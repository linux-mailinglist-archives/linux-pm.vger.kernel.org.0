Return-Path: <linux-pm+bounces-9431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C848890CB6A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB201F25C22
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDA7CF33;
	Tue, 18 Jun 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7K1KZwk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9C13C9B3;
	Tue, 18 Jun 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712832; cv=none; b=DRvO/QrZryAVU7mmkxagMCg6K7k4vrJobZuooMK0mY34xFhOTJfRuUkrH0FefhSTmlrlAzPs7DQ/hsUOVrKcR7oXICtCLibizf5p2GfXff6MJGzzOADKRgJdqEQWmPr+f03jQPb1WdAUYTdshDEl5ebiuQE3XB/7RYUcPkfax38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712832; c=relaxed/simple;
	bh=X9QCPNgUcIZsYDkcUhj1m0OpYShHx7kVNjyb1E8tyTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1AdNL42+ZRXW6xkwvUydfTYrY2GBOiEWjEXsIMaduXKeKEeXtLDmnm4EeFp/Nzku+f/Oh0alcGYugkyKhG3b7bf0KoXKIF941ve3CkRfxdo11bLJsbDA7fRrQxnpTJu9yn9yDjy2F9tvPDSTUd1IiySQOWoc1MOsNI2faJkDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7K1KZwk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718712831; x=1750248831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9QCPNgUcIZsYDkcUhj1m0OpYShHx7kVNjyb1E8tyTE=;
  b=b7K1KZwk3Map1H23pBrX4PGIk9YX/pkQHjf0k9jGVSANk3qG4qEhGU7P
   lJ9mz/kyxFeCqTF3ABV550PuEK67fNzvIj++e2djIGlLW0iDNtrkaPMe1
   hmAJtXsNNZq/5QfOUbJh5DQE+XRYSqGJq/LhrpLSrwInR3gVKdn60pyPQ
   rsNSagsJQS72ffmppEE+eNU+H72+yQ5ENSnxwDIpQ1LNV9BNGuLH01IfP
   ybKTTkHuoJ5Z8cFnuSgwHUebnsGR3mQAPIS8Q1wQkV0VbmvEraonN21gw
   3eP0fbOubjWjwsl0SCDnhR/NbpuA9ZtICOElvmHS6dpPdBjFxmJuypqiw
   w==;
X-CSE-ConnectionGUID: wURJh0hyQjOtQTikAAm2+Q==
X-CSE-MsgGUID: crldimo9RpGWDeKcM+eJ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26214663"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26214663"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 05:13:51 -0700
X-CSE-ConnectionGUID: z7pLOwwBQ7mVMNxKmWea8w==
X-CSE-MsgGUID: MDUl7/OTQGCMSo83sZdw0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46072118"
Received: from leegavin-mobl.gar.corp.intel.com (HELO localhost.localdomain) ([10.246.105.197])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 05:13:48 -0700
From: Kaiyen Chang <kaiyen.chang@intel.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kaiyen.chang@intel.com
Subject: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
Date: Tue, 18 Jun 2024 20:13:27 +0800
Message-ID: <20240618121327.2177-2-kaiyen.chang@intel.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20240618121327.2177-1-kaiyen.chang@intel.com>
References: <20240618121327.2177-1-kaiyen.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when performing a suspend operation, all devices on the
dpm_list must wait for the "synchronous" devices that are listed
after them to complete before the main suspend thread can start
their suspend routines, even if they are "asynchronous". If the
suspend routine of a synchronous device must enter a waiting state
for some reason, it will cause the main suspend thread to go to
sleep, thereby delaying the processing of all subsequent devices,
including asynchronous ones, ultimately extending the overall
suspend time.

By starting the asynchronous suspend threads upfront, we can allow
the system to handle the suspend routines of these asynchronous
devices in parallel, without waiting for the suspend routines of
the synchronous devices listed after them to complete, and without
breaking their order with respect to their parents and children.
This way, even if the main suspend thread is blocked, these
asynchronous suspend threads can continue to run without being
affected.

Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
---
Change from v1: Fix some unclear parts in the commit messages.
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


