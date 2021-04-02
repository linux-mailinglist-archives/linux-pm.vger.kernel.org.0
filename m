Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0B352A19
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhDBLK5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhDBLK4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 07:10:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681AC061788
        for <linux-pm@vger.kernel.org>; Fri,  2 Apr 2021 04:10:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so4446487wrn.4
        for <linux-pm@vger.kernel.org>; Fri, 02 Apr 2021 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8yqk6Gg1lixYUdtJreF2pfRxp/mvmHcHSAW4jILJZ8=;
        b=SQ/G73AeC7mBU2PGWmt5WJnEZLsP/2bRqZ3SK3xT58W4ZruzvfiH95FzSoWqW6FPkR
         9+HjRCYyJiwo1X1SWSznrT9TdmA3ogguKEXSJ4lE7/qSSPbROkg9+nsqOVp2zEuRM67V
         jrwzzWD7ck5mZMrZH5JlXK9TrDhmeBYxbkn2dpxODi0UzCj9dwuD9SoysUMIk4/Nk+NH
         Q4PTOosLvv9jdTZi2j6VixnHR1wBFMuhnPDiag7rqbvqIm3Ykk6XbBjvC1r57c5JkOBN
         KKpbKW2rJQJg56Q6qD3Y087ztwRTq9Vs2ZC9qJOIi2yGQ8CqnlTTRk+1F7EyxIYlxKpX
         5Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8yqk6Gg1lixYUdtJreF2pfRxp/mvmHcHSAW4jILJZ8=;
        b=rAkvYDovbrdA4YTGIiN1GlC8gTfM3Gn1mksJE5fSxGR14YWbKrjLFyTa7sSxxBtBJW
         /luy/GQ2uqRpuHthHKBvSHIT1pO5YfYpvZ5tN1fktCvRPqNd4VhC+zdweFvm7aiX9B0i
         8yBMUuHnlcrVzoy5cpKnwbC6ncY4+9a96Rgu8Jn2rytek9mwjY8qxvVPZStMCwweLOl2
         W/d+gSoLUZyxtuZj7jxbcjwRj7J8GK5KnFeIctlYeONxT9L1RGbWva920kgu/kipzthI
         TfZ2xDwluW0YcqIpsI+p7wBY1k3vEnoIBxRntzx2VfuUDrVH/yK8Mjx1QVVUPLFSSufG
         TMLw==
X-Gm-Message-State: AOAM530prDxkizOc8Yp+7p9ywUG89znAvu0aZcuIGDCSIjVG3jZw+4jL
        gohRDTHu43V+N8PS8cpH+soX8RAlfACy3Q==
X-Google-Smtp-Source: ABdhPJzpe284DhML5+Wc1Eb9A7WLfdYXYsJEIoaX8K4jQCJl80leDrwv6OnhLzJ39uiiuU+Veii8LQ==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr14509771wrx.85.1617361853168;
        Fri, 02 Apr 2021 04:10:53 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf? ([2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf])
        by smtp.googlemail.com with ESMTPSA id z82sm12240424wmg.19.2021.04.02.04.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 04:10:52 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-2-daniel.lezcano@linaro.org>
 <YGYe9p3oyNpMnsBT@kroah.com>
 <d0f818c7-3262-268b-bcc2-8036ce559d7b@linaro.org>
 <YGbPh/QrFsgyJC6B@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c819700a-97b6-9993-491b-599b82842dc2@linaro.org>
Date:   Fri, 2 Apr 2021 13:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGbPh/QrFsgyJC6B@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/04/2021 10:02, Greg KH wrote:
> On Fri, Apr 02, 2021 at 12:08:49AM +0200, Daniel Lezcano wrote:
>>
>> Hi Greg,
>>
>> On 01/04/2021 21:28, Greg KH wrote:
>>> On Thu, Apr 01, 2021 at 08:36:49PM +0200, Daniel Lezcano wrote:
>>>> A SoC can be differently structured depending on the platform and the
>>>> kernel can not be aware of all the combinations, as well as the
>>>> specific tweaks for a particular board.
>>>>
>>>> The creation of the hierarchy must be delegated to userspace.
>>>
>>> Why?  Isn't this what DT is for?
>>
>> I've always been told the DT describes the hardware. Here we are more
>> describing a configuration, that is the reason why I've let the
>> userspace to handle that through configfs.
> 
> DT does describe how the hardware configuration is to be used.  You are
> saying that the hardware description does not work and somehow you need
> a magic userspace tool to reconfigure things instead?
> 
>>> What "userspace tool" is going to be created to manage all of this?
>>> Pointers to that codebase?
>>
>> You are certainly aware of most of it but let me give a bit more of context.
> 
> No, I am not aware of it at all, thanks :)
> 
>> The thermal framework has cooling devices which export their 'state', a
>> representation of their performance level, in sysfs. Unfortunately that
>> gives access from the user space to act on the performance as a power
>> limiter in total conflict with the in-kernel thermal governor decisions.
> 
> Why not remove that conflict?

Because the cooling device state should have not be exported its state
in a writable way, that is a weakness different applications are
abusing. Moreover, the thermal framework is not designed for that. It is
not the purpose of the cooling device to be managed as a power limiter
by the userspace.

