Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF224ECB67
	for <lists+linux-pm@lfdr.de>; Wed, 30 Mar 2022 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349439AbiC3SKX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Mar 2022 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349698AbiC3SKL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2022 14:10:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC830559
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 11:08:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so384827wms.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WaS8wZZ6NV9QgDXszAGAjD+KYanb9wxfrEhZWXKcw8g=;
        b=fjiknt7ZbNRXFdv66lc7dvkgOeiZdxXBz0SiLF61ondJH7S4H5fpIgYEHxvzQ/IPqB
         Mb6PnN+RRPUUoAhO+P29v7wIwUee7NBxZqeFVArdZaeFJY6fO/TCoIqNv1a5bARGjSag
         L0V6iKrmICFbDeWm8H6RQRYCDQXU2uvpDGkq7FjjcVfvDM5UF5jHhndkj0NXXCt9+1BX
         Q76D9zt0gBUpWtzg7RbUPgVr9NJ0aT2VUqRCTgyngLPpJEtCJuIwv1gh5WcDN5zX3+0R
         hdHWTfCJ5kKODf0TnfQ2oxh4iq1I0PMIkGQ6KbUS4FXnLAfai5M4J86mTYbjbJOGIdZO
         v9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WaS8wZZ6NV9QgDXszAGAjD+KYanb9wxfrEhZWXKcw8g=;
        b=Aiw8oNSzYCrFGwRQ2sv4YGvU9RDWRz8sos9f2EbGz094TBdYf/6YgPLr65FoLk1L8q
         nkrfuSlayDxJuNdjhIyxK4lA7z7F2pE6ljf+BY9GAo9a46c+DP8hTZZuRqaSt0AxH9z+
         BIV9IUpyXUARQJWfn7J3OMB426hFGRbJEnSwNCAzw5GUDN5IfagD/6eXmJusBT8IPhmZ
         lKeZR/CBYAqDEjoWg7yIv9Kzc3zi850HBVuPqFBVoFAD/qsuqv8wLG3gos27E2Am1GtS
         HjgsloC0wpdgiq6TwMbuoKIcmjoyz7nC5NLdlGSV8cDQK92n/gfD7t6duWegzeUl0ZzB
         fxgA==
X-Gm-Message-State: AOAM530qhxiuyuvIbk5G9cysoXBYgUM5vqSdd1M0+idGdNiPHMFKdbga
        US/XMCZRFVOEVK5F+yUYnSvOpA==
X-Google-Smtp-Source: ABdhPJwGFsL1/F2Xah1Fmbs3eE+BDFto3QwJa2fvOjPNKKFkOHDrWUrwqh9G94XoRVHpi2VaB4vlpA==
X-Received: by 2002:a05:600c:4fc8:b0:38c:9f6a:1b4c with SMTP id o8-20020a05600c4fc800b0038c9f6a1b4cmr697483wmq.68.1648663701737;
        Wed, 30 Mar 2022 11:08:21 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8? ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.googlemail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm22954646wry.32.2022.03.30.11.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:08:20 -0700 (PDT)
Message-ID: <f48f8bcc-0d1c-0a36-0e50-2e6b17a645a2@linaro.org>
Date:   Wed, 30 Mar 2022 20:08:18 +0200
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

I'll answer to your email but meanwhile this can have some interest for you:

 
https://lore.kernel.org/all/20220330100444.3846661-1-daniel.lezcano@linaro.org/

Regards

  -- Daniel

On 30/03/2022 17:45, Chris Down wrote:
> Hey thermal folks,
> 
> I'm hoping that you'll be able to provide some guidance on what options 
> are available for getting thermal notifications without changing the 
> policy to userspace control.
> 
> To be clear, my intent is to have a userspace daemon which can set 
> multiple temperature trips at runtime on which it can receive a 
> notification (preferably by a simple mechanism like uevents), and to be 
> able to distinguish which threshold was tripped. For example, to be able 
> to set trips at 50C, 70C, and 90C, getting events both when the 
> temperature exceeds that and when it dips back under the specified 
> threshold.
> 
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
> 
> If that's correct, then it seems dangerous to set it to user_space for 
> userspace applications which only want to monitor their own trip 
> temperatures, but not take direct action.
> 
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
> 
> In general I would prefer something simpler that fits into the existing 
> strong tooling around uevents/etc though, this looks useful, but it does 
> a lot more than I need and requires adding another userspace dependency 
> on libnl.
> 
> 4. Poll /sys/class/thermal/thermal_zone*/temp or hwmon
> 
> This is what I'm currently doing. It's slow, and often unnecessarily 
> costly on weaker systems.
> 
> Are there other options I'm not considering here that might help me out 
> here?
> 
> Thanks,
> 
> Chris


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
