INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	MAXLEN = 60
	TestCase DWORD ?
	Command DWORD ?
	Head BYTE 'O'
	RH BYTE '/'
	LH BYTE '\'
	Chest BYTE '|'
	RF BYTE '/'
	LF BYTE '\'
	Flag DWORD 0
	Say BYTE MAXLEN * 30 DUP(?)
	J DWORD ?
	CheckInvalid DWORD 0
	InvalidPrompt BYTE "Invalid Command!", 0
	BothLegException BYTE "Both Legs Cannot Be In!", 0
	CountLine DWORD 0
	LegChecker DWORD 1

.code
Main PROC
		MOV EAX, 5 + (3 * 10h)
	
	Call SetTextColor
	Call Clrscr

	Call Crlf
	Call Crlf
	Call Crlf
	Call Crlf
	Call Crlf
	Mwrite "		**************************************************************"
	Call Crlf
	Mwrite "		*                                                            *"
	Call Crlf
	Mwrite "		*       ~~~~~~ Project : A.S.C.I.I DANCER ~~~~~~             *"
	Call Crlf
	Mwrite "		*                                                            *"
	Call Crlf
	Mwrite "		**************************************************************"
	Call Crlf
	Mwrite "		*                                                            *"
	Call Crlf
	Mwrite "		*           Prepared By : Jatin Kesnani  (K21-3204)          *"
	Call Crlf
	Mwrite "		*                         Talha Muzammil (K20-1715)          *"
	Call Crlf
	Mwrite "		*                                                            *"
	Call Crlf
	Mwrite "		*                                                            *"
	Call Crlf
	Mwrite "		**************************************************************"
	Call Crlf

	Call ReadChar
	Call Clrscr

	MOV EAX, BLACK + (YELLOW * 10h)
	
	Call SetTextColor
	Call Clrscr

	Call Crlf
	Call Crlf
	Call Crlf
	Call Crlf
	Call Crlf
	Mwrite "                         ()()()   ()()()()    ()()()()  ()()()()()  ()()()()()"
	Call Crlf
	Mwrite "                        ()    ()  ()        ()              ()          ()"
	Call Crlf
	Mwrite "                        ()()()()  ()()()()  ()              ()          ()"
	Call Crlf
	Mwrite "                        ()    ()        ()  ()              ()          ()"
	Call Crlf
	Mwrite "                        ()    ()  ()()()()    ()()()()  ()()()()()  ()()()()()"
	Call Crlf
	Call Crlf
	Mwrite "                     ()()()      ()()()   ()      ()    ()()()()  ()()()()  ()()()"
	Call Crlf
	Mwrite "                     ()    ()   ()    ()  ()()    ()  ()          ()        ()   ()"
	Call Crlf
	Mwrite "                     ()     ()  ()()()()  ()  ()  ()  ()          ()()()()  ()()()"
	Call Crlf
	Mwrite "                     ()    ()   ()    ()  ()    ()()  ()          ()        ()  ()"
	Call Crlf
	Mwrite "                     ()()()     ()    ()  ()      ()    ()()()()  ()()()()  ()   ()"
	Call Crlf

	Call ReadChar
	Call Clrscr

	MOV EAX, 5 + (3 * 10h)
	
	Call SetTextColor
	Call Clrscr
														MOV CountLine, 0
	Call ReadInt
	MOV TestCase, EAX
	_While:
			MOV RH, '/'
			MOV LH, '\'
			MOV RF, '/'
			MOV LF, '\'
			CMP TestCase, 0
			JLE _EndWhile
			MOV Flag, 00000000b
			Call ReadInt
														INC CountLine
			MOV Command, EAX
			MOV J, 0
			FirstForLoop:
				MOV EAX, Command
				CMP J, EAX
				JE OutOfFirstForLoop
				MOV EAX, MAXLEN
				MUL J
				LEA EDX, Say[EAX]
				MOV ECX, MAXLEN
				Call ReadString
														INC CountLine
				INC J
			JMP FirstForLoop
		OutOfFirstForLoop:
			MOV J, 0
														INC CountLine
			Call Crlf
			RunInput: ;MOV EAX, 1500		;;;;Delay;Call Delay
				MOV EAX, Command
				CMP J, EAX
				JE OutOfRunInputForLoop
				MOV ECX, MAXLEN
				MOV EAX, J
				MUL ECX
