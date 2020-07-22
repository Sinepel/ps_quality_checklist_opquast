<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once(_PS_MODULE_DIR_ . 'ps_quality_checklist_opquast/classes/ChecklistUtility.php');


class Ps_Quality_Checklist_Opquast extends Module
{

    public function __construct()
    {
        $this->name = 'ps_quality_checklist_opquast';
        $this->tab = 'front_office_features';
        $this->version = 1.0;
        $this->author = '<a href="https://constantin-boulanger.fr" target="_blank">Constantin Boulanger</a>';
        $this->need_instance = 0;
        $this->bootstrap = true;


        parent::__construct();

        $this->displayName = $this->l('Prestashop Quality Checklist Opquast');
        $this->description = $this->l('Checklist qualité web Opquast pour Prestashop');
    }

    public function install()
    {
        if (!Configuration::hasKey('PSOPQUASTCURRENT')) {
            Configuration::updateValue('PSOPQUASTCURRENT', serialize([]));
        }

        return parent::install();
    }

    public function postProcess()
    {
        $opquastResponses = array_filter(Tools::getAllValues(), function ($e) {
            return false !== strpos($e, 'opquast-checklist-');
        }, ARRAY_FILTER_USE_KEY);

        if (empty($opquastResponses)) {
            return false;
        }

        $toSave = [];
        foreach ($opquastResponses as $index => $response) {
            $id = explode('-', $index)[2];
            $toSave[$id] = $response;
        }

        Configuration::updateValue('PSOPQUASTCURRENT', serialize($toSave));
    }

    public function getContent()
    {
        if (Tools::isSubmit('submitOpquastChecklist')) {
            $this->postProcess();
        }
        $this->context->controller->addJS($this->_path . 'views/js/admin.js');
        $this->context->controller->addCSS($this->_path . 'views/css/admin.css');


        $themes = ChecklistUtilty::getThemesFromJSON();
        $criterias = ChecklistUtilty::getCriteriasFromJSON();
        $criteriasContent = ChecklistUtilty::getCriteriasContentFromJSON();
        $currentCriterias = ChecklistUtilty::getCurrentCriterias();
        $stats = ChecklistUtilty::getStats();
        
        $this->context->smarty->assign(
            array(
                'themes' => $themes,
                'criterias' => $criterias,
                'criteriasContent' => $criteriasContent,
                'currentCriterias' => $currentCriterias,
                'path' => $this->_path,
                'stats' => $stats,
                'actionUrl' => $this->context->link->getAdminLink('AdminModules', false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name . '&token=' . Tools::getAdminTokenLite('AdminModules'),
            )
        );

        return $this->display(__FILE__, 'views/templates/admin/index.tpl');
    }
}
