defmodule WorldJobs.Geolocation do
  @europe %{
    name: :Europe,
    polygon: %{
      type: "Polygon",
      coordinates: [
        [
          {90, -10},
          {90, 77.5},
          {42.5, 48.8},
          {42.5, 30},
          {40.79, 28.81},
          {41, 29},
          {40.55, 27.31},
          {40.40, 26.75},
          {40.05, 26.36},
          {39.17, 25.19},
          {35.46, 27.91},
          {33, 27.5},
          {38, 10},
          {35.42, -10},
          {28.25, -13},
          {15, -30},
          {57.5, -37.5},
          {78.13, -10}
        ]
      ]
    }
  }
  @north_america %{
    name: :"North America",
    polygon: %{
      type: "Polygon",
      coordinates: [
        [
          {90, -168.75},
          {90, -10},
          {78.13, -10},
          {57.5, -37.5},
          {15, -30},
          {15, -75},
          {1.25, -82.5},
          {17.14, -171.21},
          {51, -180},
          {60, -180},
          {60, -168.75}
        ]
      ]
    }
  }
  @asia %{
    name: :Asia,
    polygon: %{
      type: "Polygon",
      coordinates: [
        [
          {90, 77.5},
          {42.5, 48.8},
          {42.5, 30},
          {40.79, 28.81},
          {41, 29},
          {40.55, 27.31},
          {40.4, 26.75},
          {40.05, 26.36},
          {39.17, 25.19},
          {35.46, 27.91},
          {33, 27.5},
          {31.74, 34.58},
          {29.54, 34.92},
          {27.78, 34.46},
          {11.3, 44.3},
          {12.5, 52},
          {-60, 75},
          {-60, 110},
          {-31.88, 110},
          {-11.88, 110},
          {-10.27, 140},
          {33.13, 140},
          {51, 166.6},
          {60, 180},
          {90, 180}
        ]
      ]
    }
  }
  @africa %{
    name: :Africa,
    polygon: %{
      type: "Polygon",
      coordinates: [
        [
          {15, -30},
          {28.25, -13},
          {35.42, -10},
          {38, 10},
          {33, 27.5},
          {31.74, 34.58},
          {29.54, 34.92},
          {27.78, 34.46},
          {11.3, 44.3},
          {12.5, 52},
          {-60, 75},
          {-60, -30}
        ]
      ]
    }
  }
  @south_america %{
    name: :"South America",
    polygon: %{
      type: "Polygon",
      coordinates: [[{1.25, -105}, {1.25, -82.5}, {15, -75}, {15, -30}, {-60, -30}, {-60, -105}]]
    }
  }
  @oceania %{
    name: :Oceania,
    polygon: %{
      type: "Polygon",
      coordinates: [
        [
          {-11.88, 110},
          {-10.27, 140},
          {-10, 145},
          {-43.89, 193.18},
          {-52.5, 142.5},
          {-31.88, 110}
        ]
      ]
    }
  }
  @antarctica %{
    name: :Antarctica,
    polygon: %{type: "Polygon", coordinates: [[{-60, -180}, {-60, 180}, {-90, 180}, {-90, -180}]]}
  }
  @continents [@asia, @africa, @europe, @north_america, @south_america, @oceania, @antarctica]

  def get_continent(coordinates),
    do: Enum.find_value(@continents, &(Topo.contains?(&1.polygon, coordinates) && &1.name))
end
