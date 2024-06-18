Return-Path: <linux-pm+bounces-9421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA290C81E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B0286CD9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260F1D47B5;
	Tue, 18 Jun 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUKWJcjR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0B13B587;
	Tue, 18 Jun 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703334; cv=none; b=JzN0E2b2U0C4Kwu8jPYMK+PsqloF7f7oqsg6//x9lqGqHy30++L6JOD8jY2GKIbV4AlgnutUpflN9NVuGNY6h8TQ3wuW0zyB1wyimTT1cFLodIrVswwpCzSMcj+I1pcE4SSEGeDFEDQOMW47J0NcKZpVCh0xWVEVY7yd5KTbV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703334; c=relaxed/simple;
	bh=JHI6cNOEA2Auz04X8kWFFv6gM9/K4bsBXG/vkqd+DYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IocavyaGUH40PldM5lz5OxpjtkwKh/SrpUayIueqSH6qesnoAicbibrKO/ULguopnyHDuJpC1bvbKZal2coBLobfqpk3WiSqMXqJhWRYWu0nFtIWlwLZ6L1TY2MISSXRV1Nls/yzjWCbUK42oGyONxP6tdKnMuB6FBlr5AMGgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUKWJcjR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718703333; x=1750239333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHI6cNOEA2Auz04X8kWFFv6gM9/K4bsBXG/vkqd+DYQ=;
  b=TUKWJcjRVm7YAz13TxOaHYiwQCl8hg+ZOw+AnSqld4Mhtc3DWfrHM0wg
   CQDhaCcoyKOus9R+UHrYyQC71Az0fnvo8COXPVzfy+s455sXWQfAWOmJ+
   1vVmqKvLGoB6YUltmisWRfCdHpPme6+Cz4aCGOEwaass3bWkb3FkEttea
   dA6i2Wz4h3TNX8eEXTHI8ZQOr4gNEMFoB8Rhnj2GZ8Y58hDm2maNWAGfc
   m3Oj3cReDW8CVVzMeIa1d7+/s14IdgfOfwCzHXSkUQxBj7Tv+Ydw6Jsi+
   PZcFL2Mt0lJz/jq360RD4FXlE4X/LEkYw33BBBZQX07Wg66fhbwVaIRzD
   g==;
X-CSE-ConnectionGUID: Zs3gzVEgQjCYM8rnN0P2eQ==
X-CSE-MsgGUID: rOHjeK+iRmWPCZoZGcs6Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15400104"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15400104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:35:32 -0700
X-CSE-ConnectionGUID: laesWWKIR86l/Uw00dvT0w==
X-CSE-MsgGUID: mOg0vcnYQVKsFTIBkL+01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41968704"
Received: from leegavin-mobl.gar.corp.intel.com (HELO localhost.localdomain) ([10.246.105.197])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2024 02:35:31 -0700
From: Kaiyen Chang <kaiyen.chang@intel.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kaiyen.chang@intel.com
Subject: [PATCH 1/1] PM: Start asynchronous suspend threads upfront
Date: Tue, 18 Jun 2024 17:35:07 +0800
Message-ID: <20240618093507.2143-2-kaiyen.chang@intel.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20240618093507.2143-1-kaiyen.chang@intel.com>
References: <20240618093507.2143-1-kaiyen.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when performing a suspend operation, all devices on the
dpm_list must wait for preceding "synchronous" devices to complete
before the main suspend thread can start their suspend routines,
even if they are "asynchronous". If the suspend routine of a
synchronous device must enter a waiting state for some reason, it
will cause the main suspend thread to wait as well, thereby
delaying the processing of all subsequent devices, including
asynchronous ones, thus ultimately extending the overall device
suspend time.

By starting the asynchronous suspend threads of asynchronous
devices upfront we effectively move those devices towards the
beginning of dpm_list, without breaking their ordering with respect
to their parents and children. As a result, even if the main
suspend thread enters a waiting state, these asynchronous threads
can continue to run without delay.

Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
---
 drivers/base/power/main.c | 90 +++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 33 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..6ddd6ef36625 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1283,6 +1283,7 @@ static void async_suspend_noirq(void *data, async_cookie_t cookie)
 
 static int dpm_noirq_suspend_devices(pm_message_t state)
 {
+	struct device *dev;
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
@@ -1293,26 +1294,33 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Trigger the suspend of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones that don't depend on them.
+	 */
+
+	list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry)
+		dpm_async_fn(dev, async_suspend_noirq);
+
 	while (!list_empty(&dpm_late_early_list)) {
-		struct device *dev = to_device(dpm_late_early_list.prev);
+		dev = to_device(dpm_late_early_list.prev);
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
 
-		if (dpm_async_fn(dev, async_suspend_noirq))
-			continue;
-
-		get_device(dev);
+		if (!dev->power.async_in_progress) {
+			get_device(dev);
 
-		mutex_unlock(&dpm_list_mtx);
+			mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_noirq(dev, state, false);
+			error = device_suspend_noirq(dev, state, false);
 
-		put_device(dev);
+			put_device(dev);
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
-			break;
+			if (error || async_error)
+				break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1454,6 +1462,7 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
  */
 int dpm_suspend_late(pm_message_t state)
 {
+	struct device *dev;
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
@@ -1466,26 +1475,33 @@ int dpm_suspend_late(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Trigger the suspend of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones that don't depend on them.
+	 */
+
+	list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry)
+		dpm_async_fn(dev, async_suspend_late);
+
 	while (!list_empty(&dpm_suspended_list)) {
-		struct device *dev = to_device(dpm_suspended_list.prev);
+		dev = to_device(dpm_suspended_list.prev);
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
 
-		if (dpm_async_fn(dev, async_suspend_late))
-			continue;
-
-		get_device(dev);
+		if (!dev->power.async_in_progress) {
+			get_device(dev);
 
-		mutex_unlock(&dpm_list_mtx);
+			mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_late(dev, state, false);
+			error = device_suspend_late(dev, state, false);
 
-		put_device(dev);
+			put_device(dev);
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
-			break;
+			if (error || async_error)
+				break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
@@ -1719,6 +1735,7 @@ static void async_suspend(void *data, async_cookie_t cookie)
  */
 int dpm_suspend(pm_message_t state)
 {
+	struct device *dev;
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
@@ -1733,26 +1750,33 @@ int dpm_suspend(pm_message_t state)
 
 	mutex_lock(&dpm_list_mtx);
 
+	/*
+	 * Trigger the suspend of "async" devices upfront so they don't have to
+	 * wait for the "non-async" ones that don't depend on them.
+	 */
+
+	list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)
+		dpm_async_fn(dev, async_suspend);
+
 	while (!list_empty(&dpm_prepared_list)) {
-		struct device *dev = to_device(dpm_prepared_list.prev);
+		dev = to_device(dpm_prepared_list.prev);
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
 
-		if (dpm_async_fn(dev, async_suspend))
-			continue;
-
-		get_device(dev);
+		if (!dev->power.async_in_progress) {
+			get_device(dev);
 
-		mutex_unlock(&dpm_list_mtx);
+			mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend(dev, state, false);
+			error = device_suspend(dev, state, false);
 
-		put_device(dev);
+			put_device(dev);
 
-		mutex_lock(&dpm_list_mtx);
+			mutex_lock(&dpm_list_mtx);
 
-		if (error || async_error)
-			break;
+			if (error || async_error)
+				break;
+		}
 	}
 
 	mutex_unlock(&dpm_list_mtx);
-- 
2.34.1


