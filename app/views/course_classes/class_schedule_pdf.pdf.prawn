# encoding: utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

new_document('class_schedule.pdf', "#{I18n.t('pdf_content.course_class.class_schedule.title')} (#{@year}/#{@semester})".upcase, :page_layout => :landscape, :pdf_type => :schedule) do |pdf|

  class_schedule_table(pdf, course_classes: @course_classes)  
end

