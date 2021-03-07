Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C166330213
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 15:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCGO3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhCGO3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 09:29:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C01C06174A
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 06:29:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so8595769wro.12
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oj/4Ujv3X0dQLWGyly5F5AZIrJiiPDr1GiSc4SFfBr4=;
        b=K7cTTRzKD8ZqG7I6DgeAdDBmMlEdbmj8TjmC7EBfY//6YfjqT/cyWOO4skj79ARcAi
         H3nFF3B14fOr3vwESDrHAoo1n5hLnJweQN4q0hCrPbFVA5nXWMNpVWSG/5PbfGnCRTvJ
         t4GL94HffGxM+SH9292I2RCjR/jJXtTthkroSC3aONHw/f0l5punxzj2uc6gAPmvkKY0
         k0iumYS5f/O8cGHTMFuEOFGD+jGNbI/u4FUSUS9H0hR3TqZ6unvonQPfNUZrkasTNukN
         bk+w1KPyJydxw9jHCstddkvPkeqgh8HgWQBZyBz7gTcOT7BWG8PROGPWDscIYSvs2x2D
         W8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oj/4Ujv3X0dQLWGyly5F5AZIrJiiPDr1GiSc4SFfBr4=;
        b=Iy2W2dyLi6aw1D7Wc6aXpwKGGKB+v8lLoh/wg03eOzdnjzI07GazU8RQGKKOdPuTaA
         QCGmAM4sHjqwTV2lDG4m40Z4vz1HTn64jBfk7XR6+H8yltRlDwNFTmsBwgWV6NDXttUF
         wazthxqsdKGfhHd4GaCF1wBYlewwZvGdPG91ElzdYzF/64kRtMT15UCTcYyRALYCeqVi
         nvXfVgJvrFL7JOeEE3A9uYTLO7IPSOBaiTPnh27oA80zFdLg1vP+pCrMpFaxuuFtiQaW
         AghIWd31/2j0opjdYpGTxZ4VXek9fTyzzJE2mSAZ5F1OKqxxRlC1b+IXGBgpc7KAlgte
         Iukw==
X-Gm-Message-State: AOAM530154WSRgCAixCzF7cUDvw73PqOVNctVKG4r6lRgDKepDxSWWj4
        na45EgCK7DplGvF5cNprEu8GZg==
X-Google-Smtp-Source: ABdhPJx7GDckM+FzIZ9842Rjfqnrx0MRMv64In8XYNTg1+mgs7oybawj/JOFnjgEgrhk77GvzdfY7A==
X-Received: by 2002:a5d:4564:: with SMTP id a4mr18447531wrc.3.1615127341001;
        Sun, 07 Mar 2021 06:29:01 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b087:286:c426:25b5? ([2a01:e34:ed2f:f020:b087:286:c426:25b5])
        by smtp.googlemail.com with ESMTPSA id o11sm14314514wrq.74.2021.03.07.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 06:29:00 -0800 (PST)
Subject: Re: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on
 demand
To:     cwchoi00@gmail.com
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
 <CAGTfZH3jFJ8CaJ1Yg=oxhVSYVDULWr83iPokL+tut8mKgSufFA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <76b5b6bc-952b-aa7c-025b-3eeb2ca23c79@linaro.org>
Date:   Sun, 7 Mar 2021 15:28:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH3jFJ8CaJ1Yg=oxhVSYVDULWr83iPokL+tut8mKgSufFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2021 15:16, Chanwoo Choi wrote:
> On 21. 3. 7. 오후 6:45, Daniel Lezcano wrote:
>> Currently the default behavior is to manually having the devfreq
>> backend to register themselves as a devfreq cooling device.
>>
>> Instead of adding the code in the drivers for the thermal cooling
>> device registering, let's provide a flag in the devfreq's profile to
>> tell the common devfreq code to register the newly created devfreq as
>> a cooling device.
>>
>> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   V3:
>>     - Rebased on linux-pm branch without units.h
>>     - Set the cdev to NULL in case of error
>>     - Added description for the cdev field in the devfreq structure
>>   V2:
>>     - Added is_cooling_device boolean in profile structure
>>     - Register cooling device when the is_cooling_device boolean is set
>>     - Remove devfreq cooling device registration in the backend drivers
>>   V1:
>>     - Register devfreq as a cooling device unconditionnally
>> ---


[ ... ]

>>       return devfreq;
>>
>>   err_init:
>> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>>       if (!devfreq)
>>               return -EINVAL;
>>
>> +     thermal_cooling_device_unregister(devfreq->cdev);
> 
> I have a question. Why don't you use devfreq_cooling_unregister()?
> When thermal_cooling_device_unregister(), how can we remove
> the pm_qos_request of devfreq device?

You are perfectly right. I failed to call the right function :/

Will fix it with a v4.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
