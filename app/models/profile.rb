class Profile < ActiveRecord::Base
  	belongs_to :user
  	validate :first_last_name_both_nil
	validate :prevent_sue
	def first_last_name_both_nil
		if (first_name == nil)&&(last_name == nil)
			errors.add(:first_name,"cannot both be null")
		end
  	end
  	validates :gender, inclusion: {in: %w(male female),message:"%{value} is not a valid gender!" }
	def prevent_sue
		if (gender == "male")&&(first_name == "Sue")
			errors.add(:gender, "gender error")
		end
	end
	def self.get_all_profiles(min,max)
		Profile.where("birth_year BETWEEN :min_year AND :max_year",min_year: min,max_year: max).order(birth_year: :asc)
	end
		
end
