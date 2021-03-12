Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D93392C5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCLQK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCLQJ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 11:09:58 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC31C061574;
        Fri, 12 Mar 2021 08:09:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v14so9242347pgq.2;
        Fri, 12 Mar 2021 08:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zngbGyukwx3Iwx3aEptZ8vaHNPRsBHeSxDGOhnQdUhY=;
        b=Sn/oCBPeDCueGJ4e4+kF5zrBWZRv6XDzOyooMn8ABceNQDPHnT5oJ3xiTTlsy+FjSC
         1A/mh2kTdQrCzPKjfcbOT9lYM47cjruxdVvZWbxvRMRc7b4zcgsFcbE6cgv2jTk2s2u6
         pt0UBEfJyx1euN2lJG2ZsMCRW5DncA1nWuXCqtLrOnygFAtZmdX3BRRs8PrzElxiBrVH
         oyFSW0Xdg2kqZ0yOIoxlCRRbCYtSKxBcCyvbSJK3c48odmbo3C6i9IAIDORePmlWxzbe
         aK48/QP63QQAhUWUWoiLKSHpKkZDKFsivfqK+m0UmVAAkLTi5glRNSYBa8SIxhevHP3g
         /Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zngbGyukwx3Iwx3aEptZ8vaHNPRsBHeSxDGOhnQdUhY=;
        b=AHsGmsv0uzYNCjzxpvEJnc8iufex+ihNlLChfqUVkOPcn7/fGbP7IFzGYTr/hORN4C
         TNnXegVnDCUXAspSKxCSUembVJ3petWpzeuFhCsxS9G2k1tUolzk43DtiLOU33+jA1KI
         i46aQrsNsjALyv948NUTtuD/QTONBYDoX6OJTgH//roDMnB4Seh8rvObn2uDQIYDvDBD
         DSEqBoJ029OaJ/S6RKuK7fDGXccTgHvAQeMpGf6ge1qX3mieZGRbQkf4p9Usxz/bBI1s
         XUf+8BhcqHhjRvl0/E695MgkpTByF6wKVqdupEVkHn0RUpckgEEkzcb256/ugrkJBctG
         p9aw==
X-Gm-Message-State: AOAM5338hDsRIXvWd3EdmOnb/DeydvhvoHghT+ESn3hTDor5Uk9yyIxj
        VKH0Jq5LZOMKz+Mbfx90JgY=
X-Google-Smtp-Source: ABdhPJxO4rALUaoe8D3InnOj36yshnVcXj4M1Pk6I3CXb4/6CgNF7gHrGPbKd6VfRez1nX0Prwpi+w==
X-Received: by 2002:aa7:9431:0:b029:1f1:52fd:5444 with SMTP id y17-20020aa794310000b02901f152fd5444mr12574003pfo.47.1615565397834;
        Fri, 12 Mar 2021 08:09:57 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i22sm2632577pjz.56.2021.03.12.08.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 08:09:57 -0800 (PST)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
To:     Dong Aisheng <dongas86@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Abel Vesa <abel.vesa@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
 <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
 <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com>
 <CGME20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e@epcas1p1.samsung.com>
 <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
 <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com>
 <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
 <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com>
 <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <d92b7660-a622-06f3-6e1f-03c99fdf0a55@gmail.com>
