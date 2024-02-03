variable "include_errors" {
  type    = bool
  default = true
}

locals {
  yaml_inline_sample_ok    = <<-EOT
            element: "+"
            some_list:
            - foo
        EOT
  yaml_inline_sample_error = <<-EOT
            element: +
            some_list:
            - foo
            - +
        EOT
}

output "yaml_decode_test" {
  value = merge(
    {
      file_ok   = yamldecode(file("sample-ok.yaml"))
      inline_ok = yamldecode(local.yaml_inline_sample_ok)
    },
    (var.include_errors == true ? {
      inline_error            = yamldecode(local.yaml_inline_sample_error)
      file_error_single_value = yamldecode(file("sample-error-single-value.yaml"))
      file_error_list_value   = yamldecode(file("sample-error-list-value.yaml"))
    } : {})
  )
}
