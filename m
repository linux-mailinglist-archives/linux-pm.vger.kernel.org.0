Return-Path: <linux-pm+bounces-8107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454B8CE712
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379411C222BB
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810112CD96;
	Fri, 24 May 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K5E0dJYk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470E12C54A
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561121; cv=none; b=EYlgEa/xPCRx7OmCgug6yv2LGpgp7VEZjQ5Zso6Www30dUFpjJH2p4J0hSWJJiq46ynlUE7LWHGPPJrxM6Y7Q/rBwrh75HQiMc6f+0b2ExU2BND2nc2g8aQaXDTa+tsrQyeBHRKOWNr9IJxCEgz/LLpyrT3Xyh2+AGgJrpNh7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561121; c=relaxed/simple;
	bh=mPXSWVM/lWJTvxx8Sk78MOF9pL+YlUVhGWXRjiz7bfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fedXs2HX0RE6d2RYXLD0iie/2OQctSdKQxzIfShZDSy/r2NRiexiWg9I9U/Knd5SrTbYOJCj1f8LQGQglOg/U0c9oUGvFALapdbJntBcR7jjtdrtkwzdt0zfa4vPQTgPz2JidJoCBAVXpcCtWBNK/B/O0cKp7D7kv0NDczNRAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K5E0dJYk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so2290681f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561118; x=1717165918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+j9xOE0tYjxUOHMPpSuPZogtIBOsTQZVZMBTvXII0g=;
        b=K5E0dJYkZaZjooZzdssubRRRjVemvkEzI3Q4pMLIeZmBJ7RGZYGeQUH2DfJgr5tR3o
         MraRTaFpOJa5IATWuXiXXPjzSI57cTXHOSpTp6U5Wm5qox/JIbTujcuPRpEEbhO9sqNH
         dgosnspKTplnwRhfaNdW6WoQpJ6JvgTI3ijSOSSts44zJNBUSJ7iN7cbH77LwkY07jhc
         Z97SZ/PwntEGhkdclhuYPSbgGXIqmp6+GiGXJLw0MoIClj3i5DIMe+6IybLBEmFdzbUL
         VZCD5UHbRICMJdB8Fy7VwWVakYT0npPVVUtIfHj4F3FYggcAIj6b57yWyToNr+ipGBra
         8xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561118; x=1717165918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+j9xOE0tYjxUOHMPpSuPZogtIBOsTQZVZMBTvXII0g=;
        b=Ju7M6ZRCiwjvG0MBAKzsBz9SAqc8/mWoEcpyWTJHOj7iPF6yOQdFE7ilzMgPikoYUN
         iwnScVM4Qyv6x5WuDQ0gxxA1UT/3PIk1baoLIsxsWNQ/yBSSJaqt6USP8q4XjpCIQAwe
         cXoArsJmwPdCIcytLNs+pWHnVo1B9FsmxW5P5Hf6c5YK8khsQXi29S/fu2MCwjkPNny2
         pcx4aaLGZPk68cEGsAcT8gb6j8I/NiDPUtN7p3WprT7gF7lIC7+ZTEzyWQSqKoy2zn4o
         VK7RECMEcpCqKqymEFgWJ7qV4IsX7dq8QjDWGHofbrx3QkzEUieYap3vkg1RSF6OxGLB
         pVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOSBecffqAEE/UiAaA2eGkOw/lIzayLVYipmozZHrXhZbjS350KCB9P+DI9p0u5+0NnjJC8JZX0yQ+fc974J/2lJz7Cb5OLdU=
X-Gm-Message-State: AOJu0YyJR9YMhA1aVHjxW6keHxbgyu3oFm62hHhKXauR5as4XKMH63mQ
	oZfaYCfnX1u6KKSzQjrG3/2vN61glV30SG7PDjM4a/Xb+9dC98Q3cDhI5XYpCW0=
X-Google-Smtp-Source: AGHT+IH5y0F3sHdzgvtSPWAAwV1/nrn57MOWODWjtpU2gpn/5+qDWgV6Q2DiZ9JVGquT4dNU8LJy9w==
X-Received: by 2002:adf:f746:0:b0:354:eb62:365c with SMTP id ffacd0b85a97d-3552217fd10mr1577173f8f.15.1716561117567;
        Fri, 24 May 2024 07:31:57 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:31:56 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 2/6] thermal: Add support of multi sensors to thermal_core
