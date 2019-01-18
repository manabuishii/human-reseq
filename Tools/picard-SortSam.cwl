#!/usr/bin/env cwl-runner

class: CommandLineTool
id: picard-SortSam-2.10.6
label: picard-SortSam-2.10.6
cwlVersion: v1.0

$namespaces:
  edam: 'http://edamontology.org/'

hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/picard:2.10.6--py27_0'

requirements:
  - class: ShellCommandRequirement

baseCommand: [ java, -jar, /usr/local/share/picard-2.10.6-0/picard.jar, SortSam ]

inputs:
  - id: experimentID
    type: string
    doc: experiment ID for input FastQ file
  - id: sampleID
    type: string
    doc: sample ID for input FastQ file
  - id: centerID
    type: string
    doc: sequencing center ID for input FastQ file
  - id: sam
    type: File
    format: edam:format_2573
    inputBinding:
      prefix: "INPUT="
      position: 1
    doc: input SAM alignment file

outputs:
  - id: bam
    type: File
    format: edam:format_2572
    outputBinding:
      glob: $(inputs.experimentID).bam
  - id: bam_log
    type: stderr

stderr: $(inputs.experimentID).bam.log
    
arguments:
  - position: 2
    valueFrom: "OUTPUT=$(inputs.experimentID).bam"
  - position: 3
    valueFrom: "TMP_DIR=$(inputs.experimentID).bam.temp"
  - position: 4
    valueFrom: "SORT_ORDER=coordinate"
  - position: 5
    valueFrom: "COMPRESSION_LEVEL=1"
  - position: 6
    valueFrom: "VALIDATION_STRINGENCY=LENIENT"
  - position: 7
    valueFrom: "&&"
  - position: 8
    valueFrom: "rm"
  - position: 9
    prefix: -rf
    valueFrom: $(inputs.experimentID).bam.temp
