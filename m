Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7F74B4A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389456AbfGYKOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 06:14:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56097 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbfGYKOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 06:14:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190725101414epoutp03c1cd737f43a7c88fa507d767abe21baf~0nt-I0-wd0565105651epoutp03p
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 10:14:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190725101414epoutp03c1cd737f43a7c88fa507d767abe21baf~0nt-I0-wd0565105651epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564049654;
        bh=b/K1E4DgeswJ0P/gfs2T0F+ifuT4kyaGOmNkK/qyVm0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=caQWnnPVUqA4cqIGxuADksFFz6c8k1ydITn42Q3NQSMHN9iF8nR1Plglwt1yESEBX
         +3oygPb1wGc7ICbEir4Zkc4EO5XAnHI/SjNefIQSmor2in19UJoCMWfSWiKVl3f5W6
         adUOomlm3v1StwEaqOhBAj+Jy/0MSiBnL2JynDQg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190725101413epcas1p14bd87c8e6bd298a2277d452479aafe49~0nt_ZaYl50704007040epcas1p13;
        Thu, 25 Jul 2019 10:14:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45vSjv5jdlzMqYkY; Thu, 25 Jul
        2019 10:14:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.0D.04066.3F0893D5; Thu, 25 Jul 2019 19:14:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190725101411epcas1p484582896e8b70d39b3cbe48070e23050~0nt70OhBC1305613056epcas1p4F;
        Thu, 25 Jul 2019 10:14:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725101411epsmtrp1a75d1ef9d7616813560233dd4d072726~0nt7y9F0x0934709347epsmtrp1O;
        Thu, 25 Jul 2019 10:14:10 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-89-5d3980f311bb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.6D.03706.2F0893D5; Thu, 25 Jul 2019 19:14:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725101410epsmtip2dc3f323fd5b9f7fe9fefa984c5d25861~0nt7eqDy_2527925279epsmtip21;
        Thu, 25 Jul 2019 10:14:10 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] devfreq: exynos-bus: convert to use
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
Message-ID: <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
Date:   Thu, 25 Jul 2019 19:17:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719150535.15501-4-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmge7nBstYg11b9Cw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZc1tsCqa6V6z5vpepgbHBoouRk0NCwETib9t0xi5GLg4hgR2MEu1rG6Gc
        T4wSl1s+skM43xglrm+7zgrTsvfIcjaIxF5GiZ13l0NVvQdqOfiNBaRKWCBcon1xJ1iHiICy
        xOR705lBipgFLrNITHs0CSzBJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3Eozk/2UFsFgFViflX
        1jKB2KICERKfHhxmhagRlDg58wnYMk4BV4lDlw8zg9jMAuISt57MZ4Kw5SWat84GWywhcIpd
        ouXFBGaIH1wker8dZIOwhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHcwSixZf8FaAAYS+xfOhlo
        AwfQBk2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiV
        ZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkaN7EyM4eWuZ72DccM7nEKMAB6MSDy9H
        kkWsEGtiWXFl7iFGCQ5mJRHewAazWCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wseSXx
        hqZGxsbGFiaGZqaGhkrivAt/AM0RSE8sSc1OTS1ILYLpY+LglGpgZGvb1SaddeiniHxQlLRY
        UmhWlKPvOxuRH/O7cpUzxVdzNb/k2r/19inlCwtsfJfMCTVcb5Vx24Zph16L5fZLEXGLruZa
        qNnkf2xof/eQ+bxA+oZVn+8meoYfmVC8V2S578q1zrEC+WWnb7B/39awd9aH/QySRvkifyQr
        WHemfFr74ctz7t+zlViKMxINtZiLihMBzaw/2fQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvO6nBstYg66NxhYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHsUl01Kak5mWWqRvl0CV8bcFpuCqe4Va77vZWpgbLDoYuTkkBAwkdh7ZDlb
        FyMXh5DAbkaJr+/2sUEkJCWmXTzK3MXIAWQLSxw+XAxR85ZRYunGE0wgNcIC4RLtiztZQWwR
        AWWJyfemM4MUMQtcZZE4v3EO1NTLjBIf9y1gB6liE9CS2P/iBtgGfgFFias/HjOC2LwCdhKP
        5vwEq2ERUJWYf2Ut2AZRgQiJwztmQdUISpyc+YQFxOYUcJU4dPkwM4jNLKAu8WfeJShbXOLW
        k/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI5iLc0djJeXxB9iFOBgVOLh3RBvESvEmlhWXJl7iFGCg1lJhDewwSxWiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkbhv+wfPl/hmGW9xypE
        eZ3E/rYTm+6m6vQ+y1k6t8XCxKJK+Qfr5AoHq0jXdcJv922aV7n4XK1Q8aSvYd1Lbuu/XXAj
        hrkj5O+6HM2LLh8uZ1qEVH/ZKSCydWfu5a2xS4w8nkanH9p/pv1nKJeOyKz6y668j2dP/XCp
        Z//1W1aHyu7s66l93bdHiaU4I9FQi7moOBEA48c62N4CAAA=
