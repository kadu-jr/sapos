# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class AdvisementAuthorization < ApplicationRecord
  belongs_to :professor
  belongs_to :level

  has_paper_trail

  validates :professor, :presence => true
  validates :level, :presence => true

  def to_label
    "#{level.name}"
  end
  
end
