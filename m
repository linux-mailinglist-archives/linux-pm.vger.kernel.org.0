Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592C469E73
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfGOVoE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 17:44:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfGOVoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 17:44:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so8341315pgi.6
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwcX/dkPZO+YUYytqSNkV2HekuLHDzOEZ4gSmHw6XCs=;
        b=IUMr38WUHE+QQUrzRJqPCZ9GpMpNgSX9xR8C6R3Yymc/jcpVABhEJHQp5kcI4Ec5aL
         V/tBeoUpA1eimA+ZoQydGe0kjGXOfdQt7GIFWH4laukcBBCgGZZ5B9++7LNsXuaxn1zG
         v2VW9DdEHTeHl1GV8Fn+CYXbX73AqZIjCnpeaRu9I3H/pStR+GLQ8esvTkBiU6u52Xcs
         zgbmugzCzMwxj+KrQRzM70XLLhs9Qvh7BlvQ9y7ivi52Pg2BAZVGkqywHMGSJN4B3VEo
         anoFIFsDmEQy3tVnlavzHFNP5Sq3bRrZYNZ2hxboIigj8qByp/nWRz+F4Mct2os65Hci
         VPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwcX/dkPZO+YUYytqSNkV2HekuLHDzOEZ4gSmHw6XCs=;
        b=JbBKVGhPcgDimmqD0XDUaOjTP/ykm0Ggq9I5K2CIqUIzZjDL53zo8YZds0Jrj/QhjT
         6gJLXjhEBoMZgxB3DgsQiupNANdVG88XyfotSIFX2Zoh5GZbh1g2MKL3PAGNwgFshsUp
         qGL7XCdZeHHc5dYSBgdd61E1zTGIkPn0ZaqEfVgyhlWWnyEvFOQkaVlhNyPPMV2sz6E+
         fMOv0TacJXL4KAzmGBKJXpL/ToDcCUtkA4PyQND1qPbMFa9b5JaE6GCthvpza05A39Ln
         UAU6VltWT/IdL9xDIu8KYFwTOix8XOsFw/7WHWePSrXoAqqNjzTEq6yWpC1ajmzNOJyB
         5Zsw==
X-Gm-Message-State: APjAAAV0clVtYQvm4pz/xrxqKCSiApFeKGO2d0KyRKiJkETjDPIkkZsz
        kYAOKvGEqzjck8FgzMRoKyY=
X-Google-Smtp-Source: APXvYqznDuX3xnOL5tEk5Z28xf3urI0Mp69/vpjGN3f8M/44x1BQmdSkhyM+zzGInIQAIbOZmWSqdg==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr1830952pgh.325.1563227043040;
        Mon, 15 Jul 2019 14:44:03 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:acd:159c:264f:41eb])
        by smtp.gmail.com with ESMTPSA id f19sm24194285pfk.180.2019.07.15.14.44.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 14:44:02 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v4] PM / wakeup: show wakeup sources stats in sysfs
Date:   Mon, 15 Jul 2019 14:43:48 -0700
Message-Id: <20190715214348.81865-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715203651.GA7513@kroah.com>
References: <20190715203651.GA7513@kroah.com>
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

Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 Documentation/ABI/testing/sysfs-class-wakeup |  70 +++++++++
 drivers/base/power/Makefile                  |   1 +
 drivers/base/power/wakeup.c                  |  12 +-
 drivers/base/power/wakeup_stats.c            | 149 +++++++++++++++++++
 include/linux/pm_wakeup.h                    |  19 +++
 kernel/power/Kconfig                         |  10 ++
 kernel/power/wakelock.c                      |  10 ++
 7 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
 create mode 100644 drivers/base/power/wakeup_stats.c

v2:
- Updated Documentation/ABI/, as per Greg.
- Removed locks in attribute functions, as per Greg.
- Lifetimes of struct wakelock and struck wakeup_source are now different due to
  the latter embedding a refcounted kobject. Changed it so that struct wakelock
  only has a pointer to struct wakeup_source, instead of embedding it.
- Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
  sysfs.

v3:
Changes by Greg:
- Reworked code to use 'struct device' instead of raw kobjects.
- Updated documentation file.
- Only link wakeup_stats.o when CONFIG_PM_SLEEP_STATS is enabled.
Changes by Tri:
- Reverted changes to kernel/power/wakelock.c. 'struct device' hides kobject
  operations. So no need to handle lifetimes in wakelock.c

v4:
- Added 'Co-developed-by:' and 'Tested-by:' fields to commit message.
- Moved new documentation to a separate file
  Documentation/ABI/testing/sysfs-class-wakeup, as per Greg.
- Fixed copyright header in drivers/base/power/wakeup_stats.c, as per Greg.

diff --git a/Documentation/ABI/testing/sysfs-class-wakeup b/Documentation/ABI/testing/sysfs-class-wakeup
new file mode 100644
index 000000000000..30fb23eb9112
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-wakeup
@@ -0,0 +1,70 @@
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
index 000000000000..45e15856105b
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wakeup statistics in sysfs
+ *
+ * Copyright (c) 2019 Linux Foundation
+ * Copyright (c) 2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
index ff8592ddedee..604e1f087f14 100644
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
+	  information, read <file:Documentation/ABI/testing/sysfs-class-wakeup>.
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

