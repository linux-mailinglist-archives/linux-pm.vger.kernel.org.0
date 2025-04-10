Return-Path: <linux-pm+bounces-25124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44800A847FE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DAA3B5A78
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9811E9B29;
	Thu, 10 Apr 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgIvuIIs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5541E990A
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299085; cv=none; b=W6IBC0RrNlgxCr88iAIs+YF/XgKepCwXEa0q9P7oc1wzpQTJKKS3CEyHvtraJ8UCKo8xshJUIszTiD2PYitLDcbkWRsq1E3mLVqncFdStVKGw9cSjV/RA3vhZ2xXKKr/OCPC3os2e5auvd9P9DsOwSwOlrxFac4DLGyoEZyHTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299085; c=relaxed/simple;
	bh=o0USEwNqtA6J/OKBmvCUCRDgFagrn1UkPo+qUBa8N7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miZZfBn/FY2UP9RE8pD5Fa3f48npnUhoguzR9Ueg9iaANPZGelCXhDeriHDU7BdooovhYw6oezm5EK6lRwn6I2IEJhqvpmfY7C+6KOBMgWPMplKg2lga9EC/ytbmFKR6pYFIOFg4NdIADfpgnU+qGCeONneHyPA7YyxyjMp+Vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgIvuIIs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299084; x=1775835084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0USEwNqtA6J/OKBmvCUCRDgFagrn1UkPo+qUBa8N7Y=;
  b=WgIvuIIskf0lAs4hTSqmXGs1HFSPLEokRuIL61C82PJBfCh3NUs0FaXZ
   4kFgb3so/kHNOahf0cLDqyvwvJ9SqaaQIOciBpzfCb7xcYZWBBOwZ1Ta2
   oZTXiS1G6g+sxfc+9qThIWkso9a06uv21GdOyjlp6ZHruzQtzBW4zH+8D
   Q9QJ8On6QL1uINEdkXChZbrRDphrGy46Y8JXdmabJpzxAlgMoemDzu6aY
   bEHdM79K0iSYMseQ8cxdLlvypPs4jkRZb6d4VnCvLIAtBUuf8e8e2EyVJ
   9DXAnXfxVk1obWRO2xhqDuKOuWegxbqfraUI6BmybrBZcAn9QfC+HVFfw
   A==;
X-CSE-ConnectionGUID: LuENVIv7Q4iqp5+UOxCj5g==
X-CSE-MsgGUID: hHrACrZoRayQUlknNIZk9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806951"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
X-CSE-ConnectionGUID: tbvuUqOHQHCg7UFUKzN4bQ==
X-CSE-MsgGUID: W+UWpzCZQB6BaoZ49e/xvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475369"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 46F8911FB1F;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOdm-0t;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/7] pm: runtime: Document return values of suspend related API functions
Date: Thu, 10 Apr 2025 18:31:01 +0300
Message-Id: <20250410153106.4146265-3-sakari.ailus@linux.intel.com>
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

Document return values for device suspend and idle related API functions.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/pm_runtime.h | 147 ++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 9 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7fb5a459847e..3e31cbebc527 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -333,6 +333,20 @@ static inline void pm_runtime_release_supplier(struct device_link *link) {}
  * Invoke the "idle check" callback of @dev and, depending on its return value,
  * set up autosuspend of @dev or suspend it (depending on whether or not
  * autosuspend has been enabled for it).
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero, Runtime PM status change ongoing
+ *            or device not in %RPM_ACTIVE state.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM idle and suspend callbacks.
  */
 static inline int pm_runtime_idle(struct device *dev)
 {
@@ -342,6 +356,18 @@ static inline int pm_runtime_idle(struct device *dev)
 /**
  * pm_runtime_suspend - Suspend a device synchronously.
  * @dev: Target device.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_suspend(struct device *dev)
 {
@@ -354,6 +380,18 @@ static inline int pm_runtime_suspend(struct device *dev)
  *
  * Set up autosuspend of @dev or suspend it (depending on whether or not
  * autosuspend is enabled for it) without engaging its "idle check" callback.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
@@ -375,6 +413,18 @@ static inline int pm_runtime_resume(struct device *dev)
  *
  * Queue up a work item to run an equivalent of pm_runtime_idle() for @dev
  * asynchronously.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero, Runtime PM status change ongoing
+ *            or device not in %RPM_ACTIVE state.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
  */
 static inline int pm_request_idle(struct device *dev)
 {
@@ -396,6 +446,17 @@ static inline int pm_request_resume(struct device *dev)
  *
  * Queue up a work item to run an equivalent pm_runtime_autosuspend() for @dev
  * asynchronously.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
  */
 static inline int pm_request_autosuspend(struct device *dev)
 {
@@ -460,6 +521,17 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
  *
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, queue up a work item for @dev like in pm_request_idle().
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
  */
 static inline int pm_runtime_put(struct device *dev)
 {
@@ -472,6 +544,17 @@ static inline int pm_runtime_put(struct device *dev)
  *
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
  */
 static inline int __pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -484,6 +567,17 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  *
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
  */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -500,9 +594,20 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
  * return value, set up autosuspend of @dev or suspend it (depending on whether
  * or not autosuspend has been enabled for it).
  *
- * The possible return values of this function are the same as for
- * pm_runtime_idle() and the runtime PM usage counter of @dev remains
- * decremented in all cases, even if it returns an error code.
+ * The runtime PM usage counter of @dev remains decremented in all cases, even
+ * if it returns an error code.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync(struct device *dev)
 {
@@ -516,9 +621,21 @@ static inline int pm_runtime_put_sync(struct device *dev)
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, carry out runtime-suspend of @dev synchronously.
  *
- * The possible return values of this function are the same as for
- * pm_runtime_suspend() and the runtime PM usage counter of @dev remains
- * decremented in all cases, even if it returns an error code.
+ * The runtime PM usage counter of @dev remains decremented in all cases, even
+ * if it returns an error code.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync_suspend(struct device *dev)
 {
@@ -533,9 +650,21 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  * equal to 0, set up autosuspend of @dev or suspend it synchronously (depending
  * on whether or not autosuspend has been enabled for it).
  *
- * The possible return values of this function are the same as for
- * pm_runtime_autosuspend() and the runtime PM usage counter of @dev remains
- * decremented in all cases, even if it returns an error code.
+ * The runtime PM usage counter of @dev remains decremented in all cases, even
+ * if it returns an error code.
+ *
+ * Return:
+ * * 0: Success.
+ * * -EINVAL: Runtime PM error.
+ * * -EACCES: Runtime PM disabled.
+ * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EBUSY: Runtime PM child_count non-zero.
+ * * -EPERM: Device PM QoS resume latency 0.
+ * * -EINPROGRESS: Suspend already in progress.
+ * * -ENOSYS: CONFIG_PM not enabled.
+ * * 1: Device already suspended.
+ * Other values and conditions for the above values are possible as returned by
+ * Runtime PM suspend callbacks.
  */
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
-- 
2.39.5


