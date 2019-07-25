Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2922C74F9F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfGYNf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 09:35:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45802 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388394AbfGYNf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 09:35:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190725133557euoutp023acb575f70497173bfd9ec8fc60f5099~0qeGs_7Q90668006680euoutp02m
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 13:35:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190725133557euoutp023acb575f70497173bfd9ec8fc60f5099~0qeGs_7Q90668006680euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564061757;
        bh=DSFP2EFojvYK6/takdtG2m0wWX9DBJ3x8WA0DztH9Co=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p3WbRIY6M4xynQ204QTRNEuv7d27pICRoc5y2vXTfgjNaAUm95kIFMEYJYu718DM/
         3gnq79YCq3WcfqZtkPxGvbpn4NeLnPvnqwDzQt8E5bvUZaMkNjn03zmln5QyG3YIUX
         Lgf+1hVHZW5TZx0uNt+rYhYx6xHEXdzZ59g/0lzs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190725133556eucas1p2975fadb5d557b33eb85370a5e480cec6~0qeF7N1fT1431114311eucas1p2Y;
        Thu, 25 Jul 2019 13:35:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.D7.04325.C30B93D5; Thu, 25
        Jul 2019 14:35:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725133555eucas1p158ee253f410cb7f729a293a35b7c52c8~0qeFEj_eW1302713027eucas1p1O;
        Thu, 25 Jul 2019 13:35:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190725133555eusmtrp2e92e6d33ef8c36fc18c80625fdb2f2d4~0qeFDsQHL0884108841eusmtrp2N;
        Thu, 25 Jul 2019 13:35:55 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-6e-5d39b03c7812
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.4D.04140.B30B93D5; Thu, 25
        Jul 2019 14:35:55 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725133554eusmtip27910ac776034190b04f62f5231b5c4cf~0qeEWF1Gf2250822508eusmtip2H;
        Thu, 25 Jul 2019 13:35:54 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Chanwoo Choi <cw00.choi@samsung.com>
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
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <ed80b6e3-5b40-18ce-ca1e-65520edf516e@partner.samsung.com>
Date:   Thu, 25 Jul 2019 15:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMcRz2/b0XZ9+u6EOEG1uMYhrfpokxO3/J1pZF06nfyvTmriIWoqTD
        0c1LXZail1uiut6oiV23buhliWp5O0o2ukkX856uH9N/z+f5PM8+z7N9BFpuY+cKe+OTRHW8
        KlbBuTL1rd86VgRWBYSvNObOINW5lSzpHXvHkquWDpacG/hAk87OKp60Hx/miWmghyXdjVc4
        4jhrQSS3s5kiNy0veFLS20WRZ+lGjgx/badI5l0LT373VDOkxtbKbXBTVhRUIKWpPJtT1hQf
        Vepqy5HS2tdAKR0m72AuzDUwSozdmyKq/dZHuMZccEQnFmw7OJLdTB1DjvVa5CIA9odPfWd4
        LXIV5NiIIKfiBysNYwi6a+s4aXAgqM5tRf8sevvPv6oyBH33tLQ02BE87xngnSp3HApZ17NZ
        J/bAPpD36wlyimjczcClN/rJBYfXwpuGNsqJZXgL/DijnzzB4CXwpCqdc+JZeAeM2lpYSeMG
        D/IGGS0SBBccBLrBMCdNY0/oH7xKSXgBnKjLnwwEOFOAwnt2Voq9GfrvN9ESdof31lpewvNg
        /I5kBnwA3hbpeMmcgcCW9YmRFuugxdrFOg/TeClUNvpJ9EbobbIiJw14JvTZ3aQMM0Fff5mW
        aBmcOimX1CugYLztbxov0I7fYs8jhWFKMcOUNoYpbQz/7xYiphx5ismauGhRszpePOCrUcVp
        kuOjfSMT4kxo4u8e/bZ+vo2af+4xIywgxQyZT3lAuJxVpWhS48wIBFrhIcsomqBkUarUQ6I6
        Ybc6OVbUmJGXwCg8ZYen2XbKcbQqSdwniomi+t+WElzmHkMLXEpTP0bmBRoXZWUUzje8jRjt
        KbsYsqtCWV8S5D28OCSvN2dT2nVz92vLjWBjNn9i/5Gh7/Y0fo3/50xTa3VMcOlI2MkC3VBQ
        k1dJ2Zei6aE5KU1rXi4sfny6pb3z2sEq26L0K/lk+dZXact1s9XUw+36cWboaf2cIynmNHv6
        9gZ/BaOJUa1aRqs1qj+UX+GYcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7rWGyxjDda9l7fYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxeYHx9gcBD3WzFvD6LFpVSebx+Yl9R59W1Yxehy/sZ3J
        4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2MKZ/TC+b5V3zo3MfUwPjZrouRk0NCwERi0ts/rF2MXBxCAksZJSbtmMMOkZCWaDy9mgnC
        Fpb4c62LDaLoNaPEPaDDQBLCAuES7Ys7WUFsEQENiZl/rzCCFDELXGWROL9xDlRHB5PErg9X
        2ECq2ATMJR5tPwM2llfATeJ3zySwSSwCqhJXNjSC1YgKREgc3jGLEaJGUOLkzCcsXYwcHJwC
        9hJ9T6JAwswC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUWgWku5ZSFpmIWmZhaRlASPLKkaR
        1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAI33bs55YdjF3vgg8xCnAwKvHwXlhuGSvEmlhWXJl7
        iFGCg1lJhLdlIVCINyWxsiq1KD++qDQntfgQoynQbxOZpUST84HJJ68k3tDU0NzC0tDc2NzY
        zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+OSd/2HU859mxV0QCGAKa5pxZXqHS0TLac4
        SvH/Z1kQqzrrQSdX3nGhlw/cE3K/n9QMF161aZHT2UPPdv5kOa5ZH75gGl9w2dSCguh7ysJT
        Fvo/4vj9i8k9543qi6+TzrLrzgq6bvE2sqGheJpToXveqvzFZhdy1DJMAhXaZ5xREvFhniQ4
        m1OJpTgj0VCLuag4EQCxNd2QBgMAAA==
