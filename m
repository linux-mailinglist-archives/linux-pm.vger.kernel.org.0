Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA71BBBD2
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD1LD2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgD1LD1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 07:03:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D5C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 04:03:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l20so2218308pgb.11
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u6NUV4QFcmdAUkWHWR4oRPbBUyOZ9tdu9YsJYci8TXw=;
        b=vX3ssBxeYBNQSdgaU7xX8FMGCijpLf5QtXUFMQze4XjLZvrWBdotaiFkLk2UK2UMpB
         J0CfOKlrMmzZ/VMDMsc8J7P3qHUISQNvfrY7Bv9rgIjuVbnDusQ3gsXNwQUJJQ17J/87
         BHXulBJ+uZTj0Hk2tUs7k5jtq0Z0t6FbfWKFUTfMZaIAM40UjzMekEoXYg3dk1jMUvsN
         OwGLoKJj9v/ijDCHj/3uE3kubT0827LKTYxlOceSzqEb6jxvE+oniIyhAKi2MFk2TxP4
         Zb3I+bUI7KZlW0MT9+fwgSf8w2l7bjsKhAiyVXpMasYubCTIkvgKxjZf9kOx4bKd8qpL
         r1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u6NUV4QFcmdAUkWHWR4oRPbBUyOZ9tdu9YsJYci8TXw=;
        b=ZIYv4WHV5TMm4Gacwc1T710OrD4sM3cNrP+2ya//3gNjFjWpP2Qda1v6/tLcUikyyS
         jmPz6zfyKzvBAcySbTeeP+cOZtNMoXm89Mham9UuHVApiUz4q6g3tiusn/ulaj6rn60Z
         wDmnBSNJZx+owszZAacVc5TILRpoDvk/jmVIG/EuAQznJ1Kk4e4WHdxu6klqaYaHEX/5
         N7KMvT17AAzfnZAFvcpvrB+NIwFvxIm2fANBYvGZDxA4m6kREXR5naX2HkBnVkAVoAOH
         A/pnIeY3PoIe3KkiNjvQGdCh0ORePbLucxg38H9y1crVX0B9wAkUpLbqHFDepQ3HQo1z
         l9eA==
X-Gm-Message-State: AGi0PuaA9G9Mo7Eq5yBkmUQM8/L0bhfF2lcqwe8TGC3P7oqPcbG2Ot73
        vtgE/l40WUZOojcANAAh2EA0jW2VYQAfDD77puo=
X-Google-Smtp-Source: APiQypLPdmI3LDV1I5iX0k1L+KHT4qqIBYZYxvP7Igy+9g6GrP/tGZYR2wsJmcgv5WInNo6zIcVh1gciOoHUqfbZWvY=
X-Received: by 2002:a63:f94f:: with SMTP id q15mr26990919pgk.256.1588071807015;
 Tue, 28 Apr 2020 04:03:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2129:0:0:0:0 with HTTP; Tue, 28 Apr 2020 04:03:26
 -0700 (PDT)
In-Reply-To: <0272d497-a207-6695-cb1b-cbbbccc5f4b7@linaro.org>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7> <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7> <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
 <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com>
 <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org> <CANO_MS+pqKvkSgMuO0W615UE4tzfK__hB92HazJHLNQgN=mM9Q@mail.gmail.com>
 <0aff94ac-22da-4dd7-e062-fd1fc86e1652@linaro.org> <CANO_MSKvvGgDsCEZFMrAazCQw+kjOhGMGshLUNX8eF3xfb11sA@mail.gmail.com>
 <0272d497-a207-6695-cb1b-cbbbccc5f4b7@linaro.org>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Tue, 28 Apr 2020 19:03:26 +0800
Message-ID: <CANO_MSJobds9XCHuXrW60tXH=5tND6S97=UtM2DqV--AagMTug@mail.gmail.com>
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

Daniel, thank you very much

