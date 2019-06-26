@echo off
SetLocal EnableDelayedExpansion

set "pattern=%1"
shift

set "envs="
for /f "usebackq" %%e in (
   `tox --listenvs-all ^| find "%pattern%" ^| find "-w32"`
) do (
   if not defined envs (set "envs=%%e") else (set "envs=!envs!,%%e")
)

if not "%envs%"=="" (
   tox -e "%envs%" %*
) else (
   echo "No environments match %pattern%" >&2
)
