require 'cairo'
require 'squib/input_helpers'
require 'squib/graphics/cairo_context_wrapper'

module Squib
  # Back end graphics. Private.
  class Card

    # :nodoc:
    # @api private
    attr_reader :width, :height, :backend, :svgfile

    # :nodoc:
    # @api private
    attr_accessor :cairo_surface, :cairo_context

    # :nodoc:
    # @api private
    def initialize(deck, width, height, index=-1)
      @deck          = deck
      @width         = width
      @height        = height
      @backend       = deck.conf['backend']
      @svgfile       = "#{deck.conf['dir']}/#{deck.conf['prefix']}#{deck.conf['count_format'] % index}.svg"
      @cairo_surface = make_surface(@svgfile, @backend)
      @cairo_context = Squib::Graphics::CairoContextWrapper.new(Cairo::Context.new(@cairo_surface))
      @cairo_context.antialias = deck.conf['antialias']
    end

    # :nodoc:
    # @api private
    def make_surface(svgfile, backend)
      case backend.downcase.to_sym
      when :memory
        Cairo::ImageSurface.new(@width, @height)
      when :svg
        Dir.mkdir @deck.conf['dir'] unless Dir.exists?(@deck.conf['dir'])
        Cairo::SVGSurface.new(svgfile, @width, @height)
      else
        Squib.logger.fatal "Back end not recognized: '#{backend}'"
        abort
      end
    end


  # A save/restore wrapper for using Cairo
  # :nodoc:
  # @api private
    def use_cairo(&block)
      @cairo_context.save
      block.yield(@cairo_context)
      @cairo_context.restore
    end

    ########################
    ### BACKEND GRAPHICS ###
    ########################
    require 'squib/graphics/background'
    require 'squib/graphics/image'
    require 'squib/graphics/save_doc'
    require 'squib/graphics/save_images'
    require 'squib/graphics/shapes'
    require 'squib/graphics/showcase'
    require 'squib/graphics/text'

  end
end
