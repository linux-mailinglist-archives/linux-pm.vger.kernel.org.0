Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3781C1BBA8D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgD1KBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727797AbgD1KBi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 06:01:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA360C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 03:01:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so10463140pfa.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z0314RtwNU4W6k28nPF8ZQy51eoTQkO6Cb/FjJfoFmk=;
        b=SuZ35Uv45ujj0PxM5+nP3EtSEyw4WD2vVRHuKg364BaG7YNRlBFGZItDouORTwEF9s
         DrBBtAwzW9jDy7D/lRm1yz2UnKMiCNcT0dHkPDqIPk0GSKJiMg2KndGuHaJNsw8OUM6X
         aEvDYbtFO8hgqdWDW5nPZ/egSXfOs5x0JFlvOWGBY1pBSm6raKunCemRDU3quXNvxAy5
         AoPrbNFqB4nQne0kR+X6WJh1N5WdqPr8usfhzKYH0DV3HGZgMhN/lTVydOFq9HGHX4yo
         SqK/ppBOqvP5WM2WHnzohf12lNjW0LneIqXAHh6sDs0bnrE+bUlGV9x9mVqjZ6pyB8kg
         lFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z0314RtwNU4W6k28nPF8ZQy51eoTQkO6Cb/FjJfoFmk=;
        b=oQfNQOp6g+NcFHchjoL1To7jOqJwqWaxtgtyEx3ndjFz10pY9zDF8qz8oih0MQAMDC
         lWEpyHtXgUIRSqO442E5cFWtjkem2RTAZm7KWlfC/lFQ/To2GVp7Ys43hcVlh0x0hc3W
         Awue5mtiRDN+hzWIpPDtuPR6skISQt0tKxYpqin2IAuLXd6KK3IR1q8K+EFzv/XKWGts
         bWCp4o0jzmhseqJaLKwrprqhhmyrINnEXR2QCwXxNK3oFoF1prnBJr8q+u6hKmILZJ4r
         NWbDEq0aPHLhrBj1/llxJ/m1Wnut25Y/wMqct2Zt7nrv6ip8qzFSeRUYYi3FnBUq0e4w
         68Sw==
X-Gm-Message-State: AGi0PubJEqwAQDQsJqFo+IhpdIT82PCco9YBX8mwra73d/n65e0BinlJ
        MCIp/s1ssAqYIEamrAbA8Z1q0FFNJ7Do7EL/Fa4=
X-Google-Smtp-Source: APiQypKjIkAzMdGr6qrRAjh51/h69jqX+EqliKAEoLWMUaC/UjHILZ/mSDDx5oVGb1W5HkDPKClxUZFgXULAAkcP/Fk=
X-Received: by 2002:a62:144b:: with SMTP id 72mr29566338pfu.246.1588068098452;
 Tue, 28 Apr 2020 03:01:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2129:0:0:0:0 with HTTP; Tue, 28 Apr 2020 03:01:37
 -0700 (PDT)
In-Reply-To: <0aff94ac-22da-4dd7-e062-fd1fc86e1652@linaro.org>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7> <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7> <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
 <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
 <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org> <CANO_MS+pqKvkSgMuO0W615UE4tzfK__hB92HazJHLNQgN=mM9Q@mail.gmail.com>
 <0aff94ac-22da-4dd7-e062-fd1fc86e1652@linaro.org>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Tue, 28 Apr 2020 18:01:37 +0800
Message-ID: <CANO_MSKvvGgDsCEZFMrAazCQw+kjOhGMGshLUNX8eF3xfb11sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Yes=EF=BC=8Cthank you for your introduction

another question trouble to you.
I'm worried that the idle cycle is set too long, there may be a
jamming phenomenon for the mobile phone, so I am not sure how to
determine the idle cycle?

On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Hi,
>
> On 28/04/2020 08:51, gao yunxiao wrote:
>> Daniel
>>
>> Thank you for your suggestion
>>
>> Yes=EF=BC=8C the platform can support voltage scaling.
>
> Given your issue, I would double check if the voltage scaling is really
> effective.
>
>> I will porting cpuidle cooling and double check it on our platform.
>>
>> By the way, I have a question trouble to you
>> when one cpu is forced into the cpuidle, the running task on it are
>> stopped or migrated other cpu?
>
> The task is scheduled out by the idle injection which has a real time
> priority. When this one finishes the idle cycle, it schedules itself and
> the previous task continue its work. So the short answer is the task is
> stopped, the idle injection happens, then the task runs again.
>
> Concerning the migration, that is a scheduler thing and will depend on
> the thermal configuration and sensors layout.
>
> Let's assume the platform is 4 x cores (one cluster).
>
> 1. The platform has one sensor per core and the configuration sets one
> thermal zone with one idle cooling device per core
>
> In this case, the mitigation will insert idle cycles, those will be seen
> as chunk of system load cycle and will enter in the CPU load
> computation. Thus, when there is an imbalance, the scheduler can migrate
> the task to an idle CPU (or less busy CPU).
>
> 2. The platform has one sensor per cluster and the configuration sets
> one thermal zone with *four* idle cooling devices (one per core)
>
> When the mitigation happens, the idle injection will be on all the cores
> at the same time, thus the load will increase on all the CPUs and won't
>  enter in the balance computation (well actually it will enter but as
> they are the same on all the CPUs, the difference is zero).
>
>
> In practical, we found the configuration #2, and in order to reach the
> temperature limit, all the cores are fully busy, so task migration
> depends on what the tasks do and the idle injection has few impact on thi=
s.
>
> Does it answer your question ?
>
>
>> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>> On 22/04/2020 13:11, gao yunxiao wrote:
>>>> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>>>>> viresh
>>>>>
>>>>> On UNISOC platform, CPU's temperature can not be controlled when
>>>>> cpufreq has been limited to the lowest frequency, we have to hotplug
>>>>> out CPUS to mitigate temperature rising.
>>>>>
>>>>> adding platform callback to have a chance to check whether the
>>>>> normalised power at power2state() is lower than the power
>>>>> corresponding to the lowest frequency. provide an example in another
>>>>> patch
>>>
>>> You can use in addition the cpuidle cooling device if the cpufreq
>>> cooling device fails.
>>>
>>> Add two trip points. The first one mitigated by the cpufreq cooling
>>> device and the second one, with a higher temperature, mitigated by the
>>> cpuidle cooling device [1][2].
>>>
>>> For my personal information, does the platform support voltage scaling?
>>>
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/driver-api/thermal/cpu-idle-cooling.rst
>>>
>>> [2] https://lkml.org/lkml/2020/4/14/1442
>>>
>>>
>>>
>>> --
>>> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
>>>
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog
>>>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
