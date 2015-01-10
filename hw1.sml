(*  Assignment #1 *)

type DATE = {year:int, month:int, day: int}
exception InvalidParameter

fun weighted_sum(d : DATE) =
  real(#year d) + (real(#month d) / 12.0) + (real(#day d) / 365.0)

fun is_older(d1: DATE, d2: DATE): bool =
  if weighted_sum(d1) > weighted_sum(d2) then
    true
  else
    false
