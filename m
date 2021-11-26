Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67FF45ED2E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377171AbhKZMA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 07:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKZL6Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 06:58:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A44EC08EA4C
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 03:22:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so17953740wrb.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 03:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CH/BjpiBpZ/vu5u2YjAKcdVgEIZZP8RkoskTORrwc7k=;
        b=W901Nj+xtSh1aiNfDE0AMKIOsC0ArWr80z7PJf34QwtvFBSITUMZJSslyGMx8aPwXY
         HQfI4jtvf0PCFqM897iRWJdpPQ4XWSloTbGLYMFzxUZ1vcTn+L80wzKw8BdLfc9LiV2u
         ewffAgUhVp48ltm6XiHTIVmMc8d95+6AmyqXpms7XlCf84xW7mXJD73hqyq8UNT4mNj7
         uURucMcPRvMlkXf0FdFQMUzDogO2xGYu4s1rxMYMwUJTwJpTiRMkFs05fq0WULaP7Bx8
         xRppUITefkkT5MNMHS60YpOb/6vEI3s1VHGY7meb8dAbqBvHy0YJsuxTad9hr1B6ULlc
         rZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CH/BjpiBpZ/vu5u2YjAKcdVgEIZZP8RkoskTORrwc7k=;
        b=AT9ueBGCfWXQg5nhLHFDKOJyYH1Ur9tAzaLIRJSPQcMZQIwB6TDfE3/eHEfl4A88ae
         GdebqCmCMa49n7gkxI9H6QWsuNe2LCnBxoT6ALNhvptR2adZn3ddhurRZtN97yf4Wz9k
         OpF0xAkFQH2UA9hKX5jKbVP36AdxiwdX5cStiMxYDtZVRBNYg5+0TVEYBoCqcI7x3zPx
         K7xn3NHQ0yHOYuVhBAH0ZZLLFSAx38MI4cenu/57o9syP8RQS2IhOcJf5sem29pBhO5r
         L1qf3hn5Oo0aTa8UcyIVYSxdemSe7gUrvoPQhBOg+UmJDmq0jLXGJXk7hPzyF4lA4YpW
         aoWg==
X-Gm-Message-State: AOAM530N+LMUFdlgiurfmEV1Zc/wRks3vyXnh5qyCQhgAvtDnur26qPF
        1CV6nYe3qQDlvB3Mr+UhyXVECA==
X-Google-Smtp-Source: ABdhPJybvJVDj9O9DJ2NwSgzjlWPPDKmXV88NtvDPWzA4oqWQr33oPSWf1DuSfpq0COI7AIp00Woiw==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr12839437wrm.402.1637925742716;
        Fri, 26 Nov 2021 03:22:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:47ed:5339:c53f:6a8? ([2a01:e34:ed2f:f020:47ed:5339:c53f:6a8])
        by smtp.googlemail.com with ESMTPSA id l11sm5101510wrp.61.2021.11.26.03.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 03:22:21 -0800 (PST)
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
To:     Maulik Shah <quic_mkshah@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, quic_lsrao@quicinc.com,
        rnayak@codeaurora.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
 <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
 <687d97b6-347a-92c0-34ba-00331dfb6c82@quicinc.com>
 <0fb74083-e378-e1b4-624b-4f2076f237df@linaro.org>
 <4427fe8d-c96d-d1f7-3ef2-674000b61b93@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <444f74f7-43cc-fc48-7417-ccbcf8e176c8@linaro.org>
Date:   Fri, 26 Nov 2021 12:22:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4427fe8d-c96d-d1f7-3ef2-674000b61b93@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2021 06:56, Maulik Shah wrote:
> Hi Daniel,
> 
> On 11/25/2021 10:56 PM, Daniel Lezcano wrote:
>> On 25/11/2021 15:13, Maulik Shah wrote:
>>> Hi Peter,
>>>
>>> On 11/25/2021 3:21 PM, Peter Zijlstra wrote:
>>>> On Thu, Nov 25, 2021 at 02:44:36PM +0530, Maulik Shah wrote:
>>>>> Export cpu_idle_poll_ctrl() so that module drivers can use same.
>>>> This does not seem like a really safe interface to expose to the
>>>> world.
>>> Thanks for the review.
>>>
>>> Keeping the cpuidle enabled from boot up may delay/increase the boot up
>>> time.
>>> Below is our use case to force cpuidle to stay in cpu_idle_poll().
>>>
>>> We keep cpuidle disabled from boot up using "nohlt" option of kernel
>>> command line which internally sets cpu_idle_force_poll = 1;
>>> and once the device bootup reaches till certain point (for example the
>>> android homescreen is up) userspace may notify a
>>> vendor module driver which can invoke cpu_idle_poll_ctrl(false); to come
>>> out of poll mode.
>>> So vendor module driver needs cpu_idle_poll_ctrl() exported symbol.
>>>
>>> We can not take PM-QoS from driver to prevent deep cpuidle since all the
>>> vendor modules are kept in a separate partition and will be loaded only
>>> after kernel boot up is done
>>> and by this time kernel already starts executing deep cpuidle modes.
>>>> Surely the better solution is to rework things to not rely on this. I'm
>>>> fairly sure it's not hard to write a cpuidle driver that does much the
>>>> same.
>>> The other option i think is to pass cpuidle.off=1 in kernel command line
>>> and then add enable_cpuidle() in drivers/cpuidle/cpuidle.c
>>> something similar as below which can be called by vendor module.
>>>
>>> void enable_cpuidle(void)
>>> {
>>>          off = 0;
>>> }
>>> EXPORT_SYMBOL_GPL(enable_cpuidle);
>>>
>>> This may be a good option since we have already disable_cpuidle() but
>>> not enable_cpuidle().
>>>
>>> void disable_cpuidle(void)
>>> {
>>>          off = 1;
>>> }
>>>
>>> Hi Rafael/Daniel, can you please let me know your suggestion on
>>> this/similar implementation?
>> Did you try to use the QoS latency? Sounds like it is exactly for this
>> purpose.
>>
>> Set it to zero to force cpuidle to choose the shallowest idle state and
>> then INT_MAX to disable the constraint.
>>
>>   cpu_latency_qos_add_request();
>>
>> Hope that helps
>>
>>    -- Daniel
> The PM-QoS is not helping here since all the vendor drivers are kept in
> a separate partition
> and will be loaded only after kernel boot up is done and by the time
> vendor kernel modules are inserted
> takes QoS, kernel/menu governor already starts executing deep cpuidle
> modes.
> 
> kernel start (t0)---------Menu governor loads (t1)----------vendor
> modules loaded (t2)----------Usespace ready(t3)
> 
> Untill (t2), its only core kernel/android kernel which don't have any
> vendor driver which can take QoS.
> If we take QoS, it can be taken only from point (t2) but CPUs still
> enter deep idle state between (t1) to (t2).
> 
> So to prevent this passing "cpuidle.off=1" or "nohlt" in kernel command
> line can keep deep cpuidle states disabled from boot up and
> once vendor modules are ready at (t2) or (t3), it can either invoke
> newly added enable_cpuidle() or cpu_idle_poll_ctrl(false);
> to comeout of polling mode and start executing deep low power modes.

I understand. The approach is valid but I'm wondering if it should fall
under a more global feature with a perf <-> power cursor

If the goal is to be as fast as possible at boot time, the cursor should
be set to 'perf and then changed to 'power' after the system has booted.

So not only cpuidle but also any other subsystems can skip the PM path
or go the highest performance state (assuming the PM code is compiled-in
for the devices).




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
