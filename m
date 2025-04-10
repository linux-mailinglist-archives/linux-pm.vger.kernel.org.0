Return-Path: <linux-pm+bounces-25129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED684A847FB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E713F4E01CF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB61EB1B9;
	Thu, 10 Apr 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKuccXxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E601EB196
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299088; cv=none; b=AO/wh6Wx7Vt0MzZzMmwo6zZnQQxAqEWYOixBQNxTTZG9MCZJhWZHPZ0OI/j+viAZ3XeOL6XMEjjQlpneBr0LUsK1azSJvVNXaR4JagPU+6T/d5UOuTuv/vG8rqM/uEwE43PAPo5BFpQ7fp7aLD8w5ByRvlLVJHr5TjnH0imeVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299088; c=relaxed/simple;
	bh=P2q7oJ8kkSTZ8ZGS2o+ImIQ1I1Z1Akao7ERZz0hEslk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YU6aBzpvFdYgtxFIEgB/8eJxnAVTmS9yEemiO0mU+Lx/VQ2kGnt5s86x5SdQTRK6ZawNcfnC+Y516DemHaEY2nUq/PqyBA0ZAKnx0lhYNCQEyo95Q9GrmmSGda3NBFNIYT+UePtuSu0K5rxkcUAWIy9+uUFzIBTu1Oyq4U5FwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKuccXxX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299087; x=1775835087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2q7oJ8kkSTZ8ZGS2o+ImIQ1I1Z1Akao7ERZz0hEslk=;
  b=AKuccXxX5wl7eHwe+ug0W93zVfVQYYK2hJHiodkNMrs3x8GVyhgUsVHH
   9Dq87lSbR0pfo9U11RQ7i4p2uVdLXlDjJPYfFFjJNdOKyA8uLmvGte6JE
   hz9xHoE6mmz34QVl95ZFvpb8iegmYxa5iHglEAthVpSLQQ3X2ASQCFxfF
   ISU//bUDsK0+G7GWR70mAbfyMafwhm6IxQmODmNXyZzWQaW/C1MZSOmP/
   bgbIx63ohWxp2zq0YQuMgtinrxsokTXxVZfH7AcE/O36bY+7eqUIzjY0Q
   9WlgCegl61yGwfvRkyrxZNuZiIUdmcR3qda+Zw6bZ+4NLuIS49R7KhIgZ
   A==;
X-CSE-ConnectionGUID: FlNNLVrIRPiH6dNybL9Qrg==
X-CSE-MsgGUID: xHp+PV79R1W8WIFDjkOCzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806973"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:24 -0700
X-CSE-ConnectionGUID: JuywFkVMTau72fpgR+3VGw==
X-CSE-MsgGUID: FD48RqVHSpOg99VDwCbHxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475390"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 59EE4120B55;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOe7-17;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 6/7] pm: runtime: Mark last busy stamp in pm_request_autosuspend()
Date: Thu, 10 Apr 2025 18:31:05 +0300
Message-Id: <20250410153106.4146265-7-sakari.ailus@linux.intel.com>
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
pm_request_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst | 6 +++---
 include/linux/pm_runtime.h         | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 39a0b62f6648..91bc93422262 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -354,9 +354,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       success or error code if the request has not been queued up
 
   `int pm_request_autosuspend(struct device *dev);`
-    - schedule the execution of the subsystem-level suspend callback for the
-      device when the autosuspend delay has expired; if the delay has already
-      expired then the work item is queued up immediately
+    - Call pm_runtime_mark_last_busy() and schedule the execution of the
+      subsystem-level suspend callback for the device when the autosuspend delay
+      expires
 
   `int pm_schedule_suspend(struct device *dev, unsigned int delay);`
     - schedule the execution of the subsystem-level suspend callback for the
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 3d12cfb0bf00..61ca98cd0aa2 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -444,11 +444,12 @@ static inline int pm_request_resume(struct device *dev)
 }
 
 /**
- * pm_request_autosuspend - Queue up autosuspend of a device.
+ * pm_request_autosuspend - Update the last access time and queue up autosuspend
+ * of a device.
  * @dev: Target device.
  *
- * Queue up a work item to run an equivalent pm_runtime_autosuspend() for @dev
- * asynchronously.
+ * Update the last access time of a device and queue up a work item to run an
+ * equivalent pm_runtime_autosuspend() for @dev asynchronously.
  *
  * Return:
  * * 0: Success.
@@ -463,6 +464,7 @@ static inline int pm_request_resume(struct device *dev)
  */
 static inline int pm_request_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
 }
 
-- 
2.39.5


