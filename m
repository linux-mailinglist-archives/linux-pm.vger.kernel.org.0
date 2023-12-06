Return-Path: <linux-pm+bounces-741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590E806DF2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40977280F5C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92131A69;
	Wed,  6 Dec 2023 11:30:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D96DADE;
	Wed,  6 Dec 2023 03:30:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8044150C;
	Wed,  6 Dec 2023 03:31:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 762793F5A1;
	Wed,  6 Dec 2023 03:30:44 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH 1/5] thermal: core: Add callback for governors with cooling instances change
Date: Wed,  6 Dec 2023 11:31:34 +0000
Message-Id: <20231206113138.3576492-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206113138.3576492-1-lukasz.luba@arm.com>
References: <20231206113138.3576492-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow governors to react to the changes in the cooling instances list.
That makes possible to move memory allocations related to the number of
cooling instances out of the throttle() callback. The throttle() callback
is called much more often thus the cost of managing allocations there is
an extra overhead. The list of cooling instances is not changed that often
and it can be handled in dedicated callback. That will save CPU cycles
in the throttle() code path.  Both callbacks code paths are protected with
the same thermal zone lock, which guaranties the list of cooling instances
is consistent.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 include/linux/thermal.h        |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..c993b86f7fb5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -314,6 +314,15 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+static void handle_instances_list_update(struct thermal_zone_device *tz)
+{
+
+	if (!tz->governor || !tz->governor->instances_update)
+		return;
+
+	tz->governor->instances_update(tz);
+}
+
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
 	/*
@@ -723,6 +732,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
+
+		handle_instances_list_update(tz);
 	}
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -781,6 +792,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
 			list_del(&pos->cdev_node);
+
+			handle_instances_list_update(tz);
+
 			mutex_unlock(&cdev->lock);
 			mutex_unlock(&tz->lock);
 			goto unbind;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c7190e2dfcb4..e7b2a1f4bab0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -195,6 +195,9 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @instances_update:	callback called when thermal zone instances list
+ *	i		has changed (e.g. added new or removed), which
+ *			may help to offload work for governor like allocations
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -203,6 +206,7 @@ struct thermal_governor {
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
+	void (*instances_update)(struct thermal_zone_device *tz);
 	struct list_head	governor_list;
 };
 
-- 
2.25.1