;;;;Checking For "say "
				CMP Say[EAX + 0], 's'
				JNE DANCEMOVES
				CMP Say[EAX + 1], 'a'
				JNE DANCEMOVES
				CMP Say[EAX + 2], 'y'
				JNE DANCEMOVES
				CMP Say[EAX + 3], ' '
				JNE DANCEMOVES
					ADD EAX, 4
					LEA EDX, Say[EAX]
					Call WriteString
					Call Crlf
														ADD CountLine, 2
					JMP GoBack
;;;;Checking for DanceMoves
			DANCEMOVES:
				MOV CheckInvalid, 0
				MOV LegChecker, 1
				PUSH OFFSET Say
				PUSH EAX
				Call CheckRightLegIn
				Call CheckRightLegOut
				Call CheckLeftHandToHead
				Call CheckRightHandToHip
				Call CheckLeftHandToHip
				Call CheckRightHandToHead
				Call CheckTurn
				Call CheckRightHandToStart
				Call CheckLeftHandToStart
				Call CheckLeftLegIn
				Call CheckLeftLegOut

				CMP CheckInvalid, 0		;;;;Check Invalid Command
				JE PrintInvalid
				CMP LegChecker, 0
				JE Goback
														INC CountLine
														MOV DH, BYTE PTR CountLine
														MOV DL, 10
														Call GOTOXY
														LEA EDX, Say[EAX]
														Call WriteString
														ADD CountLine, 3
														MOV DH, BYTE PTR CountLine
														MOV DL, 0
														Call GOTOXY
			GoBack:
				Call Crlf
				INC J
			JMP RunInput
		OutOfRunInputForLoop:
														INC CountLine
			Call Crlf
			DEC TestCase
		JMP _While
	_EndWhile:
	exit
	PrintInvalid:
		MOV EDX, OFFSET InvalidPrompt	;;;;Display Invalid Prompt 
		Call WriteString
		Call Crlf
														ADD CountLine, 2
	JMP GoBack
exit
Main ENDP

CheckRightLegIn PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'r'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 1], 'i'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 2], 'g'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 3], 'h'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 4], 't'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 5], ' '
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 6], 'l'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 7], 'e'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 8], 'g'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 9], ' '
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 10], 'i'
			JNE NotRightLegIn
			CMP BYTE PTR [ESI + EAX + 11], 'n'
			JNE NotRightLegIn

			CMP Flag, 0
			JE IfState
CMP LF, '<'						;;LF = < || RF = > Error
JE BothLegIn
			MOV RF, '>'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotRightLegIn:
			POP EBP
	RET
		BothLegIn:
												ADD CountLine, 2
			MOV LegChecker, 0
			MOV EDX, OFFSET BothLegException
			Call WriteString
			Call Crlf
		JMP GoBack
		IfState:
CMP LF, '>'						;;RF = < || LF = > Error
JE BothLegIn
			MOV RF, '<'
			Call ForwardDisplayDancer
		JMP GoBack
CheckRightLegIn ENDP

CheckRightLegOut PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'r'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 1], 'i'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 2], 'g'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 3], 'h'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 4], 't'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 5], ' '
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 6], 'l'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 7], 'e'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 8], 'g'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 9], ' '
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 10], 'o'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 11], 'u'
			JNE NotRightLegOut
			CMP BYTE PTR [ESI + EAX + 12], 't'
			JNE NotRightLegOut

			CMP Flag, 0
			JE IfState
			MOV RF, '\'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotRightLegOut:
			POP EBP
	RET
		IfState:
			MOV RF, '/'
			Call ForwardDisplayDancer
		JMP GoBack
CheckRightLegOut ENDP

CheckLeftHandToHead PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'l'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 1], 'e'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 2], 'f'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 3], 't'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 4], ' '
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 5], 'h'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 6], 'a'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 7], 'n'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 8], 'd'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 9], ' '
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 10], 't'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 11], 'o'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 12], ' '
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 13], 'h'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 14], 'e'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 15], 'a'
			JNE NotLeftHandToHead
			CMP BYTE PTR [ESI + EAX + 16], 'd'
			JNE NotLeftHandToHead

			CMP Flag, 0
			JE IfState
			MOV LH, '('
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotLeftHandToHead:
			POP EBP
	RET
		IfState:
			MOV LH, ')'
			Call ForwardDisplayDancer
		JMP GoBack
