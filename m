Return-Path: <linux-pm+bounces-28777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9CADA7FF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C63AEE65
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE931C2335;
	Mon, 16 Jun 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG4GqCu9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D22594
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054341; cv=none; b=ImK+fDDGLzvOqsqmOYIQSMuf0NOiaz+GRGw852yzZMULsebvmK4U49rCml/tTUL+f6vWPqZAl4usPh32BCcQx3bfU9/CNUJN0+AY5ov5inDH+DDum/fOkTP/X9NlXry8BL70nM16MfM7JbKajh1X/lZaC73XXteI8NAY7SZEZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054341; c=relaxed/simple;
	bh=xLHSA7BUhwIwix+ZOV3mdVpnvWKLsgjUXxJbr7KMiq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eku0UUXj733x7XKCgMOpI5a7+IUCsQSjYBs8+amjcCXmleftSUJZNjCGY6U9LHjoXAaQkRk8zLicC+oIwfHwosxcSViFnzTRBzbv1Wd7dtEVOAu7C4mzbXQADvloHkmHpLnTRNVIkyPtQkcCwBTI5r3y93sYjMYi7jFm9yttoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG4GqCu9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054338; x=1781590338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLHSA7BUhwIwix+ZOV3mdVpnvWKLsgjUXxJbr7KMiq8=;
  b=fG4GqCu9z6kIQVAI9jAuJpf4Av+QJDduO0RGD7GqzeiDvv5s70MZgm+U
   Y40vNwoTy1ydIPqI6MMnixBu34VAY5K1ZRaQ7aSUiGgTNvJYqEjTysoh4
   bkmM/L6kaeblu5Smr5HIN5NEzbLxJh0qrE4z36hd8iPC+iQrRVy1MhHP3
   K89yMk47Nqlxs/01yNTebAKHZfTUO2IvtbQOeHblH0YnfbLxOPJ43Bbbb
   kbWehMrh4j/9+4E90W4viH5EtFCxUG2xTiozk/5pY+2yPJQxu3e5TWPof
   DeVlRJz/xsMLHsWCy5vi4borQZZP2Z3Vtv+bnywBVQMXxuW078xf7px0r
   Q==;
X-CSE-ConnectionGUID: 5x+8W/mUSjSz07hJnpWoTw==
X-CSE-MsgGUID: nkgP74KJThmQpx58OhFpfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278226"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:18 -0700
X-CSE-ConnectionGUID: HaaeR6cUQAWYYIZ/5cGFDw==
X-CSE-MsgGUID: 6LUAZpckTl2iBHRhcLX/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928079"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:17 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1BF5512214D;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atY-14;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 4/6] pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
Date: Mon, 16 Jun 2025 09:12:10 +0300
Message-Id: <20250616061212.2286741-5-sakari.ailus@linux.intel.com>
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
pm_runtime_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
index 3a0d5f0ea471..566a07b60f63 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -379,11 +379,13 @@ static inline int pm_runtime_suspend(struct device *dev)
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
@@ -399,6 +401,7 @@ static inline int pm_runtime_suspend(struct device *dev)
  */
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_AUTO);
 }
 
-- 
2.39.5


