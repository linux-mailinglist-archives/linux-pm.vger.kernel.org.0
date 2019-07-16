Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97466A102
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfGPDxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 23:53:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33907 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbfGPDxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 23:53:19 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190716035315epoutp01ca8ef7c14f52b7790a655dc6f5767240~xxtxKk7I22679426794epoutp01a
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 03:53:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190716035315epoutp01ca8ef7c14f52b7790a655dc6f5767240~xxtxKk7I22679426794epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563249195;
        bh=xOrfF2V1TrRx6HR73KDvk6kIn5NuviCScjP9u9RMzGo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OYtb2z3wcaCoLAnKd55vnRr5w7c/ICsZ+Q1i1n5GOBmQ99jOEWr9Xv9rKUQv+ornU
         2Wz5cSdeS9L7q6JfULe4+Rt1SdWMRutBv4pCjzYUsjbDiFKnJCqsFj6xCaBLMgI0Q9
         SvDr+xOnMpURp3RvP6fY/aYI7Kq4xR9h/luNA+hw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716035314epcas1p1f1025c2e606ef06dc96c8d6a002fba13~xxtwkzj4T2629426294epcas1p1Q;
        Tue, 16 Jul 2019 03:53:14 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45nmhS1BKSzMqYkh; Tue, 16 Jul
        2019 03:53:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.3F.04088.82A4D2D5; Tue, 16 Jul 2019 12:53:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716035311epcas1p1424c1017594946117013e11c31479c22~xxtt10Rze2629426294epcas1p1E;
        Tue, 16 Jul 2019 03:53:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716035311epsmtrp2dc38d1fc8ae77259f25193da690def31~xxtt0-uE-2387423874epsmtrp2k;
        Tue, 16 Jul 2019 03:53:11 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-57-5d2d4a28c96e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.4D.03638.72A4D2D5; Tue, 16 Jul 2019 12:53:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716035311epsmtip140bf7c8efb4b5b9bb249b5a4818b165d~xxttoDJOn1311713117epsmtip1S;
        Tue, 16 Jul 2019 03:53:11 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7f7cf551-005a-c647-d571-77eb5426478a@samsung.com>
Date:   Tue, 16 Jul 2019 12:56:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715120416.3561-3-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmrq6Gl26swewlLBYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyM+987WQrOJFVcv7WZtYGxw7eLkZNDQsBE4sHaD6xdjFwcQgI7GCXW37/N
        BOF8YpT4MeUaC4TzjVHi8aO3TDAtx899Y4RI7GWUaP00Har/PaNE78V97CBVwgLhEr/u72IE
        sUUETCUerW4AK2IWuMwiMe3RJFaQBJuAlsT+FzfYQGx+AUWJqz8eAzVwcPAK2Em0zg8ACbMI
        qEpcuPAArFxUIELi1JF5LCA2r4CgxMmZT8BsTgEXidczJ4HtZRYQl7j1ZD4ThC0v0bx1NjPI
        XgmBc+wS62fPYwKZLwHUcHmxLMQ3whKvjm9hh7ClJD6/28sGYVdLrDx5hA2it4NRYsv+C6wQ
        CWOJ/Usng81hFtCUWL9LHyKsKLHz91xGiL18Eu++9rBCrOKV6GgTgihRlrj84C40ECUlFrd3
        sk1gVJqF5JtZSD6YheSDWQjLFjCyrGIUSy0ozk1PLTYsMESO7U2M4NStZbqDcco5n0OMAhyM
        Sjy8Cvt1YoVYE8uKK3MPMUpwMCuJ8Np+1Y4V4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnA
        vJJXEm9oamRsbGxhYmhmamioJM47749mrJBAemJJanZqakFqEUwfEwenVAOjTephw5I5L6L8
        kvWDgid+qDPhjy+dEO2YfejHhpvHtv3kkMuV3s18nme+cXU138J77OfVXI/3O6eav/lu31mW
        Hd6wwGMO797/qsIXXYz+fzqcJhadsDlgQ/JxbrU5X5RFhRWZF0z+eexuy+/tghM4bxbm310a
        2Z/XsqZNfs7JNkdHkdsPLwkqsRRnJBpqMRcVJwIAmibJQfMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnK66l26swYftshYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHsUl01Kak5mWWqRvl0CV8b9750sBWeSKq7f2szawNjh28XIySEhYCJx/Nw3
        xi5GLg4hgd2MEnePNLFAJCQlpl08ytzFyAFkC0scPlwMUfOWUeLg9pVgNcIC4RK/7u9iBLFF
        BEwlHq1uYAUpYha4yiJxfuMcNoiOi0AdO7exgVSxCWhJ7H9xA8zmF1CUuPrjMSPIBl4BO4nW
        +QEgYRYBVYkLFx6wgtiiAhESk67tBFvGKyAocXLmEzCbU8BF4vXMSewgNrOAusSfeZeYIWxx
        iVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOIq1tHYwnjgRf4hRgINRiYf3xB6dWCHWxLLiytxDjBIczEoivLZftWOFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MOauNd/mpX904RaP
        7QVT39o+DVrIIPne97OWyh7T5C1dFXZfjWrinzw1nsaVarFlTkOVjob/gtBKF82+P7c3lz+3
        mxT8udnsfcaUimMqga/dkhluaa87EXhTLXEK+/eQ57ZPbbbf+Pq4lHPZvn/ZCzwObDjAKBa5
        /1vWuSfcE3ac/cYhKbzv5hElluKMREMt5qLiRABHES1s3gIAAA==
