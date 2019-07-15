Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FFA69C6E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfGOUM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 16:12:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOUM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 16:12:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so8872717plt.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li8RYbqHJAqtsyTiG54uQLL/IygjnwyqRm9GgtoYvOs=;
        b=EfxVuL5cU/y0Q2g5k9A7wAtk5LRvLMuM48tEEWwcbNh/fT2tAvVOYhO3mz0hoBp8kV
         obl496me+XbYMTVen4spDFvAtQxJ8j1j2OSH6rnsOBC2Yp6vQlIU5VwR4SXfPKIFM6TV
         dMCvEJACaiLZqwSTaKrisnc/ys8oxX/3irnffYAOUVD4O19jBSYpb5GEGq2pxbstDO+b
         aOTssczHiVfKjs/xP+HRr7G8elGWugsgDUoan0tw9VMGb5z8VOTn94/+zWZPR1Cd48Ip
         pOZlkfn1VmZDHE4XlpPbPZR7g7kURrREGWGpvR3/xSj9RiQ0I6eaC9FyMJC8dmKonsc1
         sYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li8RYbqHJAqtsyTiG54uQLL/IygjnwyqRm9GgtoYvOs=;
        b=WAMSi0Y9kfhnwD52g6YgRIsPBU6nVZeVvLBnLd9jg3oIVvdeVJ471G6kafH4FfHpCY
         R9CxIL0IaOd+u1tvcRtYxNQCofhRCFKzL8HMIXHPykbbcwb/KatnVDwExuNrHMoFJ0ls
         CIvzZSf3M4U5czSJS7JuWB/tKch3K1SZ7lP80XIsaAdYefglIeYOs4Y+csWrn0D5bHrj
         vpJCV905/V3lWs0T/R7tPWN0Ykj8JiNktiPs5mIBViJkgQTU+SitqzStTnyC5oyfEUm8
         Wk7oZQyqdDilld+JjbRPIBNFeEN4gjJDf8qlE7ibpJytJetz6lytc51TT5PvXI8/4d2Z
         +Ucw==
X-Gm-Message-State: APjAAAW8t7Urc9sz8uz9p4nBeF9yVLoBCJV16STcx4neNmkrxtOwopyL
        91aedHQGEAsUjhe8BMoZtfc=
X-Google-Smtp-Source: APXvYqwz7srtdqmxAjXn/5qnoqQylSuY//W1A26yj/eKZ8j7Uas56qq5Q+iNrX+t+dgctPNssMqb2w==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr31684150plp.194.1563221545581;
        Mon, 15 Jul 2019 13:12:25 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:acd:159c:264f:41eb])
        by smtp.gmail.com with ESMTPSA id d2sm20173090pfn.29.2019.07.15.13.12.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:25 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
Date:   Mon, 15 Jul 2019 13:11:16 -0700
Message-Id: <20190715201116.221078-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Userspace can use wakeup_sources debugfs node to plot history of suspend
blocking wakeup sources over device's boot cycle. This information can
then be used (1) for power-specific bug reporting and (2) towards
attributing battery consumption to specific processes over a period of
time.

However, debugfs doesn't have stable ABI. For this reason, create a
'struct device' to expose wakeup sources statistics in sysfs under
/sys/class/wakeup/<name>/.

Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
source statistics in sysfs.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
---
 Documentation/ABI/testing/sysfs-power |  73 ++++++++++++-
 drivers/base/power/Makefile           |   1 +
 drivers/base/power/wakeup.c           |  12 ++-
 drivers/base/power/wakeup_stats.c     | 148 ++++++++++++++++++++++++++
 include/linux/pm_wakeup.h             |  19 ++++
 kernel/power/Kconfig                  |  10 ++
 kernel/power/wakelock.c               |  10 ++
 7 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/power/wakeup_stats.c

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 18b7dc929234..ef92628e6fc3 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -300,4 +300,75 @@ Description:
 		attempt.
 
 		Using this sysfs file will override any values that were
