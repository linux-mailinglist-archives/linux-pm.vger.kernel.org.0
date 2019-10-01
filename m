Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E688C30FF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJAKLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 06:11:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51965 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbfJAKLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 06:11:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191001101131euoutp011f993fb4610cebb21e55659ee38d7c33~JfjBwKtYW2747327473euoutp015
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 10:11:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191001101131euoutp011f993fb4610cebb21e55659ee38d7c33~JfjBwKtYW2747327473euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569924691;
        bh=MEo1mMLB+S4LnYXcT7VtK49bZSOGZEtaEB58jUPk/nU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=caOyuZcqL1l2d4TBGA309u/PHD9uxfPfPJcakhPRMBw9AnuHHQEwYZ1OF5xLX0EPA
         tkinQKV2Jzg1BlhXJro7MNvA0X18aQU0BhMy9ULX11ARi4FH+H8Pezycq7ObHkG10z
         B+IdvGRLRfFYRhrqTWfZNhigHqMT4VW6g4OSvZfI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191001101131eucas1p2233a72aec7d1cb32f04891b439e498c5~JfjBYc2U00195601956eucas1p2R;
        Tue,  1 Oct 2019 10:11:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.62.04309.356239D5; Tue,  1
        Oct 2019 11:11:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191001101130eucas1p27dacc4db372df06b2d98d3f365054fbc~JfjA-Vl5s1218512185eucas1p2r;
        Tue,  1 Oct 2019 10:11:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191001101130eusmtrp2fe3d4ba0d68e46f2c9936ced110c4741~JfjA_ilvG0277202772eusmtrp2L;
        Tue,  1 Oct 2019 10:11:30 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-62-5d9326531c72
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.AE.04117.256239D5; Tue,  1
        Oct 2019 11:11:30 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191001101129eusmtip2dcb41646709cda2fbfa1980459a10328~JfjAJr1HJ2310723107eusmtip2U;
        Tue,  1 Oct 2019 10:11:29 +0000 (GMT)
Subject: Re: [PATCH 3/3] memory: samsung: exynos5422-dmc: Add support for
 interrupt from performance counters
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <9ca20d38-672f-fde5-c940-61e89f8a0805@partner.samsung.com>
Date:   Tue, 1 Oct 2019 12:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927091920.GB19131@pi3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRz2vffe997S8XVFn5VlOwptiph9rRib2f1ljJnVwsmrmuuHeyui
        UZKSfl2GnHQYLrfz6+6kH8jqiMmdMkqJ1o9ZpUmlZkq63mv67/k+n+fzfJ5n+7KUrJn2YqNj
        Ezh1rFIlZ1zFZS9/21bs8DsfvtKcM5s8LLpPk6bhbzTRWW00ye/so4jd/kBC3p76LiGmzo80
        eV9ZzJChXCsiRfZnInLX2iYht5oaRKQ1rZQhGU+tElL7PZMmI6860EasMJYYkaJC2yZRmAxn
        GYX55klFnsWAFEMmn21MqGvIAU4VncSpAzfsc40y6W10fKvqaEuxTZSKunZlIxcW8BrIS2sQ
        ZSNXVoZLEVSYrjDCYxiBvf4i41DJ8BCC6keS6Y3m51lI4PUIfg0tExb6EZR2a6YG7jgO/rTU
        ix3YAy+HpvFR2oEprKXgg84/G7EsgwOg3HDYQUvxFsgtTKccWIyXQNGF0imb+Xg3DLbX0oJm
        Hry+3DVl6TJpqRvJcFp6QkuXTiTgRfC4v5hy5AGcxoLBMioWQm+GzOo2RsDu0FtncZZZCBMV
        wjJgHlJzryMBp0Bn/lWnJhhq6xpoR2Zq8vD9ykCB3gTWH49EDhrwHGjunydEmAOFZZcogZZC
        1hmZoF4Glpx3zkMLQG+8KClAcu2MYtoZZbQzymj/372GxAbkySXyMZEcHxTLHQnglTF8Ymxk
        QERcjAlN/rc3f+uGy1Hl2P4ahFkkd5MW9GjCZbQyiU+OqUHAUnIPachYYbhMekCZfIxTx+1V
        J6o4vgZ5s2K5p/T4rPYwGY5UJnCHOC6eU09PRayLVyo6R+mlA4zRz1pcFWEe78nKIiewWeM+
        e1Dhk/JFYWn/ehBGWz9vT91RcmPuJz/3a/1NE4Hs7RG3COMTffD6bs3OsNEB3t/wYvVY76z0
        06q15rKlA75bvavuMMlWTvo56sJOyWJLn6GE2+MjXhrk28gH4XWD937mrDE1dtpDQzvkYj5K
        ucqfUvPKfyQRbM1rAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7pBapNjDRa1aFlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbFp+
        jrXgdk7FrTnnmBoYn4R1MXJySAiYSNw40MHYxcjFISSwlFGif+Z6doiEmMSkfduhbGGJP9e6
        2CCKXjNKrP9zBywhLJAv8fvWGRYQW0RAU+L63++sIEXMArOYJdZfaWaB6HjBKNGxaQVQOwcH
        m4CexI5VhSANvAJuEr2TmplBbBYBFYkZU1cwgtiiAhESh3fMYoSoEZQ4OfMJ2AJOoAXzv7Wy
        gtjMAmYS8zY/ZIawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiBkb3t2M8tOxi73gUfYhTgYFTi4bV4PjFWiDWxrLgy9xCjBAez
        kgivzZ9JsUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0w6eSXxhqaG5haWhubG5sZmFkri
        vB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGK92Prvx7d6lJPfaW1uqU9bI5XbOiZkRNnft5NJX
        6zx/xh1YL3LHWfLW/vpZy87s3HU/bF2UUHjO5CKH2YUnnsgpHfg7n9H38GY1CWGu+NnFQWoO
        X7g2bZ7A25vPKDT5d/L0yQYrri9QeBk3N9rynrCge2eQULx41bQ3m4y7dws2Zuw8Hnos+L8S
        S3FGoqEWc1FxIgAyM+UUAgMAAA==
