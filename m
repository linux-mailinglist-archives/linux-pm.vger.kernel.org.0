Return-Path: <linux-pm+bounces-15512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E082999815
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3740B281979
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE44C96;
	Fri, 11 Oct 2024 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdkRLejR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5C10F9;
	Fri, 11 Oct 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607009; cv=none; b=GpNq5MwiBSM3lESfIjCJyKxywwjrngIHKmKdlQN1EXHbqX9JQywDoBZ4yICnDVmA6TjjU0oO9VhGeChTeLZ0rZq/YPW8dtsswwbCO2s4Rf7ESR0GSdJL7YT+UR6byo4zCeV2A2LKzv15IIUKzyF2U8kiphDdHRN8t8iDzWZXPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607009; c=relaxed/simple;
	bh=Z6CVqcG557SUWaq/QGPMxq8yHGcM0g/bHCQmbZdBjf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnnkIAY03/WjdopfIXpRm6v+vNzvrvb2J3vmZsZFa4d0JRzCn46cR1KCei5ytWxnV0+GAZysOeI/paVKbKRBAx2tTjItxQAcBg9b71ld9IiUpEZtpuO1zaoDriXgX/JfD1BPsSjX8if0L8Pfx5hnfskCrC9qXAvRs1AYdbsSRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdkRLejR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728607007; x=1760143007;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Z6CVqcG557SUWaq/QGPMxq8yHGcM0g/bHCQmbZdBjf0=;
  b=fdkRLejRPfZKYfePYsq2ugpgr82ahLqtR4cImTXYsA8m+7pn98o8mh8g
   Wrz49M/VFbiwtRGBCjRvKZuKBcfaLwO0KJhQd0BF/VD90lC4fnh1AnUxg
   W+xVLijot5d5AEOhPxiXPtRS/W7qHl2eY3p65093dh5N9XX/IfqYRuLw7
   o69s0HfnA4OO54wanfPMtpGrZ5NnVMtLdvStjKBSymGsn302lneBdHGZV
   h25+u0xiogTfcvvtAkn8ozjEgoR55aE3emnYjr0ysWLwyONX0WMAEZW4u
   VUzz1erRfUJIM+/1N9rY6DzageyYwyOEVVztmyat3gKh7wmNEKTgullvk
   Q==;
X-CSE-ConnectionGUID: Va2oUk2vTJSAJiXx/XrYCg==
X-CSE-MsgGUID: 6fMN9eTmStWHvv6CmNBXiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="50535457"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="50535457"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:36:45 -0700
X-CSE-ConnectionGUID: 3VHoaaQbTSam826OQ4wNuw==
X-CSE-MsgGUID: bFSnIXywRKyRKlq5jo8OYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76399770"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:36:45 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rjw@rjwysocki.net,
	srinivas.pandruvada@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion during suspend
Date: Thu, 10 Oct 2024 17:36:39 -0700
Message-ID: <20241011003640.1613812-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011003640.1613812-1-david.e.box@linux.intel.com>
References: <20241011003640.1613812-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some platforms, aggressive C1 auto-demotion may lead to failure to enter
the deepest C-state during suspend-to-idle, causing high power consumption.
To prevent this, disable C1 auto-demotion during suspend and re-enable on
resume.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Remove #define DEBUG
   - Move refactor of cnl_resume() to separate patch
   - Use smp_call_function() to disable and restore C1_AUTO_DEMOTE
   - Add comment that the MSR is per core, not per package.
   - Add comment that the online cpu mask remains unchanged during
     suspend due to frozen userspace.

 drivers/platform/x86/intel/pmc/cnp.c | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 513c02670c5a..f12d4f0f9e93 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <linux/smp.h>
+#include <linux/suspend.h>
 #include "core.h"
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -206,8 +208,52 @@ const struct pmc_reg_map cnp_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+
+/*
+ * Disable C1 auto-demotion
+ *
+ * Aggressive C1 auto-demotion may lead to failure to enter the deepest C-state
+ * during suspend-to-idle, causing high power consumption. To prevent this, we
+ * disable C1 auto-demotion during suspend and re-enable on resume.
+ *
+ * Note that, although MSR_PKG_CST_CONFIG_CONTROL has 'package' in its name, it
+ * is actually a per-core MSR on client platforms, affecting only a single CPU.
+ * Therefore, it must be configured on all online CPUs. The online cpu mask is
+ * unchanged during the phase of suspend/resume as user space is frozen.
+ */
+
+static DEFINE_PER_CPU(u64, pkg_cst_config);
+
+static void disable_c1_auto_demote(void *unused)
+{
+	int cpunum = smp_processor_id();
+	u64 val;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	per_cpu(pkg_cst_config, cpunum) = val;
+	val &= ~NHM_C1_AUTO_DEMOTE;
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
+	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
+}
+
+static void restore_c1_auto_demote(void *unused)
+{
+	int cpunum = smp_processor_id();
+
+	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
+		 per_cpu(pkg_cst_config, cpunum));
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
+}
+
 void cnl_suspend(struct pmc_dev *pmcdev)
 {
+	if (!pm_suspend_via_firmware()) {
+		preempt_disable();
+		disable_c1_auto_demote(NULL);
+		smp_call_function(disable_c1_auto_demote, NULL, 0);
+		preempt_enable();
+	}
+
 	/*
 	 * Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. To unblock PC10 during suspend,
@@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
 
 int cnl_resume(struct pmc_dev *pmcdev)
 {
+	if (!pm_suspend_via_firmware()) {
+		preempt_disable();
+		restore_c1_auto_demote(NULL);
+		smp_call_function(restore_c1_auto_demote, NULL, 0);
+		preempt_enable();
+	}
+
 	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
 	return pmc_core_resume_common(pmcdev);
-- 
2.43.0


