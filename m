Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96ADC8A8A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBOGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 10:06:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33181 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOGa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 10:06:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so17276892ljd.0;
        Wed, 02 Oct 2019 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f8TmAkt4WsH1N0sba37uvaRLJhu+2pmQZnGHUoAuB7s=;
        b=cv6gpVhrhqD6vuOLF9pr2k24+yfJTXvbvFdfn97min5Izw2QEfqlwQ1bsd1T+bxWON
         RoENSTVIx0Z5oMt5gLw+SVhZTTQyEWPEjkBtYKMhVEbwiIExMERN+FrH1rs6fYr6iWdU
         GUldpvKfz+LhK7qHW5Qt6YiseNn2wklywFRK/Ig0LuOA1YQPAPEj1VYbuWV5LWXLMMAk
         nf584sEGbJ11rN+Vsa5ZK6EwHdmaIE81A1JRH601xWt6G/oTVRRREu2bJcXDF43WHT5s
         0obavulZvrK/OadA7FoBHksegibk6T461ZcBsFSCmgbLIogjL8Jif5mfGrYO9z+IfOcA
         U4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f8TmAkt4WsH1N0sba37uvaRLJhu+2pmQZnGHUoAuB7s=;
        b=GWM3ZRh1fwnrkWiisBcc94AOd5+2n6sVEG0AmHPCgEiNSEgKV5MEhJ4W26ZZFaSWqu
         7Y7UA87nAToqKKkeiA/mdTrh35BCaizseZy9xNXeXCB0Zssc0h/Zbr3fhpFDnZHK+/p7
         qPdDDWOqba2LCWVWnBIFjpDNHK0rMHCXuV8ed55KBgo9S4aydyVENQ/DrWFbnSb53tT8
         n7QpCJ2Vw20MIXb4qaaSodZkwM7L7Q+g8mHDzIhKnuJ3ZrG8o9ZfKi9YxU5/thDF6Il8
         oVTE48WIhbS/1+uAGY8MzxRNXOAduBHjqbEnzv0CMvHn5zjG3TSubBlH23IYuWbIKQkI
         OXbA==
X-Gm-Message-State: APjAAAUKC+X011Mj1H+eeWkHGedkCaAaNO/uSY8N64TZOkPIACHvJVP9
        f56ja9rY1qpK6RjUMeaqXwhGyfPS
X-Google-Smtp-Source: APXvYqxk+QHOFXlGClvSMrEIU7hB2ZW8mbYMxhqJVbpQplDjrgxG658UwICFAti9YjGmekJ2v3+lTQ==
X-Received: by 2002:a2e:442:: with SMTP id 63mr2664436lje.66.1570025186227;
        Wed, 02 Oct 2019 07:06:26 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.231])
        by smtp.googlemail.com with ESMTPSA id b15sm4683464lfj.84.2019.10.02.07.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:06:25 -0700 (PDT)
Subject: Re: [PATCH v6 11/19] PM / devfreq: tegra30: Use CPUFreq notifier
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
 <CGME20190811212534epcas4p415e9206019385d2bfb3be2c7a328a8df@epcas4p4.samsung.com>
 <20190811212315.12689-12-digetx@gmail.com>
 <2f7a0283-7433-b786-a8c3-7d711aafd721@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <57b2f772-8849-5180-262f-0ef8936e63bc@gmail.com>
