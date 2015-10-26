require 'squib/args/arg_loader'

module Squib
  # @api private
  module Args

    class Transform
      include ArgLoader

      def self.parameters
        { angle: 0,
          crop_x: 0,
          crop_y: 0,
          crop_corner_radius: 0,
          crop_width: :native,
          crop_height: :native,
        }
      end

      def self.expanding_parameters
        parameters.keys # all of them
      end

      def self.params_with_units
        parameters.keys # all of them
      end

    end

  end
end