On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 28/04/2020 12:01, gao yunxiao wrote:
>> Yes=EF=BC=8Cthank you for your introduction
>>
>> another question trouble to you.
>> I'm worried that the idle cycle is set too long, there may be a
>> jamming phenomenon for the mobile phone, so I am not sure how to
>> determine the idle cycle?
>
> That will depend on the speed transition of the available idle states.
> The DT gives the binding for the idle duration and the exit latency.
>
> The optional exit latency constraint will prevent to choose deep idle
> states (but which have better cooling effect).
>
> So choosing the right constraint and the idle duration (which should be
> at least greater than target residency of the idle state) is a question
> of experimentation.
>
> Concerning the jamming effect, if the phone is failing to cool down with
> cpufreq and has to use the idle injection in addition, clearly there is
> a problem with the heat dissipation and the latency introduced is not
> the biggest problem in this situation.
>
> If you think hotplugging the CPU is better, you still have the
> possibility to rely on the hot trip point notification (not sure it
> works) to unplug from userspace the CPU [1].
>
>   -- Daniel
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/thermal/thermal_core.c#n290
>
>
>> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> On 28/04/2020 08:51, gao yunxiao wrote:
>>>> Daniel
>>>>
>>>> Thank you for your suggestion
>>>>
>>>> Yes=EF=BC=8C the platform can support voltage scaling.
>>>
>>> Given your issue, I would double check if the voltage scaling is really
>>> effective.
>>>
>>>> I will porting cpuidle cooling and double check it on our platform.
>>>>
>>>> By the way, I have a question trouble to you
>>>> when one cpu is forced into the cpuidle, the running task on it are
>>>> stopped or migrated other cpu?
>>>
>>> The task is scheduled out by the idle injection which has a real time
>>> priority. When this one finishes the idle cycle, it schedules itself an=
d
>>> the previous task continue its work. So the short answer is the task is
>>> stopped, the idle injection happens, then the task runs again.
>>>
>>> Concerning the migration, that is a scheduler thing and will depend on
>>> the thermal configuration and sensors layout.
>>>
>>> Let's assume the platform is 4 x cores (one cluster).
>>>
>>> 1. The platform has one sensor per core and the configuration sets one
>>> thermal zone with one idle cooling device per core
>>>
>>> In this case, the mitigation will insert idle cycles, those will be see=
n
>>> as chunk of system load cycle and will enter in the CPU load
>>> computation. Thus, when there is an imbalance, the scheduler can migrat=
e
>>> the task to an idle CPU (or less busy CPU).
>>>
>>> 2. The platform has one sensor per cluster and the configuration sets
>>> one thermal zone with *four* idle cooling devices (one per core)
>>>
>>> When the mitigation happens, the idle injection will be on all the core=
s
>>> at the same time, thus the load will increase on all the CPUs and won't
>>>  enter in the balance computation (well actually it will enter but as
>>> they are the same on all the CPUs, the difference is zero).
>>>
>>>
>>> In practical, we found the configuration #2, and in order to reach the
>>> temperature limit, all the cores are fully busy, so task migration
>>> depends on what the tasks do and the idle injection has few impact on
>>> this.
>>>
>>> Does it answer your question ?
>>>
>>>
>>>> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>> On 22/04/2020 13:11, gao yunxiao wrote:
>>>>>> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>>>>>>> viresh
>>>>>>>
>>>>>>> On UNISOC platform, CPU's temperature can not be controlled when
>>>>>>> cpufreq has been limited to the lowest frequency, we have to hotplu=
g
>>>>>>> out CPUS to mitigate temperature rising.
>>>>>>>
>>>>>>> adding platform callback to have a chance to check whether the
>>>>>>> normalised power at power2state() is lower than the power
>>>>>>> corresponding to the lowest frequency. provide an example in anothe=
r
>>>>>>> patch
>>>>>
>>>>> You can use in addition the cpuidle cooling device if the cpufreq
>>>>> cooling device fails.
>>>>>
>>>>> Add two trip points. The first one mitigated by the cpufreq cooling
>>>>> device and the second one, with a higher temperature, mitigated by th=
e
>>>>> cpuidle cooling device [1][2].
>>>>>
>>>>> For my personal information, does the platform support voltage
>>>>> scaling?
>>>>>
>>>>>
>>>>> [1]
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/driver-api/thermal/cpu-idle-cooling.rst
>>>>>
>>>>> [2] https://lkml.org/lkml/2020/4/14/1442
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM
>>>>> SoCs
>>>>>
>>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>>
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
