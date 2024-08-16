Return-Path: <linux-pm+bounces-12315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D69543BB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF2F1F22455
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0912C549;
	Fri, 16 Aug 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLRfc+yE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144382866
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795969; cv=none; b=eoKyqpzVeMPChQOrvZV29jKnpIb24b8bvUO10tB2M9h1bK2jY4QBOGJRU772SWvlv49Zp/diZIiEPP8MVpS76TyG+3fB4cx9tZ6a/hfdXOXM1meMYilZzE57fmlOz3Bec3pd97ot25RX+asBwiftFXRTN81eiG6a5WR8p4WHFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795969; c=relaxed/simple;
	bh=q2Mr8T9rpNJu+ahK70QsUjTdsxqn2/E6HDsTHa/q5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnWFrLICZTb1hDaHHdUIN61nlh0CUJVBhuZJZ2jb/5Y74EoU80yy8/imdiYf2WPprKguCJzw0OZa1dNegBTfwdMRT76Xa/DmD7QvLTwhB89AW6TooQnjPwPOb4GEIv3AqFxppiPjZeoji6j6gbqoaF5Lzezor1Vyl3Ur4ZYvLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLRfc+yE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so12235745e9.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795966; x=1724400766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkeXiVXMve42I4m1rtYHNXv2/48ldT7q4tRb/ChewnI=;
        b=lLRfc+yEcgah6/yy3AuVQ9JEFoXCUVdBtBKRuP+2hy42q/VBlMeq8L5TY0oc+8/llO
         e2kXJ1eP4D7C0qNRjR1ZTfFRNfu+KQC+GG0yEUM8rcwVUA2unROL54VRiKY8aoH50xbh
         sQSAkActh3U5ctileSlW5+bMysHm5bCZW8Z15ODZW90aEmz68hZt1OETKuP8MEhbj0GU
         t5XvDPX+1LEF+PKVJdSK7nxsXEm2Jsqm8NSWyK3Ool5IfFVXJFZreAgpGAe7Mkz0Ycba
         HvTNdh+0sUp+YUfQ5C2r0/z4nZpXkOLTpbxGimBFjVOGZMYsjrf4MqNvVRZu3Xbc+AtT
         KS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795966; x=1724400766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkeXiVXMve42I4m1rtYHNXv2/48ldT7q4tRb/ChewnI=;
        b=UzAu625sz5pKB04BVSgs4dWAalGBSqh9ldUSI9QE+VwIZ0QDx7usybh37FuTRxh/6S
         jGDL9GHVKRUvTWkxtAXbdhj7edsQddVevEaXjTG7b1HLs6SX6XT/dLB67RIMaqv3GEp/
         KJNJ7eLewk7xZ9lhttz81H5xdgRr2QDFs3+ekN45vlkk6THdWObf4KAmn2gbWvzU9d57
         Ac15QEc9yaGd3Xv2UPC/6FaDSAZVhCrynE+C6KcyzbBXL62EyXybZrbMcv6sZhVidyud
         jlLjaKVFSnkl+tCpCEVmTCAO2RR1Z2t9VmjyZX3/sVk+wLzEFcVqBUQJw/EVoPgCh2c5
         KxPw==
X-Gm-Message-State: AOJu0YxtG8xxgd8vWG+3NOUSZYMlLzI7rXMBqsfSls9i/vEKDeT0Fi9V
	ntDfPOXrND2ufYvB4RregdRHxGSbbuSlNO5ehuDhsGZLrBzDcdRuZU3vp9Vly8A=
X-Google-Smtp-Source: AGHT+IGjg9Cc9omCO3+iL+0/SW/evj/tpynxkfYbacNaB8FvBx8Vbyq+2LncOYHIJZlSNJEORW3rUA==
X-Received: by 2002:a05:600c:5247:b0:428:1310:b6b5 with SMTP id 5b1f17b1804b1-429ed7e335cmr14447775e9.34.1723795965552;
        Fri, 16 Aug 2024 01:12:45 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 2/7] thermal/core: Add thresholds support
Date: Fri, 16 Aug 2024 10:12:33 +0200
Message-ID: <20240816081241.1925221-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trip points are a firmware description of the temperature limits
of a specific thermal zone where we associate an action which is done
by the kernel. The time resolution is low.

