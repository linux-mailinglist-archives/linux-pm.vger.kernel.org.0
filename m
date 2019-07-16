Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D456A68D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfGPKae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 06:30:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57455 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfGPKad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 06:30:33 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716103029epoutp039c704a7dda7c8d1ff53a5078bdda3667~x3Ims2gxI1387613876epoutp03F
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 10:30:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716103029epoutp039c704a7dda7c8d1ff53a5078bdda3667~x3Ims2gxI1387613876epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563273029;
        bh=0la4959LQEJaeIbv4dnhP5+dB37xO06dlNWQF9Deo0Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Eb2Xj+o11ox0ocM9ugHFJYrYAPZAsL+RaHDknQ4HV4mwbylGaQAKoIDvzw6Aa5tJx
         KqPKJPg6vRrYXBIrZOIRchA7vRuIJe1/Be7bWPWNQQuBiIFTdEk6xvlN5C6+kCejIG
         nmt3N1nomVajHBoe4nyKxbCXBGKGpgOkHxWAMjYk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716103028epcas1p340ec8ce0eb460d1d4d322bc69d9e893a~x3Il9Qsc52889728897epcas1p3a;
        Tue, 16 Jul 2019 10:30:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nxVp0qH7zMqYkf; Tue, 16 Jul
        2019 10:30:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.B4.04085.247AD2D5; Tue, 16 Jul 2019 19:30:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716103025epcas1p24865aaa2eaf832d628ece45b6d122c22~x3IjDt5VX2449424494epcas1p2E;
        Tue, 16 Jul 2019 10:30:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716103025epsmtrp2de8e5fe8cba8477ae1a39641bb86e696~x3IjCuFFw2690126901epsmtrp2T;
        Tue, 16 Jul 2019 10:30:25 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-58-5d2da742115d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.19.03638.147AD2D5; Tue, 16 Jul 2019 19:30:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716103025epsmtip1a11bfadec464bb7b72c967be7d2b5495~x3IitLbgY2084720847epsmtip1g;
        Tue, 16 Jul 2019 10:30:25 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5612547b-47c8-0dc4-cb3c-e972782d5a26@samsung.com>
