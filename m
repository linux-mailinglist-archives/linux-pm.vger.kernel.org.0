Return-Path: <linux-pm+bounces-28783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA965ADA805
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E941890CFB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6289F1DE3BB;
	Mon, 16 Jun 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsJgRSlo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE351DE4D2
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054346; cv=none; b=Qlfxs0cPPz4leuzjB69SS29F9RC3Xo91WeNSSzDq792K6jzBzsXCAD8mWTI+sDav3+93IiKJBL9m3Exu7N4pe2oPYZkT7eoz0cYq9Uu6xRPije7ZqP78FYDioHcIN4EmQ9Lj18+rueycKDfLfY3BAp8T6nkwljMUnvjxxiP7PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054346; c=relaxed/simple;
	bh=enGBXljCg6nj2CH00dAZGuG5YFavyKg+aWI9Vq7Qklo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxZGNmKj9+k+M5Tm0CFr6ZwYxho+QagtHO6qgOKmPjzvKoB3ayYimh9E1zHGSvM4UsK3pmmRCAXxczsTbo5SGxR7uCFE8ZLi3TDnFD0VCnT8HxBibJ1mMP4PW3KR9e9KJSUO49oJ/bL4WWKrgiRTCDAEDPZ6Pwh2s1DPL0UNuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsJgRSlo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054344; x=1781590344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=enGBXljCg6nj2CH00dAZGuG5YFavyKg+aWI9Vq7Qklo=;
  b=LsJgRSlolfyEtovNtSS+TNfRKY61BP6MGUqaRo3AnNVDABlSXONNUUIk
   tpImyQYSEHtQ/SF62dMixB9JzGk2zLV1wVhI3QKv/kUa6gdpB1MDmzYUm
   UJqgcV67AT9SdKA5pfhEvkEaOBB8Nrn4X4HGVqvGzvITPMx1RIQ2+Ofd6
   TvVYBICgcQf1/9iZNjrIQWS4Szen9sDJmZdGkDWqu9177uaSQJqgjQOIk
   W9UTda79HEv6yoeKAGIXrbJoKCZ+QeKU1VrnRQjyejb5WANZdm3KqP7qL
   GNjaISi/4F1sM6iBFEV05lMsLLjV3ik7R8vS8sZRmvrZjkD+gSDwpfEkm
   g==;
X-CSE-ConnectionGUID: Hvq2f6VFScyHNYverXee9w==
X-CSE-MsgGUID: Pi0tg2WUQAubZgU3H9adXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278244"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278244"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:22 -0700
X-CSE-ConnectionGUID: OrgX2o9DQMaAyTQYO71XWA==
X-CSE-MsgGUID: hP0jUndhTdyMjNbOkHABHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928101"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:21 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1EE61122159;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atc-17;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 5/6] pm: runtime: Mark last busy stamp in pm_request_autosuspend()
Date: Mon, 16 Jun 2025 09:12:11 +0300
Message-Id: <20250616061212.2286741-6-sakari.ailus@linux.intel.com>
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
pm_request_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
index 566a07b60f63..778d5988f35e 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -448,11 +448,12 @@ static inline int pm_request_resume(struct device *dev)
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
@@ -467,6 +468,7 @@ static inline int pm_request_resume(struct device *dev)
  */
 static inline int pm_request_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
 }
 
-- 
2.39.5


