Return-Path: <linux-pm+bounces-18260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A59DEC11
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 19:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FAD282D19
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8F1A42D8;
	Fri, 29 Nov 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5mkdzgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB611A3AAD;
	Fri, 29 Nov 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904582; cv=none; b=t0uvpymxStEAI6tGoS2ao4BFho/sl0TV2ze5Jp8L1FzVTHzfXrDFnse/MhGfLM3ieZn427dsgptHXsRgLaY9eCvw6QzKQ2BQpKSDnkHr4Fwp9y+FRQ8auX+AV1J78hC5nU8PniP994JlEItkkWHJt6FTSR2ItGgnYJ0uW0Q5mCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904582; c=relaxed/simple;
	bh=jSfeu3b1BSR9b7pUV+96xj7SJhfr7jFy1eJNwTV9sy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+r5ubSLYsUA/rKmceqMgCFEiaHIXSd9q8cHiD/nHM7NzssWM2UcOxlUTf8XEFkqPntmyLOXtAqjKgVZh039eEq0SFnmz+VR7AL3Jyd8qCqp6pKzpJBzspLXfcXSL5F673/rs9cJR/uW4yGg72HMx4YoTc6Wd52/V0FGKn4jAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5mkdzgm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732904581; x=1764440581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSfeu3b1BSR9b7pUV+96xj7SJhfr7jFy1eJNwTV9sy0=;
  b=b5mkdzgmU8Fw6IZYwgRpFXCSPBk4hWkhc11LfypbAb/S7+dJxg+jdEPU
   ylOtmshcq7UfoayTk4lGY5C1u0gQJ3M5mFtZ9DyIG+g/ytJrB3uGaVCQM
   fOQSlpB4goBMdDZj7ybpYOT9Zp+HcXfvCQkDPsg2uzH/Ez3dLB9qYzpJV
   FWZEOP2e+VFKyWDuA0UmLmiNwbhGC085Bv7qGHz/EyCKjHv5QSSqkb6Hk
   dmIAOfMtoukd9EHLJd/ZDkkWRdamufJU2WrpSSNsrqvQ+GpJtDQ8Sr+OS
   uDegZ/zauC9ouOIki6Bbrrj1lMyFQJ3+gvSWTwlS7AEYvIryrfsY5Az/s
   w==;
X-CSE-ConnectionGUID: AAgNFthkQ9Kd2cBER922Cw==
X-CSE-MsgGUID: a48xXcEATJKVGfxhyK11Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36811968"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36811968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:23:01 -0800
X-CSE-ConnectionGUID: YfFSxJCRScO2yNseuMymEA==
X-CSE-MsgGUID: OaGZ7WSaSMyMK4MLiUcLqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="92422167"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:58 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v7 4/4] x86/smp native_play_dead: Prefer cpuidle_play_dead() over mwait_play_dead()
Date: Fri, 29 Nov 2024 19:22:32 +0100
Message-ID: <20241129182232.14987-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current algorithm* for looking up the mwait hint for the deepest
cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
calculates the mwait hint based on the number of reported substates.
This approach depends on the hints associated with them to be continuous
in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
is not met on the recent Intel platforms.

 * The current algorithm is implemented in the for loop inspecting edx
   in mwait_play_dead().

For example, Intel's Sierra Forest report two cstates with two substates
each in cpuid leaf 0x5:

  Name*   target cstate    target subcstate (mwait hint)
  ===========================================================
  C1      0x00             0x00
  C1E     0x00             0x01

  --      0x10             ----

  C6S     0x20             0x22
  C6P     0x20             0x23

  --      0x30             ----

  /* No more (sub)states all the way down to the end. */
  ===========================================================

   * Names of the cstates are not included in the CPUID leaf 0x5, they are
     taken from the product specific documentation.

Notice that hints 0x20 and 0x21 are skipped entirely for the target
cstate 0x20 (C6), being a cause of the problem for the current cpuid
leaf 0x5 algorithm.

Remove the old implementation of play_dead MWAIT hint calculation based
on the CPUID leaf 0x5 in mwait_play_dead() and delegate calling of the
mwait_play_dead_with_hint() to the idle driver.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 56 +++++----------------------------------
 1 file changed, 7 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8a3545c2cae9..82801137486d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1272,6 +1272,10 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1317,52 +1321,6 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
 	}
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead_cpuid_hint(void)
-{
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
-	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
-	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
-
-	eax = CPUID_MWAIT_LEAF;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	/*
-	 * eax will be 0 if EDX enumeration is not valid.
-	 * Initialized below to cstate, sub_cstate value when EDX is valid.
-	 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
-		eax = 0;
-	} else {
-		edx >>= MWAIT_SUBSTATE_SIZE;
-		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-			if (edx & MWAIT_SUBSTATE_MASK) {
-				highest_cstate = i;
-				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-			}
-		}
-		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-			(highest_subcstate - 1);
-	}
-
-	mwait_play_dead(eax);
-}
-
 /*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
@@ -1413,9 +1371,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead_cpuid_hint();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	/* Below returns only on error. */
+	cpuidle_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.47.1


