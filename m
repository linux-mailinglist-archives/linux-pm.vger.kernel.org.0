Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0A4ECF97
	for <lists+linux-pm@lfdr.de>; Thu, 31 Mar 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351550AbiC3W0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Mar 2022 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244671AbiC3W0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2022 18:26:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BB4E3B0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 15:24:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso906243wmn.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z8/F2Ft2+T4lT3wAALTeq2gwW+36osrTF5QO+aQqWdo=;
        b=kwlcKITS/BmYPMU5CHF54WWHWDPKilXtemeTeUqPdTbTwmC3ORMjBcobxvQuWuQ37T
         DjE9ZvbKtJuSVe+jK7pvHRjSNgExcMAjhf7kZoHOtHojii1NdOHJm3ieu9L2ONZ/r23M
         7W+zHJhg/rOjT3eVAlikf3/qY15czQOT1G8xM5jIE7vz7uVhhnSMByybp2UyNpdDZXU0
         QZ4xLhZVWn4Yf55KOBWWG/kRnaG96l1XIheN9GVZhFj1I8kkHPZ2VxpcCEaBm32suvXh
         1MGh6lyP+DJwQKsly0d6YZLNymyE7gZRyLmpuDYQrnL7OyBKNtAobm3+5U782bPkTAQw
         Vhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z8/F2Ft2+T4lT3wAALTeq2gwW+36osrTF5QO+aQqWdo=;
        b=pKiVvncks+OEdJKK1AwjwMA/35V75CFXKYZEpJHExUm3oALXd4p5XiLKexR1zc7kYs
         JudWKy/wxxrtLy3hNZh7uzsa2LFyxm2yIXXcor6vWIN/AnI/mPnlFt3IfrK6PvBXhTBC
         zSqlC0z6DIUrJy4YzPAapmUvilHksHhFKNAOZIXKpWAOGQDLCbXFvFmtYhHMZMHAW6B0
         +qHFgacEzTF3SmuziQpVeDG3YdDDOwFCO8NIsymdEWjID6t4w+4fYr4Z+jSxIOw+FiBK
         5DWs5ZCNmvd1QJXwaMlqgWgqRZClxPuCrMGS5v5PO14AIFGJEqxGj0YM/tDMyc7OphcF
         zyGA==
X-Gm-Message-State: AOAM5324JRXViYvTl/nZ57ZXdntBKdXJFuHtAV+3bCS46nYHsI8pWDtP
        cU1yZ4ePB4jGfEmTD3ZI/PntVs2VUNzd/g==
X-Google-Smtp-Source: ABdhPJy9pB9/UxuJHLX3uDDO6tQkFDellKduiHDiaaEvMPAu01JV1V7bqfLZoSz4XizYxAjwxXWG8Q==
X-Received: by 2002:a05:600c:3785:b0:38c:9b55:a477 with SMTP id o5-20020a05600c378500b0038c9b55a477mr1697117wmr.164.1648679060825;
        Wed, 30 Mar 2022 15:24:20 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8? ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d4309000000b00205b90434e2sm11231590wrq.114.2022.03.30.15.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 15:24:20 -0700 (PDT)
Message-ID: <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
Date:   Thu, 31 Mar 2022 00:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Content-Language: en-US
To:     Chris Down <chris@chrisdown.name>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YkR6/KnH/f9U+2qf@chrisdown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Chris,

On 30/03/2022 17:45, Chris Down wrote:
> Hey thermal folks,
> 
> I'm hoping that you'll be able to provide some guidance on what options 
> are available for getting thermal notifications without changing the 
> policy to userspace control.

That is now possible with the netlink notifications mechanism.

https://www.linaro.org/blog/thermal-notifications-with-netlink/

> To be clear, my intent is to have a userspace daemon which can set 
> multiple temperature trips at runtime on which it can receive a 
> notification (preferably by a simple mechanism like uevents), and to be 
> able to distinguish which threshold was tripped. For example, to be able 
> to set trips at 50C, 70C, and 90C, getting events both when the 
> temperature exceeds that and when it dips back under the specified 
> threshold.

