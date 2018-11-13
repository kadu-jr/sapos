# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class CreateNotificationLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_logs do |t|
      t.references :notification

      t.timestamps
    end
  end
end
