Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7843985775
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbfHHBS0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 21:18:26 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59544 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389330AbfHHBS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 21:18:26 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190808011822epoutp040dd32ca63fbae4e54203098f424590f8~4zcGsXvgD0416304163epoutp04h
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 01:18:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190808011822epoutp040dd32ca63fbae4e54203098f424590f8~4zcGsXvgD0416304163epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565227102;
        bh=suZAtkIZTbidJYEnTA76OQo7ZKcjFnobhaY/lmuV4Xk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=abQtU9kI2ZQdYYVw3HnZxvGI1wnP66yE3Qww/GGgXSXbVpw1VSQHwCmDletFWvyr9
         p6n2BncgLrks4aXMjXeHBCFwnKaDxQ1ttnxjZBoa2/j5eAP6C3m2G1a1UlPB76ruYO
         2mkylD3DWFkKOaouLW11eeTsC5nUNBK43rSii8tI=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190808011821epcas1p3b9c69c2336d6f97be75f9061d122b066~4zcGG1UI-2572025720epcas1p3Y;
        Thu,  8 Aug 2019 01:18:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 463r9626FjzMqYkd; Thu,  8 Aug
        2019 01:18:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.EB.04085.A587B4D5; Thu,  8 Aug 2019 10:18:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190808011817epcas1p3134a8b6ebab5e8c22283ac185f1337e5~4zcCjpb002041420414epcas1p3B;
        Thu,  8 Aug 2019 01:18:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808011817epsmtrp141a3aa2f06d91e432431428489e33030~4zcCisNPF2993829938epsmtrp1x;
        Thu,  8 Aug 2019 01:18:17 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-c4-5d4b785a8158
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.2D.03638.9587B4D5; Thu,  8 Aug 2019 10:18:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808011817epsmtip2fa34f57945596b559e162d892de38d13~4zcCVFcDl2156621566epsmtip2h;
        Thu,  8 Aug 2019 01:18:17 +0000 (GMT)
