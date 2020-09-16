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

if (!defined('_PS_VERSION_')) {
    exit;
}

use Exception;

require_once dirname(__FILE__) . '/classes/ChecklistUtility.php';

/**
 * @author Constantin Boulanger
 */
class Ps_Quality_Checklist_Opquast extends Module
{

    public function __construct()
    {
        $this->name = 'ps_quality_checklist_opquast';
        $this->tab = 'front_office_features';
        $this->version = '1.0.1';
        $this->author = '<a href="https://constantin-boulanger.fr" target="_blank">Constantin Boulanger</a>';
        $this->need_instance = 0;
        $this->bootstrap = true;


        parent::__construct();

        $this->displayName = $this->l('Prestashop Quality Checklist Opquast');
        $this->description = $this->l('Checklist qualité web Opquast pour Prestashop');

        $this->ps_versions_compliancy = ['min' => '1.6', 'max' => _PS_VERSION_];
    }

    /**
     * {@inheritDoc}
     */
    public function install()
    {
        if (version_compare(PHP_VERSION, '5.4.0', '<')) {
            throw new Exception($this->l('Ce module nécessite PHP 5.4 ou supérieur.'));
        }

        if (!Configuration::hasKey('PSOPQUASTCURRENT')) {
            Configuration::updateValue('PSOPQUASTCURRENT', serialize([]));
        }

        return parent::install();
    }

    /**
     * {@inheritDoc}
     */
    public function postProcess()
    {
        if (method_exists('Tools','getAllValues')) {
            $values = Tools::getAllValues();
        } else {
            $values = $_GET + $_POST;
        }
        
        $opquastResponses = array_filter($values, function ($value) {
            return false !== strpos($value, 'opquast-checklist-');
        }, ARRAY_FILTER_USE_KEY);

        if (empty($opquastResponses)) {
            return false;
        }

        $toSave = [];
        foreach ($opquastResponses as $index => $response) {
            $id = explode('-', $index)[2];
            $toSave[$id] = $response;
        }

        return Configuration::updateValue('PSOPQUASTCURRENT', serialize($toSave));
    }

    /**
     * {@inheritDoc}
     */
    public function getContent()
    {
        $html = '';

        if (Tools::isSubmit('submitOpquastChecklist')) {
            if ($this->postProcess()) {
                $html .= $this->displayConfirmation($this->l('Settings saved'));
            } else {
                $html .= $this->displayError($this->l('An error has occurred. Please try again'));
            }
        }
        $this->context->controller->addJS($this->_path . 'views/js/admin.js');
        $this->context->controller->addCSS($this->_path . 'views/css/admin.css');

        $iso_code = 'fr';
        if ($this->context->language->iso_code !== 'fr') {
            $iso_code = 'en';
        }

        $checklist = ChecklistUtility::getOPQuastChecklist();
        $themes = ChecklistUtility::getThemesFromJSON();
        $currentCriterion = ChecklistUtility::getCurrentCriterion();
        $stats = ChecklistUtility::getStats();
        
        $this->context->smarty->assign(
            [
                'iso_code' => $iso_code,
                'themes' => $themes,
                'checklist' => $checklist,
                'currentCriterion' => $currentCriterion,
                'path' => $this->_path,
                'stats' => $stats,
                'actionUrl' => $this->context->link->getAdminLink('AdminModules', false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name . '&token=' . Tools::getAdminTokenLite('AdminModules'),
            ]
        );

        return $html . $this->display(__FILE__, 'views/templates/admin/index.tpl');
    }
}
