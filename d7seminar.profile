<?php
// $Id: 

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function d7seminar_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
}


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
