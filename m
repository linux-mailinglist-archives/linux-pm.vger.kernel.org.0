Return-Path: <linux-pm+bounces-36038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93072BD7DCD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4606042370A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837F29BD81;
	Tue, 14 Oct 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPfR8hp9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBF1DFDA1
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426643; cv=none; b=oO+gSLeu6dz/lJyRgVgtC08lkVJrm6AhGZR8gD660GTffC4jClm/MTTbol657kZHtnwwOdrUjFI0f1r9aRoXVjJZK5p0uqjRdlAAbnW3ba1a0M17NvJ2axk1B3N6btA960kgrVpBuM+fn2NRpgg9P7RmTW0n9ahp81I0gjSohmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426643; c=relaxed/simple;
	bh=dCeGMIWFFgRa+BuEYZOjyOHxmMDW9aUD7u7cnpbaFrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cidv3kL9MYp+JQfo5k0fBcRDDBhQD5PDC6wehOqDkTFkp6PbH17MzZG5NwQ8CZm3ZzfKVoGhRDEijlpw/fxGNdRxcAB9jwoBG4bEXDeW0Q4FpkjwKE53j6S7gXW/KXuzxFfLT1ozEBsRAx8rwbpxvA8gdAZpoQkWLl2rT6pDJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPfR8hp9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760426641; x=1791962641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dCeGMIWFFgRa+BuEYZOjyOHxmMDW9aUD7u7cnpbaFrk=;
  b=GPfR8hp96qHlGpdoFea/oPf07T2N3ubuLkx2uEngE1QLDRdxLv+3gshB
   x+yZO9eCL2jnLeMVObvXEsB2xW1nCY4g5oKw7lheCQnwCHEh/ZZxwWSMD
   0j0rH71oT+SLC5tI6pNunYCL70TVIty1+GgvRAU/Dt6Z9CGJ4c5axpyE/
   cHSgN94hI5KPf6pzXSqPNDp0P2I8fZXzGlyOTl/tKVMXl1zvpxiP/PDf1
   Y460vwTiiT6Y4olNy7Iwa0WewdTX49BLaClN9viURPRIQmQn0sw9PUOF0
   fYDe4PzAAviHqQNGFodlg+e50htKqTx9Pp2A7EEeikWRPmj+ofBJTqXcN
   A==;
X-CSE-ConnectionGUID: hkJJCt0eRsCsdP6XCmO2dA==
X-CSE-MsgGUID: JScC81cpTAGQyQbfJMkPSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61788281"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="61788281"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:24:00 -0700
X-CSE-ConnectionGUID: lpmpSTGhTnKFWBl7F7L0Eg==
X-CSE-MsgGUID: YHhRwlVpS8yL7sb9hGB98w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="186221815"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 14 Oct 2025 00:23:59 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] PM: Introduce DEFINE_PM_GENERIC_FUNC macro to reduce code duplication
Date: Tue, 14 Oct 2025 12:52:03 +0530
Message-Id: <20251014072203.979292-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DEFINE_PM_GENERIC_FUNC macro to completely eliminate repetitive
code patterns in power management generic operations. This macro
generates the entire function definition including signature,
implementation, and symbol export for each pm_generic_* function.

