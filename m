Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449153504AB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhCaQed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 12:34:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233830AbhCaQeY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 12:34:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B1FAD6E;
        Wed, 31 Mar 2021 09:34:23 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE1883F792;
        Wed, 31 Mar 2021 09:34:21 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH 2/2] thermal: power_allocator: update once cooling devices when temp is low
Date:   Wed, 31 Mar 2021 17:33:52 +0100
Message-Id: <20210331163352.32416-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331163352.32416-1-lukasz.luba@arm.com>
References: <20210331163352.32416-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cooling device state change generates an event, also when there is no
need, because temperature is low and device is not throttled. Avoid to
unnecessary update the cooling device which means also not sending event.
The cooling device state has not changed because the temperature is still
below the first activation trip point value, so we can do this.
Add a tracking mechanism if the update was triggered and makes sure it
will be done only once when the temperature continue to stay below first
trip point.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0cbd10cab193..6085b6661b8b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -65,6 +65,8 @@ static inline s64 div_frac(s64 x, s64 y)
  *					controlling for.
  * @sustainable_power:	Sustainable power (heat) that this thermal zone can
  *			dissipate
+ * @updated:		Keeps track if the framework was updated when the
+ *			temperature went below the first trip point.
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -73,6 +75,7 @@ struct power_allocator_params {
 	int trip_switch_on;
 	int trip_max_desired_temperature;
 	u32 sustainable_power;
+	bool updated;
 };
 
 /**
@@ -395,6 +398,12 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 	mutex_lock(&tz->lock);
 
+	/*
+	 * The temperature has crossed the first trip point, so next time
+	 * when it drops below, update cooling devices and framework.
+	 */
+	params->updated = false;
+
 	num_actors = 0;
 	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
@@ -596,10 +605,18 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 		 */
 		cdev->ops->get_requested_power(cdev, &req_power);
 
-		instance->cdev->updated = false;
+		if (!params->updated)
+			instance->cdev->updated = false;
+
 		mutex_unlock(&instance->cdev->lock);
-		thermal_cdev_update(instance->cdev);
+
+		if (!params->updated)
+			thermal_cdev_update(instance->cdev);
 	}
+
+	/* Don't send updates next time when temperature is low. */
+	params->updated = true;
+
 	mutex_unlock(&tz->lock);
 }
 
-- 
2.17.1

