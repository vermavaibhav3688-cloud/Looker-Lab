# flight analysis
view: flight_analysis {
  sql_table_name: `cloud-training-demos.looker_flights.flights` ;;

  dimension: flight_id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(
          ${TABLE}.carrier,
          "-",
          ${TABLE}.flight_num,
          "-",
          CAST(${TABLE}.dep_time AS STRING),
          "-",
          ${TABLE}.origin
        ) ;;
  }

  dimension: route {
    type: string
    sql: CONCAT(${origin}, ' → ', ${destination}) ;;
    label: "Route"
  }


  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
    label: "Flight Number"
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }
  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }
  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: cancelled {
    type: yesno
    sql: ${TABLE}.cancelled ;;
    label: "Cancelled Flight"
  }

  dimension: diverted {
    type: yesno
    sql: ${TABLE}.diverted ;;
    label: "Diverted Flight"
  }

  measure: flight_count {
    type: count
    sql: ${flight_id} ;;

    drill_fields: [
      carrier,
      origin,
      destination,
      flight_num,
      cancelled,
      diverted
    ]

  }

  measure: routes_operated {
    type: count_distinct
    sql: CONCAT(${origin}, '-', ${destination}) ;;
    label: "Routes Operated"
    description: "Unique origin-destination combinations"
  }

  measure: avg_departure_delay {
    type: average
    sql: ${TABLE}.dep_delay ;;
    label: "Avg Departure Delay (min)"
  }

  measure: avg_arrival_delay {
    type: average
    sql: ${TABLE}.arr_delay ;;
    label: "Avg Arrival Delay (min)"
  }

  measure: total_distance {
    type: sum
    sql: ${TABLE}.distance ;;
    label: "Total Miles Flown"
  }


}
