Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903AC2FFF35
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbhAVJa1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbhAVJOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 04:14:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5050C0613D6
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 01:02:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md11so3295493pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 01:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WYtFqNcAmCHK4Qh/6vBWCUphLzXrNxt4fXoA+c/Rq0=;
        b=vAQtyd2lBgUFGZhpEPWgU+D5td40Fd5DgDShbbYezK+eEqKPDR0Mzk/cMnlY62aD9u
         ZJRZyEY086DIknxHWXmUeE5ZD86X4JRulJQEeWCI3pMOOlZJXWg+Q/HTG6oOF6Rr3dgX
         NYkWSvmmn6UFlw3b0LxnyBA/xj2eUtrXNpPWujJ2L4utpiCxDNBXdDmxk6o9RLqywxZA
         EXgRPljMsdLjNmX0Yr56WLxe26yuEHu+qBYWZoIy5LLfzEQQg8yl3AUodd5CzL7PxFyc
         3ePqdXdgTZ26M2of92Vz2iHn/mPSusxGbjKJyXJr6lOgFxIlwqhCwsbv/MQNw0xUX7tL
         2WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WYtFqNcAmCHK4Qh/6vBWCUphLzXrNxt4fXoA+c/Rq0=;
        b=ZeyTn/USZLO8fRz89gS3yboTOTTjFeDa2LabjJchAgqitKGFCTBM8/LmAz+qWCGSxg
         QFbSdpashakwaVJuJD6pQuK+q3UOT3OJKDhaGMCqvBZGZc37oPAP5yIDmk1ONXbFBMg+
         vR26PDDHl5hZa6ESeiVJHxKbLBeAJZ+Y1vNSBcumsbUSqMsBa9eZP5hTt2j2wbpBr+UQ
         aj5T1wTZiXfIRKY/UAe78pxyw7/5t1TciR7GQXNYZm4cz61tNuZL/rC+e+PSpuQfmMOQ
         uvK1Vo2jshd0TQPwbe20XfN6PV0GMTWA2V4kg1Vw2cxoCcl21shNcEPb28mQ23585I/q
         5TOg==
X-Gm-Message-State: AOAM530EhUbIHJr8VKxVMhgeS2jQsfU20F+vhbePw54Qd6jX3HKRtYG+
        x6WlGpCFqWvg7Y61cMiTcV2hRQ==
X-Google-Smtp-Source: ABdhPJzXiwLQlnWaBuwHCzIKGE2vgYx8xQ3ze+DgW9jzqe6+XzyQXFOVPYZFyVVY9uCTowjLRjywmQ==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr1844986pjt.176.1611306162441;
        Fri, 22 Jan 2021 01:02:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n1sm7682967pfu.28.2021.01.22.01.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 01:02:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:32:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>, Jeremy.Linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 2/2] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20210122090239.ajpqvim3xuipawqn@vireshk-i7>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
 <069c40c173fc391116d13d60f4c1382c47e1a05a.1608030508.git.viresh.kumar@linaro.org>
 <20210119191550.GB19274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119191550.GB19274@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-21, 19:17, Ionela Voinescu wrote:
> Hi,
> 
> Do you know of a current platform that would benefit from this, that we
> could run some tests on?

Thunderx2 is one.

> On Tuesday 15 Dec 2020 at 16:46:36 (+0530), Viresh Kumar wrote:
> > @@ -243,7 +256,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
> >  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> >  	unsigned int cpu = policy->cpu;
> > -	int ret = 0;
> > +	int ret = 0, i;
> >  
> >  	cpu_data->cpu = cpu;
> >  	ret = cppc_get_perf_caps(cpu, caps);
> > @@ -300,6 +313,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  
> >  	cpu_data->cur_policy = policy;
> >  
> > +	for_each_cpu(i, policy->cpus)
> > +		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
> > +
> 
> Is policy->cpuinfo populated at this point?

The base has changed since the time I posted the patch, but yes this
routine itself updates min/max freq in cpuinfo at an earlier point.

