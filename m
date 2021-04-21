Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901B367190
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhDURma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:42:30 -0400
Received: from foss.arm.com ([217.140.110.172]:38850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244779AbhDURma (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 13:42:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E119513A1;
        Wed, 21 Apr 2021 10:41:56 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.27.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E2133F694;
        Wed, 21 Apr 2021 10:41:55 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH v3 1/3] thermal: power_allocator: maintain the device statistics from going stale
Date:   Wed, 21 Apr 2021 18:41:43 +0100
Message-Id: <20210421174145.8213-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421174145.8213-1-lukasz.luba@arm.com>
References: <20210421174145.8213-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the temperature is below the first activation trip point the cooling
devices are not checked, so they cannot maintain fresh statistics. It
leads into the situation, when temperature crosses first trip point, the
statistics are stale and show state for very long period. This has impact
on IPA algorithm calculation and wrong decisions. Thus, check the cooling
devices even when the temperature is low, to refresh these statistics.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2802a0e13c88..d393409fb786 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -575,15 +575,25 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	u32 req_power;
 
 	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
 		if ((instance->trip != params->trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
 			continue;
 
 		instance->target = 0;
 		mutex_lock(&instance->cdev->lock);
+		/*
+		 * Call for updating the cooling devices local stats and avoid
+		 * periods of dozen of seconds when those have not been
+		 * maintained.
+		 */
+		cdev->ops->get_requested_power(cdev, &req_power);
+
 		instance->cdev->updated = false;
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(instance->cdev);
-- 
2.17.1

