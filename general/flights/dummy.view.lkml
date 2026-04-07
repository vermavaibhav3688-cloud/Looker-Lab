view: dummy {

    sql_table_name: `cloud-training-demos.looker_flights.carriers` ;;

    dimension: code {
      primary_key: yes
      type: string
      sql: ${TABLE}.code ;;
    }
}
