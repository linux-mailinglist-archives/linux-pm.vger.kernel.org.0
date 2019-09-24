Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BEBCBFE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfIXQBC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 12:01:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49810 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389811AbfIXQBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QROowg7IjnfgVkF6RvgX0ZvqgPx3NmbsV88LFBTgGA0=; b=S6p5IVAQ5diUvMhquEZYx7rMP
        tTlohjadXH/kmhzmvneN1OMAXdwmNo/oHVhm+Gqs7ZrQsFJugIqhfurNo4/8eu9IabT3BbvoSeWHp
        diGCtNNIxXphUpONokjiQIJOJHH1RRJLrk2T3VDqIaEqYo0+ixJF4CMtft/GYeTOkifk2thtiejq8
        VlbMr+0N8/U5j5Bg2h113RIG/NXxC0l7SbZPX98MDkcCi4NekVmUGvImWO3aKCqtzahr0mF5yipZ6
        66qfdWBFiUdzQREQo7Fwa9riXdmwg9rX4/sHETgr/Zz0DwsTNCSIoXvpZs0K0TUWkaLxSjIWWaRcS
        0c5TgsurA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCnEo-0003Uu-2z; Tue, 24 Sep 2019 16:00:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBAAA3053E9;
        Tue, 24 Sep 2019 17:59:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9762829E510A4; Tue, 24 Sep 2019 18:00:22 +0200 (CEST)
Date:   Tue, 24 Sep 2019 18:00:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Quentin Perret <qperret@qperret.net>,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190924160022.GB2386@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190914105708.GA12877@qperret.net>
 <1568730466.3329.4.camel@suse.cz>
 <20190924140332.GL2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924140332.GL2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 24, 2019 at 04:03:32PM +0200, Peter Zijlstra wrote:

> > I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
> > do what you suggest (x86-specific version of arch_scale_freq_invariant().
> 
> static_cpu_has() is an alternative and ends up being a static branch
> (similar to static_key) once the alternative patching runs.

That said; I think you want a static key anyway, because if we can't
tell the max_freq we don't want to use the invariant stuff.

Something a little like so on top perhaps.

Also, the below fixes that silly tick_disable stuff.

---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -196,20 +196,24 @@ static inline void sched_clear_itmt_supp
 #ifdef CONFIG_SMP
 #include <asm/cpufeature.h>
 
-#define arch_scale_freq_tick arch_scale_freq_tick
-#define arch_scale_freq_capacity arch_scale_freq_capacity
+DECLARE_STATIC_KEY_FALSE(arch_scale_freq_key);
+
+#define arch_scale_freq_invariant() static_branch_likely(&arch_scale_freq_key)
 
 DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
 
 static inline long arch_scale_freq_capacity(int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (arch_scale_freq_invariant())
 		return per_cpu(arch_cpu_freq, cpu);
 
 	return 1024 /* SCHED_CAPACITY_SCALE */;
 }
+#define arch_scale_freq_capacity arch_scale_freq_capacity
 
 extern void arch_scale_freq_tick(void);
+#define arch_scale_freq_tick arch_scale_freq_tick
+
 extern void x86_arch_scale_freq_tick_enable(void);
 extern void x86_arch_scale_freq_tick_disable(void);
 #else
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1799,6 +1799,8 @@ void native_play_dead(void)
  * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
  */
 
+DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
+
 static DEFINE_PER_CPU(u64, arch_prev_aperf);
 static DEFINE_PER_CPU(u64, arch_prev_mperf);
 static u64 arch_max_freq = SCHED_CAPACITY_SCALE;
@@ -1860,6 +1862,8 @@ static void core_set_cpu_max_freq(void)
 	turbo_ratio = (turbo_ratio >> 24) & 0xFF;   /* 4C turbo ratio */
 
 	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio);
+
+	static_key_enable(&arch_scale_freq_key);
 }
 
 static void intel_set_cpu_max_freq(void)
@@ -1876,10 +1880,19 @@ static void intel_set_cpu_max_freq(void)
 	core_set_cpu_max_freq();
 }
 
-static void set_cpu_max_freq(void)
+static void init_scale_freq(void *arg)
 {
 	u64 aperf, mperf;
 
+	rdmsrl(MSR_IA32_APERF, aperf);
+	rdmsrl(MSR_IA32_MPERF, mperf);
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+}
+
+static void set_cpu_max_freq(void)
+{
 	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
@@ -1891,11 +1904,7 @@ static void set_cpu_max_freq(void)
 		break;
 	}
 
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
-
-	this_cpu_write(arch_prev_aperf, aperf);
-	this_cpu_write(arch_prev_mperf, mperf);
+	init_scale_freq(NULL);
 }
 
 DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
@@ -1908,7 +1917,7 @@ void arch_scale_freq_tick(void)
 	u64 aperf, mperf;
 	u64 acnt, mcnt;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF) || tick_disable)
+	if (!arch_scale_freq_invariant() || tick_disable)
 		return;
 
 	rdmsrl(MSR_IA32_APERF, aperf);
@@ -1940,5 +1949,6 @@ void x86_arch_scale_freq_tick_enable(voi
 
 void x86_arch_scale_freq_tick_disable(void)
 {
+	on_each_cpu(init_scale_freq, NULL, 1);
 	tick_disable = true;
 }
