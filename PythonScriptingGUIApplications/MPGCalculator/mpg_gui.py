#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk

class MyFrame(ttk.Frame):
    def __init__(self, parent):
        ttk.Frame.__init__(self, parent, padding="10 10 10 10")
        self.pack()

        # Define string variables for text entry fields
        self.miles_driven = tk.StringVar()
        self.gallons_used = tk.StringVar()
        self.mpg = tk.StringVar()

        # Display the grid of components
        ttk.Label(self, text="Miles Driven:").grid(column=0, row=0, sticky=tk.E)
        ttk.Entry(self, width=25, textvariable=self.miles_driven).grid(column=1, row=0)

        ttk.Label(self, text="Gallons of Gas Used:").grid(column=0, row=1, sticky=tk.E)
        ttk.Entry(self, width=25, textvariable=self.gallons_used).grid(column=1, row=1)

        ttk.Label(self, text="Miles Per Gallon:").grid(column=0, row=2, sticky=tk.E)
        ttk.Entry(self, width=25, textvariable=self.mpg, state="readonly").grid(column=1, row=2)

        # Calculate button
        ttk.Button(self, text="Calculate", command=self.calculate_mpg).grid(column=1, row=3, sticky=tk.E)

        # Add padding to all components
        for child in self.winfo_children():
            child.grid_configure(padx=5, pady=3)

    def calculate_mpg(self):
        try:
            miles = float(self.miles_driven.get())
            gallons = float(self.gallons_used.get())
            mpg = miles / gallons
            self.mpg.set(f"{mpg:.2f}")
        except ValueError:
            self.mpg.set("Invalid input")


if __name__ == "__main__":
    root = tk.Tk()
    root.title("Miles Per Gallon Calculator")
    MyFrame(root)
    root.mainloop()
