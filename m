Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920BBC443D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 01:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfJAXZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 19:25:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43486 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJAXZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 19:25:15 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191001232512epoutp02359da7f0e73b689d7fe2c8365103df01~JqX-v-F542264622646epoutp02e
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 23:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191001232512epoutp02359da7f0e73b689d7fe2c8365103df01~JqX-v-F542264622646epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569972312;
        bh=niVa1DOPKoUTnfXFd9LZfmOyIzdPyi4FYz7Cgx8S04I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tbzXBoJaEongoIMBfhmGU0MlgJfX2gnBzVVlQ7+74F0/t4Zb+eZm9oHKwU5/XEgei
         KXrs+kGaG/wLBv4mreZNWO7yvCLOuXmXZryV288B0LFPbHFK+v8nF+N82LuzkzGDOD
         z4TOO/VHwUqnjz/6h2HsY/chcOnE9+wGbf+hzC7k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191001232511epcas1p3e9d71541cace5b2e98e6d69271b12454~JqX-OxObL0970109701epcas1p3W;
        Tue,  1 Oct 2019 23:25:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46jb391KLwzMqYkb; Tue,  1 Oct
        2019 23:25:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.4C.04135.550E39D5; Wed,  2 Oct 2019 08:25:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191001232508epcas1p31879881cbd348f8e85fe8e08d443031d~JqX8VMwjY0203302033epcas1p3X;
        Tue,  1 Oct 2019 23:25:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001232508epsmtrp1ef0f534f34353c6731473fbb58957f9e~JqX8UYsKk0057100571epsmtrp1H;
        Tue,  1 Oct 2019 23:25:08 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-01-5d93e055d7fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.D2.04081.450E39D5; Wed,  2 Oct 2019 08:25:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191001232507epsmtip21c1f6da05dab47957de89cd8756ab31c~JqX78K4CD2524725247epsmtip2e;
        Tue,  1 Oct 2019 23:25:07 +0000 (GMT)
Subject: Re: [PATCH v6 09/19] PM / devfreq: tegra30: Use kHz units uniformly
 in the code
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
Message-ID: <2b65c78a-4b8f-661b-dd9c-29b3cbf0844f@samsung.com>
Date:   Wed, 2 Oct 2019 08:29:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-10-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmgW7og8mxBo+mslus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIzvj2q4Ol4F1URcvJZ6wNjHc9uxg5OCQETCRWbqnvYuTkEBLYwShx7IED
        hP2JUeLOrpguRi4g+xujxIe2iawgCZD6u7Pes0MU7WWUmPnICqLoPaNE79r3zCAJYYEoiQP/
        T7KAJEQE/jFKdP5sZgNJMAtEShzeuZoJxGYT0JLY/+IGWJxfQFHi6o/HjCA2r4CdxIHGq+wg
        17EIqEjs/agFEhYViJD49OAwK0SJoMTJmU9YQGxOAXOJ93f3M0GMF5e49WQ+lC0v0bx1NjPI
        DRICzewSU5ufsEN84CIx7dtcZghbWOLV8S1QcSmJl/1tUHa1xMqTR9ggmjsYJbbsvwD1vrHE
        /qWTmUCOYxbQlFi/Sx8irCix8/dcRojFfBLvvvawQkKXV6KjTQiiRFni8oO7TBC2pMTi9k62
        CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgVGyFG9iRGcUrXMdjAuOudziFGAg1GJ
        h/dGyORYIdbEsuLK3EOMEhzMSiK8Nn8mxQrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGC6
        zyuJNzQ1MjY2tjAxNDM1NFQS53VPb4gVEkhPLEnNTk0tSC2C6WPi4JRqYLQ55ia8TvZNjZfM
        hMsN7TN9bhp/Nzlzforc9v7VXnO40o+xLwk4f3TZZG2D/cIWS+OjH2o84s/nnLIn/kBeldTu
        /9OvBM7flskvmfbJIOxHZKR6T8DhXov/B7mn2l+KVPQ7EXEmMyMivsX42Msbbq5+ZUEdyutL
        Ti4PTt6WkZrXGrIi7q3pESWW4oxEQy3mouJEAFkjWoS/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvG7Ig8mxBlfOCFqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlfPvVwVLwLqqi5eQz1gbGu55djJwcEgImEndn
        vWfvYuTiEBLYzSgxZ9ZFFoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKLN9wgQ2kRlggSuLA/5Ms
        IAkRgSYmiU29F9hBEswCkRI9c7ewQXRsY5S4tGkNK0iCTUBLYv+LG2Dd/AKKEld/PGYEsXkF
        7CQONF5lB9nGIqAisfejFkhYVCBC4vCOWVAlghInZz4BO45TwFzi/d39TBC71CX+zLvEDGGL
        S9x6Mh8qLi/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCY0xLcwfj5SXxhxgFOBiVeHgbgibHCrEmlhVX5h5ilOBgVhLhtfkzKVaINyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRkePAzp8aXwsGdPD
        H+ck7zTYE9sTlHuUf8J9ibv3FuS4qx3l6p4d1prCz9659u6uTdMmiJyaKVd7ad4G2Xf3tp57
        sLipPP1O6IqMC5PYFLce2/1FbOJDHa+M62ui53UUrE1LmPLo1ha73v2BnypXZ714IOUno/1r
        gpvR511azRtbv0eu3raSNUKJpTgj0VCLuag4EQAFlJVsrQIAAA==