Date:   Tue, 16 Jul 2019 19:33:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3d1687b7-4825-ad82-2706-a712c30e530b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUyTVxT2vl8tjLpLQTkjbsPXmQUcwisWL0Rk2Yxpgj9I/OG2jHRv4Kat
        9Gt9ix9b4scIk7KtOBzEVQGTaWAIERG/CKUba3CaIBiD4geOiInGdYglTiOGre07M/4955zn
        uec8596rZfX3hHSt1eGhbodsE4VE7uxvmTnZH7Rll+U+PsqRU4dO8qQ1dIUnvoF/EKmf+pMl
        IyPdGjL8VVhDeqau8+Ra3xGBzH4XQuTQyABDukITGnL8xlWG3N7XLpDw82GG1ARCGjJ//RRH
        Tk8OCe8nGztbOpGxp8MrGE8f22P8dbqfMfp6O5Dx4vg5xjjb81ap5pPK9RYqV1B3BnWUOyus
        DnORWLLF9KHJkJ8rZUsFZJ2Y4ZDttEjcuLk0e5PVFnUgZmyXbVXRVKmsKGLOhvVuZ5WHZlic
        iqdIpK4Km6vAtVqR7UqVw7y63GkvlHJz1xiixM8qLd7qJuQK70M7xwJ0L+qX61CCFvBa8DV1
        CHUoUavH5xH8Emlh1SCCoHFkAqnB3wgOz7SxryRtNX5GLQQQNB/x8WrwGMHYN7VCjJWCt8KL
        P/pQDKdiAl3tf3ExEotHORg6cZuPFQScBcGH43HB63g5jD2figt0eAN4Aye4GObwSrjbMBPn
        L8EfweVQC6dykuHSj/fjOAEXQ934g/h4LE6DW/dbGRW/DdVnDscNAR7SwHT3HKN62AjhSBCp
        OAUeXezVqDgdZqcDgoq/hJ8vhQRVXIugNzjKq4U8CB4/GD1IG+2QCSf7ctT0crgw14zUxoth
        +um3fIwCWAe1X+tVygq4Njnx3whvwE/7vcIBJPoX2PEvsOBfYMH/f7OjiOtAS6lLsZupIrkM
        C++7B8Xfd1bBeTR0ZfMgwlokJul+73+vTM/L25Vd9kEEWlZM1RU9XVWm11XIu76gbqfJXWWj
        yiAyRLf9PZu+pNwZ/S0Oj0kyrMnLyyNrpXyDJIlpupaXmWV6bJY9tJJSF3W/0jHahPS9yEAb
        d3bt3nFBaL6zcrjyU29aw7pzfnyv4B2x+1jxx+3bRiNJJeLBmXx2E+/cVt/6ZGCucUWrOP8i
        RRwsrVlmWMQ+PJtUfGDcl/zDo8InJftl15s7qDW8qFih85OmtpvVwc8Tm5ZBauGZhohl3ty5
        5dnioLUzMe2uX7Oqnnlt67sip1hkKYt1K/K/aDXyCPUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnK7jct1Ygx3/5Cw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APYoLpuU1JzMstQifbsErozO5mmMBW8aGSuu7k1tYNyT2MXIySEhYCKxvHUW
        UxcjF4eQwG5GiVMnvrFCJCQlpl08ytzFyAFkC0scPlwMUfOWUWL2wn9sIDXCAuESv+7vYgSx
        RQQsJNaueMsCYjMLXGKRaJ5eCjWUSWLextvMIAk2AS2J/S9ugDXzCyhKXP3xGKyZV8BOonPv
        arBmFgFViXuTPoAdISoQITHp2k4WiBpBiZMzn4DZnAL2El03njNDLFOX+DPvEpQtLnHryXwm
        CFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBEexltYOxhMn4g8xCnAwKvHwntijEyvEmlhWXJl7iFGCg1lJhNf2q3asEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBsa41p8RhmfFCkquZ/gu/xO9
        THSl1kbOezObjBiLZG/YP59j3jbfeoH3j2OBJtc1w+6cftC9knOJ5yehsqSoEsOAe3d8v/3k
        mXP63cGDszR2i7vkLnw5T1ZB6Kp7Ydjs4u0F31NWheT8Xy4l8dCm/NrTWRXHcsodIm69PXVv
        7f6AR0c9uWOmntigxFKckWioxVxUnAgASYH1ht4CAAA=
X-CMS-MailID: 20190716103025epcas1p24865aaa2eaf832d628ece45b6d122c22
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
        <7f7cf551-005a-c647-d571-77eb5426478a@samsung.com>
        <3d1687b7-4825-ad82-2706-a712c30e530b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartlomiej,

