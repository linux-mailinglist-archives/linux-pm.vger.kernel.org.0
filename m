Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C114C9CD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 12:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2LeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 06:34:23 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:19378 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgA2LeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 06:34:22 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200129113418epoutp04c06fb4a7f63247da08806dd750a19c60~uWFkFzufR1989219892epoutp04S
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2020 11:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200129113418epoutp04c06fb4a7f63247da08806dd750a19c60~uWFkFzufR1989219892epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580297658;
        bh=dZpZLGiMiSwje8YHHJxOlxCUUy21vccxwXWxrORqna4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P93p1HByYvkyb7tGvK6HyPSBBa9KGAvkioj0+5GLYUPY1Tvz14ksLe9Fz3f3m6ltN
         GTOgnZkBP9E2s7TFKd5mlOGYMqBEuO4WgYP3geqfmARzM4VxvBGAk/NW9Sd/qYNPRP
         77LQwF3wVGiYuKnGpSTeWJNmDTH3WwmKnTVYOj9M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200129113418epcas1p3c930f8ee8d2fa429f9bfbd6232902c9f~uWFjnVVm70473404734epcas1p3c;
        Wed, 29 Jan 2020 11:34:18 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4871bR61GzzMqYkZ; Wed, 29 Jan
        2020 11:34:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.2F.57028.3BD613E5; Wed, 29 Jan 2020 20:34:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200129113411epcas1p27949df511b1284425e9d284d61b9bb41~uWFdTxpyX1912319123epcas1p2i;
        Wed, 29 Jan 2020 11:34:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200129113411epsmtrp19a53a2c33686b05655cc2b715654d208~uWFdTBORZ0526205262epsmtrp1w;
        Wed, 29 Jan 2020 11:34:11 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-db-5e316db30a96
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.43.06569.3BD613E5; Wed, 29 Jan 2020 20:34:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200129113411epsmtip183fee66781f1e38368691526762f8e21~uWFdJstLc0853208532epsmtip1G;
        Wed, 29 Jan 2020 11:34:11 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL
 event name
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cb22cfaf-ad28-9697-f2f2-b6f79c19220d@samsung.com>
Date:   Wed, 29 Jan 2020 20:41:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <bc60b915-1975-b623-6b85-fc034cf649f3@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmnu7mXMM4gzX9ehYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFosbGpht7jduILNgc1jzbw1jB6bVnWyefRtWcXo8XmTXABLVLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtByJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xoWLa9gLfulX
        TF3QxdbAuEmzi5GTQ0LARGLetBtMXYxcHEICOxglps9awQ6SEBL4xCixtbMEIvGNUeLfqlds
        MB2bdtxmhUjsZZT42vAQqv09o8TOJ7fA2oUFIiV+bf0N1iEiEC/xtnsNmM0s4C2x+O1qRhCb
        TUBLYv+LG2BxfgFFias/HoPFeQXsJM70HwGzWQRUJX5sfM4EYosKhEmc3NYCVSMocXLmExYQ
        m1PAWuLg3VtQ88Ulbj2ZzwRhy0s0b53NDHKchMBjNokVx98BFXEAOS4SFyYXQHwjLPHq+BZ2
        CFtK4mV/G5RdLbHy5BE2iN4ORokt+y+wQiSMJfYvncwEModZQFNi/S59iLCixM7fcxkh9vJJ
        vPvawwqxileio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQfDMLyQezkHwwC2HZAkaWVYxiqQXF
        uempxYYFhsiRvYkRnC61THcwTjnnc4hRgINRiYfXQckgTog1say4MvcQowQHs5IIr6irYZwQ
        b0piZVVqUX58UWlOavEhRlNgYE9klhJNzgem8rySeENTI2NjYwsTQzNTQ0Mlcd6HkZpxQgLp
        iSWp2ampBalFMH1MHJxSDYzzo70yhJo8P0kY8jmkN7w4MPGZyUWPum+vbjZM0j7qqnp9R2b3
        19OnDN79qLfdsjuLe9Xr3sWnGjZNCny6w+NtLFfkazHmHM2ORfW2n8L53MsaEi7w3/tsvbC0
        9P+KwM+vlwTMFkruldTuW39zviaf+OeS4p7EHN4ZsxsTV2xoT8mVfbRm2WYlluKMREMt5qLi
        RAD41rxtrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTndzrmGcwY8vAhYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFosbGpht7jduILNgc1jzbw1jB6bVnWyefRtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAlfGhYtr2At+6VdMXdDF1sC4SbOLkZNDQsBEYtOO26xdjFwcQgK7GSX61q9mhkhISky7
        eBTI5gCyhSUOHy6GqHnLKNG9bjc7SI2wQKTEr62/2UBsEYF4iZsTHrKA2MwC3hKL365mhGh4
        xyhx9eZEsASbgJbE/hc3wBr4BRQlrv54zAhi8wrYSZzpPwJmswioSvzY+JwJxBYVCJPYueQx
        E0SNoMTJmU/A5nAKWEscvHuLDWKZusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZ
        SFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOHa0tHYwnjgRf4hRgINR
        iYfXQckgTog1say4MvcQowQHs5IIr6irYZwQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FC
        AumJJanZqakFqUUwWSYOTqkGxtiXfF9q0tlqPaZbaKVPPpS0S6p2p2juXMEFCxg9+n8KiWgl
        NZYtz6yc7DktwOL85qxlW7cv/XlF+k1q5/Yl6YUF5a+rZ+ibpxxXdLhvevH052nvb3Gc9Jl8
        tfGKwZu9y42Lf0dPX3j3eq39hIUnfmt+vCEyY/LuZ1vSP3N4NVsmhK8/setJb5YSS3FGoqEW
        c1FxIgB79w/+mQIAAA==
