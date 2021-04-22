Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054C2367FBD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhDVLnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:43:53 -0400
Received: from foss.arm.com ([217.140.110.172]:50416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhDVLnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 07:43:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB8D1424;
        Thu, 22 Apr 2021 04:43:18 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A32B3F774;
        Thu, 22 Apr 2021 04:43:16 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v4 1/3] thermal: create a helper __thermal_cdev_update() without a lock
Date:   Thu, 22 Apr 2021 12:43:06 +0100
Message-Id: <20210422114308.29684-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422114308.29684-1-lukasz.luba@arm.com>
References: <20210422114308.29684-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a need to have a helper function which updates cooling device
state from the governors code. With this change governor can use
lock and unlock while calling helper function. This avoid unnecessary
second time lock/unlock which was in previous solution present in
governor implementation. This new helper function must be called
with mutex 'cdev->lock' hold.

The changed been discussed and part of code presented in thread:
https://lore.kernel.org/linux-pm/20210419084536.25000-1-lukasz.luba@arm.com/

Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h    |  1 +
 drivers/thermal/thermal_helpers.c | 27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 86b8cef7310e..726e327b4205 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -66,6 +66,7 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 }
 
 void thermal_cdev_update(struct thermal_cooling_device *);
+void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 7f50f412e02a..3edd047e144f 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -192,18 +192,11 @@ static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 	thermal_cooling_device_stats_update(cdev, target);
 }
 
-void thermal_cdev_update(struct thermal_cooling_device *cdev)
+void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
 	unsigned long target = 0;
 
-	mutex_lock(&cdev->lock);
-	/* cooling device is updated*/
-	if (cdev->updated) {
-		mutex_unlock(&cdev->lock);
-		return;
-	}
-
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
 		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
@@ -216,11 +209,25 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 
 	thermal_cdev_set_cur_state(cdev, target);
 
-	cdev->updated = true;
-	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
+
+/**
+ * thermal_cdev_update - update cooling device state if needed
+ * @cdev:	pointer to struct thermal_cooling_device
+ *
+ * Update the cooling device state if there is a need.
+ */
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&cdev->lock);
+	if (!cdev->updated) {
+		__thermal_cdev_update(cdev);
+		cdev->updated = true;
+	}
+	mutex_unlock(&cdev->lock);
+}
 EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
-- 
2.17.1

