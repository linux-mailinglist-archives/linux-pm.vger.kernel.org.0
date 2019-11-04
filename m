Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A244CEE1FC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDOPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 09:15:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33236 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDOPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 09:15:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so17813735ljk.0;
        Mon, 04 Nov 2019 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGgLOxNhEBahV9b+I1KpEEom1KHR1SjtB7Al++SXlGI=;
        b=RDtAeZkb42KbQJ/EmDMBHRy4skRgGNEtu3cxNo0yf/ZfN3ossM9skIDjGgCqSC0L/v
         QkbNl/jVTzY5uCAx4hHesjoPPWUeX9QV2pWW105BKsyJkQacwG2rVoLhLW9nPbtTRXFD
         SrjV87U8D93wkyIwgYoertoMGrlfQu/GTxGs9G8hHX6l9hWle+NLWCMj6ageZG2EqLak
         Lu+cz94MwefIIgCk/+6yRADO8VYqtsZo5i5guC26GaMEWNt82Emj9vtqveWkhyAeH39h
         juZJh44wvWW4b4SoIhLuJBdem9+rXeXTYkMqwRZzQIn45RT3lMQvkhhygmL7PE1qxXFv
         5VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGgLOxNhEBahV9b+I1KpEEom1KHR1SjtB7Al++SXlGI=;
        b=mmB0jUpa6CQRsDacHXVcr/k0RPqlgsJQaAbgoKQdC7fH1y8vNU1Aoh7pWIozaP+AxL
         WebaB6brCdHZky+bs5g7mrWukz02xcfh+vK8rr3PfUbkfztE9NUMfwneBiViRAGN4y+F
         Fkfnl36lPG4am1RjPcYoHFIWZ6A6FffffW7pvCj+bK+rLDbrRNwHuTIZ5mHSD5i1ZlC+
         15cns0/vY9TUrJ1E242bet+RG/vWSNi4etSysUcXf5v6GoD/b6UNQyP27NGQIP+Nn3OD
         6jIA6XO75q94mF3eBNtq6tMSHa1z6mMgJVF0RhZm2Lr2ZDKHlbw77EekilQAWdYTcRDR
         01ZA==
X-Gm-Message-State: APjAAAXB1xi0vJlx8be2SB+F1wMaZ721/lJACvpSxR4siRsD0VGFApmq
        D/U2WATtCSokGpsIuP87hnfG7yEI
X-Google-Smtp-Source: APXvYqxGmeyxm2I1kkg9hTEACKfIvuwrlWgZBSlNeY5rNDPoeA7UowKYry52jmmDVRMDMZXQLfiE2A==
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr6537118ljk.118.1572876928837;
        Mon, 04 Nov 2019 06:15:28 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id d27sm8345502lfb.3.2019.11.04.06.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:15:28 -0800 (PST)
Subject: Re: [PATCH v8 15/18] PM / devfreq: Add new interrupt_driven flag for
 governors
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191103204130.2172-1-digetx@gmail.com>
 <CGME20191103204257epcas1p4ce6f9ae729ed6cf6df1816237c80ee45@epcas1p4.samsung.com>
 <20191103204130.2172-16-digetx@gmail.com>
 <f86d35dc-1749-ad29-2023-7d69366bd0d1@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b5195266-8f92-f2b6-6dd1-9d706146e729@gmail.com>
Date:   Mon, 4 Nov 2019 17:15:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f86d35dc-1749-ad29-2023-7d69366bd0d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.11.2019 05:48, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> Sorry for the additional comment of this patch.
> I think that you better to change the 'interrupt_driven' checking
> style as following in order to keep the consistency of governor
> flag checking style.

Hello Chanwoo,

Okay, I'll update this patch.

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 27de8ddeaaa8..fe409fc1bcc4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -410,9 +410,11 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> +       if (devfreq->governor->interrupt_driven)
> +               return;
> +
>         INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>         if (devfreq->profile->polling_ms &&
> -           !devfreq->governor->interrupt_driven)
>                 queue_delayed_work(devfreq_wq, &devfreq->work,
>                         msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
> @@ -475,12 +477,15 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>         if (!devfreq->stop_polling)
>                 goto out;
>  
> +       if (devfreq->governor->interrupt_driven)
> +               goto out_update;
> +
>         if (!delayed_work_pending(&devfreq->work) &&
>                         devfreq->profile->polling_ms &&
> -                       !devfreq->governor->interrupt_driven)
>                 queue_delayed_work(devfreq_wq, &devfreq->work,
>                         msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> +out_update:
>         devfreq->last_stat_updated = jiffies;
>         devfreq->stop_polling = false;
> 
> 
> If you edit it as following, feel free to add my reviewed-by tag:
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> 
> On 19. 11. 4. 오전 5:41, Dmitry Osipenko wrote:
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
>>  drivers/devfreq/devfreq.c  | 9 +++++++--
>>  drivers/devfreq/governor.h | 3 +++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index b905963cea7d..a711a76d386e 100644
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
>> +			!devfreq->governor->interrupt_driven)
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>  
>> @@ -509,6 +511,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>  	if (devfreq->stop_polling)
>>  		goto out;
>>  
>> +	if (devfreq->governor->interrupt_driven)
>> +		goto out;
>> +
>>  	/* if new delay is zero, stop polling */
>>  	if (!new_delay) {
>>  		mutex_unlock(&devfreq->lock);
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

