#
#         Name:     Barga, Marcus
#         Project:  2
#         Due:      10/20/22
#         Course:   cs-2640-04-f22
#
#         Description:
#                   Prompt for a date and output if the given year is a leap year or not and the day of the week of the given date.
#

          .data
title:    .asciiz   "Dates by M. Barga\n"
prompt1:  .asciiz   "Enter the month? "
prompt2:  .asciiz   "Enter the day? "
prompt3:  .asciiz   "Enter the year? "
notleap:  .asciiz   " is not a leap year and "
leap:     .asciiz   " is a leap year and "
sun:      .asciiz   " is a Sunday."
mon:      .asciiz   " is a Monday."
tue:      .asciiz   " is a Tuesday."
wed:      .asciiz   " is a Wednesday."
thu:      .asciiz   " is a Thursday."
fri:      .asciiz   " is a Friday."
sat:      .asciiz   " is a Saturday."

          .text
main:     la        $a0, title          # display title
          li        $v0, 4
          syscall

          la        $a0, '\n'           # new line
          li        $v0, 11
          syscall

          la        $a0, prompt1        # display month prompt
          li        $v0, 4
          syscall
          li        $v0, 5              # user input month
          syscall
          move      $t0, $v0            # month stored into t0

          la        $a0, prompt2        # display day prompt
          li        $v0, 4
          syscall
          li        $v0, 5              # user input day
          syscall
          move      $t1, $v0            # day stored into t1

          la        $a0, prompt3        # display year prompt
          li        $v0, 4
          syscall
          li        $v0, 5              # user input year
          syscall
          move      $t2, $v0            # year stored into t2

          la        $a0, '\n'           # new line
          li        $v0, 11
          syscall

          li        $t9, 14             # calculate a
          sub       $t3, $t9, $t0
          div       $t3, $t3, 12        # a stored into t3

          sub       $t4, $t2, $t3       # y stored into t4

          li        $t9, 12
          mul       $t5, $t9, $t3       # 12a
          add       $t5, $t0, $t5       # month + 12a
          sub       $t5, $t5, 2         # month + 12a - 2, m stored into t5

          add       $t6, $t1, $t4       # day + y
          div       $t9, $t4, 4         # y/4
          add       $t6, $t6, $t9       # day + y + y/4
          div       $t9, $t4, 100       # y/100
          sub       $t6, $t6, $t9       # day + y + y/4 - y/100
          div       $t9, $t4, 400       # y/400
          add       $t6, $t6, $t9       # day + y + y/4 - y/100 + y/400
          li        $t9, 31
          mul       $t9, $t9, $t5       # 31m
          div       $t9, $t9, 12        # 31m/12
          add       $t6, $t6, $t9       # day + y + y/4 - y/100 + y/400 + 31m/12
          rem       $t7, $t6, 7         # (day + y + y/4 - y/100 + y/400 + 31m/12) mod 7, d stored into t7

          rem       $t8, $t2, 4         # check if year is divisible by 4
          seq       $t8, $t8, 0         # if true, set t8 to 1, else set t8 to 0
          rem       $t9, $t2, 100       # check if year is not divisible by 100
          sne       $t9, $t9, 0         # if true, set t9 to 1, else set t9 to 0
          and       $t8, $t8, $t9       # if both are true (t9 is set to 1), set t8 to 1, else set t8 to 0
          rem       $t9, $t2, 400       # check if year is divisible by 400
          seq       $t9, $t9, 0         # if true, set t9 to 1, else set
          or        $t8, $t8, $t9       # if either t8 or t9 are set to 1, set t8 to 1, else set t8 to 0

          move      $a0, $t2            # output year number
          li        $v0, 1
          syscall

          bne       $t8, 0, else        # if (t8 == 0) {
          la        $a0, notleap        # output that the year given is not a leap year
          li        $v0, 4              #
          syscall                       # }
          b         endif
else:
          la        $a0, leap           # else {
          li        $v0, 4              # output that the year given is a leap year
          syscall                       # }

endif:
          move      $a0, $t0            # output given date in 'month/day/year' format {
          li        $v0, 1
          syscall
          la        $a0, '/'
          li        $v0, 11
          syscall
          move      $a0, $t1
          li        $v0, 1
          syscall
          la        $a0, '/'
          li        $v0, 11
          syscall
          move      $a0, $t2
          li        $v0, 1
          syscall                       # }

          bne       $t7, 0, monday      # output label 'sun' if d = 0
          la        $a0, sun
          li        $v0, 4
          syscall
          b         exit
monday:
          bne       $t7, 1, tuesday     # output label 'mon' if d = 1
          la        $a0, mon
          li        $v0, 4
          syscall
          b         exit
tuesday:
          bne       $t7, 2, wednesday   # output label 'tue' if d = 2
          la        $a0, tue
          li        $v0, 4
          syscall
          b         exit
wednesday:
          bne       $t7, 3, thursday    # output label 'wed' if d = 3
          la        $a0, wed
          li        $v0, 4
          syscall
          b         exit
thursday:
          bne       $t7, 4, friday      # output label 'thu' if d = 4
          la        $a0, thu
          li        $v0, 4
          syscall
          b         exit
friday:
          bne       $t7, 5, saturday    # output label 'fri' if d = 5
          la        $a0, fri
          li        $v0, 4
          syscall
          b         exit
saturday:
          la        $a0, sat            # output label 'sat' if d = 6
          li        $v0, 4
          syscall

exit:
          la        $a0, '\n'           # new line
          li        $v0, 11
          syscall

          li        $v0, 10             # exit
          syscall