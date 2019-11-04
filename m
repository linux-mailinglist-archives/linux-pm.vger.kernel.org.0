Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21075ED7D0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 03:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfKDCrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 21:47:53 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10441 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfKDCrw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 21:47:52 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191104024749epoutp0372821210bb0eb59a920d3b0a9a50a40a~T1bU5h1VJ0848108481epoutp037
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 02:47:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191104024749epoutp0372821210bb0eb59a920d3b0a9a50a40a~T1bU5h1VJ0848108481epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572835669;
        bh=fYWSpwZlP/iNujNTQaMLhVz9/NfQQW5rG5wTrPipJ4Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C0adjasr1yRDTZy8PDr7lEfhQ1Pj5Oy89jrY6hXYvCv8V0SXhq0wD7dbXQtMpJaUl
         McUCHSZh/KvMAZSjNBg6+frcDy7K7diG7+3D/HwrZQprxG3A/qvTJ4davSM3CTrV3F
         vY4IlK5N9Ubbh7D+EQP2MlR0BsNPC4Eo90JmUc9w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191104024748epcas1p414476f13b7f75e36d7a2f8812b3b8cbe~T1bUZ-omn1426114261epcas1p4k;
        Mon,  4 Nov 2019 02:47:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 475xzk2TQWzMqYkd; Mon,  4 Nov
        2019 02:47:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.86.04144.1519FBD5; Mon,  4 Nov 2019 11:47:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191104024744epcas1p2c15fcfdbe0e55acba5052756a70f36bc~T1bQw-6Sw0527505275epcas1p2n;
        Mon,  4 Nov 2019 02:47:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191104024744epsmtrp194a130b2de9da90128fe44c272a9f2b7~T1bQwL7i92402124021epsmtrp13;
        Mon,  4 Nov 2019 02:47:44 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-22-5dbf9151c023
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.10.24756.0519FBD5; Mon,  4 Nov 2019 11:47:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191104024744epsmtip2095fbd7ecfc64cce8757cc1d9f0f8254~T1bQhonhl0046000460epsmtip2b;
        Mon,  4 Nov 2019 02:47:44 +0000 (GMT)
Subject: Re: [PATCH v8 16/18] PM / devfreq: tegra30: Support variable
 polling interval
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e3967b07-b53f-0d9c-8f1b-bad238c4ef68@samsung.com>
Date:   Mon, 4 Nov 2019 11:53:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103204130.2172-17-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUiTcRjH+W2vv71Ws7fZ8Tio1msUGebe5uy1NDosRmkZUZRk9uJe3HAX
        e6dlp6VYSnaghK2ysEYeRFRLVLLVFEw7MMWIYp1idtBl647a9hb53+e5n+/vIKWKK1hJGi0O
        3m7hTDQeQTS2zYiNXXXYk6n+1kiyDR+eI7bYWUOwt/e8kbG9LccxO1TejtjST07Mfn7RhdiH
        u2sxe3tgOfutpZpgD5zrwQtG6pp8Z5Cu2emT6cqL3mKds+Qq1h1w1yPd0MVJ6TgjN8nAc3re
        ruIt2Va90ZKTTC9fnbU4S5ugZmKZRHYOrbJwZj6ZTklNj11qNAXWo1X5nCkv4ErnBIGOm59k
        t+Y5eJXBKjiSad6mN9kSbbMEzizkWXJmZVvNcxm1erY2kLgp1/Coo1dq6162paFwkChEHUll
        KJwEKh6u/3yGy9AIUkE1IegqvSYTjY8IbtZXhYnGZwSXrhYRZYgMlXR5p4n+VgS/Oo5IReMd
        gt+1r4lg30hqHRz/0RYKjKX6JdDaXhwKSKn10NbcIAkypmLAM3gfB3k0NQX6vj5HQZZT86HO
        /R4HpxHUVHh/Li2I4wI9b/o5MWMMdB7tD3UMpxKg4lWjROw+AR70n/zLk6Ho8rHQCkBVyODF
        QDUWNaeA5/4lJHIkvOpwy0RWwsuDJX95G9R1tmOxeB8Ct6c7TAxowOOqkAQXklIz4HxLnOie
        As0/TiBxcAS89e8PEw9LDvtKFGJKNPQ+8UlEjoLTe0vxIUQ7h8lxDpPgHCbB+X/YKUTUo/G8
        TTDn8AJjY4Zf9kUUerkx2iZUeSfViygS0aPkg+GeTEUYly8UmL0ISCk9Vn63qjVTIddzBVt5
        uzXLnmfiBS/SBs76sFQ5Ltsa+AcWRxajna3RaNh4JkHLMPQE+cKzrkwFlcM5+Fyet/H2f3US
        MlxZiKqMqP5ob9rQvDFRhwxxS4TWtSuMGv9AoiHme93Ogh3lrv33bnm8GYuwa8FApTFq58GF
        q0f/SnNVdONa/RrltE0RS/Nf1vw+pZ94w1Lkd6tnYv/jlNQvG+NxwgUw9Gzd7tpQ0+Wb2zdq
        l7ozomQlL3nKGanNF4pV0dPjlvgmfVlFE4KBY2KkdoH7A+bym3TPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG7AxP2xBl8Palis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFt+en2K0uN24gs3i7DNvi5+75rFY9K29xObA7bHj7hJG
        j52z7rJ79Da/Y/OY1baPzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy7h2/zFxwwatidcML
        lgbG4zZdjBwcEgImEqcOqXUxcnIICexmlDjV4QNiSwhISky7eJQZokRY4vDh4i5GLqCSt4wS
        feuusILUCAtESCy+f5cVJCEi8IxJYuHenUwgCWaBSImeuVvYIDq2MEo0HHvJDpJgE9CS2P/i
        BhuIzS+gKHH1x2NGEJtXwE5i5ZYPbCDbWARUJD6s9QUJiwIteL79BlSJoMTJmU9YQGxOATOJ
        ya+2Qe1Sl/gz7xIzhC0ucevJfKi4vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5N
        zy02LDDMSy3XK07MLS7NS9dLzs/dxAiOPS3NHYyXl8QfYhTgYFTi4X3BuT9WiDWxrLgy9xCj
        BAezkgjvxRl7Y4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLg
        lGpgtM3aIrht04fJU3UKp3gcDZsXHKmkLmV9+DNjwoVkCQ81s5j0N4c/aOtffu0TWyjLdjS3
        9uZse9aJOkcnn3Flqc5RDp9YMCG+Nzahx99P9Nnz8Cmfunj5c7P3O5y4tIJvznyuO7/j13Db
        /nq0nvtX777Xn/9tEN3zS2Bz0MbfbD7JehYz+o57KbEUZyQaajEXFScCAHJDtJG5AgAA
