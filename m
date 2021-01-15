Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D691D2F73D7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbhAOHtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 02:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbhAOHtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 02:49:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F0C061757
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 23:48:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my11so5132136pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBo7XGqS/8vdVXSfxJrsdvdJTDr73Y6Uapns8KjEp88=;
        b=GmafHoXW8cpIa3au+brWxVSoyn+13XNBD5bZR7gBzBaZxZ4JfTzfubpQZbGZ40uDHk
         S45RnczmSP8gFuwC49Q7A7cl1nYNW5W7YrcttAg5W7D94pAxdnWGI2Xb2yhsZhZIZXc6
         GhXjyb1/vReH9sMhIEtmWbXJQvBQm11zJKoxE2zPWCCnPPLpctr5KmMSR/cvQ7i0Iw8j
         xL2ewTcjvO2OXip+t7uV1T/o2A/8y/a9x+uZNpVxJ+6DlFB/4RrndVf7Ty5w+VS6BEdP
         JT2rfdjKJbDGgZUbWVu1Bxikw0j+BdglPxERqGzh22fhwYApVCbye/Vw0codkehXPh6g
         Nuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBo7XGqS/8vdVXSfxJrsdvdJTDr73Y6Uapns8KjEp88=;
        b=t6MA0SUjFuIpYul5o+871INX5mm3f7/LzClBWH2jJ5+Af6xoqCNkQLaJ4eAnMMupjC
         Hfs3gU1vOf9OSlF97/S9Ax62Gc+jpszW1tRHcUu7iXZKqyiRCpqwgGSyeWK9azUZz6TY
         dLcku6G4ATVJHo9F28A4nPsUTb9uCl/Ca22obeLWzlZSmsPJMWzvjv+TI2GwNfzsKGnA
         dHC6OsWlm/UAbugMB1qlKy7KtyDjbGIv4ty79IeuC1w0/hxzN8F2lNlMMmI7RohuklEr
         dzyWPh05BRfoKsQ+3Mk6oEFs57o9ot1c4OTMVbNgTV5OXVXS/C0fKvEPp8w7zMcA4FDE
         8akQ==
X-Gm-Message-State: AOAM530DAtDCux16+Y+YOnF+YNi5OCGo6bB73qMHn1bsnvhGUAK/rdpj
        FkCW3SsPHAarCLfGeJBRuI2J8g==
X-Google-Smtp-Source: ABdhPJwZrrlUydV/DMM4M+ipp2x7ATvQEhjurT1Ut/s+ENH6Ktl2v8RDt8pG2Mo+k0cmz5FvUB26CA==
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id bj3-20020a1709028503b02900dc044f62d8mr11422575plb.34.1610696930589;
        Thu, 14 Jan 2021 23:48:50 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id y190sm8045298pgb.36.2021.01.14.23.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 23:48:49 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:18:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210115074847.4a2udqcxbaoyrztv@vireshk-i7>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
 <28ade070dd80f6f22d6e8fce5db5f0142b428fa9.1608030508.git.viresh.kumar@linaro.org>
 <20210113161855.GA32402@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113161855.GA32402@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-01-21, 16:18, Ionela Voinescu wrote:
> On Tuesday 15 Dec 2020 at 16:46:35 (+0530), Viresh Kumar wrote:
> > +void topology_scale_freq_tick(void)
> > +{
> > +	struct scale_freq_tick_data *sftd = *this_cpu_ptr(&sft_data);
> > +
> > +	if (sftd)
> > +		sftd->scale_freq();
> > +}
> 
> What do you think about having a single topology function that handles
> all sources of invariance (cpufreq, arch counters, platform counters)?

I think keeping them separate is better, both of these are called from
scheduler's context (hotpath) and adding any more unnecessary
conditionals there should be rather avoided. We could have given a
though to merging them if they were going to share some code, but that
is not the case here clearly. They are quite different.

This is how it looks now:

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 3b8dca4eb08d..be6a53ba3e2d 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -17,15 +17,9 @@ int pcibus_to_node(struct pci_bus *bus);
 #include <linux/arch_topology.h>
 
 void update_freq_counters_refs(void);
-void topology_scale_freq_tick(void);
 
-#ifdef CONFIG_ARM64_AMU_EXTN
-/*
- * Replace task scheduler's default counter-based
- * frequency-invariance scale factor setting.
- */
+/* Replace task scheduler's default frequency-invariance scale factor setting */
 #define arch_scale_freq_tick topology_scale_freq_tick
-#endif /* CONFIG_ARM64_AMU_EXTN */
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_set_freq_scale topology_set_freq_scale
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index e08a4126453a..1e47dfd465f8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,8 +199,44 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	return 0;
 }
 