> > +static void cppc_scale_freq_tick_workfn(struct kthread_work *work)
> > +{
> > +	struct cppc_freq_invariance *cppc_fi;
> > +	struct cppc_perf_fb_ctrs fb_ctrs = {0};
> > +	int cpu = raw_smp_processor_id();
> > +	struct cppc_cpudata *cpudata = all_cpu_data[cpu];
> > +	u64 rate;
> > +
> > +	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> > +
> > +	if (cppc_get_perf_ctrs(cpu, &fb_ctrs)) {
> > +		pr_info("%s: cppc_get_perf_ctrs() failed\n", __func__);
> > +		return;
> > +	}
> > +
> > +	rate = cppc_get_rate_from_fbctrs(cpudata, cppc_fi->prev_perf_fb_ctrs, fb_ctrs);
> > +	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> > +
> > +	rate <<= SCHED_CAPACITY_SHIFT;
> > +	per_cpu(freq_scale, cpu) = div64_u64(rate, cppc_fi->max_freq);
> 
> It will save you some computation by skipping the intermediary frequency
> scale transition. For this computation you're obtaining current
> performance from counters, on the CPPC abstract performance scale,
> then you're converting it to a current frequency, which then gets
> translated again to a scale factor on the [0,1024] scale.
> 
> You probably want to keep the sanitation done in
> cppc_get_rate_from_fbctrs() on the counter values, but you could skip
> the call to cppc_cpufreq_perf_to_khz(), and use obtained performance
> together with caps->highest_perf, or caps->nominal_perf instead of
> cppc_fi->max_freq, in this function.

Something like this ?

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 0d7a950f3c9f..d4d7fb0dc918 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -389,9 +389,9 @@ static inline u64 get_delta(u64 t1, u64 t0)
        return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-                                    struct cppc_perf_fb_ctrs fb_ctrs_t0,
-                                    struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+                                struct cppc_perf_fb_ctrs fb_ctrs_t0,
+                                struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
        u64 delta_reference, delta_delivered;
        u64 reference_perf, delivered_perf;
@@ -404,11 +404,20 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
                                    fb_ctrs_t0.delivered);
 
        /* Check to avoid divide-by zero */
-       if (delta_reference || delta_delivered)
-               delivered_perf = (reference_perf * delta_delivered) /
-                                       delta_reference;
-       else
-               delivered_perf = cpu_data->perf_ctrls.desired_perf;
+       if (!delta_reference && !delta_delivered)
+               return cpu_data->perf_ctrls.desired_perf;
+
+       return (reference_perf * delta_delivered) / delta_reference;
+}
+
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
+                                    struct cppc_perf_fb_ctrs fb_ctrs_t0,
+                                    struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+       u64 delivered_perf;
+
+       delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
+                                              fb_ctrs_t1);
 
        return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -539,21 +548,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
        struct cppc_freq_invariance *cppc_fi;
        struct cppc_perf_fb_ctrs fb_ctrs = {0};
        int cpu = raw_smp_processor_id();
-       u64 rate;
+       struct cppc_cpudata *cpu_data;
+       u64 perf;
 
        cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+       cpu_data = cppc_fi->cpu_data;
 
        if (cppc_get_perf_ctrs(cpu, &fb_ctrs)) {
                pr_info("%s: cppc_get_perf_ctrs() failed\n", __func__);
                return;
        }
 
-       rate = cppc_get_rate_from_fbctrs(cppc_fi->cpu_data,
-                                        cppc_fi->prev_perf_fb_ctrs, fb_ctrs);
        cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+       perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
+                                    fb_ctrs);
 
-       rate <<= SCHED_CAPACITY_SHIFT;
-       per_cpu(freq_scale, cpu) = div64_u64(rate, cppc_fi->max_freq);
+       perf <<= SCHED_CAPACITY_SHIFT;
+       per_cpu(freq_scale, cpu) = div64_u64(perf , cpu_data->perf_caps->highest_perf);
 }
 
 static void cppc_irq_work(struct irq_work *irq_work)

> Also, to optimise it further, you can compute a reference scale (from
> reference performance and highest/nominal performance as done in
> freq_inv_set_max_ratio() - arch/arm64/kernel/topology.c, and use that
> instead in further freq scale computations.

-- 
viresh
