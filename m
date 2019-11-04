Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB3EE2AB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 15:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfKDOgO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 09:36:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40106 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfKDOgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 09:36:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so11316881ljg.7;
        Mon, 04 Nov 2019 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gPQQP/qjmg2dlwkav1DuOwvLlvZF9FO9IP7DPZJ9/Vw=;
        b=W+o9FB+Fq9eKA7uy2HKHD5wY12WjKnRrh0ZtbuTH6knWzG9OwbCEmD0j+dD+uJ66bs
         fICgT1ozhtrQqWTVUa+Sfsuytee5HdjzhZpB65wwhCiyJXhYeoowuVIc0f4LCnl45LOf
         bMnz5HcxX2kYs86GFph90NEKcpM8ZhIwGSAxZv71VNSIQzGLswCXBONr+HURt7bZ7dv+
         F5T3xZxBs8V4sBU5xfQ9Si+hbeLn/N3XO/ZbAnQuy5EhlSy+eg+ONzI9e2obzeqWNGZM
         qtIoIgob0LFWcHNRxIFiswVrq+4ox6jL7BSMOY/+f//sb5GzwZ8/x/eVEyxTJJ0IkDK5
         DAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPQQP/qjmg2dlwkav1DuOwvLlvZF9FO9IP7DPZJ9/Vw=;
        b=hLOSY2BvjH4eIWVHJ3BLN2iXRAlFzZPQV+cQJvlr0BZH8cKHzNkLWqy31WCCnl7Lu4
         KkumAboWFiF7QMy103gPTaO/RJb1AGnA4pV5U+HnRwazNCqG22Y3Wm7jR5XwF2yOKZLn
         68EaXNbeaxJt/gMyyKXkiewNb6gCa3Cv+Z+BxKvpaAK07DCSd7vp8LCT8iz185DIZpBx
         95SwPJWrPm4dAjSGZ+2aPgxrCQA106Ky2GLBn2ODTqCJJX1uljJXVcF1vtSWQ2Agv+RD
         bSmw8zpDytSBsU4jnCZ65amIvD6B/mXYdBsI5RJ67J0rJ5PKg8+G7pY/Q4OgvLbbyvd/
         rzlw==
X-Gm-Message-State: APjAAAV3U4L5X+5ve6QtysEorWSlC2ASMiezc7WiFI59coQpIktinSdl
        3yYTrDj/JVeRvvyuvGWjye0J9myE
X-Google-Smtp-Source: APXvYqx898kg3ng5mWaMp9dykrgsu5c8WFqffRShXuH/K5s0D2gHKY8hx5168mIXkWDTqw43eYd8dQ==
X-Received: by 2002:a05:651c:120c:: with SMTP id i12mr13367612lja.123.1572878169530;
        Mon, 04 Nov 2019 06:36:09 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id n11sm10190116lfd.88.2019.11.04.06.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:36:08 -0800 (PST)
Subject: Re: [PATCH v8 16/18] PM / devfreq: tegra30: Support variable polling
 interval
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191103204130.2172-1-digetx@gmail.com>
 <CGME20191103204245epcas4p48f5ab2a36b3728439799adb41fed6a24@epcas4p4.samsung.com>
 <20191103204130.2172-17-digetx@gmail.com>
 <e3967b07-b53f-0d9c-8f1b-bad238c4ef68@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a7c3215d-e663-1382-440a-4e37a27bf22f@gmail.com>