-		set using the kernel command line for disk offset.
\ No newline at end of file
+		set using the kernel command line for disk offset.
+
+What:		/sys/class/wakeup/
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/class/wakeup/ directory contains pointers to all
+		wakeup sources in the kernel at that moment in time.
+
+What:		/sys/class/wakeup/.../active_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the number of times the wakeup source was
+		activated.
+
+What:		/sys/class/wakeup/.../event_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the number of signaled wakeup events
+		associated with the wakeup source.
+
+What:		/sys/class/wakeup/.../wakeup_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the number of times the wakeup source might
+		abort suspend.
+
+What:		/sys/class/wakeup/.../expire_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the number of times the wakeup source's
+		timeout has expired.
+
+What:		/sys/class/wakeup/.../active_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the amount of time the wakeup source has
+		been continuously active, in milliseconds.  If the wakeup
+		source is not active, this file contains '0'.
+
+What:		/sys/class/wakeup/.../total_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the total amount of time this wakeup source
+		has been active, in milliseconds.
+
+What:		/sys/class/wakeup/.../max_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the maximum amount of time this wakeup
+		source has been continuously active, in milliseconds.
+
+What:		/sys/class/wakeup/.../last_change_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the monotonic clock time when the wakeup
+		source was touched last time, in milliseconds.
+
+What:		/sys/class/wakeup/.../prevent_suspend_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The file contains the total amount of time this wakeup source
+		has been preventing autosleep, in milliseconds.
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index e1bb691cf8f1..1963f53d9982 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
+obj-$(CONFIG_PM_SLEEP_STATS)	+= wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a05a4f3..fd48e78c06b9 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -205,11 +205,18 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 struct wakeup_source *wakeup_source_register(const char *name)
 {
 	struct wakeup_source *ws;
+	int ret;
 
 	ws = wakeup_source_create(name);
-	if (ws)
+	if (ws) {
+		ret = wakeup_source_sysfs_add(ws);
+		if (ret) {
+			kfree_const(ws->name);
+			kfree(ws);
+			return NULL;
+		}
 		wakeup_source_add(ws);
-
+	}
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_register);
@@ -222,6 +229,7 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 {
 	if (ws) {
 		wakeup_source_remove(ws);
+		wakeup_source_sysfs_remove(ws);
 		wakeup_source_destroy(ws);
 	}
 }
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
new file mode 100644
index 000000000000..2a4d9ace1e19
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wakeup statistics in sysfs
+ *
+ * Copyright (c) 2019 Linux Foundation <gregkh@linuxfoundation.org>
+ * Copyright (c) 2019 Google Inc.
+ */
+
+#include <linux/slab.h>
+#include <linux/kdev_t.h>
+
+#include "power.h"
+
+static struct class *wakeup_class;
+
+#define wakeup_attr(_name)						\
+static ssize_t _name##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct wakeup_source *ws = dev_get_drvdata(dev);		\
+									\
+	return sprintf(buf, "%lu\n", ws->_name);			\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+wakeup_attr(active_count);
+wakeup_attr(event_count);
+wakeup_attr(wakeup_count);
+wakeup_attr(expire_count);
+
+static ssize_t active_time_ms_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+	ktime_t active_time =
+		ws->active ? ktime_sub(ktime_get(), ws->last_time) : 0;
+
+	return sprintf(buf, "%lld\n", ktime_to_ms(active_time));
+}
+static DEVICE_ATTR_RO(active_time_ms);
+
+static ssize_t total_time_ms_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+	ktime_t active_time;
+	ktime_t total_time = ws->total_time;
+
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		total_time = ktime_add(total_time, active_time);
+	}
+	return sprintf(buf, "%lld\n", ktime_to_ms(total_time));
+}
+static DEVICE_ATTR_RO(total_time_ms);
+
+static ssize_t max_time_ms_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+	ktime_t active_time;
+	ktime_t max_time = ws->max_time;
+
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		if (active_time > max_time)
+			max_time = active_time;
+	}
+	return sprintf(buf, "%lld\n", ktime_to_ms(max_time));
+}
+static DEVICE_ATTR_RO(max_time_ms);
+
+static ssize_t last_change_ms_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lld\n", ktime_to_ms(ws->last_time));
+}
+static DEVICE_ATTR_RO(last_change_ms);
+
+static ssize_t prevent_suspend_time_ms_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+	ktime_t prevent_sleep_time = ws->prevent_sleep_time;
+
+	if (ws->active && ws->autosleep_enabled) {
+		prevent_sleep_time = ktime_add(prevent_sleep_time,
+			ktime_sub(ktime_get(), ws->start_prevent_time));
+	}
+	return sprintf(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
+}
+static DEVICE_ATTR_RO(prevent_suspend_time_ms);
+
+static struct attribute *wakeup_source_attrs[] = {
+	&dev_attr_active_count.attr,
+	&dev_attr_event_count.attr,
+	&dev_attr_wakeup_count.attr,
+	&dev_attr_expire_count.attr,
+	&dev_attr_active_time_ms.attr,
+	&dev_attr_total_time_ms.attr,
+	&dev_attr_max_time_ms.attr,
+	&dev_attr_last_change_ms.attr,
+	&dev_attr_prevent_suspend_time_ms.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wakeup_source);
+
+/**
+ * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
+ * @ws: Wakeup source to be added in sysfs.
+ */
+int wakeup_source_sysfs_add(struct wakeup_source *ws)
+{
+	struct device *dev;
+
+	dev = device_create_with_groups(wakeup_class, NULL, MKDEV(0, 0), ws,
+					wakeup_source_groups, "%s", ws->name);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	ws->dev = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
+
+/**
+ * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sysfs.
+ * @ws: Wakeup source to be removed from sysfs.
+ */
+void wakeup_source_sysfs_remove(struct wakeup_source *ws)
+{
+	device_unregister(ws->dev);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
+
+static int __init wakeup_sources_sysfs_init(void)
+{
+	wakeup_class = class_create(THIS_MODULE, "wakeup");
+	if (IS_ERR(wakeup_class))
+		return PTR_ERR(wakeup_class);
+
+	return 0;
+}
+
+postcore_initcall(wakeup_sources_sysfs_init);
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index ce57771fab9b..734141869c17 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -35,6 +35,7 @@ struct wake_irq;
  * @relax_count: Number of times the wakeup source was deactivated.
  * @expire_count: Number of times the wakeup source's timeout has expired.
  * @wakeup_count: Number of times the wakeup source might abort suspend.
+ * @dev: Struct device for sysfs statistics about the wakeup source.
  * @active: Status of the wakeup source.
  * @has_timeout: The wakeup source has been activated with a timeout.
  */
@@ -55,6 +56,7 @@ struct wakeup_source {
 	unsigned long		relax_count;
 	unsigned long		expire_count;
 	unsigned long		wakeup_count;
+	struct device		*dev;
 	bool			active:1;
 	bool			autosleep_enabled:1;
 };
@@ -181,6 +183,23 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_PM_SLEEP_STATS
+
+/* drivers/base/power/wakeup_stats.c */
+int wakeup_source_sysfs_add(struct wakeup_source *ws);
+void wakeup_source_sysfs_remove(struct wakeup_source *ws);
+
+#else /* !CONFIG_PM_SLEEP_STATS */
+
+static inline int wakeup_source_sysfs_add(struct wakeup_source *ws)
+{
+	return 0;
+}
+static inline void wakeup_source_sysfs_remove(struct wakeup_source *ws)
+{ }
+
+#endif /* !CONFIG_PM_SLEEP_STATS */
+
 static inline void wakeup_source_init(struct wakeup_source *ws,
 				      const char *name)
 {
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ff8592ddedee..4d258f34020b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -195,6 +195,16 @@ config PM_SLEEP_DEBUG
 	def_bool y
 	depends on PM_DEBUG && PM_SLEEP
 
+config PM_SLEEP_STATS
+	bool "Wakeup sources statistics"
+	depends on PM_SLEEP
+	help
+	  Expose wakeup sources statistics to user space via sysfs. Collected
+	  statistics are located under /sys/power/wakeup_sources. For more
+	  information, read <file:Documentation/ABI/testing/sysfs-power>.
+
+	  If in doubt, say N.
+
 config DPM_WATCHDOG
 	bool "Device suspend/resume watchdog"
 	depends on PM_DEBUG && PSTORE && EXPERT
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..32726da3d6e6 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -122,6 +122,7 @@ static void __wakelocks_gc(struct work_struct *work)
 
 		if (!active) {
 			wakeup_source_remove(&wl->ws);
+			wakeup_source_sysfs_remove(&wl->ws);
 			rb_erase(&wl->node, &wakelocks_tree);
 			list_del(&wl->lru);
 			kfree(wl->name);
@@ -153,6 +154,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	struct rb_node **node = &wakelocks_tree.rb_node;
 	struct rb_node *parent = *node;
 	struct wakelock *wl;
+	int ret;
 
 	while (*node) {
 		int diff;
@@ -189,6 +191,14 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	}
 	wl->ws.name = wl->name;
 	wl->ws.last_time = ktime_get();
+
+	ret = wakeup_source_sysfs_add(&wl->ws);
+	if (ret) {
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(ret);
+	}
+
 	wakeup_source_add(&wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
-- 
2.22.0.510.g264f2c817a-goog

