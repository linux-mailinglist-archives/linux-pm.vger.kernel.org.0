Return-Path: <linux-pm+bounces-15909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F739A2F2A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF98AB2275A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB552281C5;
	Thu, 17 Oct 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHWLRCFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51F227B91;
	Thu, 17 Oct 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199095; cv=none; b=jVPgyOxvZhqu4ZCeFcmIXTPTph9SgYbSSaPs9iIK3KGkhZtaIEr+NCOhMmeRQHIMOYy5kBByH00GVDCNxs0QoLMnCcOZIkyeDzpL1Fce1KMHqa1MYF8UIxyMpnoDFlr01CB0yzhcD7nhnquXjqsISA9AiiUgwkdl4/XMJJJjz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199095; c=relaxed/simple;
	bh=ifSjLEeJcf0CQL9jTYu2SjWEZoP+Rh4B8Dkve02ujTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwyMhzxvfUY98389DgXn9Q9p9LnrxlA4lz4jqICpsLi5cSMd3IOKnZ9rpvETxsXs736tlk+QQa8NtS8AEQCSsq26zoaPAVqBQdqmxWX31UwQKDAInbHBZ2YTWf+Dlxh2twuR24tsR1Uzzv4eecsK1vcSrfsLTt1dlBu8bFykfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHWLRCFU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729199091; x=1760735091;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ifSjLEeJcf0CQL9jTYu2SjWEZoP+Rh4B8Dkve02ujTc=;
  b=GHWLRCFULXZocI5hjuLJuG9+PBurZyZLaQGSa3qcVSxJQXY+82nxZy4L
   eROejfh75eAmZHbH0g306nuxy0QMjkH34EX+jIsJ56DiwDdn1/dNvo3yb
   4iEMdEKsC9kffsfgwC0wd3luy/bqv/WUzAU0bK1l7wdqB6/Ww24lgnfQy
   /YZWU1bkZ026fotdip4Ur30kMwVOFbJ2Fdr1KTol3MuTKqkOFvNbmHAYb
   BeBQBkODApUz0FNDVgondv87DYpcjmJPhhBT+nshduGdglmtkBmCOt9Cm
   Go1JMLuKcBivwOE2vLi5yr3o+dN+WWhMWXhN20h71CvgKmsaBNzo58Qm4
   Q==;
X-CSE-ConnectionGUID: Ep/0CoTTTG+7ql8wz/Jlxg==
X-CSE-MsgGUID: ZVFThjSPQ/upUkeAr6NhKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28810396"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28810396"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:04:44 -0700
X-CSE-ConnectionGUID: g1AWSfI0Q8eo5n52eSYpJw==
X-CSE-MsgGUID: +mcBxcJ+SvS2wpEEn5qovA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78340407"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.109.71])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:04:44 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rjw@rjwysocki.net,
	srinivas.pandruvada@linux.intel.com,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH V3 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion during suspend
Date: Thu, 17 Oct 2024 14:04:38 -0700
Message-ID: <20241017210439.3449324-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017210439.3449324-1-david.e.box@linux.intel.com>
References: <20241017210439.3449324-1-david.e.box@linux.intel.com>
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
V3 - Use s2idle wrapper function suggested by Rafael
   - Use on_each_cpu() suggested by Ricardo

V2 - Remove #define DEBUG
   - Move refactor of cnl_resume() to separate patch
   - Use smp_call_function() to disable and restore C1_AUTO_DEMOTE
   - Add comment that the MSR is per core, not per package.
   - Add comment that the online cpu mask remains unchanged during
     suspend due to frozen userspace.

 drivers/platform/x86/intel/pmc/cnp.c | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 513c02670c5a..3eaad2a7ebf4 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <linux/smp.h>
+#include <linux/suspend.h>
 #include "core.h"
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -206,8 +208,57 @@ const struct pmc_reg_map cnp_reg_map = {
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
+
+	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
+}
+
+static void restore_c1_auto_demote(void *unused)
+{
+	int cpunum = smp_processor_id();
+
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
+
+	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
+		 per_cpu(pkg_cst_config, cpunum));
+}
+
+static void s2idle_cpu_quirk(smp_call_func_t func)
+{
+	if (pm_suspend_via_firmware())
+		return;
+
+	on_each_cpu(func, NULL, true);
+}
+
 void cnl_suspend(struct pmc_dev *pmcdev)
 {
+	s2idle_cpu_quirk(disable_c1_auto_demote);
+
 	/*
 	 * Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. To unblock PC10 during suspend,
@@ -218,6 +269,8 @@ void cnl_suspend(struct pmc_dev *pmcdev)
 
 int cnl_resume(struct pmc_dev *pmcdev)
 {
+	s2idle_cpu_quirk(restore_c1_auto_demote);
+
 	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
 	return pmc_core_resume_common(pmcdev);
-- 
2.43.0


