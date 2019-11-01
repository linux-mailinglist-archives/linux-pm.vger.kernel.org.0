Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75432EC41C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKAN4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:56:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42144 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKAN4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:56:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so10316916ljh.9;
        Fri, 01 Nov 2019 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QARoAkysEnXhZ8U4UHSm2hbxasucAbzuyPLqACWX3X4=;
        b=uncZ3qilpfNYt7SNVRmywgFcCXAPVamxWceWgJaY+lb7IVw8ZoGkrPPZpeE2y5FvdD
         VLQDutuyZnI2LpEaZmFT41222prNuBYZ5ssKZyAXTldLtYyLZXxFs89qpnQ2jWLR1aYP
         TrrQ/fyBZpAfQXXXU0yljkMTNVe+QqjHzyzWN8o1+JJlpl8KVxz6OtRqSvmFQrqtn5xx
         hBCr0h0+eB3puTY/HBNILfcUnS87oXss4q+XFN3AUWflPzsoRg9gj+GgtZFQK726FNWz
         4buwn90y+9aKTaYGevmy2AetaZxebj612tZILBEfb1HgDlI6RPRiKmCZre67CVc5rY/g
         Do0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QARoAkysEnXhZ8U4UHSm2hbxasucAbzuyPLqACWX3X4=;
        b=t4QCxjjzCrrRaOdTrf72C7k5b6/s4yrKNbjM55gmEw+ls2ShNpcMS2SIhMXAiMyARL
         pluTQ/88kdOW6o4x4HDLJAV6M5yhab4+L8qprY+yf3zXkC5BQS/IpGPMOyzB8f9XnK2j
         cKJxlT2tjpHpxTBvZwbJEMCKWx8ZJo9DDtz/fNS4PaN1yHTZwaB+48XYx55SIW/YygGz
         63rlMxwVxLbicjpYA5KkZioOLsTk59A7HkWPc9ZHCFWk+1atR9mlyw/z7urzqiJTwJj2
         TKg8LHNwJTjBWT0UoY5aY2e0IvKgk8cVbczWDdApoybzEpRSH3nl/THzQSkLywy+V+GJ
         8wcA==
X-Gm-Message-State: APjAAAUD2AxMtrenrR7iwMYX2bbguWzH4TSZZRFWU+rv0rtjGw7B8mNo
        IiZYIahDcgA1dKKlSLxsl3tKpH4n
X-Google-Smtp-Source: APXvYqw8Qbb+Lo1YKz7WFgX9NUMZ34SC0m4h/ORfIWgV4GdDjIDEw/N6gfHRs6tf/+xfhpIdUwG+6g==
X-Received: by 2002:a2e:420a:: with SMTP id p10mr8662905lja.16.1572616570109;
        Fri, 01 Nov 2019 06:56:10 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id a26sm3586771lfg.50.2019.11.01.06.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 06:56:09 -0700 (PDT)
Subject: Re: [PATCH v7 16/19] PM / devfreq: Add new interrupt_driven flag for
 governors
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029220019.26773-1-digetx@gmail.com>
 <CGME20191029220705epcas5p1dc9787952bd19cefe9e0bff592642142@epcas5p1.samsung.com>
 <20191029220019.26773-17-digetx@gmail.com>
 <a4caf25c-5907-6347-f4d7-37800a077f29@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fcf107da-a164-521d-f507-047b79b1578a@gmail.com>
Date:   Fri, 1 Nov 2019 16:56:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a4caf25c-5907-6347-f4d7-37800a077f29@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2019 10:32, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
>> Currently interrupt-driven governors (like NVIDIA Tegra30 ACTMON governor)
>> are used to set polling_ms=0 in order to avoid periodic polling of device
>> status by devfreq core. This means that polling interval can't be changed
>> by userspace for such governors.
>>
>> The new governor flag allows interrupt-driven governors to convey that
>> devfreq core shouldn't perform polling of device status and thus generic
>> devfreq polling interval could be supported by these governors now.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/devfreq.c  | 14 +++++++++-----
>>  drivers/devfreq/governor.h |  3 +++
>>  2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index b905963cea7d..0ef972264841 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -410,7 +410,8 @@ static void devfreq_monitor(struct work_struct *work)
>>  void devfreq_monitor_start(struct devfreq *devfreq)
>>  {
>>  	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> -	if (devfreq->profile->polling_ms)
>> +	if (devfreq->profile->polling_ms &&
>> +	    !devfreq->governor->interrupt_driven)
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>  }
>> @@ -474,7 +475,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>  		goto out;
>>  
>>  	if (!delayed_work_pending(&devfreq->work) &&
>> -			devfreq->profile->polling_ms)
>> +			devfreq->profile->polling_ms &&
>> +				!devfreq->governor->interrupt_driven)
> 
> Better to edit it as following for the indentation.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index cea05b43225f..60c5540b2a55 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -477,7 +477,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>         if (!delayed_work_pending(&devfreq->work) &&
>                         devfreq->profile->polling_ms &&
> -                               !devfreq->governor->interrupt_driven)
> +                       !devfreq->governor->interrupt_driven)
> 
> 
> 
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>  
>> @@ -518,8 +520,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>  
>>  	/* if current delay is zero, start polling with new delay */
>>  	if (!cur_delay) {
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> -			msecs_to_jiffies(devfreq->profile->polling_ms));
>> +		if (!devfreq->governor->interrupt_driven)
>> +			queue_delayed_work(devfreq_wq, &devfreq->work,
>> +				msecs_to_jiffies(devfreq->profile->polling_ms));
>>  		goto out;
>>  	}
>>  
>> @@ -528,7 +531,8 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>  		mutex_unlock(&devfreq->lock);
>>  		cancel_delayed_work_sync(&devfreq->work);
>>  		mutex_lock(&devfreq->lock);
>> -		if (!devfreq->stop_polling)
>> +		if (!devfreq->stop_polling &&
>> +		    !devfreq->governor->interrupt_driven)
>>  			queue_delayed_work(devfreq_wq, &devfreq->work,
>>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>>  	}
> 
> In the devfreq_interval_update(), you better to modify this function as following:
> It is more simple.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index d3d12ed0ed29..80acb55d1686 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -510,6 +510,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>         if (devfreq->stop_polling)
>                 goto out;
>  
> +       if (!devfreq->governor->interrupt_driven)
> +               goto out;
> +
>         /* if new delay is zero, stop polling */
>         if (!new_delay) {
>                 mutex_unlock(&devfreq->lock);
> 
> 
> 
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index bbe5ff9fcecf..dc7533ccc3db 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -31,6 +31,8 @@
>>   * @name:		Governor's name
>>   * @immutable:		Immutable flag for governor. If the value is 1,
>>   *			this govenror is never changeable to other governor.
>> + * @interrupt_driven:	Devfreq core won't schedule polling work for this
>> + *			governor if value is set to 1.
>>   * @get_target_freq:	Returns desired operating frequency for the device.
>>   *			Basically, get_target_freq will run
>>   *			devfreq_dev_profile.get_dev_status() to get the
>> @@ -49,6 +51,7 @@ struct devfreq_governor {
>>  
>>  	const char name[DEVFREQ_NAME_LEN];
>>  	const unsigned int immutable;
>> +	const unsigned int interrupt_driven;
>>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>>  	int (*event_handler)(struct devfreq *devfreq,
>>  				unsigned int event, void *data);
>>
> 
> 

Okay, I'll update this patch.
