<div id="opquast-panels">
    <div class="panel middle">
        <h3><i class="icon-cogs"></i> {l s='Yours stats' mod='ps_quality_checklist_opquast'}</h3>
        <ul class="opquast-stats">
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-green"></span>
                {l s='Compliant' mod='ps_quality_checklist_opquast'} : {$stats.ok}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-red"></span>
                {l s='Non-compliant' mod='ps_quality_checklist_opquast'} : {$stats.ko}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-blue"></span>
                {l s='Innaplicable' mod='ps_quality_checklist_opquast'} : {$stats.na}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-grey"></span>
                {l s='Unverified' mod='ps_quality_checklist_opquast'} : {$stats.nv}
            </li>

        </ul>
    </div>

    <div class="panel middle">
        <img width="200"src="{$path}/data/opquast-logo-full.png" alt="OPQuast Logo">
        <p class="opquast-licence">
            Les bonnes pratiques Opquast sont proposées sous licence <a
                href="https://creativecommons.org/licenses/by-sa/2.0/fr/"
                title="Creative Commons - Attribution - Partage dans les Mêmes Conditions (CC BY-SA 2.0 FR)"
                target="_blank" rel="noopener noreferrer">CC BY-SA <span class="sr-only">({l s='opens in a new tab' mod='ps_quality_checklist_opquast'})</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>
            <br />
            Les moyens de contrôle et de mise en œuvre sous licence <a
                href="https://creativecommons.org/licenses/by-nc-sa/2.0/fr/"
                title="Creative Commons - Attribution - Pas d’Utilisation Commerciale - Partage dans les Mêmes Conditions (CC BY-NC-SA 2.0)"
                target="_blank" rel="noopener noreferrer">CC BY-NC-SA <span class="sr-only">({l s='opens in a new tab' mod='ps_quality_checklist_opquast'})</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>
        </p>
        <p class="opquast-licence">
            <a href="https://checklists.opquast.com/fr/" target="_blank" rel="noopener noreferrer">
                En savoir plus sur les checklists Opquast
                <span class="sr-only"> ({l s='opens in a new tab' mod='ps_quality_checklist_opquast'})</span>
                <span aria-hidden="true" class="dashicons dashicons-external"></span>
            </a>
        </p>
    </div>

    <div class="panel">
        <form id="opquast_checklist_form" action="{$actionUrl}" method="POST">
            <h3><i class="icon-cogs"></i> {l s='Opquast Quality Checklist' mod='ps_quality_checklist_opquast'}</h3>
            <div class="row">
                <div class="form-row">
                    <div class="form-group col-md-5">
                        <label for="opquast-filter-thematiques">{l s='Sort by theme'
                            mod='ps_quality_checklist_opquast'}</label>
                        <select id="opquast-filter-thematiques" name="opquast-filter-thematiques">
                            <option value="">{l s='All thematics' mod='ps_quality_checklist_opquast'}</option>
                            {foreach $themes as $k => $thematique}
                                <option value="{$k}">{$thematique}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                    <span class="or">{l s='OR' mod='ps_quality_checklist_opquast'}</span>
                    </div>
                    <div class="form-group col-md-5">
                        <label for="opquast-filter-status">{l s='Sort by status'
                            mod='ps_quality_checklist_opquast'}</label>
                        <select id="opquast-filter-status" name="opquast-filter-status">
                            <option value="">{l s='All' mod='ps_quality_checklist_opquast'}</option>
                            <option value="ok">{l s='Compliant' mod='ps_quality_checklist_opquast'}</option>
                            <option value="ko">{l s='Non-compliant' mod='ps_quality_checklist_opquast'}</option>
                            <option value="na">{l s='Innaplicable' mod='ps_quality_checklist_opquast'}</option>
                            <option value="nv">{l s='Unverified' mod='ps_quality_checklist_opquast'}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div id="accordion" class="accordion" role="tablist" aria-multiselectable="true">
                    {foreach $checklist as $crit}
                    <div class="card {$crit.sanitized_tags} {if isset($currentCriterias[$crit.id])} {$currentCriterias[$crit.id]} {else}nv{/if}">
                        <div class="card-header" role="tab" id="heading_{$crit.id}" {if $crit@first}
                            style="border-top:none;" {/if}> 
                            <p class="mb-0">
                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                                    href="#crit_{$crit.id}" aria-expanded="false" aria-controls="{$crit.description_fr}">
                                    {$crit.name_fr} - {$crit.description_fr}
                                </a>
                                <span class="status {if isset($currentCriterias[$crit.id])} {$currentCriterias[$crit.id]} {else}nv{/if}">
                                {if isset($currentCriterias[$crit.id])} 
                                    {if $currentCriterias[$crit.id] == 'ok'}
                                        {l s='Compliant' mod='ps_quality_checklist_opquast'}
                                    {elseif $currentCriterias[$crit.id] == 'ko'}
                                        {l s='Non-compliant' mod='ps_quality_checklist_opquast'}
                                    {elseif $currentCriterias[$crit.id] == 'na'}
                                        {l s='Innaplicable' mod='ps_quality_checklist_opquast'}
                                    {/if}
                                {else}
                                    {l s='Unverified' mod='ps_quality_checklist_opquast'}
                                {/if}
                                </span>
                            </p>
                        </div>
                        <div id="crit_{$crit.id}" class="collapse" role="tabpanel"
                            aria-labelledby="heading_{$crit.id}">
                            <div class="card-block">
                                <fieldset class="opquast-verification">
                                    <span>Statut :</span>
                                    <input type="radio" name="opquast-checklist-{$crit.id}" id="input-ok-{$crit.id}"
                                        value="ok" {if isset($currentCriterias[$crit.id]) &&
                                    $currentCriterias[$crit.id]
                                    == "ok"} checked {/if} />
                                    <label for="input-ok-{$crit.id}">{l s='Compliant' mod='ps_quality_checklist_opquast'}</label>

                                    <input type="radio" name="opquast-checklist-{$crit.id}" id="input-ko-{$crit.id}"
                                        value="ko" {if isset($currentCriterias[$crit.id]) &&
                                    $currentCriterias[$crit.id]
                                    == "ko"} checked {/if} />
                                    <label for="input-ko-{$crit.id}">{l s='Non-compliant' mod='ps_quality_checklist_opquast'}</label>

                                    <input type="radio" name="opquast-checklist-{$crit.id}" id="input-na-{$crit.id}"
                                        value="na" {if isset($currentCriterias[$crit.id]) &&
                                    $currentCriterias[$crit.id]
                                    == "na"} checked {/if} />
                                    <label for="input-na-{$crit.id}">{l s='Innaplicable' mod='ps_quality_checklist_opquast'}</label>
                                </fieldset>
                                <div class="content"> 
                                    <span>{{l s='Goal' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {assign var="goal" value="goal_`$iso_code`"}
                                        {$crit.$goal nofilter}
                                    </div>
                                    <span>{{l s='Solution' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {assign var="solution" value="solution_`$iso_code`"}
                                        {$crit.$solution nofilter}
                                    </div>
                                    <span>{{l s='Control' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {assign var="control" value="control_`$iso_code`"}
                                        {$crit.$control nofilter}
                                    </div>
                                </div>
                                <p>
                                    {assign var="slug" value="slug_`$iso_code`"}
                                    <a href="https://checklists.opquast.com/{$iso_code}/qualiteweb/{$crit.$slug}" class="action" target="_blank"
                                        rel="noopener noreferrer">
                                        {l s='See the detail for Opquast' mod='ps_quality_checklist_opquast'}
                                        <span class="sr-only"> ({l s='opens in a new tab'
                                            mod='ps_quality_checklist_opquast'})</span>
                                        <span aria-hidden="true" class="dashicons dashicons-external"></span>
                                    </a>
                                </p>

                                <div class="tags">
                                    {foreach from=$crit.tags item=item key=key name=name}
                                        <span>{$item}</span>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    </div>
                    {/foreach}

                </div>

            </div>
            <div class="panel-footer">
                <button type="submit" value="1" id="module_form_submit_btn" name="submitOpquastChecklist"
                    class="btn btn-default pull-right">
                    <i class="process-icon-save"></i> {l s='Save'}
                </button>
            </div>
        </form>
    </div>
</div>