The userspace has to deal with a more complex thermal management based
on heuristics from different information coming from different
places. The logic is much more complex but based on a bigger time
resolution, usually one second based.

The purpose of the userspace is to monitor the temperatures from
different places and take actions. However, it can not be constantly
reading the temperature to detect when a temperature threshold has
been reached. This is especially bad for mobile or embedded system as
that will lead to an unacceptable number of wakeup to check the
temperature with nothing to do.

On the other side, the sensors are now most of the time interrupt
driven. That means the thermal framework will use the temperature trip
points to program the sensor to trigger an interrupt when a
temperature limit is crossed.

Unfortunately, the userspace can not benefit this feature and current
solutions found here and there, iow out-of-tree, are to add fake trip
points in the firmware and enable the writable trip points.

This is bad for different reasons, the trip points are for in-kernel
actions, the semantic of their types is used by the thermal framework
and by adding trip points in the device tree is a way to overcome the
current limitation but tampering with how the thermal framework is
supposed to work. The writable trip points is a way to adjust a
temperature limit given a specific platform if the firmware is not
accurate enough and TBH it is more a debug feature from my POV.

The thresholds mechanism is a way to have the userspace to tell
thermal framework to send a notification when a temperature limit is
crossed. There is no id, no hysteresis, just the temperature and the
direction of the limit crossing. That means we can be notified when a
threshold is crossed the way up only, or the way down only or both
ways. That allows to create hysteresis values if it is needed.

A threshold can be added, deleted or flushed. The latter means all
thresholds belonging to a thermal zone will be deleted.

When a threshold is added:

 - if the same threshold (temperature and direction) exists, an error
   is returned

 - if a threshold is specified with the same temperature but a
   different direction, the specified direction is added

 - if there is no threshold with the same temperature then it is
   created

When a threshold is deleted:

 - if the same threshold (temperature and direction) exists, it is
   deleted

 - if a threshold is specified with the same temperature but a
   different direction, the specified direction is removed

 - if there is no threshold with the same temperature, then an error
   is returned

When the threshold are flushed:

 - All thresholds related to a thermal zone are deleted

When a threshold is crossed:

 - the userspace does not need to know which threshold(s) have been
   crossed, it will be notified with the current temperature and the
   previous temperature

 - if multiple thresholds have been crossed between two updates only
   one notification will be send to the userspace, it is pointless to
   send a notification per thresholds crossed as the userspace can
   handle that easily when it has the temperature delta information

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig              |  15 ++
 drivers/thermal/Makefile             |   3 +
 drivers/thermal/thermal_core.h       |   4 +
 drivers/thermal/thermal_thresholds.c | 241 +++++++++++++++++++++++++++
 drivers/thermal/thermal_thresholds.h |  57 +++++++
 include/linux/thermal.h              |   3 +
 6 files changed, 323 insertions(+)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index ed16897584b4..84f9643678d6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -40,6 +40,21 @@ config THERMAL_DEBUGFS
 	  Say Y to allow the thermal subsystem to collect diagnostic
 	  information that can be accessed via debugfs.
 
+config THERMAL_THRESHOLDS
+	bool "Thermal thresholds notification mechanism"
+	depends on THERMAL_NETLINK
+	help
+	  The userspace implements thermal engines which needs to get
+	  notified when temperature thresholds are crossed the way up
+	  and down. These notification allow them to analyze the
+	  thermal situation of the platform and take decision to
+	  fulfill specific thermal profile like 'balanced',
+	  'performance' or 'power saving'. In addition, the
+	  temperature of the skin sensor is very important in this
+	  case and must be monitored as well.
+
+	  If in doubt, say Y
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index ce7a4752ef52..3b991b1a7db4 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o
 thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 
