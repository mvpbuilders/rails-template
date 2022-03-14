# frozen_string_literal: true

class PagesController < ApplicationController
  # rubocop:todo Layout/SpaceInsideArrayLiteralBrackets
  skip_before_action :authenticate_user!, only: [:home]
  # rubocop:enable Layout/SpaceInsideArrayLiteralBrackets

  def home; end
end
