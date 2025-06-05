<?php
/**
 * Plugin Name: AI Resume Analyzer
 * Description: Analyzes resumes using AI and provides ATS optimization tips.
 * Version: 1.0
 * Author: Soham Gurav
 */

add_action('admin_menu', 'resume_analyzer_menu');
function resume_analyzer_menu() {
    add_menu_page('Resume Analyzer', 'Resume Analyzer', 'manage_options', 'resume-analyzer', 'resume_analyzer_page');
}

function resume_analyzer_page() {
    echo '<div class="wrap">';
    echo '<h1>Resume Analyzer</h1>';
    include plugin_dir_path(__FILE__) . 'templates/form-template.php';
    echo '</div>';
}

add_action('admin_enqueue_scripts', 'resume_analyzer_scripts');
function resume_analyzer_scripts() {
    wp_enqueue_style('resume-style', plugin_dir_url(__FILE__) . 'css/style.css');
    wp_enqueue_script('resume-script', plugin_dir_url(__FILE__) . 'js/analyzer.js', ['jquery'], null, true);
    wp_localize_script('resume-script', 'analyzer_ajax', [
        'ajax_url' => admin_url('admin-ajax.php')
    ]);
}

add_action('wp_ajax_analyze_resume', 'analyze_resume_callback');
function analyze_resume_callback() {
    $resume_text = sanitize_text_field($_POST['resume']);
    $response = wp_remote_post('http://127.0.0.1:5000/analyze', [
        'body' => json_encode(['resume' => $resume_text]),
        'headers' => ['Content-Type' => 'application/json'],
    ]);

    wp_send_json(json_decode(wp_remote_retrieve_body($response)));
}
?>
