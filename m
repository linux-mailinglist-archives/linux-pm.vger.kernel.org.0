Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB612081B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfLPOGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:06:53 -0500
Received: from foss.arm.com ([217.140.110.172]:56596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfLPOGw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:06:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251EF1FB;
        Mon, 16 Dec 2019 06:06:52 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D86363F718;
        Mon, 16 Dec 2019 06:06:49 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, corbet@lwn.net, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH  3/3] thermal: Add sysfs binding for cooling device and thermal zone
Date:   Mon, 16 Dec 2019 14:06:22 +0000
Message-Id: <20191216140622.25467-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216140622.25467-1-lukasz.luba@arm.com>
References: <20191216140622.25467-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Make it possible to bind from userspace a cooling device to an existing
thermal zone. It adds more flexibility in addition to static device tree
definitions. There is also a code for changing trip point connected to
cooling device instance in the thermal zone.

In order to bind a device to a zone, first the proper thermal zone name
must be checked from file:
cat /sys/class/thermal/thermal_zoneX/type
Then that name must be set into cooling device 'bind_tz' file:
echo 'gpu-thermal' > /sys/class/thermal/cooling_deviceY/bind_tz
Next a proper trip point must be chosen for this cooling device:
echo 2 > /sys/class/thermal/thermal_zoneX/cdev_Z_trip_point

To unbind, first set -1 to connected trip point:
echo -1 > /sys/class/thermal/thermal_zoneX/cdev_Z_trip_point
Then unbind the thermal zone from the cooling device:
echo 'gpu-thermal' > /sys/class/thermal/cooling_deviceY/unbind_tz

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_sysfs.c | 57 +++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 80c8bae6dd1c..473449b41d55 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -722,15 +722,72 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	return result ? result : count;
 }
 
+static ssize_t
+bind_tz_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct thermal_zone_device *tz;
+	char *orig, *name;
+	int res = 0;
+
+	orig = kstrndup(buf, count, GFP_KERNEL);
+	if (!orig)
+		return -ENOMEM;
+
+	name = strstrip(orig);
+
+	tz = thermal_zone_get_zone_by_name(name);
+	if (IS_ERR_OR_NULL(tz))
+		return -EINVAL;
+
+	res = thermal_zone_bind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev,
+					       THERMAL_NO_LIMIT,
+					       THERMAL_NO_LIMIT,
+					       THERMAL_WEIGHT_DEFAULT);
+
+	kfree(orig);
+	return res ? res : count;
+}
+
+static ssize_t
+unbind_tz_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct thermal_zone_device *tz;
+	char *name, *orig;
+	int res = 0;
+
+	orig = kstrndup(buf, count, GFP_KERNEL);
+	if (!orig)
+		return -ENOMEM;
+
+	name = strstrip(orig);
+
+	tz = thermal_zone_get_zone_by_name(name);
+	if (IS_ERR_OR_NULL(tz))
+		return -EINVAL;
+
+	res = thermal_zone_unbind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev);
+
+	kfree(orig);
+	return res ? res : count;
+}
+
 static struct device_attribute
 dev_attr_cdev_type = __ATTR(type, 0444, cdev_type_show, NULL);
 static DEVICE_ATTR_RO(max_state);
 static DEVICE_ATTR_RW(cur_state);
+static DEVICE_ATTR_WO(bind_tz);
+static DEVICE_ATTR_WO(unbind_tz);
 
 static struct attribute *cooling_device_attrs[] = {
 	&dev_attr_cdev_type.attr,
 	&dev_attr_max_state.attr,
 	&dev_attr_cur_state.attr,
+	&dev_attr_bind_tz.attr,
+	&dev_attr_unbind_tz.attr,
 	NULL,
 };
 
-- 
2.17.1

