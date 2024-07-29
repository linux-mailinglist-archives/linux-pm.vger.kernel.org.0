Return-Path: <linux-pm+bounces-11546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F593F8FE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EC41F22EF8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86621156F28;
	Mon, 29 Jul 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXdBn19D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F315666D
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265419; cv=none; b=kk3m1QiO4uUTj0RIY2JVSNm/SX4Qmpm+4td/mNzEKqr/JEa3skDnCSWnRsDw/L0LGjQtSZRpQm7S5sl8vksZOelgabre0VhZoshRc7IYL3I9DIkWfnL9/MHsMdpeunI/9GBswbdtJkcSInW5rW2+yT3j3F4oo9z73RxoyJ3f8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265419; c=relaxed/simple;
	bh=V3Jv5lQ349hQFm3CIxs/YTGx4CZG3dm7HF9MHFBfhSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MolxQNLUhA/EyOSf78+4bXeBWTXHCMMEXI4z6ZqtsSL4mcGU41wg9Y5upVdOtt7lEwKHL39Ac3whHu71JCCxB4/zSI7zZG8vKWO6yPrKjHyH47ZrK1PSIv/fOSo1R2k4uWRcBUBTa3XDRqtsH+rWv7qsuqtRuSm0Hq9m4CQFi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kXdBn19D; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef23d04541so44929381fa.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265415; x=1722870215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7k+J4GKlvNWueEcnY3YKZZwOsvS3fdyymDdUlp7zrk=;
        b=kXdBn19DN5E++EVJUgx0Fgt8ZVKEFQCjEYiHFzqqlwgu7dO7JDYcOVjkUvpUI428Jj
         eV7QjGTJqlfizB59KzOZgrNbXvXoYe0zhks+8dP91VSJ70uYD2peMYm87+ViI6CzJQ+e
         T0uUXzskx/LqYlqtDRd0rBXQ6Fzgym2iwsjarGP5IHePCV1TdXBn7jI7UkB1P6UufBEB
         VYkYJRcX976NcfssdPqQRN+PhlchXYGJIcV6C6mZdnftZfpGTvUfotGHKX1cvtOg9Mnu
         OMTXDl+8aQuNhe9t+X+XGm5NUrXHLcx7j96aJhOgNJjfFzaHxOf8ZQIPqGQly/bQ31Eb
         RyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265415; x=1722870215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7k+J4GKlvNWueEcnY3YKZZwOsvS3fdyymDdUlp7zrk=;
        b=isRb4+9Lr1KSkCEvpjZ24nMvZlU2qSSwkfOdj/ijLV+pCPR2Wl641f3qL5QkLBexy/
         iyyaK3ba1XRU8mZ9EIRfpKg96QOKfyXbva3n2tDxzR8yoZBlonsZ8VlN26K4Ej4LDJk1
         00I7ZnpgB3Nw4YWj6xyzCKAiYKQMTRY8EXgAJNhTeQfAM01eoOelSwOVy1JWIWzq+a0N
         9vQiosBxmOq8hu5vkjAtSVTnpl/RVoMIqQJMC36vl0L/oZuon/YQkYvzM2f1woHoFYdc
         zgyqlzegiVj52Biybkfyi9x3E3/iqNBEY6eDVRbg0Y+8r9EGdyELCAGtgNDHo0j2iXwD
         v47A==
X-Gm-Message-State: AOJu0Yzf3zOunBklTkS9USMUH3TXeFFfu9M60Jjfj/qUSIewZZk2M5Am
	mOZZHIaRJ6eCoRX4b0y7D5cNYAyhwK1RQatsT115M0fpRZri55AUltat72CN6+w=
X-Google-Smtp-Source: AGHT+IGuFf0bMWlNWRD7NCduCQbPGdXdjVTg4Y9BayFBYL3dxpT9oRev9mXgnlhMRC9HytFyESxQEw==
X-Received: by 2002:a2e:800f:0:b0:2f0:27e4:3a43 with SMTP id 38308e7fff4ca-2f12edfd2d2mr49185011fa.11.1722265415093;
        Mon, 29 Jul 2024 08:03:35 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:34 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 2/7] thermal/core: Add thresholds support
Date: Mon, 29 Jul 2024 17:02:51 +0200
Message-ID: <20240729150259.1089814-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_thresholds.c | 240 +++++++++++++++++++++++++++
 drivers/thermal/thermal_thresholds.h |  57 +++++++
 include/linux/thermal.h              |   3 +
 6 files changed, 322 insertions(+)
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
index 000000000000..7506684cca58
--- /dev/null
+++ b/drivers/thermal/thermal_thresholds.c
@@ -0,0 +1,240 @@
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


