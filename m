Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CAF44EA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 11:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfKHKrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 05:47:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40397 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfKHKrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 05:47:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so5685672wmc.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NNg0zGyqKJ0CjDC2l4AU4IPx3Itn985JlpvDWoMqe8=;
        b=RW5RDen1wY419vEK4wTpV0XyJSQzB+EexK5PbkB2iY217FweXvQ55TboQTuEJeKXBj
         O4Zmmkl+yP1o/xqibpu2P7vAx3Pmtk236CgLUdxiPe+cQ8W69RlCY2FNURqKkadtm321
         gz2fULRq5czL1DbLd5o/Ipx0QtyVIl93SrgFz1r/oVXC9n49LFTVoaWV1NACdxtXlhkq
         dDkpCbTKAzmoofArrIRK97JUAtwFW09bXM+76FUSvrQFKzUPAQ61ghdRxUzRivOl/HFI
         mQeIXC5C2r09m8JoMLuNujzzkxJ1HDbheSFoMlqkr7HP7H1+FrCdkMePECzjKa3xNMFJ
         zBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0NNg0zGyqKJ0CjDC2l4AU4IPx3Itn985JlpvDWoMqe8=;
        b=K9Ws281dOjaKWSwPSZ/1UKSgTmKP4sK7jQFwDsQwX4GQQI55+T87ad5q0evLan3N9k
         rsolI0LFw1oPr6P5sLEJ1I0wEItJekNfLrPVt72lYBvghJ/AxbKXnP5f4nATwvsxTcEe
         iUW9n7BFBkkoFLIrKAW3GbhvUrOk+VIW/z22AVEaVj15C6SaqTZse8nWosCRO9jl8wyv
         iopQV99A8T4FqdbSjro71hjWKVqbwDCAJ8NxfxkXRZ1fzDQd4y1Fy/hm3B9TWpm5WzE2
         T64i7Mgx5ft+n8NxqyZF+xoNiX7IYq56F+ZqGZlwyhKsDtwgfJ3omKPfx4vMrcRmuEXO
         OLRQ==
X-Gm-Message-State: APjAAAWRTOwimlJLkp87KZaI5q7PJ99b5Ila5CyLIYDAgFFARDkZTmA/
        PujcaNFCXb4TlTEGWU/u5nP7Yw==
X-Google-Smtp-Source: APXvYqxON0z1YCynMVaGDrZhH2Uwt+V9UdhDOGIqYJeRK1N53a0pSsxbNJioYiCac/v5PZHAZk8eEA==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr7600115wmg.121.1573210028817;
        Fri, 08 Nov 2019 02:47:08 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:85c9:ca0d:aae1:f680? ([2a01:e34:ed2f:f020:85c9:ca0d:aae1:f680])
        by smtp.googlemail.com with ESMTPSA id y15sm4835935wrh.94.2019.11.08.02.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 02:47:08 -0800 (PST)
Subject: Re: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle
 state
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
References: <20191030075141.1039-1-daniel.lezcano@linaro.org>
 <20191030075141.1039-2-daniel.lezcano@linaro.org>
 <143021538.HHUP3Pj7i7@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9dfe3bd3-1903-4dc4-0605-27cc867d87ad@linaro.org>
Date:   Fri, 8 Nov 2019 11:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <143021538.HHUP3Pj7i7@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/11/2019 02:20, Rafael J. Wysocki wrote:
> On Wednesday, October 30, 2019 8:51:40 AM CET Daniel Lezcano wrote:
>> Currently, the play_idle function does not allow to tell which idle
>> state we want to go. Improve this by passing the idle state as
>> parameter to the function.
>>
>> Export cpuidle_find_deepest_state() symbol as it is used from the
>> intel_powerclamp driver as a module.
>>
>> There is no functional changes, the cpuidle state is the deepest one.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>   V6:
>>    - Change variable name 'state' -> 'index':
>>      https://lkml.org/lkml/2019/10/28/874
>>   V4:
>>    - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
>>      intel_powerclamp driver when this one is compiled as a module
>>   V3:
>>    - Add missing cpuidle.h header
>> ---
>>  drivers/cpuidle/cpuidle.c                | 1 +
>>  drivers/powercap/idle_inject.c           | 4 +++-
>>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
>>  include/linux/cpu.h                      | 2 +-
>>  kernel/sched/idle.c                      | 4 ++--
>>  5 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 18523ea6b11b..b871fc2e8e67 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
>>  
>>  	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>>  }
>> +EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);
> 
> That doesn't appear to be really necessary to me.
> 
>>  
>>  #ifdef CONFIG_SUSPEND
>>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
>> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
>> index cd1270614cc6..233c878cbf46 100644
>> --- a/drivers/powercap/idle_inject.c
>> +++ b/drivers/powercap/idle_inject.c
>> @@ -38,6 +38,7 @@
>>  #define pr_fmt(fmt) "ii_dev: " fmt
>>  
>>  #include <linux/cpu.h>
>> +#include <linux/cpuidle.h>
>>  #include <linux/hrtimer.h>
>>  #include <linux/kthread.h>
>>  #include <linux/sched.h>
>> @@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
>>  	 */
>>  	iit->should_run = 0;
>>  
>> -	play_idle(READ_ONCE(ii_dev->idle_duration_us));
>> +	play_idle(READ_ONCE(ii_dev->idle_duration_us),
>> +		  cpuidle_find_deepest_state());
> 
> The next patch changes this again and I'm not sure why this intermediate
> change is useful.
> 
>>  }
>>  
>>  /**
>> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
>> index 53216dcbe173..b55786c169ae 100644
>> --- a/drivers/thermal/intel/intel_powerclamp.c
>> +++ b/drivers/thermal/intel/intel_powerclamp.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/kthread.h>
>>  #include <linux/cpu.h>
>> +#include <linux/cpuidle.h>
>>  #include <linux/thermal.h>
>>  #include <linux/slab.h>
>>  #include <linux/tick.h>
>> @@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
>>  	if (should_skip)
>>  		goto balance;
>>  
>> -	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
>> +	play_idle(jiffies_to_usecs(w_data->duration_jiffies),
>> +		  cpuidle_find_deepest_state());
> 
> I don't see a reason for changing the code here like this.
> 
> What you really need is to have a way to set a limit on the idle
> state exit latency for idle injection on ARM.

Mmh, yes you are right. The idle state number is part of the internals
of the cpuidle framework while the exit latency is an input (from user
or kernel).

> For that you can pass the exit latency limit to play_idle(), but then
> you need to change powerclamp to pass UNIT_MAX or similar which is
> ugly, or you can redefine cpuidle_use_deepest_state() to take the
> exit latency limit as the arg (with 0 meaning use_deepest_state == false).

Should it make sense to just get the resume latency in
cpuidle_use_deepest_state() and pass the value to find_deepest_state()?

It is the only code path where the constraint is not taken into account
AFAICT.

With this simple change, we can manage everything from the pm_qos API
then and this series is no longer needed.

> In the latter case, it would be quite straightforward to add an
> exit_latency argument to cpuidle_find_deepest_state() and note that
> find_deepest_state() takes a max_latency arg already, so that would be
> a trivial change (hint!).


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

