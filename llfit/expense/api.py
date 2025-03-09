from datetime import datetime
from typing import List
from django.db.models import Sum
from ninja_extra import route, api_controller

from expense.models import Expense
from expense.schemas import ExpenseCreateSchema, ExpenseOut, ExpenseUpdateSchema

@api_controller('expense', tags=['Expense'])
class ExpenseController:

    @route.post('/add')
    def add_expense(self, request, data: ExpenseCreateSchema):
        try:
            user = request.auth
            expense = Expense.objects.create(
                user=user,
                **data.model_dump()
            )
            return {'success': True, 'message': 'expense added successfully..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        

    @route.get('/list', response=ExpenseOut)
    def get_expense_list(self, request, date: str = None, limit: int = 10, offset: int = 0):
        try:
            user = request.auth
            if not date:
                date = datetime.now().strftime("%Y-%m-%d")
            date_obj = datetime.strptime(date, '%Y-%m-%d')

            month_start = date_obj.replace(day=1)
            if date_obj.month == 12:
                month_end = date_obj.replace(month=1, year=date_obj.year + 1, day=1)
            else:
                month_end = date_obj.replace(month=date_obj.month + 1, day=1)
            expenses = Expense.objects.filter(user=user.id, date=date)[offset:offset + limit]
            day_total = Expense.objects.filter(user=user.id, date=date).aggregate(total=Sum("amount"))["total"] or 0
            month_total = Expense.objects.filter(user=user.id, date__gte=month_start, date__lt=month_end) \
                                     .aggregate(total=Sum("amount"))["total"] or 0
            return {
                "day_total": day_total,
                "month_total": month_total,
                "expense_list": expenses
            }

        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        
    
    @route.patch('/update')
    def update_expense(self, request, expense_id: int, data: ExpenseUpdateSchema):
        try:
            user = request.auth
            expense = Expense.objects.get(id=expense_id)
            if expense:
                Expense.objects.update(**data.model_dump())
                return {'success': True, 'message': 'expense updated successfully..!'}
            else:
                return {'success': False, 'message': 'expense not found..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}
        
    
    @route.delete('/delete')
    def delete_expense(self, request, expense_id: int):
        try:
            user = request.auth
            expense = Expense.objects.get(id=expense_id)
            if expense:
                expense.delete()
                return {'success': True, 'message': 'expense deleted successfully..!'}
            else:
                return {'success': False, 'message': 'expense not found..!'}
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}