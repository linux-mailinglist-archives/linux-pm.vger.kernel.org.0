Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1DEC412
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfKANzR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:55:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45863 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKANzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:55:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so7256374lfa.12;
        Fri, 01 Nov 2019 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wJ8DQqrB7pmMixz1CBZ98UUR7nSyCCIA+w4JRokeNfw=;
        b=dPNCs6gwULwiAgvgo1hFPCmr4o9xEPz1Uh26uX9jrW/wv5d8TMG2nWb3R+umzvPgG3
         1eRVaHUKi4kA/5Wa+zpKREr1J+/cRnXN2nW7XBCrGpB0uNCqm6sGt48QGR0OjZG3C6Ls
         oapboPTCNWYNC595FVNCaq0mOo2/89IIhHURNupJ6aq0W65kYnQv9Ap4dNkT2jxUgYav
         u5bquz3iufKpFexRBYqjWbsrXOTMsXe5k8uoUPA+SeG+AgJd8L0dB7mDUvw4nhkQK89c
         AnnRUZ9LaJaymQYT7YwA9Kl7fVp1lJD6yoKY79xgA4QFA2fAJNkMmBQ3PBDKT5460mCV
         purA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJ8DQqrB7pmMixz1CBZ98UUR7nSyCCIA+w4JRokeNfw=;
        b=f7vNWXUnNU7IEtQIicCV3OEXbu7Oit90c5R55wpCc53fNutq2ISX5WyaIVb2DArpqO
         NANpeKlYBIa/uWqveNhbkQ+XkWvlvZcNSEBRzHQ4Wn+43BC+xxyitoOmHGkX4qdxheAv
         Vuxx1hyTiOpIL5/YrfrA02Hxj6uC51wYX3aKSSn+ADLm5b313i6+0vLjaDZPYREOhBqB
         uBdsuzlECPEduGEmOhALk6eMA0hhiViDUjmmvPy12N5G7nqDfMztbsfBruW13zsq/jnN
         S4TBw3uEOZCwJsqVKVeFHLIOyAnp9VhPApNeq6UVx5R/VIzO/GInYiBKuhc3l73jUpZp
         YsFg==
X-Gm-Message-State: APjAAAXIVNqJniPmKswI3agr3XCd9/uLn9ry4GK3kZ4w9Asg/qdb6drL
        bL7DE8nM0sgGEdn8sl3R1HeDPUeB
X-Google-Smtp-Source: APXvYqzpMAx8ZksmsiB4hgGKaRJEpJ02QnO6e9wZTNVaiHrTKuIIig3w16p76kcDKa826MF9dMBf/Q==
X-Received: by 2002:a19:6d19:: with SMTP id i25mr7418381lfc.178.1572616514188;
        Fri, 01 Nov 2019 06:55:14 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id b67sm6101429ljf.5.2019.11.01.06.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 06:55:13 -0700 (PDT)
Subject: Re: [PATCH v7 17/19] PM / devfreq: tegra30: Support variable polling
 interval
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029220019.26773-1-digetx@gmail.com>
 <CGME20191029220636epcas2p279bee6ee40d9253cdfbcf5d6da6b3a14@epcas2p2.samsung.com>
 <20191029220019.26773-18-digetx@gmail.com>
 <00ddcbd5-262b-2130-6242-b1ec364825f3@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a60d5949-a980-306a-e65a-6017b40a7321@gmail.com>
