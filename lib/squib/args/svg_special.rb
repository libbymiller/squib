require 'squib/args/arg_loader'

module Squib
  # @api private
  module Args

    class SvgSpecial
      include ArgLoader

      def self.parameters
        {
          file: nil,
          data: nil,
          id: nil,
          force_id: false,
        }
      end

      def self.expanding_parameters
        parameters.keys # all of them
      end

      def self.params_with_units
        []
      end

      def validate_id(arg, _i)
        return nil if arg.nil?
        arg = '#' << arg unless arg.start_with? '#'
        arg
      end

      # Only render if we have an ID specified, or we are forcing an ID
      def render?(i)
        return false if force_id[i] && id[i].to_s.empty?
        return true
      end

      def validate_file(arg, i)
        return nil if arg.nil?
        raise "File #{File.expand_path(arg)} does not exist!" unless File.exists?(arg)
        Squib.logger.warn 'Both an SVG file and SVG data were specified, using data' unless arg.to_s.empty? || data[i].to_s.empty?
        File.expand_path(arg)
      end

      def rsvg_handle(i)
        @data[i] = File.read(file[i]) if @data[i].to_s.empty? # read file once
        RSVG::Handle.new_from_data(svg_str)
      end

      def computed_width(widths)
        widths.map do |width|
          case width
          when :native

          else
            width
          end
        end
      end



    end

  end
end