On 19. 7. 16. 오후 7:13, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On 7/16/19 5:56 AM, Chanwoo Choi wrote:
>> Hi Kamil,
>>
>> Looks good to me. But, this patch has some issue.
>> I added the detailed reviews.
>>
>> I recommend that you make the separate patches as following
>> in order to clarify the role of which apply the dev_pm_opp_* function.
>>
>> First patch,
>> Need to consolidate the following two function into one function.
>> because the original exynos-bus.c has the problem that the regulator
>> of parent devfreq device have to be enabled before enabling the clock.
>> This issue did not happen because bootloader enables the bus-related
>> regulators before kernel booting.
>> - exynos_bus_parse_of()
>> - exynos_bus_parent_parse_of()
>>> Second patch,
>> Apply dev_pm_opp_set_regulators() and dev_pm_opp_set_rate()
>>
>>
>> On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
>>> Reuse opp core code for setting bus clock and voltage. As a side
>>> effect this allow useage of coupled regulators feature (required
>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>> while the old code used regulator_set_voltage_tol() with fixed
>>> tolerance. This patch also removes no longer needed parsing of DT
>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>> it).
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
>>>  1 file changed, 66 insertions(+), 106 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 486cc5b422f1..7fc4f76bd848 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -25,7 +25,6 @@
>>>  #include <linux/slab.h>
>>>  
>>>  #define DEFAULT_SATURATION_RATIO	40
>>> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>>>  
>>>  struct exynos_bus {
>>>  	struct device *dev;
>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>  
>>>  	unsigned long curr_freq;
>>>  
>>> -	struct regulator *regulator;
>>> +	struct opp_table *opp_table;
>>> +
>>>  	struct clk *clk;
>>> -	unsigned int voltage_tolerance;
>>>  	unsigned int ratio;
>>>  };
>>>  
>>> @@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>  {
>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>  	struct dev_pm_opp *new_opp;
>>> -	unsigned long old_freq, new_freq, new_volt, tol;
>>>  	int ret = 0;
>>> -
>>> -	/* Get new opp-bus instance according to new bus clock */
>>> +	/*
>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>> +	 * *freq to correct value.
>>> +	 */
>>
>> You better to change this comment with following styles
>> to keep the consistency:
>>
>> 	/* Get correct frequency for bus ... */
>>
>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>  	if (IS_ERR(new_opp)) {
>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>  		return PTR_ERR(new_opp);
>>>  	}
>>>  
>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>>>  	dev_pm_opp_put(new_opp);
>>>  
>>> -	old_freq = bus->curr_freq;
>>> -
>>> -	if (old_freq == new_freq)
>>> -		return 0;
>>> -	tol = new_volt * bus->voltage_tolerance / 100;
>>> -
>>>  	/* Change voltage and frequency according to new OPP level */
>>>  	mutex_lock(&bus->lock);
>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>> +	if (!ret)
>>> +		bus->curr_freq = *freq;
>>
>> Have to print the error log if ret has minus error value.
> 
> dev_pm_opp_set_rate() should print the error message on all
> errors so wouldn't printing the error log also here be superfluous?
> 
> [ Please also note that the other user of dev_pm_opp_set_rate()
>   (cpufreq-dt cpufreq driver) doesn't do this. ]

OK. Thanks for the explanation. 

> 
>> Modify it as following:
>>
>> 	if (ret < 0) {
>> 		dev_err(dev, "failed to set bus rate\n");
>> 		goto err:
>> 	}
>> 	bus->curr_freq = *freq;
>>
>> err:
>> 	mutex_unlock(&bus->lock);
>> 	
>> 	return ret;
>>
>>>  
>>> -	if (old_freq < new_freq) {
>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>> -		if (ret < 0) {
>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>> -			goto out;
>>> -		}
>>> -	}
>>> -
>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "failed to change clock of bus\n");
>>> -		clk_set_rate(bus->clk, old_freq);
>>> -		goto out;
>>> -	}
>>> -
>>> -	if (old_freq > new_freq) {
>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>> -		if (ret < 0) {
>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>> -			goto out;
>>> -		}
>>> -	}
>>> -	bus->curr_freq = new_freq;
>>> -
>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>> -out:
>>>  	mutex_unlock(&bus->lock);
>>>  
>>>  	return ret;
>>> @@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
>>>  	if (ret < 0)
>>>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>  
>>> -	if (bus->regulator)
>>> -		regulator_disable(bus->regulator);
>>> +	if (bus->opp_table)
>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>
>> Have to disable regulator after disabling the clock
>> to prevent the h/w fault.
>>
>> I think that you should call them with following sequence:
>>
>> 	clk_disable_unprepare(bus->clk);
>> 	if (bus->opp_table)
>> 		dev_pm_opp_put_regulators(bus->opp_table);
>> 	dev_pm_opp_of_remove_table(dev);
>>
>>>  
>>>  	dev_pm_opp_of_remove_table(dev);
>>> +
>>>  	clk_disable_unprepare(bus->clk);
>>>  }
>>>  
>>> @@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>  {
>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>  	struct dev_pm_opp *new_opp;
>>> -	unsigned long old_freq, new_freq;
>>> -	int ret = 0;
>>> +	int ret;
>>>  
>>> -	/* Get new opp-bus instance according to new bus clock */
>>> +	/*
>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>> +	 * *freq to correct value.
>>> +	 */
>>
>> You better to change this comment with following styles
>> to keep the consistency:
>>
>> 	/* Get correct frequency for bus ... */
>>
>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>  	if (IS_ERR(new_opp)) {
>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>  		return PTR_ERR(new_opp);
>>>  	}
>>>  
>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>  	dev_pm_opp_put(new_opp);
>>>  
>>> -	old_freq = bus->curr_freq;
>>> -
>>> -	if (old_freq == new_freq)
>>> -		return 0;
>>> -
>>>  	/* Change the frequency according to new OPP level */
>>>  	mutex_lock(&bus->lock);
>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>> +	if (!ret)
>>> +		bus->curr_freq = *freq;
>>
>> ditto. Have to print the error log, check above comment.
>>
>>>  
>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "failed to set the clock of bus\n");
>>> -		goto out;
>>> -	}
>>> -
>>> -	*freq = new_freq;
>>> -	bus->curr_freq = new_freq;
>>> -
>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>> -out:
>>>  	mutex_unlock(&bus->lock);
>>>  
>>>  	return ret;
>>> @@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  					struct exynos_bus *bus)
>>>  {
>>>  	struct device *dev = bus->dev;
>>> -	int i, ret, count, size;
>>> -
>>> -	/* Get the regulator to provide each bus with the power */
>>> -	bus->regulator = devm_regulator_get(dev, "vdd");
>>> -	if (IS_ERR(bus->regulator)) {
>>> -		dev_err(dev, "failed to get VDD regulator\n");
>>> -		return PTR_ERR(bus->regulator);
>>> -	}
>>> -
>>> -	ret = regulator_enable(bus->regulator);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "failed to enable VDD regulator\n");
>>> -		return ret;
>>> -	}
>>> +	int i, count, size;
>>>  
>>>  	/*
>>>  	 * Get the devfreq-event devices to get the current utilization of
>>> @@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  	count = devfreq_event_get_edev_count(dev);
>>>  	if (count < 0) {
>>>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>> -		ret = count;
>>> -		goto err_regulator;
>>> +		return count;
>>>  	}
>>> +
>>>  	bus->edev_count = count;
>>>  
>>>  	size = sizeof(*bus->edev) * count;
>>>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>> -	if (!bus->edev) {
>>> -		ret = -ENOMEM;
>>> -		goto err_regulator;
>>> -	}
>>> +	if (!bus->edev)
>>> +		return -ENOMEM;
>>>  
>>>  	for (i = 0; i < count; i++) {
>>>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>> -		if (IS_ERR(bus->edev[i])) {
>>> -			ret = -EPROBE_DEFER;
>>> -			goto err_regulator;
>>> -		}
>>> +		if (IS_ERR(bus->edev[i]))
>>> +			return -EPROBE_DEFER;
>>>  	}
>>>  
>>>  	/*
>>> @@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>>>  
>>> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>> -					&bus->voltage_tolerance))
>>> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>> -
>>>  	return 0;
>>> -
>>> -err_regulator:
>>> -	regulator_disable(bus->regulator);
>>> -
>>> -	return ret;
>>>  }
>>>  
>>>  static int exynos_bus_parse_of(struct device_node *np,
>>> -			      struct exynos_bus *bus)
>>> +			      struct exynos_bus *bus, bool passive)
>>>  {
>>>  	struct device *dev = bus->dev;
>>> +	struct opp_table *opp_table;
>>> +	const char *vdd = "vdd";
>>>  	struct dev_pm_opp *opp;
>>>  	unsigned long rate;
>>>  	int ret;
>>> @@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>  		return ret;
>>>  	}
>>>  
>>> +	if (!passive) {
>>> +		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>> +		if (IS_ERR(opp_table)) {
>>> +			ret = PTR_ERR(opp_table);
>>> +			dev_err(dev, "failed to set regulators %d\n", ret);
>>> +			goto err_clk;/
>>> +		}
>>> +
>>> +		bus->opp_table = opp_table;
>>> +	}
>>
>> This driver has exynos_bus_parent_parse_of() function for parent devfreq device.
>> dev_pm_opp_set_regulators() have to be called in exynos_bus_parent_parse_of()
>> because the regulator is only used by parent devfreq device.
> 
> exynos_bus_parse_of() is called for all devfreq devices (including
> parent) and (as you've noticed) the regulator should be enabled before
> enabling clock (which is done in exynos_bus_parse_of()) so adding
> extra argument to exynos_bus_parse_of() (like it is done currently in
> the patch) 

I think that this patch has still the problem about call sequence
between clock and regulator as following:

273         ret = clk_prepare_enable(bus->clk);                                     
274         if (ret < 0) {                                                          
275                 dev_err(dev, "failed to get enable clock\n");                   
276                 return ret;                                                     
277         }                                                                       
278                                                                                 
279         if (!passive) {                                                         
280                 opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);            
281                 if (IS_ERR(opp_table)) {                                        
282                         ret = PTR_ERR(opp_table);                               
283                         dev_err(dev, "failed to set regulators %d\n", ret);     
284                         goto err_clk;                                           
285                 }                                                               
286                                                                                 
287                 bus->opp_table = opp_table;                                     
288         }                   

makes it possible to do the setup correctly without the need
> of merging both functions into one huge function (which would be more
> difficult to follow than two simpler functions IMHO). Is that approach
> acceptable or do you prefer one big function?

Actually, I don't force to make one function for both
exynos_bus_parse_of() and exynos_bus_parent_parse_of().

If we just keep this code, dev_pm_opp_set_regulators()
should be handled in exynos_bus_parent_parse_of()
because only parent devfreq device controls the regulator.

In order to keep the two functions, maybe have to change
the call the sequence between exynos_bus_parse_of() and
exynos_bus_parent_parse_of().

Once again, I don't force any fixed method. I want to fix them
with correct way.

> 
>>> +
>>>  	/* Get the freq and voltage from OPP table to scale the bus freq */
>>>  	ret = dev_pm_opp_of_add_table(dev);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "failed to get OPP table\n");
>>> -		goto err_clk;
>>> +		goto err_regulator;
>>>  	}
>>>  
>>>  	rate = clk_get_rate(bus->clk);
>>> @@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>  		ret = PTR_ERR(opp);
>>>  		goto err_opp;
>>>  	}
>>> +
>>>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>  	dev_pm_opp_put(opp);
>>>  
>>> @@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>  
>>>  err_opp:
>>>  	dev_pm_opp_of_remove_table(dev);
>>> +
>>> +err_regulator:
>>> +	if (bus->opp_table) {
>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>> +		bus->opp_table = NULL;
>>> +	}
>>
>> As I mentioned above, it it wrong to call dev_pm_opp_put_regulators()
>> after removing the opp_table by dev_pm_opp_of_remove_table().
>>
>>> +
>>>  err_clk:
>>>  	clk_disable_unprepare(bus->clk);
>>>  
>>> @@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	struct exynos_bus *bus;
>>>  	int ret, max_state;
>>>  	unsigned long min_freq, max_freq;
>>> +	bool passive = false;
>>>  
>>>  	if (!np) {
>>>  		dev_err(dev, "failed to find devicetree node\n");
>>> @@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>>  	if (!bus)
>>>  		return -ENOMEM;
>>> +
>>>  	mutex_init(&bus->lock);
>>>  	bus->dev = &pdev->dev;
>>>  	platform_set_drvdata(pdev, bus);
>>> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>> +	if (node) {
>>> +		of_node_put(node);
>>> +		passive = true;
>>> +	}
>>>  
>>>  	/* Parse the device-tree to get the resource information */
>>> -	ret = exynos_bus_parse_of(np, bus);
>>> +	ret = exynos_bus_parse_of(np, bus, passive);
>>>  	if (ret < 0)
>>>  		return ret;
>>>  
>>> @@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  		goto err;
>>>  	}
>>>  
>>> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>> -	if (node) {
>>> -		of_node_put(node);
>>> +	if (passive)
>>>  		goto passive;
>>> -	} else {
>>> -		ret = exynos_bus_parent_parse_of(np, bus);
>>> -	}
>>> +
>>> +	ret = exynos_bus_parent_parse_of(np, bus);
>>>  
>>
>> Remove unneeded blank line.
>>
>>>  	if (ret < 0)
>>>  		goto err;
>>> @@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  
>>>  err:
>>>  	dev_pm_opp_of_remove_table(dev);
>>> +	if (bus->opp_table) {
>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>> +		bus->opp_table = NULL;
>>> +	}
>>> +
>>
>> ditto.
>> Have to disable regulator after disabling the clock
>> to prevent the h/w fault.
>>
>> I think that you should call them with following sequence:
>>
>> 	clk_disable_unprepare(bus->clk);
>> 	if (bus->opp_table)
>> 		dev_pm_opp_put_regulators(bus->opp_table);
>> 	dev_pm_opp_of_remove_table(dev);
>>
>>>  	clk_disable_unprepare(bus->clk);
>>>  
>>>  	return ret;
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
