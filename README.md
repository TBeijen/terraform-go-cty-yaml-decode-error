go-cty-yaml parse error
=======================

Temporary repo to illustrate and test YAML parse error occurring in Terraform and OpenTofu
when decoding YAML containing strings values of just `+`

This originates from go-cty-yaml

```sh
terraform plan
```

Error example:

```
   on main.tf line 28, in output "yaml_decode_test":
│   28:       inline_error            = yamldecode(local.yaml_inline_sample_error)
│     ├────────────────
│     │ while calling yamldecode(src)
│     │ local.yaml_inline_sample_error is "element: +\nsome_list:\n- foo\n- +\n"
│
│ Call to function "yamldecode" failed: cannot parse "+" as tag:yaml.org,2002:int.
╵
```

Showing validly parsed YAML:

```sh
terraform plan -var 'include_errors=false'
```

Validating YAML
---------------

Checking spec: <https://yaml.org/spec/1.2.2/#indicator-characters>

Using any of the online validators, e.g.: <https://yamlchecker.com/>

Using <https://yamllint.readthedocs.io/en/stable/index.html>

```sh
python3 -m yamllint .
```

Merely some warnings, `+` values pass validation

```
./sample-ok.yaml
  1:1       warning  missing document start "---"  (document-start)

./sample-error-list-value.yaml
  1:1       warning  missing document start "---"  (document-start)

./sample-error-single-value.yaml
  1:1       warning  missing document start "---"  (document-start)
```

Possible cause
--------------

Interpreted as integer based on `+`, then turning out not to be an integer by absence of any digits.

Reference: <https://yaml.org/spec/1.2.2/#tags>