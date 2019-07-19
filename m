Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256B76D869
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfGSBd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:33:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47919 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGSBd1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:33:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190719013324epoutp036f83f660dcdf63a402fa019fa0dc5644~yqvhT_Sps2612926129epoutp031
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190719013324epoutp036f83f660dcdf63a402fa019fa0dc5644~yqvhT_Sps2612926129epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563500004;
        bh=zEeA5Cp8OmHhnTGvzXZ0wyEc2Ymt1jAItLIqP5PbzgY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XgGUDqJZDSo5b9XWma/O5GqDgci3/PdX+yYlEofTxWtfDJCsG+pImfXduJiR5kUS5
         HuXtmcqM2EQkRWSyFyT1LA2tLaiBQ/mrwMV5+7jXhvj3FLcciXZ6Q/lNEYJfkRFE3G
         bfebBQJHAuFxlp3pPb/YSy/LNJH2W02OLXAoMivw=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719013323epcas1p44b370b3ec11bfe99a0cb46a50ef5f576~yqvg0JQ261664416644epcas1p4W;
        Fri, 19 Jul 2019 01:33:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45qYRj1VkgzMqYkd; Fri, 19 Jul
        2019 01:33:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.48.04066.0ED113D5; Fri, 19 Jul 2019 10:33:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719013320epcas1p1afc7026a4887c92a7651a79a022c93aa~yqvdekx131633316333epcas1p15;
        Fri, 19 Jul 2019 01:33:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719013320epsmtrp16cfa4500d5690b6982a20fe9a3313514~yqvddnoEG3029530295epsmtrp1O;
        Fri, 19 Jul 2019 01:33:20 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-f3-5d311de0aab5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.72.03706.FDD113D5; Fri, 19 Jul 2019 10:33:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719013319epsmtip1574292a1f7f0a3820fc6f77bdd0040a5~yqvdTiSI63163931639epsmtip1Q;
        Fri, 19 Jul 2019 01:33:19 +0000 (GMT)
Subject: Re: [PATCH v4 20/24] PM / devfreq: tegra30: Optimize upper average
 watermark selection
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e3358039-d1b3-a5a0-1a37-aeb8edd49d6b@samsung.com>
Date:   Fri, 19 Jul 2019 10:36:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-21-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7O4arr3l7W+XlRJCSutOcHSulyGJR1CKCUswO7jTF3diZ
        3YPKSBdlN6JadqEblUQWFk4rTYvQLqRl2EVaFGlRVjPDdd92jPz3vO/7PN/7PN/30YSqmlLT
        RVan4LDyZoYaTl5tTkxN9o5j8zQNj1mu6strxG11nyC5+1s+KLhHdZUU17fzFuJcX90U93zz
        WYrz1x0luYoL7dSMMH1t1ymk97i7FPqdpb2UvqLmPNL3XY41yHOKpxcKvFFwxAvWApuxyGrK
        ZOYtzp+Vr0vXsMlsBjeFibfyFiGTyZ5vSJ5TZA4YYuJX8eaSQMvAiyKTmjXdYStxCvGFNtGZ
        yQh2o9meYU8ReYtYYjWlFNgsU1mNZrIuQFxRXLi3/yRlbxy7pufOZ8Um5IrZjsJowGnwsqqa
        2I6G0ypci6DjaT0lFT4E3yqOy6XiGwLfDo/in6S17BeSBtcRvL3+YlDyCUH9tTYiyIrAPLTt
        6g7JI/FvBC5/KRUcEHgZNHuqZEFM4SRo6OkM9UfiBOgYeI2CWImz4Hv314CYpkk8AV4dXhJs
        R+Gl4PM2yyXKKGg59IYM4jCcDmfu9pHS8THw7M0xmYTjoPTK4VA4wH8oKG+5J5MiZENz40Uk
        4Qh4f6dmMJoa3u3aNojXw7mWW5QkLkdQ0/BQLg200HB6nyxojsCJcLEuVWongOfHESQtHgG9
        /TtC/gEroXybSqKMh0ferkELo+FkmYvajRj3kDjuIRHcQyK4/y87jsjzKFqwixaTILJ27dDn
        voxCvzVpSi2qfjC/CWEaMeFKg0WTp5Lzq8S1liYENMFEKp+/S81TKY382nWCw5bvKDELYhPS
        BS57D6GOKrAF/r7Vmc/qJmu1Wi6NTdexLBOjPPozMU+FTbxTKBYEu+D4p5PRYepNyNS6MKOz
        dJqhceDmxjTfn0u9m1dqw2+0pfhxK5G7JMrr38+a+ukN2g1t+GXlpIjI7tgBQ/j6Oa7bq8Wc
        uB/FcTOcE9E58wmvolb4uXzRQHRM7hhFkb39vfGj3lq1pqJj5dxX7AK16SB5atjNHGP7whcH
        lj8x4NkrfDM9H1L81U6GFAt5NolwiPxf+KDXRMMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO4DWcNYg9dyFqs/Pma0aJm1iMXi
        bNMbdovLu+awWXzuPcJo0fllFpvF7cYVbBY/d81jsehbe4nNgdNjx90ljB47Z91l9+htfsfm
        0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmTvi5mKzggU/Hi+Af2BsZO8S5GTg4JAROJU+1/
        GbsYuTiEBHYzSszZuJQRIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBKdp8+wg9QICyRKXOx/zgqS
        EBFoYpLY1HsBLMEsECnRM3cLG4gtJLCFUWLqZm0Qm01AS2L/ixtgcX4BRYmrPx6DLeMVsJP4
        9fwLK8gyFgFViYezQ0HCogIREod3zIIqEZQ4OfMJC4jNKWAmsez0ZxaIVeoSf+ZdYoawxSVu
        PZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8
        dL3k/NxNjOD40tLcwXh5SfwhRgEORiUe3oBcg1gh1sSy4srcQ4wSHMxKIry3X+rHCvGmJFZW
        pRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cC40PWO7d/sWP+NJceW
        RCarzbtw+M2q+Z9nblJYXV06e18/ezcjk/4m/uOM0lUlDC2PJ+ctPyF49angScVFq53q6jap
        r6/s5r+bkbv3bEn6s5VvUo6abBWNLknsnu8UsWW2M9c5G3NLRbNzwmXnFy9uCIpyqVm34F9N
        S2D0HelZt5Z1ak2bsc9MiaU4I9FQi7moOBEAxxHQs6sCAAA=
