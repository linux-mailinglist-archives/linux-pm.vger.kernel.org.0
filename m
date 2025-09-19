Return-Path: <linux-pm+bounces-35029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58EEB89877
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC28C623166
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B51487E9;
	Fri, 19 Sep 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL4zGo7v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090278F26
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285982; cv=none; b=hcHPdWhVREaCNwbHcEYlu1IKWBxaFwwGvlSU4I+vt2oY53fwn0JYODJSRRXluJ7YPaz+lCDg75uF7xC2iD6Mr83epIhaBoMIJ3TYt3luf66jln6+2D9y9cvYJlf7A5DckC/T0hE4iryBc2TTS0C6zwj47/QzqD0PbOuxw6Fpp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285982; c=relaxed/simple;
	bh=aQEgwSY13ekEp5mp2iQW3WTm+DikfSHP74nHINR53GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvQwFvnoDiQf4+auwuzOljrTxF6+U7W9kvITzeeldGXldnAd+001hupIf7wSOaqm+cM35BHr5rqcosOisvnrym7Bkr6QkTH8J7ulqR76oDLW0Qi6RScSa6RMw1aQoIQ+aoz3cRgIXspWmqEdPRu9ldG32T6dTQgpSked5bIe9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TL4zGo7v; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758285980; x=1789821980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aQEgwSY13ekEp5mp2iQW3WTm+DikfSHP74nHINR53GI=;
  b=TL4zGo7v2qcr1zyb7c7t5O8NH5yN0L9xR7G72Ojh+C3HulUQHelAoYpA
   X7Tz2cC36QrTuKK7DRFrhiI3xor6ZuWxuaN8MNHG0BgC7gkbLYEm/759i
   lsF6zt43bK/dqXTsOqig/Hwe+GcI4WREcR3FZ1C8QPxeljjAQQisChFmy
   1FNZDXSY0vFTR6aNdclhe2wsbUug6eeW8w6jL/IKKpEIMesgDTSHEOZRx
   X3ju4zyZ/AHBNOd0LuFr9xeEbQck9YWt6TUHuyNxmJGJ3JOf9k97PB36y
   lqgFwtWmneTrf8p57G5Xoj2OsE98PqCwXJ2Wz/Fgjm5K/NbTfFWlsETLc
   Q==;
X-CSE-ConnectionGUID: jrHgmhVZR0eaClmtnnHTeA==
X-CSE-MsgGUID: ptvnDGlMTme9uRnlNNnbdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59672359"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="59672359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 05:46:19 -0700
X-CSE-ConnectionGUID: K6qvEDgDQ++ODbKv4qsdxw==
X-CSE-MsgGUID: wgFIDcBHTH+jgFkE7iIvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175083537"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa010.jf.intel.com with ESMTP; 19 Sep 2025 05:46:17 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM: Introduce CALL_PM_OP macro to reduce code duplication
Date: Fri, 19 Sep 2025 18:14:37 +0530
Message-Id: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CALL_PM_OP macro to eliminate repetitive code patterns in power
management generic operations. Replace identical driver PM callback
invocation logic across all pm_generic_* functions with a single
macro that handles the NULL pointer checks and function calls.

This reduces code duplication significantly while maintaining the
same functionality and improving code maintainability.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/base/power/generic_ops.c | 85 ++++++++++----------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 6502720bb564..c4fc802b8c65 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -8,6 +8,13 @@
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
 
+#define CALL_PM_OP(dev, op) \
+({ \
+struct device *_dev = (dev); \
+const struct dev_pm_ops *pm = _dev->driver ? _dev->driver->pm : NULL; \
+pm && pm->op ? pm->op(_dev) : 0; \
+})
+
 #ifdef CONFIG_PM
 /**
  * pm_generic_runtime_suspend - Generic runtime suspend callback for subsystems.
@@ -19,12 +26,7 @@
  */
 int pm_generic_runtime_suspend(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
-
-	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
-
-	return ret;
+	return CALL_PM_OP(dev, runtime_suspend);
 }
 EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
 
