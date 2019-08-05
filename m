Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D991E813BF
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfHEH6I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:58:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54140 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEH6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 03:58:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so73755280wmj.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tqd0bpoP//iZnBL1ULJ+B/2/MGB5z7IFUqOHk1lrMKo=;
        b=fwyq5GgrZ2K1IspWWeLOBJr4Fg+uzFcey+ANWp8BNtlAA9Va5QCdDLuDD3l9NPqaxN
         WcQZ4n6CKO/bNhaMGg6uDEQ1BY9ShNuhmtodCrBaEUK/bBvV6l9yPWOyBNSNZXE2i3Ig
         9NOocffHrMTQ3918y7XZsW4PV6vp6gwiRVaYFYBi703AfKILCr9lL2yK52AmKr8Eyp71
         aMddZ4R4d/GCg0B2ZvlJ5WOFPkT3P73HcVzP7ycLRfJgTEfIq0yyrsj+QrzEMgMNSy3s
         Vwhelnz0xQl6ZPW57daevtBExV3cBBQH7jJpKbcSOj/2alMQiq1KkqkJ9IqIDbCHOKY9
         1esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tqd0bpoP//iZnBL1ULJ+B/2/MGB5z7IFUqOHk1lrMKo=;
        b=pvXa8CvKSADcRgugQz6Q0oFR6/3JQC4zrha8VviPn5z9cSPCa0fZErRQjzaXiIM6av
         bY5w1nTY22DAKWAkuT056HUo7HfBCiUxnvJ6cHvWIeACkKyCEwulCbuIfFPO98RJh56P
         /xcm79y9xlJrRBR7bAHuU56t6v+GJDNNsO1XH61VTD6gRH8uXHFPDOD92rmtJMsDwsTL
         2XxX/FAfZchYfUtaexZ7eF4Jna6G/2EQ5dK8hkJDriPSV2eFQIHYT/H3HcCYTNlK5rav
         6jY3CSQg3RVrKlOcI/SMgDtjoKnK+v1YtIjoar83WemB4o9yaVQbfNOLgp/p6M5+1F3f
         4kuw==
X-Gm-Message-State: APjAAAW5ASmQinHRJM3s87XqIaD8/VF6ZNmbEVcXhyrCOS6DhvPfe6AM
        WYjsjJuzU0FulbBqMwl8mT+VkA==
X-Google-Smtp-Source: APXvYqxZBpBR2p2HFq/p+efcH5Wm1ABwIn4w5fvAe0T778XAYwBtuXaBr5T+GODrY1iqpp8bBsULkw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr17858708wmg.6.1564991883482;
        Mon, 05 Aug 2019 00:58:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1d1:2aa9:b538:861? ([2a01:e34:ed2f:f020:1d1:2aa9:b538:861])
        by smtp.googlemail.com with ESMTPSA id g2sm72770348wmh.0.2019.08.05.00.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 00:58:02 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        viresh.kumar@linaro.org, leo.yan@linaro.org, edubezval@gmail.com,
        vincent.guittot@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <20190805051111.24318-1-martin.kepplinger@puri.sm>
 <02ec23c3-37ee-4e9f-56a4-453a30a29747@puri.sm>
 <421c43a9-c721-05eb-1860-dfb5c042bc95@linaro.org>
 <172fc66f-a385-1d58-91f1-60224fac348b@puri.sm>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <34b1ed94-1223-60ec-ac4f-0b32be67eab2@linaro.org>
Date:   Mon, 5 Aug 2019 09:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <172fc66f-a385-1d58-91f1-60224fac348b@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/08/2019 09:42, Martin Kepplinger wrote:
> On 05.08.19 09:39, Daniel Lezcano wrote:
>> On 05/08/2019 08:53, Martin Kepplinger wrote:
>>
>> [ ... ]
>>
>>>>> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
>>>>> +{
>>>>> +	s64 next_wakeup;
>>>>> +	unsigned long state = idle_cdev->state;
>>>>> +
>>>>> +	/*
>>>>> +	 * The function should not be called when there is no
>>>>> +	 * mitigation because:
>>>>> +	 * - that does not make sense
>>>>> +	 * - we end up with a division by zero
>>>>> +	 */
>>>>> +	if (!state)
>>>>> +		return 0;
>>>>> +
>>>>> +	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
>>>>> +		idle_cdev->idle_cycle;
>>>>> +
>>>>> +	return next_wakeup * NSEC_PER_USEC;
>>>>> +}
>>>>> +
>>>>
>>>> There is a bug in your calculation formula here when "state" becomes 100.
>>>> You return 0 for the injection rate, which is the same as "rate" being 0,
>>>> which is dangerous. You stop cooling when it's most necessary :)
>>>>
>>>> I'm not sure how much sense really being 100% idle makes, so I, when testing
>>>> this, just say if (state == 100) { state = 99 }. Anyways, just don't return 0.
>>>>
>>>
>>> oh and also, this breaks S3 suspend:
>>
>> What breaks the S3 suspend? The idle cooling device or the bug above ?
> 
> The idle cooling device. I have to configure it out: remove
> CONFIG_CPU_IDLE_THERMAL to test suspend/resume again. Errors in the
> kernel log, see below.