X-CMS-MailID: 20190716035311epcas1p1424c1017594946117013e11c31479c22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a@eucas1p2.samsung.com>
        <20190715120416.3561-3-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

Looks good to me. But, this patch has some issue.
I added the detailed reviews.

I recommend that you make the separate patches as following
in order to clarify the role of which apply the dev_pm_opp_* function.

First patch,
Need to consolidate the following two function into one function.
because the original exynos-bus.c has the problem that the regulator
of parent devfreq device have to be enabled before enabling the clock.
This issue did not happen because bootloader enables the bus-related
regulators before kernel booting.
- exynos_bus_parse_of()
- exynos_bus_parent_parse_of()

Second patch,
Apply dev_pm_opp_set_regulators() and dev_pm_opp_set_rate()


On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
> Reuse opp core code for setting bus clock and voltage. As a side
> effect this allow useage of coupled regulators feature (required
> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
> uses regulator_set_voltage_triplet() for setting regulator voltage
> while the old code used regulator_set_voltage_tol() with fixed
> tolerance. This patch also removes no longer needed parsing of DT
> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
> it).
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
>  1 file changed, 66 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 486cc5b422f1..7fc4f76bd848 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -25,7 +25,6 @@
>  #include <linux/slab.h>
>  
>  #define DEFAULT_SATURATION_RATIO	40
> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>  
>  struct exynos_bus {
>  	struct device *dev;
> @@ -37,9 +36,9 @@ struct exynos_bus {
>  
>  	unsigned long curr_freq;
>  
> -	struct regulator *regulator;
> +	struct opp_table *opp_table;
> +
>  	struct clk *clk;
> -	unsigned int voltage_tolerance;
>  	unsigned int ratio;
>  };
>  
> @@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>  {
>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>  	struct dev_pm_opp *new_opp;
> -	unsigned long old_freq, new_freq, new_volt, tol;
>  	int ret = 0;
> -
> -	/* Get new opp-bus instance according to new bus clock */
> +	/*
> +	 * New frequency for bus may not be exactly matched to opp, adjust
> +	 * *freq to correct value.
> +	 */

You better to change this comment with following styles
to keep the consistency:

	/* Get correct frequency for bus ... */

>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
>  		dev_err(dev, "failed to get recommended opp instance\n");
>  		return PTR_ERR(new_opp);
>  	}
>  
> -	new_freq = dev_pm_opp_get_freq(new_opp);
> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>  	dev_pm_opp_put(new_opp);
>  
> -	old_freq = bus->curr_freq;
> -
> -	if (old_freq == new_freq)
> -		return 0;
> -	tol = new_volt * bus->voltage_tolerance / 100;
> -
>  	/* Change voltage and frequency according to new OPP level */
>  	mutex_lock(&bus->lock);
> +	ret = dev_pm_opp_set_rate(dev, *freq);
> +	if (!ret)
> +		bus->curr_freq = *freq;

Have to print the error log if ret has minus error value.
Modify it as following:

	if (ret < 0) {
		dev_err(dev, "failed to set bus rate\n");
		goto err:
	}
	bus->curr_freq = *freq;

err:
	mutex_unlock(&bus->lock);
	
	return ret;

>  
> -	if (old_freq < new_freq) {
> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
> -		if (ret < 0) {
> -			dev_err(bus->dev, "failed to set voltage\n");
> -			goto out;
> -		}
> -	}
> -
> -	ret = clk_set_rate(bus->clk, new_freq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to change clock of bus\n");
> -		clk_set_rate(bus->clk, old_freq);
> -		goto out;
> -	}
> -
> -	if (old_freq > new_freq) {
> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
> -		if (ret < 0) {
> -			dev_err(bus->dev, "failed to set voltage\n");
> -			goto out;
> -		}
> -	}
> -	bus->curr_freq = new_freq;
> -
> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
> -			old_freq, new_freq, clk_get_rate(bus->clk));
> -out:
>  	mutex_unlock(&bus->lock);
>  
>  	return ret;
> @@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
>  	if (ret < 0)
>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>  
> -	if (bus->regulator)
> -		regulator_disable(bus->regulator);
> +	if (bus->opp_table)
> +		dev_pm_opp_put_regulators(bus->opp_table);

