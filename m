Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5845EC27E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiI0MVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiI0MVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 08:21:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AD4DF0E
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 05:20:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso9305964wmq.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=T+ARObPy1nMVAT61WPcL0dvL1PZL65X6x/55j6kdsgc=;
        b=sFaS3F7F3vuNqMrAh/Zi5jvAh9ijl3kCoru45JWtKFJ9Mau9yHsU9keVhOfbWCUfus
         v5cB/hLj4eNzgkaSPK235aWJmhQX7fq9ogz5U901Hev6LBqAl/aAqBo1Xth3U4/BceJq
         3bX3C32p5uisNrRq6G+eFUQMSaVGfA4SNgL08rMKAbKHOBfAa+lbkOtI21T1/u786Ov7
         +UqDeSircO387aVyiCOTO1z/YBCBFzompYhR8diU4DaXdEzNACXROkh00qfr3/v8sScX
         0NXIxp/IctPk4gjzWHjSYESpIWdNNTylceRHtly6+qrUxZkbewNj74czv+rplmOwG1I3
         fBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T+ARObPy1nMVAT61WPcL0dvL1PZL65X6x/55j6kdsgc=;
        b=DLc7OSTc3T/cbRfuD156VdeVnkl1gBwn//P81AvVkVskk1Si+sd6v+YaN2WvZNXP6v
         g0bB4U8VXYauZXwrr0UcIGwvA1XpRFEus36y9jGkjlMCYm0OMxY/08GTJTHh9fSfBS9B
         pe1fhnDjvSXVZNHsrPSr9sGNA54eK+ZExoTZKfwerbGFE9RBRnI8EIKm4pbtvvFGC6xi
         v0XzfUZH9rGazm0ny5KgqXAJmUnarmQvSXuvlsoeQKuE1zZMqlK3NVP/zp8zIiY9qYMy
         1yfamDJxnnFuQdJ9Huf53DVxIrOSmY9TPK2+x2LLiOVmuD6FfcFJZ6Cd4eKj4o51uEvu
         qXag==
X-Gm-Message-State: ACrzQf0M14UPA6856zwE58d2hrINHvLdFYu6x5ML4E2d4PMzz7nZdTdo
        +z4pzI6pFGZJ/XmQx7vUAOSTig==
X-Google-Smtp-Source: AMsMyM44pyU5NnK7fltYQjgzFEnzcSrdXIfn/dUPyZr94SqaIOrtdnp23P1NhpV4o5cfXXwUq/z2Bg==
X-Received: by 2002:a05:600c:6003:b0:3b5:aef:d8d7 with SMTP id az3-20020a05600c600300b003b50aefd8d7mr2456240wmb.50.1664281241417;
        Tue, 27 Sep 2022 05:20:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id s14-20020a5d6a8e000000b002252ec781f7sm1788723wru.8.2022.09.27.05.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:20:40 -0700 (PDT)
Message-ID: <584a1927-0713-4a6d-a7a6-94bdda30dc0d@linaro.org>
Date:   Tue, 27 Sep 2022 14:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 03/30] thermal/core: Add a generic
 thermal_zone_set_trip() function
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-4-daniel.lezcano@linaro.org>
 <CAJZ5v0hJ7Tq1pU1hSqswPF_+KZOt1jNKvmqTeF5=1npReqmA3A@mail.gmail.com>
 <ee9ea160-ae77-112b-5302-74179e372387@linaro.org>
 <CAJZ5v0gATxtX5RW0oHbhT_hjUoEC3V39tQpJi74eg8iXhrwZKg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gATxtX5RW0oHbhT_hjUoEC3V39tQpJi74eg8iXhrwZKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2022 12:38, Rafael J. Wysocki wrote:
> On Tue, Sep 27, 2022 at 12:11 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 26/09/2022 21:25, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>> +       if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {
>>>
>>> The inner parens are not needed here and below.
>>>
>>>> +
>>>
>>> And the extra empty line is not needed here (and below) too IMO.
>>>
>>>> +               ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
>>>> +               if (ret)
>>>> +                       goto out;
>>>> +       }
>>>
>>
>> Without the parens, the following happens:
>>
>>
>> warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
>>    1229 |         if ((t.temperature != trip->temperature) &&
>> tz->ops->set_trip_temp)
>>         |         ^~
>> note: ...this statement, but the latter is misleadingly indented as if
>> it were guarded by the ‘if’
>>    1231 |                 if (ret)
>>         |                 ^~
> 
> This is about indentation, though, so it looks like white space is
> mangled somehow.
> 
> As a matter of correctness, the inner parens are not needed.

Oh, actually I did a confusion with the 'brackets', you meant:

(t.temperature != trip->temperature && tz->ops->set_trip_temp)

right ?

>>>> +       if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
>>>> +
>>>> +               ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
>>>> +               if (ret)
>>>> +                       goto out;
>>>> +       }
>>>> +
>>>> +       if (((t.temperature != trip->temperature) ||
>>>> +            (t.hysteresis != trip->hysteresis)) && tz->trips)
>>>> +               tz->trips[trip_id] = *trip;
>>>
>>> I would write this as
>>>
>>> if (tz->trips && (t.temperature != trip->temperature || t.hysteresis
>>> != trip->hysteresis))
>>>           tz->trips[trip_id] = *trip;
>>
>> Ok, sure
>>
>>> But
>>>
>>> 1. Do we want to copy the trip type here too?
>>
>> The function thermal_zone_set_trip() is called from thermal_sysfs.c, it
>> is the unique call site. However, I think it is a good idea to check the
>> type of the trip point is not changed, even if it is not possible with
>> the actual code.
>>
>>> 2. If tz->trips is set, do we still want to invoke ->set_trip_temp()
>>> or ->set_trip_hyst() if they are present?
>>
>> No but there are bogus drivers setting the interrupt with these ops
>> instead of using the set_trips ops (eg. [1][2][3]). So in order to keep
>> those working ATM, I'm keeping them and when all the drivers will be
>> changed, I'll wipe out the set_trip_* ops from everywhere.
> 
> Do those drivers set tz->trips?  If not, the tz->trips check can go
> before the ops ones.

Unfortunately some are doing that, like the tegra's soctherm driver


>> [1] drivers/thermal/samsung/exynos_tmu.c
>> [2] drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> [3] drivers/thermal/imx_thermal.c


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
