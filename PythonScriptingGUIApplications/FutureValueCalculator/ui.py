#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk
import locale

from business import Investment

class FutureValueFrame(ttk.Frame):
    def __init__(self, parent):
        ttk.Frame.__init__(self, parent, padding="10 10 10 10")
        self.parent = parent

        # Attempt to set a locale that supports currency formatting
        try:
            locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
        except locale.Error:
            locale.setlocale(locale.LC_ALL, '')  # Use the user's default installed locale
            if locale.getlocale()[0] is None:
                print("Locale setting failed. Currency formatting may not work as expected.")

        self.investment1 = Investment()
        self.investment2 = Investment()

        self.monthlyInvestment1 = tk.StringVar()
        self.yearlyInterestRate1 = tk.StringVar()
        self.years1 = tk.StringVar()
        self.futureValue1 = tk.StringVar()

        self.initComponents()

    def initComponents(self):
        self.pack(fill=tk.BOTH, expand=True)

        # Frame for the first investment calculator
        left_frame = ttk.Frame(self)
        left_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), padx=30)
        self.create_investment_frame(left_frame, self.investment1, self.monthlyInvestment1, self.yearlyInterestRate1, self.years1, self.futureValue1)

        # Frame for the second investment calculator
        self.monthlyInvestment2 = tk.StringVar()
        self.yearlyInterestRate2 = tk.StringVar()
        self.years2 = tk.StringVar()
        self.futureValue2 = tk.StringVar()

        right_frame = ttk.Frame(self)
        right_frame.grid(row=0, column=1, sticky=(tk.W, tk.E, tk.N, tk.S))
        self.create_investment_frame(right_frame, self.investment2, self.monthlyInvestment2, self.yearlyInterestRate2, self.years2, self.futureValue2)

        # Configure the grid so that the frames share the space equally
        self.grid_columnconfigure(0, weight=1)
        self.grid_columnconfigure(1, weight=1)

        # Exit button at the bottom of the right frame
        exit_button = ttk.Button(right_frame, text="Exit", command=self.parent.destroy)
        exit_button.grid(row=5, column=0, columnspan=2, pady=10, sticky=tk.E)

    def create_investment_frame(self, parent, investment, monthlyInvestment, yearlyInterestRate, years, futureValue):
        ttk.Label(parent, text="Monthly Investment:").grid(column=0, row=0, sticky=tk.E)
        ttk.Entry(parent, width=25, textvariable=monthlyInvestment).grid(column=1, row=0)

        ttk.Label(parent, text="Yearly Interest Rate:").grid(column=0, row=1, sticky=tk.E)
        ttk.Entry(parent, width=25, textvariable=yearlyInterestRate).grid(column=1, row=1)

        ttk.Label(parent, text="Years:").grid(column=0, row=2, sticky=tk.E)
        ttk.Entry(parent, width=25, textvariable=years).grid(column=1, row=2)

        ttk.Label(parent, text="Future Value:").grid(column=0, row=3, sticky=tk.E)
        ttk.Entry(parent, width=25, textvariable=futureValue, state="readonly").grid(column=1, row=3)

        buttonFrame = ttk.Frame(parent)
        buttonFrame.grid(column=0, row=4, columnspan=2, sticky=tk.E)

        ttk.Button(buttonFrame, text="Calculate",
                   command=lambda: self.calculate(investment, monthlyInvestment, yearlyInterestRate, years, futureValue)).grid(column=1, row=0)
        ttk.Button(buttonFrame, text="Clear",
                   command=lambda: self.clear_fields(monthlyInvestment, yearlyInterestRate, years, futureValue)).grid(column=0, row=0, padx=5)

    def calculate(self, investment, monthlyInvestment, yearlyInterestRate, years, futureValue):
        try:
            investment.monthlyInvestment = float(monthlyInvestment.get())
            investment.yearlyInterestRate = float(yearlyInterestRate.get())
            investment.years = int(years.get())
            calculated_value = investment.calculateFutureValue()
            futureValue.set(locale.currency(calculated_value, grouping=True))
        except ValueError as e:  # Catch the ValueError if the entries are empty or contain non-numeric characters
            print("Error with input values: ", e)
            futureValue.set("Invalid input")

    def clear_fields(self, monthlyInvestment, yearlyInterestRate, years, futureValue):
        monthlyInvestment.set("")
        yearlyInterestRate.set("")
        years.set("")
        futureValue.set("")


if __name__ == "__main__":
    root = tk.Tk()
    root.title("Future Value Calculator")
    FutureValueFrame(root)
    root.mainloop()