X-CMS-MailID: 20191104024744epcas1p2c15fcfdbe0e55acba5052756a70f36bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191103204245epcas4p48f5ab2a36b3728439799adb41fed6a24
References: <20191103204130.2172-1-digetx@gmail.com>
        <CGME20191103204245epcas4p48f5ab2a36b3728439799adb41fed6a24@epcas4p4.samsung.com>
        <20191103204130.2172-17-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 11. 4. 오전 5:41, Dmitry Osipenko wrote:
> The ACTMON governor is interrupt-driven and currently hardware's polling
> interval is fixed to 16ms in the driver. Devfreq supports variable polling
> interval by the generic governors, let's re-use the generic interface for
> changing of the polling interval. Now the polling interval can be changed
> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 83 +++++++++++++++++++++++--------
>  1 file changed, 61 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 852bde6249c7..9c645e83ef8b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -96,9 +96,10 @@ struct tegra_devfreq_device_config {
>  	unsigned int	boost_down_threshold;
>  
>  	/*
> -	 * Threshold of activity (cycles) below which the CPU frequency isn't
> -	 * to be taken into account. This is to avoid increasing the EMC
> -	 * frequency when the CPU is very busy but not accessing the bus often.
> +	 * Threshold of activity (cycles translated to kHz) below which the
> +	 * CPU frequency isn't to be taken into account. This is to avoid
> +	 * increasing the EMC frequency when the CPU is very busy but not
> +	 * accessing the bus often.
>  	 */
>  	u32		avg_dependency_threshold;
>  };
> @@ -126,7 +127,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>  		.boost_down_coeff = 90,
>  		.boost_up_threshold = 27,
>  		.boost_down_threshold = 10,
> -		.avg_dependency_threshold = 50000,
> +		.avg_dependency_threshold = 5 * KHZ,

nitpick.
Actually, this change is not related to this patch.
Even if it is trivial, it is not proper.