Ok, thanks for reporting. I'll fix the issue.


>>> Aug  5 06:09:20 pureos kernel: [  807.487887] PM: suspend entry (deep)
>>> Aug  5 06:09:40 pureos kernel: [  807.501148] Filesystems sync: 0.013
>>> seconds
>>> Aug  5 06:09:40 pureos kernel: [  807.501591] Freezing user space
>>> processes ... (elapsed 0.003 seconds) done.
>>> Aug  5 06:09:40 pureos kernel: [  807.504741] OOM killer disabled.
>>> Aug  5 06:09:40 pureos kernel: [  807.504744] Freezing remaining
>>> freezable tasks ...
>>> Aug  5 06:09:40 pureos kernel: [  827.517712] Freezing of tasks failed
>>> after 20.002 seconds (4 tasks refusing to freeze, wq_busy=0):
>>> Aug  5 06:09:40 pureos kernel: [  827.527122] thermal-idle/0  S    0
>>> 161      2 0x00000028
>>> Aug  5 06:09:40 pureos kernel: [  827.527131] Call trace:
>>> Aug  5 06:09:40 pureos kernel: [  827.527148]  __switch_to+0xb4/0x200
>>> Aug  5 06:09:40 pureos kernel: [  827.527156]  __schedule+0x1e0/0x488
>>> Aug  5 06:09:40 pureos kernel: [  827.527162]  schedule+0x38/0xc8
>>> Aug  5 06:09:40 pureos kernel: [  827.527169]  smpboot_thread_fn+0x250/0x2a8
>>> Aug  5 06:09:40 pureos kernel: [  827.527176]  kthread+0xf4/0x120
>>> Aug  5 06:09:40 pureos kernel: [  827.527182]  ret_from_fork+0x10/0x18
>>> Aug  5 06:09:40 pureos kernel: [  827.527186] thermal-idle/1  S    0
>>> 162      2 0x00000028
>>> Aug  5 06:09:40 pureos kernel: [  827.527192] Call trace:
>>> Aug  5 06:09:40 pureos kernel: [  827.527197]  __switch_to+0x188/0x200
>>> Aug  5 06:09:40 pureos kernel: [  827.527203]  __schedule+0x1e0/0x488
>>> Aug  5 06:09:40 pureos kernel: [  827.527208]  schedule+0x38/0xc8
>>> Aug  5 06:09:40 pureos kernel: [  827.527213]  smpboot_thread_fn+0x250/0x2a8
>>> Aug  5 06:09:40 pureos kernel: [  827.527218]  kthread+0xf4/0x120
>>> Aug  5 06:09:40 pureos kernel: [  827.527222]  ret_from_fork+0x10/0x18
>>> Aug  5 06:09:40 pureos kernel: [  827.527226] thermal-idle/2  S    0
>>> 163      2 0x00000028
>>> Aug  5 06:09:40 pureos kernel: [  827.527231] Call trace:
>>> Aug  5 06:09:40 pureos kernel: [  827.527237]  __switch_to+0xb4/0x200
>>> Aug  5 06:09:40 pureos kernel: [  827.527242]  __schedule+0x1e0/0x488
>>> Aug  5 06:09:40 pureos kernel: [  827.527247]  schedule+0x38/0xc8
>>> Aug  5 06:09:40 pureos kernel: [  827.527259]  smpboot_thread_fn+0x250/0x2a8
>>> Aug  5 06:09:40 pureos kernel: [  827.527264]  kthread+0xf4/0x120
>>> Aug  5 06:09:40 pureos kernel: [  827.527268]  ret_from_fork+0x10/0x18
>>> Aug  5 06:09:40 pureos kernel: [  827.527272] thermal-idle/3  S    0
>>> 164      2 0x00000028
>>> Aug  5 06:09:40 pureos kernel: [  827.527278] Call trace:
>>> Aug  5 06:09:40 pureos kernel: [  827.527283]  __switch_to+0xb4/0x200
>>> Aug  5 06:09:40 pureos kernel: [  827.527288]  __schedule+0x1e0/0x488
>>> Aug  5 06:09:40 pureos kernel: [  827.527293]  schedule+0x38/0xc8
>>> Aug  5 06:09:40 pureos kernel: [  827.527298]  smpboot_thread_fn+0x250/0x2a8
>>> Aug  5 06:09:40 pureos kernel: [  827.527303]  kthread+0xf4/0x120
>>> Aug  5 06:09:40 pureos kernel: [  827.527308]  ret_from_fork+0x10/0x18
>>> Aug  5 06:09:40 pureos kernel: [  827.527375] Restarting kernel threads
>>> ... done.
>>> Aug  5 06:09:40 pureos kernel: [  827.527771] OOM killer enabled.
>>> Aug  5 06:09:40 pureos kernel: [  827.527772] Restarting tasks ... done.
>>> Aug  5 06:09:40 pureos kernel: [  827.528926] PM: suspend exit
>>>
>>>
>>> do you know where things might go wrong here?
>>>
>>> thanks,
>>>
>>>                             martin
>>>
>>
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

