class CreateRemoteDbs < ActiveRecord::Migration[5.1]
  def change
    create_table :remote_dbs do |t|

      t.timestamps
    end
  end
end
