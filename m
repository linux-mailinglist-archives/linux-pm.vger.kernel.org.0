Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9C1BB825
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD1Hx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 03:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgD1Hx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 03:53:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F797C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 00:53:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so23463036wrt.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ye9mPupXOBo5771aKhY4K0P7hrnYE21PKgWVD0AT1U=;
        b=X1DSBj9lq4z/ayFYJRPgr28+/dYgTT+W5JD41H2nGFo2xeXZI3lMSu2J6aKhnTXcIQ
         Vymvo1yACvqoYubSqupqWuZcRaI3/YjPZKlFzyyRGLkXBDTbXlRsPMjd9zwE8Zd1DCBg
         HFWj3GnjE72h8p90mXJf+/Nf7hvCwrl3QP8fhtnv9HuOh1u4v29E8QiRpaHQg4GyI2T6
         QDl/LJfBWfYQ7VkQS3b+S6V98PFivryfvqHlgs5PhsqoAIGhZRFe3+oqn6XzEzIYEeVZ
         R7hKpMUmicyf2pF60qdR2ygOKSfmWrmryLo0YGxWSBMcg9imN+bgOBcy9ir+9WLbIh7t
         I7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ye9mPupXOBo5771aKhY4K0P7hrnYE21PKgWVD0AT1U=;
        b=X8t+zQOiGkmTSbV3zVSTl3xO/Qzg+nlM7xBr154L4GdEXBvdgOZpRnMErhELy4xTMg
         rH2tcuqmMs/WwwqdoDjot1dW4QXXyr8qXdR40pV1UtFJZrbSRqxQJJ3/fPpqhJp2r4gf
         o9WSO4IRIAIRv+IGbMkLZ1Wx/FMha8EgDY4eAyoyXvr1IxWatbwyk5gzLulThwlUf/E/
         CrF8zl9HzPfrW5bskY5isBQlUghrot6sLrO+T+MVwutMJZT7mFFD/eEzTl0Vcy/gRph/
         YHUE0ATIr6tfz4mGXoegP5Nag9ac5fQDUkn2DqQ2ps9NJbpdafR38L/K7hMiPLwIAD3M
         guQg==
X-Gm-Message-State: AGi0PuaXsDsJwZleQkDSHe0jubJcglkjcuN8sAx6Ka4569G9Kkz2gK4Z
        ztPmDAnQbPDfpZqgjHB9CsyC3JLctz8=
X-Google-Smtp-Source: APiQypK+IybvcLD5ezkiOZd50nHdWPzDpEZ5mEMRWK+B0Pfz8HDFpZ5nnoi6WEpLpwY7DDjOTWM+nA==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr31582903wrv.314.1588060405620;
        Tue, 28 Apr 2020 00:53:25 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id a1sm24559012wrn.80.2020.04.28.00.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 00:53:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     gao yunxiao <gao.yunxiao6@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
 <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7>
 <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
 <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
 <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org>
 <CANO_MS+pqKvkSgMuO0W615UE4tzfK__hB92HazJHLNQgN=mM9Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0aff94ac-22da-4dd7-e062-fd1fc86e1652@linaro.org>
Date:   Tue, 28 Apr 2020 09:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANO_MS+pqKvkSgMuO0W615UE4tzfK__hB92HazJHLNQgN=mM9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 28/04/2020 08:51, gao yunxiao wrote:
> Daniel
> 
> Thank you for your suggestion
> 
> Yes， the platform can support voltage scaling.

Given your issue, I would double check if the voltage scaling is really
effective.

> I will porting cpuidle cooling and double check it on our platform.
> 
> By the way, I have a question trouble to you
> when one cpu is forced into the cpuidle, the running task on it are
> stopped or migrated other cpu?

The task is scheduled out by the idle injection which has a real time
priority. When this one finishes the idle cycle, it schedules itself and
the previous task continue its work. So the short answer is the task is
stopped, the idle injection happens, then the task runs again.

Concerning the migration, that is a scheduler thing and will depend on
the thermal configuration and sensors layout.

Let's assume the platform is 4 x cores (one cluster).

1. The platform has one sensor per core and the configuration sets one
thermal zone with one idle cooling device per core

In this case, the mitigation will insert idle cycles, those will be seen
as chunk of system load cycle and will enter in the CPU load
computation. Thus, when there is an imbalance, the scheduler can migrate
the task to an idle CPU (or less busy CPU).

2. The platform has one sensor per cluster and the configuration sets
one thermal zone with *four* idle cooling devices (one per core)

When the mitigation happens, the idle injection will be on all the cores
at the same time, thus the load will increase on all the CPUs and won't
 enter in the balance computation (well actually it will enter but as
they are the same on all the CPUs, the difference is zero).


In practical, we found the configuration #2, and in order to reach the
temperature limit, all the cores are fully busy, so task migration
depends on what the tasks do and the idle injection has few impact on this.

Does it answer your question ?


> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 22/04/2020 13:11, gao yunxiao wrote:
>>> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>>>> viresh
>>>>
>>>> On UNISOC platform, CPU's temperature can not be controlled when
>>>> cpufreq has been limited to the lowest frequency, we have to hotplug
>>>> out CPUS to mitigate temperature rising.
>>>>
>>>> adding platform callback to have a chance to check whether the
>>>> normalised power at power2state() is lower than the power
>>>> corresponding to the lowest frequency. provide an example in another
>>>> patch
>>
>> You can use in addition the cpuidle cooling device if the cpufreq
>> cooling device fails.
>>
>> Add two trip points. The first one mitigated by the cpufreq cooling
>> device and the second one, with a higher temperature, mitigated by the
>> cpuidle cooling device [1][2].
>>
>> For my personal information, does the platform support voltage scaling?
>>
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/thermal/cpu-idle-cooling.rst
>>
>> [2] https://lkml.org/lkml/2020/4/14/1442
>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
