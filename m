Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46C0254D0
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfEUQEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:04:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 12:04:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so8810055pgm.7
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sSr8nkvct0PINiUcW2z/dRf5WMflIfwH+kfGGvza1dA=;
        b=EN9xdML3GPWW6if/DegN7gnOgJ/ylDKpImbGaqXsyTNCLifEbwPhS/OxnGik4pX0Go
         AI+uDJoeRd3biujIuMzne3A4rZ9q/3mN0NdoPKPHHnnZYKmzSmeJS+RE/Fh6Fvgd4i+Y
         7td+8ayR0ipQgJeOoFdNuBqkEOlZgynvRBavv14Y6nEXXnwE2jXF+i6S/7aPGs7nmP+h
         cooOC+rYMXaEEGXM0eyY+auxLfph+4aN4+PVSQ+fgwenUgc4BIj4MXwUopW007JXVka4
         0AioyRFxQMl2WLceLDE8hBi+qVyF5+zdnMIbhhDkBcx0NjGIraUDDlONpR0WoliUmhYC
         PqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sSr8nkvct0PINiUcW2z/dRf5WMflIfwH+kfGGvza1dA=;
        b=eVr4yYLnG3s426hg4HE3mZtM6Z8vo92162iD+Cln2/ZYm/Whz6OS2Dyauzp1fYgH4X
         yFs1If5tbp1bKlDcrqTuepKz0F1icL7QzL/xpqLw8ynzxW7bvs3UvQACR3RfDOi9Tjpt
         8EvReq+HJHTa7j83nVpbWmnGYISZBgDh6Inw4U1hdoSWlWHQkcinplziZTtKPT9Rg6MU
         9kktzHziIEUqkckqKrVLYy4F9vyJu2vavJLOkbdDXXZh+OjJTvpMchvqIR0Zhpl5/34J
         R4lGUtoMoH8YvwoyYqfdyk7+FqCFM8wTGVeTR44rcIGxnshO0ug2RUN4mHS/Dc4KCky4
         J62w==
X-Gm-Message-State: APjAAAWc/BRSwp54M12TVic8zpEHQQq/kY2sKjUcJ1ZW7G4CpFLb2+y/
        sYsz5cwllWyBkTfHkHbwjm0=
X-Google-Smtp-Source: APXvYqxsW/G05VwkA4xBnoiJwkdmOQdzA2cxqKxNOk0EPdogZeJzhC9oJNqzYzwlZHG3FA0Qp8jyAQ==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr82695090pgv.221.1558454674300;
        Tue, 21 May 2019 09:04:34 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:9cd0:73e8:b74a:624e])
        by smtp.gmail.com with ESMTPSA id j5sm28954786pfa.15.2019.05.21.09.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 09:04:33 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
Date:   Wed, 22 May 2019 01:04:07 +0900
Message-Id: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).
The temperature threshold feature (Feature Identifier 04h) configures the
asynchronous event request command to complete when the temperature is
crossed its corresponding temperature threshold.

This adds infrastructure to provide these temperatures and thresholds via
thermal zone devices.

The nvme_thermal_zones_register() creates up to nine thermal zone devices
for all implemented temperature sensors including the composite
temperature.

/sys/class/thermal/thermal_zone[0-*]:
    |---temp: Temperature
    |---trip_point_0_temp: Over temperature threshold

The thermal_zone[0-*] contains a symlink to the corresponding nvme device.
On the other hand, the following symlinks to the thermal zone devices are
created in the nvme device sysfs directory.

- nvme_temp0: Composite temperature
- nvme_temp1: Temperature sensor 1
...
- nvme_temp8: Temperature sensor 8

The nvme_thermal_zones_unregister() removes the registered thermal zone
devices and symlinks.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- s/correspoinding/corresponding/ typo in commit log
- Borrowed nvme_get_features() from Keith's patch
- Temperature threshold notification is splitted into another patch
- Change the data type of 'sensor' to unsigned
- Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
- Add WARN_ON_ONCE for paranoid checks
- Fix off-by-one error in nvme_get_temp
- Validate 'sensor' where the value is actually used
- Define and utilize two enums related to the temperature threshold feature
- Remove hysteresis value for this trip point and don't utilize the under
  temperature threshold
