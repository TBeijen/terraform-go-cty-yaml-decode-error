locals {
  yaml_load_test_ok     = yamldecode(file("sample-ok.yaml"))
  yaml_load_test_single = yamldecode(file("sample-error-single-value.yaml"))
  yaml_load_test_list   = yamldecode(file("sample-error-list-value.yaml"))

}

output "yaml_load_test" {
  value = {
    ok     = local.yaml_load_test_ok
    single = local.yaml_load_test_single
    list   = local.yaml_load_test_list
  }
}
