Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC57A485F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjIRL2D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbjIRL2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 07:28:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C081B9
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 04:24:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-274dd099cb8so1104091a91.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695036252; x=1695641052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+JIoagGbUxbJdnZ/11AR40I+FsTVn6KCyqjzpGRwohg=;
        b=XE1jOQZNuHHy/0ooQJ3QWkpVrr4ChGYzGTZ4/puq+qR+XuRDB7uIrJANXmFcO6tYY1
         ucK33oKCgfCwm8jH4FJqdwm4dbNOos1FPg0+rg1nzgCJa0JNLpGSbd71NS+ZQF/PvJ3H
         iVZ3HYHtfG9HPrHpM67Vst1/l4GhYmPoBg1uZiQX8LjIO1Bs7Kmy97iPJaLLAbsTy+m1
         dBdrirNljM1Y4kB4ofTl80MOOgnk+ewhiyQV+P4etQ1xDpbT4bPWnYeVlETnl9vlxNhx
         tx2XY/XfklzPYlG8aNWvaGeNc/gvacfD08DpXsdmzywYGSZMRCDAsUV3txWQ9W234SXE
         te3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695036252; x=1695641052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JIoagGbUxbJdnZ/11AR40I+FsTVn6KCyqjzpGRwohg=;
        b=f+UHX24rUSsIR2wVrE/IHzZeKdM8tu3MCxI1F8xDWQvTwjAk7DYyF+jxlIwO7gjWD8
         x8GBaws9zteV7UGm1PrVGXdBqk881zbet7j+WV5uqYG+n0+sx897gsViYJOVNx7Pk/aW
         6S5E4yG1BicQBRVRsSOFsM58rlT/0xYtUmgCmccrUl2nLUqzzPhYLakP0uAfvqL9A0gY
         Ety0qYFayyBq/KLeZji18/8aUFPCU6ffdQGwxL6YzMKQI0rUs1jUEeqyQ30mhQTQT22h
         0t2bWx5XpJ7OjuJGynTQxJma64aR1/SAqX+c/7DD4ma83ygliKs+yCRJTcRHGdulzQBI
         Rc6Q==
X-Gm-Message-State: AOJu0YxPUNd8yDQ/+pyD878Kznm1F4qcM62HS4Uu20OM4Akz6lsdLm80
        dPq80oMAl2n/8vAUDvfSwC2co6H/2C6n8ktRAK1gXw==
X-Google-Smtp-Source: AGHT+IEYnp5mNbH0vm2kgMzPq48KRD0OiUzdkJ9b2tXtBZlshoSaZMZ7r/copZVbT9J2mDht277Rf/2gg2PDi+Zaj9E=
X-Received: by 2002:a17:90a:8a15:b0:274:6d4e:e0d9 with SMTP id
 w21-20020a17090a8a1500b002746d4ee0d9mr7943000pjn.45.1695036251982; Mon, 18
 Sep 2023 04:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-3-vincent.guittot@linaro.org> <840cb103-8ffb-9798-05a3-a557f78f7f7a@arm.com>
In-Reply-To: <840cb103-8ffb-9798-05a3-a557f78f7f7a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Sep 2023 13:23:59 +0200
Message-ID: <CAKfTPtDahUNatFpy+cQgbadhON_kwEaBVuDpUfW2kQHJUvecHg@mail.gmail.com>
Subject: Re: [PATCH 2/4] topology: add a new arch_scale_freq_reference
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     conor.dooley@microchip.com, linux-arm-kernel@lists.infradead.org,
        suagrfillet@gmail.com, juri.lelli@redhat.com, sudeep.holla@arm.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        ajones@ventanamicro.com, lftan@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux@armlinux.org.uk, bristot@redhat.com, catalin.marinas@arm.com,
        bsegall@google.com, will@kernel.org, vschneid@redhat.com,
        rostedt@goodmis.org, rafael@kernel.org, dietmar.eggemann@arm.com,
        aou@eecs.berkeley.edu, mingo@redhat.com, paul.walmsley@sifive.com,
        mgorman@suse.de, gregkh@linuxfoundation.org, peterz@infradead.org,
        viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 4 Sept 2023 at 14:34, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