Subject: Re: [PATCH v5 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     k.konieczny@partner.samsung.com
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
Message-ID: <9dd88e2e-f9fc-aa05-4ba4-8dfb009ec9f6@samsung.com>
Date:   Thu, 8 Aug 2019 10:21:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807133838.14678-3-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmrm5UhXesweGz/BYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyM6XsvsxUctquY2vKcuYHxpmEXIyeHhICJxOeGr6xdjFwcQgI7GCVOTP7P
        COF8YpR4uv8eO4TzjVHiyM8ORpiWOS3vWCASexklFlxoYYZw3jNKtD7+AeRwcAgLhEt8veIG
        0iAioCwx+d50sBpmgcssEtMeTWIFSbAJaEnsf3GDDcTmF1CUuPrjMdgGXgE7idfPLzKD2CwC
        KhK9N28zgdiiAhESnx4cZoWoEZQ4OfMJC4jNKeAqseZCCzuIzSwgLnHryXwmCFteonnrbLDF
        EgLn2CU+Tn/BBvGCi8SKOx1QtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbY
        v3QyE8iXzAKaEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYhiBJlicsP7jJB2JISi9s7
        2SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWmCJH9yZGcPLWstzBeOyczyFGAQ5G
        JR5ehgtesUKsiWXFlbmHGCU4mJVEeO+VecYK8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5Hxg
        ZskriTc0NTI2NrYwMTQzNTRUEudd+MMiVkggPbEkNTs1tSC1CKaPiYNTqoFRdJ57xpzzjx1c
        LXvZq3RkGVRZvr5J3ahRY/zdI8ImtuPy7diZr6+wzVsbabJI6lF9g7Yna2pBLMOCv2rXcnu0
        Iu/rhzu/uc967MarZTHlh3q9u78XFM7bLvI0PVT0xNnedSsfd01d/FOpm/u3gF69WISOaCR7
        1uqUNpZvrC1/s/8XB0kFdymxFGckGmoxFxUnAgCudC/r9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvG5khXeswaP72hYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHsUl01Kak5mWWqRvl0CV8b0vZfZCg7bVUxtec7cwHjTsIuRk0NCwERiTss7
        li5GLg4hgd2MEtvm9LJBJCQlpl08ytzFyAFkC0scPlwMUfOWUWL62wZGkLiwQLjE1ytuIOUi
        AsoSk+9NZwapYRa4yiJxfuMcNoiGy4wSL//OYwWpYhPQktj/4gbYAn4BRYmrPx4zgti8AnYS
        r59fZAaxWQRUJHpv3mYCsUUFIiQO75gFVSMocXLmExYQm1PAVWLNhRZ2EJtZQF3iz7xLzBC2
        uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhb
        XJqXrpecn7uJERzFWlo7GE+ciD/EKMDBqMTDy3DBK1aINbGsuDL3EKMEB7OSCO+9Ms9YId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyaUy5eWlgr2NoW
        tkD2nYm4vIHwwxli9wP092x7URPxzM1z9u+DLFKG2uv6jdPuSoTMbczI47J+udxtQdzxLhtV
        b3PnDVaLkpV2rQ83FVyYOZlTyl0vrSzZpPjUtuBrx198tTQoz7t2q3rzn5PJVzmKZaLm3zed
        8Vsvprx/wU3JVaqyOemTZiqxFGckGmoxFxUnAgBgN9cs3gIAAA==
X-CMS-MailID: 20190808011817epcas1p3134a8b6ebab5e8c22283ac185f1337e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190807133857eucas1p23d2618db67434fa1301585cab059fa5b
References: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
        <CGME20190807133857eucas1p23d2618db67434fa1301585cab059fa5b@eucas1p2.samsung.com>
        <20190807133838.14678-3-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 19. 8. 7. 오후 10:38, k.konieczny@partner.samsung.com wrote:
> Reuse opp core code for setting bus clock and voltage. As a side
> effect this allow usage of coupled regulators feature (required
> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
> uses regulator_set_voltage_triplet() for setting regulator voltage
> while the old code used regulator_set_voltage_tol() with fixed
> tolerance. This patch also removes no longer needed parsing of DT
> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
> it). After applying changes both functions exynos_bus_passive_target()
> and exynos_bus_target() have the same code, so remove
> exynos_bus_passive_target(). In exynos_bus_probe() replace it with
> exynos_bus_target.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
> Changes:
> v5:
> - squashed last patch into this one, as suggested by Chanwoo Choi
> v4:
> - remove unrelated changes, add newline before comment
> 
> ---
>  drivers/devfreq/exynos-bus.c | 130 +++++++----------------------------
>  1 file changed, 24 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index f34fa26f00d0..2aeb6cc07960 100644
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
> @@ -37,9 +36,8 @@ struct exynos_bus {
>  
>  	unsigned long curr_freq;
>  
> -	struct regulator *regulator;
> +	struct opp_table *opp_table;
>  	struct clk *clk;
> -	unsigned int voltage_tolerance;
>  	unsigned int ratio;
>  };
>  
> @@ -93,62 +91,29 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
>  }
>  
>  /*
> - * Must necessary function for devfreq simple-ondemand governor
> + * devfreq function for both simple-ondemand and passive governor
>   */
>  static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>  {
>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>  	struct dev_pm_opp *new_opp;
> -	unsigned long old_freq, new_freq, new_volt, tol;
>  	int ret = 0;
>  
> -	/* Get new opp-bus instance according to new bus clock */
> +	/* Get correct frequency for bus. */
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
> @@ -196,54 +161,10 @@ static void exynos_bus_exit(struct device *dev)
>  
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
> -	if (bus->regulator)
> -		regulator_disable(bus->regulator);
> -}
> -
> -/*
> - * Must necessary function for devfreq passive governor
> - */
> -static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
> -					u32 flags)
> -{
> -	struct exynos_bus *bus = dev_get_drvdata(dev);
> -	struct dev_pm_opp *new_opp;
> -	unsigned long old_freq, new_freq;
> -	int ret = 0;
> -
> -	/* Get new opp-bus instance according to new bus clock */
> -	new_opp = devfreq_recommended_opp(dev, freq, flags);
> -	if (IS_ERR(new_opp)) {
> -		dev_err(dev, "failed to get recommended opp instance\n");
> -		return PTR_ERR(new_opp);
> -	}
> -
> -	new_freq = dev_pm_opp_get_freq(new_opp);
> -	dev_pm_opp_put(new_opp);
> -
> -	old_freq = bus->curr_freq;
> -
> -	if (old_freq == new_freq)
> -		return 0;
> -
> -	/* Change the frequency according to new OPP level */
> -	mutex_lock(&bus->lock);
> -
> -	ret = clk_set_rate(bus->clk, new_freq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to set the clock of bus\n");
> -		goto out;
> +	if (bus->opp_table) {
> +		dev_pm_opp_put_regulators(bus->opp_table);
> +		bus->opp_table = NULL;
>  	}
> -
> -	*freq = new_freq;
> -	bus->curr_freq = new_freq;
> -
> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
> -			old_freq, new_freq, clk_get_rate(bus->clk));
> -out:
> -	mutex_unlock(&bus->lock);
> -
> -	return ret;
>  }
>  
>  static void exynos_bus_passive_exit(struct device *dev)
> @@ -258,21 +179,19 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  					struct exynos_bus *bus)
>  {
>  	struct device *dev = bus->dev;
> +	struct opp_table *opp_table;
> +	const char *vdd = "vdd";
>  	int i, ret, count, size;
>  
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
> +	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +	if (IS_ERR(opp_table)) {
> +		ret = PTR_ERR(opp_table);
> +		dev_err(dev, "failed to set regulators %d\n", ret);
>  		return ret;
>  	}
>  
> +	bus->opp_table = opp_table;
> +
>  	/*
>  	 * Get the devfreq-event devices to get the current utilization of
>  	 * buses. This raw data will be used in devfreq ondemand governor.
> @@ -313,14 +232,11 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>  
> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
> -					&bus->voltage_tolerance))
> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
> -
>  	return 0;
>  
>  err_regulator:
> -	regulator_disable(bus->regulator);
> +	dev_pm_opp_put_regulators(bus->opp_table);
> +	bus->opp_table = NULL;
>  
>  	return ret;
>  }
> @@ -471,7 +387,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	goto out;
>  passive:
>  	/* Initialize the struct profile and governor data for passive device */
> -	profile->target = exynos_bus_passive_target;
> +	profile->target = exynos_bus_target;
>  	profile->exit = exynos_bus_passive_exit;
>  
>  	/* Get the instance of parent devfreq device */
> @@ -511,8 +427,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
>  err_reg:
> -	if (!passive)
> -		regulator_disable(bus->regulator);
> +	if (!passive) {
> +		dev_pm_opp_put_regulators(bus->opp_table);
> +		bus->opp_table = NULL;
> +	}
>  
>  	return ret;
>  }
> 

It looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