Have to disable regulator after disabling the clock
to prevent the h/w fault.

I think that you should call them with following sequence:

	clk_disable_unprepare(bus->clk);
	if (bus->opp_table)
		dev_pm_opp_put_regulators(bus->opp_table);
	dev_pm_opp_of_remove_table(dev);

>  
>  	dev_pm_opp_of_remove_table(dev);
> +
>  	clk_disable_unprepare(bus->clk);
>  }
>  
> @@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>  {
>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>  	struct dev_pm_opp *new_opp;
> -	unsigned long old_freq, new_freq;
> -	int ret = 0;
> +	int ret;
>  
> -	/* Get new opp-bus instance according to new bus clock */
> +	/*
> +	 * New frequency for bus may not be exactly matched to opp, adjust
> +	 * *freq to correct value.
> +	 */

You better to change this comment with following styles
to keep the consistency:

	/* Get correct frequency for bus ... */

>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
>  		dev_err(dev, "failed to get recommended opp instance\n");
>  		return PTR_ERR(new_opp);
>  	}
>  
> -	new_freq = dev_pm_opp_get_freq(new_opp);
>  	dev_pm_opp_put(new_opp);
>  
> -	old_freq = bus->curr_freq;
> -
> -	if (old_freq == new_freq)
> -		return 0;
> -
>  	/* Change the frequency according to new OPP level */
>  	mutex_lock(&bus->lock);
> +	ret = dev_pm_opp_set_rate(dev, *freq);
> +	if (!ret)
> +		bus->curr_freq = *freq;

ditto. Have to print the error log, check above comment.

