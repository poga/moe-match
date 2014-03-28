#!/usr/bin/env lsc -cj
author:
  name: ['Poga Po']
  email: 'poga@poga.tw'
name: 'moe-match'
version: '0.0.1'
scripts:
  prepublish: """
  lsc common.ls 1 > common.1.json
  lsc common.ls 2 > common.2.json
  lsc common.ls 3 > common.3.json
  lsc sound2tone.ls > tone.json
  lsc pos.ls > pos.json
  """
repository:
  type: 'git'
  url: '{VCS}'
devDependencies:
  gulp: \*
  'gulp-util': \*
  'gulp-stylus': \*
  'gulp-jade': \*
  'gulp-livescript': \*
  LiveScript: \*
  jade: \*
