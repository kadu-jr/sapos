# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class StudentMajorsController < ApplicationController
  authorize_resource

  active_scaffold :student_major do |config|
    columns = [:student, :major]

    config.list.columns = columns
    config.create.columns = columns
    config.update.columns = columns
    config.show.columns = columns

    config.columns[:student].form_ui = :record_select
    config.columns[:major].form_ui = :record_select

    config.actions.exclude :deleted_records
  end

  record_select
end