>  
> -	ret = clk_set_rate(bus->clk, new_freq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to set the clock of bus\n");
> -		goto out;
> -	}
> -
> -	*freq = new_freq;
> -	bus->curr_freq = new_freq;
> -
> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
> -			old_freq, new_freq, clk_get_rate(bus->clk));
> -out:
>  	mutex_unlock(&bus->lock);
>  
>  	return ret;
> @@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  					struct exynos_bus *bus)
>  {
>  	struct device *dev = bus->dev;
> -	int i, ret, count, size;
> -
> -	/* Get the regulator to provide each bus with the power */
> -	bus->regulator = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(bus->regulator)) {
> -		dev_err(dev, "failed to get VDD regulator\n");
> -		return PTR_ERR(bus->regulator);
> -	}
> -
> -	ret = regulator_enable(bus->regulator);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable VDD regulator\n");
> -		return ret;
> -	}
> +	int i, count, size;
>  
>  	/*
>  	 * Get the devfreq-event devices to get the current utilization of
> @@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	count = devfreq_event_get_edev_count(dev);
>  	if (count < 0) {
>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
> -		ret = count;
> -		goto err_regulator;
> +		return count;
>  	}
> +
>  	bus->edev_count = count;
>  
>  	size = sizeof(*bus->edev) * count;
>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
> -	if (!bus->edev) {
> -		ret = -ENOMEM;
> -		goto err_regulator;
> -	}
> +	if (!bus->edev)
> +		return -ENOMEM;
>  
>  	for (i = 0; i < count; i++) {
>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
> -		if (IS_ERR(bus->edev[i])) {
> -			ret = -EPROBE_DEFER;
> -			goto err_regulator;
> -		}
> +		if (IS_ERR(bus->edev[i]))
> +			return -EPROBE_DEFER;
>  	}
>  
>  	/*
> @@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>  
> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
> -					&bus->voltage_tolerance))
> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
> -
>  	return 0;
> -
> -err_regulator:
> -	regulator_disable(bus->regulator);
> -
> -	return ret;
>  }
>  
>  static int exynos_bus_parse_of(struct device_node *np,
> -			      struct exynos_bus *bus)
> +			      struct exynos_bus *bus, bool passive)
>  {
>  	struct device *dev = bus->dev;
> +	struct opp_table *opp_table;
> +	const char *vdd = "vdd";
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
>  	int ret;
> @@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
>  		return ret;
>  	}
>  
> +	if (!passive) {
> +		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +		if (IS_ERR(opp_table)) {
> +			ret = PTR_ERR(opp_table);
> +			dev_err(dev, "failed to set regulators %d\n", ret);
> +			goto err_clk;/
> +		}
> +
> +		bus->opp_table = opp_table;
> +	}

This driver has exynos_bus_parent_parse_of() function for parent devfreq device.
dev_pm_opp_set_regulators() have to be called in exynos_bus_parent_parse_of()
because the regulator is only used by parent devfreq device.

> +
>  	/* Get the freq and voltage from OPP table to scale the bus freq */
>  	ret = dev_pm_opp_of_add_table(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to get OPP table\n");
> -		goto err_clk;
> +		goto err_regulator;
>  	}
>  
>  	rate = clk_get_rate(bus->clk);
> @@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>  		ret = PTR_ERR(opp);
>  		goto err_opp;
>  	}
> +
>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> @@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>  
>  err_opp:
>  	dev_pm_opp_of_remove_table(dev);
> +
> +err_regulator:
> +	if (bus->opp_table) {
> +		dev_pm_opp_put_regulators(bus->opp_table);
> +		bus->opp_table = NULL;
> +	}

As I mentioned above, it it wrong to call dev_pm_opp_put_regulators()
after removing the opp_table by dev_pm_opp_of_remove_table().

> +
>  err_clk:
>  	clk_disable_unprepare(bus->clk);
>  
> @@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	struct exynos_bus *bus;
>  	int ret, max_state;
>  	unsigned long min_freq, max_freq;
> +	bool passive = false;
>  
>  	if (!np) {
>  		dev_err(dev, "failed to find devicetree node\n");
> @@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>  	if (!bus)
>  		return -ENOMEM;
> +
>  	mutex_init(&bus->lock);
>  	bus->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, bus);
> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> +	if (node) {
> +		of_node_put(node);
> +		passive = true;
> +	}
>  
>  	/* Parse the device-tree to get the resource information */
> -	ret = exynos_bus_parse_of(np, bus);
> +	ret = exynos_bus_parse_of(np, bus, passive);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> -	if (node) {
> -		of_node_put(node);
> +	if (passive)
>  		goto passive;
> -	} else {
> -		ret = exynos_bus_parent_parse_of(np, bus);
> -	}
> +
> +	ret = exynos_bus_parent_parse_of(np, bus);
>  

Remove unneeded blank line.

>  	if (ret < 0)
>  		goto err;
> @@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  
>  err:
>  	dev_pm_opp_of_remove_table(dev);
> +	if (bus->opp_table) {
> +		dev_pm_opp_put_regulators(bus->opp_table);
> +		bus->opp_table = NULL;
> +	}
> +

ditto.
Have to disable regulator after disabling the clock
to prevent the h/w fault.

I think that you should call them with following sequence:

	clk_disable_unprepare(bus->clk);
	if (bus->opp_table)
		dev_pm_opp_put_regulators(bus->opp_table);
	dev_pm_opp_of_remove_table(dev);

>  	clk_disable_unprepare(bus->clk);
>  
>  	return ret;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
