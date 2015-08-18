select t.target_name, t.target_type,  d.property_name,
       d.property_display_name, p.property_value
     from mgmt$target t,
          mgmt$target_properties p,
          mgmt$all_target_prop_defs d
     where t.target_guid=p.target_guid
       and p.property_name=d.property_name
       and p.property_value is not null
       and d.property_display_name = 'LifeCycle Status';
