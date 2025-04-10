Return-Path: <linux-pm+bounces-25128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44AA847ED
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F06C1889FC5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1D1EB1AA;
	Thu, 10 Apr 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImbsUgGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC41EA7FE
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299087; cv=none; b=GDqgvT9vuRRAuNAm1hX9XGnA8aY7rBeYvOSUVEbebp5cakBg9XJLeCEx3qR9HGYtpmcpCksBRf9h+YBBOjs4oZN86W5c2Ld0cPob5NdmXcdqugCQzgZLGxyrk7t0X0DOxV5LOOJH/lQa5XCVhQhaO5vOxiDJbs8LntuoE6mCzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299087; c=relaxed/simple;
	bh=RjL9jykpiEQzFAVBKIHpYgL2jOPan1FiV3sq7SBZSdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkDzYyY9TkX0MduoQyFVjBMNiqwJwEz8Cm8uAWrV3UiNrpKOH4/krpj1DyGMt/Cm+0OrvNYKQzg3qmsrAPyyCNUy7YaXmELQ2Yog+bPVMhSOyIre66coZ1ulxRioJvuUwbyd20TA7uEMKdEZB5AjYeDwFIy3s45DNG30Q0Ue5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImbsUgGm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299086; x=1775835086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RjL9jykpiEQzFAVBKIHpYgL2jOPan1FiV3sq7SBZSdE=;
  b=ImbsUgGm+BpQjq2vwLgLaWTKuf3NESkTSkZNLapIBv2b/wiQpgPA+hEX
   qGmrij26EA2lLJ9dKIs3U3VAyBu5jiNWZEUa27eTgWxD8aMMtaaUHOkFX
   xBOpe/IrHPT3UGLU7iA4v4V7VQEaEoPahxBUVDfyamqq3IiXXZRnaNjLH
   3b8OYcB6mCR4WMt6ObvZlIwHJAR0EcD1cJTaAb/Xsx7zk9xYqSlTMSBDT
   0VLQ7bjw1kXNtVCRrsFHTAcf2cWXthqHUz6Dn6yTZDR1eTVD4ADNxox2C
   i6w80OcQD59OQwNEmk1BvwHCWnYVIo5qpSciVIrJBJCzWVzTB4dftcCz6
   Q==;
X-CSE-ConnectionGUID: V2eFienhR7i2w+YMR12tww==
X-CSE-MsgGUID: hrvQ92D1TjSE5dWpQsZivA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806962"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806962"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
X-CSE-ConnectionGUID: BovMagiESQ+FZuhdoFZVqQ==
X-CSE-MsgGUID: HjzrBfHaR56ukWc6vcpU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475364"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 513CC120739;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOdx-11;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 4/7] pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
Date: Thu, 10 Apr 2025 18:31:03 +0300
Message-Id: <20250410153106.4146265-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set device's last busy timestamp to current time in
pm_runtime_put_sync_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst |  3 ++-
 include/linux/pm_runtime.h         | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index e7bbdc66d64c..9c21c913f9cf 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -428,7 +428,8 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       pm_runtime_suspend(dev) and return its result
 
   `int pm_runtime_put_sync_autosuspend(struct device *dev);`
-    - decrement the device's usage counter; if the result is 0 then run
+    - set the power.last_busy field to the current time and decrement the
+      device's usage counter; if the result is 0 then run
       pm_runtime_autosuspend(dev) and return its result
 
   `void pm_runtime_enable(struct device *dev);`
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0ade3f75d903..e26caf2c0552 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -645,12 +645,14 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
 }
 
 /**
- * pm_runtime_put_sync_autosuspend - Drop device usage counter and autosuspend if 0.
+ * pm_runtime_put_sync_autosuspend - Update the last access time of a device,
+ * drop device usage counter and autosuspend if 0.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, set up autosuspend of @dev or suspend it synchronously (depending
- * on whether or not autosuspend has been enabled for it).
+ * Update the last access time of @dev, decrement the runtime PM usage counter
+ * of @dev and if it turns out to be equal to 0, set up autosuspend of @dev or
+ * suspend it synchronously (depending on whether or not autosuspend has been
+ * enabled for it).
  *
  * The runtime PM usage counter of @dev remains decremented in all cases, even
  * if it returns an error code.
@@ -670,6 +672,7 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  */
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
 }
 
-- 
2.39.5


