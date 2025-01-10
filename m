Return-Path: <linux-pm+bounces-20203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E4A08FEE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BF23A8B68
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027720D51C;
	Fri, 10 Jan 2025 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrFvSn2Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B020DD60;
	Fri, 10 Jan 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510416; cv=none; b=jtNOAkWAlgTblpt88JO+SPr+VthOSRY6K+y/PPL6EsrIPimR3EfY1sEEzKww3dfQx8SPSxtEk6S6CLuaVQwHpjQ4frN7vJnuDp2V13yLDmwv2ICasQ0WtYgfCPLoRyVX/pNztNh7yxR0W2YH7E91ncFAGV3bvNCuL0fGxCN4VFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510416; c=relaxed/simple;
	bh=GIi58TM6+FpsZ0pnYE0p26iFqZ520DWOcuH5aLkD2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBh/8nsh3/30WWxnVGpT9NOBN7BnfwTpXeBgAS/MClaeP/TjtywSW+7qssOXZNYUapsWR6yxeXFI6PfQMzBC5B1hNtnZXTgYXX6TvKKwVCw+U6TUm3C+woi7GRo4iMiJwE6gBZ+hbQSSH6747xYNuVhTI+cskjafT3dpAfF+WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrFvSn2Z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736510414; x=1768046414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GIi58TM6+FpsZ0pnYE0p26iFqZ520DWOcuH5aLkD2Mw=;
  b=RrFvSn2ZWcCQ8MVEC6x856cp/FWdgsrH1TrYlxMGVwzBhjruzA/6n1gf
   8HZwbPqFIFrkpvegYVizjRTzHfKYII+0AcpYgyU7addM6qhNr6ZBFaXsQ
   qVBvVqOuLc6Dw957JBHUrpahS9jmFKNvVdJH78vsEg45rDq/NTK/fA5Pp
   0CwoXR6LVDTqkt7NiqzMyIQ32YoD+//z/Pit9KQx8xlKN06/kMpsi3qHo
   2Wad9NxZBtT0fu9he1fwBPBhE6r7U8vcqwtsKWtMlytKCMrer26u3crVi
   sDq+abUNgRYHScYZb5VVQTHPC5QvhbS1whjUUWFv1WR1HgMscDEnDNqeZ
   g==;
X-CSE-ConnectionGUID: uDJis4KZSD6vxraJeQRyCA==
X-CSE-MsgGUID: TOUUBQ39Qu+LpplooJ7v0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40743794"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40743794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:13 -0800
X-CSE-ConnectionGUID: uOkQVIpyQHe/jP/7LWS7KQ==
X-CSE-MsgGUID: sJGA//W6QDiwws2pH0QXhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108636062"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:11 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v9 4/4] x86/smp: Eliminate mwait_play_dead_cpuid_hint()
Date: Fri, 10 Jan 2025 12:59:53 +0100
Message-ID: <20250110115953.6058-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
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


