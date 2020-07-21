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
}