X-CMS-MailID: 20191001101130eucas1p27dacc4db372df06b2d98d3f365054fbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
        <CGME20190925161844eucas1p2dc69a451c2d86fd7f4be2b33940f8d62@eucas1p2.samsung.com>
        <20190925161813.21117-4-l.luba@partner.samsung.com>
        <20190927091920.GB19131@pi3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/27/19 11:19 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 25, 2019 at 06:18:13PM +0200, Lukasz Luba wrote:
>> Introduce a new interrupt driven mechanism for managing speed of the
>> memory controller. The interrupts are generated due to performance
>> counters overflow. The performance counters might track memory reads,
>> writes, transfers, page misses, etc. In the basic algorithm tracking
>> read transfers and calculating memory pressure should be enough to
>> skip polling mode in devfreq.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 297 ++++++++++++++++++++++--
>>   1 file changed, 272 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> index 0fe5f2186139..86e1844b97ef 100644
>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/devfreq.h>
>>   #include <linux/devfreq-event.h>
>>   #include <linux/device.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/mfd/syscon.h>
>>   #include <linux/module.h>
>> @@ -35,6 +36,29 @@
>>   #define USE_BPLL_TIMINGS			(0)
>>   #define EXYNOS5_AREF_NORMAL			(0x2e)
>>   
>> +#define DREX_PPCCLKCON		(0x0130)
>> +#define DREX_PEREV2CONFIG	(0x013c)
>> +#define DREX_PMNC_PPC		(0xE000)
>> +#define DREX_CNTENS_PPC		(0xE010)
>> +#define DREX_CNTENC_PPC		(0xE020)
>> +#define DREX_INTENS_PPC		(0xE030)
>> +#define DREX_INTENC_PPC		(0xE040)
>> +#define DREX_FLAG_PPC		(0xE050)
>> +#define DREX_PMCNT2_PPC		(0xE130)
>> +
>> +#define CC_RESET		BIT(2)
>> +#define PPC_COUNTER_RESET	BIT(1)
>> +#define PPC_ENABLE		BIT(0)
>> +#define PEREV_CLK_EN		BIT(0)
>> +#define PERF_CNT2		BIT(2)
>> +#define PERF_CCNT		BIT(31)
> 
> Describe to which registers these bitfields are applicable.
OK, I will add comment above them.
> 
>> +
>> +#define READ_TRANSFER_CH0	(0x6d)
>> +#define READ_TRANSFER_CH1	(0x6f)
> 
> The same. Otherwise they all look like some generic constants which is
> not true.
Make sense, agree. I will add comment above them.
> 
>> +
>> +#define PERF_COUNTER_START_VALUE 0xff000000
>> +#define PERF_EVENT_UP_DOWN_THRESHOLD 900000000ULL
>> +
>>   /**
>>    * struct dmc_opp_table - Operating level desciption
>>    *
>> @@ -85,6 +109,9 @@ struct exynos5_dmc {
>>   	struct clk *mout_mx_mspll_ccore_phy;
>>   	struct devfreq_event_dev **counter;
>>   	int num_counters;
>> +	u64 last_overflow_ts[2];
>> +	unsigned long load, total;
> 
> One member per line.  This decreases readability.
OK
> 
>> +	bool in_irq_mode;
>>   };
>>   
>>   #define TIMING_FIELD(t_name, t_bit_beg, t_bit_end) \
>> @@ -653,6 +680,167 @@ static int exynos5_counters_get(struct exynos5_dmc *dmc,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * exynos5_dmc_start_perf_events() - Setup and start performance event counters
>> + * @dmc:	device for which the counters are going to be checked
>> + * @beg_value:	initial value for the counter
>> + *
>> + * Function which enables needed counters, interrupts and sets initial values
>> + * then starts the counters.
>> + */
>> +static void exynos5_dmc_start_perf_events(struct exynos5_dmc *dmc,
>> +					  u32 beg_value)
>> +{
>> +	/* Enable interrupts for counter 2 */
>> +	writel(PERF_CNT2, dmc->base_drexi0 + DREX_INTENS_PPC);
>> +	writel(PERF_CNT2, dmc->base_drexi1 + DREX_INTENS_PPC);
> 
> Blank line.
> 
>> +	/* Enable counter 2 and CCNT  */
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENS_PPC);
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENS_PPC);
> 
> Blank line.
> 
>> +	/* Clear overflow flag for all counters */
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
> 
> Blank line.
> 
>> +	/* Reset all counters */
>> +	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi0 + DREX_PMNC_PPC);
>> +	writel(CC_RESET | PPC_COUNTER_RESET, dmc->base_drexi1 + DREX_PMNC_PPC);
> 
> Blank line.
> 
>> +	/*
>> +	 * Set start value for the counters, the number of samples that
>> +	 * will be gathered is calculated as: 0xffffffff - beg_value
>> +	 */
>> +	writel(beg_value, dmc->base_drexi0 + DREX_PMCNT2_PPC);
>> +	writel(beg_value, dmc->base_drexi1 + DREX_PMCNT2_PPC);
> 
> Blank line.
> 
>> +	/* Start all counters */
>> +	writel(PPC_ENABLE, dmc->base_drexi0 + DREX_PMNC_PPC);
>> +	writel(PPC_ENABLE, dmc->base_drexi1 + DREX_PMNC_PPC);
>> +}
>> +
>> +/**
>> + * exynos5_dmc_perf_events_calc() - Calculate utilization
>> + * @dmc:	device for which the counters are going to be checked
>> + * @diff_ts:	time between last interrupt and current one
>> + *
>> + * Function which calculates needed utilization for the devfreq governor.
>> + * It prepares values for 'busy_time' and 'total_time' based on elapsed time
>> + * between interrupts, which approximates utilization.
>> + */
>> +static void exynos5_dmc_perf_events_calc(struct exynos5_dmc *dmc, u64 diff_ts)
>> +{
>> +	/*
>> +	 * This is a simple algorithm for managing traffic on DMC.
>> +	 * When there is almost no load the counters overflow every 4s,
>> +	 * no mater the DMC frequency.
>> +	 * The high load might be approximated using linear function.
>> +	 * Knowing that, simple calculation can provide 'busy_time' and
>> +	 * 'total_time' to the devfreq governor which picks up target
>> +	 * frequency.
>> +	 * We want a fast ramp up and slow decay in frequency change function.
>> +	 */
>> +	if (diff_ts < PERF_EVENT_UP_DOWN_THRESHOLD) {
>> +		/*
>> +		 * Set higher utilization for the simple_ondemand governor.
>> +		 * The governor should increase the frequency of the DMC.
>> +		 */
>> +		dmc->load = 70;
>> +		dmc->total = 100;
>> +	} else {
>> +		/*
>> +		 * Set low utilization for the simple_ondemand governor.
>> +		 * The governor should decrease the frequency of the DMC.
>> +		 */
>> +		dmc->load = 35;
>> +		dmc->total = 100;
>> +	}
>> +
>> +	dev_dbg(dmc->dev, "diff_ts=%llu\n", diff_ts);
>> +}
>> +
>> +/**
>> + * exynos5_dmc_perf_events_check() - Checks the status of the counters
>> + * @dmc:	device for which the counters are going to be checked
>> + *
>> + * Function which is called from threaded IRQ to check the counters state
>> + * and to call approximation for the needed utilization.
>> + */
>> +static void exynos5_dmc_perf_events_check(struct exynos5_dmc *dmc)
>> +{
>> +	u32 val;
>> +	u64 diff_ts, ts;
>> +
>> +	ts = ktime_get_ns();
>> +
>> +	/* Stop all counters */
>> +	writel(0, dmc->base_drexi0 + DREX_PMNC_PPC);
>> +	writel(0, dmc->base_drexi1 + DREX_PMNC_PPC);
>> +
>> +	/* Check the source in interrupt flag registers (which channel) */
>> +	val = readl(dmc->base_drexi0 + DREX_FLAG_PPC);
>> +	if (val) {
>> +		diff_ts = ts - dmc->last_overflow_ts[0];
>> +		dmc->last_overflow_ts[0] = ts;
>> +		dev_dbg(dmc->dev, "drex0 0xE050 val= 0x%08x\n",  val);
>> +	} else {
>> +		val = readl(dmc->base_drexi1 + DREX_FLAG_PPC);
>> +		diff_ts = ts - dmc->last_overflow_ts[1];
>> +		dmc->last_overflow_ts[1] = ts;
>> +		dev_dbg(dmc->dev, "drex1 0xE050 val= 0x%08x\n",  val);
>> +	}
>> +
>> +	exynos5_dmc_perf_events_calc(dmc, diff_ts);
>> +
>> +	exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
>> +}
>> +
>> +/**
>> + * exynos5_dmc_enable_perf_events() - Enable performance events
>> + * @dmc:	device for which the counters are going to be checked
>> + *
>> + * Function which is setup needed environment and enables counters.
>> + */
>> +static void exynos5_dmc_enable_perf_events(struct exynos5_dmc *dmc)
>> +{
>> +	u64 ts;
>> +
>> +	/* Enable Performance Event Clock */
>> +	writel(PEREV_CLK_EN, dmc->base_drexi0 + DREX_PPCCLKCON);
>> +	writel(PEREV_CLK_EN, dmc->base_drexi1 + DREX_PPCCLKCON);
>> +
>> +	/* Select read transfers as performance event2 */
>> +	writel(READ_TRANSFER_CH0, dmc->base_drexi0 + DREX_PEREV2CONFIG);
>> +	writel(READ_TRANSFER_CH1, dmc->base_drexi1 + DREX_PEREV2CONFIG);
>> +
>> +	dmc->in_irq_mode = 1;
> 
> Move this outside, to the probe. Logically it belongs there.
OK
> 
>> +
>> +	ts = ktime_get_ns();
>> +	dmc->last_overflow_ts[0] = ts;
>> +	dmc->last_overflow_ts[1] = ts;
>> +
>> +	/* Devfreq shouldn't be faster than initialization, play safe though. */
>> +	dmc->load = 99;
>> +	dmc->total = 100;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_disable_perf_events() - Disable performance events
>> + * @dmc:	device for which the counters are going to be checked
>> + *
>> + * Function which stops, disables performance event counters and interrupts.
>> + */
>> +static void exynos5_dmc_disable_perf_events(struct exynos5_dmc *dmc)
>> +{
>> +	/* Stop all counters */
>> +	writel(0, dmc->base_drexi0 + DREX_PMNC_PPC);
>> +	writel(0, dmc->base_drexi1 + DREX_PMNC_PPC);
> 
> Blank line here and later.
OK - for all the 'blank line' hints.
> 
>> +	/* Disable interrupts for counter 2 */
>> +	writel(PERF_CNT2, dmc->base_drexi0 + DREX_INTENC_PPC);
>> +	writel(PERF_CNT2, dmc->base_drexi1 + DREX_INTENC_PPC);
>> +	/* Disable counter 2 and CCNT  */
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_CNTENC_PPC);
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_CNTENC_PPC);
>> +	/* Clear overflow flag for all counters */
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi0 + DREX_FLAG_PPC);
>> +	writel(PERF_CNT2 | PERF_CCNT, dmc->base_drexi1 + DREX_FLAG_PPC);
>> +}
>> +
>>   /**
>>    * exynos5_dmc_get_status() - Read current DMC performance statistics.
>>    * @dev:	device for which the statistics are requested
>> @@ -669,18 +857,24 @@ static int exynos5_dmc_get_status(struct device *dev,
>>   	unsigned long load, total;
>>   	int ret;
>>   
>> -	ret = exynos5_counters_get(dmc, &load, &total);
>> -	if (ret < 0)
>> -		return -EINVAL;
>> +	if (dmc->in_irq_mode) {
>> +		stat->current_frequency = dmc->curr_rate;
>> +		stat->busy_time = dmc->load;
>> +		stat->total_time = dmc->total;
>> +	} else {
>> +		ret = exynos5_counters_get(dmc, &load, &total);
>> +		if (ret < 0)
>> +			return -EINVAL;
>>   
>> -	/* To protect from overflow in calculation ratios, divide by 1024 */
>> -	stat->busy_time = load >> 10;
>> -	stat->total_time = total >> 10;
>> +		/* To protect from overflow, divide by 1024 */
>> +		stat->busy_time = load >> 10;
>> +		stat->total_time = total >> 10;
>>   
>> -	ret = exynos5_counters_set_event(dmc);
>> -	if (ret < 0) {
>> -		dev_err(dev, "could not set event counter\n");
>> -		return ret;
>> +		ret = exynos5_counters_set_event(dmc);
>> +		if (ret < 0) {
>> +			dev_err(dev, "could not set event counter\n");
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	return 0;
>> @@ -712,7 +906,6 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
>>    * It provides to the devfreq framework needed functions and polling period.
>>    */
>>   static struct devfreq_dev_profile exynos5_dmc_df_profile = {
>> -	.polling_ms = 500,
>>   	.target = exynos5_dmc_target,
>>   	.get_dev_status = exynos5_dmc_get_status,
>>   	.get_cur_freq = exynos5_dmc_get_cur_freq,
>> @@ -1108,6 +1301,26 @@ static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
>>   	return 0;
>>   }
>>   
>> +static irqreturn_t dmc_irq_thread(int irq, void *priv)
>> +{
>> +	int res;
>> +	struct exynos5_dmc *dmc = priv;
>> +
>> +	dev_dbg(dmc->dev, "irq thread handler\n");
> 
> Skip a debug in thread handler for memory. It can pollute your log (I
> guess depending on workload).
OK, I will remove it.
> 
>> +
>> +	mutex_lock(&dmc->df->lock);
>> +
>> +	exynos5_dmc_perf_events_check(dmc);
>> +
>> +	res = update_devfreq(dmc->df);
>> +	if (res)
>> +		dev_err(dmc->dev, "devfreq failed with %d\n", res);
> 
> dev_warn()
OK
> 
>> +
>> +	mutex_unlock(&dmc->df->lock);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   /**
>>    * exynos5_dmc_probe() - Probe function for the DMC driver
>>    * @pdev:	platform device for which the driver is going to be initialized
>> @@ -1125,6 +1338,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>   	struct device_node *np = dev->of_node;
>>   	struct exynos5_dmc *dmc;
>>   	struct resource *res;
>> +	int irq;
>>   
>>   	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
>>   	if (!dmc)
>> @@ -1172,24 +1386,48 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>   		goto remove_clocks;
>>   	}
>>   
>> -	ret = exynos5_performance_counters_init(dmc);
>> -	if (ret) {
>> -		dev_warn(dev, "couldn't probe performance counters\n");
>> -		goto remove_clocks;
>> -	}
>> -
>>   	ret = exynos5_dmc_set_pause_on_switching(dmc);
>>   	if (ret) {
>>   		dev_warn(dev, "couldn't get access to PAUSE register\n");
>>   		goto err_devfreq_add;
> 
> This is wrong now, I think.
Good point, should be 'goto remove_clocks'.
> 
>>   	}
>>   
>> -	/*
>> -	 * Setup default thresholds for the devfreq governor.
>> -	 * The values are chosen based on experiments.
>> -	 */
>> -	dmc->gov_data.upthreshold = 30;
>> -	dmc->gov_data.downdifferential = 5;
>> +	/* There is two modes in which the driver works: polling or IRQ */
>> +	irq = platform_get_irq(pdev, 0);
> 
> You need to document it in bindings.
OK
> 
>> +	if (irq < 0) {
>> +		ret = exynos5_performance_counters_init(dmc);
>> +		if (ret) {
>> +			dev_warn(dev, "couldn't probe performance counters\n");
>> +			goto remove_clocks;
> 
> Weird, previous error jump goes to err_devfreq_add. This goes to error
> label which is narrower (less to cleanup).

Right.

Thank you for the review. I will address the issues in the next version.

Regards,
Lukasz