Date: Fri, 24 May 2024 16:31:46 +0200
Message-ID: <20240524143150.610949-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support of multi sensors to thermal.
Currently, this only support the get_temp operation.
This returns an average temperature of all the sensors.
If defined, a coefficient is applied to the value read from the sensor
before computing the average.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/thermal_core.h  |  15 ++
 drivers/thermal/thermal_multi.c | 332 ++++++++++++++++++++++++++++++++
 include/uapi/linux/thermal.h    |   5 +
 4 files changed, 353 insertions(+)
 create mode 100644 drivers/thermal/thermal_multi.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 5cdf7d68687f..872190f9062b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -6,6 +6,7 @@ CFLAGS_thermal_core.o		:= -I$(src)
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o
 thermal_sys-y			+= thermal_trip.o thermal_helpers.o
+thermal_sys-y			+= thermal_multi.o
 
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0d8a42bb7ce8..224735b644bc 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -142,6 +142,21 @@ ssize_t weight_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
 
+/* Multi sensors */
+struct thermal_zone_device *thermal_multi_sensor_find_tz(const char *type);
+struct thermal_zone_device_ops *thermal_multi_sensor_alloc_ops(int aggr_type);
+struct thermal_zone_device *thermal_multi_sensor_tz_alloc(const char *type,
+						  struct thermal_trip *trips,
+						  int num_trips,
+						  struct thermal_zone_device_ops *ops,
+						  int passive_delay, int polling_delay);
+void thermal_multi_sensor_tz_free(struct thermal_zone_device *tz);
+int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offset);
+int thermal_multi_sensor_register(struct thermal_zone_device *tz,
+	struct thermal_zone_device *sensor_tz, int coeff);
+void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_tz);
+
+
 #ifdef CONFIG_THERMAL_STATISTICS
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 					 unsigned long new_state);
diff --git a/drivers/thermal/thermal_multi.c b/drivers/thermal/thermal_multi.c
new file mode 100644
index 000000000000..cee0ded8dc25
--- /dev/null
+++ b/drivers/thermal/thermal_multi.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "thermal_core.h"
+
+struct sensor_interface {
+	struct thermal_zone_device *tz;
+	int coeff;
+
+	struct list_head node;
+};
+
+struct multi_sensor_thermal_zone {
+	struct thermal_zone_device *tz;
+	struct mutex sensors_lock;
+	struct list_head sensors;
+
+	struct list_head node;
+};
+
+static DEFINE_MUTEX(multi_tz_mutex);
+static LIST_HEAD(multi_tz_list);
+
+#define TJ_MAX 120000
+
+static int multi_sensor_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct multi_sensor_thermal_zone *multi_tz = tz->devdata;
+	struct sensor_interface *sensor;
+	int accumulated_temp = 0;
+	u32 accumulated_coeff = 0;
+	int ret;
+
+	mutex_lock(&multi_tz->sensors_lock);
+
+	if (list_empty(&multi_tz->sensors)) {
+		mutex_unlock(&multi_tz->sensors_lock);
+		return -ENODEV;
+	}
+
+	list_for_each_entry(sensor, &multi_tz->sensors, node) {
+		ret = thermal_zone_get_temp(sensor->tz, temp);
+		if (ret) {
+			mutex_unlock(&multi_tz->sensors_lock);
+			return ret;
+		}
+
+		accumulated_temp += *temp * sensor->coeff;
+		accumulated_coeff += sensor->coeff;
+	}
+
+	mutex_unlock(&multi_tz->sensors_lock);
+
+	*temp = accumulated_temp / accumulated_coeff;
+	return ret;
+}
+
+static int multi_sensor_get_temp_max(struct thermal_zone_device *tz, int *temp)
+{
+	struct multi_sensor_thermal_zone *multi_tz = tz->devdata;
+	struct sensor_interface *sensor;
+	int max_temp;
+	int ret;
+
+	mutex_lock(&multi_tz->sensors_lock);
+
+	if (list_empty(&multi_tz->sensors)) {
+		mutex_unlock(&multi_tz->sensors_lock);
+		return -ENODEV;
+	}
+
+	list_for_each_entry(sensor, &multi_tz->sensors, node) {
+		ret = thermal_zone_get_temp(sensor->tz, temp);
+		if (ret) {
+			mutex_unlock(&multi_tz->sensors_lock);
+			return ret;
+		}
+
+		max_temp = max(max_temp, *temp * sensor->coeff);
+	}
+
+	mutex_unlock(&multi_tz->sensors_lock);
+
+	*temp = max_temp;
+	return ret;
+}
+
+/**
+ * Check if the sum of the coefficients multiplied by sensors temperature plus
+ * an offset won't overflow during the aggregation.
+ * @coeff: An array of coefficient
+ * @count: Number of coefficient
+ * @offset: The offset
+ *
+ * Returns: 0 if the coefficient are safe, -EOVERFLOW otherwise
+ */
+int thermal_multi_sensor_validate_coeff(int *coeff, int count, int offset)
+{
+	int max_accumulated_temp = 0;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		max_accumulated_temp += TJ_MAX * coeff[i];
+		if (max_accumulated_temp < 0)
+			return -EOVERFLOW;
+	}
+
+	max_accumulated_temp += offset;
+	return max_accumulated_temp < 0 ? -EOVERFLOW : 0;
+}
+
+/**
+ * Find a multi sensor thermal zone
+ * @type: The thermal zone type to find
+ *
+ * Returns: a pointer to the thermal zone or NULL  if not found
+ */
+struct thermal_zone_device *thermal_multi_sensor_find_tz(const char *type)
+{
+	struct thermal_zone_device *tz;
+
+	tz = thermal_zone_get_zone_by_name(type);
+	if (IS_ERR(tz))
+		return NULL;
+	return tz;
+}
+
+/**
+ * Allocate a struct thermal_zone_device_ops for the multi sensor thermal zoen
+ *
+ * This allocates a struct thermal_zone_device_ops with a predifiend get_temp
+ * operation. This allows setting the other function pointers before registering
+ * the thermal zone.
+ *
+ * @aggr_type: The aggregation type to use (THERMAL_AGGR_AVG or THERMAL_AGGR_MAX)
+ *
+ * Returns: a pointer to the created struct thermal_zone_device_ops or an
+ * in case of error, an ERR_PTR. Caller must check return value with
+ * IS_ERR*() helpers.
+ */
+struct thermal_zone_device_ops *thermal_multi_sensor_alloc_ops(int aggr_type)
+{
+	struct thermal_zone_device_ops *ops;
+
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	switch (aggr_type) {
+	case THERMAL_AGGR_AVG:
+		ops->get_temp = multi_sensor_get_temp;
+		break;
+	case THERMAL_AGGR_MAX:
+		ops->get_temp = multi_sensor_get_temp_max;
+		break;
+	default:
+		kfree(ops);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return ops;
+}
+
+/**
+ * Register a new thermal zone device that supports multi sensors
+ * @type:	the thermal zone device type
+ * @trips:	a pointer to an array of thermal trips
+ * @num_trips:	the number of trip points the thermal zone support
+ * @mask:	a bit string indicating the writeablility of trip points
+ * @ops:	standard thermal zone device callbacks
+ * @passive_delay: number of milliseconds to wait between polls when
+ *		   performing passive cooling
+ * @polling_delay: number of milliseconds to wait between polls when checking
+ *		   whether trip points have been crossed (0 for interrupt
+ *		   driven systems)
+ *
+ * This function allocates and register a multi sensor thermal zone.
+ * To register a sensor to this thermal zone, use thermal_multi_sensor_register().
+ * thermal_multi_sensor_unregister() must be called to unregister the sensors
+ * and release this thermal zone when it is not used anymore.
+ *
+ * Return: a pointer to the created struct thermal_zone_device or an
+ * in case of error, an ERR_PTR. Caller must check return value with
+ * IS_ERR*() helpers.
+ */
+struct thermal_zone_device *thermal_multi_sensor_tz_alloc(const char *type,
+					struct thermal_trip *trips,
+					int num_trips,
+					struct thermal_zone_device_ops *ops,
+					int passive_delay, int polling_delay)
+{
+	struct thermal_zone_device *tz;
+	struct thermal_zone_params tzp = {};
+	struct multi_sensor_thermal_zone *multi_tz;
+
+	mutex_lock(&multi_tz_mutex);
+
+	tz = thermal_zone_get_zone_by_name(type);
+	if (!IS_ERR(tz))
+		goto unlock;
+
+	multi_tz = kzalloc(sizeof(*multi_tz), GFP_KERNEL);
+	if (!multi_tz) {
+		tz = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
+	mutex_init(&multi_tz->sensors_lock);
+	INIT_LIST_HEAD(&multi_tz->sensors);
+
+	tzp.no_hwmon = true;
+	tzp.slope = 1;
+	tzp.offset = 0;
+
+	tz = thermal_zone_device_register_with_trips(type, trips, num_trips,
+						     multi_tz, ops, &tzp,
+						     passive_delay, polling_delay);
+	if (IS_ERR(tz)) {
+		kfree(multi_tz);
+	} else {
+		multi_tz->tz = tz;
+		list_add(&multi_tz->node, &multi_tz_list);
+	}
+
+unlock:
+	mutex_unlock(&multi_tz_mutex);
+	return tz;
+}
+
+/**
+ * Remove all sensors from multi sensor thermal zone and release it
+ *
+ * This function must not be used except on error path to correctly
+ * release all the allocated resources.
+ * Use thermal_multi_sensor_unregister() to unregister a sensor and
+ * release a thermal zone that is not used anymore.
+ *
+ * @tz: Pointer to thermal zone to release
+ */
+void thermal_multi_sensor_tz_free(struct thermal_zone_device *tz)
+{
+	struct multi_sensor_thermal_zone *multi_tz = tz->devdata;
+	struct thermal_trip *trips = tz->trips;
+	struct thermal_zone_device_ops *ops = &tz->ops;
+	struct sensor_interface *sensor, *tmp;
+
+	list_for_each_entry_safe(sensor, tmp, &multi_tz->sensors, node) {
+		list_del(&sensor->node);
+		kfree(sensor);
+	}
+
+	thermal_zone_device_unregister(tz);
+	list_del(&multi_tz->node);
+	kfree(multi_tz);
+	kfree(trips);
+	kfree(ops);
+}
+
+/**
+ * Register a thermal sensor to a multi sensor thermal zone
+ * @tz: The multi sensor thermal zone
+ * @sensor_tz: The thermal zone of the zensor to register
+ * @coeff: The coefficient to apply to the temperature returned by the sensor
+ *
+ * Returns: On success 0, a negative value in case of error
+ */
+int thermal_multi_sensor_register(struct thermal_zone_device *tz,
+				  struct thermal_zone_device *sensor_tz,
+				  int coeff)
+{
+	struct multi_sensor_thermal_zone *multi_tz;
+	struct sensor_interface *sensor;
+
+	mutex_lock(&multi_tz_mutex);
+
+	multi_tz =  tz->devdata;
+
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	if (!sensor) {
+		mutex_unlock(&multi_tz_mutex);
+		return -ENOMEM;
+	}
+
+	sensor->tz = sensor_tz;
+	sensor->coeff = coeff;
+	mutex_lock(&multi_tz->sensors_lock);
+	list_add(&sensor->node, &multi_tz->sensors);
+	mutex_unlock(&multi_tz->sensors_lock);
+
+	thermal_zone_device_enable(tz);
+
+	mutex_unlock(&multi_tz_mutex);
+
+	return 0;
+}
+
+/**
+ * Unregister a thermal sensor from a multi sensor thermal zone
+ *
+ * This unregister a thermal sensor from a multi sensor thermal zone.
+ * If all the sensors have been removed then this also release the multi sensor
+ * thermal zone.
+ * @sensor_tz: The sensor to unregister
+ */
+void thermal_multi_sensor_unregister(struct thermal_zone_device *sensor_tz)
+{
+	struct multi_sensor_thermal_zone *multi_tz, *tmp_tz;
+	struct sensor_interface *sensor, *tmp;
+
+	mutex_lock(&multi_tz_mutex);
+	list_for_each_entry_safe(multi_tz, tmp_tz, &multi_tz_list, node) {
+		mutex_lock(&multi_tz->sensors_lock);
+		list_for_each_entry_safe(sensor, tmp, &multi_tz->sensors, node) {
+			if (sensor->tz == sensor_tz) {
+				list_del(&sensor->node);
+				kfree(sensor);
+				break;
+			}
+		}
+		mutex_unlock(&multi_tz->sensors_lock);
+
+		if (list_empty(&multi_tz->sensors))
+			thermal_multi_sensor_tz_free(multi_tz->tz);
+	}
+	mutex_unlock(&multi_tz_mutex);
+}
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index fc78bf3aead7..e4f6c4c5e6fd 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -16,6 +16,11 @@ enum thermal_trip_type {
 	THERMAL_TRIP_CRITICAL,
 };
 
+enum thermal_aggregation_type {
+	THERMAL_AGGR_AVG = 0,
+	THERMAL_AGGR_MAX = 1,
+};
+
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME		"thermal"
 #define THERMAL_GENL_VERSION			0x01
-- 
2.44.1


