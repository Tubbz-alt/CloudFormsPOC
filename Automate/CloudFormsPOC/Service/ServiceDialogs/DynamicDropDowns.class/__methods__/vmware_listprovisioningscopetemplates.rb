# vmware_ListProvisioningScopeTemplates.rb
#
# Description: Build Dialog of available vmware tempalates that are tagged with prov_scope=all and a certain criteria
#
templates_hash = {}
# build a hash of templates that meet this criteria
$evm.vmdb('miq_template').all.each do |template|
  next if template.archived
  next unless template.tagged_with?('prov_scope', 'all')
  next unless template.vendor.downcase == 'vmware'
  templates_hash[template[:name]] = template[:name]
end

# build a dialog of templates
dialog_field               = $evm.object
dialog_field["values"]     = [[nil, nil]] + templates_hash.to_a
dialog_field["data_type"]  = "string"
dialog_field["required"]   = "true"
dialog_field["sort_by"]    = "description"
dialog_field["sort_order"] = "ascending"
$evm.log(:info, "Dialog Values:<#{dialog_field['values'].inspect}>")