This reduces code duplication significantly while maintaining the
same functionality and improving code maintainability.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Include function signature and symbol export in macro as suggested
---
 drivers/base/power/generic_ops.c | 158 +++++--------------------------
 1 file changed, 26 insertions(+), 132 deletions(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 6502720bb564..0afea5d8f8ef 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -8,6 +8,14 @@
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
 
+#define DEFINE_PM_GENERIC_FUNC(func_name, op_name) \
+int pm_generic_##func_name(struct device *dev) \
+{ \
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL; \
+	return pm && pm->op_name ? pm->op_name(dev) : 0; \
+} \
+EXPORT_SYMBOL_GPL(pm_generic_##func_name)
+
 #ifdef CONFIG_PM
 /**
  * pm_generic_runtime_suspend - Generic runtime suspend callback for subsystems.
@@ -17,16 +25,7 @@
  * ->runtime_suspend(), execute it and return its error code.  Otherwise,
  * return 0.
  */
-int pm_generic_runtime_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
-
-	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
+DEFINE_PM_GENERIC_FUNC(runtime_suspend, runtime_suspend);
 
 /**
  * pm_generic_runtime_resume - Generic runtime resume callback for subsystems.
@@ -36,16 +35,7 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
  * ->runtime_resume(), execute it and return its error code.  Otherwise,
  * return 0.
  */
-int pm_generic_runtime_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
-
-	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
+DEFINE_PM_GENERIC_FUNC(runtime_resume, runtime_resume);
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
@@ -70,193 +60,97 @@ int pm_generic_prepare(struct device *dev)
  * pm_generic_suspend_noirq - Generic suspend_noirq callback for subsystems.
  * @dev: Device to suspend.
  */
-int pm_generic_suspend_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend_noirq ? pm->suspend_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
+DEFINE_PM_GENERIC_FUNC(suspend_noirq, suspend_noirq);
 
 /**
  * pm_generic_suspend_late - Generic suspend_late callback for subsystems.
  * @dev: Device to suspend.
  */
-int pm_generic_suspend_late(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend_late ? pm->suspend_late(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
+DEFINE_PM_GENERIC_FUNC(suspend_late, suspend_late);
 
 /**
  * pm_generic_suspend - Generic suspend callback for subsystems.
  * @dev: Device to suspend.
  */
-int pm_generic_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend ? pm->suspend(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_suspend);
+DEFINE_PM_GENERIC_FUNC(suspend, suspend);
 
 /**
  * pm_generic_freeze_noirq - Generic freeze_noirq callback for subsystems.
  * @dev: Device to freeze.
  */
-int pm_generic_freeze_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->freeze_noirq ? pm->freeze_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
+DEFINE_PM_GENERIC_FUNC(freeze_noirq, freeze_noirq);
 
 /**
  * pm_generic_freeze - Generic freeze callback for subsystems.
  * @dev: Device to freeze.
  */
-int pm_generic_freeze(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->freeze ? pm->freeze(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_freeze);
+DEFINE_PM_GENERIC_FUNC(freeze, freeze);
 
 /**
  * pm_generic_poweroff_noirq - Generic poweroff_noirq callback for subsystems.
  * @dev: Device to handle.
  */
-int pm_generic_poweroff_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff_noirq ? pm->poweroff_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
+DEFINE_PM_GENERIC_FUNC(poweroff_noirq, poweroff_noirq);
 
 /**
  * pm_generic_poweroff_late - Generic poweroff_late callback for subsystems.
  * @dev: Device to handle.
  */
-int pm_generic_poweroff_late(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff_late ? pm->poweroff_late(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
+DEFINE_PM_GENERIC_FUNC(poweroff_late, poweroff_late);
 
 /**
  * pm_generic_poweroff - Generic poweroff callback for subsystems.
  * @dev: Device to handle.
  */
-int pm_generic_poweroff(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff ? pm->poweroff(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_poweroff);
+DEFINE_PM_GENERIC_FUNC(poweroff, poweroff);
 
 /**
  * pm_generic_thaw_noirq - Generic thaw_noirq callback for subsystems.
  * @dev: Device to thaw.
  */
-int pm_generic_thaw_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->thaw_noirq ? pm->thaw_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
+DEFINE_PM_GENERIC_FUNC(thaw_noirq, thaw_noirq);
 
 /**
  * pm_generic_thaw - Generic thaw callback for subsystems.
  * @dev: Device to thaw.
  */
-int pm_generic_thaw(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->thaw ? pm->thaw(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_thaw);
+DEFINE_PM_GENERIC_FUNC(thaw, thaw);
 
 /**
  * pm_generic_resume_noirq - Generic resume_noirq callback for subsystems.
  * @dev: Device to resume.
  */
-int pm_generic_resume_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume_noirq ? pm->resume_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
+DEFINE_PM_GENERIC_FUNC(resume_noirq, resume_noirq);
 
 /**
  * pm_generic_resume_early - Generic resume_early callback for subsystems.
  * @dev: Device to resume.
  */
-int pm_generic_resume_early(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume_early ? pm->resume_early(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_resume_early);
+DEFINE_PM_GENERIC_FUNC(resume_early, resume_early);
 
 /**
  * pm_generic_resume - Generic resume callback for subsystems.
  * @dev: Device to resume.
  */
-int pm_generic_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume ? pm->resume(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_resume);
+DEFINE_PM_GENERIC_FUNC(resume, resume);
 
 /**
  * pm_generic_restore_noirq - Generic restore_noirq callback for subsystems.
  * @dev: Device to restore.
  */
-int pm_generic_restore_noirq(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore_noirq ? pm->restore_noirq(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
+DEFINE_PM_GENERIC_FUNC(restore_noirq, restore_noirq);
 
 /**
  * pm_generic_restore_early - Generic restore_early callback for subsystems.
  * @dev: Device to resume.
  */
-int pm_generic_restore_early(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore_early ? pm->restore_early(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_restore_early);
+DEFINE_PM_GENERIC_FUNC(restore_early, restore_early);
 
 /**
  * pm_generic_restore - Generic restore callback for subsystems.
  * @dev: Device to restore.
  */
-int pm_generic_restore(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore ? pm->restore(dev) : 0;
-}
-EXPORT_SYMBOL_GPL(pm_generic_restore);
+DEFINE_PM_GENERIC_FUNC(restore, restore);
 
 /**
  * pm_generic_complete - Generic routine completing a device power transition.
-- 
2.34.1


