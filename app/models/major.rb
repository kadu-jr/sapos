# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class Major < ApplicationRecord
  belongs_to :level
  belongs_to :institution
  has_many :student_majors, :dependent => :destroy
  has_many :students, :through => :student_majors

  has_paper_trail

  validates :name, :presence => true
  validates :institution, :presence => true
  validates :level, :presence => true

  def to_label
    "#{name} - #{institution.name} - (#{level.name})"
  end
end
