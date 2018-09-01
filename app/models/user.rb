# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class User < ApplicationRecord

  
  belongs_to :role

  has_paper_trail

  devise :database_authenticatable, :recoverable, :rememberable, :registerable, :trackable, :confirmable,
         :lockable

  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  validate :role_valid?
  validates :role, :presence => true
  
  before_destroy :validate_destroy

  def to_label
    "#{self.name}"
  end

  def valid_password?(password)
    if self.hashed_password.present?
      if User.encrypt_password(password, self.salt) == self.hashed_password
        self.password = password
        self.password_confirmation = password
        self.hashed_password = nil
        self.save!
        true
      else
        false
      end
    else
      super
    end
  end

  def role_valid?
    return if current_user.nil?
    return if role.nil?
    if Role::ORDER.index(current_user.role.id) < Role::ORDER.index(self.role_id_was)
      errors.add(:role, I18n.translate("activerecord.errors.models.user.invalid_role_was")) 
    end
    if Role::ORDER.index(current_user.role.id) < Role::ORDER.index(role.id)
      errors.add(:role, I18n.translate("activerecord.errors.models.user.invalid_role")) 
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def reset_password!(*args)
    self.hashed_password = nil
    super
  end

  #Application need a user to log in
  def validate_destroy
    errors.add(:base, I18n.t("activerecord.errors.models.user.delete")) if User.count == 1
    unless current_user.nil?
      errors.add(:base, I18n.t("activerecord.errors.models.user.invalid_role_full")) if Role::ORDER.index(current_user.role.id) < Role::ORDER.index(self.role.id) 
      errors.add(:base, I18n.t("activerecord.errors.models.user.self_delete")) if current_user.id == self.id
    end
    errors.blank?
  end

end
