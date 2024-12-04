Return-Path: <linux-pm+bounces-18543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C009E3C71
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29607B2A6F6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F420B20C;
	Wed,  4 Dec 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+MKTK8M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED20B1E9;
	Wed,  4 Dec 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321334; cv=none; b=V0aOuk+oBomwngWLRcI7Xj4Z65iizzZW55tIQOw43CRlKq9ssRkFqaI7k5zHa0NH49EMcxOFSmERC78wdMp2TCS/TScADBMA10O1OvxV1y9kmmRrSoVYDmMcr994AZLEYdv9X6N00xzfwSuWENKBhlYTkyYkql6am8nhs470yWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321334; c=relaxed/simple;
	bh=C8H/vAtl/ysCKFSDbRX2SBUQ4grZrSHvkzZz0WczXwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0U7huT9oHw+Fl7/YQ54ERFx8lqtO2lZECcTrMZe/b+z+R0gREZu/A3CdcCbqv3RWyRLeUkTFQ+M74a0WqigrUCfAeSVmMTKueVkG4GSc/7Kq+Z8dsR61UxtasXqZUF5HQI5yekh72qRXPG6iWSnrJhNNMIiZYdew2BCeCewIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+MKTK8M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321334; x=1764857334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8H/vAtl/ysCKFSDbRX2SBUQ4grZrSHvkzZz0WczXwU=;
  b=l+MKTK8MCl+1PClNQ+2jpFRCsubxQ4evPK2RLaKCPRaoezJzZJHXHhU3
   f+WXAAKQx3E4mPFiOJVLb+hZ6G0jb8zDDiuxB5t/MsiNaTlvTIKSbMCX6
   tUvhx9QOOHqGk8U8SzCASerNarKHv+C59IVuRGXKZP3JEVsWBkst3qof9
   8dim9Gufj1W2dyD3wsvH7kOKVPCzL9pMKgUewDXBCch2kK27f0zI6NND1
   WLtntWj+9bJzI7QOfL78oGBDsRRFfQhjDE6R+7aMemMFg4Af6Rox0pzoJ
   0pGXzyO2cuxlGLE20FoV5wfEsp3tdzGOR+yZUrrBHGE5Z1s00h8QaOTz2
   A==;
X-CSE-ConnectionGUID: 1719QpZKSseavKbPGLuyCg==
X-CSE-MsgGUID: 5HdtUWfPQZms9OUmbRb2+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56071400"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56071400"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:53 -0800
X-CSE-ConnectionGUID: 3Hvwb+tbRcatBVEOowyDjg==
X-CSE-MsgGUID: QWGhmExSShG1/yS+xAr2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98202798"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:51 -0800
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
Subject: [PATCH v8 4/4] x86/smp native_play_dead: Prefer cpuidle_play_dead() over mwait_play_dead()
Date: Wed,  4 Dec 2024 15:08:28 +0100
Message-ID: <20241204140828.11699-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current algorithm* for looking up the mwait hint for the deepest
cstate, in mwait_play_dead_cpuid_hint() code works by inspecting CPUID
leaf 0x5 and calculates the mwait hint based on the number of reported
substates.  This approach depends on the hints associated with them to
be continuous in the range [0, NUM_SUBSTATES-1]. This continuity is not
documented and is not met on the recent Intel platforms.

 * The current algorithm is implemented in the for loop inspecting edx
   in mwait_play_dead_cpuid_hint().

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
on the CPUID leaf 0x5 in mwait_play_dead_cpuid_hint() and delegate
calling of the mwait_play_dead() to the idle driver.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


