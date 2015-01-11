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

fun number_in_month(dates : DATE list, month : int) =
  if null dates
  then 0
  else if (#month (hd dates)) = month
  then 1 + number_in_month(tl dates, month)
       else 0 + number_in_month(tl dates, month)

fun number_in_months(dates: DATE list, months: int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)