Date:   Mon, 4 Nov 2019 17:36:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e3967b07-b53f-0d9c-8f1b-bad238c4ef68@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.11.2019 05:53, Chanwoo Choi пишет:
> On 19. 11. 4. 오전 5:41, Dmitry Osipenko wrote:
>> The ACTMON governor is interrupt-driven and currently hardware's polling
>> interval is fixed to 16ms in the driver. Devfreq supports variable polling
>> interval by the generic governors, let's re-use the generic interface for
>> changing of the polling interval. Now the polling interval can be changed
>> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 83 +++++++++++++++++++++++--------
>>  1 file changed, 61 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 852bde6249c7..9c645e83ef8b 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -96,9 +96,10 @@ struct tegra_devfreq_device_config {
>>  	unsigned int	boost_down_threshold;
>>  
>>  	/*
>> -	 * Threshold of activity (cycles) below which the CPU frequency isn't
>> -	 * to be taken into account. This is to avoid increasing the EMC
>> -	 * frequency when the CPU is very busy but not accessing the bus often.
>> +	 * Threshold of activity (cycles translated to kHz) below which the
>> +	 * CPU frequency isn't to be taken into account. This is to avoid
>> +	 * increasing the EMC frequency when the CPU is very busy but not
>> +	 * accessing the bus often.
>>  	 */
>>  	u32		avg_dependency_threshold;
>>  };
>> @@ -126,7 +127,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>>  		.boost_down_coeff = 90,
>>  		.boost_up_threshold = 27,
>>  		.boost_down_threshold = 10,
>> -		.avg_dependency_threshold = 50000,
>> +		.avg_dependency_threshold = 5 * KHZ,
> 
> nitpick.
> Actually, this change is not related to this patch.
> Even if it is trivial, it is not proper.

As I wrote in the cover letter, this change is directly related to this
patch. It was missed in v7 by accident. Please see more comments below.

>>  	},
>>  };
>>  
>> @@ -208,9 +209,16 @@ static void device_writel(struct tegra_devfreq_device *dev, u32 val,
>>  	writel_relaxed(val, dev->regs + offset);
>>  }
>>  
>> -static unsigned long do_percent(unsigned long val, unsigned int pct)
>> +static unsigned long do_percent(unsigned long long val, unsigned int pct)
>>  {
>> -	return val * pct / 100;
>> +	val = val * pct;
>> +	do_div(val, 100);
>> +
>> +	/*
>> +	 * High freq + high boosting percent + large polling interval are
>> +	 * resulting in integer overflow when watermarks are calculated.
>> +	 */
>> +	return min_t(u64, val, U32_MAX);
>>  }
>>  
>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>> @@ -218,8 +226,9 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  {
>>  	u32 avg = dev->avg_count;
>>  	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
>> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
>> +	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
>>  
>> +	avg = min(dev->avg_count, U32_MAX - band);
>>  	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>>  
>>  	avg = max(dev->avg_count, band);
>> @@ -229,7 +238,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  				       struct tegra_devfreq_device *dev)
>>  {
>> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>> +	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>>  
>>  	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
>>  		      ACTMON_DEV_UPPER_WMARK);
>> @@ -308,10 +317,9 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>>  	unsigned int avg_sustain_coef;
>>  	unsigned long target_freq;
>>  
>> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>> -	target_freq += dev->boost_freq;
>>  
>>  	return target_freq;
>>  }
>> @@ -322,15 +330,18 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>>  	unsigned long cpu_freq = 0;
>>  	unsigned long static_cpu_emc_freq = 0;
>>  
>> -	if (dev->config->avg_dependency_threshold) {
>> +	dev->target_freq = actmon_device_target_freq(tegra, dev);
>> +
>> +	if (dev->config->avg_dependency_threshold &&
>> +	    dev->config->avg_dependency_threshold <= dev->target_freq) {
> 
> This changes are related to polling interval change at the run time?
> This patch touched the 'avg_dependency_threshold'. It is related to the 
> dynamic change of polling interval?
Before this patch the avg_dependency_threshold was defined in "cycle"
units and the the predefined value was fixed for the polling interval of
12ms.

After this patch the avg_dependency_threshold is redefined to use "kHz"
units which are independent of the polling interval.

So yes, this change is related to the dynamic changing of the polling
interval at run time.

>>  		cpu_freq = cpufreq_quick_get(0);
>>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>> -	}
>>  
>> -	dev->target_freq = actmon_device_target_freq(tegra, dev);
>> -
>> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
>> +		dev->target_freq += dev->boost_freq;
>>  		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
>> +	} else {
>> +		dev->target_freq += dev->boost_freq;
>> +	}
> 
> ditto. This changes are related to polling interval change at the run time?

