Return-Path: <linux-pm+bounces-25130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17696A847FC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D674E0346
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D51EB1BB;
	Thu, 10 Apr 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjGBo34O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46361E9B38
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299089; cv=none; b=kt0tDLdXPCqVuo7h+u8DqOhahWWpwEy1W879//l2RLp4o5NthipM1q2XkUIxXQfbn5EGHIdeJS5+uAoMzKFatG/oiBt0thiWYFhmv92Y8S+kUiieiRr8xv7G6Ci3X8bX+9pUg8LmrzaBHc3v4nlS7uIkLLsEQZThs2CjbNB5QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299089; c=relaxed/simple;
	bh=KTnOVxCx05kYnTiWbyfwazR+WvPKTbLzNbPbEMm2vws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvuFFnQqYb3YcF9Y3YQ5xsV7grupW303+fikUSxdna0kWVJG+pv7ZR1cCnbQFuZVrbOcmeugWKcHVuOSK7mAnQ0tU0Awi30mhN/8hHzlQgP3KXC9HyyjaoQiPGqqFpeR1vQnIjlyfdUhaE0Fn17Pgk615FI+jZFR2rMThG+Ye5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjGBo34O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299088; x=1775835088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTnOVxCx05kYnTiWbyfwazR+WvPKTbLzNbPbEMm2vws=;
  b=KjGBo34ObgbfQAzzA4W86IxEvc39O4Pl/jEVm5AgnioKLtxsXhUrs7u5
   iNjJdkkE7jvoA/awoMYIZNR0vb/kuh/tWzdkhAGYmFmol4yXBfrXAaGgG
   X8NtzoKr2Mh0yBWCnYR96CfznpWEdSmPuF5uEOSEAEkS0AUJZZcOGVUb5
   2EDBMXgTHoedMXoRNTBDGgkmyMOUGSZlg8VzgG6oEBmacCMx+fFYaLx3K
   Tocatp0Hl/kGbvapU1CvZHQwYIBGbdzzuf3LER61JUDGffJaigCY6IG0N
   NIENaGllPP78AW1FH8AlacAxPwYmG5OQjAIkaAwXmJo43zd3qPKyoW9Kt
   w==;
X-CSE-ConnectionGUID: n8L9LfBaS9KJJtsDtdHupw==
X-CSE-MsgGUID: WpCie+NoTDyKj1kyhp8ikg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806976"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806976"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:24 -0700
X-CSE-ConnectionGUID: oR1xRyJnQ9eEsGRUM/RNTQ==
X-CSE-MsgGUID: B/ukP4QVQ5mtHBrdKIbTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475393"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 54C1C12097D;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOe2-14;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 5/7] pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
Date: Thu, 10 Apr 2025 18:31:04 +0300
Message-Id: <20250410153106.4146265-6-sakari.ailus@linux.intel.com>
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
pm_runtime_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst | 15 ++++++---------
 include/linux/pm_runtime.h         |  9 ++++++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 9c21c913f9cf..39a0b62f6648 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -154,11 +154,9 @@ suspending the device are satisfied) and to queue up a suspend request for the
 device in that case.  If there is no idle callback, or if the callback returns
 0, then the PM core will attempt to carry out a runtime suspend of the device,
 also respecting devices configured for autosuspend.  In essence this means a
-call to pm_runtime_autosuspend() (do note that drivers needs to update the
-device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
-this circumstance).  To prevent this (for example, if the callback routine has
-started a delayed suspend), the routine must return a non-zero value.  Negative
-error return codes are ignored by the PM core.
+call to pm_runtime_autosuspend(). To prevent this (for example, if the callback
+routine has started a delayed suspend), the routine must return a non-zero
+value.  Negative error return codes are ignored by the PM core.
 
 The helper functions provided by the PM core, described in Section 4, guarantee
 that the following constraints are met with respect to runtime PM callbacks for
@@ -330,10 +328,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       'power.disable_depth' is different from 0
 
   `int pm_runtime_autosuspend(struct device *dev);`
-    - same as pm_runtime_suspend() except that the autosuspend delay is taken
-      `into account;` if pm_runtime_autosuspend_expiration() says the delay has
-      not yet expired then an autosuspend is scheduled for the appropriate time
-      and 0 is returned
+    - same as pm_runtime_suspend() except that a call to
+      pm_runtime_mark_last_busy() is made and an autosuspend is scheduled for
+      the appropriate time and 0 is returned
 
   `int pm_runtime_resume(struct device *dev);`
     - execute the subsystem-level resume callback for the device; returns 0 on
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index e26caf2c0552..3d12cfb0bf00 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -375,11 +375,13 @@ static inline int pm_runtime_suspend(struct device *dev)
 }
 
 /**
- * pm_runtime_autosuspend - Set up autosuspend of a device or suspend it.
+ * pm_runtime_autosuspend - Update the last access time and set up autosuspend
+ * of a device.
  * @dev: Target device.
  *
- * Set up autosuspend of @dev or suspend it (depending on whether or not
- * autosuspend is enabled for it) without engaging its "idle check" callback.
+ * First update the last access time, then set up autosuspend of @dev or suspend
+ * it (depending on whether or not autosuspend is enabled for it) without
+ * engaging its "idle check" callback.
  *
  * Return:
  * * 0: Success.
@@ -395,6 +397,7 @@ static inline int pm_runtime_suspend(struct device *dev)
  */
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_AUTO);
 }
 
-- 
2.39.5


