Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C75F9BB7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJJJPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJJJPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 05:15:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8E4B489
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 02:15:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn8so12532653ljb.6
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3Nc5ybSmm3MUhdS+5MVyvIh/NesSmD7wvi1u6Qup6U=;
        b=WvK1AiGto8CcgCMoI4sx/iJk9ekcDIyGNkFYy2f2pDxuQOp0q5v+wcrG7IBca2IV1s
         znSltlhtNZ8+BVPfpKUSFa9tIBmTEEsUHTEfEIYn0IHVjuqjKmbxJo9OAc9ARf8hCQDi
         jwg9o/Dc8npSCgHL/x5WJNEHdipO5+9NUHk6ekjr97xicnLV4wFisvLghRIgePZgQK38
         wC/5kHf12eXMbUtv1ecfoslc8iiMRFY/KomLaMHBt4SaPrVl2YDOY0gepcmlT+HwGYTK
         eThmRHUzAxzvTlSmSEk68nq0aprAxQmgNH9qBnWrri2+LavXZZogk1NFT75YlH6N4Q+d
         vINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3Nc5ybSmm3MUhdS+5MVyvIh/NesSmD7wvi1u6Qup6U=;
        b=p4hB/3VTDdA/n5oNkp/d6vWfgxFfSX5b9DYOcwU8QNBCfeNgZwvV/Xpy1YK2Rs2MOU
         6k8oRu2jSGTFnZ9FnNBI32lpT952Z/JTS24wNGmwNoDiL0h0xfLl2cm3RNcA5RZjGglZ
         NJcuZZTsYSuRZmYOvISNeiehKVvLAMcOPjmLS6FDGS9NL30NO2NkMWsO00m5EnbStOAA
         5cROBlih/x/zmvuXQfuEugNEU7ip8IEY/+LRv1oBTbKUUc1D7VlM8cwnS6fEOqKugZ8K
         8sFJWuzxstuVBkNt/F0x+/d5oqlnfnLuYG782kN8xXRQqS220Cilzih2zSy23PdXDeR2
         iC1A==
X-Gm-Message-State: ACrzQf18KODoVbSGaWa44QJORmsNCh1yNLjfpBUr1xwW1R6rFEMSVttt
        Y55wpSr+R+LSNR9Q3r7rgftarl9bAPMMMR0dY1zsZg==
X-Google-Smtp-Source: AMsMyM7XBI1ABDkrZqxzLTRibptq5a/rT9db9D7b8Bn/dCWyKGKlV7NV/NHvtCAM8VXRGDJxyei9o4KLHB6J3JoS1k0=
X-Received: by 2002:a2e:9919:0:b0:26e:59a:3449 with SMTP id
 v25-20020a2e9919000000b0026e059a3449mr6189634lji.494.1665393319687; Mon, 10
 Oct 2022 02:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220930094821.31665-1-lukasz.luba@arm.com> <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7> <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
In-Reply-To: <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Oct 2022 11:15:07 +0200
Message-ID: <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in store_scaling_max_freq()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Oct 2022 at 11:02, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 10/10/22 06:39, Viresh Kumar wrote:
> > Would be good to always CC Scheduler maintainers for such a patch.
>
> Agree, I'll do that.
>
> >
> > On 30-09-22, 10:48, Lukasz Luba wrote:
> >> When the new max frequency value is stored, the task scheduler must
> >> know about it. The scheduler uses the CPUs capacity information in the
> >> task placement. Use the existing mechanism which provides information
> >> about reduced CPU capacity to the scheduler due to thermal capping.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
> >>   1 file changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 1f8b93f42c76..205d9ea9c023 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -27,6 +27,7 @@
> >>   #include <linux/slab.h>
> >>   #include <linux/suspend.h>
> >>   #include <linux/syscore_ops.h>
> >> +#include <linux/thermal.h>
> >>   #include <linux/tick.h>
> >>   #include <linux/units.h>
> >>   #include <trace/events/power.h>
> >> @@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> >>   static ssize_t store_scaling_max_freq
> >>   (struct cpufreq_policy *policy, const char *buf, size_t count)
> >>   {
> >> +    unsigned int frequency;
> >> +    struct cpumask *cpus;
> >>      unsigned long val;
> >>      int ret;
> >>
> >> @@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
> >>              return -EINVAL;
> >>
> >>      ret = freq_qos_update_request(policy->max_freq_req, val);
> >> -    return ret >= 0 ? count : ret;
> >> +    if (ret >= 0) {
> >> +            /*
> >> +             * Make sure that the task scheduler sees these CPUs
> >> +             * capacity reduction. Use the thermal pressure mechanism
> >> +             * to propagate this information to the scheduler.
> >> +             */
> >> +            cpus = policy->related_cpus;
> >
> > No need of this, just use related_cpus directly.
> >
> >> +            frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
> >> +            arch_update_thermal_pressure(cpus, frequency);
> >
> > I wonder if using the thermal-pressure API here is the right thing to
> > do. It is a change coming from User, which may or may not be
> > thermal-related.
>
> Yes, I thought the same. Thermal-pressure name might be not the
> best for covering this use case. I have been thinking about this
> thermal pressure mechanism for a while, since there are other
> use cases like PowerCap DTPM which also reduces CPU capacity
> because of power policy from user-space. We don't notify
> the scheduler about it. There might be also an issue with virtual
> guest OS and how that kernel 'sees' the capacity of CPUs.
> We might try to use this 'thermal-pressure' in the guest kernel
> to notify about available CPU capacity (just a proposal, not
> even an RFC, since we are missing requirements, but issues where
> discussed on LPC 2022 on ChromeOS+Android_guest)

The User space setting scaling_max_freq is a long scale event and it
should be considered as a new running environnement instead of a
transient event. I would suggest updating the EM is and capacity orig
of the system in this case. Similarly, we rebuild sched_domain with a
cpu hotplug. scaling_max_freq interface should not be used to do any
kind of dynamic scaling.

>
> Android middleware has 'powerhits' (IIRC since ~4-5 versions now)
> but our capacity in task scheduler is not aware of those reductions.
>
> IMO thermal-pressure mechanism is good, but the naming convention
> just might be a bit more 'generic' to cover those two users.
>
> Some proposals of better naming:
> 1. Performance capping
> 2. Capacity capping
> 3. Performance reduction
>
> What do you think about changing the name of this and cover
> those two users: PowerCap DTPM and this user-space cpufreq?
