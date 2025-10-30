

with
    order_per_day as (
        select
            date_date,
            count(distinct orders_id) as nb_transactions,
            round(sum(revenue), 0) as revenue,
            round(sum(margin), 0) as margin,
            round(sum(operational_margin), 0) as operational_margin,
            round(sum(purchase_cost), 0) as purchase_cost,
            round(sum(shipping_fee), 0) as shipping_fee,
            round(sum(logcost), 0) as logcost,
            round(sum(ship_cost), 0) as ship_cost,
            sum(quantity) as quantity

        from {{ ref("int_orders_operational") }}

        group by date_date
    )

select
    date_date,
    revenue,
    margin,
    operational_margin,
    purchase_cost,
    shipping_fee,
    logcost,
    ship_cost,
    quantity,
    round(revenue / nullif(nb_transactions, 0), 2) as average_basket
from order_per_day

order by date_date desc
