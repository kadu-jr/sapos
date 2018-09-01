# encoding: utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class FormTemplatesController < ApplicationController
  authorize_resource
  active_scaffold :form_template do |config|
    config.list.sorting = {:name => 'ASC'}
    config.columns = [:name, :description, :code]
    config.list.columns = [:name, :description]
    config.create.label = :create_form_template_label
    config.update.label = :update_form_template_label
    config.columns[:code].form_ui = :textarea
    config.columns[:code].options = {:cols => 124, :rows =>30}
    config.actions.exclude :deleted_records

  end
  record_select :per_page => 10,:search_on => [:name], :order_by => 'name', :full_text_search => true

end
