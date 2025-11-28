with combined as(
SELECT 
    c.customers_id,
    c.NAME,
    c.market_segment AS Customer_Market_Segment,
    MIN(o.order_date) AS First_Ordered_At,
    MAX(o.order_date) AS Last_Ordered_At,
    COUNT(DISTINCT o.order_id) AS Lifetime_Orders,
    SUM(l.extended_price * L.tax_rate) AS Lifetime_Tax,
    SUM(l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) AS Lifetime_Total,
    CASE 
        WHEN SUM(l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) > 500000 THEN 'VIP'
        WHEN SUM(l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) BETWEEN 100000 AND 500000 THEN 'Mid-Tier'
        ELSE 'Low Spender'
    END AS Customer_Spending_Type,
    CASE 
        WHEN COUNT(DISTINCT o.order_id) > 1 THEN 'Repeated Customer'
        ELSE 'New Customer'
    END AS Customer_Status

FROM 
    {{ref('stg_customers')}} c
JOIN 
    {{ref('stg_orders')}} o 
    ON c.customers_id = o.customer_id
JOIN 
    {{ref('stg_line_items')}} l 
    ON o.order_id = l.order_id
GROUP BY 
    c.customers_id, 
    c.name, 
    c.market_segment
ORDER BY 
    Lifetime_Total DESC
)
select * from combined