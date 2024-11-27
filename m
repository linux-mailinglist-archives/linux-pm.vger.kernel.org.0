Return-Path: <linux-pm+bounces-18170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC29DAB9B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98524B2207B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302120102B;
	Wed, 27 Nov 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AryEQRAD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9E20102D;
	Wed, 27 Nov 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724163; cv=none; b=pbI0LpgZM/3X0d2538TUIdoZI1d3Pzo0qkJV4dyvIWqXgmBZZEiRcUZ4iWLjIJGmnh1dUV7hStTnJ8+lMaEmhmb02J6kIBOwbYN1f9ziU34lkceFvb/rGwBTZIEjs8D7xRM9snYvlpjDmhhKXOm5fTS21x280jEQ21m5IgfAl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724163; c=relaxed/simple;
	bh=PYqpZCevWBfW3JOxBGFkpqBiONfsytVyzZ/qS4X/H4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1TZRpH16Y1ICYE9fuOX3ci/piQTVPstdKD1eAGWNWmsv2FjageuTFU7od2/rDe15gO1oCPjoMwnRHYL/IZeaCgC9F7PLdp0qcHbhqoFqcSzNGX475z/2baGIn9vWrQig1S0nXdJwqFD3N1fqkpKQkRk1pDJOYCycDT4Q3udUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AryEQRAD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732724162; x=1764260162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PYqpZCevWBfW3JOxBGFkpqBiONfsytVyzZ/qS4X/H4A=;
  b=AryEQRADk0AldgPUMzpYj4zrBBJJPD2IhDPh/1elurCDCITFVYRZXFr0
   772Pl3EWigxDtIdugrtOluwGAVNvdorH7KPMFxKDK8r0xaikLzjDJDquO
   AufE+0sRY+LJtptT0CqSKAWrpyiLOCCHyb8A4CfHE0MGtqlfbyEAq8NMd
   EQzUvrqRRK5LhIS9B0PRZ+ccKOfuCOsjDxvoA2bu/IBUl4Ibbd2+GekJw
   V/79tsD8MW0lROMC34tVIheeA7/Nnv07+DZW5/uWWjEjvppNz3FJRpy20
   kYh0sswzHt4idOZJlAN3fl0bcNpKzS8FSCGAoTxCNen1n/f/upiaVRUu5
   A==;
X-CSE-ConnectionGUID: t/QIx1WyT7GPyckDhDAlUA==
X-CSE-MsgGUID: GHR7FPjgTDqGZZ6ME2x6XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43597616"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43597616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:16:02 -0800
X-CSE-ConnectionGUID: xlkeW29ESECfgn+xE2+GGA==
X-CSE-MsgGUID: Yc2wVOr2SHqL6cQMGBg7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97042476"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:58 -0800
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
Subject: [PATCH v6 4/4] x86/smp native_play_dead: Prefer cpuidle_play_dead() over mwait_play_dead()
Date: Wed, 27 Nov 2024 17:15:18 +0100
Message-ID: <20241127161518.432616-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
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
 arch/x86/kernel/smpboot.c | 52 +++------------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ef112143623d..704a1b1d650c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1317,52 +1317,6 @@ void __noreturn mwait_play_dead_with_hint(unsigned int eax_hint)
 	}
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead(void)
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
-	mwait_play_dead_with_hint(eax);
-}
-
 /*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
@@ -1413,9 +1367,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	/* Below returns only on error. */
+	cpuidle_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.47.1


