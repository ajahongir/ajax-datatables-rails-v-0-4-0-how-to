class CityDatatable < AjaxDatatablesRails::Base

  def view_columns
    @view_columns ||= {
      id: { source: "City.id", cond: :eq },
      name: { source: "City.name" },
      timezone: { source: "City.timezone" },
      iata: { source: "City.iata" },
      country_name: { source: "City.country_id", cond: :eq }
    }
  end

  private
  def data
    records.map do |city|
      {
        id: city.id,
        name: city.name,
        iata: city.iata,
        timezone: city.timezone,
        country_name: city.country.try(:name),
      }
    end
  end

  def get_raw_records
    City.includes(:country)
  end
end