+# thermal thresholds
+thermal_sys-$(CONFIG_THERMAL_THRESHOLDS)	+= thermal_thresholds.o
+
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 67a09f90eb95..0742c0f03d46 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_thresholds.h"
 #include "thermal_debugfs.h"
 
 struct thermal_trip_desc {
@@ -132,6 +133,9 @@ struct thermal_zone_device {
 	bool resuming;
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
+#endif
+#ifdef CONFIG_THERMAL_THRESHOLDS
+	struct thresholds *thresholds;
 #endif
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
new file mode 100644
index 000000000000..0241b468cfbd
--- /dev/null
+++ b/drivers/thermal/thermal_thresholds.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Thermal thresholds
+ */
+#include <linux/list.h>
+#include <linux/list_sort.h>
+#include <linux/slab.h>
+
+#include "thermal_core.h"
+
+struct thresholds {
+	struct list_head list;
+};
+
+int thermal_thresholds_init(struct thermal_zone_device *tz)
+{
+	struct thresholds *thresholds;
+
+	thresholds = kmalloc(sizeof(*thresholds), GFP_KERNEL);
+	if (!thresholds)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&thresholds->list);
+	tz->thresholds = thresholds;
+
+	return 0;
+}
+
+void thermal_thresholds_exit(struct thermal_zone_device *tz)
+{
+	thermal_thresholds_flush(tz);
+	kfree(tz->thresholds);
+	tz->thresholds = NULL;
+}
+
+static int __thermal_thresholds_cmp(void *data,
+				    const struct list_head *l1,
+				    const struct list_head *l2)
+{
+	struct threshold *t1 = container_of(l1, struct threshold, list);
+	struct threshold *t2 = container_of(l2, struct threshold, list);
+
+	return t1->temperature - t2->temperature;
+}
+
+static struct threshold *__thermal_thresholds_find(const struct thresholds *thresholds, int temperature)
+{
+	struct threshold *t;
+
+	list_for_each_entry(t, &thresholds->list, list)
+		if (t->temperature == temperature)
+			return t;
+
+	return NULL;
+}
+
+static bool __thermal_threshold_is_crossed(struct threshold *threshold, int temperature,
+					   int last_temperature, int direction,
+					   int *low, int *high)
+{
+	if (temperature > threshold->temperature && threshold->temperature > *low &&
+	    (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
+		*low = threshold->temperature;
+
+	if (temperature < threshold->temperature && threshold->temperature < *high &&
+	    (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
+		*high = threshold->temperature;
+
+	if (temperature < threshold->temperature &&
+	    last_temperature >= threshold->temperature &&
+	    (threshold->direction & direction))
+		return true;
+
+	if (temperature >= threshold->temperature &&
+	    last_temperature < threshold->temperature &&
+	    (threshold->direction & direction))
+		return true;
+
+	return false;
+}
+
+static bool thermal_thresholds_handle_raising(struct thresholds *thresholds, int temperature,
+					      int last_temperature, int *low, int *high)
+{
+	struct threshold *t;
+
+	list_for_each_entry(t, &thresholds->list, list) {
+		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
+						   THERMAL_THRESHOLD_WAY_UP, low, high))
+			return true;
+	}
+
+	return false;
+}
+
+static bool thermal_thresholds_handle_dropping(struct thresholds *thresholds, int temperature,
+					       int last_temperature, int *low, int *high)
+{
+	struct threshold *t;
+
+	list_for_each_entry_reverse(t, &thresholds->list, list) {
+		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
+						   THERMAL_THRESHOLD_WAY_DOWN, low, high))
+			return true;
+	}
+
+	return false;
+}
+
+void thermal_thresholds_flush(struct thermal_zone_device *tz)
+{
+	struct thresholds *thresholds = tz->thresholds;
+	struct threshold *entry, *tmp;
+
+	lockdep_assert_held(&tz->lock);
+
+	list_for_each_entry_safe(entry, tmp, &thresholds->list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_THRESHOLD_FLUSHED);
+}
+
+int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
+{
+	struct thresholds *thresholds = tz->thresholds;
+
+	int temperature = tz->temperature;
+	int last_temperature = tz->last_temperature;
+	bool notify;
+
+	lockdep_assert_held(&tz->lock);
+
+	/*
+	 * We need a second update in order to detect a threshold being crossed
+	 */
+	if (last_temperature == THERMAL_TEMP_INVALID)
+		return 0;
+
+	/*
+	 * The temperature is stable, so obviously we can not have
+	 * crossed a threshold.
+	 */
+	if (last_temperature == temperature)
+		return 0;
+
+	/*
+	 * Since last update the temperature:
+	 * - increased : thresholds are crossed the way up
+	 * - decreased : thresholds are crossed the way down
+	 */
+	if (temperature > last_temperature)
+		notify = thermal_thresholds_handle_raising(thresholds, temperature,
+							   last_temperature, low, high);
+	else
+		notify = thermal_thresholds_handle_dropping(thresholds, temperature,
+							    last_temperature, low, high);
+
+	if (notify)
+		pr_debug("A threshold has been crossed the way %s, with a temperature=%d, last_temperature=%d\n",
+			 temperature > last_temperature ? "up" : "down", temperature, last_temperature);
+
+	return 0;
+}
+
+int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	struct thresholds *thresholds = tz->thresholds;
+	struct threshold *t;
+
+	lockdep_assert_held(&tz->lock);
+
+	t = __thermal_thresholds_find(thresholds, temperature);
+	if (t) {
+		if (t->direction == direction)
+			return -EEXIST;
+
+		t->direction |= direction;
+	} else {
+
+		t = kmalloc(sizeof(*t), GFP_KERNEL);
+		if (!t)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&t->list);
+		t->temperature = temperature;
+		t->direction = direction;
+		list_add(&t->list, &thresholds->list);
+		list_sort(NULL, &thresholds->list, __thermal_thresholds_cmp);
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_THRESHOLD_ADDED);
+
+	return 0;
+}
+
+int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	struct thresholds *thresholds = tz->thresholds;
+	struct threshold *t;
+
+	lockdep_assert_held(&tz->lock);
+
+	t = __thermal_thresholds_find(thresholds, temperature);
+	if (!t)
+		return -ENOENT;
+
+	if (t->direction == direction) {
+		list_del(&t->list);
+		kfree(t);
+	} else {
+		t->direction &= ~direction;
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_THRESHOLD_DELETED);
+
+	return 0;
+}
+
+int thermal_thresholds_for_each(struct thermal_zone_device *tz,
+				int (*cb)(struct threshold *, void *arg), void *arg)
+{
+	struct thresholds *thresholds = tz->thresholds;
+	struct threshold *entry;
+	int ret;
+
+	lockdep_assert_held(&tz->lock);
+
+	list_for_each_entry(entry, &thresholds->list, list) {
+		ret = cb(entry, arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/thermal_thresholds.h
new file mode 100644
index 000000000000..7c8ce150d6d0
--- /dev/null
+++ b/drivers/thermal/thermal_thresholds.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define THERMAL_THRESHOLD_WAY_UP   BIT(0)
+#define THERMAL_THRESHOLD_WAY_DOWN BIT(1)
+
+struct threshold {
+	int temperature;
+	int direction;
+	struct list_head list;
+};
+
+#ifdef CONFIG_THERMAL_THRESHOLDS
+int thermal_thresholds_init(struct thermal_zone_device *tz);
+void thermal_thresholds_exit(struct thermal_zone_device *tz);
+void thermal_thresholds_flush(struct thermal_zone_device *tz);
+int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction);
+int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction);
+int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high);
+int thermal_thresholds_for_each(struct thermal_zone_device *tz,
+				int (*cb)(struct threshold *, void *arg), void *arg);
+#else
+static inline int thermal_thresholds_init(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static inline void thermal_thresholds_exit(struct thermal_zone_device *tz)
+{
+	;
+}
+
+static inline void thermal_thresholds_flush(struct thermal_zone_device *tz)
+{
+	;
+}
+
+static inline int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	return 0;
+}
+
+static inline int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	return 0;
+}
+
+static inline int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
+{
+	return 0;
+}
+
+static inline int thermal_thresholds_for_each(struct thermal_zone_device *tz,
+					      int (*cb)(struct threshold *, void *arg), void *arg)
+{
+	return 0;
+}
+#endif
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25fbf960b474..bf0b4a8218f6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -55,6 +55,9 @@ enum thermal_notify_event {
 	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
 	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
 	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
+	THERMAL_THRESHOLD_ADDED, /* Threshold added */
+	THERMAL_THRESHOLD_DELETED, /* Threshold deleted */
+	THERMAL_THRESHOLD_FLUSHED, /* All thresholds deleted */
 };
 
 /**
-- 
2.43.0


