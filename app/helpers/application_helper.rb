module ApplicationHelper

	def sortable_filters(columns, filters)
    render partial: 'includes/sortable_filters', locals: {columns: columns, filters: filters}
	end

	def filter_default(k, v, defaults = {})
	  if v and v[:input_type] == :settings_select
    	defaults.dig(k) ? defaults.dig(k, "exact") : ''
    elsif v and v[:input_type] == :relation_select
      defaults.dig(k) ? defaults.dig(k).id : ''
    elsif v and v[:input_type] == :date_before
      defaults.dig(v[:field].to_s, "date_before") ? l(defaults.dig(v[:field].to_s, "date_before"), format: :short_date) : ''
    elsif v and v[:input_type] == :date_after
      defaults.dig(v[:field].to_s, "date_after") ? l(defaults.dig(v[:field].to_s, "date_after"), format: :short_date) : ''
    else
      defaults[k]
    end
  end
end