CheckLeftHandToHead ENDP

CheckRightHandToHip PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'r'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 1], 'i'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 2], 'g'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 3], 'h'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 4], 't'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 5], ' '
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 6], 'h'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 7], 'a'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 8], 'n'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 9], 'd'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 10], ' '
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 11], 't'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 12], 'o'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 13], ' '
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 14], 'h'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 15], 'i'
			JNE NotRightHandToHip
			CMP BYTE PTR [ESI + EAX + 16], 'p'
			JNE NotRightHandToHip

			CMP Flag, 0
			JE IfState
			MOV RH, '>'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotRightHandToHip:
			POP EBP
	RET
		IfState:
			MOV RH, '<'
			Call ForwardDisplayDancer
		JMP GoBack
CheckRightHandToHip ENDP

CheckLeftHandToHip PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'l'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 1], 'e'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 2], 'f'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 3], 't'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 4], ' '
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 5], 'h'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 6], 'a'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 7], 'n'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 8], 'd'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 9], ' '
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 10], 't'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 11], 'o'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 12], ' '
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 13], 'h'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 14], 'i'
			JNE NotLeftHandToHip
			CMP BYTE PTR [ESI + EAX + 15], 'p'
			JNE NotLeftHandToHip

			CMP Flag, 0
			JE IfState
			MOV LH, '<'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotLeftHandToHip:
			POP EBP
	RET
		IfState:
			MOV LH, '>'
			Call ForwardDisplayDancer
		JMP GoBack
CheckLeftHandToHip ENDP

CheckRightHandToHead PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'r'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 1], 'i'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 2], 'g'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 3], 'h'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 4], 't'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 5], ' '
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 6], 'h'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 7], 'a'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 8], 'n'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 9], 'd'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 10], ' '
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 11], 't'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 12], 'o'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 13], ' '
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 14], 'h'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 15], 'e'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 16], 'a'
			JNE NotRightHandToHead
			CMP BYTE PTR [ESI + EAX + 17], 'd'
			JNE NotRightHandToHead

			CMP Flag, 0
			JE IfState
			MOV RH, ')'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotRightHandToHead:
			POP EBP
	RET
		IfState:
			MOV RH, '('
			Call ForwardDisplayDancer
		JMP GoBack
CheckRightHandToHead ENDP

CheckTurn PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 't'
			JNE NotTurn
			CMP BYTE PTR [ESI + EAX + 1], 'u'
			JNE NotTurn
			CMP BYTE PTR [ESI + EAX + 2], 'r'
			JNE NotTurn
			CMP BYTE PTR [ESI + EAX + 3], 'n'
			JNE NotTurn

			CMP Flag, 0
			JE IfState
			Call BackwardToForward
			Call ForwardDisplayDancer
			MOV Flag, 0
		GoBack:
		MOV CheckInvalid, 1
		NotTurn:
			POP EBP
	RET
		IfState:
			Call ForwardToBackward
			Call BackwardDisplayDancer
			MOV Flag, 1
		JMP GoBack
CheckTurn ENDP

CheckRightHandToStart PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'r'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 1], 'i'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 2], 'g'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 3], 'h'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 4], 't'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 5], ' '
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 6], 'h'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 7], 'a'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 8], 'n'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 9], 'd'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 10], ' '
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 11], 't'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 12], 'o'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 13], ' '
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 14], 's'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 15], 't'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 16], 'a'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 17], 'r'
			JNE NotRightHandToStart
			CMP BYTE PTR [ESI + EAX + 18], 't'
			JNE NotRightHandToStart

			CMP Flag, 0
			JE IfState
			MOV RH, '\'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotRightHandToStart:
			POP EBP
	RET
		IfState:
			MOV RH, '/'
			Call ForwardDisplayDancer
		JMP GoBack
CheckRightHandToStart ENDP

