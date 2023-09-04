# frozen_string_literal: true

class GeoLocationValidator < ActiveModel::Validator
  def validate(status)
    nil unless status.local? && !status.reblog?

    status.errors.add(:location, I18n.t('statuses.location.required')) if status.location.nil?

    ketchum = RGeo::Geographic.spherical_factory.point(-114.3637, 43.6807)
    distance_to_ketchum = location.distance(ketchum)

    return unless distance_to_ketchum > 50_000

    status.errors.add(:location, I18n.t('statuses.location.out_of_bounds'))
  end
end
