<?php

/**
 * 2020-present Friends of Presta community
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the MIT License
 * that is bundled with this package in the file LICENSE
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/MIT
 *
 * @author Friends of Presta community
 * @copyright 2019-present Friends of Presta community
 * @license https://opensource.org/licenses/MIT MIT
 */

class ChecklistUtility
{
    const OPQUAST_THEMATICS = __DIR__ . '/../data/data-fr-thematics.json';
    const OPQUAST = __DIR__ . '/../data/checklist-opquast-v4.json';

    public static function getOPQuastChecklist() 
    {
        $get_json = file_get_contents(self::OPQUAST);
        $get_json = json_decode($get_json);

        $get_json = get_object_vars($get_json);
        foreach ($get_json as &$criteria) {
            $sanitized_tags_array =  $criteria->thema;
            $sanitized_tags_array = array_map(['Tools','link_rewrite'] , $sanitized_tags_array);
            $criteria->sanitized_tags = implode(' ', $sanitized_tags_array);
            $criteria = get_object_vars($criteria);
        }
        uasort($get_json, function($a, $b) {
            return (int) $a['name_fr'] > (int) $b['name_fr'];
        });
        
        return $get_json;
    }

    public static function getThemesFromJSON()
    {
        $themes = [];
        $get_json = file_get_contents(self::OPQUAST_THEMATICS);
        $get_json = json_decode($get_json);

        foreach ($get_json as $theme) {
            $themes[Tools::link_rewrite($theme)] = $theme;
        }

        return $themes;
    }

    public static function getCurrentCriterion()
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

    public static function getStatsByStatus($status = '')
    {
        if (empty($status)) {
                return;
        }

        $criteria = self::getOPQuastChecklist();
        $existing_criteria = self::getCurrentCriterion();
       
        $corresponding_criteria = [];
        if ($status === 'nv') {
                return count( $criteria ) - count( $existing_criteria );               
        }

        foreach ($existing_criteria as $key => $value) {
                if ($value === $status) {
                        $corresponding_criteria[] = $key;
                }
        }

        return count($corresponding_criteria);
    }
}