-static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
-#define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
+static void amu_scale_freq_tick(void)
+{
+	u64 prev_core_cnt, prev_const_cnt;
+	u64 core_cnt, const_cnt, scale;
+
+	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
+	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	update_freq_counters_refs();
+
+	const_cnt = this_cpu_read(arch_const_cycles_prev);
+	core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	if (unlikely(core_cnt <= prev_core_cnt ||
+		     const_cnt <= prev_const_cnt))
+		return;
+
+	/*
+	 *	    /\core    arch_max_freq_scale
+	 * scale =  ------- * --------------------
+	 *	    /\const   SCHED_CAPACITY_SCALE
+	 *
+	 * See validate_cpu_freq_invariance_counters() for details on
+	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
+	 */
+	scale = core_cnt - prev_core_cnt;
+	scale *= this_cpu_read(arch_max_freq_scale);
+	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
+			  const_cnt - prev_const_cnt);
+
+	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
+	this_cpu_write(freq_scale, (unsigned long)scale);
+}
+
+static struct scale_freq_data amu_sfd = {
+	.source = SCALE_FREQ_SOURCE_ARCH,
+	.set_freq_scale = amu_scale_freq_tick,
+};
 
 static void amu_fie_setup(const struct cpumask *cpus)
 {
@@ -227,7 +263,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
 		return;
 
-	static_branch_enable(&amu_fie_key);
+	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
@@ -283,53 +319,6 @@ static int __init init_amu_fie(void)
 }
 core_initcall(init_amu_fie);
 
-bool arch_freq_counters_available(const struct cpumask *cpus)
-{
-	return amu_freq_invariant() &&
-	       cpumask_subset(cpus, amu_fie_cpus);
-}
-
-void topology_scale_freq_tick(void)
-{
-	u64 prev_core_cnt, prev_const_cnt;
-	u64 core_cnt, const_cnt, scale;
-	int cpu = smp_processor_id();
-
-	if (!amu_freq_invariant())
-		return;
-
-	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
-		return;
-
-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
-
-	update_freq_counters_refs();
-
-	const_cnt = this_cpu_read(arch_const_cycles_prev);
-	core_cnt = this_cpu_read(arch_core_cycles_prev);
-
-	if (unlikely(core_cnt <= prev_core_cnt ||
-		     const_cnt <= prev_const_cnt))
-		return;
-
-	/*
-	 *	    /\core    arch_max_freq_scale
-	 * scale =  ------- * --------------------
-	 *	    /\const   SCHED_CAPACITY_SCALE
-	 *
-	 * See validate_cpu_freq_invariance_counters() for details on
-	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
-	 */
-	scale = core_cnt - prev_core_cnt;
-	scale *= this_cpu_read(arch_max_freq_scale);
-	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
-			  const_cnt - prev_const_cnt);
-
-	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
-	this_cpu_write(freq_scale, (unsigned long)scale);
-}
-
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587cc119e..e2115ea348dc 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,17 +21,65 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
+static struct cpumask scale_freq_counters_mask;
+
+static bool supports_scale_freq_counters(const struct cpumask *cpus)
+{
+	return cpumask_subset(cpus, &scale_freq_counters_mask);
+}
+
 bool topology_scale_freq_invariant(void)
 {
 	return cpufreq_supports_freq_invariance() ||
-	       arch_freq_counters_available(cpu_online_mask);
+	       supports_scale_freq_counters(cpu_online_mask);
+}
+
+void topology_set_scale_freq_source(struct scale_freq_data *data,
+				  const struct cpumask *cpus)
+{
+	struct scale_freq_data *sfd;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		sfd = per_cpu(sft_data, cpu);
+
+		/* Use ARCH provided counters whenever possible */
+		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
+			per_cpu(sft_data, cpu) = data;
+			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
+		}
+	}
 }
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
 
-__weak bool arch_freq_counters_available(const struct cpumask *cpus)
+void topology_clear_scale_freq_source(enum scale_freq_source source,
+				    const struct cpumask *cpus)
 {
-	return false;
+	struct scale_freq_data *sfd;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		sfd = per_cpu(sft_data, cpu);
+
+		if (sfd && sfd->source == source) {
+			per_cpu(sft_data, cpu) = NULL;
+			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
+		}
+	}
 }
+EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
+
+void topology_scale_freq_tick(void)
+{
+	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
+
+	if (sfd)
+		sfd->set_freq_scale();
+}
+
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(freq_scale);
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
@@ -47,7 +95,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 	 * want to update the scale factor with information from CPUFREQ.
 	 * Instead the scale factor will be updated from arch_scale_freq_tick.
 	 */
-	if (arch_freq_counters_available(cpus))
+	if (supports_scale_freq_counters(cpus))
 		return;
 
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..1bcbf8eff991 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -34,7 +34,18 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq);
 bool topology_scale_freq_invariant(void);
 
-bool arch_freq_counters_available(const struct cpumask *cpus);
+enum scale_freq_source {
+	SCALE_FREQ_SOURCE_ARCH,
+};
+
+struct scale_freq_data {
+	enum scale_freq_source source;
+	void (*set_freq_scale)(void);
+};
+
+void topology_scale_freq_tick(void);
+void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
+void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 

-- 
viresh
