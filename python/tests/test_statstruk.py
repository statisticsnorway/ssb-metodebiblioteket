# Tests for rate models

# Import libraries
from pathlib import Path

import numpy as np
import pandas as pd
import pytest

from statstruk import ratemodel

# Read in test data
sample_file = Path(__file__).parent / "data" / "sample_data.csv"
pop_file = Path(__file__).parent / "data" / "pop_data.csv"

sample1_file = Path(__file__).parent / "data" / "sample_data_1obs.csv"
pop1_file = Path(__file__).parent / "data" / "pop_data_1obs.csv"

s_data = pd.read_csv(sample_file)
p_data = pd.read_csv(pop_file)

# Add country variable
s_data["country"] = 1
p_data["country"] = 1


def test_statstruk_ratiomodel() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(x_var="employees", y_var="job_vacancies", strata_var="industry")
    assert isinstance(mod1.get_coeffs, pd.DataFrame)


def test_statstruk_ratio_nostrata() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(x_var="employees", y_var="job_vacancies", control_extremes=False)
    assert mod1.get_coeffs.shape[0] == 1


def test_statstruk_ratiomodel_liststrata() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var=["industry", "size"],
        control_extremes=False,
    )
    assert mod1.get_coeffs.shape[0] == 15


def test_statstruk_ratiomodel_excludes() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(
        x_var="employees", y_var="job_vacancies", strata_var="industry", exclude=[5, 9]
    )
    assert mod1.get_coeffs["_strata_var_mod"].iloc[2] == "B_surprise_9"
    assert mod1.get_estimates().shape[0] == 5
    assert mod1.get_weights().estimation_weights.iloc[0] == 1


def test_statstruk_ratiomodel_excludes_missing() -> None:
    """Observation 9855 is missing y-value and is removed. It should therefore be ignored when exclude is specified"""
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var="industry",
        exclude=[9855, 9912],
        control_extremes=False,
    )
    assert isinstance(mod1.get_coeffs, pd.DataFrame)


def test_statstruk_ratiomodel_get_estimates() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    with pytest.raises(RuntimeError):
        mod1.get_estimates()
    mod1.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var="industry",
        control_extremes=False,
    )

    # test estimates can be extracted
    est_df = mod1.get_estimates()
    assert int(est_df["job_vacancies_EST"].iloc[0]) == 24186

    # test for cross strata domain estimates
    est_df2 = mod1.get_estimates("size")
    assert int(est_df2["job_vacancies_EST"].iloc[0]) == 818 

    # test for aggregated domain estimates
    est_df3 = mod1.get_estimates("country")
    assert (
        int(est_df3["job_vacancies_EST"].values[0]) == 119773
    )


def test_statstruk_ratiomodel_uncertainty_type() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var="industry",
        control_extremes=False,
    )
    cv_df = mod1.get_estimates(uncertainty_type="CV", variance_type="standard")
    columns_ending_with_cv = [
        column for column in cv_df.columns if column.endswith("_CV")
    ]
    assert len(columns_ending_with_cv) > 0
    other_df = mod1.get_estimates(
        uncertainty_type="CI_SE_VAR", variance_type="standard"
    )
    columns_ending_with_lb = [
        column for column in other_df.columns if column.endswith("_LB")
    ]
    assert len(columns_ending_with_lb) > 0
    columns_ending_with_CV = [
        column for column in other_df.columns if column.endswith("_CV")
    ]
    assert len(columns_ending_with_CV) == 0


def test_statstruk_ratiomodel_get_extremes() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    with pytest.raises(RuntimeError):
        mod1.get_extremes()
    mod1.fit(x_var="employees", y_var="job_vacancies", strata_var="industry")
    ex_df = mod1.get_extremes()
    assert ex_df["id"][0] == 5
    assert ex_df.shape[0] == 111
    ex_df2 = mod1.get_extremes(gbound=10)
    assert ex_df2.shape[0] == 45
    ex_df3 = mod1.get_extremes(rbound=5, gbound=5)
    assert ex_df3.shape[0] == 4
    ex_df4 = mod1.get_extremes(rbound=3, threshold_type="rstud")
    assert ex_df4.shape[0] == 1

    mod2 = ratemodel(p_data, s_data, id_nr="id")
    mod2.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var="industry",
        control_extremes=False,
    )
    with pytest.raises(RuntimeError):
        mod2.get_extremes()



def test_statstruk_ratiomodel_standard() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(x_var="employees", y_var="job_vacancies", strata_var="industry")
    out = mod1.get_estimates(variance_type="standard")
     assert np.isclose(
        np.round(out["job_vacancies_CV"].iloc[0], 4), 3.9762, rtol=1e-09, atol=1e-09
    )


def test_statstruk_ratiomodel_nocontrol() -> None:
    mod1 = RatioModel(p_data, s_data, id_nr="id")
    mod1.fit(
        x_var="employees",
        y_var="job_vacancies",
        strata_var="industry",
        control_extremes=False,
    )
    out = mod1.get_estimates(variance_type="standard")
    assert np.isclose(
        np.round(out["job_vacancies_CV"].iloc[0], 4), 3.9762, rtol=1e-09, atol=1e-09
    )
    with pytest.raises(RuntimeError):
        mod1.get_extremes()
