Return-Path: <linux-pm+bounces-928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CE80E496
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DB3282D22
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489B15AFE;
	Tue, 12 Dec 2023 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCxTAmru"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0BBF
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 23:00:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so39398595e9.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 23:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702364417; x=1702969217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mOODffkcSbhJnVPc2Mb/toFoQFGDkXS7uLIm7BDUjg=;
        b=SCxTAmruNCIjpBBnghjAK5Yeloxu27P928Jwi6seTPgaCE3P5dAXxMlg8tSqu7UJa8
         yjVPM8eFL4M/y1HOSTqsDWXCS1i174E7/5aUKciNKhFYyXvhqc/E0Ft3xBPjf8e4PgU9
         P1btKpnzy9RHdh3DJDNcJhKHbHsT/foV7gYwimKjKpKjJS8mmwAZVY39EUazwnykuRkt
         X1g6dHIOeo7cevi7twHkVyZaZZ1xVt9lkHwc8XDRAVDhP+TtXCx/3nq46ueusDgCrjOa
         Jelk9kFoTKW8oWLSLI5tv4YOe4i5s0ZVQJ5hRf63pPjSQDednrbmCZIvZMnnSETeGvS6
         kgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364417; x=1702969217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mOODffkcSbhJnVPc2Mb/toFoQFGDkXS7uLIm7BDUjg=;
        b=c0Iiv493siDWjsl2IKxkfce2cfbfGrmZyuhy9hNO6L/2+uGKxW8u7Zh9mz/8dUUqdM
         npeuB5A2MLi36IAy+A73rwlyOO9iH9qtv/DTQi4sNGddxD6o4mmF4DdorO2msbsYcXl/
         Q5bZzOZGjaeLo6mzK70cdwumTCndTwMMsWg5vHr6KOB3USqx8exaArS0mRlLE+7jXLwb
         j4QRONHchOOaEdXvCjT23u8VpGhpDRAWBWy88Its8fpNeY3eUO7RDPss1rFDCy8Kt9GY
         hiUZG3Z66h6yyX3GPByavLab62cc2UiZqWLa7s8kIT4moHqJCVnD1CcoRCtKICQ6kWP/
         rJ4w==
X-Gm-Message-State: AOJu0YwrVsI0q66935tZ+LcV+87ASMKdIgmJXsupi55W7cc+gqx+Uzal
	zdnJsdJFmexgzdADWjQ1vXUUbw==
X-Google-Smtp-Source: AGHT+IECt3W+daTiMhSj0c0XMVScV+jjtFofyVZBCA6jzm9q9Q9q029jz9wRUp9vJ7a5+Xd3fCZXSw==
X-Received: by 2002:a05:600c:444a:b0:40c:4857:e000 with SMTP id v10-20020a05600c444a00b0040c4857e000mr1426731wmn.46.1702364416805;
        Mon, 11 Dec 2023 23:00:16 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id g20-20020a05600c4ed400b0040c31bb66dcsm15132225wmq.20.2023.12.11.23.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 23:00:16 -0800 (PST)
Message-ID: <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org>
Date: Tue, 12 Dec 2023 08:00:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND
 asynchronously
Content-Language: en-US
To: Radu Solea <radusolea@google.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
 <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org>
 <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2023 00:25, Radu Solea wrote:
> On Wed, Dec 6, 2023 at 3:23 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Radu,
>>
>> On 06/12/2023 02:20, Radu Solea wrote:
>>> On Wed, Nov 29, 2023 at 4:20 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 21/11/2023 00:40, Radu Solea wrote:
>>>>> Some thermal zones are bus connected and slow to resume, thus
>>>>> delaying actions which depend on completion of PM_POST_SUSPEND.
>>>>> Add optional execution path to resume thermal zones on the system
>>>>> unbounded workqueue.
>>>>>
>>>>> Signed-off-by: Radu Solea <radusolea@google.com>
>>>>> ---
>>>>
>>>> This async change may have a lot of hidden implications.
>>>>
>>>> Could you elaborate more the issue and how the async will fix the problem?
>>>>
>>>> If you have a platform being slow to resume, can you provide numbers
>>>> with and without this option?
>>>>
>>>> Thanks
>>>>      -- D.
>>>>
>>>> --
>>>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>
>>>
>>> In multicore systems PM_POST_SUSPEND is executed on a single core.
>>> Any work done in the notification chain delays all subsequent actions
>>> in the chain with respect to system time, including the completion of
>>> the write() to /sys/power/state.
>>> I didn't include numbers from my system since they are likely
>>> irrelevant for other systems out there. The particular number I'm
>>> chasing is ~50ms.
>>> This comes from having on-board peripherals as thermal zones, they
>>> execute async and significantly slower than the main core, add a/d
>>> conversions and bus delays to that and it's easy to see those numbers.
>>> Making the entire sequence synchronous to itself and async to
>>> PM_POST_SUSPEND isn't that much of a change, it allows the sequence to
>>> run on any core with spare cycles delayed with whatever the system
>>> unbounded queue load is at the time.
>>> (on my target system) I've seen consistent time gains (those same
>>> 50ms) to PM_POST_SUSPEND completion with this sequence actually
>>> completing before the chain finishes, this will vary from integration
>>> to integration.
>>
>> Sorry but I don't see how you can have a gain of 50ms by doing the
>> restore asynchronously.
>>
>> Can you give a more detailed description of the hardware? How many
>> thermal zones?
>>
>>
> I can't go into much detail about the hardware. But let's put it this
> way, if thermal_zone_device_update() takes 5 ms for each device (read
> temp, get trips, set trips, etc). Assume 5 onboard thermal zones, on a
> good day, ignoring system churn you'd get to around 25ms (already
> significant).
> Now on top of that add that these devices have multiple functions,
> like a PMIC for example. The resume sequence is the perfect time frame
> where you'd encounter more than one operation aimed at any one of
> these devices. Unless you have uncommonly smart drivers and devices,
> these will be queued.
> The driver in most cases will spin (hardly ideal, but realistic), even
> if they would yield the effect on the completion of the chain is at
> least the same or, likely, worse.
> 
> To the patch itself, I realized I've been somewhat hamfisted.
> thermal_zone_device_init() should not be deferred, and likely should
> execute for all zones before the in_suspend lock-out is released. I'll
> correct that once we've landed on something.
> 
> To my 50ms, it's almost the worst-case, but it happens way more often
> than would be comfortable.

If you call monitor_thermal_zone() instead of 
thermal_zone_device_update(), does it speed up the resume time ?


>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


