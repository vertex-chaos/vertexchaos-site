# Patterns and Antipatterns

## Required Tracking Questions

Every meaningful project change should answer:
- what holds truth?
- what moves work?
- what retries?
- what fails first?
- what shortcut is tempting?
- why reject it or tolerate it temporarily?
- when must it be replaced?

## Explicit Antipattern Register

### database-as-a-queue

#### Description
Using the primary application database as a generic work-dispatch mechanism by polling rows for pending work.

#### Risks
- wasted polling load
- row-locking complexity
- fragile retry semantics
- queue churn harming the primary workload
- messy recovery logic

#### Rule
Do not tolerate this casually. If temporarily accepted, record:
- where it exists
- why it exists
- why it is acceptable for now
- what metric or event triggers replacement