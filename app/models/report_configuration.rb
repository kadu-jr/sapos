# encoding utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class ReportConfiguration < ApplicationRecord
  has_paper_trail

  validates :text, :presence => true
  validates :order, :presence => true
  validates :x, :presence => true
  validates :y, :presence => true
  validates :scale, :presence => true

  mount_uploader :image, ImageUploader

  def initialize_dup(other)
    super
    attrib = other.attributes.except("id", "created_at", "updated_at")
    self.assign_attributes(attrib)
  end

  def mount_uploader_name
    :image
  end

end