X-CMS-MailID: 20200129113411epcas1p27949df511b1284425e9d284d61b9bb41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200129111225epcas1p1c262e46a878ad68836a676bc351840bf
References: <20200129112002.6998-1-cw00.choi@samsung.com>
        <CGME20200129111225epcas1p1c262e46a878ad68836a676bc351840bf@epcas1p1.samsung.com>
        <20200129112002.6998-2-cw00.choi@samsung.com>
        <bc60b915-1975-b623-6b85-fc034cf649f3@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/29/20 8:28 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> Apart from small mistakes in the commit message, looks good to me.
> 
> On 1/29/20 11:20 AM, Chanwoo Choi wrote:
>> DEVFREQ_GOV_INTERVAL event indicates that update the interval
>> for polling mode of devfreq device. But, this event name doesn't
>> specify exactly what to do.
>>
>> Change DEVFREQ_GOV_INTERVAL event name to DEVFREQ_GOV_UPDATE_INTERVAL
>> which specifies what to do by event name.
>>
>> And modify the functio name for DEVFREQ_GOV_UPDATE_INTERVAL
> 
> s/functio/function

I'll fix it.

> 
>> with 'devfreq_' prefix + verb + obejct as following:
> 
> 'obejct'?

I'll fix it to 'object'.

Thanks for the review.

> 
>> - devfreq_interval_update -> devfreq_updatee_interval
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c                 | 10 +++++-----
>>   drivers/devfreq/governor.h                |  4 ++--
>>   drivers/devfreq/governor_simpleondemand.c |  4 ++--
>>   drivers/devfreq/tegra30-devfreq.c         |  4 ++--
>>   4 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index cceee8bc3c2f..8494c5f05a73 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -550,14 +550,14 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>   EXPORT_SYMBOL(devfreq_monitor_resume);
>>     /**
>> - * devfreq_interval_update() - Update device devfreq monitoring interval
>> + * devfreq_update_interval() - Update device devfreq monitoring interval
>>    * @devfreq:    the devfreq instance.
>>    * @delay:      new polling interval to be set.
>>    *
>>    * Helper function to set new load monitoring polling interval. Function
>> - * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
>> + * to be called from governor in response to DEVFREQ_GOV_UPDATE_INTERVAL event.
>>    */
>> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
>>   {
>>       unsigned int cur_delay = devfreq->profile->polling_ms;
>>       unsigned int new_delay = *delay;
>> @@ -597,7 +597,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>   out:
>>       mutex_unlock(&devfreq->lock);
>>   }
>> -EXPORT_SYMBOL(devfreq_interval_update);
>> +EXPORT_SYMBOL(devfreq_update_interval);
>>     /**
>>    * devfreq_notifier_call() - Notify that the device frequency requirements
>> @@ -1426,7 +1426,7 @@ static ssize_t polling_interval_store(struct device *dev,
>>       if (ret != 1)
>>           return -EINVAL;
>>   -    df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
>> +    df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
>>       ret = count;
>>         return ret;
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index 5ba3e051b1d0..c07ce77c253d 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -18,7 +18,7 @@
>>   /* Devfreq events */
>>   #define DEVFREQ_GOV_START            0x1
>>   #define DEVFREQ_GOV_STOP            0x2
>> -#define DEVFREQ_GOV_INTERVAL            0x3
>> +#define DEVFREQ_GOV_UPDATE_INTERVAL        0x3
>>   #define DEVFREQ_GOV_SUSPEND            0x4
>>   #define DEVFREQ_GOV_RESUME            0x5
>>   @@ -61,7 +61,7 @@ void devfreq_monitor_start(struct devfreq *devfreq);
>>   void devfreq_monitor_stop(struct devfreq *devfreq);
>>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>>   void devfreq_monitor_resume(struct devfreq *devfreq);
>> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
>> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
>>     int devfreq_add_governor(struct devfreq_governor *governor);
>>   int devfreq_remove_governor(struct devfreq_governor *governor);
>> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
>> index 3d809f228619..1b314e1df028 100644
>> --- a/drivers/devfreq/governor_simpleondemand.c
>> +++ b/drivers/devfreq/governor_simpleondemand.c
>> @@ -96,8 +96,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>>           devfreq_monitor_stop(devfreq);
>>           break;
>>   -    case DEVFREQ_GOV_INTERVAL:
>> -        devfreq_interval_update(devfreq, (unsigned int *)data);
>> +    case DEVFREQ_GOV_UPDATE_INTERVAL:
>> +        devfreq_update_interval(devfreq, (unsigned int *)data);
>>           break;
>>         case DEVFREQ_GOV_SUSPEND:
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 0b65f89d74d5..28b2c7ca416e 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -734,7 +734,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>           devfreq_monitor_stop(devfreq);
>>           break;
>>   -    case DEVFREQ_GOV_INTERVAL:
>> +    case DEVFREQ_GOV_UPDATE_INTERVAL:
>>           /*
>>            * ACTMON hardware supports up to 256 milliseconds for the
>>            * sampling period.
>> @@ -745,7 +745,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>           }
>>             tegra_actmon_pause(tegra);
>> -        devfreq_interval_update(devfreq, new_delay);
>> +        devfreq_update_interval(devfreq, new_delay);
>>           ret = tegra_actmon_resume(tegra);
>>           break;
>>  
> 
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> 
> Regards,
> Lukasz
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
