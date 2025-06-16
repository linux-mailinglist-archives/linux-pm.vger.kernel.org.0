Return-Path: <linux-pm+bounces-28781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A94ADA804
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373777A7F4F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D791DE4F3;
	Mon, 16 Jun 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUPLCEAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99311DDC0B
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054344; cv=none; b=OjDXOXcTzwLFIQXiYOjMIRtS1b3ZfFaI2/YGJN98ofWadPOzPHFwWKPVdV/pLQry021x21orWe30awPO55/CyC47iX/m1MNu3GvPQNQ6728lxaioVekCoW+XoPOx4rl8QCTVRerdZeXShibcLXl1VfJDTqiWzD7gJTKRwYgQo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054344; c=relaxed/simple;
	bh=tHXTUhTcKzbAWjQNaqvGcduXjmEExUrhaCJV9+HiWPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLyGNbSBQ/wOHEeivQELlMKNd7wJzxgHcQC4lU5CmkW2sHw0atqQSQ35bs1xQrU3FI/fGNg99928aa8eEpFJEwlZtA9HdFUp0TSE6U1vFaM7Lg0njUTt3xvb8v4i/BTZbarRFi/5orc3EjKyylsVCdrRfpgERcfQWkjfOGwxsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUPLCEAh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054342; x=1781590342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tHXTUhTcKzbAWjQNaqvGcduXjmEExUrhaCJV9+HiWPE=;
  b=kUPLCEAhE5GIWvD+OQNLVikQIU14VUyt0FbA6PmdaqrEEkCvqy+mjGIA
   iE8JgtWd/HB5erw5LF8fpe63wyGpfErWhEwjIB1eC8Us5tSyX6HW9n/ZS
   ELewx+86VWn0cMP004iI7H+M0BjuCbMFrDmiGPmGjXF/AMQPKMpNYxaSK
   x4LkX2I1AuUYZqlqiBN55TPsdPYaAOXNBDC4Xxly+FmhGoDnGfo7pZCt5
   pvWoZtOrYO+8AW7g8CJRO+rDxnfmnoMP0Zikn/pf9UK/irYvqyTE+W5V0
   xdcCFysbQ+drGBCcwExpGEmuXTolWsl+NXZRDpn417FH5j6kTYdMPOskp
   A==;
X-CSE-ConnectionGUID: HGRJLngmR0O/eAyD+kiQ6g==
X-CSE-MsgGUID: g1uSFXHdTdumNBUZsMHKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278236"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:18 -0700
X-CSE-ConnectionGUID: OSKXQVk8SVGu3PWEtVNjqQ==
X-CSE-MsgGUID: RbArfsc5Tv6Zf4fLVQa8hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928086"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:17 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 179F2121312;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atM-0q;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 1/6] pm: runtime: Document return values of suspend related API functions
Date: Mon, 16 Jun 2025 09:12:07 +0300
Message-Id: <20250616061212.2286741-2-sakari.ailus@linux.intel.com>
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

Document return values for device suspend and idle related API functions.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/pm_runtime.h | 147 ++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 9 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index e7cb70fcc0af..9dd2e4031a27 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -337,6 +337,20 @@ static inline void pm_runtime_release_supplier(struct device_link *link) {}
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
@@ -346,6 +360,18 @@ static inline int pm_runtime_idle(struct device *dev)
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
@@ -358,6 +384,18 @@ static inline int pm_runtime_suspend(struct device *dev)
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
@@ -379,6 +417,18 @@ static inline int pm_runtime_resume(struct device *dev)
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
@@ -400,6 +450,17 @@ static inline int pm_request_resume(struct device *dev)
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
@@ -464,6 +525,17 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
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
@@ -478,6 +550,17 @@ DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
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
@@ -490,6 +573,17 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
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
@@ -506,9 +600,20 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
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
@@ -522,9 +627,21 @@ static inline int pm_runtime_put_sync(struct device *dev)
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
@@ -539,9 +656,21 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
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


