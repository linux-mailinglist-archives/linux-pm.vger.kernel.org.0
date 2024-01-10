Return-Path: <linux-pm+bounces-2062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C416B829A5E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 13:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB18282FE3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA9482C4;
	Wed, 10 Jan 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg3eZODC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFA481D3
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704889444; x=1736425444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HFZ2IUol6I+RG6PAFryIqM8H/UALV0K8+U2a36pXjkc=;
  b=Lg3eZODCQZvcPMdRkZwS2+QRddkM5jZWadueNrU9A39NL5gOUiraNEdM
   8oUCuwY2IfyLCrNEFPafX3M9eCgNbbHJoeY5GvVtH2VO3WVsA5RHghksC
   SxQ5SpAVwZ8sy+h9r0nvC6zrhW9+EgcTO3RRj81qih4Ug9tcGZ5SAYE8i
   DYQOAaFjCJd5ekLK9lMI2J8NnH2Y4yawAvQngQTgSDNQ1X+5Y4QJFIDfI
   mX+tFF7x/fk8vnlpp/ISCP+AW/1kGuwMMoE15aupGqXFBUXzcC3I9mnpH
   U2w3ekWg/idOKJwyzfCQ2DQ6cdWDqR6WYTxPaD8FKRGGI91wegfCAytpS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5249656"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5249656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 04:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="925625215"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925625215"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 04:24:00 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C271D12080F;
	Wed, 10 Jan 2024 14:23:57 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 2/2] pm: runtime: Add pm_runtime_put_autosuspend() replacement
Date: Wed, 10 Jan 2024 14:23:56 +0200
Message-Id: <20240110122356.142997-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
References: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __pm_runtime_put_autosuspend() that replaces
pm_runtime_put_autosuspend() for new users. The intent is to later
re-purpose pm_runtime_put_autosuspend() to also mark the device's last
busy stamp---which is what the vast majority of users actually need.

This is also described in pm_runtime_put_autosuspend() documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/power/runtime_pm.rst | 17 +++++++++++------
 include/linux/pm_runtime.h         | 12 ++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index da99379071a4..6fa50e4f87ce 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -154,7 +154,7 @@ suspending the device are satisfied) and to queue up a suspend request for the
 device in that case.  If there is no idle callback, or if the callback returns
 0, then the PM core will attempt to carry out a runtime suspend of the device,
 also respecting devices configured for autosuspend.  In essence this means a
-call to pm_runtime_autosuspend() (do note that drivers needs to update the
+call to __pm_runtime_autosuspend() (do note that drivers needs to update the
 device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
 this circumstance).  To prevent this (for example, if the callback routine has
 started a delayed suspend), the routine must return a non-zero value.  Negative
@@ -409,6 +409,10 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       pm_request_idle(dev) and return its result
 
   `int pm_runtime_put_autosuspend(struct device *dev);`
+    - does the same as __pm_runtime_put_autosuspend() for now, but in the
+      future, will also call pm_runtime_mark_last_busy() as well, DO NOT USE!
+
+  `int __pm_runtime_put_autosuspend(struct device *dev);`
     - decrement the device's usage counter; if the result is 0 then run
       pm_request_autosuspend(dev) and return its result
 
@@ -539,6 +543,7 @@ It is safe to execute the following helper functions from interrupt context:
 - pm_runtime_put_noidle()
 - pm_runtime_put()
 - pm_runtime_put_autosuspend()
+- __pm_runtime_put_autosuspend()
 - pm_runtime_enable()
 - pm_suspend_ignore_children()
 - pm_runtime_set_active()
@@ -864,9 +869,9 @@ automatically be delayed until the desired period of inactivity has elapsed.
 
 Inactivity is determined based on the power.last_busy field.  Drivers should
 call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
-typically just before calling pm_runtime_put_autosuspend().  The desired length
-of the inactivity period is a matter of policy.  Subsystems can set this length
-initially by calling pm_runtime_set_autosuspend_delay(), but after device
+typically just before calling __pm_runtime_put_autosuspend().  The desired
+length of the inactivity period is a matter of policy.  Subsystems can set this
+length initially by calling pm_runtime_set_autosuspend_delay(), but after device
 registration the length should be controlled by user space, using the
 /sys/devices/.../power/autosuspend_delay_ms attribute.
 
@@ -877,7 +882,7 @@ instead of the non-autosuspend counterparts::
 
 	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
 	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
-	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
+	Instead of: pm_runtime_put        use: __pm_runtime_put_autosuspend;
 	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
 
 Drivers may also continue to use the non-autosuspend helper functions; they
@@ -916,7 +921,7 @@ Here is a schematic pseudo-code example::
 		lock(&foo->private_lock);
 		if (--foo->num_pending_requests == 0) {
 			pm_runtime_mark_last_busy(&foo->dev);
-			pm_runtime_put_autosuspend(&foo->dev);
+			__pm_runtime_put_autosuspend(&foo->dev);
 		} else {
 			foo_process_next_request(foo);
 		}
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index a212b3008ade..fc6d95b09570 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -482,6 +482,18 @@ static inline int pm_runtime_put(struct device *dev)
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+/**
+ * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ */
+static inline int __pm_runtime_put_autosuspend(struct device *dev)
+{
+	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
+}
+
 /**
  * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.
-- 
2.39.2


