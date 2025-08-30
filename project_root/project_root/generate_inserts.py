import json

# Replace with your GeoJSON filename
GEOJSON_FILE = "chemnitz.geojson"
OUTPUT_SQL_FILE = "insert_sites.sql"

def escape_sql_string(s):
    """Escape single quotes for SQL strings."""
    if s is None:
        return ""
    return s.replace("'", "''")

def main():
    with open(GEOJSON_FILE, "r", encoding="utf-8") as f:
        geojson = json.load(f)

    insert_statements = []

    for feature in geojson.get("features", []):
        props = feature.get("properties", {})
        geometry = feature.get("geometry", {})

        name = escape_sql_string(props.get("name", ""))
        tourism = escape_sql_string(props.get("tourism", ""))
        amenity = escape_sql_string(props.get("amenity", ""))
        website = escape_sql_string(props.get("website", ""))

        coordinates = geometry.get("coordinates", [])
        lon = coordinates[0] if len(coordinates) > 0 else None
        lat = coordinates[1] if len(coordinates) > 1 else None

        # Handle NULL values for lat/lon and website
        lat_str = str(lat) if lat is not None else "NULL"
        lon_str = str(lon) if lon is not None else "NULL"
        website_str = f"'{website}'" if website else "NULL"

        sql = f"INSERT INTO sites (name, tourism, amenity, lat, lon, website) VALUES (" \
              f"'{name}', '{tourism}', '{amenity}', {lat_str}, {lon_str}, {website_str});"

        insert_statements.append(sql)

    with open(OUTPUT_SQL_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(insert_statements))

    print(f"Generated {len(insert_statements)} insert statements in '{OUTPUT_SQL_FILE}'.")

if __name__ == "__main__":
    main()
