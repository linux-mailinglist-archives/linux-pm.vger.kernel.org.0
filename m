Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C50116CD0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 13:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfLIMDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 07:03:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIMDV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 07:03:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so15181607wmj.4
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 04:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ehhSM/AEybir7J/IIWP4SOv1xJ3+Whs3x7c6evVuMA=;
        b=GheOp4M6CbgeQhGO7WsE/Pzzq5w3VldnRwKpTJgVBjoBxmmiLxwd245k5BXoFvvDUz
         Hq+lRqhb+pFNrcF7+o2v91ZJOEum3TlsBLZtGIp20JuKQRUL/URSKjZqsR5VA0lwwTD/
         EelzpSfRkKYg7cTwjZtJex/PHBtekLnSqn2AxlggkJF3sI1fXwemNOmwyycIuGJJJw4T
         d4dLjJz7wvUOJquj/LxgQffmJjBUcQMLc+DLhODh+uWer4eESumHpdT54qEIS6w6KVEh
         6hmu7NX8241s4Aq3af6B5BgKu0EoxXfZQspYN4T2cJAeD3wxZduRbULYDU98RIWWiet1
         Y8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+ehhSM/AEybir7J/IIWP4SOv1xJ3+Whs3x7c6evVuMA=;
        b=RJbWH5zkQPnYYOBhMI5LFnx45tvH5Y2iRTAxtKn8UO+5Z22oeOdyPvI9BEGWIEhFsc
         NvKSoc2MmJaCaTNr/AZxpU+0WzWW1c4exvViy1yya/XWiJFZyJt8lK07AqeHr8Gd7kc6
         Q69MNygFCNjwol9qijR/cAaE343/pP9SilxQZ2Roe9F2d2p99ofRrYfq+bH7Z/GMB9ET
         bOCP22cWc9/dYJUSqltyoUaMNi4fTXTBbHEIFTy8IkzFq9xJptLcNGMLxKpVqCV9WQaW
         JnLvFLHTokxRiKa0+AlIT+EBBWwXfwg8oCW8Xd1vdi/S+d4BxEiUCDA+raSgPZQtajIP
         LK0Q==
X-Gm-Message-State: APjAAAVYckKEGX6al3BlBpc6wZhqkdk0P+PKqmI23K9xc7z8zIQ5K10v
        itpeBOCviss2Ayra5zlYukJR4w==
X-Google-Smtp-Source: APXvYqwh+T1cgoxXaaSsXjJ1TupeYogp5VPe+saQ99SIpwpi/5Ek//wbmyeXdd905Cjx5OrWv8ynzQ==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr10645448wmk.14.1575892997661;
        Mon, 09 Dec 2019 04:03:17 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id u8sm11646492wmm.15.2019.12.09.04.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 04:03:17 -0800 (PST)
Subject: Re: [PATCH V4 4/4] thermal/drivers/cpu_cooling: Rename to
 cpufreq_cooling
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, edubezval@gmail.com,
        rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
References: <20191204153930.9128-4-daniel.lezcano@linaro.org>
 <20191206113315.18954-1-martin.kepplinger@puri.sm>
 <e6cbe4fb-8b04-cff6-f2af-6c5829d9deb1@linaro.org>
 <7ae753bd-8330-6652-0207-0c884d722a6c@puri.sm>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2beb4758-d66d-e8d9-a64d-86ce361aa57f@linaro.org>
Date:   Mon, 9 Dec 2019 13:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7ae753bd-8330-6652-0207-0c884d722a6c@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/12/2019 10:54, Martin Kepplinger wrote:
> 
> 
> On 06.12.19 15:15, Daniel Lezcano wrote:
>> On 06/12/2019 12:33, Martin Kepplinger wrote:
>>> I tested this on the librem5-devkit and see the
>>> cooling devices in sysfs. I configure ARM_PSCI_CPUIDLE, not ARM_CPUIDLE and
>>> add the patch below in register the cooling device there. "psci_idle"
>>> is listed as the cpuidle_driver.
>>>
>>> That's what I'm running, in case you want to see it all:
>>> https://source.puri.sm/martin.kepplinger/linux-next/commits/next-20191205/librem5_cpuidle_mainline_atf
>>>
>>> so I add a trip temperature description like this:
>>> https://source.puri.sm/martin.kepplinger/linux-next/commit/361f49f93ae2c477fd012790831cabd0ed976660
>>>
>>> When I let the SoC heat up, cpuidle cooling won't kick it. In sysfs:
>>>
>>> catting the relevant files in /sys/class/thermal after heating up,
>>> if that makes sense:
>>>
>>> 87000
>>> 85000
>>> 85000
>>> thermal-cpufreq-0
>>> 1
>>> thermal-idle-0
>>> 0
>>> thermal-idle-1                                                                  
>>> 0                                                                               
>>> thermal-idle-2
>>> 0
>>> thermal-idle-3
>>> 0
>>>
>>> with ARM_CPUIDLE instead of ARM_PSCI_CPUIDLE (and registering the cooling dev
>>> during cpuidle-arm.c init) I won't have a cpuidle driver and thus no cpu-sleep
>>> state at all.
>>>
>>> Can you see where the problem here lies?
>>
>> Yes, I removed the registration via the DT.
>>
>> Can you try the following:
>>
>> diff --git a/drivers/cpuidle/dt_idle_states.c
>> b/drivers/cpuidle/dt_idle_states.c
>> index d06d21a9525d..01367ddec49a 100644
>> --- a/drivers/cpuidle/dt_idle_states.c
>> +++ b/drivers/cpuidle/dt_idle_states.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/cpu_cooling.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>
>> @@ -205,6 +206,9 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>>  			err = -EINVAL;
>>  			break;
>>  		}
>> +
>> +		cpuidle_of_cooling_register(state_node, drv);
>> +
>>  		of_node_put(state_node);
>>  	}
>>
>> That's a hack for the moment.
>>
> 
> thanks. I could test that successfully. The only question would be: Is
> is intentional how "non-aggressive" the cooling driver cools? I would
> have expected it to basically inject more idle cycles earlier. I'd set
> 75 degrees as trip point and at 85 degress is would only inject about 30
> (of 100).
> 
> You describe the "config values" in question in the documentation, but
> I'm not sure what's the correct way to change them.

That is difficult to say without knowing the board behavior. Are you
able to profile the temperature with the load? How fast the temperature
increases? The aggressive behavior of the cooling device will depend on
the governor which depends on the slope of the temperature increase and
the sampling.

Can you give the pointer to the git tree with the DT definition of your
board?

You can try by changing the idle duration to 10ms instead of the default
4ms.

You can also change the cooling states in the DT <&state 20 70>, so it
will begin to mitigate at state 20. But I wouldn't recommend that.

Do you have the energy power model, so we can try with the IPA governor?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

