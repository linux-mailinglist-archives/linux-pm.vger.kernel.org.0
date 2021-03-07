Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE533027F
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCGPOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 10:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCGPOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 10:14:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC9C06174A;
        Sun,  7 Mar 2021 07:14:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1696958pjb.0;
        Sun, 07 Mar 2021 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=arpSuCU764ob7Hh1VLljRuMffaUWaGNtffaUoD1lJwA=;
        b=ciNOKauxZUrYekv13YqWqBW3nerR0TSDcVdCkVFJk5KCH35dUVSQmGV0evpWatwcAh
         Krb+yijInt51NdVdZwmpo24a5g0O7vy3qt+jvEZV7q5348K/xWSWhfXp2ftpYFBMBMrX
         ojejP3Q8DuhADJN6GD66ihlomSElJB0hRRigGLKyjOw93xex+hMyjEa8LcDvqhtiCrwi
         bKFLf9CRSnX8uknr5WV5Q+6MSVfGfyIn8LvpPa67wrTrbpE2xJV4OLirxyngqb/3IpWR
         rkoMCZeo0isJgTZDbDEOLuCEBeUqBHjwloZzWXrZTgxDH39TwL/cfWk8PbrxIyxYjvet
         GfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=arpSuCU764ob7Hh1VLljRuMffaUWaGNtffaUoD1lJwA=;
        b=Ggc7RQL5MTvN3uwpUicH+1gZ89KVu6b7wyVjL+H2ER4sCCh9oRvdk7EP8nqg3+U82l
         bP6fSjcqdIKnmeGREoCFGvtN8wOCRqdOo9VNfXdGcfxQQGQC8+xSj4qB60i7a6UTEcdq
         5oIsjPCfdmqjoTr01j1z8lGhDbuf//Qxl7FHYa4pMzE/xRuK8/xNdWtIx2XAdFGSJUBV
         PYuzW+NGXqEuEX3UHQAuenJkyiwUW6iv5PlYPcWPHjPrsFhiaWTUJ1+ZQCukk7MRu8uC
         RvjzqBnb/YH9Xl0yQCwL6TzQXmlv4Upl6HbNtQXIv/hV9QYS0C9onc+BmzfbUWAH8Mbv
         wlEQ==
X-Gm-Message-State: AOAM5313iCVRVSnk/UhsVwxMUbYYjtf+GklBebGtytr5rGQFjDz+CtQO
        o0Jow1p+Sw9nUHuRXB06a7XqS8Q8J6D9lA==
X-Google-Smtp-Source: ABdhPJx58L53QCmmmlFb71UVCz/XuyAP2E/nZ0BT5QaAZzGyCxCwTxsj+gQqjzfJy6ejedhRJjEhmA==
X-Received: by 2002:a17:90a:31cc:: with SMTP id j12mr19874462pjf.203.1615130064494;
        Sun, 07 Mar 2021 07:14:24 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y14sm7784626pfq.218.2021.03.07.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 07:14:23 -0800 (PST)
Subject: Re: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on
 demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
 <CAGTfZH3jFJ8CaJ1Yg=oxhVSYVDULWr83iPokL+tut8mKgSufFA@mail.gmail.com>
 <76b5b6bc-952b-aa7c-025b-3eeb2ca23c79@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <587ae86e-158d-8ffa-319c-66f397f5a218@gmail.com>
Date:   Mon, 8 Mar 2021 00:14:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <76b5b6bc-952b-aa7c-025b-3eeb2ca23c79@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 7. 오후 11:28, Daniel Lezcano wrote:
> On 07/03/2021 15:16, Chanwoo Choi wrote:
>> On 21. 3. 7. 오후 6:45, Daniel Lezcano wrote:
>>> Currently the default behavior is to manually having the devfreq
>>> backend to register themselves as a devfreq cooling device.
>>>
>>> Instead of adding the code in the drivers for the thermal cooling
>>> device registering, let's provide a flag in the devfreq's profile to
>>> tell the common devfreq code to register the newly created devfreq as
>>> a cooling device.
>>>
>>> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>    V3:
>>>      - Rebased on linux-pm branch without units.h
>>>      - Set the cdev to NULL in case of error
>>>      - Added description for the cdev field in the devfreq structure
>>>    V2:
>>>      - Added is_cooling_device boolean in profile structure
>>>      - Register cooling device when the is_cooling_device boolean is set
>>>      - Remove devfreq cooling device registration in the backend drivers
>>>    V1:
>>>      - Register devfreq as a cooling device unconditionnally
>>> ---
> 
> 
> [ ... ]
> 
>>>        return devfreq;
>>>
>>>    err_init:
>>> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>>>        if (!devfreq)
>>>                return -EINVAL;
>>>
>>> +     thermal_cooling_device_unregister(devfreq->cdev);
>>
>> I have a question. Why don't you use devfreq_cooling_unregister()?
>> When thermal_cooling_device_unregister(), how can we remove
>> the pm_qos_request of devfreq device?
> 
> You are perfectly right. I failed to call the right function :/
> 
> Will fix it with a v4.
> 

Thanks. And, please add 'PM /' prefix for patch in order to
keep the consistent patch title format.

PM / devfreq: Register devfreq as a cooling device on demand

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
