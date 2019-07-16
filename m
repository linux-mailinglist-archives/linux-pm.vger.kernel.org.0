Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541336A769
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfGPLXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:23:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30105 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbfGPLXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:23:52 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716112349epoutp040659a5354a6df02d58b793ab24e0689b~x33KmClyZ1772617726epoutp04J
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:23:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716112349epoutp040659a5354a6df02d58b793ab24e0689b~x33KmClyZ1772617726epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563276229;
        bh=CKB1e2isOLxF66j2/eCxbJDSalbr3NE7/La/WhR+j24=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F6RHUmAVUiv+OxbTh0aQ8+hwjRj3XTYUyKKKXrezrcK071uH7UwHoBdp+H2l64z4e
         5eunIdgKXccJKginNkIWhN8/2eRn2HR65G89EZMswlj1apF0HL6AjkF8+IJoiLwvMa
         GQ4sRn1cdiNcGn7LLGyDBrbSEp6fJNC89e3M7zkQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716112348epcas1p35988781ef5657a148a0bb1e21558de5d~x33JuBRxC0519105191epcas1p3m;
        Tue, 16 Jul 2019 11:23:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nyhC3NxQzMqYkV; Tue, 16 Jul
        2019 11:23:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.2B.04160.BB3BD2D5; Tue, 16 Jul 2019 20:23:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716112338epcas1p27572fa536e769c6fce6126ef12752336~x33AyTczs0106301063epcas1p2P;
        Tue, 16 Jul 2019 11:23:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716112338epsmtrp2306563007682b2a1be921d7d66e9a8f4~x33AwuJn82404724047epsmtrp2H;
        Tue, 16 Jul 2019 11:23:38 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-4d-5d2db3bb7f37
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.2C.03706.AB3BD2D5; Tue, 16 Jul 2019 20:23:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716112338epsmtip2e323e5e758a74bf95d2197407f6a83cf~x33Af4jFb0406804068epsmtip2U;
        Tue, 16 Jul 2019 11:23:38 +0000 (GMT)
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
Message-ID: <29cfafc4-ee22-6d38-4c67-776c48bfed8a@samsung.com>
Date:   Tue, 16 Jul 2019 20:26:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3ba736fa-832c-a72c-e60b-f4328e54c524@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmge7uzbqxBl1nxCw2zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZ/xpXMBbsmMtY0fD+AHsD48aKLkYODgkBE4nfP7S6GLk4hAR2MEqcPbuH
        BcL5xCix8vRaZgjnG6PEt/cNjF2MnGAduzZNZoJI7GWU2Dn3MjtIQkjgPaPE7TfaILawQLjE
        r/u7wBpEBCwk1q54CzaWWeACi8Sx1bdZQRJsAloS+1/cYAOx+QUUJa7+eAzWwCtgJ7Ho2nkW
        EJtFQFVi44R7YLaoQITEqSPzWCBqBCVOznwCZnMK2Es8OPodrJdZQFzi1pP5TBC2vETz1tlg
        L0gInGKX6D//kQ3iBReJa+0rWSBsYYlXx7ewQ9hSEp/f7YWqqZZYefIIG0RzB6PElv0XWCES
        xhL7l4L8zwG0QVNi/S59iLCixM7fc6GO4JN497WHFRLAvBIdbUIQJcoSlx/cZYKwJSUWt3ey
        TWBUmoXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwQY7uTYzg5K1lsYNxzzmfQ4wCHIxK
        PLwn9ujECrEmlhVX5h5ilOBgVhLhtf2qHSvEm5JYWZValB9fVJqTWnyI0RQY2hOZpUST84GZ
        Ja8k3tDUyNjY2MLE0MzU0FBJnHfeH81YIYH0xJLU7NTUgtQimD4mDk6pBsaM/wYq3rPq2I51
        3Fu46P6Wn5fsb7BMbs85+MjU9cae9fOYXolZ25/Q2zjhnVnyzNuhu3NWbNCZaPVpI8MxXe/U
        l6rn5qet2R5XxLJvWuH3rq8Hv2RUM0Z9DjvHLJbSu75z6mUm9xXnlQWyftoxaMxYrCH/2m25
        c1bWr81xX3842GZJq+lHppsrsRRnJBpqMRcVJwIAnH14WfQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO6uzbqxBrfeKFhsnLGe1WL+kXOs
        Fn37/jNa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i6XXLzJZ
        3G5cwWbx5sdZJovWvUfYLf5d28hisfnBMTYHQY8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0
        OH5jO5PH501yAexRXDYpqTmZZalF+nYJXBn/GlcwFuyYy1jR8P4AewPjxoouRk4OCQETiV2b
        JjN1MXJxCAnsZpT4MvEjG0RCUmLaxaPMXYwcQLawxOHDxRA1bxklvp5pZgKpERYIl/h1fxcj
        iC0iYCGxdsVbFhCbWeASi0Tz9FKIhqXMEo8XvmQGSbAJaEnsf3EDbAG/gKLE1R+PwZp5Bewk
        Fl07D9bMIqAqsXHCPTBbVCBCYtK1nSwQNYISJ2c+AbM5BewlHhz9zgixTF3iz7xLzBC2uMSt
        J/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqX
        rpecn7uJERzHWpo7GC8viT/EKMDBqMTDe2KPTqwQa2JZcWXuIUYJDmYlEV7br9qxQrwpiZVV
        qUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTCyh00oPdtjUFFu9ej+
        1lPMYd9+zNUqtUr6a3//6LIPxzw2XHjgHRjGdnSDSa9ZzLJ3k/S8PKtX5Tbw2z4LyD36cb5m
        2dNcuRRD06ZpGT92aCmkqzIXrI1JeFEktKDDR7laufhk4c+/ZUf3nTPzFW4557DkXXZ7znGZ
        aVoyrv6WUoGPv0dH71NiKc5INNRiLipOBAAVwoCH3wIAAA==
