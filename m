Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5A211644
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgGAWtI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 18:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgGAWtH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 18:49:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE4C08C5C1;
        Wed,  1 Jul 2020 15:49:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so14470122ljl.3;
        Wed, 01 Jul 2020 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fPsKBXYO3Tet43XDuQQQGHQH4tCc1yYACrZBORXJJ68=;
        b=P0OE/MumCxoQHzp+GCtkevXNIAcpHJsUmxKsWnF8E1eywTmWNV6oX3GnvLK1aG7FwD
         jGy4vCh5PmmvcMxM109Hek7o0qwA+M1CTyrrHC+libila3qa5u6UOMqtTQeNkfxk963F
         TcrgsN3pEF8+YDxjzWCWe2PoWqrBSDOepgwFJerG/hqx0QVvU2fz2aHw8J9p2wErRJ7T
         7C3EFanMwtolcDSkfpwohVvbyEXBZdmwrPAKzBH298ZQ33znZZlE230Uldn+WMxF5HV8
         YrrYCwfKhKIMWp/trkrVuD7UW/beL6st6Hc2/csDzyOYBoZU+qQx6/8rWHOaTTQFTpBg
         bhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fPsKBXYO3Tet43XDuQQQGHQH4tCc1yYACrZBORXJJ68=;
        b=IdTxkEmlXYayfsJddMpeGtRUdgHjmTYaM1brC5Nfa14CS22CAJ8CHOhZ5omQKBM2HQ
         MyQuhexS3z93wxpl1rkPgtEXLuxOQao6/9yQosDxOd0eVLDR8kKmqMztp6zJSjh70zWi
         O4+a3H2/sQa6EiOYBYe6tIuZZ4FrLd7KU2VFPQZituaRTl97O/OeFevtxzvPhNgphhyp
         IHnXpvIEKX9AYyQCSlOYUu+LZKGyweuWUuWOdKD8Nl5yNkzIVsGumLRrGrgEUWwcBlNk
         jwRk/PBpfPBmB1GRdZGn6A0k81LP/EjSY52BesWUx7/M0Hr/C60fIf7hK1ePwQQ71z9Y
         fSAQ==
X-Gm-Message-State: AOAM533Ha/4ebjkBiKNYTCt2rYRcPewxjGFNsjzPqHtb7wsMvu8Zau/f
        yTwGVJIBooz4LRseev/Z6bCmUV1gUoc=
X-Google-Smtp-Source: ABdhPJxxRc70R0rtUr+V01v5C1hWj1YNSddKIovHKWqwJ4E7h9yElLNZVKCZhYW11WqsARdGDa6y+w==
X-Received: by 2002:a2e:81c8:: with SMTP id s8mr14561656ljg.281.1593643745475;
        Wed, 01 Jul 2020 15:49:05 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id l1sm2286341ljc.65.2020.07.01.15.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:49:04 -0700 (PDT)
Subject: Re: [PATCH v1] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200629222625.674-1-digetx@gmail.com>
 <d9efb0f5-d6ab-f3db-540e-c6ae1b42e45e@nvidia.com>
 <4bae133b-1b51-281c-1759-ca0d259b18ca@gmail.com>
 <a55f74fd-1105-1576-8f73-d6d3062541ef@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de1d5c68-0714-3b50-9d39-9351950308e7@gmail.com>
Date:   Thu, 2 Jul 2020 01:49:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a55f74fd-1105-1576-8f73-d6d3062541ef@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.07.2020 16:56, Jon Hunter пишет:
> 
> On 30/06/2020 19:54, Dmitry Osipenko wrote:
>> 30.06.2020 12:02, Jon Hunter пишет:
>>>
>>> On 29/06/2020 23:26, Dmitry Osipenko wrote:
>>>> The arm_cpuidle_simple_enter() returns the entered idle-index and not a
>>>> error code. It happened that TEGRA_C1=index=err=0, and hence this typo
>>>> was difficult to notice in the code since everything happened to work
>>>> properly. This patch fixes the minor typo, it doesn't fix any problem.
>>>
>>> I guess that is dependent on if CPUIDLE is enabled ...
>>>
>>> #ifdef CONFIG_CPU_IDLE
>>> extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>>>                 struct cpuidle_driver *drv, int index);
>>> #else
>>> static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>>>                  struct cpuidle_driver *drv, int index) { return -ENODEV; }
>>> #endif
>>>
>>> Looks like it could return an error.
>>
>> Hello Jon!
>>
>> The cpuidle's enter() callback returns an index of the entered state on
>> success, on negative value on failure.
> 
> Yes, however, when I read the first sentence of the changelog it seemed
> to suggested it would never return and error code. Perhaps you meant in
> the context of the Tegra CPUIdle driver because CPU_IDLE is always enabled?

Yes, the commit message could be improved in regards to the error
condition clarification. I'll update it in v2, thank you for the suggestion!

>> The negative number *could be* a proper error code, but in the same time
>> it also doesn't matter what's the exact negative value is for the
>> cpuidle's core code. Please see more below!
>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/cpuidle/cpuidle-tegra.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>>>> index 150045849d78..9e9a9cccd755 100644
>>>> --- a/drivers/cpuidle/cpuidle-tegra.c
>>>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>>>> @@ -236,14 +236,14 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>>>  			       int index)
>>>>  {
>>>>  	unsigned int cpu = cpu_logical_map(dev->cpu);
>>>> -	int err;
>>>> +	int err = 0;
>>>>  
>>>>  	index = tegra_cpuidle_adjust_state_index(index, cpu);
>>>>  	if (dev->states_usage[index].disable)
>>>>  		return -1;
>>>>  
>>>>  	if (index == TEGRA_C1)
>>>> -		err = arm_cpuidle_simple_enter(dev, drv, index);
>>>> +		index = arm_cpuidle_simple_enter(dev, drv, index);
>>>>  	else
>>>>  		err = tegra_cpuidle_state_enter(dev, index, cpu);
>>>>  
>>>>
>>>
>>> However, I do think that there is something not right in the error handling
>>> here. Would also be nice to get rid of these -1.
>>
>> IIRC, the -1 was borrowed from some other cpuidle driver, for example
>> cpuidle-psci[1] and coupled.c[2] are returning -1 on a failure.
> 
> Indeed. Maybe we just let sleeping dogs lie in this case.

+1

We could always return to this later on, once there will be a real need.
