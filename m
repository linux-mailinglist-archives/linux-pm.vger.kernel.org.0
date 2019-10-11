Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1768AD3E88
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJKLd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 07:33:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49126 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 07:33:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191011113355euoutp01135aed32cd0cc2d85472331e5e5de2a1~MlH0YGEJK0778907789euoutp01P
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2019 11:33:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191011113355euoutp01135aed32cd0cc2d85472331e5e5de2a1~MlH0YGEJK0778907789euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570793635;
        bh=4ZYRzf6XeFviC24JG3kc+6eo4xAoGOrUhYOqB4a0MZc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AXVdnsFS+UnP18yoy2NrwZ4s+czvJHklYPMz9cA3QL1qSh3DFSTF0py5ncO4lIroR
         ePxxM5LCUVBNmx84kXEgV+30KVU54eWpJp8vQS4KiWhknyvDN7mPuGCJ0SoP1K/BuC
         ejyGLdWpZogtAEgIebD29Q4xZCjNQ8aY14ggSaL4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191011113354eucas1p14d4a819a030bba87cbecc0a6f4bb24f2~MlH0BB75m1526815268eucas1p16;
        Fri, 11 Oct 2019 11:33:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.62.04374.2A860AD5; Fri, 11
        Oct 2019 12:33:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191011113354eucas1p219e79f62d780540027a1350ea3a016ea~MlHzrtVVx0387903879eucas1p2G;
        Fri, 11 Oct 2019 11:33:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191011113354eusmtrp2deb37900f27cecd2eded4d8c644dd6ba~MlHzrEwdA0746607466eusmtrp2g;
        Fri, 11 Oct 2019 11:33:54 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-93-5da068a2d7ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.A3.04117.2A860AD5; Fri, 11
        Oct 2019 12:33:54 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191011113353eusmtip1e76cf8e6c1eea71f16851db13000461b~MlHzEpiRd3093230932eusmtip15;
        Fri, 11 Oct 2019 11:33:53 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0ce56e65-d989-18f8-af84-2fbd74ba20aa@samsung.com>
Date:   Fri, 11 Oct 2019 13:33:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87qLMhbEGrycrWKxccZ6VovrX56z
        WvTt+89o0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XtxhVsDtwem1Z1
        snlsXlLvcfDdHiaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyjg8dSNjwSq5it73P5gbGM9L
        dDFyckgImEjcuPGSrYuRi0NIYAWjxIFd/cwQzhdGibXt5xkhnM+MEg93nWOEaWlb+YcJIrEc
        qOrWWmaQhJDAW0aJZf8sQWxhgWyJb6eXgcVFBDwl/n6YwwLSwCxwm0mi99MvFpAEm4ChRNfb
        LjYQm1fATmLp7k9MIDaLgKpE65Hf7CC2qECsxL0fx5khagQlTs58AtbLKWAv8aPpEFg9s4C8
        RPPW2cwQtrjErSfzwa6TELjELnH+wmaos10kWk/1M0HYwhKvjm9hh7BlJP7vhGloBvrz3Fp2
        CKeHUeJy0wyobmuJw8cvsnYxcgCt0JRYv0sfIuwo8fb+ZUaQsIQAn8SNt4IQR/BJTNo2nRki
        zCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmycl1qu
        V5yYW1yal66XnJ+7iRGYrE7/O/51B+O+P0mHGAU4GJV4eGfIz48VYk0sK67MPcQowcGsJMK7
        aNacWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MR7pr
        3gXpBere2WKZKzPtmfUeGclLe032i4Vob+gqm23w1c1vIbfF/xl/fEM8Iy60C5d+tWwU1fnd
        p2d+w/WCXOb7PaVNyg4lO5/pn/hfeEXwh0WE1MNOK4+HF69Uy16Ouhl0lL3nAdcK265ZUa4J
        TckVzyb8itbcwMDMHpAlpG7Vt6z8d6ASS3FGoqEWc1FxIgAnZEJLUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7qLMhbEGrzZxWexccZ6VovrX56z
        WvTt+89o0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XtxhVsDtwem1Z1
        snlsXlLvcfDdHiaPvi2rGD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQyzg8dSNjwSq5it73P5gbGM9LdDFyckgImEi0rfzD1MXIxSEk
        sJRRYtqhZ0wQCRmJk9MaWCFsYYk/17rYIIpeM0r8XT2JHSQhLJAt8e30MmYQW0TAU+Lvhzks
        IEXMAneZJNZ9+wA19iyjxIN5MxlBqtgEDCW63oKM4uTgFbCTWLr7E9g6FgFVidYjv4GmcnCI
        CsRKbNprBlEiKHFy5hMWEJtTwF7iR9MhsHJmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQL
        SfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmB0bjv2c8sOxq53wYcY
        BTgYlXh4Z8jPjxViTSwrrsw9xCjBwawkwrto1pxYId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYS
        Tc4HJo68knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mh082Vy59
        HWMUWpPRlPXXqMqwNW6vVfM8h0OTGLkj7KMiN//wl6uKvr9q6YdFWT3zTYvY5KSC7yzJNvEM
        OVP36vnju0qmh9ZZNW2ZbqnlNpfz+0G+26w+/TKR7VWMXr5PSo88MfZTlxHZXDNn1rlDoSn/
        zZxP6Mr8YDL5aX7YNf2q8lW2a8+VWIozEg21mIuKEwF9HHsT5AIAAA==
X-CMS-MailID: 20191011113354eucas1p219e79f62d780540027a1350ea3a016ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
        <20191008134923.30123-1-k.konieczny@partner.samsung.com>
        <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 10.10.2019 04:50, Chanwoo Choi wrote:
> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>> dev_pm_opp_set_rate()") introduced errors:
>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>> ...
>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>
>> They are caused by incorrect PLL assigned to clock source, which results
>> in clock rate outside of OPP range. Add workaround for this in
>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
> If the clock caused this issue, you can set the initial clock on DeviceTree
> with assigned-clock-* properties. Because the probe time of clock driver
> is early than the any device drivers.
>
> It is not proper to fix the clock issue on other device driver.
> I think you can fix it by using the supported clock properties.

This issue is about something completely different. The OPPs defined in 
DT cannot be applied, because it is not possible to derive the needed 
clock rate from the bootloader-configured clock topology (mainly due to 
lack of common divisor values for some of the parent clocks). Some time 
ago Lukasz tried initially to redefine this clock topology using 
assigned-clock-rates/parents properties (see 
https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
such changes has to be done in bootloader. Until this is resolved, 
devfreq simply cannot set some of the defined OPPs.

This issue was there from the beginning, recent Kamil's patch only 
revealed it. In fact it was even worse - devfreq and common clock 
framework silently set lower clock than the given OPP defined.

>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index c832673273a2..37bd34d5625b 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>   {
>>   	struct device *dev = bus->dev;
>>   	struct dev_pm_opp *opp;
>> -	unsigned long rate;
>> +	unsigned long rate, opp_rate;
>>   	int ret;
>>   
>>   	/* Get the clock to provide each bus with source clock */
>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>   	}
>>   
>>   	rate = clk_get_rate(bus->clk);
>> -
>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>> +	opp_rate = rate;
>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>   	if (IS_ERR(opp)) {
>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>   		ret = PTR_ERR(opp);
>>   		goto err_opp;
>>   	}
>> +	/*
>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>> +	 * setting clock rate to recommended one.
>> +	 */
>> +	if (rate > opp_rate)
>> +		clk_set_rate(bus->clk, opp_rate);
>> +
>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>   	dev_pm_opp_put(opp);
>>   
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

