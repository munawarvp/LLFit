from typing import List, Optional
from ninja import Schema, ModelSchema

from expense.models import Expense

class ExpenseCreateSchema(Schema):
    category: str
    description: str
    amount: float
    date: str
    type: str

class ExpenseUpdateSchema(Schema):
    category: Optional[str] = None
    description: Optional[str] = None
    amount: Optional[float] = None
    date: Optional[str] = None
    type: Optional[str] = None

class ExpenseListOut(ModelSchema):
    class Meta:
        model = Expense
        fields = ('id', 'amount', 'category', 'description', 'date', 'type', 'created_at')

class ExpenseOut(Schema):
    day_total: float = 0
    month_total: float = 0
    expense_list: List[ExpenseListOut]