- Print error message for thermal_zone_device_register() failure
- Add function comments for nvme_thermal_zones_{,un}register
- Suppress non-fatal errors from nvme_thermal_zones_register()
- Add comment about implemented temperature sensors 
- Instead of creating a new 'thermal_work', append async smart event's
  action to the existing async_event_work
- Add comment for tzdev member in nvme_ctrl

 drivers/nvme/host/core.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  27 +++++
 include/linux/nvme.h     |   5 +
 3 files changed, 297 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c04df80..0ec303c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2179,6 +2179,271 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	}
 }
 
+#ifdef CONFIG_THERMAL
+
+static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, int *temp)
+{
+	struct nvme_smart_log *log;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=
+		     ARRAY_SIZE(ctrl->tzdev));
+
+	if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
+		return -EINVAL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return -ENOMEM;
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			   log, sizeof(*log), 0);
+	if (ret) {
+		ret = ret > 0 ? -EINVAL : ret;
+		goto free_log;
+	}
+
+	if (sensor)
+		*temp = le16_to_cpu(log->temp_sensor[sensor - 1]);
+	else
+		*temp = get_unaligned_le16(log->temperature);
+
+	if (!*temp)
+		ret = -EINVAL;
+
+free_log:
+	kfree(log);
+
+	return ret;
+}
+
+static unsigned int nvme_tz_type_to_sensor(const char *type)
+{
+	unsigned int sensor;
+
+	if (sscanf(type, "nvme_temp%u", &sensor) != 1)
+		return UINT_MAX;
+
+	return sensor;
+}
+
+#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
+#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
+
+static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,
+			    int *temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+	int ret;
+
+	ret = nvme_get_temp(ctrl, sensor, temp);
+	if (!ret)
+		*temp = KELVIN_TO_MILLICELSIUS(*temp);
+
+	return ret;
+}
+
+static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,
+				 int trip, enum thermal_trip_type *type)
+{
+	*type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
+
+static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl,
+				     unsigned int sensor, int *temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int status;
+	int ret;
+
+	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
+		return -EINVAL;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+	if (!ret)
+		*temp = status & NVME_TEMP_THRESH_MASK;
+
+	return ret > 0 ? -EINVAL : ret;
+}
+
+static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
+				     unsigned int sensor, int temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int status;
+	int ret;
+
+	if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
+		return -EINVAL;
+
+	if (temp > NVME_TEMP_THRESH_MASK)
+		return -EINVAL;
+
+	threshold |= temp & NVME_TEMP_THRESH_MASK;
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+
+	return ret > 0 ? -EINVAL : ret;
+}
+
+static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
+				 int trip, int *temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+	int ret;
+
+	ret = nvme_get_over_temp_thresh(ctrl, sensor, temp);
+	if (!ret)
+		*temp = KELVIN_TO_MILLICELSIUS(*temp);
+
+	return ret;
+}
+
+static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,
+				 int trip, int temp)
+{
+	unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
+	struct nvme_ctrl *ctrl = tzdev->devdata;
+
+	temp = MILLICELSIUS_TO_KELVIN(temp);
+
+	return nvme_set_over_temp_thresh(ctrl, sensor, temp);
+}
+
+static struct thermal_zone_device_ops nvme_tz_ops = {
+	.get_temp = nvme_tz_get_temp,
+	.get_trip_type = nvme_tz_get_trip_type,
+	.get_trip_temp = nvme_tz_get_trip_temp,
+	.set_trip_temp = nvme_tz_set_trip_temp,
+};
+
+static struct thermal_zone_params nvme_tz_params = {
+	.governor_name = "user_space",
+	.no_hwmon = true,
+};
+
+static struct thermal_zone_device *
+nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
+{
+	struct thermal_zone_device *tzdev;
+	char type[THERMAL_NAME_LENGTH];
+	int ret;
+
+	snprintf(type, sizeof(type), "nvme_temp%d", sensor);
+
+	tzdev = thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,
+					     &nvme_tz_params, 0, 0);
+	if (IS_ERR(tzdev)) {
+		dev_err(ctrl->device,
+			"Failed to register thermal zone device: %ld\n",
+			PTR_ERR(tzdev));
+		return tzdev;
+	}
+
+	ret = sysfs_create_link(&ctrl->ctrl_device.kobj,
+				&tzdev->device.kobj, type);
+	if (ret)
+		goto device_unregister;
+
+	ret = sysfs_create_link(&tzdev->device.kobj,
+				&ctrl->ctrl_device.kobj, "device");
+	if (ret)
+		goto remove_link;
+
+	return tzdev;
+
+remove_link:
+	sysfs_remove_link(&ctrl->ctrl_device.kobj, type);
+device_unregister:
+	thermal_zone_device_unregister(tzdev);
+
+	return ERR_PTR(ret);
+}
+
+/**
+ * nvme_thermal_zones_register() - register nvme thermal zone devices
+ * @ctrl: controller instance
+ *
+ * This function creates up to nine thermal zone devices for all implemented
+ * temperature sensors including the composite temperature.
+ * Each thermal zone device provides a single trip point temperature that is
+ * associated with an over temperature threshold.
+ */
+int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
+{
+	struct nvme_smart_log *log;
+	int ret;
+	int i;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return 0; /* non-fatal error */
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			   log, sizeof(*log), 0);
+	if (ret) {
+		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
+		ret = ret > 0 ? -EINVAL : ret;
+		goto free_log;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
+		struct thermal_zone_device *tzdev;
+
+		/*
+		 * All implemented temperature sensors report a non-zero value
+		 * in temperature sensor fields in the smart log page.
+		 */
+		if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
+			continue;
+		if (ctrl->tzdev[i])
+			continue;
+
+		tzdev = nvme_thermal_zone_register(ctrl, i);
+		if (!IS_ERR(tzdev))
+			ctrl->tzdev[i] = tzdev;
+	}
+
+free_log:
+	kfree(log);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_thermal_zones_register);
+
+/**
+ * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
+ * @ctrl: controller instance
+ *
+ * This function removes the registered thermal zone devices and symlinks.
+ */
+void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
+		struct thermal_zone_device *tzdev = ctrl->tzdev[i];
+
+		if (!tzdev)
+			continue;
+
+		sysfs_remove_link(&tzdev->device.kobj, "device");
+		sysfs_remove_link(&ctrl->ctrl_device.kobj, tzdev->type);
+		thermal_zone_device_unregister(tzdev);
+
+		ctrl->tzdev[i] = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_thermal_zones_unregister);
+
+#endif /* CONFIG_THERMAL */
+
 struct nvme_core_quirk_entry {
 	/*
 	 * NVMe model and firmware strings are padded with spaces.  For
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb673b8..0bc4e85 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -15,6 +15,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/thermal.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -248,6 +249,14 @@ struct nvme_ctrl {
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
+
+#ifdef CONFIG_THERMAL
+	/*
+	 * tzdev[0]: composite temperature
+	 * tzdev[1-8]: temperature sensor 1 through 8
+	 */
+	struct thermal_zone_device *tzdev[9];
+#endif
 };
 
 enum nvme_iopolicy {
@@ -559,6 +568,24 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+#ifdef CONFIG_THERMAL
+
+int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);
+void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);
+
+#else
+
+static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
+{
+	return 0;
+}
+
+static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
+{
+}
+
+#endif /* CONFIG_THERMAL */
+
 #ifdef CONFIG_NVM
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 658ac75..54f0a13 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -780,6 +780,11 @@ struct nvme_write_zeroes_cmd {
 
 /* Features */
 
+enum {
+	NVME_TEMP_THRESH_MASK		= 0xffff,
+	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
+};
+
 struct nvme_feat_auto_pst {
 	__le64 entries[32];
 };
-- 
2.7.4

