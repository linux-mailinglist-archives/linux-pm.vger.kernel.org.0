Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1444C3521FD
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhDAWIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 18:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDAWIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 18:08:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE6C061788
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 15:08:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z2so3172494wrl.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LVnk/U0WbnlpUYYM+S6Qz/SpyHTLRPx/Vw8szN4QhO8=;
        b=PiaEbRevd3uh1rN8q4RORO5cvT0HsbngzeNxHJOaAzO+Wlb1nWF75GMYtHAqYqBAsX
         p2sYelIbCurnO3rzZLBw0RyYqPuG36qrjMlkz7EDqUpBz9Ynzk/9h0+Si/fPVZBw7Slk
         oDJU5b76pPZpu3fpXeKSSG6f7SVrX10ubWayMfT9o4DUADypZxooCOlzFwNCzV/+5Im3
         QZBJIebTU60DNkEz09WZtjId1xCk0skcwul1EqdxoEzm+bWA20LGeNg8GIIHXIeZ61M/
         VM4L+yHcgZyIZ0e4WUcMi/T+HJOqw6pY04kVdlQICumegLSN9deReKYDStzYSz9yiOeP
         pQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LVnk/U0WbnlpUYYM+S6Qz/SpyHTLRPx/Vw8szN4QhO8=;
        b=jn+Wb8pdqNpSY0w4Cg668+c8fIM593/U5gt/BtURaBFcPlmsAxua0mebh4mOubIa1N
         6gPrjDns/ThfoH53SGLKac3bQeuVgwF7DKpeMEtoPglwgVTpt5daohC/AIDIU0OhouQy
         vx/80ySee5o2mCfGNQCVeqKYExW1iTSD38Hk1gxiYTx71pAsaHYCNw1/doHycWV3gOvr
         z0JvZl4/KmicKIN9oOzVh4qwD92ezrQcAqR79KwwW5BG8M5Aa3jMl6kNJZQL7rVarvOD
         JPNcpj2ZWnjU8ErXvji53hKl4I5X+I88hHVkcVr3n47Tc+Ae90RSsKom/0wo8ThRth9R
         LiPQ==
X-Gm-Message-State: AOAM5332SrTEwOemri7q60qZAfSA+5ar1s/HcroPVOBIrl2v1+tOy/r+
        aAS9mRHjo5EnAtpvYg9dm5+I3A==
X-Google-Smtp-Source: ABdhPJxqjkJty6L9W+sQvodBiYlEfI8iN21rP1srtDp7aU4mqjZOQnrWVrWMUi+CZmEXLW9qt343wg==
X-Received: by 2002:adf:82aa:: with SMTP id 39mr12325286wrc.114.1617314931237;
        Thu, 01 Apr 2021 15:08:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf? ([2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf])
        by smtp.googlemail.com with ESMTPSA id z66sm10490853wmc.4.2021.04.01.15.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 15:08:50 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-2-daniel.lezcano@linaro.org>
 <YGYe9p3oyNpMnsBT@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d0f818c7-3262-268b-bcc2-8036ce559d7b@linaro.org>
Date:   Fri, 2 Apr 2021 00:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGYe9p3oyNpMnsBT@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Greg,

On 01/04/2021 21:28, Greg KH wrote:
> On Thu, Apr 01, 2021 at 08:36:49PM +0200, Daniel Lezcano wrote:
>> A SoC can be differently structured depending on the platform and the
>> kernel can not be aware of all the combinations, as well as the
>> specific tweaks for a particular board.
>>
>> The creation of the hierarchy must be delegated to userspace.
> 
> Why?  Isn't this what DT is for?

I've always been told the DT describes the hardware. Here we are more
describing a configuration, that is the reason why I've let the
userspace to handle that through configfs.

> What "userspace tool" is going to be created to manage all of this?
> Pointers to that codebase?

You are certainly aware of most of it but let me give a bit more of context.

The thermal framework has cooling devices which export their 'state', a
representation of their performance level, in sysfs. Unfortunately that
gives access from the user space to act on the performance as a power
limiter in total conflict with the in-kernel thermal governor decisions.

That is done from thermal daemon the different SoC vendors tweak for
their platform. Depending on the application running and identified as a
scenario, the daemon acts proactively on the different cooling devices
to ensure a skin temperature which is far below the thermal limit of the
components.

This usage of the cooling devices hijacked the real purpose of the
thermal framework which is to protect the silicon. Nobody to blame,
there is no alternative for userspace.

The use case falls under the power limitation framework prerogative and
that is the reason why we provided a new framework to limit the power
based on the powercap framework. The thermal daemon can then use it and
stop abusing the thermal framework.

This DTPM framework allows to read the power consumption and set a power
limit to a device.

While the powercap simple backend gives a single device entry, DTPM
aggregates the different devices power by summing their power and their
limits. The tree representation of the different DTPM nodes describe how
their limits are set and how the power is computed along the different
devices.

For more info, we did a presentation at ELC [1] and Linux PM
microconference [2] and there is an article talking about it [3].


To answer your questions, there is a SoC vendor thermal daemon using
DTPM and there is a tool created to watch the thermal framework and read
the DTPM values, it is available at [4]. It is currently under
development with the goal of doing power rebalancing / capping across
the different nodes when there is a violation of the parent's power limit.



[1]
https://ossna2020.sched.com/event/c3Wf/ideas-for-finer-grained-control-over-your-heat-budget-amit-kucheria-daniel-lezcano-linaro

[2]
https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#power-cr

[3] https://www.linaro.org/blog/using-energy-model-to-stay-in-tdp-budget/

[4] https://git.linaro.org/people/daniel.lezcano/dtpm.git


>> These changes provide a registering mechanism where the different
>> subsystems will initialize their dtpm backends and register with a
>> name the dtpm node in a list.
>>
>> The next changes will provide an userspace interface to create
>> hierarchically the different nodes. Those will be created by name and
>> found via the list filled by the different subsystem.
>>
>> If a specified name is not found in the list, it is assumed to be a
>> virtual node which will have children and the default is to allocate
>> such node.
> 
> So userspace sets the name?
> 
> Why not use the name in the device itself?  I thought I asked that last
> time...

I probably missed it, sorry for that.

When the userspace creates the directory in the configfs, there is a
lookup with the name in the device list name. If it is found, then the
device is used, otherwise a virtual node is created instead, its power
consumption is equal to the sum of the children.

The different drivers register themselves with their name and the
associated dtpm structure. The userspace pick in this list to create a
hierarchy via configfs.

For example, a big.Little system.

- little CPUs power limiter will have the name cpu0-cpufreq
- big CPUs will have the name cpu4-cpufreq
- gpu will have the name ff9a0000.gpu-devfreq
- charger will have the name power-supply-charge
- DDR memory controller can have the name dmc-devfreq

Userspace may want to create this hierarchy:

soc
 - package
   - cluster0
     - cpu0-cpufreq
   - cluster1
     - ff9a0000.gpu-devfreq
   - dmc-devfreq
 - battery
   - power-supply-charge

It will do:

mkdir soc (virtual node)
mkdir soc/cluster0 (virtual node)
mkdir soc/cluster0/cpu0-cpufreq (real device)
etc ...

The configfs does not represent the layout of the sensors or the floor
plan of the devices but only the constraints we want to tie together.

That is the reason why I think using configfs instead of OF is more
adequate and flexible as userspace deals with the power numbers.
Moreover, we won't be facing issues with devices initialization priority
when the daemon starts.

I thought we can add OF later, when the framework has more users and
more devices. The configfs and OF can certainly co-exist or be mutually
exclusive via the Kconfig option.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
