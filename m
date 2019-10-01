Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB814C4451
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 01:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfJAXag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 19:30:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13465 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfJAXag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 19:30:36 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191001233031epoutp0172f81c43b43a7e587897077da706e504~Jqcpm8UHk1590515905epoutp01c
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 23:30:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191001233031epoutp0172f81c43b43a7e587897077da706e504~Jqcpm8UHk1590515905epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569972631;
        bh=gnEqNb8QnadO4nNCdUYCeu5P5Hpj5zHQ1/7mb1mbjmQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R8qmkkIIqGoKwjEjTLkUwpTWzuqsOku7X6uRlG3x/odJAPONoQ59OD+n+4aRFEUSS
         zQTqB38ijP9J+JJk0bhMxAULbR5MgSE/Y1s1qSKVBmYBQp1Nmcr1SJodJLCn3DhNC2
         DtRNSwtlZNcUhSas5jVWExgmXSEtTm/2+Ixs9LHY=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191001233031epcas1p3350f90c3b7d2d59fff2c9b70fd7969fd~JqcpAiI3u2074320743epcas1p3G;
        Tue,  1 Oct 2019 23:30:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46jb9J0ZfjzMqYkd; Tue,  1 Oct
        2019 23:30:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.AB.04068.191E39D5; Wed,  2 Oct 2019 08:30:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191001233025epcas1p368ad4010f970639e933b2ed52f3f80d1~Jqcjv9aRo0733107331epcas1p3u;
        Tue,  1 Oct 2019 23:30:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191001233025epsmtrp2e4956355344901925a096826da684ef7~JqcjvG2xK1405914059epsmtrp25;
        Tue,  1 Oct 2019 23:30:25 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-d5-5d93e191a3c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.23.04081.191E39D5; Wed,  2 Oct 2019 08:30:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001233025epsmtip1393125d7d119914bd1fabc0343ec17b5~JqcjgGFIR0541805418epsmtip1S;
        Tue,  1 Oct 2019 23:30:25 +0000 (GMT)
