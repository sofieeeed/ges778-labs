# Tables


This will be a very quick lab where you just practice formatting your
data and making a table of it. Not much that isn’t already in the notes.

- Use the ACS data, filtered for the US, Maryland, and a few counties of
  your choice.
- Choose a few columns you’re interested in, and select those (plus
  location).
- Use more than one type of numeric variable (choose a mix of
  percentages, integers, and/or dollar amounts).
- Define the formatter functions you’ll need, and use them to format
  each variable as appropriate.
- Create a table using `knitr::kable`.
- Give your columns clean, readable names.
- Align the columns so text columns are aligned on the left, numeric
  ones on the right.
- Give the table a title using the `caption` argument of `kable`.

``` r
# install.packages("remotes")
remotes::install_github("umbc-viz/justviz")
```

    Skipping install of 'justviz' from a github remote, the SHA1 (c2826236) has not changed since last install.
      Use `force = TRUE` to force installation

``` r
# Central MD Counties/close to where I live
acs_frederick <- justviz::acs |>
    dplyr::filter(
        name %in%
            c(
                "United States",
                "Maryland",
                "Frederick County",
                "Washington County",
                "Carroll County",
                "Montgomery County"
            )
    ) |>
    dplyr::select(level, name, total_pop, no_vehicle_hh, median_hh_income, low_income, poverty)

# remember that the scales::label_* functions return formatter functions to reuse
comma <- scales::label_comma(accuracy = 1) # round to nearest whole number
percent <- scales::label_percent(accuracy = 1)
dollar <- scales::label_currency(accuracy = 1)

acs_fmttd <- acs_frederick |>
    dplyr::mutate(no_vehicle_hh = percent(no_vehicle_hh)) |>
    dplyr::mutate(median_hh_income = dollar(median_hh_income)) |>
    dplyr::mutate(poverty = percent(poverty)) |>
    dplyr::mutate(low_income = percent(low_income))

dplyr::rename(acs_fmttd,
    Level = level,
    Name = name,
    "No Vehicle Households" = "no_vehicle_hh",
    "Median Household Income" = "median_hh_income",
    "Low Income" = "low_income",
    "Poverty rate" = "poverty",
)
```

    # A tibble: 6 × 7
      Level  Name            total_pop No Vehicle Household…¹ Median Household Inc…²
      <fct>  <chr>               <dbl> <chr>                  <chr>                 
    1 us     United States   334922499 8%                     $80,734               
    2 state  Maryland          6206011 9%                     $103,678              
    3 county Carroll County     175321 3%                     $118,211              
    4 county Frederick Coun…    287048 4%                     $122,002              
    5 county Montgomery Cou…   1065949 9%                     $132,450              
    6 county Washington Cou…    155709 8%                     $77,747               
    # ℹ abbreviated names: ¹​`No Vehicle Households`, ²​`Median Household Income`
    # ℹ 2 more variables: `Low Income` <chr>, `Poverty rate` <chr>

``` r
knitr::kable(
   acs_fmttd,
   col.names = c(
      "Level",
      "Name",
      "Total Population",
      "No Vehicle Households",
      "Median Household Income",
      "Low Income",
      "Poverty Rate"
   ),
   caption = "Selected Socioeconomic Status Indicators, Frederick and Nearby Counties, 2024"
)
```

| Level | Name | Total Population | No Vehicle Households | Median Household Income | Low Income | Poverty Rate |
|:---|:---|---:|:---|:---|:---|:---|
| us | United States | 334922499 | 8% | \$80,734 | 28% | 12% |
| state | Maryland | 6206011 | 9% | \$103,678 | 21% | 9% |
| county | Carroll County | 175321 | 3% | \$118,211 | 13% | 5% |
| county | Frederick County | 287048 | 4% | \$122,002 | 14% | 6% |
| county | Montgomery County | 1065949 | 9% | \$132,450 | 17% | 7% |
| county | Washington County | 155709 | 8% | \$77,747 | 28% | 12% |

Selected Socioeconomic Status Indicators, Frederick and Nearby Counties,
2024
