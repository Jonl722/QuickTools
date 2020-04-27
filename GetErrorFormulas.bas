Attribute VB_Name = "Module1"
Option Explicit

Private Sub GetErrorFormulas( _
        ByRef p_sheet As Worksheet, _
        ByRef pr_xlUnlockedFormulaCells As Range, _
        ByRef pr_xlInconsistentFormula As Range, _
        ByRef pr_xlInconsistentListFormula As Range)
    Dim rformula As Range   ' to be used as the iterrative cell in the search
    Dim rused As Range ' a range of all the in-use cells in a worksheet
    Dim rusedlast As Range ' the last cell of the rused range
    Dim rlastformula As Range ' the last cell containing a formula
    Set rused = p_sheet.UsedRange   ' get used cells range
    Set rusedlast = rused(rused.Count)  ' get last used cell
    Set rlastformula = p_sheet.Cells.Find(what:="=", LookIn:=xlFormulas, searchdirection:=xlPrevious, after:=rusedlast.Next) ' get last formula cell
    If rlastformula Is Nothing Then ' if the above call did not find a cell, then we do not have any formulas in the worksheet - exit with nothing
        Exit Sub
    End If
    Set rformula = rusedlast ' this is set to the last used cell to ensure that it finds the first formula cell, even if it is the first cell in the used range
    Do
        Set rformula = rused.Find(what:="=", LookIn:=xlFormulas, after:=rformula) ' get the next cell with formula from current rformula position
        If rformula.Errors(xlUnlockedFormulaCells).Value = True Then
            If pr_xlUnlockedFormulaCells Is Nothing Then
                Set pr_xlUnlockedFormulaCells = rformula
            Else
                Set pr_xlUnlockedFormulaCells = p_sheet.Application.Union(pr_xlUnlockedFormulaCells, rformula)
            End If
        End If
        If rformula.Errors(xlInconsistentFormula).Value = True Then
            If pr_xlInconsistentFormula Is Nothing Then
                Set pr_xlInconsistentFormula = rformula
            Else
                Set pr_xlInconsistentFormula = p_sheet.Application.Union(pr_xlInconsistentFormula, rformula)
            End If
        End If
        If rformula.Errors(xlInconsistentListFormula).Value = True Then
            If pr_xlInconsistentListFormula Is Nothing Then
                Set pr_xlInconsistentListFormula = rformula
            Else
                Set pr_xlInconsistentListFormula = p_sheet.Application.Union(pr_xlInconsistentListFormula, rformula)
            End If
        End If
    Loop Until rformula.Address = rlastformula.Address
End Sub

Public Sub test()
    Dim r1 As Range
    Dim r2 As Range
    Dim r3 As Range
    Dim sh As Worksheet
    Dim rarea As Range
    Set sh = ActiveWorkbook.Worksheets("Sheet2")
    GetErrorFormulas p_sheet:=sh, pr_xlUnlockedFormulaCells:=r1, pr_xlInconsistentFormula:=r2, pr_xlInconsistentListFormula:=r3
    For Each rarea In r1.Areas
        MsgBox rarea.Address
    Next
End Sub

'xlEvaluateToError   1   The cell evaluates to an error value.
'xlTextDate  2   Date entered as text.
'xlNumberAsText  3   Number entered as text.
'xlInconsistentFormula   4   The cell contains an inconsistent formula for a region.
'xlOmittedCells  5   Cells omitted.
'xlUnlockedFormulaCells  6   Formula cells are unlocked.
'xlEmptyCellReferences   7   The cell contains a formula referring to empty cells.
'xlListDataValidation    8   Data in the list contains a validation error.
'xlInconsistentListFormula   9   The cell contains an inconsistent formula for a list.

