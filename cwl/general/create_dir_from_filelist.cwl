cwlVersion: v1.1
class: ExpressionTool

doc: |
  Based on: https://github.com/common-workflow-language/cwl-v1.1/blob/a22b7580c6b50e77c0a181ca59d3828dd5c69143/tests/dir7.cwl

requirements:
  InlineJavascriptRequirement: {}
inputs:
  files: File[]
  basename: string
outputs:
  dir: Directory
expression: |
  ${
  return {"dir": {"class": "Directory", "basename": inputs.basename, "listing": inputs.files}};
  }