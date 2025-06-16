Return-Path: <linux-pm+bounces-28780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F836ADA801
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D731890D8E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC631DE4CE;
	Mon, 16 Jun 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwmZhY3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73631DDC28
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054344; cv=none; b=UUkuPoSWXpya8XshZ9nvk6gwcdBc7JeP/8CiunQCb6MXeu2q4O5AMcUCKeSNsSL8xjoP9RJCtryA2+qBN4T7RxWD47WOS+dW6LfC9W3l08pm9PX7AMf3n86ZvcObyYB68xxy0tGJ/eVzXhdAb6uxA8dvMCwFegNT1bqhOC5Ilvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054344; c=relaxed/simple;
	bh=rdDoT9o8aEDrsn0IPH5i+17nOpp4r0SmcM2NXDUFSkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azuYr11Wrk9T1xd0I/4XYkin5s/ECymSawXtAtHD4nclV8/2Xf5gQ4TJcI9v3Pns8TxM2jAxHDs0KGn/wEwslXzN8/tAKAVyy7fyd7xl3Z6Wg/y1Q9el5GCz5G778w1ioahsthyf9QoeYGg77ssWBHIvaAOW0V4KGdSeqflMZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwmZhY3W; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054342; x=1781590342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdDoT9o8aEDrsn0IPH5i+17nOpp4r0SmcM2NXDUFSkw=;
  b=lwmZhY3WqUW8nHGKdoCu/LsCrG/d/xJ88AkrUuaQmZj7eEhrDVqzRYqp
   oXkssQUp0TlxIIrYCFhA832x6RZOHbQ0sZo+Lb/eVPclDbL0RkvP0MY1R
   khqpy7RVmQkVQg5jE64F4Ie1wHlolM5QMexRJDuwGdeQRDMrpOsay+y4r
   n5s/UVAuor7F2NkTLrl0XIWA28FcEaV2DtYqw1f9Zn57aKCShZBxWxM2C
   AttSKH9s0qfJJPjGYLsti2N7tjRcuK2SoTAdTekQv4f24WWJVEwAlqIHK
   OsgB/GwJv4vj5Z/nJ1hHVGiO0EbobQZfvy2a7TGL5xM5Wcl5zyZowlIvq
   w==;
X-CSE-ConnectionGUID: bI+fDDOISOmVYrkRFyndTA==
X-CSE-MsgGUID: XvK/cvOXS06S75LezrAACA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278238"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278238"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:18 -0700
X-CSE-ConnectionGUID: 9Ld7Q7nXQR2LTSfmfHR3JQ==
X-CSE-MsgGUID: PucJCyZIRM6niIgms7xxGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928088"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:17 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1945F1213BF;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atQ-0w;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 2/6] pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
Date: Mon, 16 Jun 2025 09:12:08 +0300
Message-Id: <20250616061212.2286741-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
index 9dd2e4031a27..14ca7be96686 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -568,11 +568,13 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
 }
 
 /**
- * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
+ * pm_runtime_put_autosuspend - Update the last access time of a device, drop
+ * its usage counter and queue autosuspend if the usage counter becomes 0.
  * @dev: Target device.
  *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ * Update the last access time of @dev, decrement runtime PM usage counter of
+ * @dev and if it turns out to be equal to 0, queue up a work item for @dev like
+ * in pm_request_autosuspend().
  *
  * Return:
  * * 0: Success.
@@ -587,8 +589,8 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
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


