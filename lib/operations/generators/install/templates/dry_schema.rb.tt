# frozen_string_literal: true

require "dry/schema"

# Could be acheived with:

# Dry::Schema.load_extensions(:info)

# UserSchema.info.keys

# NOTE: The info data structure is not stable yet and may change before 2.0.0 depending on the user feedback. ^

module ExtractKeysFromSchema
  def key_list
    key_map.keys.map { |key| key.name.to_sym }
  end
end

Dry::Schema.Params.class.include(ExtractKeysFromSchema)
