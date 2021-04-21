Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B89367193
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhDURmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:42:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244854AbhDURme (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 13:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD90B11FB;
        Wed, 21 Apr 2021 10:42:00 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 390EE3F694;
        Wed, 21 Apr 2021 10:41:58 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v3 3/3] thermal: create a helper __thermal_cdev_update() without a lock
Date:   Wed, 21 Apr 2021 18:41:45 +0100
Message-Id: <20210421174145.8213-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421174145.8213-1-lukasz.luba@arm.com>
References: <20210421174145.8213-1-lukasz.luba@arm.com>
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
 drivers/thermal/gov_power_allocator.c |  5 +----
 drivers/thermal/thermal_core.h        |  1 +
 drivers/thermal/thermal_helpers.c     | 28 +++++++++++++++++----------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index f379f1aaa3b5..a6cdb2e892da 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -595,12 +595,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 		cdev->ops->get_requested_power(cdev, &req_power);
 
 		if (update)
-			instance->cdev->updated = false;
+			__thermal_cdev_update(instance->cdev);
 
 		mutex_unlock(&instance->cdev->lock);
-
-		if (update)
-			thermal_cdev_update(instance->cdev);
 	}
 	mutex_unlock(&tz->lock);
 }
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
index 7f50f412e02a..3d7fd46104de 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -192,18 +192,12 @@ static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 	thermal_cooling_device_stats_update(cdev, target);
 }
 
-void thermal_cdev_update(struct thermal_cooling_device *cdev)
+
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
@@ -216,11 +210,25 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 
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

