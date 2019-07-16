Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EC6A6E3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbfGPK7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 06:59:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56090 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbfGPK7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 06:59:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190716105940euoutp0133409911b22f069447c84838bc6cab5a~x3iFZGcxP3230132301euoutp01X
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 10:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190716105940euoutp0133409911b22f069447c84838bc6cab5a~x3iFZGcxP3230132301euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563274780;
        bh=j1vm47pO077UaRo/L7zcyCPJ4i3+xQKRoeSR6qhWXlU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Xu9N0A/4znjjTDdFIc/T06KDWAp1h2xsUhi2UTCZpnrmSenqQBtzJzVvhVbTz4wwa
         IoSB3DCFUx6lciYndd14PhlNJnSSqy6sdR+s4+4Q57IQ8YYsTb/9mr4OjrPWf8Qis3
         UP/QPcFmUttCXlu3DtYXLlv2Vf1Pe1uTFkQyFclE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716105939eucas1p1d819c04050425de3cf0beb7982027125~x3iErz_tG0327403274eucas1p1O;
        Tue, 16 Jul 2019 10:59:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 71.FE.04325.B1EAD2D5; Tue, 16
        Jul 2019 11:59:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716105938eucas1p2fef8a70ad880cf48c273768fc5b707a3~x3iD3g2p-1483114831eucas1p2L;
        Tue, 16 Jul 2019 10:59:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716105938eusmtrp133052bc980df447f01e4903fea59706e~x3iDpQZya2272822728eusmtrp1j;
        Tue, 16 Jul 2019 10:59:38 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-44-5d2dae1ba530
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 00.80.04140.A1EAD2D5; Tue, 16
        Jul 2019 11:59:38 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716105937eusmtip1b75fefdf26a3e94c7683877ca76203c1~x3iC6lnZj2032820328eusmtip1d;
        Tue, 16 Jul 2019 10:59:37 +0000 (GMT)
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
Message-ID: <3ba736fa-832c-a72c-e60b-f4328e54c524@samsung.com>
Date:   Tue, 16 Jul 2019 12:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5612547b-47c8-0dc4-cb3c-e972782d5a26@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH/d578ebtFD1yac5iRMU0fi4Vm9mZzWVmk0t06F216sh5y/UP
        0qpTdMGGYqWF6ginopIuK8fpRqdoilAucy1jZRQOnfPW9N/neZ7vd8/32R6OVHykXbkwTbSo
        1agjlIw9VWoabPGcesMzcMHTC1Nwx8B7GmcbW2icWv0X4bQ3n0lsNhtY/PB4L4uL3zyh8eOK
        iwzuTzEifN5cTeDrxhcsvtLRRuCu2HwG9/58SOD4KiOLLU+KKFzSY2JWOqoKswqRqlifxKhK
        Lh9V1X6pJFSpt/RIVd9ZRqj6i2dsZLfZrwgWI8L2i1pvvyD70NdXe8ioyhR00JJURhxDLeHJ
        yI4DwQfaC3KYZGTPKYR8BOmJWYRcDCB41XSWlYt+BCeakolRS2PqTVIe5CHIGTSP+PsQ1MUl
        2lROwhYY6q5AVnYW5kDGn3ZkFZFCKwWma120dcAIy+BUot4m4gU/KKg02ZgSZkGRrsnGk4QA
        6DYZaFnjCI0Zbykr2wn+cPd5LWtlUnCBZ2+zCZndIO72BVs8EJI4+JnYgOTcqyHfXMPI7ASf
        6m+xMk+D5jMnKdlwA8Ef3YcRdxmCvDOWEcdyuFffNhyDG14xF25WeMvtVfA6foiwtkFwgM4+
        RzmEA5wuPUfKbR50CQpZPRsMVw3M6NrkOwVkOlJmjjktc8w5mWPOyfy/9xKi9MhFjJEiQ0Rp
        kUY84CWpI6UYTYjXnr2RxWj4AZst9d/LUfXv3XVI4JByAt9QOT9QQav3S4ci6xBwpNKZ9/0+
        L1DBB6sPHRa1e3dpYyJEqQ5N5SilC39kXM92hRCijhbDRTFK1I5OCc7O9RjKuWPxH6RxgkP6
        0lVGxcua8m+P9HYTF/elL/qVkZ3r6rOtfb1X+0DE5KAa51xWc3qO39fwx1rP3pNdG3Lvu61L
        NYxX7qvyqtCx7wJ0Lr7NvK5tedTMtJjNkx+ccE9Tza3Kkr768K2TZvescaxestM98MfWWI+s
        RxPXTl+/accSPpg+rKSkUPVCD1Irqf8BbQE+z3wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7pS63RjDSYuVLC4/uU5q8X8I+dY
        Lfr2/We06H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs3izY+zTBate4+wW/y7tpHFYvODY2wOgh5r5q1h9Ni0qpPNY/OSeo+D7/YwefRtWcXo
        cfzGdiaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DIeLXvAXLCnl7HiX+d2pgbGc9ldjJwcEgImEif71jN3MXJxCAksZZTYu62NvYuR
        AyghI3F8fRlEjbDEn2tdbBA1rxklFq3+yQ6SEBYIl/h1fxcjiC0ioCEx8+8VMJtZ4BKLRPP0
        UoiGD0wScxvegyXYBKwkJravArN5BewkVu45BmazCKhKbOw4BWaLCkRInHm/ggWiRlDi5Mwn
        YDangL3E7jsH2SEWqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKjfduxn1t2MHa9Cz7EKMDBqMTDe2KPTqwQa2JZ
        cWXuIUYJDmYlEV7br9qxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTER5JfGGpobmFpaG
        5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYGSonzAo6FZcjPf14tIb3F/v+0s9C
        01efE9HWWHzR6Hrm5uzrZw8/6y09Kn7EMXIV17KamQWXl+t51b5fknv4vHh44cbZEd9+b3ga
        94GvWp+9wO9viJDhwjPLFovKMU+aLHiS1+vlgriFz4N0/KK7LYWZdn24/aBz3/LpGi16706x
        P5nF58wjpsRSnJFoqMVcVJwIAPavALkMAwAA
