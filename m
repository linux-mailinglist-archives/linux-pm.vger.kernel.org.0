Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4A70F5A8
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEXLur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 May 2023 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEXLuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 07:50:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172B10CC
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 04:50:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f60dfc5f93so7356305e9.2
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684929005; x=1687521005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G5qr+y8Og34U7/wuDAr7A7OdYIwtt1sXsW3Z1wgc7s=;
        b=FLh2wEpBZnXzP6FyUREj4UtF+u+VMWaRCMJY5DDGY/zxhOuCy86kMpFs24uUtSXZe/
         lEZKCSmMHCPocGNBOZ7IuVXjiTWElwGNLJIdbNk9oe9TRW9cTTSg1JdfEJTpasqH7+uk
         sqvgep9fcZCAeq6AHcY8Ct8gJPqsbVbCVgu2huLpKSj83ya1flHYFYuqqb2btaV4T13E
         NvtFxsJWVBcy7LOH/2MG4rbgZ8KeS3gfZHGLz9gobcz7Y0PwnDYei7ryheFwq+jTYoH6
         tvh0rWGAugf23f4dr0kKFAGk3AwFoher5z1z8BvVVcrFPC/Mkj+fiaXc+N+ygy/tvrW9
         AGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929005; x=1687521005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G5qr+y8Og34U7/wuDAr7A7OdYIwtt1sXsW3Z1wgc7s=;
        b=dT5aNZM8X0/ruUBA2h6i3fZnt1PvjCoiR8sadZz/tbnHhoSXzI4hNTjr1E27t1oqeK
         1e0iCjfw94gLEnV8D3VHNsi09Uy+ivVJQquPJqkmJARuP2OfcKa+wWAT0xPHtVHctaiz
         WhauYpehCufEhHT3ulgmGKr/9VRX2bTFsqlFoFY96k625lGbRdhE7lPcnL3WBOIlQByd
         H10TUpXSFy1h5NqAqjI+XSvD5nwANvxFdT98pEvgLwWQZXHx9gaHJ4XCyaK5eUNMfxRO
         COpBmQ6CqhsTiMmi4JsbhqlGg2cKloXg4jAFO3R1pnAruWy5mLaxzdY2NPB7TjCOB05I
         v8nw==
X-Gm-Message-State: AC+VfDyJ2GXGOmDhFU1GShUAI0AcAJK/qpKG2REwR05C78D38YjYko1N
        GBYBGheSq8rCH2dZqGI+Gtu3SA==
X-Google-Smtp-Source: ACHHUZ5THFSDvb91AuGnOhK8nElYleH7LWUlOjDpqU2ToXSDnl/8XKLy8wFBwVoEQZSxitOFSzNUjw==
X-Received: by 2002:a1c:7315:0:b0:3f5:9ba:442d with SMTP id d21-20020a1c7315000000b003f509ba442dmr12902482wmb.33.1684929005471;
        Wed, 24 May 2023 04:50:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:fd45:6a0d:5512:e76? ([2a05:6e02:1041:c10:fd45:6a0d:5512:e76])
        by smtp.googlemail.com with ESMTPSA id i1-20020a05600c354100b003f61177faffsm3916021wmq.0.2023.05.24.04.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:50:04 -0700 (PDT)
Message-ID: <5ee23c8d-a9a6-f93a-ee6c-a7dd1285a806@linaro.org>
Date:   Wed, 24 May 2023 13:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <745b8b17-af4d-e8e1-83c1-89d600e7cd19@linaro.org>
 <CAJZ5v0iqWMKZo8yJMqymwLwZK9kXJFi89USd96A-H+aktSYT+A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iqWMKZo8yJMqymwLwZK9kXJFi89USd96A-H+aktSYT+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/05/2023 12:25, Rafael J. Wysocki wrote:
> On Wed, May 24, 2023 at 10:06 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/05/2023 19:12, Rafael J. Wysocki wrote:
>>> Hi Folks,
>>>
>>> I'm going to submit a Power Management and Thermal Control
>>> micro-conference proposal for LPC2023 along the lines of what happened
>>> in the previous iterations of it.
>>>
>>> If you have topics that you'd like to be discussed there, please let
>>> me know by Friday, May 26.
>>>
>>> Please note that LPC MC topics are expected to cover work in progress
>>> or at the concept stage.  They are not supposed to be about work that
>>> has been done already.
>>
>> * Create a relevant debugfs thermal infrastructure + cleanup the sysfs
>> debug related information.
>>      -> average temperature (overall / moving)
>>      -> mitigation episodes (duration, temperature max, min, avg, average
>> performance througput)
>>      -> thermal zone behavior (temperature slope dT/dt vs performance
>> througput)
>>      -> more TBD at LPC
> 
> Sounds good.
> 
>> [ RFC series ready but depends on the generic trip point ]
>>
>> * New thermal trip types. Currently we have 'hot', 'passive', 'active',
>> 'critical' trip points. The userspace needs to deal with the thermal
>> also but in a different manner. Currently, it has to poll the thermal
>> zone to get the temperature, thus introducing more wakes up on the
>> system. However the sensors have now a programmable register to trigger
>> an interrupt and the userspace may benefit that. By adding one or
>> several writable 'custom' trip points, the userspace can program a point
>> to be notified and do an action. So we separate the actions from the
>> kernel to protect the silicon and the ones from userspace to manage the
>> overall thermal behavior in the system at lower temperatures.
>>
>> [ depends on the generic trip points ]
> 
> So this basically would be an interface for user space to add a trip
> point at run time?

I was thinking about a description like any other trip points. So they 
will be added in sysfs as trip_point_x_temp. The thermal framework will 
ensure the trip temperature is below the temperature of other trip 
points types.

> What about a "send me an event if the temperature is equal to this"
> interface instead?

If you add a writable trip point that is what the thermal framework will 
do. The idea is to clearly identify an 'userspace' trip point which will 
be writable, other types will stay read-only.


> But yes, as a discussion topic this would be fine.

Yeah, we can see that is already triggering a discussion here :)


>> * Thermal management without the time dimension taken into account is
>> too simplistic. Add this dimension in the thermal information for better
>> decision (eg. notification when a temperature is above a temperature
>> after a duration)
> 
> OK
> 
>> * Improve the step wise governor. The step wise governor may take too
>> much time to react when there are many cooling device states as it will
>> increment with one step at each update (eg. idle cooling device has 100
>> states). That may result on overshoots. Depending on the temperature
>> slope we should increase the number of steps for the cooling action. The
>> result should be some kind of PID regulation loop but simplified
>> regarding the power allocator.
> 
> Sounds good, but it is kind of minor with respect to the above.  We'll see.

No problem

Thanks!

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

