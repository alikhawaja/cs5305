from pyspark.sql import DataFrame
import pandas as pd
import matplotlib.pyplot as plt
from IPython.display import display as ipy_display, HTML

def display(df: DataFrame, max_rows: int = 20, chart: bool = False, x=None, y=None):
    """
    Drop-in replacement for Databricks display() in PySpark.
    
    Args:
        df (DataFrame): Spark DataFrame to display.
        max_rows (int): Max rows to collect for display.
        chart (bool): If True, plot a chart (requires x and y).
        x (str): Column name for x-axis (required if chart=True).
        y (str): Column name for y-axis (required if chart=True).
    """
    if not isinstance(df, DataFrame):
        raise TypeError("display() expects a PySpark DataFrame.")

    try:
        # Collect small sample to Pandas
        pdf = df.limit(max_rows).toPandas()

        if chart:
            if not x or not y:
                raise ValueError("For chart=True, you must provide x and y column names.")
            plt.figure(figsize=(8, 4))
            pdf.plot(kind='bar', x=x, y=y, legend=False)
            plt.title(f"{y} by {x}")
            plt.tight_layout()
            plt.show()
        else:
            # Pretty HTML table if in Jupyter
            try:
                ipy_display(HTML(pdf.to_html(index=False)))
            except Exception:
                print(pdf.to_string(index=False))

    except Exception as e:
        print(f"[display] Error: {e}")
        print("Falling back to df.show():")
        df.show(max_rows, truncate=False)
