Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9E2FBA2F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbhASOp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 09:45:57 -0500
Received: from foss.arm.com ([217.140.110.172]:52696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388791AbhASLnC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Jan 2021 06:43:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0986E113E;
        Tue, 19 Jan 2021 03:41:51 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D4093F719;
        Tue, 19 Jan 2021 03:41:49 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH v2] thermal: power allocator: fail binding for non-power actor devices
Date:   Tue, 19 Jan 2021 11:41:26 +0000
Message-Id: <20210119114126.19480-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone can have cooling devices which are missing power actor
API. This could be due to missing Energy Model for devfreq or cpufreq
cooling device. In this case it is safe to fail the binding rather than
trying to workaround and control the temperature in such thermal zone.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi all,

This is a v2 patch which just stops the binding when there is some
cooling device which is not implementing power actor API. As discussed
with Daniel, it's better option than trying to control such undefined
thermal zone.
The v1 and related seggestion from Daniel can be found here [1].

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20210105190107.30479-1-lukasz.luba@arm.com/


 drivers/thermal/gov_power_allocator.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 7a4170a0b51f..39e64eea7841 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -589,6 +589,34 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+/**
+ * check_power_actors() - Check all cooling devices and warn when they are
+ *			not power actors
+ * @tz:		thermal zone to operate on
+ *
+ * Check all cooling devices in the @tz and warn every time they are missing
+ * power actor API. The warning should help to investigate the issue, which
+ * could be e.g. lack of Energy Model for a given device.
+ *
+ * Return: 0 on success, -EINVAL if any cooling device does not implement
+ * the power actor API.
+ */
+static int check_power_actors(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance;
+	int ret = 0;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (!cdev_is_power_actor(instance->cdev)) {
+			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
+				 instance->cdev->type);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
@@ -596,7 +624,8 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
  * Initialize the PID controller parameters and bind it to the thermal
  * zone.
  *
- * Return: 0 on success, or -ENOMEM if we ran out of memory.
+ * Return: 0 on success, or -ENOMEM if we ran out of memory, or -EINVAL
+ * when there are unsupported cooling devices in the @tz.
  */
 static int power_allocator_bind(struct thermal_zone_device *tz)
 {
@@ -604,6 +633,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	struct power_allocator_params *params;
 	int control_temp;
 
+	ret = check_power_actors(tz);
+	if (ret)
+		return ret;
+
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
-- 
2.17.1

