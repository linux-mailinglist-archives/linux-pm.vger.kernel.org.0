Return-Path: <linux-pm+bounces-28779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DCADA802
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73ED7A60F3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE21DE3A7;
	Mon, 16 Jun 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPTi8wIf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2F1DDA32
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054343; cv=none; b=k2N90EqmvD8d9SShagpZXktMEodATZuIH8dJE/mXgoW3cfnFCsVc+nTAli5N+g5felwE3lwqfhvlKdMMR+FpshDaw20C0MIiu31YyLHistoXFveM+uq+9Yyx8S/P5OD38zc+ZHVpXdoxYOBRWe/N2MYS6pEjj86FVRrRKKnfnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054343; c=relaxed/simple;
	bh=wQF3ywGgbN3L+zKf+9M4MlfQtDjDJs6Eza9GOPbRlYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWiFR4fvr+8tsBL/umHg5Q9hv4zndgFFxsEsTN+LPm6hpJGcxvThjSDuHf4zaxX7Ef5rWQZYnFwNiI0bL8KoL1LNNRiH2+OnD6JVuMetMrL/5F6Gu3O4p1AKYE0vcBzgHHK7/zP+LDcC53Q62bO8Qt5oQrsTYzgoZCG9OzN78cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPTi8wIf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054341; x=1781590341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQF3ywGgbN3L+zKf+9M4MlfQtDjDJs6Eza9GOPbRlYY=;
  b=IPTi8wIfD0WQKyQQtRejgw8stpXWUL0kAGrap9U3MPRvSt/V9J7Qwrk/
   1eJg8igDEh4eALjNAobG6jIS/6Q/+bBKQPjh8IDr/v1MNPT/zXbU6F5kn
   jFa1w61Co5Ajw/gO736p3wy1ktbYMfMICqp1yz8PuUMc+GIkQL3gGOnG4
   ryTxcXoSNLZT8vYmG4S1kC4Wam0xOiyZuL+HZPjwfceW1wocGpxScxsSe
   FU/ONXouy5rhcpvUpzyZhNtFS9NbXj5t4pQQYTc6vXubrOdNsbLLyfrbD
   Q1jtlEmn5A8iBwTE5ldHTBsO/0RO9sp5EYOAAyQFUJWd7tJX2jQMYED9r
   g==;
X-CSE-ConnectionGUID: 20w3b3iHR8u8VLtEWneNqw==
X-CSE-MsgGUID: q0LNWByIS7mxzvLhEQdZ3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278233"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278233"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:18 -0700
X-CSE-ConnectionGUID: Vb7Gbqi/QmSjCy8h3ngLGw==
X-CSE-MsgGUID: f2dZdLo1RGi7TCnj+L4dYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928083"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:17 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1A45D1218AF;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atU-11;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 3/6] pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
Date: Mon, 16 Jun 2025 09:12:09 +0300
Message-Id: <20250616061212.2286741-4-sakari.ailus@linux.intel.com>
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
pm_runtime_put_sync_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
index 14ca7be96686..3a0d5f0ea471 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -651,12 +651,14 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
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
@@ -676,6 +678,7 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  */
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
+	pm_runtime_mark_last_busy(dev);
 	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
 }
 
-- 
2.39.5


