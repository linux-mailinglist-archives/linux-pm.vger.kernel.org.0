Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16A3A7E8E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFOND6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFOND6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 09:03:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA3C061574;
        Tue, 15 Jun 2021 06:01:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x14so24868134ljp.7;
        Tue, 15 Jun 2021 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Je6LUvQqM2+h4QweMn2XdMxL5oyPLqNPW0OGfuboKsg=;
        b=IKTYPkLFGzVGeNItbfYkCLFxvZ42/oPY+6KyaJ9jPOnz9I9SusyGkOPU8iSMWwfOTO
         T9cjw2fMCEg5SJjqdOAsHZ+OVv4xz0eSDgtg53iy2561cW1f3MDrlziMv3vSUl/BUzH5
         Rb2s+ruRRaTXFnVAt2Vc7EhpdKA3KVo/GXcGbEC7cC2dq0OvvDyvLb5hwZsPLuGAgb0y
         zaDpiZ6j4mhtrX0Kgu4BC2V5TkFde72QRCClAmaQaLJ5jnlDtgZBvmeU37WIIhEchG+F
         5ykBNcx+K3DpvjSbpX11mo4lM7ISZEdpO4XqkLak3XGhATSbTHlwKCeW1FDAJOdpBQTP
         UTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Je6LUvQqM2+h4QweMn2XdMxL5oyPLqNPW0OGfuboKsg=;
        b=L6O/1/BgE/ACA06gt1+E1Q94GOPitzTyEUHsOpnpgr6kiKZOP4ujz3s2dSplfPEwWq
         tKn4qszQqtdU8p8iiMO8FjGfjkioGhiO7zVDUZow7C0DwiST5JU2BYZ0qxlQ1hzqoyWs
         /GxT50NKnBoalpXtJ/RLgBNp0d/mm/K1T85rRMU1S8g4JxLTn2+tDhkaVV4Cpb+/PCRp
         Mmxbr4ft+0wh4+i+mDVgtDp6gQuFfC4uxdAPvO+PboY+TBpz0SVAaFOskvTGgSsKOyXZ
         ruoEt1LmJQsLfC5sUTZ2j7M446c+hF9fP5NrabqGyPapVbEzqqyajJ3bJ05kE9wwgi+I
         4R6w==
X-Gm-Message-State: AOAM5307VZ+Yv+UHb0CyBY2eSAyrhTkj3/lw8sYVdEqCN/0zARPwAHuA
        ytMJ+MZ01xWvsdQICMhgiNz7TzU/dLE=
X-Google-Smtp-Source: ABdhPJz05wB+Fj7uIytS6fn9Cd8advl4tRlk0ng7E+slzGo6f5CcKz7Pi96pGAqV9Go+EKbXW8fiNw==
X-Received: by 2002:a05:651c:391:: with SMTP id e17mr17777217ljp.257.1623762109700;
        Tue, 15 Jun 2021 06:01:49 -0700 (PDT)
Received: from [192.168.2.145] (94-29-31-25.dynamic.spd-mgts.ru. [94.29.31.25])
        by smtp.googlemail.com with ESMTPSA id v1sm1799731lfq.284.2021.06.15.06.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:01:49 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
 <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
Date:   Tue, 15 Jun 2021 16:01:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.06.2021 13:26, Viresh Kumar пишет:
> On 15-06-21, 12:03, Daniel Lezcano wrote:
>>
>> [Cc Viresh]
>>
>> On 29/05/2021 19:09, Dmitry Osipenko wrote:
>>> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
>>> monitors temperature and voltage of the SoC. Sensors control CPU frequency
>>> throttling, which is activated by hardware once preprogrammed temperature
>>> level is breached, they also send signal to Power Management controller to
>>> perform emergency shutdown on a critical overheat of the SoC die. Add
>>> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
>>> and a cooling device.
>>
>> IMO it does not make sense to expose the hardware throttling mechanism
>> as a cooling device because it is not usable anywhere from the thermal
>> framework.
>>
>> Moreover, that will collide with the thermal / cpufreq framework
>> mitigation (hardware sets the frequency but the software thinks the freq
>> is different), right ?

H/w mitigation is additional and should be transparent to the software
mitigation. The software mitigation is much more flexible, but it has
latency. Software also could crash and hang.

Hardware mitigation doesn't have latency and it will continue to work
regardless of the software state.

The CCF driver is aware about the h/w cooling status [1], hence software
sees the actual frequency.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=344d5df34f5abd468267daa98f041abf90b2f660

> I am not even sure what the cooling device is doing here:
> 
> tegra_tsensor_set_cur_state() is not implemented and it says hardware
> changed it by itself. What is the benefit you are getting out of the
> cooling device here ?

It allows userspace to check whether hardware cooling is active via the
cooling_device sysfs. Otherwise we don't have ability to check whether
h/w cooling is active, I think it's a useful information. It's also
interesting to see the cooling_device stats, showing how many times h/w
mitigation was active.

>> The hardware limiter should let know the cpufreq framework about the
>> frequency change.
>>
>> 	https://lkml.org/lkml/2021/6/8/1792
>>
>> May be post the sensor without the hw limiter for now and address that
>> in a separate series ?
> 

I wasn't aware about existence of the thermal pressure, thank you for
pointing at it. At a quick glance it should be possible to benefit from
the information about the additional pressure.

Seems the current thermal pressure API assumes that there is only one
user of the API. So it's impossible to aggregate the pressure from
different sources, like software cpufreq pressure + h/w freq pressure.
Correct? If yes, then please let me know yours thoughts about the best
approach of supporting the aggregation.

I'll factor out the h/w limiter from this patchset and prepare the v4.
Thank you all for taking a look at the patches.
