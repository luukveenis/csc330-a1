(*  Assignment #1 *)

type DATE = {year:int, month:int, day: int}
exception InvalidParameter

fun weighted_sum(d : DATE) =
  real(#year d) + (real(#month d) / 12.0) + (real(#day d) / 365.0)

fun is_older(d1: DATE, d2: DATE): bool =
  weighted_sum(d1) > weighted_sum(d2)

fun number_in_month(dates : DATE list, month : int) =
  if null dates then 0
  else if (#month (hd dates)) = month then 1 + number_in_month(tl dates, month)
       else 0 + number_in_month(tl dates, month)

fun number_in_months(dates: DATE list, months: int list) =
  if null months then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates: DATE list, month: int): DATE list =
  if null dates then []
  else if (#month (hd dates)) = month then hd dates :: dates_in_month(tl dates, month)
       else dates_in_month(tl dates, month)

fun dates_in_months(dates: DATE list, months: int list): DATE list =
  if null months then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(words: string list, n: int): string =
  if n = 0 orelse n > length words then raise InvalidParameter
  else if n = 1 then hd words
    else get_nth(tl words, n-1)

fun date_to_string(date: DATE): string =
  let
    val months = [
      "January", "February", "March", "April", "May", "June", "July",
      "August", "September", "November", "December"
    ]
  in
    get_nth(months, #month date) ^ " " ^ Int.toString(#day date) ^ ", " ^ Int.toString(#year date)
  end

fun number_before_reaching_sum(sum: int, nums: int list): int =
  if null nums andalso sum > 0 then raise InvalidParameter
  else if sum - hd nums <= 0 then 0
       else 1 + number_before_reaching_sum(sum - hd nums, tl nums)
