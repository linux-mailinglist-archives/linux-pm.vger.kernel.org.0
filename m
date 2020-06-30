Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFD20FC49
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgF3SzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgF3SzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:55:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45519C061755;
        Tue, 30 Jun 2020 11:55:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so20249926ljp.6;
        Tue, 30 Jun 2020 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BzgMhXLEUdnpV+eyiXp8gY+NYcPXZt80LsSxCrt130w=;
        b=Fo4rsg9H56IFS5D6ha3r5T6pqcQWPWslqUXu7kmBvkklL7wJeH3/nl7CKgFL21ghuy
         9rNrp2/e1H5T168hRirL0tgYM3ttdLYx+qDNm0pMuPCgpxtgJyRj0iCInQw2GFWe6GVa
         9lySD/DX9Hdo8MBJmertxwdGWyzPmcQ1Ly5MBtIzTVcAaSp9O2gk+EkXIVDhlw/vLQ5b
         gSQ+MPWtPJ0C3qEezUAKJgaKc7gK3fEA3ulM3AolgdBF9huNYRvsWRYGxUuUazR10rd/
         m5AzdWfnDSFig3GRjXEC/OF9UD8xoZwq7mF2wOYJmowN6cr6whdMq5UeV5/pG2ZrtZGd
         sqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzgMhXLEUdnpV+eyiXp8gY+NYcPXZt80LsSxCrt130w=;
        b=hp6QRcTFNoT551qDamadfv31MOYcBsb7VQDoNMhTfe1a+t68zubocctS0XpvmFoV/8
         jOkGKE08DkNEd8xyZmzNA1pb85bPk5xI9g4vi+kQEIVFQdQTjMbwKcLnZzn7c53sum9I
         7EQNdVvcs2e1Eh34PnjB45Rs8rOiBuLklasuZGNdgNec3mJm+Y32Ew+d3uRnINsfBY/I
         Z3yS+3Odt+AiD86DEDQZmw2Kk4mXxKsSJkBqHbOwIoL6LOprmnxoSjFQJMEC7Qs7MbjZ
         WjrZPdAmBtgrUEilQ1PLrVl3hIB/ZBbQevnXUcGgOPqS5kezbbJ+Mp4q7IuJI7jGQ0g9
         GZ6g==
X-Gm-Message-State: AOAM531vPNwal/SeQ6YO452CA4X1SLq8umKqCHLFGpgA1kxpeNg1ufbi
        jCScoEUH1xBCNpqzAPKM/6Ru4mnjR6c=
X-Google-Smtp-Source: ABdhPJyhPR2tcOOOHwWqsufCXF381rfcl46YGZknX8X4/gNKMNA8HDyZUfQJJet9owInRvF70mAoJg==
X-Received: by 2002:a05:651c:119a:: with SMTP id w26mr10725430ljo.126.1593543299276;
        Tue, 30 Jun 2020 11:54:59 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id z1sm990910ljn.88.2020.06.30.11.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:54:58 -0700 (PDT)
Subject: Re: [PATCH v1] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200629222625.674-1-digetx@gmail.com>
 <d9efb0f5-d6ab-f3db-540e-c6ae1b42e45e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4bae133b-1b51-281c-1759-ca0d259b18ca@gmail.com>
Date:   Tue, 30 Jun 2020 21:54:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d9efb0f5-d6ab-f3db-540e-c6ae1b42e45e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.06.2020 12:02, Jon Hunter пишет:
> 
> On 29/06/2020 23:26, Dmitry Osipenko wrote:
>> The arm_cpuidle_simple_enter() returns the entered idle-index and not a
>> error code. It happened that TEGRA_C1=index=err=0, and hence this typo
>> was difficult to notice in the code since everything happened to work
>> properly. This patch fixes the minor typo, it doesn't fix any problem.
> 
> I guess that is dependent on if CPUIDLE is enabled ...
> 
> #ifdef CONFIG_CPU_IDLE
> extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>                 struct cpuidle_driver *drv, int index);
> #else
> static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>                  struct cpuidle_driver *drv, int index) { return -ENODEV; }
> #endif
> 
> Looks like it could return an error.

Hello Jon!

The cpuidle's enter() callback returns an index of the entered state on
success, on negative value on failure.

The negative number *could be* a proper error code, but in the same time
it also doesn't matter what's the exact negative value is for the
cpuidle's core code. Please see more below!

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpuidle/cpuidle-tegra.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>> index 150045849d78..9e9a9cccd755 100644
>> --- a/drivers/cpuidle/cpuidle-tegra.c
>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>> @@ -236,14 +236,14 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>>  			       int index)
>>  {
>>  	unsigned int cpu = cpu_logical_map(dev->cpu);
>> -	int err;
>> +	int err = 0;
>>  
>>  	index = tegra_cpuidle_adjust_state_index(index, cpu);
>>  	if (dev->states_usage[index].disable)
>>  		return -1;
>>  
>>  	if (index == TEGRA_C1)
>> -		err = arm_cpuidle_simple_enter(dev, drv, index);
>> +		index = arm_cpuidle_simple_enter(dev, drv, index);
>>  	else
>>  		err = tegra_cpuidle_state_enter(dev, index, cpu);
>>  
>>
> 
> However, I do think that there is something not right in the error handling
> here. Would also be nice to get rid of these -1.

IIRC, the -1 was borrowed from some other cpuidle driver, for example
cpuidle-psci[1] and coupled.c[2] are returning -1 on a failure.

[1]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/cpuidle/cpuidle-psci.c#L63
[2]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/cpuidle/coupled.c#L473

Looking at the the cpuidle's call chain, all of the code checks only
whether the returned value of the enter() is negative or not and in the
end that value is ignored [3][4].

[3]
https://elixir.bootlin.com/linux/v5.8-rc3/source/kernel/sched/idle.c#L216
[4]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/cpuidle/cpuidle.c#L360

Indeed, it would be better to return something more meaningful, but what
should we return for a disabled state if not -1?
