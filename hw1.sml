(*  Assignment #1 *)

type DATE = {year:int, month:int, day: int}
exception InvalidParameter

fun is_older(d1: DATE, d2: DATE): bool =
  if (#year d1) > (#year d2) then true
  else if (#year d1) = (#year d2) then
    if (#month d1) > (#month d2) then true
    else if (#month d1) = (#month d2) andalso (#day d1) > (#day d2) then true
    else false
  else false

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

fun what_month(doy: int):int =
  let
    val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum(doy, days_in_months) + 1
  end

fun month_range(day1: int, day2: int): int list =
  if day1 > day2 then []
  else what_month(day1) :: month_range(day1+1, day2)

fun oldest(dates: DATE list): DATE option =
  if null dates then NONE
  else
    let fun max(dates: DATE list): DATE =
      if null (tl dates) then hd dates
      else
        let val tl_max = max(tl dates)
        in
          if is_older(hd dates, tl_max)
          then hd dates
          else tl_max
        end
    in
      SOME (max dates)
    end

fun is_leap_year(year: int): bool =
  (year mod 400 = 0) orelse ((year mod 4 = 0) andalso (year mod 100 <> 0))

fun reasonable_date(date: DATE): bool =
  if (#year date) > 0 andalso (#month date) > 0 andalso (#month date) < 13
  then
    let
      fun get_days(days: int list, month: int): int =
        if month = 1 then hd days
        else get_days(tl days, month-1)

      val days_in_months =
        if is_leap_year(#year date)
        then [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        else [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      val days_in_month = get_days(days_in_months, #month date)
    in
      (#day date) > 0 andalso (#day date) <= days_in_month
    end
  else false