X-CMS-MailID: 20190716105938eucas1p2fef8a70ad880cf48c273768fc5b707a3
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/16/19 12:33 PM, Chanwoo Choi wrote:
> Hi Bartlomiej,
> 
> On 19. 7. 16. 오후 7:13, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi Chanwoo,
>>
>> On 7/16/19 5:56 AM, Chanwoo Choi wrote:
>>> Hi Kamil,
>>>
>>> Looks good to me. But, this patch has some issue.
>>> I added the detailed reviews.
>>>
>>> I recommend that you make the separate patches as following
>>> in order to clarify the role of which apply the dev_pm_opp_* function.
>>>
>>> First patch,
>>> Need to consolidate the following two function into one function.
>>> because the original exynos-bus.c has the problem that the regulator
>>> of parent devfreq device have to be enabled before enabling the clock.
>>> This issue did not happen because bootloader enables the bus-related
>>> regulators before kernel booting.
>>> - exynos_bus_parse_of()
>>> - exynos_bus_parent_parse_of()
>>>> Second patch,
>>> Apply dev_pm_opp_set_regulators() and dev_pm_opp_set_rate()
>>>
>>>
>>> On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
>>>> Reuse opp core code for setting bus clock and voltage. As a side
>>>> effect this allow useage of coupled regulators feature (required
>>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>>> while the old code used regulator_set_voltage_tol() with fixed
>>>> tolerance. This patch also removes no longer needed parsing of DT
>>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>>> it).
>>>>
>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>> ---
>>>>  drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
>>>>  1 file changed, 66 insertions(+), 106 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>> index 486cc5b422f1..7fc4f76bd848 100644
>>>> --- a/drivers/devfreq/exynos-bus.c
>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>> @@ -25,7 +25,6 @@
>>>>  #include <linux/slab.h>
>>>>  
>>>>  #define DEFAULT_SATURATION_RATIO	40
>>>> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>>>>  
>>>>  struct exynos_bus {
>>>>  	struct device *dev;
>>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>>  
>>>>  	unsigned long curr_freq;
>>>>  
>>>> -	struct regulator *regulator;
>>>> +	struct opp_table *opp_table;
>>>> +
>>>>  	struct clk *clk;
>>>> -	unsigned int voltage_tolerance;
>>>>  	unsigned int ratio;
>>>>  };
>>>>  
>>>> @@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>>  {
>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>  	struct dev_pm_opp *new_opp;
>>>> -	unsigned long old_freq, new_freq, new_volt, tol;
>>>>  	int ret = 0;
>>>> -
>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>> +	/*
>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>> +	 * *freq to correct value.
>>>> +	 */
>>>
>>> You better to change this comment with following styles
>>> to keep the consistency:
>>>
>>> 	/* Get correct frequency for bus ... */
>>>
>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>  	if (IS_ERR(new_opp)) {
>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>  		return PTR_ERR(new_opp);
>>>>  	}
>>>>  
>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>>>>  	dev_pm_opp_put(new_opp);
>>>>  
>>>> -	old_freq = bus->curr_freq;
>>>> -
>>>> -	if (old_freq == new_freq)
>>>> -		return 0;
>>>> -	tol = new_volt * bus->voltage_tolerance / 100;
>>>> -
>>>>  	/* Change voltage and frequency according to new OPP level */
>>>>  	mutex_lock(&bus->lock);
>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>> +	if (!ret)
>>>> +		bus->curr_freq = *freq;
>>>
>>> Have to print the error log if ret has minus error value.
>>
>> dev_pm_opp_set_rate() should print the error message on all
>> errors so wouldn't printing the error log also here be superfluous?
>>
>> [ Please also note that the other user of dev_pm_opp_set_rate()
>>   (cpufreq-dt cpufreq driver) doesn't do this. ]
> 
> OK. Thanks for the explanation. 
> 
>>
>>> Modify it as following:
>>>
>>> 	if (ret < 0) {
>>> 		dev_err(dev, "failed to set bus rate\n");
>>> 		goto err:
>>> 	}
>>> 	bus->curr_freq = *freq;
>>>
>>> err:
>>> 	mutex_unlock(&bus->lock);
>>> 	
>>> 	return ret;
>>>
>>>>  
>>>> -	if (old_freq < new_freq) {
>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>> -		if (ret < 0) {
>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>> -			goto out;
>>>> -		}
>>>> -	}
>>>> -
>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>> -	if (ret < 0) {
>>>> -		dev_err(dev, "failed to change clock of bus\n");
>>>> -		clk_set_rate(bus->clk, old_freq);
>>>> -		goto out;
>>>> -	}
>>>> -
>>>> -	if (old_freq > new_freq) {
>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>> -		if (ret < 0) {
>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>> -			goto out;
>>>> -		}
>>>> -	}
>>>> -	bus->curr_freq = new_freq;
>>>> -
>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>> -out:
>>>>  	mutex_unlock(&bus->lock);
>>>>  
>>>>  	return ret;
>>>> @@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
>>>>  	if (ret < 0)
>>>>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>>  
>>>> -	if (bus->regulator)
>>>> -		regulator_disable(bus->regulator);
>>>> +	if (bus->opp_table)
>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>
>>> Have to disable regulator after disabling the clock
>>> to prevent the h/w fault.
>>>
>>> I think that you should call them with following sequence:
>>>
>>> 	clk_disable_unprepare(bus->clk);
>>> 	if (bus->opp_table)
>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>> 	dev_pm_opp_of_remove_table(dev);
>>>
>>>>  
>>>>  	dev_pm_opp_of_remove_table(dev);
>>>> +
>>>>  	clk_disable_unprepare(bus->clk);
>>>>  }
>>>>  
>>>> @@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>>  {
>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>  	struct dev_pm_opp *new_opp;
>>>> -	unsigned long old_freq, new_freq;
>>>> -	int ret = 0;
>>>> +	int ret;
>>>>  
>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>> +	/*
>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>> +	 * *freq to correct value.
>>>> +	 */
>>>
>>> You better to change this comment with following styles
>>> to keep the consistency:
>>>
>>> 	/* Get correct frequency for bus ... */
>>>
>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>  	if (IS_ERR(new_opp)) {
>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>  		return PTR_ERR(new_opp);
>>>>  	}
>>>>  
>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>  	dev_pm_opp_put(new_opp);
>>>>  
>>>> -	old_freq = bus->curr_freq;
>>>> -
>>>> -	if (old_freq == new_freq)
>>>> -		return 0;
>>>> -
>>>>  	/* Change the frequency according to new OPP level */
>>>>  	mutex_lock(&bus->lock);
>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>> +	if (!ret)
>>>> +		bus->curr_freq = *freq;
>>>
>>> ditto. Have to print the error log, check above comment.
>>>
>>>>  
>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>> -	if (ret < 0) {
>>>> -		dev_err(dev, "failed to set the clock of bus\n");
>>>> -		goto out;
>>>> -	}
>>>> -
>>>> -	*freq = new_freq;
>>>> -	bus->curr_freq = new_freq;
>>>> -
>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>> -out:
>>>>  	mutex_unlock(&bus->lock);
>>>>  
>>>>  	return ret;
>>>> @@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>  					struct exynos_bus *bus)
>>>>  {
>>>>  	struct device *dev = bus->dev;
>>>> -	int i, ret, count, size;
>>>> -
>>>> -	/* Get the regulator to provide each bus with the power */
>>>> -	bus->regulator = devm_regulator_get(dev, "vdd");
>>>> -	if (IS_ERR(bus->regulator)) {
>>>> -		dev_err(dev, "failed to get VDD regulator\n");
>>>> -		return PTR_ERR(bus->regulator);
>>>> -	}
>>>> -
>>>> -	ret = regulator_enable(bus->regulator);
>>>> -	if (ret < 0) {
>>>> -		dev_err(dev, "failed to enable VDD regulator\n");
>>>> -		return ret;
>>>> -	}
>>>> +	int i, count, size;
>>>>  
>>>>  	/*
>>>>  	 * Get the devfreq-event devices to get the current utilization of
>>>> @@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>  	count = devfreq_event_get_edev_count(dev);
>>>>  	if (count < 0) {
>>>>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>>> -		ret = count;
>>>> -		goto err_regulator;
>>>> +		return count;
>>>>  	}
>>>> +
>>>>  	bus->edev_count = count;
>>>>  
>>>>  	size = sizeof(*bus->edev) * count;
>>>>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>>> -	if (!bus->edev) {
>>>> -		ret = -ENOMEM;
>>>> -		goto err_regulator;
>>>> -	}
>>>> +	if (!bus->edev)
>>>> +		return -ENOMEM;
>>>>  
>>>>  	for (i = 0; i < count; i++) {
>>>>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>>> -		if (IS_ERR(bus->edev[i])) {
>>>> -			ret = -EPROBE_DEFER;
>>>> -			goto err_regulator;
>>>> -		}
>>>> +		if (IS_ERR(bus->edev[i]))
>>>> +			return -EPROBE_DEFER;
>>>>  	}
>>>>  
>>>>  	/*
>>>> @@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>>>>  
>>>> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>>> -					&bus->voltage_tolerance))
>>>> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>>> -
>>>>  	return 0;
>>>> -
>>>> -err_regulator:
>>>> -	regulator_disable(bus->regulator);
>>>> -
>>>> -	return ret;
>>>>  }
>>>>  
>>>>  static int exynos_bus_parse_of(struct device_node *np,
>>>> -			      struct exynos_bus *bus)
>>>> +			      struct exynos_bus *bus, bool passive)
>>>>  {
>>>>  	struct device *dev = bus->dev;
>>>> +	struct opp_table *opp_table;
>>>> +	const char *vdd = "vdd";
>>>>  	struct dev_pm_opp *opp;
>>>>  	unsigned long rate;
>>>>  	int ret;
>>>> @@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> +	if (!passive) {
>>>> +		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>> +		if (IS_ERR(opp_table)) {
>>>> +			ret = PTR_ERR(opp_table);
>>>> +			dev_err(dev, "failed to set regulators %d\n", ret);
>>>> +			goto err_clk;/
>>>> +		}
>>>> +
>>>> +		bus->opp_table = opp_table;
>>>> +	}
>>>
>>> This driver has exynos_bus_parent_parse_of() function for parent devfreq device.
>>> dev_pm_opp_set_regulators() have to be called in exynos_bus_parent_parse_of()
>>> because the regulator is only used by parent devfreq device.
>>
>> exynos_bus_parse_of() is called for all devfreq devices (including
>> parent) and (as you've noticed) the regulator should be enabled before
>> enabling clock (which is done in exynos_bus_parse_of()) so adding
>> extra argument to exynos_bus_parse_of() (like it is done currently in
>> the patch) 
> 
> I think that this patch has still the problem about call sequence
> between clock and regulator as following:

Yes, this should be fixed (though the wrong sequence between regulator
and clock handling is not introduced by the patchset itself and is present
in the original driver code).

> 273         ret = clk_prepare_enable(bus->clk);                                     
> 274         if (ret < 0) {                                                          
> 275                 dev_err(dev, "failed to get enable clock\n");                   
> 276                 return ret;                                                     
> 277         }                                                                       
> 278                                                                                 
> 279         if (!passive) {                                                         
> 280                 opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);            
> 281                 if (IS_ERR(opp_table)) {                                        
> 282                         ret = PTR_ERR(opp_table);                               
> 283                         dev_err(dev, "failed to set regulators %d\n", ret);     
> 284                         goto err_clk;                                           
> 285                 }                                                               
> 286                                                                                 
> 287                 bus->opp_table = opp_table;                                     
> 288         }                   
> 
> makes it possible to do the setup correctly without the need
>> of merging both functions into one huge function (which would be more
>> difficult to follow than two simpler functions IMHO). Is that approach
>> acceptable or do you prefer one big function?
> 
> Actually, I don't force to make one function for both
> exynos_bus_parse_of() and exynos_bus_parent_parse_of().
> 
> If we just keep this code, dev_pm_opp_set_regulators()
> should be handled in exynos_bus_parent_parse_of()
> because only parent devfreq device controls the regulator.

Could your please explain rationale for this requirement (besides
function name)?

The patch adds 'bool passive' argument (which is set to false for
parent devfreq device and true for child devfreq device) to
exynos_bus_parse_of() (which is called for *all* devfreq devices
and is called before exynos_bus_parent_parse_of()) and there is
no hard requirement to call dev_pm_opp_set_regulators() in
exynos_bus_parent_parse_of() so after only changing the ordering
between regulator and clock handling the setup code should be
correct.

[ Please note that this patch moves parent/child detection before
  exynos_bus_parse_of() call. ]

> In order to keep the two functions, maybe have to change
> the call the sequence between exynos_bus_parse_of() and
> exynos_bus_parent_parse_of().

Doesn't seem to be needed, care to explain it more?

> Once again, I don't force any fixed method. I want to fix them
> with correct way.
> 
>>
>>>> +
>>>>  	/* Get the freq and voltage from OPP table to scale the bus freq */
>>>>  	ret = dev_pm_opp_of_add_table(dev);
>>>>  	if (ret < 0) {
>>>>  		dev_err(dev, "failed to get OPP table\n");
>>>> -		goto err_clk;
>>>> +		goto err_regulator;
>>>>  	}
>>>>  
>>>>  	rate = clk_get_rate(bus->clk);
>>>> @@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>  		ret = PTR_ERR(opp);
>>>>  		goto err_opp;
>>>>  	}
>>>> +
>>>>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>  	dev_pm_opp_put(opp);
>>>>  
>>>> @@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>  
>>>>  err_opp:
>>>>  	dev_pm_opp_of_remove_table(dev);
>>>> +
>>>> +err_regulator:
>>>> +	if (bus->opp_table) {
>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>> +		bus->opp_table = NULL;
>>>> +	}
>>>
>>> As I mentioned above, it it wrong to call dev_pm_opp_put_regulators()
>>> after removing the opp_table by dev_pm_opp_of_remove_table().
>>>
>>>> +
>>>>  err_clk:
>>>>  	clk_disable_unprepare(bus->clk);
>>>>  
>>>> @@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>  	struct exynos_bus *bus;
>>>>  	int ret, max_state;
>>>>  	unsigned long min_freq, max_freq;
>>>> +	bool passive = false;
>>>>  
>>>>  	if (!np) {
>>>>  		dev_err(dev, "failed to find devicetree node\n");
>>>> @@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>>>  	if (!bus)
>>>>  		return -ENOMEM;
>>>> +
>>>>  	mutex_init(&bus->lock);
>>>>  	bus->dev = &pdev->dev;
>>>>  	platform_set_drvdata(pdev, bus);
>>>> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>> +	if (node) {
>>>> +		of_node_put(node);
>>>> +		passive = true;
>>>> +	}
>>>>  
>>>>  	/* Parse the device-tree to get the resource information */
>>>> -	ret = exynos_bus_parse_of(np, bus);
>>>> +	ret = exynos_bus_parse_of(np, bus, passive);
>>>>  	if (ret < 0)
>>>>  		return ret;
>>>>  
>>>> @@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>  		goto err;
>>>>  	}
>>>>  
>>>> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>> -	if (node) {
>>>> -		of_node_put(node);
>>>> +	if (passive)
>>>>  		goto passive;
>>>> -	} else {
>>>> -		ret = exynos_bus_parent_parse_of(np, bus);
>>>> -	}
>>>> +
>>>> +	ret = exynos_bus_parent_parse_of(np, bus);
>>>>  
>>>
>>> Remove unneeded blank line.
>>>
>>>>  	if (ret < 0)
>>>>  		goto err;
>>>> @@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>  
>>>>  err:
>>>>  	dev_pm_opp_of_remove_table(dev);
>>>> +	if (bus->opp_table) {
>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>> +		bus->opp_table = NULL;
>>>> +	}
>>>> +
>>>
>>> ditto.
>>> Have to disable regulator after disabling the clock
>>> to prevent the h/w fault.
>>>
>>> I think that you should call them with following sequence:
>>>
>>> 	clk_disable_unprepare(bus->clk);
>>> 	if (bus->opp_table)
>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>> 	dev_pm_opp_of_remove_table(dev);
>>>
>>>>  	clk_disable_unprepare(bus->clk);
>>>>  
>>>>  	return ret;
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