The powercap framework is there for that.

There are devices registering themselves as a cooling device while there
is no sensor and governor for them just for the sake of acting on their
power via opaque integer values.


>> That is done from thermal daemon the different SoC vendors tweak for
>> their platform. Depending on the application running and identified as a
>> scenario, the daemon acts proactively on the different cooling devices
>> to ensure a skin temperature which is far below the thermal limit of the
>> components.
> 
> So userspace is going to try to manage power settings in order to keep
> thermal values under control?  Has no one learned from our past mistakes
> when we used to have to do this 10 years ago and it turned out so bad
> that it was just baked into the hardware instead?

I agree in a desktop/server environment, that is true but on the
embedded world, things are a bit different because we are on battery,
the cooling devices are passive and the device is carried. This is why
there are different level of thermal control:

 - In the hardware / firmware to protect physically the silicon

 - In the kernel, to protect from a hard reset or reboot. Usually each
of them is represented with a thermal zone (and its sensor) and a
governor. There is a 1:1 relationship. IOW, a governor manage a thermal
zone without any knowledge of the other thermal zones temperature, just
the one it is monitoring and acts on the power (with different
techniques) when the temperature threshold is reached. Its action is
local and it is after crossing a certain temperature for this component.

 - In the userspace, the logic will get notified about which application
is running and can set the power limitation on different devices knowing
the performances are enough for that particular application, that saves
energy and consequently reduce the temperature. Its action is on
multiple places and happens far below the thermal limits. On the other
side, the skin temperature is a particular sensor placed on the
dissipation path and its temperature must be below 45°C (30 minutes skin
contact at 45°C causes a 1st degree burn). It is the results of the
dissipation of all the devices, the logic in userspace can know which
devices to act on to have the overall power dissipation low enough to
stay below this 45°C (eg. reduce camera resolution).  So here userspace
deals with performance, temperature, application profile, etc ... and
abuse the cooling device.

I'm not sure in the ARM/ARM64 embedded ecosystem, creating a complex
hardware mechanism, supported by a firmware is really possible.

In a desktop/server environment, we do not care about having this skin
temperature (and battery savings) aspects.

> {sigh}
> 
>> This usage of the cooling devices hijacked the real purpose of the
>> thermal framework which is to protect the silicon. Nobody to blame,
>> there is no alternative for userspace.
> 
> Userspace should not care.
> 
>> The use case falls under the power limitation framework prerogative and
>> that is the reason why we provided a new framework to limit the power
>> based on the powercap framework. The thermal daemon can then use it and
>> stop abusing the thermal framework.
>>
>> This DTPM framework allows to read the power consumption and set a power
>> limit to a device.
>>
>> While the powercap simple backend gives a single device entry, DTPM
>> aggregates the different devices power by summing their power and their
>> limits. The tree representation of the different DTPM nodes describe how
>> their limits are set and how the power is computed along the different
>> devices.
> 
> That's all great, doing this in-kernel is fine, it's now the "userspace
> must set this up properly that I'm objecting to as no one will know how
> to do this.
> 
>> For more info, we did a presentation at ELC [1] and Linux PM
>> microconference [2] and there is an article talking about it [3].
>>
>>
>> To answer your questions, there is a SoC vendor thermal daemon using
>> DTPM and there is a tool created to watch the thermal framework and read
>> the DTPM values, it is available at [4]. It is currently under
>> development with the goal of doing power rebalancing / capping across
>> the different nodes when there is a violation of the parent's power limit.
> 
> Crazy ideas aside, your implementation of this is my main objection
> here.  You are creating a user/kernel api that you will have to support
> for 20+ years, without a real userspace user just yet (from what I can
> tell).  That's rough, and is going to mean that this gets messy over
> time.

I'm not sure to understand, the API already exists since v3.3, it is the
powercap and DTPM is its backend. AFAICT, there are already users of it
except they create their own way to build the hierarchy today.

> Also there's the whole "tying sysfs to configfs" mess and reference
> counting that I object to as well...

Ok, I think my description was bad but I agree with the fact that we
must get rid of any adherence between sysfs and configfs. Thanks for
reporting the issue.

[ ... ]

>> The configfs does not represent the layout of the sensors or the floor
>> plan of the devices but only the constraints we want to tie together.
>>
>> That is the reason why I think using configfs instead of OF is more
>> adequate and flexible as userspace deals with the power numbers.
>> Moreover, we won't be facing issues with devices initialization priority
>> when the daemon starts.
>>
>> I thought we can add OF later, when the framework has more users and
>> more devices. The configfs and OF can certainly co-exist or be mutually
>> exclusive via the Kconfig option.
> 
> Kconfig options are not ok for this, you want to build a kernel that
> works everywhere.
> 
> If you want to make virtual things, that's fine, but again, your tying
> of sysfs to configfs in odd ways, along with the reference counting
> bugs/nightmare the current implementation is creating, is a non-starter
> for me at the moment, sorry.

I did not realize this reference counting issue. Thanks for spotting it.

The points you raised are IMO solvable and I can send a new version but
with all the comments I'm a bit lost with the approach with configfs.

Do you think it is preferable to use OF instead ?

Thanks again for your time

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
