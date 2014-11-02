---
title: Tickets handling
description: The easiest way to contribute is to help us handling the tickets.
order: 4
---

## Tickets

This document outlines the best practices for handling tickets in a medium/big
size Open Source Project. As CocoaPods is developed on GitHub and thus is based
on GitHub features, except this point all the concepts are applicable to other
Open Source Project.

The following guidelines are indicative and any step can be skipped when
reasonably useless.

CocoaPods ticket handling and development is an open process where actors use
their own judgement to decide whether they are comfortable undertaking an
action. If for any reason there is no enough confidence for an action the rest
of the team can be called.

### Labels

Tickets are classified along 4 axis: type, status, difficulty and priority. Every time a label is applied or changed a comment should be posted including any relevant information.

<div class="row">
  <div class="col-md-3 col-lg-3 col-sm-6">
    <h4>Type</h4>
    <ul style="padding:0">
      <li style="list-style-type:none"><span style="background-color:#02AFE1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">enhancement</span></li>
      <li style="list-style-type:none"><span style="background-color:#6902E1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">defect</span></li>
      <li style="list-style-type:none"><span style="background-color:#E10288;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">discussion</span></li>
    </ul>

  </div>

  <div class="col-md-3 col-lg-3 col-sm-6">
    <h4>Status</h4>
    <ul style="padding:0">
      <li style="list-style-type:none"><span style="background-color:#EDCE24;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">waiting&nbsp;input</span></li>
      <li style="list-style-type:none"><span style="background-color:#E2A72C;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">confirmed</span></li>
      <li style="list-style-type:none"><span style="background-color:#E28C2C;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">detailed</span></li>
      <li style="list-style-type:none"><span style="background-color:#F97D27;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">waiting&nbsp;validation</span></li>
      <li style="list-style-type:none"><span style="background-color:#684324;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">blocked</span></li>
    </ul>
  </div>

  <div class="col-md-3 col-lg-3 col-sm-6">
    <h4>Difficulty</h4>
    <ul style="padding:0">
      <li style="list-style-type:none"><span style="background-color:#00B952;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">easy</span></li>
      <li style="list-style-type:none"><span style="background-color:#40741F;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">moderate</span></li>
      <li style="list-style-type:none"><span style="background-color:#375921;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">hard</span></li>
    </ul>
  </div>

  <div class="col-md-3 col-lg-3 col-sm-6">
    <h4>Priority</h4>
    <ul style="padding:0">
      <li style="list-style-type:none"><span style="color:#000;background-color:#C7C1C1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">★</span> </li>
    </ul>
  </div>
</div>

### Steps to resolve a ticket

- Type identification
- Clarification
- Confirmation
- Identification of the actions
- Implementation
- Validation

### Type Identification

The ticket type should be set to either:
<span style="background-color:#02AFE1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">enhancement</span>
<span style="background-color:#6902E1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">defect</span>
<span style="background-color:#E10288;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">discussion</span>


If the ticket duplicates another one it should be closed as duplicated indicating a comment.

### Clarification

The ticket status should be changed to
<span style="background-color:#EDCE24;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">waiting&nbsp;input</span>

If the ticket description is incomplete or unclear further information should
requested to the submitter. This information might include a reproducible test
case for defects.

### Confirmation

Either ticket should either to closed or its status should be changed to
<span style="background-color:#E2A72C;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">confirmed</span>

If the ticket is considered highly desirable it can be prioritised setting the
priority to
<span style="color:#000;background-color:#C7C1C1;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">★</span>

#### Defects

A defect can be confirmed by reproducing the test case reported by the user.
The confirmation comment should report the __version__ of CocoaPods used and
should be considered valid for 2 minor versions. Moreover it should include a
report of the output generated by the tool and the contents of any generated
artefact if relevant.

#### Features

Minor enhancements can be confirmed by any contributor, major ones instead
require the opinion of a member of the Core team as their judgement might
require architectural and philosophical implications.

### Identification of the actions

The ticket status should be changed to
<span style="background-color:#E28C2C;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">detailed</span>

If there is another ticket which should be resolved before implementing this
ticket the <span style="background-color:#684324;color:#FFF;padding:0px
4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0
rgba(0,0,0,0.12);">blocked</span> label should be applied and a comment
indicating the dependency should be posted.

In this step, according to the breath of the change and the technical difficulty involved with it, the difficulty of the ticket should be set to either
<span style="background-color:#00B952;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">easy</span>
<span style="background-color:#A9B900;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">moderate</span>
<span style="background-color:#DC2424;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">hard</span>


Consists in the description of the changes which should be performed to the
output of CocoaPods indicating the command (or the context where they should
happen) if relevant.

Moreover the comment should include a description of the programmatic changes
required to implement the ticket.

### Implementation

After the ticket has been implemented via a pull request it can be marked
as
<span style="background-color:#F97D27;color:#FFF;padding:0px 4px;line-height:1.7em;border-radius:2px;box-shadow: inset 0 -1px 0 rgba(0,0,0,0.12);">waiting&nbsp;validation</span>

### Validation

Once a ticket has been implemented it should be validated, merged and finally
closed.

To validate the implementation of a major ticket a member of the Core team is
required.

Unless for trivial changes every pull request should include:

- Tests to prevent a regression
- A note in the CHANGELOG
