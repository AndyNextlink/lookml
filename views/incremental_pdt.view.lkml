datagroup: incremental_default_datagroup {
  sql_trigger: SELECT MAX(created_at) FROM `data-sandbox-344301.thelook_ecommerce.orders`;;
  max_cache_age: "5 minutes"
}

view: incremental_pdt {
  derived_table: {
    sql: SELECT * FROM thelook_ecommerce.orders WHERE {% incrementcondition %} created_at {%  endincrementcondition %};;
    increment_key: "created_date"
    #increment_offset: 1
    datagroup_trigger: incremental_default_datagroup
    #interval_trigger: "5 minutes"
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

}
