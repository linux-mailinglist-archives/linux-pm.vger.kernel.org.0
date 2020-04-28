Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F333F1BBB1D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 12:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgD1KUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgD1KUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 06:20:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E5C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 03:20:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so24014088wrx.4
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYJe0BhL7NE4twx7OLfVu5R7br1zitu9lE8D/yNSBMc=;
        b=HOxWrrDdBpYQvTPKmRqtcmGWZLsC/P2x9OPfZrHtkSHaShOypb2NYV+PiCa7ztFo6u
         uiAoWkmYIGrq+THt9h6HjQK7p9q5Uk6CXeEbTj40vCFEUOtR4wMW05zGyKazDCi0qAl/
         aJE9Z+OnE1QrYJCxneAlWARf/c1JzqnMIc54W5spNExSd5XScELJb67SPeD96TXafNcf
         jMVS2iWUPjCaBxhKPb1W3rNHiT/yzXfjDG1xlE5xJ6j40vXgYQoKgfv0eRfSRXrmFh7z
         lEM0En+x6RdeYU8oGNiorHLMmGt0OOG3Begdo48DMubEM/w7htKsJDMuoKgWacLFR9WD
         vVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYJe0BhL7NE4twx7OLfVu5R7br1zitu9lE8D/yNSBMc=;
        b=ZasvLvFDeOm2f50kQ/xXcVA9OcI8Ok1ogulk655GuovIMnT6yPsyM5R9qc/5C41IzR
         w+jsOgQyQw5psrp0DGuCU8atgqOfFure784pYHmzio0zk4llIq3hM/BwkwPnTDBlvqt/
         ccyQARtuMRJuD37YiVVTa2xiij8SwlVttSIwPHDRaeYp7OJTGFGDjHIfsB51Ia+wabH6
         At8sajQXj9aoAp+DIKB6LQ+2snZ615/h8OI2NzIXvS1MDVaCSjYYSpc+n1AjoAWdes6E
         Ob9gdlQyCJbj4+KExU6rSAHz02vVfihs4+s3BgC2IwTrFE6ozZuaFYD2TQ2A1h4PhoXz
         T02g==
X-Gm-Message-State: AGi0PubZLwYQ74dcGUbwMeEfhCP9HQcGFr1xFnoRLjjWfW+mAEirDLbQ
        T2DMDfhxk5dUU/UcEyTgzpst1A==
X-Google-Smtp-Source: APiQypLzIiay8HDApt/HUUbFcV5EDVe2w8en2f7jxCwcXTM96FMH9GpVkXd0DVEvau92v6eylMvd7A==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr32581024wrr.68.1588069252674;
        Tue, 28 Apr 2020 03:20:52 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id 74sm25928016wrk.30.2020.04.28.03.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:20:52 -0700 (PDT)
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
 <0aff94ac-22da-4dd7-e062-fd1fc86e1652@linaro.org>
 <CANO_MSKvvGgDsCEZFMrAazCQw+kjOhGMGshLUNX8eF3xfb11sA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0272d497-a207-6695-cb1b-cbbbccc5f4b7@linaro.org>
Date:   Tue, 28 Apr 2020 12:20:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANO_MSKvvGgDsCEZFMrAazCQw+kjOhGMGshLUNX8eF3xfb11sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/04/2020 12:01, gao yunxiao wrote:
> Yes，thank you for your introduction
> 
> another question trouble to you.
> I'm worried that the idle cycle is set too long, there may be a
> jamming phenomenon for the mobile phone, so I am not sure how to
> determine the idle cycle?

That will depend on the speed transition of the available idle states.
The DT gives the binding for the idle duration and the exit latency.

The optional exit latency constraint will prevent to choose deep idle
states (but which have better cooling effect).

So choosing the right constraint and the idle duration (which should be
at least greater than target residency of the idle state) is a question
of experimentation.

Concerning the jamming effect, if the phone is failing to cool down with
cpufreq and has to use the idle injection in addition, clearly there is
a problem with the heat dissipation and the latency introduced is not
the biggest problem in this situation.

If you think hotplugging the CPU is better, you still have the
possibility to rely on the hot trip point notification (not sure it
works) to unplug from userspace the CPU [1].

  -- Daniel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/thermal_core.c#n290


> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Hi,
>>
>> On 28/04/2020 08:51, gao yunxiao wrote:
>>> Daniel
>>>
>>> Thank you for your suggestion
>>>
>>> Yes， the platform can support voltage scaling.
>>
>> Given your issue, I would double check if the voltage scaling is really
>> effective.
>>
>>> I will porting cpuidle cooling and double check it on our platform.
>>>
>>> By the way, I have a question trouble to you
>>> when one cpu is forced into the cpuidle, the running task on it are
>>> stopped or migrated other cpu?
>>
>> The task is scheduled out by the idle injection which has a real time
>> priority. When this one finishes the idle cycle, it schedules itself and
>> the previous task continue its work. So the short answer is the task is
>> stopped, the idle injection happens, then the task runs again.
>>
>> Concerning the migration, that is a scheduler thing and will depend on
>> the thermal configuration and sensors layout.
>>
>> Let's assume the platform is 4 x cores (one cluster).
>>
>> 1. The platform has one sensor per core and the configuration sets one
>> thermal zone with one idle cooling device per core
>>
>> In this case, the mitigation will insert idle cycles, those will be seen
>> as chunk of system load cycle and will enter in the CPU load
>> computation. Thus, when there is an imbalance, the scheduler can migrate
>> the task to an idle CPU (or less busy CPU).
>>
>> 2. The platform has one sensor per cluster and the configuration sets
>> one thermal zone with *four* idle cooling devices (one per core)
>>
>> When the mitigation happens, the idle injection will be on all the cores
>> at the same time, thus the load will increase on all the CPUs and won't
>>  enter in the balance computation (well actually it will enter but as
>> they are the same on all the CPUs, the difference is zero).
>>
>>
>> In practical, we found the configuration #2, and in order to reach the
>> temperature limit, all the cores are fully busy, so task migration
>> depends on what the tasks do and the idle injection has few impact on this.
>>
>> Does it answer your question ?
>>
>>
>>> On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>> On 22/04/2020 13:11, gao yunxiao wrote:
>>>>> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>>>>>> viresh
>>>>>>
>>>>>> On UNISOC platform, CPU's temperature can not be controlled when
>>>>>> cpufreq has been limited to the lowest frequency, we have to hotplug
>>>>>> out CPUS to mitigate temperature rising.
>>>>>>
>>>>>> adding platform callback to have a chance to check whether the
>>>>>> normalised power at power2state() is lower than the power
>>>>>> corresponding to the lowest frequency. provide an example in another
>>>>>> patch
>>>>
>>>> You can use in addition the cpuidle cooling device if the cpufreq
>>>> cooling device fails.
>>>>
>>>> Add two trip points. The first one mitigated by the cpufreq cooling
>>>> device and the second one, with a higher temperature, mitigated by the
>>>> cpuidle cooling device [1][2].
>>>>
>>>> For my personal information, does the platform support voltage scaling?
>>>>
>>>>
>>>> [1]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/thermal/cpu-idle-cooling.rst
>>>>
>>>> [2] https://lkml.org/lkml/2020/4/14/1442
>>>>
>>>>
>>>>
>>>> --
>>>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>
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
