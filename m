Return-Path: <linux-pm+bounces-15036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF298C87B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 00:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C23286630
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA671CF282;
	Tue,  1 Oct 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8FGKgXA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7C1CEEB5;
	Tue,  1 Oct 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823552; cv=none; b=d48wXTZwc0+ny71hCfxKX6d7OfyezRBHoqBWwJqxmpkgu+tJ1Z5ELL6cxx+g2hVWhk2YgyY3wO2zrXjlwnEu83ZWUuJqOcJvi+Kr6sDw5XoasTB+Tgwxb3/l7o0ugZLzIR9FOQFBYSH8sK24FMdqV+3vKLLFomAqxgr/u7LFq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823552; c=relaxed/simple;
	bh=YLAvbo/FGLUh/8VxvI6dGnsAo7AT/XO1bfUSzRiyZmo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RM2iM4R0XrrDYMelGSFQ3a9/uyri5boB87eBPxvionBtY93OEKYENeftRXXcViQaIRn1H40hQ7tbRnMPlOsCGf1h9dw445E72LBAodbzm/yooFAOOxDJbjXuFqAhMaflvij4SiceGG5YQ5QqTEGFvOoUJIMs29v1G8qWcDrCRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8FGKgXA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727823551; x=1759359551;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YLAvbo/FGLUh/8VxvI6dGnsAo7AT/XO1bfUSzRiyZmo=;
  b=B8FGKgXAovXDnKoYXwQSF6m6eRShtr5wqzEGmPxq1ZliLUL9d8kHmUv+
   KcrvForj+Niw0SDvt0sxGHH4gt1zmlq4LgcwE1Ed1M/T9T0rAL9L6UPwq
   AU+SFQs/h0WeYI1J2SR26oSySC6w4iN2oybvkrgN5lniUhBsEgIHkI7Ny
   PH82tfK/x9NVbDakuuL/4kBUufGMPZTbEYdVRuLLPuvgfNHsZdwBsMucZ
   ichYWyY9G7cRrtmmvVe5ZgUlYCMF8lQQ4D/5WlgdKD3eZBTkX6HBZQLhC
   XObW1+AO/5TXBUGbyib1fbSqPKi0h/oiz6IjS2lMoPmmNTDzyzy+cGDvo
   Q==;
X-CSE-ConnectionGUID: 6/89CwUFQDiGB75M/3F0Pw==
X-CSE-MsgGUID: 5YPkfJqLT7GkMt5j9w7GWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26936074"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26936074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 15:59:10 -0700
X-CSE-ConnectionGUID: T+UUANdXSumQyKOWMp8j1Q==
X-CSE-MsgGUID: 7XLDfa76S7mV3P/vzOuV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78576156"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.125.109.6])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 15:59:10 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rjw@rjwysocki.net
Subject: [PATCH] platform/x86/intel/pmc: Disable C1 auto-demotion during suspend
Date: Tue,  1 Oct 2024 15:58:59 -0700
Message-ID: <20241001225901.135564-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/platform/x86/intel/pmc/arl.c |  3 +--
 drivers/platform/x86/intel/pmc/cnp.c | 28 +++++++++++++++++++++++++++-
 drivers/platform/x86/intel/pmc/lnl.c |  3 +--
 drivers/platform/x86/intel/pmc/mtl.c |  3 +--
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index e10527c4e3e0..05dec4f5019f 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
 static int arl_resume(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int arl_core_init(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 513c02670c5a..5b8b3ac7f061 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -7,7 +7,8 @@
  * All Rights Reserved.
  *
  */
-
+#define DEBUG
+#include <linux/suspend.h>
 #include "core.h"
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -206,8 +207,24 @@ const struct pmc_reg_map cnp_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+
+static DEFINE_PER_CPU(u64, pkg_cst_config);
+
 void cnl_suspend(struct pmc_dev *pmcdev)
 {
+	if (!pm_suspend_via_firmware()) {
+		u64 val;
+		int cpunum;
+
+		for_each_online_cpu(cpunum) {
+			rdmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, &val);
+			per_cpu(pkg_cst_config, cpunum) = val;
+			val &= ~NHM_C1_AUTO_DEMOTE;
+			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, val);
+			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
+		}
+	}
+
 	/*
 	 * Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. To unblock PC10 during suspend,
@@ -220,6 +237,15 @@ int cnl_resume(struct pmc_dev *pmcdev)
 {
 	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
+	if (!pm_suspend_via_firmware()) {
+		int cpunum;
+
+		for_each_online_cpu(cpunum) {
+			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, per_cpu(pkg_cst_config, cpunum));
+			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
+		}
+	}
+
 	return pmc_core_resume_common(pmcdev);
 }
 
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index e7a8077d1a3e..be029f12cdf4 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
 static int lnl_resume(struct pmc_dev *pmcdev)
 {
 	lnl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int lnl_core_init(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 91f2fa728f5c..fc6a89b8979f 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
 static int mtl_resume(struct pmc_dev *pmcdev)
 {
 	mtl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int mtl_core_init(struct pmc_dev *pmcdev)
-- 
2.43.0