Subject: Re: [PATCH v6 10/19] PM / devfreq: tegra30: Reduce unnecessary
 interrupts activity
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
Message-ID: <b67a7878-fa74-df89-9a62-556b9300b5a5@samsung.com>
Date:   Wed, 2 Oct 2019 08:35:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-11-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH970fz11xeZzSxxnqYbPaqnuqy5Ndfo/z44+M5NfJo3t2pfvl
        njtTNosalylxaK7CCusH82Ohy1IqhY2aZA1XyLCQJaxkeO6eTP+9Pp/P+/Pr+/1IhfKrmEKa
        brIxVhNtIDB/0c3msIiIY6+dWmVrh5qqHuxDVK6rTEQ9OvBJQnXWlWDUUH4LovK+uTDqxf4K
        jBqpOyOiCi4/wRb5aWo955HG7fJINPk5A5imoKYKaYauz0wUb85QpzG0jrGGMKZUsy7dpE8g
        Vq9LWZqiilOSEWQ8NY8IMdFGJoFYtiYxYnm6gRuICNlNG+ycK5FmWSJqgdpqttuYkDQza0sg
        GIvOYIm3RLK0kbWb9JGpZuN8UqmMVnHC7RlpbWUuZOlT7xk9UYRlo9/Kw8hPCngsOJwOgZfl
        eC2COwcjDyN/jr8iuNlzCeONHwgK+34J/2XktpYL+EA9p3J4xowvCD42FPhqTcG1UH/KLfEG
        AvHfCPJGcjBvQIhvgmZ3tU+E4eHQ8KHb55+Eh0LXcB/ysgxfAFfvXZR4WYTPgdujl3wchG+E
        r6+axbxmMjw4/VbkZT98Hjz7clLE1w+G52/PCnieBTk3ioXeIQD/g8H9xvqxHZbBtaOnJDxP
        gf62mjFWwNBAPcbzXqh80ILxyQ4ENQ0dYj4QAw0XnFwHKdchDK7URfHuUHCPliK+cQAMfD8i
        9koAl4HjoJyXzIbOVx4Bz9Og/FAeVogI17h1XONWcI1bwfW/2TkkqkJTGQtr1DMsaVGN/+7r
        yHet4fG1qPXxmiaESxExUda93qmVi+ndbKaxCYFUSATK1L+Oa+UyHZ2ZxVjNKVa7gWGbkIp7
        7WNCRVCqmbt9ky2FVEXHxMRQsWSciiSJYJlGn62V43raxmQwjIWx/ssTSP0U2WjGrd4b09Xt
        PVUfQofV/dHHFe+6kipaB18n78u3XusNqyxe9fLp48vbWo4U6fb3TGAC/FcKk4oMs+c3ft5a
        4pRMK+k0nl78xizf4lT9tHmSKzLb1yZvKHUGKO3vpEPuwoUr8nVxlbt2ToxekoXfDTx3tL9s
        uDIsyBC8o/phxdq578W5hIhNo8lwoZWl/wKlpexJwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7Eh5NjDTYvkbFY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKOL5oFmPBY5uK31OmszUw/jPoYuTkkBAwkWg5
        tpipi5GLQ0hgN6NEz4GdzBAJSYlpF48C2RxAtrDE4cPFEDVvGSW6FrxmBakRFoiV2DttJztI
        QkSgiUliU+8FdpAEs0CkRM/cLWwQHdsYJWY1vQWbyiagJbH/xQ02EJtfQFHi6o/HjCA2r4Cd
        xIajy8CaWQRUJHb/XgNmiwpESBzeMQuqRlDi5MwnLCA2p4C5xLX3U1kglqlL/Jl3iRnCFpe4
        9WQ+E4QtL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYKjTEtzB+PlJfGHGAU4GJV4eBuCJscKsSaWFVfmHmKU4GBWEuG1+TMpVog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGvFtx85U/pWgkqtU2
        VYemFBbOF1wpv9nnqOhPlxC7CbXy761PCkws9LSdaHjrpdtG+ddvHDQnfilWPCMRoMqxvr3P
        cz3rm7zLGxXTn/Nmb6qvEfD58yylRr71SXzvqpMu62Qn7VfbfGaz1/V9H7z/edQvWOOfY2bg
        WFuyZzunJ8eBRJGcZVOUWIozEg21mIuKEwF8DjjYrgIAAA==
X-CMS-MailID: 20191001233025epcas1p368ad4010f970639e933b2ed52f3f80d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212533epcas4p3e4968a3397caaf8682a56105cd061cad
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212533epcas4p3e4968a3397caaf8682a56105cd061cad@epcas4p3.samsung.com>
        <20190811212315.12689-11-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
