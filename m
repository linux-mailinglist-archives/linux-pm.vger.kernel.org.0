Return-Path: <linux-pm+bounces-16656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B712A9B4683
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B7228445D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1D204F74;
	Tue, 29 Oct 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaQ7G7hl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D91204F8C;
	Tue, 29 Oct 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196945; cv=none; b=hR4Q87yybbWPKjFEMPtSk+COEM+6PT+sYYNRXjVTsKhJCM95Q5bMNvZh6Ec1z/WMYtL5NfFfpvx+bDYyE5DeF4wwvGm01IS2h5E5RWBu82bHBMjnMK4w8J8g6irz8dGh40CiAtTD2I998tSYmTK4tk2Gf3Xtt2r1dyffMVwsCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196945; c=relaxed/simple;
	bh=dmw0Ev6NtbB/FrIq42ORgnyR9QmIFlVVce4TvduxG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrANWmSfTPj0dlzVxyxOETfSnBHFXjYnhQU3nlKt5XYZGBCjU3LchF/L2rw3Cq14fYAKe7ScG6YdUBqAHlEIl7uYS6tApgrKR4/mUIBgGjHUlHui2WLyLSTVRzRc/nSKm7hVnnCjklx5n3Uzs+8UF5tPKe4ob5nmrnSK9k87J7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaQ7G7hl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196943; x=1761732943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dmw0Ev6NtbB/FrIq42ORgnyR9QmIFlVVce4TvduxG+g=;
  b=jaQ7G7hlBjZTZPpKhAsp0w5A4iQLm0MJO1KbJDuuXUv+wvldcAYzPhTG
   ndiFVKh2TFRybnYweBP1tHqe26ktutAOeFtgOn7k4rDKbGXI3yAYdryAy
   SkPff8xkyTmtFTYTyiBYVUeISnAa6NLY2j1OgT6KYajt89UM74NvlVeV5
   rfBIBKDsjpDmm5ohdc/x1GGeE5kYENaH9sE8pQnEFMcrpeauhcW3xS3kf
   bW2NTVmRe1hfeLCSSHzNwJ0fOGTtWTESp957EQd6uKIWmjNJ/qfvvqOpi
   2CMMtSO9Xp67mkGLAw27Kxz/ozuHZ93WgBqnMslIxCHBYOZWO7RtriaSQ
   Q==;
X-CSE-ConnectionGUID: 6K+agIx4S6uMQXChcrX39g==
X-CSE-MsgGUID: ffQ/TM6tQuSDpIVFBK5ldA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33624108"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33624108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:43 -0700
X-CSE-ConnectionGUID: CEPBl2zgSeWoyY9s+cA2+Q==
X-CSE-MsgGUID: XlYl3EZjTuG6WOSaeZHizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="119375299"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:40 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v2 3/3] intel_idle: Identify the deepest cstate for SRF
Date: Tue, 29 Oct 2024 11:15:07 +0100
Message-ID: <20241029101507.7188-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sierra Forest the mwait hints for subsequent idle states are not
continuous, resulting in play_dead() code not computing the most
optimized idle state when CPU is put offline. This in turn prevents from
entering PC6 state when any of the CPUs in the package is offline.
Force the known, best mwait hint for the deepest cstate.

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
2.47.0


