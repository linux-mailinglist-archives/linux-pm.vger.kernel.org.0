Return-Path: <linux-pm+bounces-14559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC94597E931
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839DA28115F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C41946CD;
	Mon, 23 Sep 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRSxsDRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AD39AE3
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085614; cv=none; b=o3z+ETHirIUTn+HalQaeS36qB1C5qApQhPD9JSoC6530QqPViJSr7Wgu5jq09o1ThMK2jz7gfRsQ9JPo6G920ss1J8yurRWDepMz4Dnx+BnaT2liNhI/9XALdQbrs6TVLUFW5d+LB12NpEO1sOUtV6Zhs23EGtJ+q6mshoD0fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085614; c=relaxed/simple;
	bh=OB2xUZYGxWedeuqvHkT1CXBOirhzDamRF2CCikuWQLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMBMIEtGlm3aSqjk7mJ5Olms8k+T0lmLwkd3cQf6rnZzocsiD11IO4kw/Ed8wEAkzo+/Wu3+lWeXjl/E5PG5MI1qc69I8ezn8P+zpxKr6AKzTND2p+P3pOvtErFA8XJpIsI5lU9G3dgEIwBENu7R6kcZEoWFaWiyJXFswe1GdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lRSxsDRw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2951475f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085611; x=1727690411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S81Xdhhpdgjm9+1OIil72SYpiWwe4A9pFc1/W5gcRjs=;
        b=lRSxsDRwKZp5CrUkIeVmmM8HcRr50ucZq5W0/EKVwO3v0ugfI/wqhsrzcUpmCpLX3k
         BOOtrPYlX8t1Dc2lJbNdwTciln5AwKq5hdcPnYucZNptaD9WcBW3cTGqL54EsmPZPhQe
         UtMs4q9OgypqmyJBxLgIOUtq18Ul9Qz0EVwyJGzmnU6Qtd4HgFPPL7sG75I8vCRqLZIL
         BzH7qqQQvryBeXH3aoSkZShJ9Ofdpi2SaxR2GImMscYA+Ygtj62i7dKPQGp84+5+ky1e
         xdgzN/ghtc6EL5kz3FGKmUR2bV0loKAg4aUi6+mxG8oj4mVxkWrsJtnnHUHfz5uQbHRZ
         5HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085611; x=1727690411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S81Xdhhpdgjm9+1OIil72SYpiWwe4A9pFc1/W5gcRjs=;
        b=PpVOb2a0OLcS2YTnrBjznz3Yh8+B3DcU1MFge5fj6kakhJndKt2FuIQ0Q12YGhZscb
         c9bQIgH4K0qoIVTn2M8B38KX0W8IOAK6kAeVDhRukSVsGJ77rHNtXOUsbgSbZ1a9nRxE
         VGGAnaiKVbEHBGntRx/YP8w8da0AsIdpNC0zpz1TgP3nWUjf2kaiS6hjWfADw9Akq+Pl
         9vW+2EAW2IDIt1/MdqED6i7h7XFIVB3BA7zWn3xfpmjXz8fBhvEqsIosmPDlmF/Cd2Fe
         9F8e/ykZ7ZWKUYnEWIx9uHQ0sskrmSHzfwqCwh6dRFTxtteK4O1jzO24auE6aGp1oI7w
         XfTw==
X-Gm-Message-State: AOJu0YwRdjKb2qEbUvHFw/63jFMww+605xhZT29b5V5BRyz7G6TABdgd
	XWBHD3ru89y/u1G8nRBNxKYuF4Hl8iXU+C5vjvScEQK5kNxHVMwGjN3vR7fZbh0=
X-Google-Smtp-Source: AGHT+IEkn3zw9tNS/V3If70n59WTrrgiBVNznJN3wL8J9odFznZCL4ky9yQS2mCcipTKjdtOe/ZfdQ==
X-Received: by 2002:a5d:4e09:0:b0:374:c454:dbb3 with SMTP id ffacd0b85a97d-37a431be7aemr5375128f8f.55.1727085610960;
        Mon, 23 Sep 2024 03:00:10 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:10 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 1/6] thermal/core: Add user thresholds support
