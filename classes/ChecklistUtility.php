<?php

class ChecklistUtilty
{
    const OPQUAST_THEMATHIQUES = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr-thematiques.json';
    const OPQUAST_CONTENT = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr-content.json';
    const OPQUAST_CHECKLIST = _PS_MODULE_DIR_ . '/ps_quality_checklist_opquast/data/data-fr.json';

    public static function getCriteriasFromJSON()
    {
        $get_json = file_get_contents(self::OPQUAST_CHECKLIST);
        $get_json = json_decode($get_json);
        foreach ($get_json as $criteria) {
            $sanitized_tags_array = explode(',', $criteria->tags);
            $sanitized_tags_array = array_map(  array('Tools','link_rewrite') , $sanitized_tags_array);
            $criteria->sanitized_tags = implode(' ', $sanitized_tags_array);
        }
        return $get_json;
    }
    public static function getCriteriasContentFromJSON()
    {
        $get_json = file_get_contents(self::OPQUAST_CONTENT);
        return json_decode($get_json);
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
        $criteria = self::getCriteriasFromJSON(); 
       
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
