Return-Path: <linux-pm+bounces-17203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3489C1CFA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B1A285508
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECB1E8858;
	Fri,  8 Nov 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ck1PMiQ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF41E883E;
	Fri,  8 Nov 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068971; cv=none; b=eXzUe/zJLMF2wP0zlGxKVBljQgDD4btBtBHcnX0dSEo85caYzlFH7fqXR0spJ1zd+kGgFF590DzGY+apULObbxysZ8eeUCWpEhMF5/PtQbgKZJcko4rP8RLw2/CWSVRN4PIje/OedPlqZXMWet3hy8Bg+Aa0yTGWcjHK28BZ4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068971; c=relaxed/simple;
	bh=zSBLRIBbaYeA+QemFOtWX9BgOHY9bYPGcEOfeM2A010=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/IVZsKOEiMKF67qI1IJE3xmiqEmBO0u9HPD7qVKdsIP80IAjKP5r+dt0x9/M3bA0AB2BBAUMWEBL9+/pgb5SUuiNJFwZfUEc0L73ClziTyTZHd4n1u89kP03zSY1s28pr+fRFW3Un897dN6Gr1E2zYN4d9KMX8uNHnt+8MIZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ck1PMiQ2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068970; x=1762604970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSBLRIBbaYeA+QemFOtWX9BgOHY9bYPGcEOfeM2A010=;
  b=Ck1PMiQ2dijzQLF9axPiki0M6dYV5ybN9a0i7wgNytV7G+0Pp8mrXFik
   9U62T0Zgk9Wdd/PlBidQJpXmzhaqLH/lj8TlNhxRbgcwff1dirVRnEI/n
   VbRe2mj9hcq05BmRnRZe0PImulIYooGJvv1OgzS0JSaBSrRYVFd2y1RJj
   KoeFpVR9TsOoCVpkxzv1961VQO4jFJAzjchIFHl/NLV/u5X5b2TiaOuds
   N3ImhfPibOtaCsxjhInC4DYqfip07jtsgseNVYgtPPkd8yXGJ4ZXEmoBh
   CPxy5O1niWczFzf6PXKKDXxrL0+mDzHvOQS3ikPHqX74l5U21z/FpgQ3V
   g==;
X-CSE-ConnectionGUID: q7ICO7dDQBCUF7dbselpjg==
X-CSE-MsgGUID: 3oxBPrs0Q5uZdRcCdf6EeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53510347"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53510347"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:30 -0800
X-CSE-ConnectionGUID: 8HdpXsAlRQWi9TT9ET/2qA==
X-CSE-MsgGUID: XjDM3UkhSKmkGkq98pK5pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85921049"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:27 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v3 1/3] x86/smp: Allow calling mwait_play_dead with arbitrary hint
Date: Fri,  8 Nov 2024 13:29:07 +0100
Message-ID: <20241108122909.763663-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation for looking up the mwait hint for the deepest
cstate depends on them to be continuous in range [0, NUM_SUBSTATES-1].
While that is correct on most Intel x86 platforms, it is not documented
and may not result in reaching the most optimized idle state on some of
them.

For example Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
    C6S  (hint 0x22)
    C6SP (hint 0x23)

Hints 0x20 and 0x21 are skipped entirely, causing the current
implementation to compute the wrong hint, when looking for the deepest
cstate for offlined CPU to enter. As a result, package with an offlined
CPU can never reach PC6.

Allow the idle driver to call mwait_play_dead() code with the forced
mwait hint, skipping the cpuid based computation.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  6 ++++++
 arch/x86/kernel/smpboot.c  | 25 ++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..fbd275d6661a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+int mwait_play_dead_with_hint(unsigned long hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline int mwait_play_dead_with_hint(unsigned long eax_hint)
+{
+	return 1;
+}
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..44c40781bad6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1270,13 +1270,14 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+int mwait_play_dead_with_hint(unsigned long eax_hint);
+
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
  */
-static inline void mwait_play_dead(void)
+static inline int mwait_play_dead(void)
 {
-	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
@@ -1284,13 +1285,13 @@ static inline void mwait_play_dead(void)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
+		return 1;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
+		return 1;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
+		return 1;
 	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
+		return 1;
 
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
@@ -1314,6 +1315,13 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	return mwait_play_dead_with_hint(eax);
+}
+
+int mwait_play_dead_with_hint(unsigned long eax_hint)
+{
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
+
 	/* Set up state for the kexec() hack below */
 	md->status = CPUDEAD_MWAIT_WAIT;
 	md->control = CPUDEAD_MWAIT_WAIT;
@@ -1333,7 +1341,7 @@ static inline void mwait_play_dead(void)
 		mb();
 		__monitor(md, 0, 0);
 		mb();
-		__mwait(eax, 0);
+		__mwait(eax_hint, 0);
 
 		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
 			/*
@@ -1353,6 +1361,9 @@ static inline void mwait_play_dead(void)
 				native_halt();
 		}
 	}
+
+	/* Never reached */
+	return 0;
 }
 
 /*
-- 
2.47.0