Date:   Sat, 13 Mar 2021 01:09:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 12. 오후 7:57, Dong Aisheng wrote:
> On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> On 3/10/21 1:56 PM, Dong Aisheng wrote:
>>> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>
>>>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
>>>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>>>>>
>>>>>> On 21. 3. 10. 오전 12:58, Chanwoo Choi wrote:
>>>>>>> On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
>>>>>>>> The devfreq monitor depends on the device to provide load information
>>>>>>>> by .get_dev_status() to calculate the next target freq.
>>>>>>>>
>>>>>>>> And this will cause changing governor to simple ondemand fail
>>>>>>>> if device can't support.
>>>>>>>>
>>>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>>>>>> ---
>>>>>>>>    drivers/devfreq/devfreq.c                 | 10 +++++++---
>>>>>>>>    drivers/devfreq/governor.h                |  2 +-
>>>>>>>>    drivers/devfreq/governor_simpleondemand.c |  3 +--
>>>>>>>>    3 files changed, 9 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
>>>>>>>> *work)
>>>>>>>>     * to be called from governor in response to DEVFREQ_GOV_START
>>>>>>>>     * event when device is added to devfreq framework.
>>>>>>>>     */
>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>    {
>>>>>>>>        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>>>>>>>> -        return;
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    if (!devfreq->profile->get_dev_status)
>>>>>>>> +        return -EINVAL;
>>>>>>
>>>>>> Again, I think that get_dev_status is not used for all governors.
>>>>>> So that it cause the governor start fail. Don't check whether
>>>>>> .get_dev_status is NULL or not.
>>>>>>
>>>>>
>>>>> I'm not quite understand your point.
>>>>> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
>>>>> get_target_freq -> devfreq_update_stats -> get_dev_status
>>>>
>>>> The devfreq can add the new governor by anyone.
>>>> So these functions like devfreq_monitor_* have to support
>>>> the governors and also must support the governor to be added
>>>> in the future.
>>>
>>> Yes, but devfreq_monitor_* is only used by polling mode, right?
>>> The governor using it has to implement get_dev_status unless
>>> there's an exception in the future.
>>>
>>> Currently this patch wants to address the issue that user can switch
>>> to ondemand governor (polling mode) by sysfs even devices does
>>> not support it (no get_dev_status implemented).
>>
>> As I commented, I'll fix this issue. If devfreq driver doesn't implement
>> the .get_dev_status, don't show it via available_governors. I think that
>> it is fundamental solution to fix this issue.
> 
> Sounds good
> 
>> So on this version,
>> don't add the this conditional statement on this function
>>
> 
> Almost all this patch did is adding a checking for get_dev_status.
> So do you mean drop this patch?
> I wonder it's still a necessary checking to explicitly tell devfreq monitor
> users that get_dev_status is needed during governor startup.

I think that the it is enough to check .get_dev_status in
devfreq_update_stats. We have to check it on where it is used.

> 
>> And on next version, please use the capital letter for first character
>> on patch title as following:
>>
>> - PM / devfreq: Check get_dev_status before start monitor
>>
> 
> Okay to me.
> Thanks for the suggestion.
> 
> Regards
> Aisheng
> 
>>>
>>> Regards
>>> Aisheng
>>>
>>>>
>>>>>
>>>>> Without checking, device can switch to ondemand governor if it does not support.
>>>>>
>>>>> Am i missed something?
>>>>>
>>>>> Regards
>>>>> Aisheng
>>>>>
>>>>>>>>        switch (devfreq->profile->timer) {
>>>>>>>>        case DEVFREQ_TIMER_DEFERRABLE:
>>>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>>>>>            INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>>>>>>>            break;
>>>>>>>>        default:
>>>>>>>> -        return;
>>>>>>>> +        return -EINVAL;
>>>>>>>>        }
>>>>>>>>        if (devfreq->profile->polling_ms)
>>>>>>>>            queue_delayed_work(devfreq_wq, &devfreq->work,
>>>>>>>>                msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>>>>> +    return 0;
>>>>>>>>    }
>>>>>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
>>>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
>>>>>>>> --- a/drivers/devfreq/governor.h
>>>>>>>> +++ b/drivers/devfreq/governor.h
>>>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
>>>>>>>>                    unsigned int event, void *data);
>>>>>>>>    };
>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
>>>>>>>>    void devfreq_monitor_stop(struct devfreq *devfreq);
>>>>>>>>    void devfreq_monitor_suspend(struct devfreq *devfreq);
>>>>>>>>    void devfreq_monitor_resume(struct devfreq *devfreq);
>>>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>> b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>> index d57b82a2b570..ea287b57cbf3 100644
>>>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
>>>>>>>> devfreq *devfreq,
>>>>>>>>    {
>>>>>>>>        switch (event) {
>>>>>>>>        case DEVFREQ_GOV_START:
>>>>>>>> -        devfreq_monitor_start(devfreq);
>>>>>>>> -        break;
>>>>>>>> +        return devfreq_monitor_start(devfreq);
>>>>>>>>        case DEVFREQ_GOV_STOP:
>>>>>>>>            devfreq_monitor_stop(devfreq);
>>>>>>>>
>>>>>>>
>>>>>>> Need to handle the all points of devfreq_monitor_start() usage.
>>>>>>> please check the tegra30-devfreq.c for this update.
>>>>>>>
>>>>>>> $ grep -rn "devfreq_monitor_start" drivers/
>>>>>>> drivers/devfreq/governor_simpleondemand.c:92:
>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>> drivers/devfreq/tegra30-devfreq.c:744:
>>>>>>> devfreq_monitor_start(devfreq);
>>>>>>> ......
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>> Samsung Electronics
>>>>>> Chanwoo Choi
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Chanwoo Choi
>>>> Samsung Electronics
>>>
>>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
