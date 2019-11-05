Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BADEF43D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 04:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfKED4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 22:56:51 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59852 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfKED4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 22:56:51 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191105035648epoutp0378e9d88cc0a308b6d751cf4a0b3ebb2f~UKA123lJt0268202682epoutp03h
        for <linux-pm@vger.kernel.org>; Tue,  5 Nov 2019 03:56:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191105035648epoutp0378e9d88cc0a308b6d751cf4a0b3ebb2f~UKA123lJt0268202682epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572926208;
        bh=Ui9tA+UYBsSWnr3h2ocPjxY5hgU9p3yUegbC1G7sx0c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ii6cxuIzkYGcDAaCtz7QekfK2do2X0kPPpY5z3l06AV4N1N+7HFcGKwGEFiyCi3zR
         u4oSjbH8CW0PHj3H3u4sewC6KGxc/8OIDz2jfQUldeCgknyi9lSRzBHrKdTrSkcaKS
         Cp7AjXyiOMP+kZu6tkk06p5qtytfZ5sEDyGOLKWo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191105035647epcas1p4f7493dfe216fbf41cb90da6a34638c0b~UKA1Ur9u61811218112epcas1p4K;
        Tue,  5 Nov 2019 03:56:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 476bSs2tQ7zMqYkk; Tue,  5 Nov
        2019 03:56:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.71.04144.DF2F0CD5; Tue,  5 Nov 2019 12:56:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191105035645epcas1p4dbfd6dab703a4772b429ace9494982c8~UKAzCjy7z1662216622epcas1p4Y;
        Tue,  5 Nov 2019 03:56:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191105035645epsmtrp2804d038cebd6c38ba429e5d97bc21de1~UKAzBzvPM2632726327epsmtrp2G;
        Tue,  5 Nov 2019 03:56:45 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-a7-5dc0f2fdf45b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.8E.25663.DF2F0CD5; Tue,  5 Nov 2019 12:56:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191105035644epsmtip20aa390ddd2eea5621144376da067e42f~UKAyviGFG0976409764epsmtip2M;
        Tue,  5 Nov 2019 03:56:44 +0000 (GMT)
Subject: Re: [PATCH v9 17/19] PM / devfreq: tegra30: Support variable
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
Message-ID: <5e1246dc-0dce-1f05-49f7-354a581ae510@samsung.com>
Date:   Tue, 5 Nov 2019 13:02:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104215617.25544-18-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmnu7fTwdiDX5PFbdY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLL49P8VocbtxBZvF2WfeFj93zWOx6Ft7ic2B22PH3SWM
        Hjtn3WX36G1+x+Yxq20fm0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzth4cwFjwQKLiq7jm1kbGM/pdjFyckgImEg0
        rXnG0sXIxSEksINR4uKRG+wQzidGiYOfnkBlvjFKrJn9jwWm5caCOYwQib2MEqenXWCFcN4z
        Snx4t44RpEpYIELize4FYLNEBJ4wSew90gLWziwQKXF452omEJtNQEti/4sbbCA2v4CixNUf
        j8GaeQXsJP7+OsYOYrMIqEi8+jMJyObgEAUaevprIkSJoMTJmU/ARnIKmEvc+3mVEWK8uMSt
        J/OZIGx5ieats5lBbpAQmMwusaX5EyPECy4SX4/vZYWwhSVeHd/CDmFLSXx+t5cNwq6WWHny
        CBtEcwejxJb9F6AajCX2L53MBHIQs4CmxPpd+hBhRYmdv+dCHcEn8e5rDytIiYQAr0RHmxBE
        ibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQsMkaN7EyM4
        7WqZ7mCccs7nEKMAB6MSD++H9gOxQqyJZcWVuYcYJTiYlUR4L87YGyvEm5JYWZValB9fVJqT
        WnyI0RQY2BOZpUST84E5Ia8k3tDUyNjY2MLE0MzU0FBJnNdx+dJYIYH0xJLU7NTUgtQimD4m
        Dk6pBkZdFwfO1oA78/ZbpqzhPKRwO1yaLSir8ofAKneWm4IOrt+3LBAMKT+/XD3o02R99tOT
        0y4p5v9nVvm9NT4s+//kZ6/uzKmOWDh/3Vb/0pWtcrGzHoUGLRQpyDiwWsff480rdanozrvy
        9zU8Dpe5vnc7d0TvXYffyT0Vv4InnvuYX9auOO/0dnclluKMREMt5qLiRABC1R0i0QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvO7fTwdiDf4fZrFY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLL49P8VocbtxBZvF2WfeFj93zWOx6Ft7ic2B22PH3SWM
        Hjtn3WX36G1+x+Yxq20fm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBlbLy5gLFggUVF1/HN
        rA2M53S7GDk5JARMJG4smMPYxcjFISSwm1Fi6fIz7BAJSYlpF48ydzFyANnCEocPF0PUvGWU
        mLV0PwtIjbBAhMTNye/YQBIiAs+YJBbu3ckEkmAWiJTombuFDcQWEtjGKHF4cgmIzSagJbH/
        xQ2wOL+AosTVH48ZQWxeATuJv7+OgS1mEVCRePVnEpgtCrTg+fYbUDWCEidnPgFbzClgLnHv
        51VGiF3qEn/mXWKGsMUlbj2ZD3WDvETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5N
        zy02LDDKSy3XK07MLS7NS9dLzs/dxAiOPy2tHYwnTsQfYhTgYFTi4f3QfiBWiDWxrLgy9xCj
        BAezkgjvxRl7Y4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFw
        SjUwrj3zQoNrfeSByx5ZFh+iXZNSF+4X/7WQ9WSgZV+E5Y5O0XMndrWsvnnLcon6rtjvSuoM
        djOmTN2V9eaU7Tkll6ManfaMT7JsM58ZcF6e9O7D0n9/ckOV7UwfJE48Gi9RuHeqVbHJ5ogL
        auLNP3zvOotvdJvOc3lH4PfuKTMvRF15mCu6Yfs5GSWW4oxEQy3mouJEAOVHNnG7AgAA
