<script>
$(function() {
       $('#opquast-filter-thematiques').on('change', function () {
        var selected_status_slug = $(this).val();
        var selected_status_title = $(this).children('option:selected').text();
        console.log(selected_status_slug, selected_status_title);
        var count = 0;
        $('.card').each(function () {
            $(this).removeClass('hidden');
            //$(this).next().attr('hidden', 'hidden');
            if (!$(this).hasClass(selected_status_slug) && selected_status_slug !== '') {
                $(this).addClass('hidden');
            } else {
                count++;
            }
        });
        /* $('#health-check-issues-general-title > .issue-count').text(count);
        if (selected_status_slug === '') {
            $('#health-check-issues-general-title > .issue-type').text('au total');
        } else {
            $('#health-check-issues-general-title > .issue-type').text('avec le statut : « ' +
                selected_status_title + ' »');
        }
        $('#opquast-filter-thematiques > option[value=""]').prop('selected', true); */
    }); 
});
</script>
<div class="panel">
    <h3><i class="icon-cogs"></i> {l s='Yours stats' mod='ps_quality_checklist_opquast'}</h3>
    Soon !
</div>

<div class="panel">
    <h3><i class="icon-cogs"></i> {l s='Opquast Quality Checklist' mod='ps_quality_checklist_opquast'}</h3>

    <div class="row">
        <select id="opquast-filter-thematiques">
            <option value="">Toutes les thématiques</option>
            {foreach $themes as $k => $thematique}
            <option value="{$k}">{$thematique}</option>
            {/foreach}
        </select>
    </div>
    <div class="row">
        <div id="accordion" role="tablist" aria-multiselectable="true">
            {foreach $criterias as $crit}
            <div class="card {$crit->sanitized_tags}">
                <div class="card-header" role="tab" id="heading_{$crit->id}">
                    <h5 class="mb-0">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#crit_{$crit->id}"
                            aria-expanded="false" aria-controls="{$crit->title}">
                            {$crit->id}. {$crit->title}
                        </a>
                    </h5>
                </div>
                <div id="crit_{$crit->id}" class="collapse" role="tabpanel" aria-labelledby="heading_{$crit->id}">
                    <div class="card-block">
                        {$criteriasContent->{$crit->id} nofilter}
                    </div>
                </div>
            </div>
            {/foreach}
        </div>

    </div>