X-CMS-MailID: 20190719013320epcas1p1afc7026a4887c92a7651a79a022c93aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p333f556dcf5a477b5cad5c9362a6f9b97@epcas4p3.samsung.com>
        <20190707223303.6755-21-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> I noticed that CPU may be crossing the dependency threshold very
> frequently for some workloads and this results in a lot of interrupts
> which could be avoided if MCALL client is keeping actual EMC frequency
> at a higher rate.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index c3cf87231d25..4d582809acb6 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -314,7 +314,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  }
>  
>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> -					   struct tegra_devfreq_device *dev)
> +					   struct tegra_devfreq_device *dev,
> +					   unsigned long freq)
>  {
>  	unsigned long avg_threshold, lower, upper;
>  
> @@ -323,6 +324,15 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  	avg_threshold = dev->config->avg_dependency_threshold;
>  	avg_threshold = avg_threshold * ACTMON_SAMPLING_PERIOD;
>  
> +	/*
> +	 * If cumulative EMC frequency selection is higher than the
> +	 * device's, then there is no need to set upper watermark to
> +	 * a lower value because it will result in unnecessary upper
> +	 * interrupts.
> +	 */
> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
> +		upper = freq * ACTMON_SAMPLING_PERIOD;

Also, 'upper value is used on the patch5. You can combine this code to patch5
or if this patch depends on the cpu notifier, you can combine it to the patch
of adding cpu notifier without separate patch.

> +
>  	/*
>  	 * We want to get interrupts when MCCPU client crosses the
>  	 * dependency threshold in order to take into / out of account
> @@ -392,6 +402,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
>  	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
> +	unsigned long freq;
>  
>  	trace_device_isr_enter(tegra->regs, dev->config->offset,
>  			       dev->boost_freq, cpufreq_get(0));
> @@ -405,8 +416,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
>  			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
>  
> -	if (intr_status & avg_intr_mask)
> -		tegra_devfreq_update_avg_wmark(tegra, dev);
> +	if (intr_status & avg_intr_mask) {
> +		freq = clk_get_rate(tegra->emc_clock) / KHZ;
> +		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
> +	}
>  
>  	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
>  		/*
> @@ -525,7 +538,7 @@ static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> -		tegra_devfreq_update_avg_wmark(tegra, dev);
> +		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
>  		tegra_devfreq_update_wmark(tegra, dev, freq);
>  	}
>  
> @@ -630,7 +643,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
>  		      ACTMON_DEV_INIT_AVG);
>  
> -	tegra_devfreq_update_avg_wmark(tegra, dev);
> +	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
>  	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
>  
>  	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
