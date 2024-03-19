class ForecastController < ApplicationController
    def index
    end

    def search
        @address = params[:address]
        puts "*** searched for #{@address}"
        render 'search'
    end
end
