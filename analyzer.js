jQuery(document).ready(function ($) {
    $('#analyzeBtn').on('click', function () {
        const resume = $('#resumeInput').val();
        $('#output').text('Analyzing...');

        $.post(analyzer_ajax.ajax_url, {
            action: 'analyze_resume',
            resume: resume
        }, function (response) {
            $('#output').text(JSON.stringify(response, null, 2));
        });
    });
});
