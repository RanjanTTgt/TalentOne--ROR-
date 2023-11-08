class User < ApplicationRecord
  has_paper_trail #make versions of any event

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  validates_presence_of :first_name
  enum role: %i[employee manager super_admin hr], _default: "employee"
  enum status: %i[active inactive terminated], _default: "active"
  mount_uploader :profile_picture, ImageUploader

  has_many :users_projects, dependent: :destroy
  has_many :daily_statuses, dependent: :destroy
  has_many :weekly_statuses, dependent: :destroy
  has_many :attendance_reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :projects, through: :users_projects
  belongs_to :department
  belongs_to :designation

  def full_name
    [first_name, last_name].join(" ").strip
  end

  def start_working
    self.attendance_reports.today_attendances.last
  end

  def self.upcoming_birthdays(limit = 5)
    start_month = Date.today.month
    start_day = Date.today.day
    end_month = 12
    end_day = 31
    users = User.where("(DATE_PART('month', dob) >= ? AND DATE_PART('day', dob) >= ?) AND (DATE_PART('month', dob) <= ? AND DATE_PART('day', dob) <= ?)", start_month, start_day, end_month, end_day).limit(limit)
    users_data = users.order(Arel.sql("DATE_PART('month', dob), DATE_PART('day', dob)"))
    return users_data if users_data.count == limit
    start_month = 1
    start_day = 1
    end_month = (Date.today - 1.month).month
    end_day = (Date.today - 1.month).end_of_month.day
    if end_month != 12
      users = User.where("(DATE_PART('month', dob) >= ? AND DATE_PART('day', dob) >= ?) AND (DATE_PART('month', dob) <= ? AND DATE_PART('day', dob) <= ?)", start_month, start_day, end_month, end_day).limit(limit - users_data.count)
      users_data += users.order(Arel.sql("DATE_PART('month', dob), DATE_PART('day', dob)"))
      return users_data if users_data.count == limit
    end
    start_month = 1
    start_day = end_month
    end_month = Date.today.month
    end_day = Date.today.day - 1
    users = User.where("(DATE_PART('month', dob) >= ? AND DATE_PART('day', dob) >= ?) AND (DATE_PART('month', dob) <= ? AND DATE_PART('day', dob) <= ?)", start_month, start_day, end_month, end_day).limit(limit - users_data.count)
    users_data = users_data + users.order(Arel.sql("DATE_PART('month', dob), DATE_PART('day', dob)"))
    users_data.uniq
  end

end