X-CMS-MailID: 20190725101411epcas1p484582896e8b70d39b3cbe48070e23050
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
        <20190719150535.15501-4-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

Looks good to me. But, I have some comment. Please check them.

After this patch, exynos_bus_target is perfectly same with
exynos_bus_passive_target. The exynos_bus_passive_target() could be removed.

On 19. 7. 20. 오전 12:05, k.konieczny@partner.samsung.com wrote:
> Reuse opp core code for setting bus clock and voltage. As a side
> effect this allow useage of coupled regulators feature (required

s/useage/usage ?

> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
> uses regulator_set_voltage_triplet() for setting regulator voltage
> while the old code used regulator_set_voltage_tol() with fixed
> tolerance. This patch also removes no longer needed parsing of DT
> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
> it).
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 143 +++++++++--------------------------
>  1 file changed, 37 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index f391044aa39d..c2147b0912a0 100644
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
> @@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
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
> @@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>  
>  	clk_disable_unprepare(bus->clk);
> -	if (bus->regulator)
> -		regulator_disable(bus->regulator);
> +	if (bus->opp_table)
> +		dev_pm_opp_put_regulators(bus->opp_table);
>  
>  	dev_pm_opp_of_remove_table(dev);
>  }
> @@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>  {
>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>  	struct dev_pm_opp *new_opp;
> -	unsigned long old_freq, new_freq;
> -	int ret = 0;
> +	int ret;
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
> @@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
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
> +	struct opp_table *opp_table;
> +	const char *vdd = "vdd";
> +	int i, count, size;
>  
>  	/*
>  	 * Get the devfreq-event devices to get the current utilization of
> @@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	count = devfreq_event_get_edev_count(dev);
>  	if (count < 0) {
>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
> -		ret = count;
> -		goto err_regulator;
> +		return count;
>  	}
> -	bus->edev_count = count;
>  
> +	bus->edev_count = count;
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
> +	}
> +
> +	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +	if (IS_ERR(opp_table)) {
> +		i = PTR_ERR(opp_table);
> +		dev_err(dev, "failed to set regulators %d\n", i);
> +		return i;

Maybe, you just used the 'i' defined variable instead of adding
new variable. But, I think that you better to add new variable
like 'err' for the readability. Or, jut use the 'PTR_ERR(opp_table)'
directly without any additional variable.

>  	}
>  
> +	bus->opp_table = opp_table;

Add blank line. 

>  	/*
>  	 * Optionally, Get the saturation ratio according to Exynos SoC
>  	 * When measuring the utilization of each AXI bus with devfreq-event
> @@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
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
>  static int exynos_bus_parse_of(struct exynos_bus *bus)
> @@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  
>  	/* Parse the device-tree to get the resource information */
>  	ret = exynos_bus_parse_of(bus);
> -	if (ret < 0) {
> -		if (!passive)
> -			regulator_disable(bus->regulator);
> -
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto err_reg;
>  
>  	if (passive)
>  		goto passive;
> @@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  
>  err:
>  	clk_disable_unprepare(bus->clk);
> -	if (!passive)
> -		regulator_disable(bus->regulator);
> -
>  	dev_pm_opp_of_remove_table(dev);

This function removes the 'opp_table'. But, the below code
uses the 'opp_table' variable by dev_pm_opp_put_regulators().

To disable the regulator, you have to call dev_pm_opp_of_remove_table(dev)
after dev_pm_opp_put_regulators(bus->opp_table).

> +err_reg:
> +	if (bus->opp_table) {
> +		dev_pm_opp_put_regulators(bus->opp_table);
> +		bus->opp_table = NULL;
> +	}
>  
>  	return ret;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
