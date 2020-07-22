$(function () {
    $('select[id^=opquast-filter-]').on('change', function () {
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

        if ($(this).attr('id') === 'opquast-filter-thematiques') {
            $('#opquast-filter-status > option[value=""]').prop('selected', true);
        } else if ($(this).attr('id') === 'opquast-filter-status') {
            $('#opquast-filter-thematiques > option[value=""]').prop('selected', true);
        }

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