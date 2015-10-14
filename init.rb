require 'redmine'
require_dependency 'project_state/hooks'
require_dependency 'project_state/patches'
require_dependency 'project_state/initialization'

Redmine::Plugin.register :project_state do
  name 'Project State plugin'
  author 'Gord Brown'
  description 'Track project states, notify if/when various conditions occur'
  version '1.1.1'
  url 'https://github.com/crukci-bioinformatics/process_tracker_plugin'
  author_url 'http://gdbrown.org/blog/'

  settings(:default => { 'root_projects' => 'Research Groups',
                         'alert_logins' => 'brown22',
                         'filter_trackers' => 'Class I - Statistics',
                         'filter_projects' => 'External; Genomics; Proteomics; Other Core Facilities',
                         'filter_keepers' => 'Class I - Analysis',
                         'ignore_trackers' => 'Bug; Feature; Support; Other'},
           :partial => 'settings/project_state_settings' )

  menu :top_menu, :states, { controller: 'project_state/summary', action: 'index' }, caption: :project_state_caption, before: :help

end

Rails.configuration.after_initialize do
  Issue.send(:include,ProjectStatePlugin::IssuePatch)
  Project.send(:include,ProjectStatePlugin::ProjectPatch)
  CustomValue.send(:include,ProjectStatePlugin::CustomValuePatch)
  Journal.send(:include,ProjectStatePlugin::JournalPatch)
  # the following steps are necessary in case the "root_projects" variable
  # has been altered... may need to add new projects to the custom fields,
  # and if so, add default CustomField values to issues
  initr = ProjectStatePlugin::Initializer.new
  initr.ensure_custom_fields # ensure custom fields are present (should only need to be created once)
  projSet = initr.ensure_projects_have_custom_fields
  initr.ensure_issues_have_custom_fields(projSet)
end
