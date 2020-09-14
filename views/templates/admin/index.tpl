<div id="opquast-panels">
    <div class="panel">
        <p class="opquast-licence">
            Les bonnes pratiques Opquast sont proposées sous licence <a
                href="https://creativecommons.org/licenses/by-sa/2.0/fr/"
                title="Creative Commons - Attribution - Partage dans les Mêmes Conditions (CC BY-SA 2.0 FR)"
                target="_blank" rel="noopener noreferrer">CC BY-SA <span class="screen-reader-text">(ce lien s'ouvre
                    dans un nouvel
                    onglet)</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>
            <br />
            Les moyens de contrôle et de mise en œuvre sous licence <a
                href="https://creativecommons.org/licenses/by-nc-sa/2.0/fr/"
                title="Creative Commons - Attribution - Pas d’Utilisation Commerciale - Partage dans les Mêmes Conditions (CC BY-NC-SA 2.0)"
                target="_blank" rel="noopener noreferrer">CC BY-NC-SA <span class="screen-reader-text">(ce lien s'ouvre
                    dans
                    un nouvel onglet)</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>
        </p>
        <p class="opquast-licence">
            <a href="https://checklists.opquast.com/fr/" target="_blank" rel="noopener noreferrer">
                En savoir plus sur les checklists Opquast
                <span class="screen-reader-text"> (s’ouvre dans un nouvel onglet)</span>
                <span aria-hidden="true" class="dashicons dashicons-external"></span>
            </a>
        </p>
    </div>
    <div class="panel">
        <h3><i class="icon-cogs"></i> {l s='Yours stats' mod='ps_quality_checklist_opquast'}</h3>
        <ul class="opquast-stats">
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-green"></span>
                Conforme : {$stats.ok}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-red"></span>
                Non conforme : {$stats.ko}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-blue"></span>
                Non applicable : {$stats.na}
            </li>
            <li>
                <span class="dashicons dashicons-yes-alt opquast-stat-grey"></span>
                Non vérifié : {$stats.nv}
            </li>

        </ul>
        <img src="{$path}/data/opquast-logo-full.png">
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
                            <option value="">Toutes les thématiques</option>
                            {foreach $themes as $k => $thematique}
                                <option value="{$k}">{$thematique}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                    <span>{l s='OR' mod='ps_quality_checklist_opquast'}</span>
                    </div>
                    <div class="form-group col-md-5">
                        <label for="opquast-filter-status">{l s='Sort by status'
                            mod='ps_quality_checklist_opquast'}</label>
                        <select id="opquast-filter-status" name="opquast-filter-status">
                            <option value="">Tous les status</option>
                            <option value="ok">Conformes</option>
                            <option value="ko">Non conformes</option>
                            <option value="na">Non applicables</option>
                            <option value="nv">Non vérifiés</option>
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
                                    <label for="input-ok-{$crit.id}">Conforme</label>

                                    <input type="radio" name="opquast-checklist-{$crit.id}" id="input-ko-{$crit.id}"
                                        value="ko" {if isset($currentCriterias[$crit.id]) &&
                                    $currentCriterias[$crit.id]
                                    == "ko"} checked {/if} />
                                    <label for="input-ko-{$crit.id}">Non conforme</label>

                                    <input type="radio" name="opquast-checklist-{$crit.id}" id="input-na-{$crit.id}"
                                        value="na" {if isset($currentCriterias[$crit.id]) &&
                                    $currentCriterias[$crit.id]
                                    == "na"} checked {/if} />
                                    <label for="input-na-{$crit.id}">Non applicable</label>
                                </fieldset>
                                <div class="content"> 
                                    <span>{{l s='Goal' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {$crit.goal_fr nofilter}
                                    </div>
                                    <span>{{l s='Solution' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {$crit.solution_fr nofilter}
                                    </div>
                                    <span>{{l s='Control' mod='ps_quality_checklist_opquast'}}</span>
                                    <div>
                                        {$crit.control_fr nofilter}
                                    </div>
                                </div>
                                <p>
                                    <a href="https://checklists.opquast.com/fr/qualiteweb/{$crit.slug_fr}" class="action" target="_blank"
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
                    <i class="process-icon-save"></i> Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>