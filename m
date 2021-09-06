Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DB401EA7
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbhIFQrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbhIFQov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 12:44:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3FC061575
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 09:43:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m26so6011292pff.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpCBeF0p4omYE2D9GwBpGanZ1k+kf8G9nWZ3OfHPsNM=;
        b=RpsV7BN0PHzqNOwJTNcmMJ05qcNTbYA55cmj8TJCR+tzJWV4pg4s2AXrjcw8S0NHP9
         s4dmHp34qA5FIudzQUA4OiM34SwPny1EfrGnWGOll5tMP2QWLOHXVyDx/x7I9fA0ZgZm
         Un66Fx7Ab/1Y/XO+e85l+n6sh+WAmZjEWolKJBw9CSiEd35ZGdknsA6937zCjBTDmofv
         4HwnzBqeaOivVabm7aRy5R6nlsW6OWg76Ia5LMT+NkZ2yfP/Ur0ZlypjCD5u1NpJAusO
         cGQJL+ClZ6SqoQR7SMFtOCW4TwoQAfHvT+e40MeXFitmfG9fWBE+bhK4UPf9aIxKjdhl
         MpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpCBeF0p4omYE2D9GwBpGanZ1k+kf8G9nWZ3OfHPsNM=;
        b=k5T5mxYg6cKbB+svGLXwKTds+I6hOOe3TChFFgp/Ial2tzlmJEaFA4xH+4HgxPBZ1x
         qWJWpcPBuHvziRG6iTGuPhZICBKoMzV/CeJqIkdSa62Ju8fiz6aILancpiGehLLdN3lz
         TO76DLSxDYywES53UiCwmRUcAxRdEX0uyCHK0u6qoJgS2y3mphsNcmSxIAfEKBlitlkO
         9IKAlrVl+hBibQLAl3lYy/eJRbRV8BxdPtAVrcV1+sOIy3OWlylM/me7NaB1VPtwszgR
         1d8mYeY7bRq78CRAdP7kYhXXPd1IR1X68VTYHvF6Wpb7YUCU+5dTKczC+eQABZQQavk7
         wEpQ==
X-Gm-Message-State: AOAM532zhpiFQmV/oUsc6RaL/Nj3HlJABOXg9F7y0eCLqqMlVTHUuzXB
        hPLSGe1kKsVIsXWC6tfCAXKd8g==
X-Google-Smtp-Source: ABdhPJxw8UPaJ5wwZygZo9edzEuiLbWk9adGqsksRle6zSSYcHmbY0+7F+xDpEiVbrsLH7rq+NMVpA==
X-Received: by 2002:a63:d456:: with SMTP id i22mr12918638pgj.421.1630946626437;
        Mon, 06 Sep 2021 09:43:46 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b4sm7776822pga.69.2021.09.06.09.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:43:45 -0700 (PDT)
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before
 driver is ready
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <926ac4b9-1bb5-e96e-ded3-6461f7a215b7@kernel.dk>
Date:   Mon, 6 Sep 2021 10:43:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hQp8Hxf__tL22s0oOcTym5mx9tND34ijufTDE3_NSW6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/6/21 10:17 AM, Rafael J. Wysocki wrote:
> On Sat, Sep 4, 2021 at 7:37 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>>
>> In Lenovo X1 gen9 laptop, HWP interrupts arrive before driver is ready
>> to handle on that CPU. Basically didn't even allocated memory for per
>> cpu data structure and not even started interrupt enable process on that
>> CPU. So interrupt handler observes a NULL pointer to schedule work.
>>
>> This interrupt was probably for SMM, but since it is redirected to
>> OS by OSC call, OS receives it, but not ready to handle. That redirection
>> of interrupt to OS was also done to solve one SMM crash on Yoga 260 for
>> HWP interrupt a while back.
>>
>> To solve this the HWP interrupt handler should ignore such request if the
>> driver is not ready. This will require some flag to wait till the driver
>> setup a workqueue to handle on a CPU. We can't simply assume cpudata to
>> be NULL and avoid processing as it may not be NULL but data structure is
>> not in consistent state.
>>
>> So created a cpumask which sets the CPU on which interrupt was setup. If
>> not setup, simply clear the interrupt status and return. Since the
>> similar issue can happen during S3 resume, clear the bit during offline.
>>
>> Since interrupt timing may be before HWP is enabled, use safe MSR read
>> writes as before the change for HWP interrupt.
>>
>> Fixes: d0e936adbd22 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
>> Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index b4ffe6c8a0d0..5ac86bfa1080 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -298,6 +298,8 @@ static bool hwp_boost __read_mostly;
>>
>>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>>
>> +static cpumask_t hwp_intr_enable_mask;
>> +
>>  #ifdef CONFIG_ACPI
>>  static bool acpi_ppc;
>>  #endif
>> @@ -1067,11 +1069,15 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>>         wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>>  }
>>
>> +static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata);
>> +
>>  static void intel_pstate_hwp_offline(struct cpudata *cpu)
>>  {
>>         u64 value = READ_ONCE(cpu->hwp_req_cached);
>>         int min_perf;
>>
>> +       intel_pstate_disable_hwp_interrupt(cpu);
>> +
>>         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>>                 /*
>>                  * In case the EPP has been set to "performance" by the
>> @@ -1645,20 +1651,35 @@ void notify_hwp_interrupt(void)
>>         if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
>>                 return;
>>
>> -       rdmsrl(MSR_HWP_STATUS, value);
>> +       rdmsrl_safe(MSR_HWP_STATUS, &value);
>>         if (!(value & 0x01))
>>                 return;
>>
>> +       if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask)) {
>> +               wrmsrl_safe(MSR_HWP_STATUS, 0);
>> +               return;
>> +       }
> 
> Without additional locking, there is a race between this and
> intel_pstate_disable_hwp_interrupt().
> 
> 1. notify_hwp_interrupt() checks hwp_intr_enable_mask() and the target
> CPU is in there, so it will go for scheduling the delayed work.
> 2. intel_pstate_disable_hwp_interrupt() runs between the check and the
> cpudata load below.
> 3. hwp_notify_work is scheduled on the CPU that isn't there in the
> mask any more.

I noticed that too, not clear to me how much of an issue that is in
practice. But there's definitely a race there.

Can we just revert d0e936adbd22 for now so this can get solved in due
time? I doubt I'm the only one that got bit by this, but I might be the
only one that bothered to actually figured out what caused my laptop to
crash with a black screen on boot.

-- 
Jens Axboe