X-CMS-MailID: 20191001232508epcas1p31879881cbd348f8e85fe8e08d443031d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212545epcas4p4132cb98ef69ef04136fda4030bd64f92
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212545epcas4p4132cb98ef69ef04136fda4030bd64f92@epcas4p4.samsung.com>
        <20190811212315.12689-10-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> Now that all kHz-conversion related bugs are fixed, we can use the kHz
> uniformly. This makes code cleaner and avoids integer divisions in the
> code, which is useful in a case of Tegra30 that has Cortex A9 CPU that
> doesn't support integer division instructions, hence all divisions are
> actually made in software mode. Another small benefit from this change
> is that now powertop utility correctly displays devfreq's stats, for
> some reason it expects them to be in kHz.

If possible, please specify the benefit result on patch description.

And I have a question. Why do you fix the KHz-conversion issue on one patch?
Actually, in my case, it is difficult to understand that multiple patches
try to fix the KHz-conversion issue. I think that it is possible to
make one patch.

And, 
On these series, some codes wad added and then these codes are deleted
on later patch. It looks like that you made the issue and then you fix
the issue by yourself. I think that it is not proper.
Even if you developed the patches on your local environment sequentially
according to the sequence of your issue detection, you better to do
refactoring the patches.

Frankly, I cannot agree that some codes wad added on front patch
and then added codes are deleted on later patch in the same patchset.


> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 81 +++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index ca499368ee81..43d50b4366dd 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -137,8 +137,11 @@ struct tegra_devfreq_device {
>  	const struct tegra_devfreq_device_config *config;
>  	void __iomem *regs;
>  
> -	/* Average event count sampled in the last interrupt */
> -	u32 avg_count;
> +	/*
> +	 * Average event count sampled in the last interrupt and converted
> +	 * to frequency value.
> +	 */
> +	u32 avg_freq;
>  
>  	/*
>  	 * Extra frequency to increase the target by due to consecutive
> @@ -222,6 +225,14 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
>  	return 0;
>  }
>  
> +static unsigned long
> +tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
> +				     struct tegra_devfreq_device *dev)
> +{
> +	return dev->config->avg_dependency_threshold /
> +		ACTMON_SAMPLING_PERIOD;
> +}
> +
>  static unsigned long
>  tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev,
> @@ -229,13 +240,15 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>  {
>  	unsigned long static_cpu_emc_freq;
>  
> -	if (dev->config->avg_dependency_threshold &&
> -	    dev->config->avg_dependency_threshold < dev->avg_count) {
> +	if (!dev->config->avg_dependency_threshold)
> +		return target_freq;
> +
> +	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
> -		target_freq = max(target_freq, static_cpu_emc_freq);
> -	}
> +	else
> +		static_cpu_emc_freq = 0;
>  
> -	return target_freq;
> +	return max(target_freq, static_cpu_emc_freq);
>  }
>  
>  static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq *tegra,
> @@ -261,7 +274,7 @@ static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq *tegra,
>  
>  	opp = dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
>  	if (IS_ERR(opp))
> -		upper = ULONG_MAX;
> +		upper = KHZ_MAX;
>  	else
>  		dev_pm_opp_put(opp);
>  
> @@ -280,15 +293,12 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  	 * range in a case where target_freq falls into a range of
>  	 * next_possible_opp_freq - 1MHz.
>  	 */
> -	target_freq = round_down(target_freq, 1000000);

This line was added on patch5. I think that you could fix the KHz-conversion
on patch5 instead of this patch. It is not good way to make the patches.
Because some codes wad added and then these codes are deleted on later patch.

It looks like that you made the issue and then you fix the issue by yourself.
It is difficult to make me to decide this patch is either proper or not.

> +	target_freq = round_down(target_freq, 1000);
>  
>  	/* watermarks are set at the borders of the corresponding OPPs */
>  	*lower = tegra_actmon_lower_freq(tegra, target_freq);
>  	*upper = tegra_actmon_upper_freq(tegra, target_freq);
>  
> -	*lower /= KHZ;
> -	*upper /= KHZ;
> -
>  	/*
>  	 * The upper watermark should take into account CPU's frequency
>  	 * because cpu_to_emc_rate() may override the target_freq with
> @@ -304,10 +314,11 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  					   struct tegra_devfreq_device *dev)
>  {
> -	unsigned long lower, upper, freq;
> +	unsigned long avg_dependency_freq, lower, upper;
> +
> +	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);
>  
> -	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
> -	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
> +	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
>  
>  	/*
>  	 * We want to get interrupts when MCCPU client crosses the
> @@ -316,7 +327,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  	 */
>  	if (lower < dev->config->avg_dependency_threshold &&
>  	    upper > dev->config->avg_dependency_threshold) {
> -		if (dev->avg_count < dev->config->avg_dependency_threshold)
> +		if (dev->avg_freq < avg_dependency_freq)
>  			upper = dev->config->avg_dependency_threshold;
>  		else
>  			lower = dev->config->avg_dependency_threshold;
> @@ -358,8 +369,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  	 * device. Once that mark is hit and boosting is stopped, the
>  	 * interrupt is disabled by ISR.
>  	 */
> -	freq = dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
> -	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower, &upper);
> +	tegra_actmon_get_lower_upper(tegra, dev, dev->avg_freq, &lower, &upper);

Also, patch5 newly defined this function and then you edit the function prototype
of this function. It is not proper way.

>  
>  	delta = do_percent(upper - lower, dev->config->boost_down_threshold);
>  	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
> @@ -368,12 +378,14 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
> -	u32 intr_status, dev_ctrl, avg_intr_mask;
> +	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
>  
> -	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
> +	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>  	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
>  
> +	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> +
>  	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
>  			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
>  
> @@ -427,7 +439,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  {
>  	unsigned long target_freq;
>  
> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
> +	target_freq = dev->avg_freq + dev->boost_freq;
>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>  
>  	return min(target_freq, tegra->max_freq);
> @@ -464,6 +476,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	struct clk_notifier_data *data = ptr;
>  	struct tegra_devfreq_device *dev;
>  	struct tegra_devfreq *tegra;
> +	unsigned long freq;
>  	unsigned int i;
>  
>  	if (action != POST_RATE_CHANGE)
> @@ -471,6 +484,8 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  
>  	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
>  
> +	freq = data->new_rate / KHZ;
> +
>  	/*
>  	 * EMC rate could change due to three reasons:
>  	 *
> @@ -492,7 +507,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  		dev = &tegra->devices[i];
>  
>  		tegra_devfreq_update_avg_wmark(tegra, dev);
> -		tegra_devfreq_update_wmark(tegra, dev, data->new_rate);
> +		tegra_devfreq_update_wmark(tegra, dev, freq);
>  	}
>  
>  	return NOTIFY_OK;
> @@ -501,14 +516,14 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
> -	u32 val = 0, target_freq;
> +	u32 val = 0;
>  
> -	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> -	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
> -	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
> +	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> +	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
> +		      ACTMON_DEV_INIT_AVG);
>  
>  	tegra_devfreq_update_avg_wmark(tegra, dev);
> -	tegra_devfreq_update_wmark(tegra, dev, target_freq);
> +	tegra_devfreq_update_wmark(tegra, dev, dev->avg_freq);
>  
>  	device_writel(dev, ACTMON_COUNT_WEIGHT, ACTMON_DEV_COUNT_WEIGHT);
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> @@ -572,7 +587,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	rate = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> -	err = clk_set_min_rate(tegra->emc_clock, rate);
> +	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
>  	if (err)
>  		return err;
>  
> @@ -595,7 +610,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	struct tegra_devfreq_device *actmon_dev;
>  	unsigned long cur_freq;
>  
> -	cur_freq = clk_get_rate(tegra->emc_clock);
> +	cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>  
>  	/* To be used by the tegra governor */
>  	stat->private_data = tegra;
> @@ -612,7 +627,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
> +	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> @@ -652,7 +667,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  		target_freq = max(target_freq, dev_target_freq);
>  	}
>  
> -	*freq = target_freq * KHZ;
> +	*freq = target_freq;
>  
>  	return 0;
>  }
> @@ -787,7 +802,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  			goto remove_opps;
>  		}
>  
> -		err = dev_pm_opp_add(&pdev->dev, rate, 0);
> +		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
>  		if (err) {
>  			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
>  			goto remove_opps;
> @@ -812,6 +827,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> +	tegra_devfreq_profile.initial_freq /= KHZ;
> +
>  	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>  				     "tegra_actmon", NULL);
>  	if (IS_ERR(devfreq)) {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
