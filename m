Return-Path: <linux-pm+bounces-21405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38134A294DF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 16:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E6A3AEE62
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F618E756;
	Wed,  5 Feb 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+tuCT/q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55018FDBD
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768869; cv=none; b=aJk4z5bQsjhHX2v2WS9At7y5Pji9A4qrvhK3hAz9Zg+s6M/aDMyy0oa7xkKpDZYtuIB833hjKJ4xSPqjfPHSjbh3YqH1lyUWNmptGV2uSQW0Dykec71w2iJKBjUK3H//WNaZ7zY6xatKAdj29wtHEg2UWiBqQwNpppgz4xuWqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768869; c=relaxed/simple;
	bh=lPtztsIzhTbtdknG3YE1TiZH4LIuiXEmHZsR47i++LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpaGfIqCxLl4uYaZiOg+j2ZOpMZlgx8b/xE2RqNXADg/HXlMvFC0EdlmDB9aWtWHs5L2kouAsgsxrO/vaEg8dLR5rwL/MYeqwDC32Y/hIBHJbtPKOmaYbzUKKJ5sien/VejOPRp7BK9x4b+BqPjW809bjRfJI7yD2iWTW0pEfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+tuCT/q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738768868; x=1770304868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPtztsIzhTbtdknG3YE1TiZH4LIuiXEmHZsR47i++LM=;
  b=b+tuCT/qJQXspHcBPvFKRed8P9v+rJRoJheiYnYbTSc/Ra4BzbhNukVr
   /GU6+eck4uS2Id84PBgN/1oqT2vQ/2k1z6UhgvYDcpc7tZfRpY+nxd7Ac
   tLvGEyMks5UK3TygzHM209rgCV6sgpA5fi7mjGWrUavAKyXGbNXHr4eH2
   scQlyPMSzb4ttgfahCGXbN7XTwzFo+jG724dgPmdRey4IlveafiTSz7fE
   jG5Daj2Bjawn68fM0DAyCzBv5Ki1Fiz8TVEsAmkxLdbPhSXSLlzU456Ea
   GIN9VHx4glCy/KQKyrnp/DWdaM29BK5U7Ao27RAEJh/Hv0cV/NrwUMM4W
   w==;
X-CSE-ConnectionGUID: BUAUqT5FRwOiolQE7ZIhaw==
X-CSE-MsgGUID: JIqO2fUWTGu5EuymH2rQbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39498173"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39498173"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:21:07 -0800
X-CSE-ConnectionGUID: MuJmap+kRF+b3MWxHpOMkQ==
X-CSE-MsgGUID: GIP8jcnMQfiBgIJkfVU7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="111109605"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2025 07:21:06 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: x86@kernel.org
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	dave.hansen@linux.intel.com
Subject: [PATCH v10 4/4] x86/smp: Eliminate mwait_play_dead_cpuid_hint()
Date: Wed,  5 Feb 2025 17:20:56 +0200
Message-ID: <20250205152057.171030-5-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
References: <20250205152057.171030-1-artem.bityutskiy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mwait_play_dead_cpuid_hint() looks up the MWAIT hint of the
deepest idle state by inspecting CPUID leaf 0x5 with the assumption
that, if the number of sub-states for a given major C-state is nonzero,
those sub-states are always represented by consecutive numbers starting
from 0. This assumption is not based on the documented platform behavior
and in fact it is not met on recent Intel platforms.

For example, Intel's Sierra Forest report two C-states with two
substates each in cpuid leaf 0x5:

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

   * Names of the cstates are not included in the CPUID leaf 0x5,
     they are taken from the product specific documentation.

Notice that hints 0x20 and 0x21 are not defined for C-state 0x20
(C6), so the existing MWAIT hint lookup in
mwait_play_dead_cpuid_hint() based on the CPUID leaf 0x5 contents does
not work in this case.

Instead of using MWAIT hint lookup that is not guaranteed to work,
make native_play_dead() rely on the idle driver for the given platform
to put CPUs going offline into appropriate idle state and, if that
fails, fall back to hlt_play_dead().

Accordingly, drop mwait_play_dead_cpuid_hint() altogether and make
native_play_dead() call cpuidle_play_dead() instead of it
unconditionally with the assumption that it will not return if it is
successful. Still, in case cpuidle_play_dead() fails, call
hlt_play_dead() at the end.

Based on patches from Patryk Wlazlyn <patryk.wlazlyn@gmail.com>.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 54 +++++----------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8aad14e43f54..5746084bafe4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1258,6 +1258,10 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1303,50 +1307,6 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
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
-
-	eax = CPUID_LEAF_MWAIT;
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
@@ -1397,9 +1357,9 @@ void native_play_dead(void)
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


