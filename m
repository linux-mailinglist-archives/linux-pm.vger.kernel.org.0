Return-Path: <linux-pm+bounces-14193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B3978634
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D755F1C21C9E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AC74418;
	Fri, 13 Sep 2024 16:51:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC047F4D
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246308; cv=none; b=KeDKjnbSouCaG7jC1X6UUqvz+MIW/W+3jQe7ufgJCYnKlvcXgY/fT+EM0zdUmiNuuVX53eunhlMA4GUWm/VLBqvZvLq4jSIU6HZR6iWYQtIRv9JAYy2MkXSLpO6DZzCXSHSRkNqaZH0al2PC6FsbrN0JlnxtpgUBdA6WG788fTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246308; c=relaxed/simple;
	bh=GtnJM9JCGvo4hjD385OoZYhWuuZ7KajA04WCkg16ubk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fa/IMLsQo/z3sVwSmIyLdVnzcpyxR7AL2OJ+44qX66ivF8Uv7asFYE/n3f5fHkk0hEns45o6MPvG68klEGvEQvLkNYtAKgnaCB19kE4uNJfnOR19+Q8Eqdexkohs9uFIqyl92jLjaeGqhEv92MbIKCAT9w/ylMj0vDdIQfF6FQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: g7RwmfVaSh6X12rMzBK0dg==
X-CSE-MsgGUID: bUOiaHWIQSeY7uij4VUwmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42663550"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="42663550"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:51:45 -0700
X-CSE-ConnectionGUID: Q0UV8dMYT0GS5P8bHjXegg==
X-CSE-MsgGUID: 9EJ/bu5BRWCbjLXLwG2nlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72489450"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa005.fm.intel.com with ESMTP; 13 Sep 2024 09:51:44 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] [PATCH] intel_idle: fix ACPI _CST matching for newer Xeon platforms
Date: Fri, 13 Sep 2024 19:51:43 +0300
Message-ID: <20240913165143.4140073-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Background
~~~~~~~~~~

The driver uses 'use_acpi = true' in C-state custom table for all Xeon
platforms. The meaning of this flag is as follows.

1. If a C-state from the custom table is defined in ACPI _CST (matched by the
   mwait hint), then enable this C-state.
2. Otherwise, disable this C-state, unless the C-sate definition in the
   custom table has the 'CPUIDLE_FLAG_ALWAYS_ENABLE' flag set, in which case
   enabled it.

The goal is to honor BIOS C6 settings - If BIOS disables C6, disable it by
default in the OS too (but it can be enabled via sysfs).

This works well on Xeons that expose only one flavor of C6. This are all Xeons
except for the newest Granite Rapids (GNR) and Sierra Forest (SRF).

The problem
~~~~~~~~~~~

GNR and SRF have 2 flavors of C6: C6/C6P on GNR, C6S/C6SP on SRF. The the "P"
flavor allows for the package C6, while the "non-P" flavor allows only for
core/module C6.

As far as this patch is concerned, both GNR and SRF platforms are handled the
same way. Therefore, further discussion is focused on GNR, but it applies to
SRF as well.

On Intel Xeon platforms, BIOS exposes only 2 ACPI C-states: C1 and C2. Well,
depending on BIOS settings, C2 may be named as C3. But there still will be only
2 states - C1 and C3. But this is a non-essential detail, so further discussion
is focused on the ACPI C1 and C2 case.

On pre-GNR/SRF Xeon platforms, ACPI C1 is mapped to C1 or C1E, and ACPI C2 is
mapped to C6. The 'use_acpi' flag works just fine:
* If ACPI C2 enabled, enable C6.
* Otherwise, disable C6.

However, on GNR there are 2 flavors of C6, so BIOS maps ACPI C2 to either C6 or
C6P, depending on the user settings. As a result, due to the 'use_acpi' flag,
'intel_idle' disables least one of the C6 flavors.

BIOS                   | OS                         | Verdict
----------------------------------------------------|---------
ACPI C2 disabled       | C6 disabled, C6P disabled  | OK
ACPI C2 mapped to C6   | C6 enabled,  C6P disabled  | Not OK
ACPI C2 mapped to C6P  | C6 disabled, C6P enabled   | Not OK

The goal of 'use_acpi' is to honor BIOS ACPI C2 disabled case, which works
fine. But if ACPI C2 is enabled, the goal is to enable all flavors of C6, not
just one of the flavors. This was overlooked when enabling GNR/SRF platforms.

In other words, before GNR/SRF, the ACPI C2 status was binary - enabled or
disabled. But it is not binary on GNR/SRF, however the goal is to continue
treat it as binary.

The fix
~~~~~~~

Notice, that current algorithm matches ACPI and custom table C-states by the
mwait hint. However, mwait hint consists of the 'state' and 'sub-state' parts,
and all C6 flavors have the same state value of 0x20, but a different sub-state
values.