@@ -38,12 +40,7 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
  */
 int pm_generic_runtime_resume(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
-
-	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
-
-	return ret;
+	return CALL_PM_OP(dev, runtime_resume);
 }
 EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
 #endif /* CONFIG_PM */
@@ -72,9 +69,7 @@ int pm_generic_prepare(struct device *dev)
  */
 int pm_generic_suspend_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend_noirq ? pm->suspend_noirq(dev) : 0;
+	return CALL_PM_OP(dev, suspend_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
 
@@ -84,9 +79,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
  */
 int pm_generic_suspend_late(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend_late ? pm->suspend_late(dev) : 0;
+	return CALL_PM_OP(dev, suspend_late);
 }
 EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
 
@@ -96,9 +89,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
  */
 int pm_generic_suspend(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->suspend ? pm->suspend(dev) : 0;
+	return CALL_PM_OP(dev, suspend);
 }
 EXPORT_SYMBOL_GPL(pm_generic_suspend);
 
@@ -108,9 +99,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend);
  */
 int pm_generic_freeze_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->freeze_noirq ? pm->freeze_noirq(dev) : 0;
+	return CALL_PM_OP(dev, freeze_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
 
@@ -120,9 +109,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
  */
 int pm_generic_freeze(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->freeze ? pm->freeze(dev) : 0;
+	return CALL_PM_OP(dev, freeze);
 }
 EXPORT_SYMBOL_GPL(pm_generic_freeze);
 
@@ -132,9 +119,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze);
  */
 int pm_generic_poweroff_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff_noirq ? pm->poweroff_noirq(dev) : 0;
+	return CALL_PM_OP(dev, poweroff_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
 
@@ -144,9 +129,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
  */
 int pm_generic_poweroff_late(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff_late ? pm->poweroff_late(dev) : 0;
+	return CALL_PM_OP(dev, poweroff_late);
 }
 EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
 
@@ -156,9 +139,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
  */
 int pm_generic_poweroff(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->poweroff ? pm->poweroff(dev) : 0;
+	return CALL_PM_OP(dev, poweroff);
 }
 EXPORT_SYMBOL_GPL(pm_generic_poweroff);
 
@@ -168,9 +149,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff);
  */
 int pm_generic_thaw_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->thaw_noirq ? pm->thaw_noirq(dev) : 0;
+	return CALL_PM_OP(dev, thaw_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
 
@@ -180,9 +159,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
  */
 int pm_generic_thaw(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->thaw ? pm->thaw(dev) : 0;
+	return CALL_PM_OP(dev, thaw);
 }
 EXPORT_SYMBOL_GPL(pm_generic_thaw);
 
@@ -192,9 +169,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw);
  */
 int pm_generic_resume_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume_noirq ? pm->resume_noirq(dev) : 0;
+	return CALL_PM_OP(dev, resume_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
 
@@ -204,9 +179,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
  */
 int pm_generic_resume_early(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume_early ? pm->resume_early(dev) : 0;
+	return CALL_PM_OP(dev, resume_early);
 }
 EXPORT_SYMBOL_GPL(pm_generic_resume_early);
 
@@ -216,9 +189,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_early);
  */
 int pm_generic_resume(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->resume ? pm->resume(dev) : 0;
+	return CALL_PM_OP(dev, resume);
 }
 EXPORT_SYMBOL_GPL(pm_generic_resume);
 
@@ -228,9 +199,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume);
  */
 int pm_generic_restore_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore_noirq ? pm->restore_noirq(dev) : 0;
+	return CALL_PM_OP(dev, restore_noirq);
 }
 EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
 
@@ -240,9 +209,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
  */
 int pm_generic_restore_early(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore_early ? pm->restore_early(dev) : 0;
+	return CALL_PM_OP(dev, restore_early);
 }
 EXPORT_SYMBOL_GPL(pm_generic_restore_early);
 
@@ -252,9 +219,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_early);
  */
 int pm_generic_restore(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	return pm && pm->restore ? pm->restore(dev) : 0;
+	return CALL_PM_OP(dev, restore);
 }
 EXPORT_SYMBOL_GPL(pm_generic_restore);
 
-- 
2.34.1