Date:   Wed, 2 Oct 2019 17:06:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2f7a0283-7433-b786-a8c3-7d711aafd721@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.10.2019 03:02, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
>> The CPU's client need to take into account that CPUFreq may change
>> while memory activity not, staying high. Thus an appropriate frequency
>> notifier should be used in addition to the clk-notifier.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 173 ++++++++++++++++++++++++++----
>>  1 file changed, 153 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index a2623de56d20..a260812f7744 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_opp.h>
>>  #include <linux/reset.h>
>> +#include <linux/workqueue.h>
>>  
>>  #include "governor.h"
>>  
>> @@ -34,6 +35,8 @@
>>  #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
>>  #define ACTMON_DEV_CTRL_ENB					BIT(31)
>>  
>> +#define ACTMON_DEV_CTRL_STOP					0x00000000
>> +
>>  #define ACTMON_DEV_UPPER_WMARK					0x4
>>  #define ACTMON_DEV_LOWER_WMARK					0x8
>>  #define ACTMON_DEV_INIT_AVG					0xc
>> @@ -159,7 +162,10 @@ struct tegra_devfreq {
>>  
>>  	struct clk		*emc_clock;
>>  	unsigned long		max_freq;
>> -	struct notifier_block	rate_change_nb;
>> +	struct notifier_block	clk_rate_change_nb;
>> +
>> +	struct delayed_work	cpufreq_update_work;
>> +	struct notifier_block	cpu_rate_change_nb;
>>  
>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>>  
>> @@ -207,10 +213,10 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
>>  	return val * pct / 100;
>>  }
>>  
>> -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
>> +static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
>> +					    unsigned int cpu_freq)
>>  {
>>  	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>> -	unsigned int cpu_freq = cpufreq_quick_get(0);
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
>> @@ -244,7 +250,8 @@ tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
>>  		return target_freq;
>>  
>>  	if (dev->avg_freq > tegra_actmon_dev_avg_dependency_freq(tegra, dev))
>> -		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra);
>> +		static_cpu_emc_freq = actmon_cpu_to_emc_rate(
>> +						tegra, cpufreq_quick_get(0));
>>  	else
>>  		static_cpu_emc_freq = 0;
>>  
>> @@ -543,8 +550,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
>>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>>  }
>>  
>> -static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>> -				       unsigned long action, void *ptr)
>> +static int tegra_actmon_clk_notify_cb(struct notifier_block *nb,
>> +				      unsigned long action, void *ptr)
>>  {
>>  	struct clk_notifier_data *data = ptr;
>>  	struct tegra_devfreq_device *dev;
>> @@ -555,7 +562,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>>  	if (action != POST_RATE_CHANGE)
>>  		return NOTIFY_OK;
>>  
>> -	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
>> +	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
>>  
>>  	freq = data->new_rate / KHZ;
>>  
>> @@ -586,6 +593,94 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>>  	return NOTIFY_OK;
>>  }
>>  
>> +static void tegra_actmon_delayed_update(struct work_struct *work)
>> +{
>> +	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
>> +						   cpufreq_update_work.work);
>> +
>> +	mutex_lock(&tegra->devfreq->lock);
>> +	update_devfreq(tegra->devfreq);
>> +	mutex_unlock(&tegra->devfreq->lock);
>> +}
>> +
>> +static unsigned long
>> +tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>> +				  unsigned int cpu_freq)
>> +{
>> +	unsigned long freq, static_cpu_emc_freq;
>> +
>> +	/* check whether CPU's freq is taken into account at all */
>> +	freq = tegra_actmon_dev_avg_dependency_freq(tegra,
>> +						    &tegra->devices[MCCPU]);
>> +	if (tegra->devices[MCCPU].avg_freq <= freq)
>> +		return 0;
>> +
>> +	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>> +
>> +	/* compare static CPU-EMC freq with MCALL */
>> +	freq = tegra->devices[MCALL].avg_freq +
>> +	       tegra->devices[MCALL].boost_freq;
>> +
>> +	freq = tegra_actmon_upper_freq(tegra, freq);
>> +
>> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
>> +		return 0;
>> +
>> +	/* compare static CPU-EMC freq with MCCPU */
>> +	freq = tegra->devices[MCCPU].avg_freq +
>> +	       tegra->devices[MCCPU].boost_freq;
>> +
>> +	freq = tegra_actmon_upper_freq(tegra, freq);
>> +
>> +	if (freq == tegra->max_freq || freq >= static_cpu_emc_freq)
>> +		return 0;
>> +
>> +	return static_cpu_emc_freq;
>> +}
>> +
>> +static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>> +				      unsigned long action, void *ptr)
>> +{
>> +	struct cpufreq_freqs *freqs = ptr;
>> +	struct tegra_devfreq *tegra;
>> +	unsigned long old, new, delay;
>> +
>> +	if (action != CPUFREQ_POSTCHANGE)
>> +		return NOTIFY_OK;
>> +
>> +	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
>> +
>> +	/*
>> +	 * Quickly check whether CPU frequency should be taken into account
>> +	 * at all, without blocking CPUFreq's core.
>> +	 */
>> +	if (mutex_trylock(&tegra->devfreq->lock)) {
>> +		old = tegra_actmon_cpufreq_contribution(tegra, freqs->old);
>> +		new = tegra_actmon_cpufreq_contribution(tegra, freqs->new);
>> +		mutex_unlock(&tegra->devfreq->lock);
>> +
>> +		/*
>> +		 * If CPU's frequency shouldn't be taken into account at
>> +		 * the moment, then there is no need to update the devfreq's
>> +		 * state because ISR will re-check CPU's frequency on the
>> +		 * next interrupt.
>> +		 */
>> +		if (old == new)
>> +			return NOTIFY_OK;
>> +	}
>> +
>> +	/*
>> +	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
>> +	 * to allow asynchronous notifications. This means we can't block
>> +	 * here for too long, otherwise CPUFreq's core will complain with a
>> +	 * warning splat.
>> +	 */
>> +	delay = msecs_to_jiffies(ACTMON_SAMPLING_PERIOD);
>> +	schedule_delayed_work(&tegra->cpufreq_update_work, delay);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  					  struct tegra_devfreq_device *dev)
>>  {
>> @@ -617,9 +712,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  	device_writel(dev, val, ACTMON_DEV_CTRL);
>>  }
>>  
>> -static void tegra_actmon_start(struct tegra_devfreq *tegra)
>> +static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
>> +{
>> +	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
>> +	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>> +}
>> +
>> +static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  {
>>  	unsigned int i;
>> +	int err;
>>  
>>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>>  		      ACTMON_GLB_PERIOD_CTRL);
>> @@ -627,7 +729,30 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>>  		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
>>  
>> +	/*
>> +	 * We are estimating CPU's memory bandwidth requirement based on
>> +	 * amount of memory accesses and system's load, judging by CPU's
>> +	 * frequency. We also don't want to receive events about CPU's
>> +	 * frequency transaction when governor is stopped, hence notifier
>> +	 * is registered dynamically.
>> +	 */
>> +	err = cpufreq_register_notifier(&tegra->cpu_rate_change_nb,
>> +					CPUFREQ_TRANSITION_NOTIFIER);
>> +	if (err) {
>> +		dev_err(tegra->devfreq->dev.parent,
>> +			"Failed to register rate change notifier: %d\n", err);
>> +		goto err_stop;
>> +	}
>> +
>>  	enable_irq(tegra->irq);
>> +
>> +	return 0;
>> +
>> +err_stop:
>> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>> +		tegra_actmon_stop_device(&tegra->devices[i]);
> 
> nitpick:
> Why don't you contain this for loop statement in the tegra_actmon_stop_device()?
> I think that you can make it as following:
> 
> 	tegra_actmon_stop_device(struct tegra_devfreq *target);
> 		for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)> +				
> 			device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);              
> 			device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS); 

I'll change that in v7.

> Except for this, looks good to me. 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks!
