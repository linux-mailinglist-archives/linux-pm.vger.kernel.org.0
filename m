Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048C06A78C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfGPLjl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:39:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33179 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbfGPLjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:39:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190716113937euoutp0237a85a5f4a1791c459ebf03688e3fcee~x4E975qIR1349213492euoutp02G
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190716113937euoutp0237a85a5f4a1791c459ebf03688e3fcee~x4E975qIR1349213492euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563277177;
        bh=fMb9MXvIHQMWmLmlYL443kSG4HRn1rGQIO9yE41AQpE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iRodbfpsWIXuv5hO8Hs60wTLuMO6m5B2tpVE2HIO1fOGWwHYbiIkl/AZSkTwhOPo3
         tCB+becVrz7omQVKHTrFElW5HtQdCQquo6XrtDrkHCaQjHpqDOYVTGYCVF7qJYslHg
         CcwyBMhMDfWkyFCmbSJOj5RaNVhmE0i9lOMFN8tw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716113936eucas1p2f38cf6dbfdeacc0f609727c9b2a8a368~x4E9HGLtN1772817728eucas1p2S;
        Tue, 16 Jul 2019 11:39:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.75.04377.877BD2D5; Tue, 16
        Jul 2019 12:39:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716113936eucas1p1e7674eeed8fcabbd0e9b984d58891347~x4E8Z6nDN1106611066eucas1p1D;
        Tue, 16 Jul 2019 11:39:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716113935eusmtrp24509b691f2fdbdcfebcbcdd099187932~x4E8Lg7mM0827908279eusmtrp2F;
        Tue, 16 Jul 2019 11:39:35 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-a7-5d2db778bbb1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.1E.04146.777BD2D5; Tue, 16
        Jul 2019 12:39:35 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716113934eusmtip1e1a0ac3811597a893390ec244f48246a~x4E7bezhL1380313803eusmtip16;
        Tue, 16 Jul 2019 11:39:34 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@partner.samsung.com>,
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
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1a9e5752-bc2b-3b08-a36b-fc02ca51764c@samsung.com>
Date:   Tue, 16 Jul 2019 13:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <29cfafc4-ee22-6d38-4c67-776c48bfed8a@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjt/e6OFp+r8EHFYmB0VYvAF28ZRuxHP/pjRrJq1YdKTmXTsqum
        Zipp2t0VTkXTZhebprUsSJca4aZkaq4wvGDptEIrG2npPiX/ned5znnPOfBypOwL7c7FxCUK
        mjhVrJyRUHXNv62bkus3Kf2qLF64e3KYxnqzhcZ5L/4ifGlglMRWazWL29LsLDYOdNH4rek2
        gydyzQjftL4g8H3zRxaXd3cQ2HauksH2qTYCn39uZvFM1yMK13xqZkJdFfeK7iGF0ZDNKGrK
        UhQvxxsIRV6tASlaeuoJxYTRaze7TxJ0RIiNOSZofEMOSqJ16VephKlSlDxWamNTUeuZHOTC
        Ab8VPuSmETlIwsn4SgQ59mvzwySCru46JA4TCLILTMyCRNdhIcVDBYJ84ygrDmMIPhRmUHOs
        5XwEOPpMaA6v4NdC4XSn8ymSb6egucpGzx0YPgAKLhicJCkfAr0lZU4xxXvDL4vZyVnJ74W+
        5mpa5LjC68JBJ8eF3wbZuY+ckUjeDXoH9YSIV0H641vOeMDnclCQYSfF3DugxtZHi3g5jLTU
        siL2hL9P9YQoeIBgOuvzvLoeQcWVmfnWgdDU0jGr5mYt1sFDk6+43g795x3E3Br4ZdAz5iqG
        WAaX626Q4loKWZkykb0Gqu9UMwu2OU/vkvlIrltUTbeojm5RHd1/32JEGZCbkKRVRwnaLXHC
        cR+tSq1NiovyORyvNqLZD/hmpmXyCTL9OdSIeA7Jl0pbGzYqZbTqmPaEuhEBR8pXSIN/bFDK
        pEdUJ04KmvgDmqRYQduIPDhK7iY9teRTpIyPUiUKRwUhQdAsXAnOxT0VyQoTAg/7H3Ac/5pV
        oofa/baKs2M+Htej+odWR6eUB3V+16/r7Ar3L0peXXExMtYgfxZeLk1OVRzMDmPDAvZsD7Na
        firdX8Uot3ng6edNJUO/hycj9EsbPu6yO6yDEe22CT/OMzS4nX4/Upwy/m5K4lBFFO3scfNm
        Dp3+ltlU1SCntNGqzetJjVb1D/uEv/98AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7rl23VjDf5d1rS4/uU5q8X8I+dY
        Lfr2/We06H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs3izY+zTBate4+wW/y7tpHFYvODY2wOgh5r5q1h9Ni0qpPNY/OSeo+D7/YwefRtWcXo
        cfzGdiaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DJmNU9hKfixiLHi7aLb7A2MJ2q7GDk5JARMJGZdPMfcxcjFISSwlFHi3tNtbF2M
        HEAJGYnj68sgaoQl/lzrYoOoec0oMfN5JxtIQlggXOLX/V2MILaIgIbEzL9XwGxmgUssEs3T
        SyEabjFLbJo+lwUkwSZgJTGxfRVYEa+AncSthUvA4iwCqhLfzx1hBbFFBSIkzrxfwQJRIyhx
        cuYTMJtTwF6is3cjG8QCdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDQLSfssJC2zkLTMQtKy
        gJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmC0bzv2c/MOxksbgw8xCnAwKvHwntijEyvE
        mlhWXJl7iFGCg1lJhNf2q3asEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDE1FeSbyhqaG5
        haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGGNndO349WJrIdkgy+8jma73s
        3wofKZulcaUz8641cQvR05ji3M0z36l2k1r1pbAVDs+ao7S1pHa6Vfz/e7v0qLrl1Z7MaVqn
        8+bP518Ye6zqS8rmZWnq/yd9DxY2C+ZyX+KY5bjo0L4VDy5yZxWaaM9bcG/+wu9zNNKc50pk
        feeb7rbw78lXSizFGYmGWsxFxYkAbxhu0gwDAAA=
