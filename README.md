Readme
================

# Mantalsregister 1909

## Purpose

Stockholms city archive have got a nice register of people who were
taxed in Stockholm in 1909 with name, date of birth, address and title.
There are many observations!

It could be interesting to do some geo-coding of this data to look at
how technological change in the labour market resulting in changing
housing patterns - did changing incomes increase segregation, drive up
rental prices etc? Would tie in well with the data that Fredrik will
have. What were the occupational structures like and how much economies
of agglomeration were there?

[Link](https://sok.stadsarkivet.stockholm.se/Databas/mantalsregister-1909/Sok?sidindex=0)

## Data

It is digitized and in a nice table on the website of Stockholm city
archives.

This is what it looks like:

![](images/table.PNG)

## Scraping

The scraper is in in the [code folder](code/03-scraper.qmd).

### Records

``` r
library(tidyverse)
```

    ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ✔ ggplot2 3.3.6      ✔ purrr   0.3.5 
    ✔ tibble  3.1.8      ✔ dplyr   1.0.10
    ✔ tidyr   1.2.1      ✔ stringr 1.4.1 
    ✔ readr   2.1.3      ✔ forcats 0.5.2 
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()

``` r
library(gt)

records <- c("1800 - 45838
1810 - 40003
1820 - 43416
1830 - 38953
1840 - 27312
1850 - 33802
1860 - 41264
1870 - 73899
1880 - 111130")

records %>%
  as_tibble() %>%
  separate_rows(value, sep = "\n") %>%
  separate(value, into = c("year", "n_records")) %>%
  mutate(across(everything(), parse_number)) %>%
  gt() %>%
  fmt_number(columns = c(n_records), decimals = 0, sep_mark = " ")
```

<div id="ouystskvcu" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ouystskvcu .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ouystskvcu .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ouystskvcu .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ouystskvcu .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ouystskvcu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ouystskvcu .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ouystskvcu .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ouystskvcu .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ouystskvcu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ouystskvcu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ouystskvcu .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ouystskvcu .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#ouystskvcu .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ouystskvcu .gt_from_md > :first-child {
  margin-top: 0;
}

#ouystskvcu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ouystskvcu .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ouystskvcu .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ouystskvcu .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ouystskvcu .gt_row_group_first td {
  border-top-width: 2px;
}

#ouystskvcu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ouystskvcu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ouystskvcu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ouystskvcu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ouystskvcu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ouystskvcu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ouystskvcu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ouystskvcu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ouystskvcu .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ouystskvcu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ouystskvcu .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ouystskvcu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ouystskvcu .gt_left {
  text-align: left;
}

#ouystskvcu .gt_center {
  text-align: center;
}

#ouystskvcu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ouystskvcu .gt_font_normal {
  font-weight: normal;
}

#ouystskvcu .gt_font_bold {
  font-weight: bold;
}

#ouystskvcu .gt_font_italic {
  font-style: italic;
}

#ouystskvcu .gt_super {
  font-size: 65%;
}

#ouystskvcu .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#ouystskvcu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ouystskvcu .gt_indent_1 {
  text-indent: 5px;
}

#ouystskvcu .gt_indent_2 {
  text-indent: 10px;
}

#ouystskvcu .gt_indent_3 {
  text-indent: 15px;
}

#ouystskvcu .gt_indent_4 {
  text-indent: 20px;
}

#ouystskvcu .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">year</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">n_records</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_right">1800</td>
<td class="gt_row gt_right">45 838</td></tr>
    <tr><td class="gt_row gt_right">1810</td>
<td class="gt_row gt_right">40 003</td></tr>
    <tr><td class="gt_row gt_right">1820</td>
<td class="gt_row gt_right">43 416</td></tr>
    <tr><td class="gt_row gt_right">1830</td>
<td class="gt_row gt_right">38 953</td></tr>
    <tr><td class="gt_row gt_right">1840</td>
<td class="gt_row gt_right">27 312</td></tr>
    <tr><td class="gt_row gt_right">1850</td>
<td class="gt_row gt_right">33 802</td></tr>
    <tr><td class="gt_row gt_right">1860</td>
<td class="gt_row gt_right">41 264</td></tr>
    <tr><td class="gt_row gt_right">1870</td>
<td class="gt_row gt_right">73 899</td></tr>
    <tr><td class="gt_row gt_right">1880</td>
<td class="gt_row gt_right">111 130</td></tr>
  </tbody>
  
  
</table>
</div>
