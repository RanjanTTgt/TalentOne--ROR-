class StatusReport < ApplicationRecord
  serialize :to_ids, Array
  serialize :cc_ids, Array
  enum report_type: [:daily, :weekly], _default: "daily"
  enum status: [:draft_save, :post],   _default: "draft_save"
  validate :validate_status_value, if: :status_changed?
  after_save :send_mail, if: :status_changed?
  before_save :convert_to_integer
  validates_presence_of :to_ids

  scope :received, -> (id) {where("to_ids like '%- #{id}\n%' or cc_ids like '%- #{id}\n%'")}
  # scope :search_record, -> (content) {where("like or cc_ids like '%- #{id}\n%'")}

  scope :today, -> {where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)}

  private

  def convert_to_integer
    self.to_ids = self.to_ids.map(&:to_i).uniq if to_ids_changed?
    self.cc_ids = self.cc_ids.map(&:to_i).uniq if to_ids_changed?
  end

  def validate_status_value
    if self.status && self.status_was == "post"
      self.errors.add(:status, "can be changed is after post.")
    end
  end

  def send_mail
    if self.status == "post"
      puts "send---mail---->---#{self.sends_to}"
    end
  end

end
