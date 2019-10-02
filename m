Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2CC8CD8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfJBP1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 11:27:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45245 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJBP1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 11:27:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so17555312ljb.12;
        Wed, 02 Oct 2019 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XkppJh76zQG+z7eHKGe6Lr4cdpRntCx0CAPy1aKT+o=;
        b=USgJeNCBFzPWJL/hQ3Vc4ReNbEWrli2P+F+WwjERjspXI2L2TWYRsOiHFFUHxL7BDG
         zbpVRQb1uhBJ6g+l+XaTP5fXmepaNKoGt4xVxhc2ge9jmjiIzUfY/IfZ1W+NT8+zRLPV
         9HkdecKIDXcJaRKTFz0We4WRAWj5kwLa0+MTC9vdK1V2uXN/x4E2+y0I6Rm/Ivw7Vvvl
         Bdnp7NZi9kbuIDkqHj1McmvzF7YUS9kYjxK0mEZ6c5BDUrMa7ol1SIBnZ5VyCXB5bmAJ
         v3REbZn4o6wmVD6WQHllWbFTv+Ul/ObtXD76zSaRbzEwkuiSBZBT6435SY2qer2+VTlx
         6TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XkppJh76zQG+z7eHKGe6Lr4cdpRntCx0CAPy1aKT+o=;
        b=fA5pKi634bAMBmRSwy6lK/pfWNqeWiapc+4LHhMyBWCVicPK5ERSwBVHsTJ/MHAANA
         RzLg3/mlyakkfSLpfJ0le/SLjmawyKFc5RDawlObndDjOq8Flx9Qx73/cMV0o05Vl0E3
         Lyp3mJsnpS5iPmjAOMlyrcddBeDzR3heEt5UiTbVdSCAU1XGg5bB3tN4MIWqf++8k896
         9N9NEMurM/SWxissGvJZXOQaTawzs2jqmrv9OH4F4tYBdY2JyXP89QYJfCijsx2OqUq3
         pcLM8Vgu7WpVitUsr5S0AMGP5swbxYBm73+GkekFHjJ7WpFz16ukrREftlkF2k5A/mtd
         gCoA==
X-Gm-Message-State: APjAAAWpH8fokZaUYxFc4gmazSlnopoQs9icyXeAejaiVIm0hytpZAcX
        Z6nPCwDIpzWAYzYbpeR7rULp4xlE
X-Google-Smtp-Source: APXvYqzmoB9nbALd/RFjqZlRIZbc7MHa/7A/ZgwUC7tO94MzSmt1z1gS1hiMfRbQ+wTs3gc1k4u7DA==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr2942331ljg.119.1570030066891;
        Wed, 02 Oct 2019 08:27:46 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id v1sm4707924lfe.34.2019.10.02.08.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 08:27:46 -0700 (PDT)
Subject: Re: [PATCH v6 18/19] PM / devfreq: tegra30: Support variable polling
 interval
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
 <CGME20190811212509epcas4p20ec245213cedfcc066f7b0032b912a39@epcas4p2.samsung.com>
 <20190811212315.12689-19-digetx@gmail.com>
 <721c4dd0-d667-f83d-64b5-74e4b58a7a1c@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a800b077-3d01-78d8-2fb4-bec82c796b45@gmail.com>
Date:   Wed, 2 Oct 2019 18:27:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <721c4dd0-d667-f83d-64b5-74e4b58a7a1c@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.10.2019 03:18, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
>> The ACTMON governor is interrupt-driven and currently hardware's polling
>> interval is fixed to 16ms in the driver. Devfreq supports variable polling
>> interval by the generic governors, let's re-use the generic interface for
>> changing of the polling interval. Now the polling interval can be changed
>> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 71 ++++++++++++++++++++++---------
>>  1 file changed, 50 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 8adc0ff48b45..e30314bd571a 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/irq.h>
>> +#include <linux/jiffies.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>> @@ -236,7 +237,7 @@ tegra_actmon_dev_avg_dependency_freq(struct tegra_devfreq *tegra,
>>  				     struct tegra_devfreq_device *dev)
>>  {
>>  	return dev->config->avg_dependency_threshold /
>> -		ACTMON_SAMPLING_PERIOD;
>> +		tegra->devfreq->profile->polling_ms;
>>  }
>>  
>>  static unsigned long
>> @@ -314,8 +315,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
>>  	 */
>>  	*upper = tegra_actmon_account_cpu_freq(tegra, dev, *upper);
>>  
>> -	*lower *= ACTMON_SAMPLING_PERIOD;
>> -	*upper *= ACTMON_SAMPLING_PERIOD;
>> +	*lower *= tegra->devfreq->profile->polling_ms;
>> +	*upper *= tegra->devfreq->profile->polling_ms;
>>  }
>>  
>>  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>> @@ -341,8 +342,8 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  	 * result, but this one is probably the least churning, although
>>  	 * it may look a bit convoluted.
>>  	 */
>> -	if (freq * ACTMON_SAMPLING_PERIOD > upper)
>> -		upper = freq * ACTMON_SAMPLING_PERIOD;
>> +	if (freq * tegra->devfreq->profile->polling_ms > upper)
>> +		upper = freq * tegra->devfreq->profile->polling_ms;
>>  
>>  	/*
>>  	 * We want to get interrupts when MCCPU client crosses the
>> @@ -420,7 +421,7 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>  	dev_ctrl = device_readl(dev, ACTMON_DEV_CTRL);
>>  
>> -	dev->avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
>> +	dev->avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
>>  
>>  	avg_intr_mask = ACTMON_DEV_INTR_AVG_BELOW_WMARK |
>>  			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
>> @@ -499,7 +500,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>>  	 * outdated.
>>  	 */
>>  	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>> -	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
>> +	avg_freq = avg_count / tegra->devfreq->profile->polling_ms;
>>  
>>  	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
>>  	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
>> @@ -675,7 +676,7 @@ static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>>  	 * here for too long, otherwise CPUFreq's core will complain with a
>>  	 * warning splat.
>>  	 */
>> -	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
>> +	delay = msecs_to_jiffies(tegra->devfreq->profile->polling_ms);
>>  	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
>>  
>>  	return NOTIFY_OK;
>> @@ -690,7 +691,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  	dev->boost_freq = 0;
>>  
>>  	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>> -	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
>> +	device_writel(dev, dev->avg_freq * tegra->devfreq->profile->polling_ms,
>>  		      ACTMON_DEV_INIT_AVG);
>>  
>>  	tegra_devfreq_update_avg_wmark(tegra, dev, dev->avg_freq);
>> @@ -725,7 +726,14 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  	unsigned int i;
>>  	int err;
>>  
>> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>> +	if (!tegra->devfreq->stop_polling)
> 
> I don't prefer to change the 'stop_polling' on each device driver direclty
> without devfreq interface. Don't access it directly.

