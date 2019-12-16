Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FBB12081C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfLPOGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:06:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfLPOGu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:06:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77A271FB;
        Mon, 16 Dec 2019 06:06:49 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36CB23F718;
        Mon, 16 Dec 2019 06:06:47 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, corbet@lwn.net, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH  2/3] thermal: Make cooling device trip point writable from sysfs
Date:   Mon, 16 Dec 2019 14:06:21 +0000
Message-Id: <20191216140622.25467-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216140622.25467-1-lukasz.luba@arm.com>
References: <20191216140622.25467-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Make it possible to change trip point for the cooling device instance
in the thermal zone. It would be helpful in case when cooling devices can
by bind to thermal zones using sysfs interface.

A proper trip point can be chosen for a cooling device by:
echo 2 > /sys/class/thermal/thermal_zoneX/cdev_Z_trip_point

It is also possible to unpin cooling device from trip point:
echo -1 > /sys/class/thermal/thermal_zoneX/cdev_Z_trip_point

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c  |  3 ++-
 drivers/thermal/thermal_core.h  |  2 ++
 drivers/thermal/thermal_sysfs.c | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..aa66a73e9fa5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -740,8 +740,9 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
 	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name = dev->attr_name;
-	dev->attr.attr.mode = 0444;
+	dev->attr.attr.mode = 0644;
 	dev->attr.show = trip_point_show;
+	dev->attr.store = trip_point_store;
 	result = device_create_file(&tz->device, &dev->attr);
 	if (result)
 		goto remove_symbol_link;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 207b0cda70da..203cc7a63706 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -76,6 +76,8 @@ void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
 void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
 /* used only at binding time */
 ssize_t trip_point_show(struct device *, struct device_attribute *, char *);
+ssize_t trip_point_store(struct device *, struct device_attribute *,
+			 const char *, size_t);
 ssize_t weight_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..80c8bae6dd1c 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -977,6 +977,26 @@ trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 		return sprintf(buf, "%d\n", instance->trip);
 }
 
+ssize_t trip_point_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct thermal_instance *instance;
+	int ret, trip;
+
+	ret = kstrtoint(buf, 0, &trip);
+	if (ret)
+		return ret;
+
+	instance = container_of(attr, struct thermal_instance, attr);
+
+	if (trip >= instance->tz->trips || trip < THERMAL_TRIPS_NONE)
+		return -EINVAL;
+
+	instance->trip = trip;
+
+	return count;
+}
+
 ssize_t
 weight_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.17.1

