Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9366332BAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCIQM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhCIQMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:12:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32204C06174A;
        Tue,  9 Mar 2021 08:12:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so5261006pjh.1;
        Tue, 09 Mar 2021 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cRekcBH7rVWJ+cXQbK+iyWwu9LAOnwcOABEvQsGJb/4=;
        b=qFXAzmzob2l3MfmxbGRZRVIZSsWfb7p+zKUl04lOZaGWRgoYiVMutQ8az7/LClHmLC
         EcIOlbNDQ2UFAORIMfOgKb2xRoD/QZSKPZEmi3950R4cn0LUdaF0Zicq5gIAk7olYimA
         HWMGlHvY7VIC1ujRyfYfKvy0ezsZFw3FdnpXQOuNzTgsUpBdhGG/tQa2zMBZq7tmvNNG
         BTpFTPd8vTSje37UsnfRV8p4TY9h2kLBS7APjivYpUhST0idxITYTqSPuRWkhl85NmRP
         Uo7orygBjQ89XFn630dFmR6lrEVQuJWa22ivk+oJ8xHpwEBeU6jIIXnwuYysWjxThOJ/
         Hfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRekcBH7rVWJ+cXQbK+iyWwu9LAOnwcOABEvQsGJb/4=;
        b=IkazibODoGnXmdmF80PCFnaaqXH/zZUt+brVrFhuWaPDpJ68LzZnDunbWbtNyGEkwQ
         g+KS7EaxI/LEA138rag9ITDYmxWhCCs2YpwqhI/fx1KtzyHkRYSIDVLwDOKnhL5suPma
         bT1MxPXaeD59KLhWgIxFksD/4khQI/Izry7zzv/NcoSnfIgiyKXqyn0txA/J2BAZ5Xzw
         rqJQY7iq+cLylH+mNldeeYaK8iw2R+bBZ+FWF4Y9zBEdfm0itgyt8NWyRUOLzeyEbekU
         76r6K5g0WgM12KjFRREMJfTDsvIk68W8IMPn5h9blK7TztLDmomCtrzEc6soYW3iH4tZ
         CRjw==
X-Gm-Message-State: AOAM530j/xTs411qnp6ahmJ3GyUuXfsR1fIJKeYQU2h7UQDZ19x63kB7
        nIvcNp7Mj8SYGoJU2eFjs34=
X-Google-Smtp-Source: ABdhPJzNxA+FndNawwctuvqhJyAVFHpBpTm4C0rBGCuwrAdUJnHDnpddaqaC8GmJAjVtPJ/NL2SQZQ==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr5499609pjt.170.1615306369755;
        Tue, 09 Mar 2021 08:12:49 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x9sm3344130pjp.29.2021.03.09.08.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:12:48 -0800 (PST)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
 <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
Message-ID: <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com>
Date:   Wed, 10 Mar 2021 01:12:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>> The devfreq monitor depends on the device to provide load information
>> by .get_dev_status() to calculate the next target freq.
>>
>> And this will cause changing governor to simple ondemand fail
>> if device can't support.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>   drivers/devfreq/devfreq.c                 | 10 +++++++---
>>   drivers/devfreq/governor.h                |  2 +-
>>   drivers/devfreq/governor_simpleondemand.c |  3 +--
>>   3 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 7231fe6862a2..d1787b6c7d7c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct 
>> *work)
>>    * to be called from governor in response to DEVFREQ_GOV_START
>>    * event when device is added to devfreq framework.
>>    */
>> -void devfreq_monitor_start(struct devfreq *devfreq)
>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>>       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>> -        return;
>> +        return 0;
>> +
>> +    if (!devfreq->profile->get_dev_status)
>> +        return -EINVAL;

Again, I think that get_dev_status is not used for all governors.
So that it cause the governor start fail. Don't check whether
.get_dev_status is NULL or not.

>>       switch (devfreq->profile->timer) {
>>       case DEVFREQ_TIMER_DEFERRABLE:
>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>           INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>           break;
>>       default:
>> -        return;
>> +        return -EINVAL;
>>       }
>>       if (devfreq->profile->polling_ms)
>>           queue_delayed_work(devfreq_wq, &devfreq->work,
>>               msecs_to_jiffies(devfreq->profile->polling_ms));
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_monitor_start);
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index 5cee3f64fe2b..31af6d072a10 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>                   unsigned int event, void *data);
>>   };
>> -void devfreq_monitor_start(struct devfreq *devfreq);
>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>   void devfreq_monitor_stop(struct devfreq *devfreq);
>>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>>   void devfreq_monitor_resume(struct devfreq *devfreq);
>> diff --git a/drivers/devfreq/governor_simpleondemand.c 
>> b/drivers/devfreq/governor_simpleondemand.c
>> index d57b82a2b570..ea287b57cbf3 100644
>> --- a/drivers/devfreq/governor_simpleondemand.c
>> +++ b/drivers/devfreq/governor_simpleondemand.c
>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct 
>> devfreq *devfreq,
>>   {
>>       switch (event) {
>>       case DEVFREQ_GOV_START:
>> -        devfreq_monitor_start(devfreq);
>> -        break;
>> +        return devfreq_monitor_start(devfreq);
>>       case DEVFREQ_GOV_STOP:
>>           devfreq_monitor_stop(devfreq);
>>
> 
> Need to handle the all points of devfreq_monitor_start() usage.
> please check the tegra30-devfreq.c for this update.
> 
> $ grep -rn "devfreq_monitor_start" drivers/
> drivers/devfreq/governor_simpleondemand.c:92: 
> devfreq_monitor_start(devfreq);
> drivers/devfreq/tegra30-devfreq.c:744:        
> devfreq_monitor_start(devfreq);
> ......
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
