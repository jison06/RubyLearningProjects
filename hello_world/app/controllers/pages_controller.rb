# frozen_string_literal: true

# Pages controller
class PagesController < ApplicationController
  def home
    @greeting = 'Home action says: Hello world'
  end
end