>  	},
>  };
>  
> @@ -208,9 +209,16 @@ static void device_writel(struct tegra_devfreq_device *dev, u32 val,
>  	writel_relaxed(val, dev->regs + offset);
>  }
>  
> -static unsigned long do_percent(unsigned long val, unsigned int pct)
> +static unsigned long do_percent(unsigned long long val, unsigned int pct)
>  {
> -	return val * pct / 100;
> +	val = val * pct;
> +	do_div(val, 100);
> +
> +	/*
> +	 * High freq + high boosting percent + large polling interval are
> +	 * resulting in integer overflow when watermarks are calculated.
> +	 */
> +	return min_t(u64, val, U32_MAX);
>  }
>  
>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
> @@ -218,8 +226,9 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  {
>  	u32 avg = dev->avg_count;
>  	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
>  
> +	avg = min(dev->avg_count, U32_MAX - band);
>  	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>  
>  	avg = max(dev->avg_count, band);
> @@ -229,7 +238,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  				       struct tegra_devfreq_device *dev)
>  {
> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  
>  	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
>  		      ACTMON_DEV_UPPER_WMARK);
> @@ -308,10 +317,9 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>  	unsigned int avg_sustain_coef;
>  	unsigned long target_freq;
>  
> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	target_freq = do_percent(target_freq, avg_sustain_coef);
> -	target_freq += dev->boost_freq;
>  
>  	return target_freq;
>  }
> @@ -322,15 +330,18 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>  	unsigned long cpu_freq = 0;
>  	unsigned long static_cpu_emc_freq = 0;
>  
> -	if (dev->config->avg_dependency_threshold) {
> +	dev->target_freq = actmon_device_target_freq(tegra, dev);
> +
> +	if (dev->config->avg_dependency_threshold &&
> +	    dev->config->avg_dependency_threshold <= dev->target_freq) {

This changes are related to polling interval change at the run time?
This patch touched the 'avg_dependency_threshold'. It is related to the 
dynamic change of polling interval?

>  		cpu_freq = cpufreq_quick_get(0);
>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> -	}
>  
> -	dev->target_freq = actmon_device_target_freq(tegra, dev);
> -
> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
> +		dev->target_freq += dev->boost_freq;
>  		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
> +	} else {
> +		dev->target_freq += dev->boost_freq;
> +	}

ditto. This changes are related to polling interval change at the run time?

>  }
>  
>  static irqreturn_t actmon_thread_isr(int irq, void *data)
> @@ -396,15 +407,16 @@ static unsigned long
>  tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>  				  unsigned int cpu_freq)
>  {
> +	struct tegra_devfreq_device *dev = &tegra->devices[MCCPU];
>  	unsigned long static_cpu_emc_freq, dev_freq;
>  
> +	dev_freq = actmon_device_target_freq(tegra, dev);
> +
>  	/* check whether CPU's freq is taken into account at all */
> -	if (tegra->devices[MCCPU].avg_count <
> -	    tegra->devices[MCCPU].config->avg_dependency_threshold)
> +	if (dev_freq < dev->config->avg_dependency_threshold)

ditto.

>  		return 0;
>  
>  	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
> -	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
>  
>  	if (dev_freq >= static_cpu_emc_freq)
>  		return 0;
> @@ -465,7 +477,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  
>  	dev->target_freq = tegra->cur_freq;
>  
> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>  
>  	tegra_devfreq_update_avg_wmark(tegra, dev);
> @@ -506,7 +518,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	unsigned int i;
>  	int err;
>  
> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> +	if (!tegra->devfreq->profile->polling_ms || tegra->cur_freq)
> +		return 0;
> +
> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
>  	/*
> @@ -551,11 +566,16 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  
> +	tegra->cur_freq = 0;
> +
>  	return err;
>  }
>  
>  static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  {
> +	if (!tegra->devfreq->profile->polling_ms || !tegra->cur_freq)
> +		return;
> +
>  	disable_irq(tegra->irq);
>  
>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
> @@ -566,6 +586,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  	tegra_actmon_stop_devices(tegra);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
> +
> +	tegra->cur_freq = 0;
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> @@ -625,7 +647,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
> +	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> @@ -633,7 +655,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  }
>  
>  static struct devfreq_dev_profile tegra_devfreq_profile = {
> -	.polling_ms	= 0,
> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>  };
> @@ -673,6 +695,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> +	unsigned int *new_delay = data;
>  	int ret = 0;
>  
>  	/*
> @@ -692,6 +715,21 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
> +	case DEVFREQ_GOV_INTERVAL:
> +		/*
> +		 * ACTMON hardware supports up to 256 milliseconds for the
> +		 * sampling period.
> +		 */
> +		if (*new_delay > 256) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		tegra_actmon_stop(tegra);
> +		devfreq_interval_update(devfreq, new_delay);
> +		ret = tegra_actmon_start(tegra);
> +		break;
> +
>  	case DEVFREQ_GOV_SUSPEND:
>  		tegra_actmon_stop(tegra);
>  		devfreq_monitor_suspend(devfreq);
> @@ -711,6 +749,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
>  	.immutable = true,
> +	.interrupt_driven = true,
>  };
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