CheckLeftHandToStart PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'l'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 1], 'e'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 2], 'f'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 3], 't'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 4], ' '
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 5], 'h'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 6], 'a'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 7], 'n'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 8], 'd'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 9], ' '
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 10], 't'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 11], 'o'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 12], ' '
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 13], 's'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 14], 't'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 15], 'a'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 16], 'r'
			JNE NotLeftHandToStart
			CMP BYTE PTR [ESI + EAX + 17], 't'
			JNE NotLeftHandToStart

			CMP Flag, 0
			JE IfState
			MOV LH, '/'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotLeftHandToStart:
			POP EBP
	RET
		IfState:
			MOV LH, '\'
			Call ForwardDisplayDancer
		JMP GoBack
CheckLeftHandToStart ENDP

CheckLeftLegIn PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'l'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 1], 'e'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 2], 'f'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 3], 't'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 4], ' '
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 5], 'l'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 6], 'e'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 7], 'g'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 8], ' '
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 9], 'i'
			JNE NotLeftLegIn
			CMP BYTE PTR [ESI + EAX + 10], 'n'
			JNE NotLeftLegIn

			CMP Flag, 0
			JE IfState
CMP RF, '>'								;;LF = < || RF = > Error
JE BothLegIn
			MOV LF, '<'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotLeftLegIn:
			POP EBP
	RET
		BothLegIn:
													ADD CountLine, 2
			MOV LegChecker, 0
			MOV EDX, OFFSET BothLegException
			Call WriteString
			Call Crlf
		JMP GoBack
		IfState:
CMP RF, '<'								;;RF = < || LF = > Error
JE BothLegIn
			MOV LF, '>'
			Call ForwardDisplayDancer
		JMP GoBack
CheckLeftLegIn ENDP

CheckLeftLegOut PROC
			PUSH EBP
			MOV EBP, ESP
			MOV EAX, [EBP+8]		;;INDEX
			MOV ESI, [EBP+12]		;;MOVES

			CMP BYTE PTR [ESI + EAX + 0], 'l'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 1], 'e'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 2], 'f'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 3], 't'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 4], ' '
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 5], 'l'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 6], 'e'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 7], 'g'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 8], ' '
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 9], 'o'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 10], 'u'
			JNE NotLeftLegOut
			CMP BYTE PTR [ESI + EAX + 11], 't'
			JNE NotLeftLegOut

			CMP Flag, 0
			JE IfState
			MOV LF, '/'
			Call BackwardDisplayDancer
		GoBack:
		MOV CheckInvalid, 1
		NotLeftLegOut:
			POP EBP
	RET
		IfState:
			MOV LF, '\'
			Call ForwardDisplayDancer
		JMP GoBack
CheckLeftLegOut ENDP

ForwardToBackward PROC
			MOV AL, RH
			CMP AL, '('
			JE ChangeRH1
		Code1:
			CMP AL, '<'
			JE ChangeRH2
		Code2:
			CMP AL, '/'
			JE ChangeRH3
		Code3:
			MOV AL, LH
			CMP AL, ')'
			JE ChangeLH1
		Code4:
			CMP AL, '>'
			JE ChangeLH2
		Code5:
			CMP AL, '\'
			JE ChangeLH3
		Code6:
			MOV AL, RF
			CMP AL, '<'
			JE ChangeRF1
		Code7:
			CMP AL, '/'
			JE ChangeRF2
		Code8:
			MOV AL, LF
			CMP AL, '>'
			JE ChangeLF1
		Code9:
			CMP AL, '\'
			JE ChangeLF2
		Code10:
	RET
		ChangeRH1:
			MOV AL, ')'
			MOV RH, AL
		JMP Code1
	
		ChangeRH2:
			MOV AL, '>'
			MOV RH, AL
		JMP Code2

		ChangeRH3:
			MOV AL, '\'
			MOV RH, AL
		JMP Code3

		ChangeLH1:
			MOV AL, '('
			MOV LH, AL
		JMP Code4
	
		ChangeLH2:
			MOV AL, '<'
			MOV LH, AL
		JMP Code5

		ChangeLH3:
			MOV AL, '/'
			MOV LH, AL
		JMP Code6

		ChangeRF1:
			MOV AL, '>'
			MOV RF, AL
		JMP Code7

		ChangeRF2:
			MOV AL, '\'
			MOV RF, AL
		JMP Code8

		ChangeLF1:
			MOV AL, '<'
			MOV LF, AL
		JMP Code9

		ChangeLF2:
			MOV AL, '/'
			MOV LF, AL
		JMP Code10
ForwardToBackward ENDP

