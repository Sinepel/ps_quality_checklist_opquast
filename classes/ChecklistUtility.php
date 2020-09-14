<?php

class ChecklistUtilty
{
    const OPQUAST_THEMATHIQUES = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr-thematiques.json';
    // const OPQUAST_CONTENT = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr-content.json';
    // const OPQUAST_CHECKLIST = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr.json';
    const OPQUAST = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/CHECKLIST-OPQUAST-2020.json';

    public static function getOPQuastChecklist() 
    {
        $get_json = file_get_contents(self::OPQUAST);
        $get_json = json_decode($get_json);
        // $thema = [];

        $get_json = get_object_vars($get_json);
        foreach ($get_json as &$criteria) {
            // dump($criteria->thema);die;
            $sanitized_tags_array =  $criteria->thema;
            // $thema = array_unique(array_merge($thema, $sanitized_tags_array));
            $sanitized_tags_array = array_map(  array('Tools','link_rewrite') , $sanitized_tags_array);
            $criteria->sanitized_tags = implode(' ', $sanitized_tags_array);
            $criteria = get_object_vars($criteria);
        }
        uasort($get_json, function($a, $b) {
            return (int)$a['name_fr'] > (int)$b['name_fr'];
        });
        // echo json_encode($thema);die;
        
        return $get_json;
    }

    public static function getThemesFromJSON()
    {
        $themes = [];
        $get_json = file_get_contents(self::OPQUAST_THEMATHIQUES);
        $get_json = json_decode($get_json);

        foreach ($get_json as $theme) {
            $themes[Tools::link_rewrite($theme)] = $theme;
        }

        return $themes;
    }

    public static function getCurrentCriterias()
    {
        return unserialize(Configuration::get('PSOPQUASTCURRENT'));
    }

    public static function getStats()
    {
        return [
            'ok' => self::getStatsByStatus('ok'),
            'ko' => self::getStatsByStatus('ko'),
            'na' => self::getStatsByStatus('na'),
            'nv' => self::getStatsByStatus('nv'),
        ];
    }

    public static function getStatsByStatus( $status = '' ) {
        if ( empty( $status ) ) {
                return;
        }
        $criteria = self::getOPQuastChecklist(); 
       
        $existing_criteria = array();
        $existing_criteria = self::getCurrentCriterias();
       
        $corresponding_criteria = array();
        if ( $status === 'nv' ) {
                return count( $criteria ) - count( $existing_criteria );               
        } else {
                foreach ( $existing_criteria as $key => $value ) {
                        if ( $value === $status ) {
                                $corresponding_criteria[] = $key;
                        }
                }
                return count( $corresponding_criteria );
        }
}
}
