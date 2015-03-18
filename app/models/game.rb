class Game < ActiveRecord::Base
  serialize :players, JSON
  serialize :state, JSON
end
