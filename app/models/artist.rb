class Artist < ApplicationRecord
  has_many :album, dependent: :destroy
  validates :name, presence: true
  validates :birth_date, comparison: { less_than: Time.zone.today,
                                       messages: "can't be in the future" }
  # Custom Validate
  validate :death_date_is_valid
  validate :death_date_is_after_birth_date

  private

  def death_date_is_valid
    errors.add(:birth_date, "must exist when death date is present") if !death_date.nil? && birth_day.blank?
  end

  def death_date_is_after_birth_date
    errors.add(:death_date, "must be after birth date") if !death_date.nil? && death_date < birth_date
  end
end