Hmm.. okay. Please see more comments below.

>> +		return 0;
>> +
>> +	tegra->devfreq->previous_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>> +	tegra->devfreq->last_stat_updated = jiffies;
>> +	tegra->devfreq->stop_polling = false;
> 
> ditto.
> 
>> +
>> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>>  		      ACTMON_GLB_PERIOD_CTRL);
>>  
>>  	/*
>> @@ -776,6 +784,11 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  {
>>  	unsigned int i;
>>  
>> +	if (tegra->devfreq->stop_polling)
> 
> ditto.
> 
>> +		return;
>> +
>> +	mutex_unlock(&tegra->devfreq->lock);
>> +
>>  	disable_irq(tegra->irq);
>>  
>>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
>> @@ -783,10 +796,16 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  
>>  	cancel_delayed_work_sync(&tegra->cpufreq_update_work);
>>  
>> +	mutex_lock(&tegra->devfreq->lock);
>> +
>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>>  		tegra_actmon_stop_device(&tegra->devices[i]);
>>  
>>  	clk_notifier_unregister(tegra->emc_clock, &tegra->clk_rate_change_nb);
>> +
>> +	devfreq_update_status(tegra->devfreq, tegra->devfreq->previous_freq);
>> +
>> +	tegra->devfreq->stop_polling = true;
> 
> ditto.
> 
>>  }
>>  
>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>> @@ -846,7 +865,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>  
>>  	/* Number of cycles in a sampling period */
>> -	stat->total_time = cur_freq * ACTMON_SAMPLING_PERIOD;
>> +	stat->total_time = cur_freq * tegra->devfreq->profile->polling_ms;
>>  
>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>  
>> @@ -854,7 +873,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  }
>>  
>>  static struct devfreq_dev_profile tegra_devfreq_profile = {
>> -	.polling_ms	= 0,
>> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>>  	.target		= tegra_devfreq_target,
>>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>>  };
>> @@ -895,8 +914,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  					unsigned int event, void *data)
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>> +	unsigned int new_delay, *delay_ptr = data;
>>  	int ret = 0;
>>  
>> +	mutex_lock(&devfreq->lock);
>> +
>>  	/*
>>  	 * Couple device with the governor early as it is needed at
>>  	 * the moment of governor's start (used by ISR).
>> @@ -905,26 +927,33 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  
>>  	switch (event) {
>>  	case DEVFREQ_GOV_START:
>> -		devfreq_monitor_start(devfreq);
>> +		devfreq->stop_polling = true;
> 
> It is not proper to initialize the 'stop_polling' on device driver directly.
> 
>> +		/* fall through */
>> +	case DEVFREQ_GOV_RESUME:
>>  		ret = tegra_actmon_start(tegra);
>>  		break;
>>  
>>  	case DEVFREQ_GOV_STOP:
>> -		tegra_actmon_stop(tegra);
>> -		devfreq_monitor_stop(devfreq);
> 
> Why do you remove them?

Becasue DEVFREQ_GOV_STOP and DEVFREQ_GOV_SUSPEND are doing the same now:

	case DEVFREQ_GOV_STOP:
		/* fall through */
	case DEVFREQ_GOV_SUSPEND:
		tegra_actmon_stop(tegra);
		break;

>> -		break;
>> -
>> +		/* fall through */
>>  	case DEVFREQ_GOV_SUSPEND:
>>  		tegra_actmon_stop(tegra);
>> -		devfreq_monitor_suspend(devfreq);
> 
> Why do you remove it?

a) it takes the same mutex devfreq->lock as tegra_governor_event_handler()
b) the devfreq's manual polling isn't needed for this driver and thus
devfreq->work is unwanted
c) this patch makes tegra_actmon_stop() to replicate what
devfreq_monitor_suspend() does

It looks like it will be better to add new generic events for the
governors, like DEVFREQ_GOV_START/STOP_POLLING. Then this driver will be
able to customize start/stop of the polling, while software governors
will utilize some new default helpers that will start/stop the polling
work. What do you think?

[snip]