X-CMS-MailID: 20190716112338epcas1p27572fa536e769c6fce6126ef12752336
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
        <5612547b-47c8-0dc4-cb3c-e972782d5a26@samsung.com>
        <3ba736fa-832c-a72c-e60b-f4328e54c524@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 16. 오후 7:59, Bartlomiej Zolnierkiewicz wrote:
> 
> On 7/16/19 12:33 PM, Chanwoo Choi wrote:
>> Hi Bartlomiej,
>>
>> On 19. 7. 16. 오후 7:13, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi Chanwoo,
>>>
>>> On 7/16/19 5:56 AM, Chanwoo Choi wrote:
>>>> Hi Kamil,
>>>>
>>>> Looks good to me. But, this patch has some issue.
>>>> I added the detailed reviews.
>>>>
>>>> I recommend that you make the separate patches as following
>>>> in order to clarify the role of which apply the dev_pm_opp_* function.
>>>>
>>>> First patch,
>>>> Need to consolidate the following two function into one function.
>>>> because the original exynos-bus.c has the problem that the regulator
>>>> of parent devfreq device have to be enabled before enabling the clock.
>>>> This issue did not happen because bootloader enables the bus-related
>>>> regulators before kernel booting.
>>>> - exynos_bus_parse_of()
>>>> - exynos_bus_parent_parse_of()
>>>>> Second patch,
>>>> Apply dev_pm_opp_set_regulators() and dev_pm_opp_set_rate()
>>>>
>>>>
>>>> On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
>>>>> Reuse opp core code for setting bus clock and voltage. As a side
>>>>> effect this allow useage of coupled regulators feature (required
>>>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>>>> while the old code used regulator_set_voltage_tol() with fixed
>>>>> tolerance. This patch also removes no longer needed parsing of DT
>>>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>>>> it).
>>>>>
>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>> ---
>>>>>  drivers/devfreq/exynos-bus.c | 172 ++++++++++++++---------------------
>>>>>  1 file changed, 66 insertions(+), 106 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>> index 486cc5b422f1..7fc4f76bd848 100644
>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>> @@ -25,7 +25,6 @@
>>>>>  #include <linux/slab.h>
>>>>>  
>>>>>  #define DEFAULT_SATURATION_RATIO	40
>>>>> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>>>>>  
>>>>>  struct exynos_bus {
>>>>>  	struct device *dev;
>>>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>>>  
>>>>>  	unsigned long curr_freq;
>>>>>  
>>>>> -	struct regulator *regulator;
>>>>> +	struct opp_table *opp_table;
>>>>> +
>>>>>  	struct clk *clk;
>>>>> -	unsigned int voltage_tolerance;
>>>>>  	unsigned int ratio;
>>>>>  };
>>>>>  
>>>>> @@ -99,56 +98,25 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>>>  {
>>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>  	struct dev_pm_opp *new_opp;
>>>>> -	unsigned long old_freq, new_freq, new_volt, tol;
>>>>>  	int ret = 0;
>>>>> -
>>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>>> +	/*
>>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>>> +	 * *freq to correct value.
>>>>> +	 */
>>>>
>>>> You better to change this comment with following styles
>>>> to keep the consistency:
>>>>
>>>> 	/* Get correct frequency for bus ... */
>>>>
>>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>  	if (IS_ERR(new_opp)) {
>>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>>  		return PTR_ERR(new_opp);
>>>>>  	}
>>>>>  
>>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>>>>>  	dev_pm_opp_put(new_opp);
>>>>>  
>>>>> -	old_freq = bus->curr_freq;
>>>>> -
>>>>> -	if (old_freq == new_freq)
>>>>> -		return 0;
>>>>> -	tol = new_volt * bus->voltage_tolerance / 100;
>>>>> -
>>>>>  	/* Change voltage and frequency according to new OPP level */
>>>>>  	mutex_lock(&bus->lock);
>>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>>> +	if (!ret)
>>>>> +		bus->curr_freq = *freq;
>>>>
>>>> Have to print the error log if ret has minus error value.
>>>
>>> dev_pm_opp_set_rate() should print the error message on all
>>> errors so wouldn't printing the error log also here be superfluous?
>>>
>>> [ Please also note that the other user of dev_pm_opp_set_rate()
>>>   (cpufreq-dt cpufreq driver) doesn't do this. ]
>>
>> OK. Thanks for the explanation. 
>>
>>>
>>>> Modify it as following:
>>>>
>>>> 	if (ret < 0) {
>>>> 		dev_err(dev, "failed to set bus rate\n");
>>>> 		goto err:
>>>> 	}
>>>> 	bus->curr_freq = *freq;
>>>>
>>>> err:
>>>> 	mutex_unlock(&bus->lock);
>>>> 	
>>>> 	return ret;
>>>>
>>>>>  
>>>>> -	if (old_freq < new_freq) {
>>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>> -		if (ret < 0) {
>>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>>> -			goto out;
>>>>> -		}
>>>>> -	}
>>>>> -
>>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>>> -	if (ret < 0) {
>>>>> -		dev_err(dev, "failed to change clock of bus\n");
>>>>> -		clk_set_rate(bus->clk, old_freq);
>>>>> -		goto out;
>>>>> -	}
>>>>> -
>>>>> -	if (old_freq > new_freq) {
>>>>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>> -		if (ret < 0) {
>>>>> -			dev_err(bus->dev, "failed to set voltage\n");
>>>>> -			goto out;
>>>>> -		}
>>>>> -	}
>>>>> -	bus->curr_freq = new_freq;
>>>>> -
>>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>>> -out:
>>>>>  	mutex_unlock(&bus->lock);
>>>>>  
>>>>>  	return ret;
>>>>> @@ -194,10 +162,11 @@ static void exynos_bus_exit(struct device *dev)
>>>>>  	if (ret < 0)
>>>>>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>>>  
>>>>> -	if (bus->regulator)
>>>>> -		regulator_disable(bus->regulator);
>>>>> +	if (bus->opp_table)
>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>
>>>> Have to disable regulator after disabling the clock
>>>> to prevent the h/w fault.
>>>>
>>>> I think that you should call them with following sequence:
>>>>
>>>> 	clk_disable_unprepare(bus->clk);
>>>> 	if (bus->opp_table)
>>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>>> 	dev_pm_opp_of_remove_table(dev);
>>>>
>>>>>  
>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>> +
>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>  }
>>>>>  
>>>>> @@ -209,39 +178,26 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>>>  {
>>>>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>  	struct dev_pm_opp *new_opp;
>>>>> -	unsigned long old_freq, new_freq;
>>>>> -	int ret = 0;
>>>>> +	int ret;
>>>>>  
>>>>> -	/* Get new opp-bus instance according to new bus clock */
>>>>> +	/*
>>>>> +	 * New frequency for bus may not be exactly matched to opp, adjust
>>>>> +	 * *freq to correct value.
>>>>> +	 */
>>>>
>>>> You better to change this comment with following styles
>>>> to keep the consistency:
>>>>
>>>> 	/* Get correct frequency for bus ... */
>>>>
>>>>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>  	if (IS_ERR(new_opp)) {
>>>>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>>>>  		return PTR_ERR(new_opp);
>>>>>  	}
>>>>>  
>>>>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>>  	dev_pm_opp_put(new_opp);
>>>>>  
>>>>> -	old_freq = bus->curr_freq;
>>>>> -
>>>>> -	if (old_freq == new_freq)
>>>>> -		return 0;
>>>>> -
>>>>>  	/* Change the frequency according to new OPP level */
>>>>>  	mutex_lock(&bus->lock);
>>>>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>>>>> +	if (!ret)
>>>>> +		bus->curr_freq = *freq;
>>>>
>>>> ditto. Have to print the error log, check above comment.
>>>>
>>>>>  
>>>>> -	ret = clk_set_rate(bus->clk, new_freq);
>>>>> -	if (ret < 0) {
>>>>> -		dev_err(dev, "failed to set the clock of bus\n");
>>>>> -		goto out;
>>>>> -	}
>>>>> -
>>>>> -	*freq = new_freq;
>>>>> -	bus->curr_freq = new_freq;
>>>>> -
>>>>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>>>>> -out:
>>>>>  	mutex_unlock(&bus->lock);
>>>>>  
>>>>>  	return ret;
>>>>> @@ -259,20 +215,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>  					struct exynos_bus *bus)
>>>>>  {
>>>>>  	struct device *dev = bus->dev;
>>>>> -	int i, ret, count, size;
>>>>> -
>>>>> -	/* Get the regulator to provide each bus with the power */
>>>>> -	bus->regulator = devm_regulator_get(dev, "vdd");
>>>>> -	if (IS_ERR(bus->regulator)) {
>>>>> -		dev_err(dev, "failed to get VDD regulator\n");
>>>>> -		return PTR_ERR(bus->regulator);
>>>>> -	}
>>>>> -
>>>>> -	ret = regulator_enable(bus->regulator);
>>>>> -	if (ret < 0) {
>>>>> -		dev_err(dev, "failed to enable VDD regulator\n");
>>>>> -		return ret;
>>>>> -	}
>>>>> +	int i, count, size;
>>>>>  
>>>>>  	/*
>>>>>  	 * Get the devfreq-event devices to get the current utilization of
>>>>> @@ -281,24 +224,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>  	count = devfreq_event_get_edev_count(dev);
>>>>>  	if (count < 0) {
>>>>>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>>>> -		ret = count;
>>>>> -		goto err_regulator;
>>>>> +		return count;
>>>>>  	}
>>>>> +
>>>>>  	bus->edev_count = count;
>>>>>  
>>>>>  	size = sizeof(*bus->edev) * count;
>>>>>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>>>> -	if (!bus->edev) {
>>>>> -		ret = -ENOMEM;
>>>>> -		goto err_regulator;
>>>>> -	}
>>>>> +	if (!bus->edev)
>>>>> +		return -ENOMEM;
>>>>>  
>>>>>  	for (i = 0; i < count; i++) {
>>>>>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>>>> -		if (IS_ERR(bus->edev[i])) {
>>>>> -			ret = -EPROBE_DEFER;
>>>>> -			goto err_regulator;
>>>>> -		}
>>>>> +		if (IS_ERR(bus->edev[i]))
>>>>> +			return -EPROBE_DEFER;
>>>>>  	}
>>>>>  
>>>>>  	/*
>>>>> @@ -314,22 +253,15 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>>>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>>>>>  
>>>>> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>>>> -					&bus->voltage_tolerance))
>>>>> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>>>> -
>>>>>  	return 0;
>>>>> -
>>>>> -err_regulator:
>>>>> -	regulator_disable(bus->regulator);
>>>>> -
>>>>> -	return ret;
>>>>>  }
>>>>>  
>>>>>  static int exynos_bus_parse_of(struct device_node *np,
>>>>> -			      struct exynos_bus *bus)
>>>>> +			      struct exynos_bus *bus, bool passive)
>>>>>  {
>>>>>  	struct device *dev = bus->dev;
>>>>> +	struct opp_table *opp_table;
>>>>> +	const char *vdd = "vdd";
>>>>>  	struct dev_pm_opp *opp;
>>>>>  	unsigned long rate;
>>>>>  	int ret;
>>>>> @@ -347,11 +279,22 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>  		return ret;
>>>>>  	}
>>>>>  
>>>>> +	if (!passive) {
>>>>> +		opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>>> +		if (IS_ERR(opp_table)) {
>>>>> +			ret = PTR_ERR(opp_table);
>>>>> +			dev_err(dev, "failed to set regulators %d\n", ret);
>>>>> +			goto err_clk;/
>>>>> +		}
>>>>> +
>>>>> +		bus->opp_table = opp_table;
>>>>> +	}
>>>>
>>>> This driver has exynos_bus_parent_parse_of() function for parent devfreq device.
>>>> dev_pm_opp_set_regulators() have to be called in exynos_bus_parent_parse_of()
>>>> because the regulator is only used by parent devfreq device.
>>>
>>> exynos_bus_parse_of() is called for all devfreq devices (including
>>> parent) and (as you've noticed) the regulator should be enabled before
>>> enabling clock (which is done in exynos_bus_parse_of()) so adding
>>> extra argument to exynos_bus_parse_of() (like it is done currently in
>>> the patch) 
>>
>> I think that this patch has still the problem about call sequence
>> between clock and regulator as following:
> 
> Yes, this should be fixed (though the wrong sequence between regulator
> and clock handling is not introduced by the patchset itself and is present
> in the original driver code).
> 
>> 273         ret = clk_prepare_enable(bus->clk);                                     
>> 274         if (ret < 0) {                                                          
>> 275                 dev_err(dev, "failed to get enable clock\n");                   
>> 276                 return ret;                                                     
>> 277         }                                                                       
>> 278                                                                                 
>> 279         if (!passive) {                                                         
>> 280                 opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);            
>> 281                 if (IS_ERR(opp_table)) {                                        
>> 282                         ret = PTR_ERR(opp_table);                               
>> 283                         dev_err(dev, "failed to set regulators %d\n", ret);     
>> 284                         goto err_clk;                                           
>> 285                 }                                                               
>> 286                                                                                 
>> 287                 bus->opp_table = opp_table;                                     
>> 288         }                   
>>
>> makes it possible to do the setup correctly without the need
>>> of merging both functions into one huge function (which would be more
>>> difficult to follow than two simpler functions IMHO). Is that approach
>>> acceptable or do you prefer one big function?
>>
>> Actually, I don't force to make one function for both
>> exynos_bus_parse_of() and exynos_bus_parent_parse_of().
>>
>> If we just keep this code, dev_pm_opp_set_regulators()
>> should be handled in exynos_bus_parent_parse_of()
>> because only parent devfreq device controls the regulator.
> 
> Could your please explain rationale for this requirement (besides
> function name)?

OK. I hope to satisfy the following requirements:

1. Fix the sequence problem between clock and regulator for enabling them.
2. dev_pm_opp_set_regulator() have to be handled in exynos_bus_parent_parse_of()
   instead of exynos_bus_parse_of() for only parent devfreq device.
3. exynos_bus_parse_of() have to handle the only common properties
   of both parent devfreq device and passive devfreq device.

> 
> The patch adds 'bool passive' argument (which is set to false for
> parent devfreq device and true for child devfreq device) to
> exynos_bus_parse_of() (which is called for *all* devfreq devices

As I menteiond, exynos_bus_parse_of have to handle the only common
properties of both parent device and passive device. 

I gathered the properties for parent device into exynos_bus_parent_parse_of()
This way using 'bool passive' argument is not proper in exynos_bus_parse_of().


> and is called before exynos_bus_parent_parse_of()) and there is
> no hard requirement to call dev_pm_opp_set_regulators() in
> exynos_bus_parent_parse_of() so after only changing the ordering
> between regulator and clock handling the setup code should be
> correct.
> 
> [ Please note that this patch moves parent/child detection before
>   exynos_bus_parse_of() call. ]
> 
>> In order to keep the two functions, maybe have to change
>> the call the sequence between exynos_bus_parse_of() and
>> exynos_bus_parent_parse_of().
> 
> Doesn't seem to be needed, care to explain it more?

In order to fix the sequence problem between clock and regulator
with dev_pm_opp_set_regualtor() and want to keep two functions
(exynos_bus_parent_parse_of() and exynos_bus_parse_of()),
have to change the call order as following and then modify
the exception handling code when error happen.

	node = of_parse_phandle(dev->of_node, "devfreq", 0);                    
	if (node) {                                                             
		of_node_put(node);                                              
		passive = true
	}

	if (!passive)	
		exynos_bus_parent_parse_of()
			dev_pm_opp_set_regulator

	exynos_bus_parse_of()

> 
>> Once again, I don't force any fixed method. I want to fix them
>> with correct way.
>>
>>>
>>>>> +
>>>>>  	/* Get the freq and voltage from OPP table to scale the bus freq */
>>>>>  	ret = dev_pm_opp_of_add_table(dev);
>>>>>  	if (ret < 0) {
>>>>>  		dev_err(dev, "failed to get OPP table\n");
>>>>> -		goto err_clk;
>>>>> +		goto err_regulator;
>>>>>  	}
>>>>>  
>>>>>  	rate = clk_get_rate(bus->clk);
>>>>> @@ -362,6 +305,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>  		ret = PTR_ERR(opp);
>>>>>  		goto err_opp;
>>>>>  	}
>>>>> +
>>>>>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>>  	dev_pm_opp_put(opp);
>>>>>  
>>>>> @@ -369,6 +313,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>  
>>>>>  err_opp:
>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>> +
>>>>> +err_regulator:
>>>>> +	if (bus->opp_table) {
>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>> +		bus->opp_table = NULL;
>>>>> +	}
>>>>
>>>> As I mentioned above, it it wrong to call dev_pm_opp_put_regulators()
>>>> after removing the opp_table by dev_pm_opp_of_remove_table().
>>>>
>>>>> +
>>>>>  err_clk:
>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>  
>>>>> @@ -386,6 +337,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>  	struct exynos_bus *bus;
>>>>>  	int ret, max_state;
>>>>>  	unsigned long min_freq, max_freq;
>>>>> +	bool passive = false;
>>>>>  
>>>>>  	if (!np) {
>>>>>  		dev_err(dev, "failed to find devicetree node\n");
>>>>> @@ -395,12 +347,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>  	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>>>>  	if (!bus)
>>>>>  		return -ENOMEM;
>>>>> +
>>>>>  	mutex_init(&bus->lock);
>>>>>  	bus->dev = &pdev->dev;
>>>>>  	platform_set_drvdata(pdev, bus);
>>>>> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>>> +	if (node) {
>>>>> +		of_node_put(node);
>>>>> +		passive = true;
>>>>> +	}
>>>>>  
>>>>>  	/* Parse the device-tree to get the resource information */
>>>>> -	ret = exynos_bus_parse_of(np, bus);
>>>>> +	ret = exynos_bus_parse_of(np, bus, passive);
>>>>>  	if (ret < 0)
>>>>>  		return ret;
>>>>>  
>>>>> @@ -410,13 +368,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>  		goto err;
>>>>>  	}
>>>>>  
>>>>> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>>>> -	if (node) {
>>>>> -		of_node_put(node);
>>>>> +	if (passive)
>>>>>  		goto passive;
>>>>> -	} else {
>>>>> -		ret = exynos_bus_parent_parse_of(np, bus);
>>>>> -	}
>>>>> +
>>>>> +	ret = exynos_bus_parent_parse_of(np, bus);
>>>>>  
>>>>
>>>> Remove unneeded blank line.
>>>>
>>>>>  	if (ret < 0)
>>>>>  		goto err;
>>>>> @@ -509,6 +464,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>  
>>>>>  err:
>>>>>  	dev_pm_opp_of_remove_table(dev);
>>>>> +	if (bus->opp_table) {
>>>>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>>>> +		bus->opp_table = NULL;
>>>>> +	}
>>>>> +
>>>>
>>>> ditto.
>>>> Have to disable regulator after disabling the clock
>>>> to prevent the h/w fault.
>>>>
>>>> I think that you should call them with following sequence:
>>>>
>>>> 	clk_disable_unprepare(bus->clk);
>>>> 	if (bus->opp_table)
>>>> 		dev_pm_opp_put_regulators(bus->opp_table);
>>>> 	dev_pm_opp_of_remove_table(dev);
>>>>
>>>>>  	clk_disable_unprepare(bus->clk);
>>>>>  
>>>>>  	return ret;
>>>
>>> Best regards,
>>> --
>>> Bartlomiej Zolnierkiewicz
>>> Samsung R&D Institute Poland
>>> Samsung Electronics
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
