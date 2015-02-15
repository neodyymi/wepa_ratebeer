class Style < ActiveRecord::Base
  has_many :beers

  def to_s
    self.style
  end
  def add_style(s)
    if Style.find_by style:s
      Style.find_by style:s
    else
      Style.create(style:s)
    end
  end
end
