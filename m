Return-Path: <linux-pm+bounces-17897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26549D52E4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D501F210C3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574831DE4C2;
	Thu, 21 Nov 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epBHLhlg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AE1D79BE
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215202; cv=none; b=sIxGjFJGeaVTO5BJ3BJYTBDEKgholxiL9y8qfggPMNrv1TMZmIBOTz5Rjr12F61NCgWGzYM48WaITlIra+xP+RHaposWPylE9LzOdtyZ5a/N+hEug0ESKaCgwtouCdYZru1MZvS0f2KiooHxmtU3a8E+QNw8c75Sf52RmzGuBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215202; c=relaxed/simple;
	bh=eGhYnE5emXo94Pyg5quiuPFdiSkETv0T4xLbIt+gbbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFZRuvxaxwbe7cvS6S5xEDAsXh7MObZqq6bHoDnr10uUiqDrmKbdknAy5gdxRck03XU5I8ketvi9v8U7iB7fj4SDcSKuXd9sf1qFvZpjnEBRURZ/S2/VUBHeoRaidXJ87nxEYDLZX5dJm8ZOMRZ8GIPSrNtGBVnOegLI501Ezxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epBHLhlg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eec3cb4a81so23295087b3.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215199; x=1732819999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=T+9Madf5AUgYPaX6aUUL9JHycbWIRkK+aZqhIzgnbrs=;
        b=epBHLhlgmfnklftRQidJ2GmzQ+NWXPZW4UK+9IvFWJMBEz545B6BzS5+fs/HgOlrnx
         doncHJ6bH3mEZomG9hhOSpCDC+ZE+C3Mc/+aN+F+YxDoy56mOWkBuePVzTJzJM5Ze4H5
         +6Qlc8xxQq9s4SlVnaaZZvNG1g3T5ZP7k8taUUxiWkBMEC/JdmAeMU6qyir8OpILwAQ9
         TsYABene16OKHGimxZX0pZsTEPOdJScw+vldYYnQJ08ZAp3Lf0TvloFI6D7bEPIQLpbH
         EvppUyxtL6gq8rgZWbESl63tfumL8ia9OBvjtEVJCcM37Pqnj8w0BbokVSYVXEdXneHP
         2y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215199; x=1732819999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+9Madf5AUgYPaX6aUUL9JHycbWIRkK+aZqhIzgnbrs=;
        b=sGzjYuW83Eb+5rZJnctTNYJ8uozVXVXks7vsMdFlkTOr84vErYzMuJ/MEytBHxrxWw
         BL4juMjMlAfXaz+jfsLGuPDtOhQCuAxgHCg5VSeMPX4Q8vR/KSgSSc+Q8pNFTMflwDRl
         VVrykmjtIYqTg7vNaeXKy5WJc0RZDebZNJAum4PzHk6Q0FYpDvBVQ8i7rqHT7ezGDa+P
         ll93fzEtAThpbss53mvJmso24NYCAZd6LDLaSLqfycRJEl41a6P9dYmInZOCsk746655
         4D2BB/naqgFYgvh3DltTxaEDlHHNxvu2t7Jy8KC7BgcGG/evefHBy/gtUXmSIs9qbZx3
         x1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcYWha+ciY/D1X02HO3MogGVgf7myoNvakbxi2EjYEvq8BLguOL1QIK1QtnM4nlOAPh9xTwnnX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNr1RnNu9fP8oraAURXaYAvEltpoOA8w8d3TcZGdCZUFqxLdpo
	kvIqTikpP1mjVHkJgAtHh/UqgZBjHX+nM+4k1GkE31tL6E4WA4hk0V2L2fyrvGlXaidCdc+XImT
	bKlXpbw==
X-Google-Smtp-Source: AGHT+IFW1c+yo5NB9i6gITZMQ/WYNQr1/fXSlza8bauLrwlg/McJYGaXVTMf7a6D63EaXjw6XMTTYqlKnd3N
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a25:ab92:0:b0:e30:d5cf:775a with SMTP id
 3f1490d57ef6-e38f74af44emr892276.6.1732215199276; Thu, 21 Nov 2024 10:53:19
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:53 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-2-mizhang@google.com>
Subject: [RFC PATCH 01/22] x86/aperfmperf: Introduce get_host_[am]perf()
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

In preparation for KVM pass-through of IA32_APERF and IA32_MPERF,
introduce wrappers that read these MSRs. Going forward, all kernel
code that needs host APERF/MPERF values should use these wrappers
instead of rdmsrl().

While these functions currently just read the MSRs directly, future
patches will enhance them to handle cases where the MSRs contain guest
values. Moving all host APERF/MPERF reads to use these functions now
will make it easier to add this functionality later.

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/topology.h  |  3 +++
 arch/x86/kernel/cpu/aperfmperf.c | 22 ++++++++++++++++++----
 drivers/cpufreq/amd-pstate.c     |  4 ++--
 drivers/cpufreq/intel_pstate.c   |  5 +++--
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 92f3664dd933b..2ef9903cf85d7 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -302,6 +302,9 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
 #endif
 
+extern u64 get_host_aperf(void);
+extern u64 get_host_mperf(void);
+
 extern void arch_scale_freq_tick(void);
 #define arch_scale_freq_tick arch_scale_freq_tick
 
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index f642de2ebdac8..3be5070ba3361 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -40,8 +40,8 @@ static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
 
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	aperf = get_host_aperf();
+	mperf = get_host_mperf();
 
 	this_cpu_write(cpu_samples.aperf, aperf);
 	this_cpu_write(cpu_samples.mperf, mperf);
@@ -94,6 +94,20 @@ void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
 
+u64 get_host_aperf(void)
+{
+	WARN_ON_ONCE(!irqs_disabled());
+	return native_read_msr(MSR_IA32_APERF);
+}
+EXPORT_SYMBOL_GPL(get_host_aperf);
+
+u64 get_host_mperf(void)
+{
+	WARN_ON_ONCE(!irqs_disabled());
+	return native_read_msr(MSR_IA32_MPERF);
+}
+EXPORT_SYMBOL_GPL(get_host_mperf);
+
 static bool __init turbo_disabled(void)
 {
 	u64 misc_en;
@@ -474,8 +488,8 @@ void arch_scale_freq_tick(void)
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	aperf = get_host_aperf();
+	mperf = get_host_mperf();
 	acnt = aperf - s->aperf;
 	mcnt = mperf - s->mperf;
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b63863f77c677..c26092284be56 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -446,8 +446,8 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	aperf = get_host_aperf();
+	mperf = get_host_mperf();
 	tsc = rdtsc();
 
 	if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 400337f3b572d..993a66095547f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pm_qos.h>
 #include <linux/bitfield.h>
+#include <linux/topology.h>
 #include <trace/events/power.h>
 
 #include <asm/cpu.h>
@@ -2423,8 +2424,8 @@ static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 	u64 tsc;
 
 	local_irq_save(flags);
-	rdmsrl(MSR_IA32_APERF, aperf);
-	rdmsrl(MSR_IA32_MPERF, mperf);
+	aperf = get_host_aperf();
+	mperf = get_host_mperf();
 	tsc = rdtsc();
 	if (cpu->prev_mperf == mperf || cpu->prev_tsc == tsc) {
 		local_irq_restore(flags);
-- 
2.47.0.371.ga323438b13-goog