Introduce new C-state table flag - CPUIDLE_FLAG_PARTIAL_HINT_MATCH and add it
to both C6 flavors of the GNR/SRF platforms.

When matching ACPI _CST and custom table C-states, match only the start part if
the C-state has CPUIDLE_FLAG_PARTIAL_HINT_MATCH, other wise match both state
and sub-state parts (as before).

With this fix, GNR C-states enabled/disabled status looks like this.

BIOS                   | OS
----------------------------------------------------
ACPI C2 disabled       | C6 disabled, C6P disabled
ACPI C2 mapped to C6   | C6 enabled, C6P enabled
ACPI C2 mapped to C6P  | C6 enabled, C6P enabled

Possible alternative
~~~~~~~~~~~~~~~~~~~~

The alternative would be to remove 'use_acpi' flag for GNR and SRF. This would
be a simpler solution, but it would violate the principle of least surprise -
users of Xeon platforms are used to the fact that intel_idle honors C6
enabled/disabled flag. It is more consistent user experience if GNR/SRF
continue doing so.

How tested
~~~~~~~~~~

Tested on GNR and SRF platform with all the 3 BIOS configurations: ACPI C2
disabled, mapped to C6/C6S, mapped to C6P/C6SP.

Tested on Ice lake Xeon and Sapphire Rapids Xeon platforms with ACPI C2 enabled
and disabled, just to verify that the patch does not break older Xeons.

Fixes: 92813fd5b156 ("intel_idle: add Sierra Forest SoC support")
Fixes: 370406bf5738 ("intel_idle: add Granite Rapids Xeon support")
Cc: stable@vger.kernel.org # 6.8+

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

Note, about:

  Fixes: 370406bf5738 ("intel_idle: add Granite Rapids Xeon support")

This patch is not in Lunus' tree yet, it is only in linux-pm. But I assume that
commit ID won't change.

Also, about Cc: stable: this patch won't cleanly apply, and I assume stable
maintainer contacts me and I'll help porting it.

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9457e34b9e32..67aebfe0fed6 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -120,6 +120,12 @@ static unsigned int mwait_substates __initdata;
  */
 #define CPUIDLE_FLAG_INIT_XSTATE	BIT(17)
 
+/*
+ * Ignore the sub-state when matching mwait hints between the ACPI _CST and
+ * custom tables.
+ */
+#define CPUIDLE_FLAG_PARTIAL_HINT_MATCH	BIT(18)
+
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
@@ -1043,7 +1049,8 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
-					   CPUIDLE_FLAG_INIT_XSTATE,
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 170,
 		.target_residency = 650,
 		.enter = &intel_idle,
@@ -1052,7 +1059,8 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.name = "C6P",
 		.desc = "MWAIT 0x21",
 		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED |
-					   CPUIDLE_FLAG_INIT_XSTATE,
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 210,
 		.target_residency = 1000,
 		.enter = &intel_idle,
@@ -1354,7 +1362,8 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x22",
-		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 270,
 		.target_residency = 700,
 		.enter = &intel_idle,
@@ -1362,7 +1371,8 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 	{
 		.name = "C6SP",
 		.desc = "MWAIT 0x23",
-		.flags = MWAIT2flg(0x23) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x23) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 310,
 		.target_residency = 900,
 		.enter = &intel_idle,
@@ -1744,7 +1754,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 	}
 }
 
-static bool __init intel_idle_off_by_default(u32 mwait_hint)
+static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 {
 	int cstate, limit;
 
@@ -1761,7 +1771,15 @@ static bool __init intel_idle_off_by_default(u32 mwait_hint)
 	 * the interesting states are ACPI_CSTATE_FFH.
 	 */
 	for (cstate = 1; cstate < limit; cstate++) {
-		if (acpi_state_table.states[cstate].address == mwait_hint)
+		u32 acpi_hint = acpi_state_table.states[cstate].address;
+		u32 table_hint = mwait_hint;
+
+		if (flags & CPUIDLE_FLAG_PARTIAL_HINT_MATCH) {
+			acpi_hint &= ~MWAIT_SUBSTATE_MASK;
+			table_hint &= ~MWAIT_SUBSTATE_MASK;
+		}
+
+		if (acpi_hint == table_hint)
 			return false;
 	}
 	return true;
@@ -1771,7 +1789,10 @@ static bool __init intel_idle_off_by_default(u32 mwait_hint)
 
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
-static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
+static inline bool intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
+{
+	return false;
+}
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
 /**
@@ -2098,7 +2119,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
-		     intel_idle_off_by_default(mwait_hint) &&
+		     intel_idle_off_by_default(state->flags, mwait_hint) &&
 		     !(state->flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			state->flags |= CPUIDLE_FLAG_OFF;
 
-- 
2.43.1