> There are cases where unnecessary ACTMON interrupts could be avoided,
> like when one memory client device requests higher clock rate than the
> other or when clock rate is manually limited using sysfs devfreq
> parameters. These cases could be avoided by tuning upper watermark or
> disabling hardware events when min/max boosting thresholds are reached.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 87 ++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 43d50b4366dd..a2623de56d20 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -312,7 +312,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>  }
>  
>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> -					   struct tegra_devfreq_device *dev)
> +					   struct tegra_devfreq_device *dev,
> +					   unsigned long freq)
>  {
>  	unsigned long avg_dependency_freq, lower, upper;
>  
> @@ -320,6 +321,22 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  
>  	avg_dependency_freq = tegra_actmon_dev_avg_dependency_freq(tegra, dev);
>  
> +	/*
> +	 * If cumulative EMC frequency selection (MCALL / min_freq) is
> +	 * higher than the device's, then there is no need to set upper
> +	 * watermark to a lower value because it will result in unnecessary
> +	 * upper interrupts.
> +	 *
> +	 * Note that average watermarks are also updated after EMC
> +	 * clock rate change, hence if clock rate goes down, then the
> +	 * watermarks will be set in accordance to the new rate after
> +	 * changing the rate. There are other ways to achieve the same
> +	 * result, but this one is probably the least churning, although
> +	 * it may look a bit convoluted.
> +	 */
> +	if (freq * ACTMON_SAMPLING_PERIOD > upper)
> +		upper = freq * ACTMON_SAMPLING_PERIOD;
> +
>  	/*
>  	 * We want to get interrupts when MCCPU client crosses the
>  	 * dependency threshold in order to take into / out of account
> @@ -361,7 +378,18 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower, &upper);
>  
>  	delta = do_percent(upper - lower, dev->config->boost_up_threshold);
> -	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);


Also, this patch edits the added codes on front patch.
This code was added on patch5 and then delete it on this patch.
If it is not necessary, you can remove it on patch5 by refactoring.

> +
> +	/*
> +	 * The memory events count could go a bit higher than the maximum
> +	 * defined by the OPPs, hence make the upper watermark infinitely
> +	 * high to avoid unnecessary upper interrupts in that case.
> +	 */
> +	if (freq == tegra->max_freq)
> +		upper = ULONG_MAX;
> +	else
> +		upper = lower + delta;
> +
> +	device_writel(dev, upper, ACTMON_DEV_UPPER_WMARK);

I think that the changes of tegra_devfreq_update_avg_wmark() on this patch
can be merged to patch5.

>  
>  	/*
>  	 * Meanwhile the lower mark is based on the average value
> @@ -379,6 +407,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
>  	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
> +	unsigned long freq;
>  
>  	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
> @@ -389,8 +418,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
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
> @@ -412,6 +443,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  		dev->boost_freq = do_percent(dev->boost_freq,
>  					     dev->config->boost_down_coeff);
>  
> +		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> +
>  		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
>  			dev->boost_freq = 0;
>  	}
> @@ -427,8 +460,16 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	}
>  
>  	/* no boosting => no need for consecutive-down interrupt */
> -	if (dev->boost_freq == 0)
> +	if (dev->boost_freq == 0) {
>  		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> +		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> +	}
> +
> +	/* boosting max-out => no need for consecutive-up interrupt */
> +	if (dev->boost_freq == tegra->max_freq) {
> +		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> +		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> +	}
>  
>  	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> @@ -437,8 +478,40 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
> +	u32 avg_count, avg_freq, old_upper, new_upper, dev_ctrl;
>  	unsigned long target_freq;
>  
> +	/*
> +	 * The avg_count / avg_freq is getting snapshoted on device's
> +	 * interrupt, but there are cases where actual value need to
> +	 * be utilized on target's update, like CPUFreq boosting and
> +	 * overriding the min freq via /sys/class/devfreq/devfreq0/min_freq
> +	 * because we're optimizing the upper watermark based on the
> +	 * actual EMC frequency. This means that interrupt may be
> +	 * inactive for a long time and thus making snapshoted value
> +	 * outdated.
> +	 */
> +	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
> +	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> +
> +	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
> +	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
> +
> +	/* similar to ISR, see comments in actmon_isr_device() */
> +	if (old_upper != new_upper) {
> +		if (dev->boost_freq == tegra->max_freq) {
> +			dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
> +
> +			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> +			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> +
> +			device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
> +		}
> +
> +		dev->avg_freq = avg_freq;
> +		dev->boost_freq = 0;
> +	}
> +
>  	target_freq = dev->avg_freq + dev->boost_freq;
>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>  
> @@ -506,7 +579,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> -		tegra_devfreq_update_avg_wmark(tegra, dev);
> +		tegra_devfreq_update_avg_wmark(tegra, dev, freq);
>  		tegra_devfreq_update_wmark(tegra, dev, freq);
>  	}
>  
> @@ -522,7 +595,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
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