For that it would require to setup a trip point from the firmware 
dedicated to userspace management along with the writable trip point 
kernel config option.

On embedded systems, the trip point can be added easily in the device tree.

You would end up with:

  - one passive trip point : writable and used by userspace

  - one passive trip point to protect the system tied with a cooling 
device and handled by the kernel

  - one hot trip point to notify the userspace critical is about to be reach

  - one critical trip point to reboot the system

 From the userspace, you change the trip temp to 50°C, 70°C and 90°C 
when crossing the way up or the way down.

The sensor should implement the set_trip in order to program the 
register to fire the interrupt at the specified temperature. Otherwise, 
monitoring will be needed.

On ACPI, except hacking the table and reload from the kernel I don't see 
how to do that.


> Right now I am polling /sys/class/thermal/thermal_zone*/temp but this 
> can be expensive, especially for the ACPI thermal zone.
> 
> As it is, I see four options:
> 
> 1. Set thermal_zone to use user_space governor and use uevents
> 
> As I understand it, this means that the default critical temperature 
> will no longer be respected and user space is now responsible for taking 
> action to control thermal events.

The userspace governor is marked deprecated and will be removed soon. 
The decision was because this governor was only used for the sake of 
having the notification but at the cost of losing the in-kernel control 
of the thermal zone.

The netlink notification solving that, the userspace governor is no 
longer needed.

> If that's correct, then it seems dangerous to set it to user_space for 
> userspace applications which only want to monitor their own trip 
> temperatures, but not take direct action.

Right

> 2. Use hwmon thermal events
> 
> I see that commit 1597b374af22 ("hwmon: Add notification support") adds 
> notification support to hwmon, but as far as I can tell this is based on 
> statically defined trip temperatures from ACPI or similar inputs. I see 
> you can change it with the thermal.crt boot option, but that's too early 
> for a normal userspace daemon to do anything (and it doesn't allow any 
> dynamic reconfiguration).
> 
> 3. Use thermal over netlink
> 
> I see that commit 1ce50e7d408e ("thermal: core: genetlink support for 
> events/cmd/sampling") which was merged a couple of years ago adds 
> support for thermal netlink events.
> 
> I also see articles suggesting that support for this new netlink 
> interface will be or was added to libnl, but I can't seem to find 
> anything about it in the libnl sources.
> 
> Is this mature enough to use? If so, does one have to hack up their own 
> userspace netlink library for now, or what's the plan there?


For the record, everything is here:

https://lore.kernel.org/all/20220330100444.3846661-1-daniel.lezcano@linaro.org/


> In general I would prefer something simpler that fits into the existing 
> strong tooling around uevents/etc though, this looks useful, but it does 
> a lot more than I need and requires adding another userspace dependency 
> on libnl.


Yeah, that is the drawback.


> 4. Poll /sys/class/thermal/thermal_zone*/temp or hwmon
> 
> This is what I'm currently doing. It's slow, and often unnecessarily 
> costly on weaker systems.

If the sensor backend drivers has the set_trip ops working and setting 
the interrupt for the next threshold, that should be solved with the 
writable trip point.

Otherwise, the netlink sampling channel can be used with the in-kernel 
monitoring. The cost of a back and forth netlink message is 14us on a 
Cortex-A75@2.8GHz (the half if just getting a notification or sampling)

> Are there other options I'm not considering here that might help me out 
> here?

Yes, I assume the daemon gets notification but has to do an action. 
Usually, it acts on the cooling device and that is bad.

There is a power capping framework called DTPM which aims to provide a 
way to set a power limitation on the device. As it is very new, it is 
only supporting ARM with an energy model for CPU and any devfreq device 
(eg. GPU and memory).

More details here:

https://resources.linaro.org/en/resource/oyFSkedFn1RPeSLKhcQ1T3


Hope that helped

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
