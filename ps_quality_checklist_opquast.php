<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once(_PS_MODULE_DIR_.'ps_quality_checklist_opquast/classes/ChecklistUtility.php');


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
    
    public function getContent()
    {
        $themes = ChecklistUtilty::getThemesFromJSON();
        $criterias = ChecklistUtilty::getCriteriasFromJSON();
        $criteriasContent = ChecklistUtilty::getCriteriasContentFromJSON();
        $currentCriterias = ChecklistUtilty::getCurrentCriterias();

        $this->context->smarty->assign(
            array(
                'themes' => $themes,
                'criterias' => $criterias,
                'criteriasContent' => $criteriasContent,
            )
        );

        return $this->display(__FILE__, 'views/templates/admin/index.tpl');

    }
}