Date: Mon, 23 Sep 2024 11:59:57 +0200
Message-ID: <20240923100005.2532430-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user thresholds mechanism is a way to have the userspace to tell
the thermal framework to send a notification when a temperature limit
is crossed. There is no id, no hysteresis, just the temperature and
the direction of the limit crossing. That means we can be notified
when a threshold is crossed the way up only, or the way down only or
both ways. That allows to create hysteresis values if it is needed.

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
 drivers/thermal/Makefile             |   1 +
 drivers/thermal/thermal_core.h       |   2 +
 drivers/thermal/thermal_thresholds.c | 229 +++++++++++++++++++++++++++
 drivers/thermal/thermal_thresholds.h |  19 +++
 include/linux/thermal.h              |   3 +
 include/uapi/linux/thermal.h         |   2 +
 6 files changed, 256 insertions(+)
 create mode 100644 drivers/thermal/thermal_thresholds.c
 create mode 100644 drivers/thermal/thermal_thresholds.h

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 41c4d56beb40..1e1559bb971e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -6,6 +6,7 @@ CFLAGS_thermal_core.o		:= -I$(src)
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o
 thermal_sys-y			+= thermal_trip.o thermal_helpers.o
+thermal_sys-y			+= thermal_thresholds.o
 
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 50b858aa173a..8f320d17d927 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_thresholds.h"
 #include "thermal_debugfs.h"
 
 struct thermal_attr {
@@ -139,6 +140,7 @@ struct thermal_zone_device {
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
+	struct list_head user_thresholds;
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
new file mode 100644
index 000000000000..f33b6d5474d8
--- /dev/null
+++ b/drivers/thermal/thermal_thresholds.c
@@ -0,0 +1,229 @@
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
+#include "thermal_thresholds.h"
+
+int thermal_thresholds_init(struct thermal_zone_device *tz)
+{
+	INIT_LIST_HEAD(&tz->user_thresholds);
+
+	return 0;
+}
+
+void thermal_thresholds_flush(struct thermal_zone_device *tz)
+{
+	struct list_head *thresholds = &tz->user_thresholds;
+	struct user_threshold *entry, *tmp;
+
+	lockdep_assert_held(&tz->lock);
+
+	list_for_each_entry_safe(entry, tmp, thresholds, list_node) {
+		list_del(&entry->list_node);
+		kfree(entry);
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
+}
+
+void thermal_thresholds_exit(struct thermal_zone_device *tz)
+{
+	thermal_thresholds_flush(tz);
+}
+
+static int __thermal_thresholds_cmp(void *data,
+				    const struct list_head *l1,
+				    const struct list_head *l2)
+{
+	struct user_threshold *t1 = container_of(l1, struct user_threshold, list_node);
+	struct user_threshold *t2 = container_of(l2, struct user_threshold, list_node);
+
+	return t1->temperature - t2->temperature;
+}
+
+static struct user_threshold *__thermal_thresholds_find(const struct list_head *thresholds,
+							int temperature)
+{
+	struct user_threshold *t;
+
+	list_for_each_entry(t, thresholds, list_node)
+		if (t->temperature == temperature)
+			return t;
+
+	return NULL;
+}
+
+static bool __thermal_threshold_is_crossed(struct user_threshold *threshold, int temperature,
+					   int last_temperature, int direction,
+					   int *low, int *high)
+{
+
+	if (temperature >= threshold->temperature) {
+		if (threshold->temperature > *low &&
+		    THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
+			*low = threshold->temperature;
+
+		if (last_temperature < threshold->temperature &&
+		    threshold->direction & direction)
+			return true;
+	} else {
+		if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
+		    & threshold->direction)
+			*high = threshold->temperature;
+
+		if (last_temperature >= threshold->temperature &&
+		    threshold->direction & direction)
+			return true;
+	}
+
+	return false;
+}
+
+static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
+					      int last_temperature, int *low, int *high)
+{
+	struct user_threshold *t;
+
+	list_for_each_entry(t, thresholds, list_node) {
+		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
+						   THERMAL_THRESHOLD_WAY_UP, low, high))
+			return true;
+	}
+
+	return false;
+}
+
+static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
+					       int last_temperature, int *low, int *high)
+{
+	struct user_threshold *t;
+
+	list_for_each_entry_reverse(t, thresholds, list_node) {
+		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
+						   THERMAL_THRESHOLD_WAY_DOWN, low, high))
+			return true;
+	}
+
+	return false;
+}
+
+void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
+{
+	struct list_head *thresholds = &tz->user_thresholds;
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
+		return;
+
+	/*
+	 * The temperature is stable, so obviously we can not have
+	 * crossed a threshold.
+	 */
+	if (last_temperature == temperature)
+		return;
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
+}
+
+int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	struct list_head *thresholds = &tz->user_thresholds;
+	struct user_threshold *t;
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
+		INIT_LIST_HEAD(&t->list_node);
+		t->temperature = temperature;
+		t->direction = direction;
+		list_add(&t->list_node, thresholds);
+		list_sort(NULL, thresholds, __thermal_thresholds_cmp);
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
+
+	return 0;
+}
+
+int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
+{
+	struct list_head *thresholds = &tz->user_thresholds;
+	struct user_threshold *t;
+
+	lockdep_assert_held(&tz->lock);
+
+	t = __thermal_thresholds_find(thresholds, temperature);
+	if (!t)
+		return -ENOENT;
+
+	if (t->direction == direction) {
+		list_del(&t->list_node);
+		kfree(t);
+	} else {
+		t->direction &= ~direction;
+	}
+
+	__thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
+
+	return 0;
+}
+
+int thermal_thresholds_for_each(struct thermal_zone_device *tz,
+				int (*cb)(struct user_threshold *, void *arg), void *arg)
+{
+	struct list_head *thresholds = &tz->user_thresholds;
+	struct user_threshold *entry;
+	int ret;
+
+	lockdep_assert_held(&tz->lock);
+
+	list_for_each_entry(entry, thresholds, list_node) {
+		ret = cb(entry, arg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/thermal_thresholds.h
new file mode 100644
index 000000000000..232f4e8089af
--- /dev/null
+++ b/drivers/thermal/thermal_thresholds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __THERMAL_THRESHOLDS_H__
+#define __THERMAL_THRESHOLDS_H__
+
+struct user_threshold {
+	struct list_head list_node;
+	int temperature;
+	int direction;
+};
+
+int thermal_thresholds_init(struct thermal_zone_device *tz);
+void thermal_thresholds_exit(struct thermal_zone_device *tz);
+void thermal_thresholds_flush(struct thermal_zone_device *tz);
+void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high);
+int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction);
+int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction);
+int thermal_thresholds_for_each(struct thermal_zone_device *tz,
+				int (*cb)(struct user_threshold *, void *arg), void *arg);
+#endif
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 25ea8fe2313e..bcaa92732e14 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -56,6 +56,9 @@ enum thermal_notify_event {
 	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
 	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
 	THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep */
+	THERMAL_TZ_ADD_THRESHOLD, /* Threshold added */
+	THERMAL_TZ_DEL_THRESHOLD, /* Threshold deleted */
+	THERMAL_TZ_FLUSH_THRESHOLDS, /* All thresholds deleted */
 };
 
 /**
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index fc78bf3aead7..3e7c1c2e71a7 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -3,6 +3,8 @@
 #define _UAPI_LINUX_THERMAL_H
 
 #define THERMAL_NAME_LENGTH	20
+#define THERMAL_THRESHOLD_WAY_UP	0x1
+#define THERMAL_THRESHOLD_WAY_DOWN	0x2
 
 enum thermal_device_mode {
 	THERMAL_DEVICE_DISABLED = 0,
-- 
2.43.0


