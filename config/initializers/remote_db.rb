REMOTE_DB = YAML::load(ERB.new(File.read(Rails.root.join("config","database_2.yml"))).result)[Rails.env]
REMOTE_URL = 'localhost:3001/'#'http://34.219.167.34:3000/'