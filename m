Return-Path: <linux-pm+bounces-25125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C931A847FF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7423B617D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FA1EA7ED;
	Thu, 10 Apr 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8CiTUZp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAB1CB31D
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299086; cv=none; b=AEgh/Xg3Hp5nkDpGDtQ90o4rq4UI0FwBY2ym9REKVF01euRxtQFSeQ6vgJBUUuok5Y1mMBWXWUdCbulfFezavfghhThZUw/AeSDxhFL+H4zl55hq1oUknLrm52UMyxB1hpQO1Udb/Rmm+fva4E8ntiZ/gmkL2uFeSq/Nes28iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299086; c=relaxed/simple;
	bh=0hVVainr2nhsKp3QUAXNadUC4viN/joSKE5cBZjgp0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjIY0GMCOTbvhrgCJVvuDRE8gK4R6q+XVUeca4ao36BmAF15FAI9rMyq0AKO3tONu3k/ZT984rbmkbLS9miZnYfyFgkwQLDsKoXgzxI7OMk0VzQtRp4/Dqlb9RNrLzmnOtWSHFuZG1oEnhCkw8bDO2GHGanKaERzK/rhmDA3yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8CiTUZp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299085; x=1775835085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hVVainr2nhsKp3QUAXNadUC4viN/joSKE5cBZjgp0A=;
  b=Y8CiTUZpZkjQlikX2swFYu2M5xIWQ8LhXRi+21H5CB3uodZyk1o7Yeje
   mxnkvMvQqCbTE2uRKKPswWveNkVD9zK5yzEkEnSkA4z24rftH+lyNk7IW
   mZWScDcdvRaSFMxBW0bWGUhiKBEGqAPl/aFXyvDCDxcp9Jj7CcgfzV66Q
   mgA3fuQD8SS4k/SvMNLHweEbH4KYoYZMtUuKNcy4l7TGq2SVeIGuqa2Q1
   uEa3FAlkSBZWvCVpkmaVXKixBKkqif2V8Eqrm9XZahUxh1F430EWf8YC/
   8pbvyx2nxkZTehkJehMOHkKDbrMxTSCILQkNTHhao3uQ4oO/E4+Ws0I8l
   A==;
X-CSE-ConnectionGUID: y/GpDerDQHW8f2j6314o/w==
X-CSE-MsgGUID: NWJz8+4VQ36CONVAEH2R8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806955"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806955"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
X-CSE-ConnectionGUID: 4y+W5fiqRa2J0pIVi+YxZg==
X-CSE-MsgGUID: cEqZ8WWVSaa3vYQt9aUx4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475368"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4CFA61203B9;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOdq-0w;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 3/7] pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
Date: Thu, 10 Apr 2025 18:31:02 +0300
Message-Id: <20250410153106.4146265-4-sakari.ailus@linux.intel.com>
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
pm_runtime_put_autosuspend(). Callers wishing not to do that will need to
use __pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst | 23 ++++++++++-------------
 include/linux/pm_runtime.h         | 12 +++++++-----
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 63344bea8393..e7bbdc66d64c 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -411,8 +411,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       pm_request_idle(dev) and return its result
 
   `int pm_runtime_put_autosuspend(struct device *dev);`
-    - does the same as __pm_runtime_put_autosuspend() for now, but in the
-      future, will also call pm_runtime_mark_last_busy() as well, DO NOT USE!
+    - set the power.last_busy field to the current time and decrement the
+      device's usage counter; if the result is 0 then run
+      pm_request_autosuspend(dev) and return its result
 
   `int __pm_runtime_put_autosuspend(struct device *dev);`
     - decrement the device's usage counter; if the result is 0 then run
@@ -870,11 +871,9 @@ device is automatically suspended (the subsystem or driver still has to call
 the appropriate PM routines); rather it means that runtime suspends will
 automatically be delayed until the desired period of inactivity has elapsed.
 
-Inactivity is determined based on the power.last_busy field.  Drivers should
-call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
-typically just before calling __pm_runtime_put_autosuspend().  The desired
-length of the inactivity period is a matter of policy.  Subsystems can set this
-length initially by calling pm_runtime_set_autosuspend_delay(), but after device
+Inactivity is determined based on the power.last_busy field. The desired length
+of the inactivity period is a matter of policy.  Subsystems can set this length
+initially by calling pm_runtime_set_autosuspend_delay(), but after device
 registration the length should be controlled by user space, using the
 /sys/devices/.../power/autosuspend_delay_ms attribute.
 
@@ -885,7 +884,7 @@ instead of the non-autosuspend counterparts::
 
 	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
 	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
-	Instead of: pm_runtime_put        use: __pm_runtime_put_autosuspend;
+	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
 	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
 
 Drivers may also continue to use the non-autosuspend helper functions; they
@@ -922,12 +921,10 @@ Here is a schematic pseudo-code example::
 	foo_io_completion(struct foo_priv *foo, void *req)
 	{
 		lock(&foo->private_lock);
-		if (--foo->num_pending_requests == 0) {
-			pm_runtime_mark_last_busy(&foo->dev);
-			__pm_runtime_put_autosuspend(&foo->dev);
-		} else {
+		if (--foo->num_pending_requests == 0)
+			pm_runtime_put_autosuspend(&foo->dev);
+		else
 			foo_process_next_request(foo);
-		}
 		unlock(&foo->private_lock);
 		/* Send req result back to the user ... */
 	}
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 3e31cbebc527..0ade3f75d903 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -562,11 +562,13 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
 }
 
 /**
- * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
+ * pm_runtime_put_autosuspend - Update the last access time of a device, drop
+ * its usage counter and queue autosuspend if the usage counter becomes 0.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ * Update the last access time of @dev and decrement its runtime PM usage
+ * counter and if it turns out to be equal to 0, queue up a work item for @dev
+ * like in pm_request_autosuspend().
  *
  * Return:
  * * 0: Success.
@@ -581,8 +583,8 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
-	return __pm_runtime_suspend(dev,
-	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
+	pm_runtime_mark_last_busy(dev);
+	return __pm_runtime_put_autosuspend(dev);
 }
 
 /**
-- 
2.39.5


