# frozen_string_literal: true

class Organisms::BannerComponent < ViewComponent::Base
  attr_accessor :background_svg, :background_color, :classes, :first_column_classes,
                :second_column_classes, :padding
  with_content_areas :first_column, :second_column, :conditional_div

  def initialize(background_svg: 60, classes:, background_color: "#F5F9FE",
    first_column_classes:, second_column_classes:, padding: "p-3")
    @background_svg = background_svg
    @classes = classes
    @background_color = background_color
    @first_column_classes = first_column_classes
    @second_column_classes = second_column_classes
    @padding = padding
  end
end