It is possible to derive these changes into a separate patch. This
should help a tad with the following of the code changes. I'll do it in v9

>>  }
>>  
>>  static irqreturn_t actmon_thread_isr(int irq, void *data)
>> @@ -396,15 +407,16 @@ static unsigned long
>>  tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>>  				  unsigned int cpu_freq)
>>  {
>> +	struct tegra_devfreq_device *dev = &tegra->devices[MCCPU];
>>  	unsigned long static_cpu_emc_freq, dev_freq;
>>  
>> +	dev_freq = actmon_device_target_freq(tegra, dev);
>> +
>>  	/* check whether CPU's freq is taken into account at all */
>> -	if (tegra->devices[MCCPU].avg_count <
>> -	    tegra->devices[MCCPU].config->avg_dependency_threshold)
>> +	if (dev_freq < dev->config->avg_dependency_threshold)
> 
> ditto.
> 
>>  		return 0;
>>  
>>  	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>> -	dev_freq = actmon_device_target_freq(tegra, &tegra->devices[MCCPU]);
>>  
>>  	if (dev_freq >= static_cpu_emc_freq)
>>  		return 0;
>> @@ -465,7 +477,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  
>>  	dev->target_freq = tegra->cur_freq;
>>  
>> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>> +	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>>  
>>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>> @@ -506,7 +518,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  	unsigned int i;
>>  	int err;
>>  
>> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>> +	if (!tegra->devfreq->profile->polling_ms || tegra->cur_freq)
>> +		return 0;
>> +
>> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>>  		      ACTMON_GLB_PERIOD_CTRL);
>>  
>>  	/*
>> @@ -551,11 +566,16 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  
>>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>>  
>> +	tegra->cur_freq = 0;
>> +
>>  	return err;
>>  }
>>  
>>  static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  {
>> +	if (!tegra->devfreq->profile->polling_ms || !tegra->cur_freq)
>> +		return;
>> +
>>  	disable_irq(tegra->irq);
>>  
>>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
>> @@ -566,6 +586,8 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  	tegra_actmon_stop_devices(tegra);
>>  
>>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>> +
>> +	tegra->cur_freq = 0;
>>  }
>>  
>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>> @@ -625,7 +647,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>  
>>  	/* Number of cycles in a sampling period */
>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>> +	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
>>  
>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>  
>> @@ -633,7 +655,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  }
>>  
>>  static struct devfreq_dev_profile tegra_devfreq_profile = {
>> -	.polling_ms	= 0,
>> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>>  	.target		= tegra_devfreq_target,
>>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>>  };
>> @@ -673,6 +695,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  					unsigned int event, void *data)
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>> +	unsigned int *new_delay = data;
>>  	int ret = 0;
>>  
>>  	/*
>> @@ -692,6 +715,21 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  		devfreq_monitor_stop(devfreq);
>>  		break;
>>  
>> +	case DEVFREQ_GOV_INTERVAL:
>> +		/*
>> +		 * ACTMON hardware supports up to 256 milliseconds for the
>> +		 * sampling period.
>> +		 */
>> +		if (*new_delay > 256) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		tegra_actmon_stop(tegra);
>> +		devfreq_interval_update(devfreq, new_delay);
>> +		ret = tegra_actmon_start(tegra);
>> +		break;
>> +
>>  	case DEVFREQ_GOV_SUSPEND:
>>  		tegra_actmon_stop(tegra);
>>  		devfreq_monitor_suspend(devfreq);
>> @@ -711,6 +749,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>  	.get_target_freq = tegra_governor_get_target,
>>  	.event_handler = tegra_governor_event_handler,
>>  	.immutable = true,
>> +	.interrupt_driven = true,
>>  };
>>  
>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>
> 
> 