X-CMS-MailID: 20190725133555eucas1p158ee253f410cb7f729a293a35b7c52c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
        <20190719150535.15501-4-k.konieczny@partner.samsung.com>
        <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 25.07.2019 12:17, Chanwoo Choi wrote:
> Hi Kamil,
> 
> Looks good to me. But, I have some comment. Please check them.

Thank you for review, please see answers below.

> After this patch, exynos_bus_target is perfectly same with
> exynos_bus_passive_target. The exynos_bus_passive_target() could be removed.

Ok, I will make it in separate patch to simplify review process.

> On 19. 7. 20. 오전 12:05, k.konieczny@partner.samsung.com wrote:
>> Reuse opp core code for setting bus clock and voltage. As a side
>> effect this allow useage of coupled regulators feature (required
> 
> s/useage/usage ?

Good catch, I will change it.

>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>> uses regulator_set_voltage_triplet() for setting regulator voltage
>> while the old code used regulator_set_voltage_tol() with fixed
>> tolerance. This patch also removes no longer needed parsing of DT
>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>> it).
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/devfreq/exynos-bus.c | 143 +++++++++--------------------------
>>  1 file changed, 37 insertions(+), 106 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index f391044aa39d..c2147b0912a0 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -25,7 +25,6 @@
>>  #include <linux/slab.h>
>>  
>>  #define DEFAULT_SATURATION_RATIO	40
>> -#define DEFAULT_VOLTAGE_TOLERANCE	2
>>  
>>  struct exynos_bus {
>>  	struct device *dev;
>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>  
>>  	unsigned long curr_freq;
>>  
>> -	struct regulator *regulator;
>> +	struct opp_table *opp_table;
>> +
>>  	struct clk *clk;
>> -	unsigned int voltage_tolerance;
>>  	unsigned int ratio;
>>  };
>>  
>> @@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>  {
>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>  	struct dev_pm_opp *new_opp;
>> -	unsigned long old_freq, new_freq, new_volt, tol;
>>  	int ret = 0;
>>  
>> -	/* Get new opp-bus instance according to new bus clock */
>> +	/* Get correct frequency for bus. */
>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>  	if (IS_ERR(new_opp)) {
>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>  		return PTR_ERR(new_opp);
>>  	}
>>  
>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>> -	new_volt = dev_pm_opp_get_voltage(new_opp);
>>  	dev_pm_opp_put(new_opp);
>>  
>> -	old_freq = bus->curr_freq;
>> -
>> -	if (old_freq == new_freq)
>> -		return 0;
>> -	tol = new_volt * bus->voltage_tolerance / 100;
>> -
>>  	/* Change voltage and frequency according to new OPP level */
>>  	mutex_lock(&bus->lock);
>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>> +	if (!ret)
>> +		bus->curr_freq = *freq;
>>  
>> -	if (old_freq < new_freq) {
>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>> -		if (ret < 0) {
>> -			dev_err(bus->dev, "failed to set voltage\n");
>> -			goto out;
>> -		}
>> -	}
>> -
>> -	ret = clk_set_rate(bus->clk, new_freq);
>> -	if (ret < 0) {
>> -		dev_err(dev, "failed to change clock of bus\n");
>> -		clk_set_rate(bus->clk, old_freq);
>> -		goto out;
>> -	}
>> -
>> -	if (old_freq > new_freq) {
>> -		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>> -		if (ret < 0) {
>> -			dev_err(bus->dev, "failed to set voltage\n");
>> -			goto out;
>> -		}
>> -	}
>> -	bus->curr_freq = new_freq;
>> -
>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>> -out:
>>  	mutex_unlock(&bus->lock);
>>  
>>  	return ret;
>> @@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
>>  		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>  
>>  	clk_disable_unprepare(bus->clk);
>> -	if (bus->regulator)
>> -		regulator_disable(bus->regulator);
>> +	if (bus->opp_table)
>> +		dev_pm_opp_put_regulators(bus->opp_table);
>>  
>>  	dev_pm_opp_of_remove_table(dev);
>>  }
>> @@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>  {
>>  	struct exynos_bus *bus = dev_get_drvdata(dev);
>>  	struct dev_pm_opp *new_opp;
>> -	unsigned long old_freq, new_freq;
>> -	int ret = 0;
>> +	int ret;
>>  
>> -	/* Get new opp-bus instance according to new bus clock */
>> +	/* Get correct frequency for bus. */
>>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>  	if (IS_ERR(new_opp)) {
>>  		dev_err(dev, "failed to get recommended opp instance\n");
>>  		return PTR_ERR(new_opp);
>>  	}
>>  
>> -	new_freq = dev_pm_opp_get_freq(new_opp);
>>  	dev_pm_opp_put(new_opp);
>>  
>> -	old_freq = bus->curr_freq;
>> -
>> -	if (old_freq == new_freq)
>> -		return 0;
>> -
>>  	/* Change the frequency according to new OPP level */
>>  	mutex_lock(&bus->lock);
>> +	ret = dev_pm_opp_set_rate(dev, *freq);
>> +	if (!ret)
>> +		bus->curr_freq = *freq;
>>  
>> -	ret = clk_set_rate(bus->clk, new_freq);
>> -	if (ret < 0) {
>> -		dev_err(dev, "failed to set the clock of bus\n");
>> -		goto out;
>> -	}
>> -
>> -	*freq = new_freq;
>> -	bus->curr_freq = new_freq;
>> -
>> -	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>> -			old_freq, new_freq, clk_get_rate(bus->clk));
>> -out:
>>  	mutex_unlock(&bus->lock);
>>  
>>  	return ret;
>> @@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>  					struct exynos_bus *bus)
>>  {
>>  	struct device *dev = bus->dev;
>> -	int i, ret, count, size;
>> -
>> -	/* Get the regulator to provide each bus with the power */
>> -	bus->regulator = devm_regulator_get(dev, "vdd");
>> -	if (IS_ERR(bus->regulator)) {
>> -		dev_err(dev, "failed to get VDD regulator\n");
>> -		return PTR_ERR(bus->regulator);
>> -	}
>> -
>> -	ret = regulator_enable(bus->regulator);
>> -	if (ret < 0) {
>> -		dev_err(dev, "failed to enable VDD regulator\n");
>> -		return ret;
>> -	}
>> +	struct opp_table *opp_table;
>> +	const char *vdd = "vdd";
>> +	int i, count, size;
>>  
>>  	/*
>>  	 * Get the devfreq-event devices to get the current utilization of
>> @@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>  	count = devfreq_event_get_edev_count(dev);
>>  	if (count < 0) {
>>  		dev_err(dev, "failed to get the count of devfreq-event dev\n");
>> -		ret = count;
>> -		goto err_regulator;
>> +		return count;
>>  	}
>> -	bus->edev_count = count;
>>  
>> +	bus->edev_count = count;
>>  	size = sizeof(*bus->edev) * count;
>>  	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>> -	if (!bus->edev) {
>> -		ret = -ENOMEM;
>> -		goto err_regulator;
>> -	}
>> +	if (!bus->edev)
>> +		return -ENOMEM;
>>  
>>  	for (i = 0; i < count; i++) {
>>  		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>> -		if (IS_ERR(bus->edev[i])) {
>> -			ret = -EPROBE_DEFER;
>> -			goto err_regulator;
>> -		}
>> +		if (IS_ERR(bus->edev[i]))
>> +			return -EPROBE_DEFER;
>> +	}
>> +
>> +	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>> +	if (IS_ERR(opp_table)) {
>> +		i = PTR_ERR(opp_table);
>> +		dev_err(dev, "failed to set regulators %d\n", i);
>> +		return i;
> 
> Maybe, you just used the 'i' defined variable instead of adding
> new variable. But, I think that you better to add new variable
> like 'err' for the readability. Or, jut use the 'PTR_ERR(opp_table)'
> directly without any additional variable.

I will remove not related changes, so here I will reuse 'ret' variable.

>>  	}
>>  
>> +	bus->opp_table = opp_table;
> 
> Add blank line. 

OK

>>  	/*
>>  	 * Optionally, Get the saturation ratio according to Exynos SoC
>>  	 * When measuring the utilization of each AXI bus with devfreq-event
>> @@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>  	if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>  		bus->ratio = DEFAULT_SATURATION_RATIO;
>>  
>> -	if (of_property_read_u32(np, "exynos,voltage-tolerance",
>> -					&bus->voltage_tolerance))
>> -		bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>> -
>>  	return 0;
>> -
>> -err_regulator:
>> -	regulator_disable(bus->regulator);
>> -
>> -	return ret;
>>  }
>>  
>>  static int exynos_bus_parse_of(struct exynos_bus *bus)
>> @@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>  
>>  	/* Parse the device-tree to get the resource information */
>>  	ret = exynos_bus_parse_of(bus);
>> -	if (ret < 0) {
>> -		if (!passive)
>> -			regulator_disable(bus->regulator);
>> -
>> -		return ret;
>> -	}
>> +	if (ret < 0)
>> +		goto err_reg;
>>  
>>  	if (passive)
>>  		goto passive;
>> @@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>  
>>  err:
>>  	clk_disable_unprepare(bus->clk);
>> -	if (!passive)
>> -		regulator_disable(bus->regulator);
>> -
>>  	dev_pm_opp_of_remove_table(dev);
> 
> This function removes the 'opp_table'. But, the below code
> uses the 'opp_table' variable by dev_pm_opp_put_regulators().
> 
> To disable the regulator, you have to call dev_pm_opp_of_remove_table(dev)
> after dev_pm_opp_put_regulators(bus->opp_table).

Regulators should be set before dev_pm_opp_add_table(), so exit sequence
should be in reverse order,

init order:

exynos_bus_parent_parse_of()
	dev_pm_opp_set_regulators()
exynos_bus_parse_of()
	clk_prepare_enable()
	dev_pm_opp_of_add_table()

exit or error order:

dev_pm_opp_of_remove_table()
clk_disable_unprepare()
if (bus->opp_table)
	dev_pm_opp_put_regulators(bus->opp_table);

I will send v4 soon.

>> +err_reg:
>> +	if (bus->opp_table) {
>> +		dev_pm_opp_put_regulators(bus->opp_table);
>> +		bus->opp_table = NULL;
>> +	}
>>  
>>  	return ret;
>>  }

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

