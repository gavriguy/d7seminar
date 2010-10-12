<?php
// $Id: 

/**
 * Implementation of hook_profile_details().
 */
function d7seminar_profile_details() {
  return array(
    'name' => 'D7 Seminar Installation Profile',
    'description' => 'Linnovate D7 Seminar.',
  );
}


/**
 * Implementation of hook_profile_modules().
 */
function d7seminar_profile_modules() {
  $modules = array(
     // Drupal core
    'block',
    'dashboard',
    'field',
    'field_sql_storage',
    'field_ui',
    'filter',
    'help',
    'image',
    'list',
    'menu',
    'node',
    'number',
    'overlay',
    'path', 
    'taxonomy',
    'upload',
    'user',
    // Views
    'views',
    // CTools
    'ctools',
    // Context
    'context', 'context_ui', 'context_layouts',
    // Features
    'features',
    // Wysiwyg
    'wysiwyg',
  );
  return $modules;
}
/**
 * Implementation of hook_profile_task_list().
 */
function d7seminar_profile_task_list() {
  $tasks['task1'] = st('Task 1');
  $tasks['task2'] = st('Task 2');
  return $tasks;
}


/**
 * Implementation of hook_profile_tasks().
 */
function d7seminar_profile_tasks(&$task, $url) {
  global $profile, $install_locale;
  $output = '';
  if ($task == 'profile') {
    $task = 'task1';
  }
  // We are running a batch task for this profile so basically do nothing and return page
  if (in_array($task, array('task1', 'task'))) {
    include_once 'includes/batch.inc';
    $output = _batch_page();
  }
  
  //
  if ($task == 'task1') {
    $modules = _d7seminar_features_modules();
    $files = module_rebuild_cache();
    // Create batch
    foreach ($modules as $module) {
      $batch['operations'][] = array('_install_module_batch', array($module, $files[$module]->info['name']));
    }    
    $batch['finished'] = '_d7seminar_profile_batch_finished';
    $batch['title'] = st('Installing @drupal', array('@drupal' => drupal_install_profile_name()));
    $batch['error_message'] = st('The installation has encountered an error.');

    // Start a batch, switch to 'intranet-modules-batch' task. We need to
    // set the variable here, because batch_process() redirects.
    variable_set('install_task', 'task2');
    batch_set($batch);
    batch_process($url, $url);
    // Jut for cli installs. We'll never reach here on interactive installs.
    return;
  }
  return $output;
}
  
function _d7seminar_features_modules() {
  return array(
    //features
    'controller_feature'
  );
}

/**
 * Finished callback for the modules install batch.
 *
 * Advance installer task to language import.
 */
function _d7seminar_profile_batch_finished($success, $results) {
  variable_set('install_task', 'task2');
}