Date:   Fri, 1 Nov 2019 16:55:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <00ddcbd5-262b-2130-6242-b1ec364825f3@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2019 10:41, Chanwoo Choi пишет:
> On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
>> The ACTMON governor is interrupt-driven and currently hardware's polling
>> interval is fixed to 16ms in the driver. Devfreq supports variable polling
>> interval by the generic governors, let's re-use the generic interface for
>> changing of the polling interval. Now the polling interval can be changed
>> dynamically via /sys/class/devfreq/devfreq0/polling_interval.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 35 ++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index b745a973c35a..d0dd42856e5b 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -218,7 +218,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  {
>>  	u32 avg = dev->avg_count;
>>  	u32 avg_band_freq = tegra->max_freq * ACTMON_DEFAULT_AVG_BAND / KHZ;
>> -	u32 band = avg_band_freq * ACTMON_SAMPLING_PERIOD;
>> +	u32 band = avg_band_freq * tegra->devfreq->profile->polling_ms;
>>  
>>  	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
>>  
>> @@ -229,7 +229,7 @@ static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq *tegra,
>>  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  				       struct tegra_devfreq_device *dev)
>>  {
>> -	u32 val = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>> +	u32 val = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>>  
>>  	device_writel(dev, do_percent(val, dev->config->boost_up_threshold),
>>  		      ACTMON_DEV_UPPER_WMARK);
>> @@ -308,7 +308,7 @@ static unsigned long actmon_device_target_freq(struct tegra_devfreq *tegra,
>>  	unsigned int avg_sustain_coef;
>>  	unsigned long target_freq;
>>  
>> -	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>> +	target_freq = dev->avg_count / tegra->devfreq->profile->polling_ms;
>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>  	target_freq = do_percent(target_freq, avg_sustain_coef);
>>  	target_freq += dev->boost_freq;
>> @@ -465,7 +465,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  
>>  	dev->target_freq = tegra->cur_freq;
>>  
>> -	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
>> +	dev->avg_count = tegra->cur_freq * tegra->devfreq->profile->polling_ms;
>>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
>>  
>>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>> @@ -506,7 +506,11 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  	unsigned int i;
>>  	int err;
>>  
>> -	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>> +	if (!tegra->devfreq->profile->polling_ms ||
>> +	    tegra->devfreq->stop_polling)
> 
> I think that the access of 'devfreq->stop_polling' is not good
> on governor. It is possible to alter with DEVFREQ_GOV_START/STOP/SUSPEND/RESUME
> notification.

Could you please clarify what you're meaning by "alter with notification"?

Do you mean to have the start/stop state tracking done by the
tegra30-devfreq driver itself?

>> +		return 0;> +
>> +	actmon_writel(tegra, tegra->devfreq->profile->polling_ms - 1,
>>  		      ACTMON_GLB_PERIOD_CTRL);
>>  
>>  	/*
>> @@ -554,6 +558,10 @@ static int tegra_actmon_start(struct tegra_devfreq *tegra)
>>  
>>  static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  {
>> +	if (!tegra->devfreq->profile->polling_ms ||
>> +	    tegra->devfreq->stop_polling)
> 
> ditto.
> 
>> +		return;
>> +
>>  	disable_irq(tegra->irq);
>>  
>>  	cpufreq_unregister_notifier(&tegra->cpu_rate_change_nb,
>> @@ -623,7 +631,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>  
>>  	/* Number of cycles in a sampling period */
>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>> +	stat->total_time = tegra->devfreq->profile->polling_ms * cur_freq;
>>  
>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>  
>> @@ -631,7 +639,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  }
>>  
>>  static struct devfreq_dev_profile tegra_devfreq_profile = {
>> -	.polling_ms	= 0,
>> +	.polling_ms	= ACTMON_SAMPLING_PERIOD,
>>  	.target		= tegra_devfreq_target,
>>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>>  };
>> @@ -671,6 +679,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  					unsigned int event, void *data)
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>> +	unsigned int *new_delay = data;
>>  	int ret = 0;
>>  
>>  	/*
>> @@ -690,6 +699,17 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  		devfreq_monitor_stop(devfreq);
>>  		break;
>>  
>> +	case DEVFREQ_GOV_INTERVAL:
>> +		if (*new_delay > 256) {
> 
> Need to add the comment why the maximum delay is under 256 ms.

Okay, will add comment in v8. The 256ms max is the hardware's capability.
