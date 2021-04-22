Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D5367FC1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhDVLn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:43:58 -0400
Received: from foss.arm.com ([217.140.110.172]:50436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236161AbhDVLn4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 07:43:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9661424;
        Thu, 22 Apr 2021 04:43:21 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40A243F774;
        Thu, 22 Apr 2021 04:43:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v4 3/3] thermal: power_allocator: update once cooling devices when temp is low
Date:   Thu, 22 Apr 2021 12:43:08 +0100
Message-Id: <20210422114308.29684-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422114308.29684-1-lukasz.luba@arm.com>
References: <20210422114308.29684-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cooling device state change generates an event, also when there is no
need, because temperature is low and device is not throttled. Avoid to
unnecessary update the cooling device which means also not sending event.
The cooling device state has not changed because the temperature is still
below the first activation trip point value, so we can do this.
Add a tracking mechanism to make sure it updates cooling devices only
once - when the temperature dropps below first trip point.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d393409fb786..a6cdb2e892da 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -571,7 +571,7 @@ static void reset_pid_controller(struct power_allocator_params *params)
 	params->prev_err = 0;
 }
 
-static void allow_maximum_power(struct thermal_zone_device *tz)
+static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
@@ -594,9 +594,10 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 		 */
 		cdev->ops->get_requested_power(cdev, &req_power);
 
-		instance->cdev->updated = false;
+		if (update)
+			__thermal_cdev_update(instance->cdev);
+
 		mutex_unlock(&instance->cdev->lock);
-		thermal_cdev_update(instance->cdev);
 	}
 	mutex_unlock(&tz->lock);
 }
@@ -710,6 +711,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	int ret;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
+	bool update;
 
 	/*
 	 * We get called for every trip point but we only need to do
@@ -721,9 +723,10 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
 	if (!ret && (tz->temperature < switch_on_temp)) {
+		update = (tz->last_temperature >= switch_on_temp);
 		tz->passive = 0;
 		reset_pid_controller(params);
-		allow_maximum_power(tz);
+		allow_maximum_power(tz, update);
 		return 0;
 	}
 
-- 
2.17.1

