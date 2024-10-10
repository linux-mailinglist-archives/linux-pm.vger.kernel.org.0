Return-Path: <linux-pm+bounces-15459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB4998803
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0741B2887E3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E71CC89F;
	Thu, 10 Oct 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt8YJueX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F641CC88A;
	Thu, 10 Oct 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567621; cv=none; b=ruUa2Al3uk3s8m+PocWa1B31GAhkhQw7f4jM7SmDSH3FarjoYv4dEiLKEAkYMVoqgDcc75WuC+GsCf+ioU1luPAxVVoNJgS4BdICV96eZ6FkIniMyKcVyGXmFJr+BW5NVG+YZgCBWGHmdCdAvqDstXtEkwSeGA0rutrdfmOJIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567621; c=relaxed/simple;
	bh=WJOwR/xQjLOCKg4FKEHRuSanrdMdmq2lEyKpsUMDSKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFELP4QXuekebSCqg6TwnF6NPiHzzBQVTOhO4rNqD6JLOzuKBIHWumJqgINy4+qvnzchGDB7lB83NPz8BQmRYYU7lUTXOyTEgx9NC66PTtZePrZ5+LwPFKxbbt4VvtJE4T/v+pJjuAlgSmYmdcKxu01Doc4fmj1Hx0cDrOVtYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt8YJueX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728567620; x=1760103620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJOwR/xQjLOCKg4FKEHRuSanrdMdmq2lEyKpsUMDSKc=;
  b=Bt8YJueX+AslhybrWc5mbmQNSIFveJjff0Jm/Z9Z0/v1I/tsAsLTCGGJ
   05yBZ4OQ1PoiF981JeTa/6CumGyKCM2GM6g4rMsUoD96MmVSemPsrfCva
   Gtlthfbj7Mk3X6LrDTZA/gsAFvedfHGemsxyWhtjaKhkWPRCHEGA6yDbe
   vNKe5r/7ToKSt9T3w20V//hyhDZnVVIqyyeF/l5QuvlKqfb9PQJgz+o6/
   m2LCc/OzHrmOu0/h3/bxwFbASegIb/8SErXJ6BXGzOuJN0GzDl41eHato
   +AOuJJl4Tlt2D5dv0to8f272re3cc0+LSnUhl7mhaXoqPROQ3JDvW5b27
   A==;
X-CSE-ConnectionGUID: 2PpAgoCcTJeFa9mfKn+G7Q==
X-CSE-MsgGUID: Vi9Lo3ByRxaYKMB3x/zJ6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31718286"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31718286"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:20 -0700
X-CSE-ConnectionGUID: VSbU31+FQhq7B+wX5SMroA==
X-CSE-MsgGUID: 0O/cs4lwQYmOVw/cwvQrcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81114934"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.12])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:16 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH 3/3] intel_idle: Identify the deepest cstate for cpu offline code
Date: Thu, 10 Oct 2024 15:39:55 +0200
Message-ID: <20241010133955.7749-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010133955.7749-1-patryk.wlazlyn@linux.intel.com>
References: <20241010133955.7749-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some platforms, for example Sierra Forest, the mwait hints for
subsequent idle states are not continuous, resulting in play_dead() code
not computing the most optimized idle state when CPU is put offline.
This in turn prevents from entering PC6 state when any of the CPUs in
the package is offline. Force the known, best mwait hint for the deepest
cstate.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 drivers/idle/intel_idle.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae9..d0b4b231d9ad 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -48,6 +48,7 @@
 #include <trace/events/power.h>
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
+#include <linux/smp.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
@@ -1645,6 +1646,7 @@ static bool __init intel_idle_acpi_cst_extract(void)
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
+	unsigned int mwait_hint_deepest = 0;
 
 	/*
 	 * If limit > 0, intel_idle_cst_usable() has returned 'true', so all of
@@ -1678,6 +1680,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->target_residency *= 3;
 
 		state->flags = MWAIT2flg(cx->address);
+		mwait_hint_deepest = cx->address;
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
@@ -1690,6 +1693,9 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
+
+	if (mwait_hint_deepest)
+		smp_set_mwait_play_dead_hint(mwait_hint_deepest);
 }
 
 static bool __init intel_idle_off_by_default(u32 mwait_hint)
@@ -1988,6 +1994,7 @@ static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
+	unsigned int mwait_hint_deepest = 0;
 	int cstate;
 
 	switch (boot_cpu_data.x86_vfm) {
@@ -2037,6 +2044,8 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		if (!intel_idle_verify_cstate(mwait_hint))
 			continue;
 
+		mwait_hint_deepest = mwait_hint;
+
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 		state = &drv->states[drv->state_count];
@@ -2060,6 +2069,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
 		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
 	}
+
+	if (mwait_hint_deepest)
+		smp_set_mwait_play_dead_hint(mwait_hint_deepest);
 }
 
 /**
-- 
2.46.2