BackwardToForward PROC
			MOV AL, RH
			CMP AL, ')'
			JE ChangeRH1
		Code1:
			CMP AL, '>'
			JE ChangeRH2
		Code2:
			CMP AL, '\'
			JE ChangeRH3
		Code3:
			MOV AL, LH
			CMP AL, '('
			JE ChangeLH1
		Code4:
			CMP AL, '<'
			JE ChangeLH2
		Code5:
			CMP AL, '/'
			JE ChangeLH3
		Code6:
			MOV AL, RF
			CMP AL, '>'
			JE ChangeRF1
		Code7:
			CMP AL, '\'
			JE ChangeRF2
		Code8:
			MOV AL, LF
			CMP AL, '<'
			JE ChangeLF1
		Code9:
			CMP AL, '/'
			JE ChangeLF2
		Code10:
	RET
		ChangeRH1:
			MOV AL, '('
			MOV RH, AL
		JMP Code1
	
		ChangeRH2:
			MOV AL, '<'
			MOV RH, AL
		JMP Code2

		ChangeRH3:
			MOV AL, '/'
			MOV RH, AL
		JMP Code3

		ChangeLH1:
			MOV AL, ')'
			MOV LH, AL
		JMP Code4
	
		ChangeLH2:
			MOV AL, '>'
			MOV LH, AL
		JMP Code5

		ChangeLH3:
			MOV AL, '\'
			MOV LH, AL
		JMP Code6

		ChangeRF1:
			MOV AL, '<'
			MOV RF, AL
		JMP Code7

		ChangeRF2:
			MOV AL, '/'
			MOV RF, AL
		JMP Code8

		ChangeLF1:
			MOV AL, '>'
			MOV LF, AL
		JMP Code9

		ChangeLF2:
			MOV AL, '\'
			MOV LF, AL
		JMP Code10
BackwardToForward ENDP

ForwardDisplayDancer PROC
			MOV AL, RH
			CMP AL, '('
			JE RunThisRH
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Head
											Call Text_Animation
			Call WriteChar
			MOV AL, LH
			CMP AL, ')'
			JE ElseIfCode
											Call Text_Animation
			Call Crlf
			MOV AL, RH
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
			MOV AL, LH
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
		ReturnFromRH:
			MOV AL, RF
											Call Text_Animation
			Call WriteChar
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, LF
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
	RET
		ElseIfCode:
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			MOV AL, RH
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			JMP ReturnFromRH
		RunThisLH:
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			JMP ToPrev
		RunThisRH:
											Call Text_Animation
			Call WriteChar
			MOV AL, Head
											Call Text_Animation
			Call WriteChar
			MOV AL, LH
			CMP AL, ')'
			JE RunThisLH
											Call Text_Animation
			Call Crlf
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
			MOV AL, LH
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
		ToPrev:
			JMP ReturnFromRH
ForwardDisplayDancer ENDP

BackwardDisplayDancer PROC
			MOV AL, LH
			CMP AL, '('
			JE RunThisLH
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Head
											Call Text_Animation
			Call WriteChar
			MOV AL, RH
			CMP AL, ')'
			JE ElseIfCode
											Call Text_Animation
			Call Crlf
			MOV AL, LH
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
			MOV AL, RH
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
		ReturnFromLH:
			MOV AL, LF
											Call Text_Animation
			Call WriteChar
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, RF
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
	RET
		ElseIfCode:
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			MOV AL, LH
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			JMP ReturnFromLH
		RunThisRH:
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
			JMP ToPrev
		RunThisLH:
											Call Text_Animation
			Call WriteChar
			MOV AL, Head
											Call Text_Animation
			Call WriteChar
			MOV AL, RH
			CMP AL, ')'
			JE RunThisRH
											Call Text_Animation
			Call Crlf
			MOV AL, ' '
											Call Text_Animation
			Call WriteChar
			MOV AL, Chest
											Call Text_Animation
			Call WriteChar
			MOV AL, RH
											Call Text_Animation
			Call WriteChar
											Call Text_Animation
			Call Crlf
		ToPrev:
			JMP ReturnFromLH
BackwardDisplayDancer ENDP

Text_Animation PROC
		MOV ECX, 100000000
		L1:
		
		Loop L1
	RET
Text_Animation ENDP

END Main