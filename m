Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE82FC259
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbhASV3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbhASV2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A38C061786
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reOexqO18r52eZRsqC7RDtYXLoHPJ9Fb181N4MTfypE=;
        b=iwXEfi55o1M7opknW/n0mIkGKMec+64MzfN9XIp8kKAQmIlip4uOIWwTDxQiIT0/QAgQAt
        XKVwVlco+Nk/AHwMTkQRXZYbr3nruALrOoVotD9mesH6o2wExslZLUhZDqahLjXT8/GVhE
        UADiraOHanMDyAv0i++teBxCv9wV9tSQ/pv2goqnGRyBTvC8e6o+447tyvAilnFK0in9xS
        vC87qH7KpgG1Y0sYS1LHpVMX8T65m2VfOej2ge8r3MLDSOMFpKKDlhqo9ca6gXTQfAGhnL
        BXAX+d99TVdPAcirXAOvNlQy99z5oj8hHGe2L+7xz7ZNBag2ilYlMmGY/kh3KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reOexqO18r52eZRsqC7RDtYXLoHPJ9Fb181N4MTfypE=;
        b=vZUEpITpMZM3C4tkpOy+FlH8Pnw4Rwg6sVh2WDn+IIgz0EPcQ7FangCfsp80oonw0xozaX
        euzHGq/W+DlArUCw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove unused functions
 rebind/unbind exception
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201214233811.485669-2-daniel.lezcano@linaro.org>
References: <20201214233811.485669-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164686.414.14084700235811896963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a20b995b23e41190fb088e7dab4a2b956bf343ae
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a20b995b23e41190fb088e7dab4a2b956bf343ae
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:05 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:04 +01:00

thermal/core: Remove unused functions rebind/unbind exception

The functions thermal_zone_device_rebind_exception and
thermal_zone_device_unbind_exception are not used from anywhere.

Remove that code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c | 37 +---------------------------------
 drivers/thermal/thermal_core.h |  4 +----
 2 files changed, 41 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 567bc6f..a0f0c33 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -598,26 +598,6 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
-void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
-					  const char *cdev_type, size_t size)
-{
-	struct thermal_cooling_device *cdev = NULL;
-
-	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(cdev, &thermal_cdev_list, node) {
-		/* skip non matching cdevs */
-		if (strncmp(cdev_type, cdev->type, size))
-			continue;
-
-		/* re binding the exception matching the type pattern */
-		thermal_zone_bind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_NO_LIMIT,
-						 THERMAL_WEIGHT_DEFAULT);
-	}
-	mutex_unlock(&thermal_list_lock);
-}
-
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *data)
 {
@@ -685,23 +665,6 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
 	return match;
 }
 
-void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
-					  const char *cdev_type, size_t size)
-{
-	struct thermal_cooling_device *cdev = NULL;
-
-	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(cdev, &thermal_cdev_list, node) {
-		/* skip non matching cdevs */
-		if (strncmp(cdev_type, cdev->type, size))
-			continue;
-		/* unbinding the exception matching the type pattern */
-		thermal_zone_unbind_cooling_device(tz, THERMAL_TRIPS_NONE,
-						   cdev);
-	}
-	mutex_unlock(&thermal_list_lock);
-}
-
 /*
  * Device management section: cooling devices, zones devices, and binding
  *
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 8df600f..e50c6b2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -118,10 +118,6 @@ struct thermal_instance {
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
-					  const char *, size_t);
-void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
-					  const char *, size_t);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 
