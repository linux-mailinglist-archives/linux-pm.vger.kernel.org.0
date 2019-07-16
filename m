Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D146A969
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGPNSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:18:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44790 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPNSH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:18:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so19900679ljc.11;
        Tue, 16 Jul 2019 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKGcUuJ4fxVi3WhAhqmDrQ7B5i1DMQmnWK9aYGNHR4I=;
        b=X7nkalrqYi7Onq5INv1L/lRXBZPeeQ3XhLVV5CjtREOMsB959XEVqcwmrGmjQB9x7u
         C8EqbqdgW9bYgmG0yynnMnvfFCIzP3Pndare3WwHkAO4L97OOuBIhwIAfpJgI02JIS3h
         5sV4qY08Dpb/kJ6eZimUCln+lTbJsNoyl5vO6M0ycU780KeuWlUkBFtGIkrBqDE6XqHL
         7+3S+BMHUJpPGBxH7SZ5ehM9NvV84zk0a7EwDW2i1Z7L/d59TCn21yKfj1A3wCUpQnIb
         TBWygPvIhBX3OwX6xAjmD9tvWbEMPGIYhytgyzpfzKIZFocraVB8UYMrAkWS9nTNtwqn
         fo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKGcUuJ4fxVi3WhAhqmDrQ7B5i1DMQmnWK9aYGNHR4I=;
        b=T7oElOh4khfAG/WTtlFSZFnP0viECp8H3OpZJEL7egKEXWoJs0eWQLtHRtPTRx9PZU
         UC0B6XOjYp1iRz6Nd+Unl3i5LXDl1tVtuwKJHmOzQHJdaaph9yLIOrPX0e8/L9NsOoyq
         tW0KLRV8TyWRhLYdIjUPjwgFLyfQCz+yRt0TXhXqnGdgJwHsGfzCuAoymCGKor7CoQLl
         Kfw8o0P7NXBFIapXbTLHdYzCs0+mWjrErD1Y3KmSZiZ/in6tyzaz5foszaiziOHzR+uk
         JQTZTteySFAjv90BpVnQJCkzJTS8N3EltpcBBXgsEzvmwiKZ4q+MdPK1ssVSN1OIqO0/
         OFZA==
X-Gm-Message-State: APjAAAVYk1FAkdY8JKbTax18EpfeF81K75J+3SAf7qJb1AuKTEc/VXsS
        YttnjVNZu9i+0W7mmOngUmnMH0lh
X-Google-Smtp-Source: APXvYqwD+2h4/sDLhibA5LoGD+P+/w1zFYPp7zmtaSFzfAHXKLBNA2Aq27VD9hAlN/vLqSXuDH6jtQ==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr12940890ljb.120.1563283084419;
        Tue, 16 Jul 2019 06:18:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id e26sm2870082lfc.68.2019.07.16.06.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:18:03 -0700 (PDT)
Subject: Re: [PATCH v4 07/24] PM / devfreq: tegra30: Use CPUFreq notifier
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223538epcas5p47ff4d1a90c3cfe7a5fb96108b1bd344a@epcas5p4.samsung.com>
 <20190707223303.6755-8-digetx@gmail.com>
 <c94da786-05b4-1604-d208-f73f32ea937d@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <23176828-02b8-7781-54f1-4dbf28e3098b@gmail.com>
Date:   Tue, 16 Jul 2019 16:18:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c94da786-05b4-1604-d208-f73f32ea937d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:08, Chanwoo Choi пишет:
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> The CPU's client need to take into account that CPUFreq may change
>> while memory activity not, staying high. Thus an appropriate frequency
>> notifier should be used in addition to the clk-notifier.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 105 +++++++++++++++++++++++++-----
>>  1 file changed, 88 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 2bf65409ddd8..48a799fa5f63 100644
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
>> @@ -154,7 +155,10 @@ struct tegra_devfreq {
>>  
>>  	struct clk		*emc_clock;
>>  	unsigned long		max_freq;
>> -	struct notifier_block	rate_change_nb;
>> +	struct notifier_block	clk_rate_change_nb;
>> +
>> +	struct work_struct	update_work;
> 
> nitpick.
> I think 'update_work' is not clear to indicate the work
> for changing the clock according to the cpu clock change.
> You better to change the name for more clearly.

Okay, I'll rename it to 'cpufreq_update_work' or something like that.

>> +	struct notifier_block	cpu_rate_change_nb;
>>  
>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>>  
>> @@ -456,8 +460,8 @@ static irqreturn_t actmon_thread_isr(int irq, void *data)
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
>> @@ -467,7 +471,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>>  	if (action != POST_RATE_CHANGE)
>>  		return NOTIFY_OK;
>>  
>> -	tegra = container_of(nb, struct tegra_devfreq, rate_change_nb);
>> +	tegra = container_of(nb, struct tegra_devfreq, clk_rate_change_nb);
>>  
>>  	/*
>>  	 * EMC rate could change due to three reasons:
>> @@ -496,6 +500,37 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>>  	return NOTIFY_OK;
>>  }
>>  
>> +static void tegra_actmon_delayed_update(struct work_struct *work)
>> +{
>> +	struct tegra_devfreq *tegra = container_of(work, struct tegra_devfreq,
>> +						   update_work);
>> +
>> +	mutex_lock(&tegra->devfreq->lock);
>> +	update_devfreq(tegra->devfreq);
>> +	mutex_unlock(&tegra->devfreq->lock);
>> +}
>> +
>> +static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
>> +				      unsigned long action, void *ptr)
>> +{
>> +	struct tegra_devfreq *tegra;
>> +
>> +	if (action != CPUFREQ_POSTCHANGE)
>> +		return NOTIFY_OK;
>> +
>> +	tegra = container_of(nb, struct tegra_devfreq, cpu_rate_change_nb);
> 
> nitpick. Better to check whether 'tegra' is NULL or not.

It can't be NULL, unless 'nb' is NULL and even in that case
container_of() will cause kernel crash. Hence it's absolutely
unnecessary to check for NULL here.

>> +
>> +	/*
>> +	 * CPUFreq driver should support CPUFREQ_ASYNC_NOTIFICATION in order
>> +	 * to allow asynchronous notifications. This means we can't block
>> +	 * here for too long, otherwise CPUFreq's core will complain with a
>> +	 * warning splat.
>> +	 */
>> +	schedule_work(&tegra->update_work);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  					  struct tegra_devfreq_device *dev)
>>  {
>> @@ -527,9 +562,16 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>  	device_writel(dev, val, ACTMON_DEV_CTRL);
>>  }
>>  
>> -static void tegra_actmon_start(struct tegra_devfreq *tegra)
>> +static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
>> +{
>> +	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
> 
> Better to define the constant definition of 0x00000000
> in order to explain the correct meaning.
> 
> For example,
> #define ACTMON_DEV_RESET	0x00000000

Okay.
