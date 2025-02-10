Return-Path: <linux-pm+bounces-21651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA486A2E535
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82272162C2F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4811A2622;
	Mon, 10 Feb 2025 07:12:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7E130E58
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739171578; cv=none; b=nRLoI+84p4qcZ4yJRMLtxEkDYBxWLUvYL9wVSnNb00POZyDSdw/g2DYdFMDxaCSpTEJYTI7/D9vbB2IplL39RZrJuD8s+g3t1llTm8JVPg107MVaWO/Jhp259FtrF7Y7nt3NcrerwQvlhDc7CYkSAJJAuTYcV3bBl9GATKA7ZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739171578; c=relaxed/simple;
	bh=+0YVdGEHTSADgE6t4aBp9DBgOd+FdZfGkbsaG3cBKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbUZkJuqeuQTKkDyeMTC8IgMqnNmLzWjtbK8UkHFqfiw8OAdbeyBdhqjbut7E59Ho5mZf1n02ZFC1cppNFUbQwmcLT66Sr5w8VRTzF7ESKMgO0qi34sX6+dfIjk5rdxap2QzoDreVRtZYL9V8XPZyFAOlE/Kd/0nPqFxUB2t+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: jWKh9jXTTEOf19WLUWLaeQ==
X-CSE-MsgGUID: hf3rPdMGTH6X7dvMQk5DxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38972178"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="38972178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:12:56 -0800
X-CSE-ConnectionGUID: A9ewnuPSTLGdfTHtKR7xkA==
X-CSE-MsgGUID: Ag5bdkihTGmBvp+UeT1OTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112047392"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa006.jf.intel.com with ESMTP; 09 Feb 2025 23:12:55 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: cleanup BYT/CHT auto demotion disable
Date: Mon, 10 Feb 2025 09:12:53 +0200
Message-ID: <20250210071253.2991030-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Bay Trail (BYT) and Cherry Trail (CHT) platforms have a very specific way
of disabling auto-demotion via specific MSR bits. Clean up the code so that
BYT/CHT-specifics do not show up in the common 'struct idle_cpu' data
structure.

Remove the 'byt_auto_demotion_disable_flag' flag from 'struct idle_cpu',
because a better coding pattern is to avoid very case-specific fields like
'bool byt_auto_demotion_disable_flag' in a common data structure, which is
used for all platforms, not only BYT/CHT. The code is just more readable
when common data structures contain only commonly used fields.

Instead, match BYT/CHT in the 'intel_idle_init_cstates_icpu()' function,
and introduce a small helper to take care of BYT/CHT auto-demotion. This
is consistent with how platform-specific things are done for other
platforms.

No intended functional changes, compile-tested only.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..324814dc34fa 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -89,7 +89,6 @@ struct idle_cpu {
 	 * Indicate which enable bits to clear here.
 	 */
 	unsigned long auto_demotion_disable_flags;
-	bool byt_auto_demotion_disable_flag;
 	bool disable_promotion_to_c1e;
 	bool use_acpi;
 };
@@ -1463,13 +1462,11 @@ static const struct idle_cpu idle_cpu_snx __initconst = {
 static const struct idle_cpu idle_cpu_byt __initconst = {
 	.state_table = byt_cstates,
 	.disable_promotion_to_c1e = true,
-	.byt_auto_demotion_disable_flag = true,
 };
 
 static const struct idle_cpu idle_cpu_cht __initconst = {
 	.state_table = cht_cstates,
 	.disable_promotion_to_c1e = true,
-	.byt_auto_demotion_disable_flag = true,
 };
 
 static const struct idle_cpu idle_cpu_ivb __initconst = {
@@ -2055,6 +2052,15 @@ static void __init spr_idle_state_table_update(void)
 	}
 }
 
+/**
+ * byt_cht_auto_demotion_disable - Disable Bay/Cherry Trail auto-demotion.
+ */
+static void __init byt_cht_auto_demotion_disable(void)
+{
+	wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
+	wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
+}
+
 static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 {
 	unsigned int mwait_cstate = (MWAIT_HINT2CSTATE(mwait_hint) + 1) &
@@ -2136,6 +2142,10 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_ATOM_GRACEMONT:
 		adl_idle_state_table_update();
 		break;
+	case INTEL_ATOM_SILVERMONT:
+	case INTEL_ATOM_AIRMONT:
+		byt_cht_auto_demotion_disable();
+		break;
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
@@ -2178,11 +2188,6 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 
 		drv->state_count++;
 	}
-
-	if (icpu->byt_auto_demotion_disable_flag) {
-		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
-		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
-	}
 }
 
 /**
-- 
2.47.1


