module Filterable
  extend ActiveSupport::Concern

  included do
    # Allow filters to be applied to seach criteria
    def self.filter(params = nil, order_by = nil, defaults = {})
      params = [] unless params
      order_by = order_by || "id"
      search_params = params[:search] || defaults
      sort = params[:sort].blank? ? order_by : params[:sort]
      direction = params[:direction] || "asc"
      direction = %w[asc desc].include?(direction) ? direction : "asc"
      page = params[:page] || "1"

      things = scoped
      search_params.each do |pk, pv|
        if pv.is_a?(Hash)
          pv.each do |pvk, pvv|
            if pvk == "exact"
              things = things.where("#{table_name}.#{pk} = ?", pvv) unless pvv.blank?
            elsif pvk == "date_after"
              things = things.where("#{table_name}.#{pk} >= ?", pvv) unless pvv.blank?
            elsif pvk == "date_before"
              things = things.where("#{table_name}.#{pk} <= ?", pvv) unless pvv.blank?
            end
          end
        else
          if pv.is_a?(String)
            things = things.where("#{table_name}.#{pk} ILIKE ?", "%#{pv}%") unless pv.blank?
          else
            things = things.where("#{table_name}.#{pk} = ?", pv) unless pv.blank?
          end
        end
      end

      sort = "lower(#{sort})" if things.columns_hash[sort] and things.columns_hash[sort].type == :string
      things.order( sort + ' ' + direction).paginate(:per_page => Settings.per_page, :page => page)
    end
  end
end