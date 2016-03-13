class CityDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      id: { source: "City.id", cond: :eq },
      name: { source: "City.name" },
      custom_column: { source: "custom_column", cond: filter_custom_column_condition },
      iata: { source: "City.iata" },
      country_name: { source: "City.country_id", cond: filter_country_condition },
    }
  end

  private
  def data
    records.map do |city|
      {
        id: city.id,
        name: city.name,
        iata: city.iata,
        country_name: city.country.try(:name),
        custom_column: city[:custom_column]
      }
    end
  end

  def get_raw_records
    City.select('cities.*, timezone AS custom_column').includes(:country)
  end

  def filter_country_condition
    ->(column) { column.table[column.field].eq(column.search.value.to_i + 1) }
  end

  def filter_custom_column_condition
    ->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
  end
end