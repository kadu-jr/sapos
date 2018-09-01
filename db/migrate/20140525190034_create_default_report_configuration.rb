# encoding utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class CreateDefaultReportConfiguration < ActiveRecord::Migration
  def up

    if ActiveRecord::Base.connection.table_exists? CarrierWave::Storage::ActiveRecord::ActiveRecordFile.table_name
      ReportConfiguration.new do |rc|
        rc.image = File.open(Rails.root.join("public/images/logoUFF.jpg").to_s)
        rc.name = "Padrão"
        rc.show_sapos = false
        rc.text = "UNIVERSIDADE FEDERAL FLUMINENSE
INSTITUTO DE COMPUTAÇÃO
PROGRAMA DE PÓS-GRADUAÇÃO EM COMPUTAÇÃO"
        rc.use_at_grades_report = true
        rc.use_at_report = true
        rc.use_at_schedule = true
        rc.use_at_transcript = true
        rc.order = 1
        rc.scale = 0.4
        rc.x = 13
        rc.y = 13
      end.save!
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists? CarrierWave::Storage::ActiveRecord::ActiveRecordFile.table_name
      rc = ReportConfiguration.find_by_name("Padrão")
      rc.destroy unless rc.nil?
    end
  end
end