X-CMS-MailID: 20190716113936eucas1p1e7674eeed8fcabbd0e9b984d58891347
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120431eucas1p215eae81d0ca772d7e2a22a803669068a@eucas1p2.samsung.com>
        <20190715120416.3561-3-k.konieczny@partner.samsung.com>
        <7f7cf551-005a-c647-d571-77eb5426478a@samsung.com>
        <3d1687b7-4825-ad82-2706-a712c30e530b@samsung.com>
        <5612547b-47c8-0dc4-cb3c-e972782d5a26@samsung.com>
        <3ba736fa-832c-a72c-e60b-f4328e54c524@samsung.com>
        <29cfafc4-ee22-6d38-4c67-776c48bfed8a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/16/19 1:26 PM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 7. 16. 오후 7:59, Bartlomiej Zolnierkiewicz wrote:
>>
>> On 7/16/19 12:33 PM, Chanwoo Choi wrote:
>>> Hi Bartlomiej,
>>>
>>> On 19. 7. 16. 오후 7:13, Bartlomiej Zolnierkiewicz wrote:
>>>>
>>>> Hi Chanwoo,
>>>>
>>>> On 7/16/19 5:56 AM, Chanwoo Choi wrote:
>>>>> Hi Kamil,
>>>>>
>>>>> Looks good to me. But, this patch has some issue.
>>>>> I added the detailed reviews.
>>>>>
>>>>> I recommend that you make the separate patches as following
>>>>> in order to clarify the role of which apply the dev_pm_opp_* function.
>>>>>
>>>>> First patch,
>>>>> Need to consolidate the following two function into one function.
>>>>> because the original exynos-bus.c has the problem that the regulator
>>>>> of parent devfreq device have to be enabled before enabling the clock.
>>>>> This issue did not happen because bootloader enables the bus-related
>>>>> regulators before kernel booting.
>>>>> - exynos_bus_parse_of()
>>>>> - exynos_bus_parent_parse_of()
>>>>>> Second patch,
>>>>> Apply dev_pm_opp_set_regulators() and dev_pm_opp_set_rate()
>>>>>
>>>>>
>>>>> On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
>>>>>> Reuse opp core code for setting bus clock and voltage. As a side
>>>>>> effect this allow useage of coupled regulators feature (required
>>>>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>>>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>>>>> while the old code used regulator_set_voltage_tol() with fixed
>>>>>> tolerance. This patch also removes no longer needed parsing of DT
>>>>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>>>>> it).
>>>>>>
>>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>>> ---
>>>>>>  drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
>>>>>>  1 file changed, 66 insertions(+), 106 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>>> index 486cc5b422f1..7fc4f76bd848 100644
>>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>>> @@ -25,7 +25,6 @@
>>>>>>  #include <linux/slab.h>
>>>>>>  
>>>>>>  #define DEFAULT_SATURATION_RATIO	40
>>>>>> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>>>>>>  
>>>>>>  struct exynos_bus {
>>>>>>  	struct device *dev;
>>>>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>>>>  
>>>>>>  	unsigned long curr_freq;
>>>>>>  
>>>>>> -	struct regulator *regulator;
>>>>>> +	struct opp_table *opp_table;
>>>>>> +
>>>>>>  	struct clk *clk;
>>>>>> -	unsigned int voltage_tolerance;
>>>>>>  	unsigned int ratio;
>>>>>>  };
>>>>>>  
>>>>>> @@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>>>>  {
>>>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>>  	struct dev_pm_opp *new_opp;
>>>>>> -	unsigned long old_freq, new_freq, new_volt, tol;
>>>>>>  	int ret = 0;
>>>>>> -
>>>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>>>> +	/*
>>>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>>>> +	 * *freq to correct value.
>>>>>> +	 */
>>>>>
>>>>> You better to change this comment with following styles
>>>>> to keep the consistency:
>>>>>
>>>>> 	/* Get correct frequency for bus ... */
>>>>>
>>>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>>  	if (IS_ERR(new_opp)) {
>>>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>>>  		return PTR_ERR(new_opp);
>>>>>>  	}
>>>>>>  
>>>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>>> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>>>>>>  	dev_pm_opp_put(new_opp);
>>>>>>  
>>>>>> -	old_freq = bus->curr_freq;
>>>>>> -
>>>>>> -	if (old_freq == new_freq)
>>>>>> -		return 0;
>>>>>> -	tol = new_volt * bus->voltage_tolerance / 100;
>>>>>> -
>>>>>>  	/* Change voltage and frequency according to new OPP level */
>>>>>>  	mutex_lock(&bus->lock);
>>>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>>>> +	if (!ret)
>>>>>> +		bus->curr_freq = *freq;
>>>>>
>>>>> Have to print the error log if ret has minus error value.
>>>>
>>>> dev_pm_opp_set_rate() should print the error message on all
>>>> errors so wouldn't printing the error log also here be superfluous?
>>>>
>>>> [ Please also note that the other user of dev_pm_opp_set_rate()
>>>>   (cpufreq-dt cpufreq driver) doesn't do this. ]
>>>
>>> OK. Thanks for the explanation. 
>>>
>>>>
>>>>> Modify it as following:
>>>>>
>>>>> 	if (ret < 0) {
>>>>> 		dev_err(dev, "failed to set bus rate\n");
>>>>> 		goto err:
>>>>> 	}
>>>>> 	bus->curr_freq = *freq;
>>>>>
>>>>> err:
>>>>> 	mutex_unlock(&bus->lock);
>>>>> 	
>>>>> 	return ret;
>>>>>
>>>>>>  
>>>>>> -	if (old_freq < new_freq) {
>>>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>>> -		if (ret < 0) {
>>>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>>>> -			goto out;
>>>>>> -		}
>>>>>> -	}
>>>>>> -
>>>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>>>> -	if (ret < 0) {
>>>>>> -		dev_err(dev, "failed to change clock of bus\n");
>>>>>> -		clk_set_rate(bus->clk, old_freq);
>>>>>> -		goto out;
>>>>>> -	}
>>>>>> -
>>>>>> -	if (old_freq > new_freq) {
>>>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>>> -		if (ret < 0) {
>>>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>>>> -			goto out;
>>>>>> -		}
>>>>>> -	}
>>>>>> -	bus->curr_freq = new_freq;
>>>>>> -
>>>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>>>> -out:
>>>>>>  	mutex_unlock(&bus->lock);
>>>>>>  
>>>>>>  	return ret;
>>>>>> @@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
>>>>>>  	if (ret < 0)
>>>>>>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>>>>  
>>>>>> -	if (bus->regulator)
>>>>>> -		regulator_disable(bus->regulator);
>>>>>> +	if (bus->opp_table)
>>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>>
>>>>> Have to disable regulator after disabling the clock
>>>>> to prevent the h/w fault.
>>>>>
>>>>> I think that you should call them with following sequence:
>>>>>
>>>>> 	clk_disable_unprepare(bus->clk);
>>>>> 	if (bus->opp_table)
>>>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>>>> 	dev_pm_opp_of_remove_table(dev);
>>>>>
>>>>>>  
>>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>>> +
>>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>>  }
>>>>>>  
>>>>>> @@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>>>>  {
>>>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>>  	struct dev_pm_opp *new_opp;
>>>>>> -	unsigned long old_freq, new_freq;
>>>>>> -	int ret = 0;
>>>>>> +	int ret;
>>>>>>  
>>>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>>>> +	/*
>>>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>>>> +	 * *freq to correct value.
>>>>>> +	 */
>>>>>
>>>>> You better to change this comment with following styles
>>>>> to keep the consistency:
>>>>>
>>>>> 	/* Get correct frequency for bus ... */
>>>>>
>>>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>>  	if (IS_ERR(new_opp)) {
>>>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>>>  		return PTR_ERR(new_opp);
>>>>>>  	}
>>>>>>  
>>>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>>>  	dev_pm_opp_put(new_opp);
>>>>>>  
>>>>>> -	old_freq = bus->curr_freq;
>>>>>> -
>>>>>> -	if (old_freq == new_freq)
>>>>>> -		return 0;
>>>>>> -
>>>>>>  	/* Change the frequency according to new OPP level */
>>>>>>  	mutex_lock(&bus->lock);
>>>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>>>> +	if (!ret)
>>>>>> +		bus->curr_freq = *freq;
>>>>>
>>>>> ditto. Have to print the error log, check above comment.
>>>>>
>>>>>>  
>>>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>>>> -	if (ret < 0) {
>>>>>> -		dev_err(dev, "failed to set the clock of bus\n");
>>>>>> -		goto out;
>>>>>> -	}
>>>>>> -
>>>>>> -	*freq = new_freq;
>>>>>> -	bus->curr_freq = new_freq;
>>>>>> -
>>>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>>>> -out:
>>>>>>  	mutex_unlock(&bus->lock);
>>>>>>  
>>>>>>  	return ret;
>>>>>> @@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>>  					struct exynos_bus *bus)
>>>>>>  {
>>>>>>  	struct device *dev = bus->dev;
>>>>>> -	int i, ret, count, size;
>>>>>> -
>>>>>> -	/* Get the regulator to provide each bus with the power */
>>>>>> -	bus->regulator = devm_regulator_get(dev, "vdd");
>>>>>> -	if (IS_ERR(bus->regulator)) {
>>>>>> -		dev_err(dev, "failed to get VDD regulator\n");
>>>>>> -		return PTR_ERR(bus->regulator);
>>>>>> -	}
>>>>>> -
>>>>>> -	ret = regulator_enable(bus->regulator);
>>>>>> -	if (ret < 0) {
>>>>>> -		dev_err(dev, "failed to enable VDD regulator\n");
>>>>>> -		return ret;
>>>>>> -	}
>>>>>> +	int i, count, size;
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Get the devfreq-event devices to get the current utilization of
>>>>>> @@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>>  	count = devfreq_event_get_edev_count(dev);
>>>>>>  	if (count < 0) {
>>>>>>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>>>>> -		ret = count;
>>>>>> -		goto err_regulator;
>>>>>> +		return count;
>>>>>>  	}
>>>>>> +
>>>>>>  	bus->edev_count = count;
>>>>>>  
>>>>>>  	size = sizeof(*bus->edev) * count;
>>>>>>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>>>>> -	if (!bus->edev) {
>>>>>> -		ret = -ENOMEM;
>>>>>> -		goto err_regulator;
>>>>>> -	}
>>>>>> +	if (!bus->edev)
>>>>>> +		return -ENOMEM;
>>>>>>  
>>>>>>  	for (i = 0; i < count; i++) {
>>>>>>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>>>>> -		if (IS_ERR(bus->edev[i])) {
>>>>>> -			ret = -EPROBE_DEFER;
>>>>>> -			goto err_regulator;
>>>>>> -		}
>>>>>> +		if (IS_ERR(bus->edev[i]))
>>>>>> +			return -EPROBE_DEFER;
>>>>>>  	}
>>>>>>  
>>>>>>  	/*
>>>>>> @@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>>>>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>>>>>>  
>>>>>> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>>>>> -					&bus->voltage_tolerance))
>>>>>> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>>>>> -
>>>>>>  	return 0;
>>>>>> -
>>>>>> -err_regulator:
>>>>>> -	regulator_disable(bus->regulator);
>>>>>> -
>>>>>> -	return ret;
>>>>>>  }
>>>>>>  
>>>>>>  static int exynos_bus_parse_of(struct device_node *np,
>>>>>> -			      struct exynos_bus *bus)
>>>>>> +			      struct exynos_bus *bus, bool passive)
>>>>>>  {
>>>>>>  	struct device *dev = bus->dev;
>>>>>> +	struct opp_table *opp_table;
>>>>>> +	const char *vdd = "vdd";
>>>>>>  	struct dev_pm_opp *opp;
>>>>>>  	unsigned long rate;
>>>>>>  	int ret;
>>>>>> @@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>  		return ret;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (!passive) {
>>>>>> +		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>>>> +		if (IS_ERR(opp_table)) {
>>>>>> +			ret = PTR_ERR(opp_table);
>>>>>> +			dev_err(dev, "failed to set regulators %d\n", ret);
>>>>>> +			goto err_clk;/
>>>>>> +		}
>>>>>> +
>>>>>> +		bus->opp_table = opp_table;
>>>>>> +	}
>>>>>
>>>>> This driver has exynos_bus_parent_parse_of() function for parent devfreq device.
>>>>> dev_pm_opp_set_regulators() have to be called in exynos_bus_parent_parse_of()
>>>>> because the regulator is only used by parent devfreq device.
>>>>
>>>> exynos_bus_parse_of() is called for all devfreq devices (including
>>>> parent) and (as you've noticed) the regulator should be enabled before
>>>> enabling clock (which is done in exynos_bus_parse_of()) so adding
>>>> extra argument to exynos_bus_parse_of() (like it is done currently in
>>>> the patch) 
>>>
>>> I think that this patch has still the problem about call sequence
>>> between clock and regulator as following:
>>
>> Yes, this should be fixed (though the wrong sequence between regulator
>> and clock handling is not introduced by the patchset itself and is present
>> in the original driver code).
>>
>>> 273         ret = clk_prepare_enable(bus->clk);                                     
>>> 274         if (ret < 0) {                                                          
>>> 275                 dev_err(dev, "failed to get enable clock\n");                   
>>> 276                 return ret;                                                     
>>> 277         }                                                                       
>>> 278                                                                                 
>>> 279         if (!passive) {                                                         
>>> 280                 opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);            
>>> 281                 if (IS_ERR(opp_table)) {                                        
>>> 282                         ret = PTR_ERR(opp_table);                               
>>> 283                         dev_err(dev, "failed to set regulators %d\n", ret);     
>>> 284                         goto err_clk;                                           
>>> 285                 }                                                               
>>> 286                                                                                 
>>> 287                 bus->opp_table = opp_table;                                     
>>> 288         }                   
>>>
>>> makes it possible to do the setup correctly without the need
>>>> of merging both functions into one huge function (which would be more
>>>> difficult to follow than two simpler functions IMHO). Is that approach
>>>> acceptable or do you prefer one big function?
>>>
>>> Actually, I don't force to make one function for both
>>> exynos_bus_parse_of() and exynos_bus_parent_parse_of().
>>>
>>> If we just keep this code, dev_pm_opp_set_regulators()
>>> should be handled in exynos_bus_parent_parse_of()
>>> because only parent devfreq device controls the regulator.
>>
>> Could your please explain rationale for this requirement (besides
>> function name)?
> 
> OK. I hope to satisfy the following requirements:
> 
> 1. Fix the sequence problem between clock and regulator for enabling them.
> 2. dev_pm_opp_set_regulator() have to be handled in exynos_bus_parent_parse_of()
>    instead of exynos_bus_parse_of() for only parent devfreq device.
> 3. exynos_bus_parse_of() have to handle the only common properties
>    of both parent devfreq device and passive devfreq device.
> 
>>
>> The patch adds 'bool passive' argument (which is set to false for
>> parent devfreq device and true for child devfreq device) to
>> exynos_bus_parse_of() (which is called for *all* devfreq devices
> 
> As I menteiond, exynos_bus_parse_of have to handle the only common
> properties of both parent device and passive device. 
> 
> I gathered the properties for parent device into exynos_bus_parent_parse_of()
> This way using 'bool passive' argument is not proper in exynos_bus_parse_of().
> 
> 
>> and is called before exynos_bus_parent_parse_of()) and there is
>> no hard requirement to call dev_pm_opp_set_regulators() in
>> exynos_bus_parent_parse_of() so after only changing the ordering
>> between regulator and clock handling the setup code should be
>> correct.
>>
>> [ Please note that this patch moves parent/child detection before
>>   exynos_bus_parse_of() call. ]
>>
>>> In order to keep the two functions, maybe have to change
>>> the call the sequence between exynos_bus_parse_of() and
>>> exynos_bus_parent_parse_of().
>>
>> Doesn't seem to be needed, care to explain it more?
> 
> In order to fix the sequence problem between clock and regulator
> with dev_pm_opp_set_regualtor() and want to keep two functions
> (exynos_bus_parent_parse_of() and exynos_bus_parse_of()),
> have to change the call order as following and then modify
> the exception handling code when error happen.
> 
> 	node = of_parse_phandle(dev->of_node, "devfreq", 0);                    
> 	if (node) {                                                             
> 		of_node_put(node);                                              
> 		passive = true
> 	}
> 
> 	if (!passive)	
> 		exynos_bus_parent_parse_of()
> 			dev_pm_opp_set_regulator
> 
> 	exynos_bus_parse_of()

OK. This seems like a solution.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>>
>>> Once again, I don't force any fixed method. I want to fix them
>>> with correct way.
>>>
>>>>
>>>>>> +
>>>>>>  	/* Get the freq and voltage from OPP table to scale the bus freq */
>>>>>>  	ret = dev_pm_opp_of_add_table(dev);
>>>>>>  	if (ret < 0) {
>>>>>>  		dev_err(dev, "failed to get OPP table\n");
>>>>>> -		goto err_clk;
>>>>>> +		goto err_regulator;
>>>>>>  	}
>>>>>>  
>>>>>>  	rate = clk_get_rate(bus->clk);
>>>>>> @@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>  		ret = PTR_ERR(opp);
>>>>>>  		goto err_opp;
>>>>>>  	}
>>>>>> +
>>>>>>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>>>  	dev_pm_opp_put(opp);
>>>>>>  
>>>>>> @@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>  
>>>>>>  err_opp:
>>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>>> +
>>>>>> +err_regulator:
>>>>>> +	if (bus->opp_table) {
>>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>>> +		bus->opp_table = NULL;
>>>>>> +	}
>>>>>
>>>>> As I mentioned above, it it wrong to call dev_pm_opp_put_regulators()
>>>>> after removing the opp_table by dev_pm_opp_of_remove_table().
>>>>>
>>>>>> +
>>>>>>  err_clk:
>>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>>  
>>>>>> @@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>>  	struct exynos_bus *bus;
>>>>>>  	int ret, max_state;
>>>>>>  	unsigned long min_freq, max_freq;
>>>>>> +	bool passive = false;
>>>>>>  
>>>>>>  	if (!np) {
>>>>>>  		dev_err(dev, "failed to find devicetree node\n");
>>>>>> @@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>>  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>>>>>  	if (!bus)
>>>>>>  		return -ENOMEM;
>>>>>> +
>>>>>>  	mutex_init(&bus->lock);
>>>>>>  	bus->dev = &pdev->dev;
>>>>>>  	platform_set_drvdata(pdev, bus);
>>>>>> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>>>> +	if (node) {
>>>>>> +		of_node_put(node);
>>>>>> +		passive = true;
>>>>>> +	}
>>>>>>  
>>>>>>  	/* Parse the device-tree to get the resource information */
>>>>>> -	ret = exynos_bus_parse_of(np, bus);
>>>>>> +	ret = exynos_bus_parse_of(np, bus, passive);
>>>>>>  	if (ret < 0)
>>>>>>  		return ret;
>>>>>>  
>>>>>> @@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>>  		goto err;
>>>>>>  	}
>>>>>>  
>>>>>> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>>>> -	if (node) {
>>>>>> -		of_node_put(node);
>>>>>> +	if (passive)
>>>>>>  		goto passive;
>>>>>> -	} else {
>>>>>> -		ret = exynos_bus_parent_parse_of(np, bus);
>>>>>> -	}
>>>>>> +
>>>>>> +	ret = exynos_bus_parent_parse_of(np, bus);
>>>>>>  
>>>>>
>>>>> Remove unneeded blank line.
>>>>>
>>>>>>  	if (ret < 0)
>>>>>>  		goto err;
>>>>>> @@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>>  
>>>>>>  err:
>>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>>> +	if (bus->opp_table) {
>>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>>> +		bus->opp_table = NULL;
>>>>>> +	}
>>>>>> +
>>>>>
>>>>> ditto.
>>>>> Have to disable regulator after disabling the clock
>>>>> to prevent the h/w fault.
>>>>>
>>>>> I think that you should call them with following sequence:
>>>>>
>>>>> 	clk_disable_unprepare(bus->clk);
>>>>> 	if (bus->opp_table)
>>>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>>>> 	dev_pm_opp_of_remove_table(dev);
>>>>>
>>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>>  
>>>>>>  	return ret;
>>>>
>>>> Best regards,
>>>> --
>>>> Bartlomiej Zolnierkiewicz
>>>> Samsung R&D Institute Poland
>>>> Samsung Electronics
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
