Return-Path: <linux-pm+bounces-9087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA390739F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBA2B270F3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34C14600E;
	Thu, 13 Jun 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vSRp1pYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0C144D1F
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285062; cv=none; b=WffUR1akKlBQOZlJdbXX++PDJ8i3nD1qV/cL5fO7PS2J+aRGZQWY8M6zPbXULgn+UoG4qP6pIq/TFv3IV7Fd/w8+ZxminJVNusX2k906iX1er2jwR6O1dSbqCA1Y+AVqA7chDHVcoLEmN4QDc942uwBnPTVsmjErxbWLMG/ZpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285062; c=relaxed/simple;
	bh=j7f3ZXCinJ1j3RqxyoUU0BtazpbIWYMRhtwdrGF0DRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPQ2aIEM/Gql91y13E+xQJiYZVeteE3osiOlhPfTQWFBUgVpqG2XEBklU2a7e/qquYufwAKSqzXp3bVkljALDUtmxRWT6WWB/dllUHz9F1hwUEBGswpsvazcrIdcgEMhSJ6xHkNxa13ukFQTaoOw96kyFV3F4PWKSoRy3m+5rAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vSRp1pYG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217136a74dso9657805e9.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285058; x=1718889858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LyOSi8f/3UaYrbHuOz6VLA6k5tiA3tUA9t+QNNaNjo=;
        b=vSRp1pYGWLsoWhr1wdptYe1itkN3vVztankJ+tU74HmFgOk2PZc4L8jnm8n3AJV2/p
         E8U8SjMkKil2uJTXBW13+8Wx9Qc7+NiiILJHEOegb5ptrysM621v6LpLYMo+f5OB57t3
         SHJuPr8U4kXOZHACkxaBDHjJknirlUAMsWbvx3A9EROU9nWnAuThNtMKCheOUx+q8kCm
         hoX8gp2QVDSRitmh2MAfJdyfk8Wk/C0J+vXV4HeB3rLj48rmkzbSqnS9DR9NEjUrHC99
         wrotLsl0x6xNFG1nHYQ5dYBshcD816DqAo/GBlUWuXY6C6rmqsZ1/ZQXZNU7B6D6vpwC
         JzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285058; x=1718889858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LyOSi8f/3UaYrbHuOz6VLA6k5tiA3tUA9t+QNNaNjo=;
        b=FzrF/NbPA9ICyNQe5rCau54sPq5gELBZ38xwhg6Yz34DNL7jwSsnziDKWARPYEaj0y
         ygJZ90fS13JavbLjzgBxLLSYqiuuJcI4/srouCLnDZyxe2VVQeqZjr7WBnYTEUv0B/yp
         e/LWeSl9kVUAEQxxRFZcF7dV49qANXf7nmWfsjuag98gwro5pXUeKoDnrCwqkobX9NcK
         Mm6oVKESAzdeqmny2Cip4T9HV/3bA1tWk3BmgX7S/6D+bnCmOLfXJ5Ly4cH4A0BeUWmx
         FLgkVgBQBJLRM3rnUUQdPutjiAGsrCyFGuRUcvcfIUJRzriPQXvDBws3w5yZWmt8O3De
         pmJA==
X-Forwarded-Encrypted: i=1; AJvYcCXGgVlOuLrdPK5G4uMhivZ4NTZJST6Nc777tMdpoNhSoS3ZKoa5fUMZ6a0pz0wue6r7hpwUzShPdtciBhQvUw/AHOfg2PgKTcs=
X-Gm-Message-State: AOJu0YwF5mV0Z6pZ0Mbrmy2GJ2b5Ps7WyLI6AXVM41HTLf6koyoQAcI+
	YN8koQZz9mj6aYbxedlg/vvqrOeh9yFaRMiDnpaqviB2Ub+Ee/jh2aoX5DFaGeg=
X-Google-Smtp-Source: AGHT+IGsOLsgFK7ts6VttFOyzjo0d0li8FyVir5Ilvh/4L2ZA8c+T3S4y7KLtVeT+iKItocG0DgtjA==
X-Received: by 2002:a05:600c:3d16:b0:421:8345:7891 with SMTP id 5b1f17b1804b1-422863a8d1amr53462135e9.16.1718285057919;
        Thu, 13 Jun 2024 06:24:17 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:16 -0700 (PDT)
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
Subject: [PATCH v4 2/4] thermal: Add support of multi sensors to thermal_core
Date: Thu, 13 Jun 2024 15:24:08 +0200
Message-ID: <20240613132410.161663-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
References: <20240613132410.161663-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support of multi sensors to thermal.
Currently, this only support the get_temp operation.
This returns the maximum temperature among all the sensors.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/thermal_core.h  |  15 ++
 drivers/thermal/thermal_multi.c | 286 ++++++++++++++++++++++++++++++++
 include/uapi/linux/thermal.h    |   5 +
 4 files changed, 307 insertions(+)
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
index 20e7b45673d6..c2cf2c19738a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -261,6 +261,21 @@ ssize_t weight_show(struct device *, struct device_attribute *, char *);
 ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
 
+/* Multi sensors */
+struct thermal_zone_device *thermal_multi_sensor_find_tz(const char *type);
+struct thermal_zone_device_ops *thermal_multi_sensor_alloc_ops(void);
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
index 000000000000..4b3f261a7000
--- /dev/null
+++ b/drivers/thermal/thermal_multi.c
@@ -0,0 +1,286 @@
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
+ * Returns: a pointer to the created struct thermal_zone_device_ops or an
+ * in case of error, an ERR_PTR. Caller must check return value with
+ * IS_ERR*() helpers.
+ */
+struct thermal_zone_device_ops *thermal_multi_sensor_alloc_ops(void)
+{
+	struct thermal_zone_device_ops *ops;
+
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	ops->get_temp = multi_sensor_get_temp_max;
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


