Return-Path: <linux-pm+bounces-38326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32CC76B47
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 01:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 267814E4978
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBF84A35;
	Fri, 21 Nov 2025 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdgWgY1X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8753A7;
	Fri, 21 Nov 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763683637; cv=none; b=H+Q2fG/xjlhVFZEc6DG8Sp6GeYELpq1cuFgBes/FwVy1FQ4TQ5KSQeBe/0rGN+/mj9DkmX5F1hi227VezVudQnnOgHQotyf1JJZNxESY1NQKoL1bglZqe+6npORC+ODNgKTdQCSQnoE1ETrrMpDuY74YqwUtIz41EJStBMSMzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763683637; c=relaxed/simple;
	bh=8oEpnrmPSP/iBxmGTp1aTA/w6REbpuatbjXx3z8yL5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnVmU1bllB4gDPaGf2DnsymdRMNhASGQYyJ7fLm/4zn/085ZbOutRm+wtQNex5sytyckM8e4PMG1kYpZJ0eQorCMmr1If++4t2n7g/DDfAuqcSGWHbmsLY6T4tnq9jrE3pjKDddeLSg84rMf8XkIll6UbwGvPhM0iaA58up5aB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdgWgY1X; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763683635; x=1795219635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8oEpnrmPSP/iBxmGTp1aTA/w6REbpuatbjXx3z8yL5A=;
  b=DdgWgY1X0hOXfuiZhVGTUSOSDoSxJYztBAwNh7PblwSBoVzsvjG9USsf
   bRuMEosPPN1oGk3NvBPg4t8iOZLiDRdyMxR0VRqoMdgJGxqxFcqadMumj
   +fZgaYucfSo0lek45YXYtB5/YyJs2h86PJPRdITYtXfEehUhkqKGqOjEn
   ObnDLoqubBDj7TKWiSCYFCmLF0nr/kCAeJL6lRBRfTKhp6OatdXagcZpw
   cRw8dIQZ+u+BkC1wbLEM+r8g/9qW/kwfCltiuG3f1jnFzjTI8D2eaNk5G
   ixwxL1rxjlDXR8CBJfuVwnqHWSpxun/8fYUiGLs0n4wFE4xZn9uzVdOAC
   Q==;
X-CSE-ConnectionGUID: ZmnRS16QRASRKawX/fAGzg==
X-CSE-MsgGUID: c+sqdR+GRiCVM0j8aE9LuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65718693"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65718693"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
X-CSE-ConnectionGUID: OffC2RVXTqu/saUJO0w22A==
X-CSE-MsgGUID: 1HOXfi94TCCCcAzFWs9hPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="192298641"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:07:12 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] powercap: intel_rapl: Enable MSR-based RAPL PMU support
Date: Thu, 20 Nov 2025 16:05:39 -0800
Message-ID: <20251121000539.386069-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, RAPL PMU support requires adding CPU model entries to
arch/x86/events/rapl.c for each new generation. However, RAPL MSRs are
not architectural and require platform-specific customization, making
arch/x86 an inappropriate location for this functionality.

The powercap subsystem already handles RAPL functionality and is the
natural place to consolidate all RAPL features. The powercap RAPL
driver already includes PMU support for TPMI-based RAPL interfaces,
making it straightforward to extend this support to MSR-based RAPL
interfaces as well.

This consolidation eliminates the need to maintain RAPL support in
multiple subsystems and provides a unified approach for both TPMI and
MSR-based RAPL implementations.

The MSR-based PMU support includes the following updates:

1. Register MSR-based PMU support for the supported platforms
   and unregister it when no online CPUs remain in the package.
2. Remove existing checks that restrict RAPL PMU support to TPMI-based
   interfaces and extend the logic to allow MSR-based RAPL interfaces.
   atomic-safe MSR reads when invoked from PMU event handlers
3. Define a CPU model list to determine which processors should
   register RAPL PMU interface through the powercap driver for
   MSR-based RAPL, excluding those that support TPMI interface.
   This list prevents conflicts with existing arch/x86 PMU code
   that already registers RAPL PMU for some processors. Add
   Panther Lake & Wildcat Lake to the CPU models list.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 12 ++++++------
 drivers/powercap/intel_rapl_msr.c    | 24 ++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 066779460bc8..03979d32aa34 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1594,11 +1594,11 @@ static int get_pmu_cpu(struct rapl_package *rp)
 	if (!rp->has_pmu)
 		return nr_cpu_ids;
 
-	/* Only TPMI RAPL is supported for now */
-	if (rp->priv->type != RAPL_IF_TPMI)
+	/* Only TPMI & MSR RAPL are supported for now */
+	if (rp->priv->type != RAPL_IF_TPMI && rp->priv->type != RAPL_IF_MSR)
 		return nr_cpu_ids;
 
-	/* TPMI RAPL uses any CPU in the package for PMU */
+	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
 	for_each_online_cpu(cpu)
 		if (topology_physical_package_id(cpu) == rp->id)
 			return cpu;
@@ -1611,11 +1611,11 @@ static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
 	if (!rp->has_pmu)
 		return false;
 
-	/* Only TPMI RAPL is supported for now */
-	if (rp->priv->type != RAPL_IF_TPMI)
+	/* Only TPMI & MSR RAPL are supported for now */
+	if (rp->priv->type != RAPL_IF_TPMI && rp->priv->type != RAPL_IF_MSR)
 		return false;
 
-	/* TPMI RAPL uses any CPU in the package for PMU */
+	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
 	return topology_physical_package_id(cpu) == rp->id;
 }
 
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 46b716ea45b2..15660c6ea5a7 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -33,6 +33,8 @@
 /* private data for RAPL MSR Interface */
 static struct rapl_if_priv *rapl_msr_priv;
 
+static bool rapl_msr_pmu __ro_after_init;
+
 static struct rapl_if_priv rapl_msr_priv_intel = {
 	.type = RAPL_IF_MSR,
 	.reg_unit.msr = MSR_RAPL_POWER_UNIT,
@@ -79,6 +81,8 @@ static int rapl_cpu_online(unsigned int cpu)
 		rp = rapl_add_package_cpuslocked(cpu, rapl_msr_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
+		if (rapl_msr_pmu)
+			rapl_package_add_pmu(rp);
 	}
 	cpumask_set_cpu(cpu, &rp->cpumask);
 	return 0;
@@ -95,10 +99,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
-	if (lead_cpu >= nr_cpu_ids)
+	if (lead_cpu >= nr_cpu_ids) {
+		if (rapl_msr_pmu)
+			rapl_package_remove_pmu(rp);
 		rapl_remove_package_cpuslocked(rp);
-	else if (rp->lead_cpu == cpu)
+	} else if (rp->lead_cpu == cpu) {
 		rp->lead_cpu = lead_cpu;
+	}
+
 	return 0;
 }
 
@@ -168,6 +176,13 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	{}
 };
 
+/* List of MSR-based RAPL PMU support CPUs */
+static const struct x86_cpu_id pmu_support_ids[] = {
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
+	{}
+};
+
 static int rapl_msr_probe(struct platform_device *pdev)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
@@ -195,6 +210,11 @@ static int rapl_msr_probe(struct platform_device *pdev)
 		pr_info("PL4 support detected.\n");
 	}
 
+	if (x86_match_cpu(pmu_support_ids)) {
+		rapl_msr_pmu = true;
+		pr_info("MSR-based RAPL PMU support enabled\n");
+	}
+
 	rapl_msr_priv->control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
 	if (IS_ERR(rapl_msr_priv->control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
-- 
2.43.0