X-CMS-MailID: 20191105035645epcas1p4dbfd6dab703a4772b429ace9494982c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191104221852epcas4p4a2994854fa50bded40d0a3550f6f7e10
References: <20191104215617.25544-1-digetx@gmail.com>
        <CGME20191104221852epcas4p4a2994854fa50bded40d0a3550f6f7e10@epcas4p4.samsung.com>
        <20191104215617.25544-18-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 11. 5. 오전 6:56, Dmitry Osipenko wrote:
> The ACTMON governor is interrupt-driven and currently hardware's polling
> interval is fixed to 16ms in the driver. Devfreq supports variable polling
> interval by the generic governors, let's re-use the generic interface for
> changing of the polling interval. Now the polling interval can be changed
> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 78 ++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 3bd920829bfd..e44f1a48f838 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>  
>  	unsigned int		irq;
> +
> +	bool			started;
>  };
>  
>  struct tegra_actmon_emc_ratio {
> @@ -209,18 +211,26 @@ static void device_writel(struct tegra_devfreq_device *dev, u32 val,
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
>  					   struct tegra_devfreq_device *dev)
>  {
> -	u32 avg = dev->avg_count;
>  	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
> +	u32 avg;
>  
> +	avg = min(dev->avg_count, U32_MAX - band);
>  	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>  
>  	avg = max(dev->avg_count, band);
> @@ -230,7 +240,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  				       struct tegra_devfreq_device *dev)
>  {
> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  
>  	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
>  		      ACTMON_DEV_UPPER_WMARK);
> @@ -309,7 +319,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>  	unsigned int avg_sustain_coef;
>  	unsigned long target_freq;
>  
> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>  
> @@ -469,7 +479,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  
>  	dev->target_freq = tegra->cur_freq;
>  
> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> +	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>  
>  	tegra_devfreq_update_avg_wmark(tegra, dev);
> @@ -505,12 +515,15 @@ static void tegra_actmon_stop_devices(struct tegra_devfreq *tegra)
>  	}
>  }
>  
> -static int tegra_actmon_start(struct tegra_devfreq *tegra)
> +static int tegra_actmon_resume(struct tegra_devfreq *tegra)
>  {
>  	unsigned int i;
>  	int err;
>  
> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> +	if (!tegra->devfreq->profile->polling_ms || !tegra->started)
> +		return 0;
> +
> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>  		      ACTMON_GLB_PERIOD_CTRL);
>  
>  	/*
> @@ -558,8 +571,26 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  	return err;
>  }
>  
> -static void tegra_actmon_stop(struct tegra_devfreq *tegra)
> +static int tegra_actmon_start(struct tegra_devfreq *tegra)
>  {
> +	int ret = 0;
> +
> +	if (!tegra->started) {
> +		tegra->started = true;
> +
> +		ret = tegra_actmon_resume(tegra);
> +		if (ret)
> +			tegra->started = false;
> +	}
> +
> +	return ret;
> +}
> +
> +static void tegra_actmon_pause(struct tegra_devfreq *tegra)
> +{
> +	if (!tegra->devfreq->profile->polling_ms || !tegra->started)
> +		return;
> +
>  	disable_irq(tegra->irq);
>  
>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
> @@ -572,6 +603,12 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>  }
>  
> +static void tegra_actmon_stop(struct tegra_devfreq *tegra)
> +{
> +	tegra_actmon_pause(tegra);
> +	tegra->started = false;
> +}
> +
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  				u32 flags)
>  {
> @@ -629,7 +666,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
> +	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> @@ -637,7 +674,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  }
>  
>  static struct devfreq_dev_profile tegra_devfreq_profile = {
> -	.polling_ms	= 0,
> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>  };
> @@ -677,6 +714,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> +	unsigned int *new_delay = data;
>  	int ret = 0;
>  
>  	/*
> @@ -696,6 +734,21 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
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
> +		tegra_actmon_pause(tegra);
> +		devfreq_interval_update(devfreq, new_delay);
> +		ret = tegra_actmon_resume(tegra);
> +		break;
> +
>  	case DEVFREQ_GOV_SUSPEND:
>  		tegra_actmon_stop(tegra);
>  		devfreq_monitor_suspend(devfreq);
> @@ -715,6 +768,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
>  	.immutable = true,
> +	.interrupt_driven = true,
>  };
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