>
> On 9/1/23 14:03, Vincent Guittot wrote:
> > Create a new method to get a unique and fixed max frequency. Currently
> > cpuinfo.max_freq or last item of performance domain are used as the max
> > frequency when computing the frequency for a level of utilization but:
> > - cpuinfo_max_freq can change at runtime. boost is one example of
> >    such change.
> > - cpuinfo.max_freq and last item of the PD can be different leading to
> >    different results betwen cpufreq and energy model.
> >
> > We need to save the max frequency that has been used when computing the
> > CPUs capacity and use this fixed and coherent value to convert between
> > frequency and CPU's capacity.
> >
> > In fact, we already save the frequency that has been used when computing
> > the capacity of each CPU. We extend the precision to save khZ instead of
> > Mhz currently and we modify the type to be aligned with other variables
> > used when converting frequency to capacity and the other way.
>
> I do like this 'kHz' change. We also use kHz in the EM, so better
> aligned now.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   arch/arm/include/asm/topology.h   | 1 +
> >   arch/arm64/include/asm/topology.h | 1 +
> >   arch/riscv/include/asm/topology.h | 1 +
> >   drivers/base/arch_topology.c      | 9 +++------
> >   include/linux/arch_topology.h     | 7 +++++++
> >   5 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> > index c7d2510e5a78..853c4f81ba4a 100644
> > --- a/arch/arm/include/asm/topology.h
> > +++ b/arch/arm/include/asm/topology.h
> > @@ -13,6 +13,7 @@
> >   #define arch_set_freq_scale topology_set_freq_scale
> >   #define arch_scale_freq_capacity topology_get_freq_scale
> >   #define arch_scale_freq_invariant topology_scale_freq_invariant
> > +#define arch_scale_freq_ref topology_get_freq_ref
> >   #endif
> >
> >   /* Replace task scheduler's default cpu-invariant accounting */
> > diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> > index 9fab663dd2de..a323b109b9c4 100644
> > --- a/arch/arm64/include/asm/topology.h
> > +++ b/arch/arm64/include/asm/topology.h
> > @@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
> >   #define arch_set_freq_scale topology_set_freq_scale
> >   #define arch_scale_freq_capacity topology_get_freq_scale
> >   #define arch_scale_freq_invariant topology_scale_freq_invariant
> > +#define arch_scale_freq_ref topology_get_freq_ref
> >
> >   #ifdef CONFIG_ACPI_CPPC_LIB
> >   #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> > diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> > index e316ab3b77f3..61183688bdd5 100644
> > --- a/arch/riscv/include/asm/topology.h
> > +++ b/arch/riscv/include/asm/topology.h
> > @@ -9,6 +9,7 @@
> >   #define arch_set_freq_scale         topology_set_freq_scale
> >   #define arch_scale_freq_capacity    topology_get_freq_scale
> >   #define arch_scale_freq_invariant   topology_scale_freq_invariant
> > +#define arch_scale_freq_ref          topology_get_freq_ref
> >
> >   /* Replace task scheduler's default cpu-invariant accounting */
> >   #define arch_scale_cpu_capacity     topology_get_cpu_scale
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index b741b5ba82bd..75fa67477a9d 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -26,7 +26,7 @@
> >   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
> >   static struct cpumask scale_freq_counters_mask;
> >   static bool scale_freq_invariant;
> > -static DEFINE_PER_CPU(u32, freq_factor) = 1;
> > +DEFINE_PER_CPU(unsigned long, freq_factor) = 1;
>
> Why it's not static now?

it can be accessed outside with inline function like cpu_scale and
arch_freq_scale

>
> >
> >   static bool supports_scale_freq_counters(const struct cpumask *cpus)
> >   {
> > @@ -183,10 +183,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
> >
> >       cpu = cpumask_first(cpus);
> >       max_capacity = arch_scale_cpu_capacity(cpu);
> > -     max_freq = per_cpu(freq_factor, cpu);
> > -
> > -     /* Convert to MHz scale which is used in 'freq_factor' */
> > -     capped_freq /= 1000;
> > +     max_freq = arch_scale_freq_ref(cpu);
> >
> >       /*
> >        * Handle properly the boost frequencies, which should simply clean
> > @@ -411,7 +408,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> >
> >       for_each_cpu(cpu, policy->related_cpus)
> > -             per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> > +             per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq;
> >
> >       if (cpumask_empty(cpus_to_visit)) {
> >               topology_normalize_cpu_scale();
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index a07b510e7dc5..7a2dba9c3dc0 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >
> >   void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >
> > +DECLARE_PER_CPU(unsigned long, freq_factor);
> > +
> > +static inline unsigned long topology_get_freq_ref(int cpu)
> > +{
> > +     return per_cpu(freq_factor, cpu);
> > +}
> > +
> >   DECLARE_PER_CPU(unsigned long, arch_freq_scale);
> >
> >   static inline unsigned long topology_get_freq_scale(int cpu)
>
> Apart from that 'static' missing, that looks good.
>
> Regards,
> Lukasz
