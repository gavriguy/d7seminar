<?php

/**
 * Implementation of hook_node_info().
 */
function controller_feature_node_info() {
  $items = array(
    'seminar' => array(
      'name' => t('seminar'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  return $items;
}
