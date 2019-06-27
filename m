Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502F258E2F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 00:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfF0Wy2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 18:54:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42898 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfF0Wy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 18:54:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so2056238plb.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tKarvRqt70ZFONMml1vAFnv0tiS/gOicjfAVZhrrus=;
        b=rqB0S7Tdi2IbvGVybH5c3W5X4y50oyHG/HcgyyuXfwRdC1Jhg6+N6EVZUI7zlIAz3n
         HJn6ekMzshXtU095uQoD++hAPqyPvpUdvsWu9TgHCNjxpy5gdppstLHbYSQrdhqvregw
         q3l4zWOY0J49Lo07h8xpNAbWa8ql8liyGHDkC5Dcy9oq9jHc80U1s0yy15qarovHIy6L
         klbGdrRyfrPZxfTIGvvW0qpLlJywppODxmFyHrIbXzqKfrK9xn1jm2XUvtJeZ4k8CzIG
         P8nULgTXbg9b0WgT/MbT++/XaIwftmQF4EvfIWMDVErdVmf3vQ0tpQAlmiciF8FuOaJJ
         ya4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tKarvRqt70ZFONMml1vAFnv0tiS/gOicjfAVZhrrus=;
        b=DX1DpHczhNe7YUOj35Y4J+As3YJcFNwuGYxssWAIkGDEgXWorvz4BfQQiDM9A4/RS+
         dY3A8G5aUmIlLpqDYg3hlOvRUUd2FGJ/WNqRj/XayP48neU+8jxo94W124ttdjDNBV3A
         o7b0fF7UmPi+t+QVU1pu/5Ll4qucM/uBKvJL+ibERJkzieldOdK0FaCl9QKRUFCFjZl/
         iChd4UYx4SwvMSkWWsm7+N9MLGA0jMAqOVwwhUfDjlTjHHKvQ72pnh9j/eNwg04l7wGJ
         NTmB9oYZpEuWtpyNaFg32VnP6YXTPkoSotq7cJSz90GJnsmR6vx1rhKoB/9iWgrEWzu2
         OiEQ==
X-Gm-Message-State: APjAAAVrrqRhsb5QOjA11P2n1jdbLeNidIWMOHpa+qD2zGeduUFuhYa/
        ZH/ypi5/AgXmCH3KrVrCtoaaAg==
X-Google-Smtp-Source: APXvYqyVNkIQD67Qk26NPBUkm32UjYTdg3M7OyIo3hSXI2z25AL7phzbD4ZvckXCUNKNoqG5JptGZA==
X-Received: by 2002:a17:902:2869:: with SMTP id e96mr7218216plb.203.1561676066904;
        Thu, 27 Jun 2019 15:54:26 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:acd:159c:264f:41eb])
        by smtp.gmail.com with ESMTPSA id u10sm160454pgk.41.2019.06.27.15.54.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:54:26 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v2] PM / wakeup: show wakeup sources stats in sysfs
Date:   Thu, 27 Jun 2019 15:53:35 -0700
Message-Id: <20190627225335.72107-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190627000412.GA527@kroah.com>
References: <20190627000412.GA527@kroah.com>
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

However, debugfs doesn't have stable ABI. For this reason, expose wakeup
sources statistics in sysfs under /sys/power/wakeup_sources/<name>/

Embedding a struct kobject into struct wakeup_source changes lifetime
requirements on the latter. To that end, change deallocation of struct
wakeup_source using kfree to kobject_put().

Change struct wakelock's wakeup_source member to a pointer to decouple
lifetimes of struct wakelock and struct wakeup_source for above reason.

Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
source statistics in sysfs.

Signed-off-by: Tri Vo <trong@android.com>
---
 Documentation/ABI/testing/sysfs-power |  80 ++++++++++-
 drivers/base/power/Makefile           |   2 +-
 drivers/base/power/power.h            |   7 +
 drivers/base/power/wakeup.c           |  16 ++-
 drivers/base/power/wakeup_stats.c     | 194 ++++++++++++++++++++++++++
 include/linux/pm_wakeup.h             |  15 ++
 kernel/power/Kconfig                  |  10 ++
 kernel/power/wakelock.c               |  42 ++++--
 8 files changed, 347 insertions(+), 19 deletions(-)
 create mode 100644 drivers/base/power/wakeup_stats.c

v2:
- Updated Documentation/ABI/, as per Greg.
- Removed locks in attribute functions, as per Greg.
- Lifetimes of struct wakelock and struck wakeup_source are now different due to
  the latter embedding a refcounted kobject. Changed it so that struct wakelock
  only has a pointer to struct wakeup_source, instead of embedding it.
- Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
  sysfs.

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 18b7dc929234..ba35f1eef73b 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -300,4 +300,82 @@ Description:
 		attempt.

 		Using this sysfs file will override any values that were
-		set using the kernel command line for disk offset.
\ No newline at end of file
+		set using the kernel command line for disk offset.
+
+What:		/sys/power/wakeup_sources/.../
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../ directory contains attributes
+		that expose statistics about a given wakeup source to user
+		space.  Attributes in this directory are read-only.
+
+What:		/sys/power/wakeup_sources/.../active_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../active_count file contains the
+		number of times the wakeup source was activated.
+
+What:		/sys/power/wakeup_sources/.../event_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../event_count file contains the
+		number of signaled wakeup events associated with the wakeup
+		source.
+
+What:		/sys/power/wakeup_sources/.../wakeup_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../wakeup_count file contains the
+		number of times the wakeup source might abort suspend.
+
+What:		/sys/power/wakeup_sources/.../expire_count
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../expire_count file contains the
+		number of times the wakeup source's timeout has expired.
+
+What:		/sys/power/wakeup_sources/.../active_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../active_time_ms file contains
+		the amount of time the wakeup source has been continuously
+		active, in milliseconds.  If the wakeup source is not active,
+		this file contains '0'.
+
+What:		/sys/power/wakeup_sources/.../total_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../total_time_ms file contains
+		the total amount of time this wakeup source has been active, in
+		milliseconds.
+
+What:		/sys/power/wakeup_sources/.../max_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../max_time_ms file contains the
+		maximum amount of time this wakeup source has been continuously
+		active, in milliseconds.
+
+What:		/sys/power/wakeup_sources/.../last_change_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../last_change_ms file contains
+		the monotonic clock time when the wakeup source was touched last
+		time, in milliseconds.
+
+What:		/sys/power/wakeup_sources/.../prevent_suspend_time_ms
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/power/wakeup_sources/.../prevent_suspend_time_ms file
+		contains the total amount of time this wakeup source has been
+		preventing autosleep, in milliseconds.
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index e1bb691cf8f1..ec5bb190b9d0 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o wakeup_stats.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index ec33fbdb919b..c288298f57c0 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -149,3 +149,10 @@ static inline void device_pm_init(struct device *dev)
 	device_pm_sleep_init(dev);
 	pm_runtime_init(dev);
 }
+
+#ifdef CONFIG_PM_SLEEP
+
+/* drivers/base/power/wakeup_stats.c */
+extern struct kobj_type wakeup_source_ktype;
+
+#endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a05a4f3..620c87923a3e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -102,6 +102,9 @@ struct wakeup_source *wakeup_source_create(const char *name)
 		return NULL;

 	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
+
+	kobject_init(&ws->kobj, &wakeup_source_ktype);
+
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
@@ -147,8 +150,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)

 	__pm_relax(ws);
 	wakeup_source_record(ws);
-	kfree_const(ws->name);
-	kfree(ws);
+	kobject_put(&ws->kobj);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);

@@ -205,11 +207,17 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 struct wakeup_source *wakeup_source_register(const char *name)
 {
 	struct wakeup_source *ws;
+	int ret;

 	ws = wakeup_source_create(name);
-	if (ws)
+	if (ws) {
+		ret = wakeup_source_sysfs_add(ws);
+		if (ret) {
+			kobject_put(&ws->kobj);
+			return NULL;
+		}
 		wakeup_source_add(ws);
-
+	}
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_register);
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
new file mode 100644
index 000000000000..05ab8283ed66
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+
+#include "power.h"
+
+struct wakeup_source_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct wakeup_source *ws,
+			struct wakeup_source_attribute *attr, char *buf);
+	ssize_t (*store)(struct wakeup_source *ws,
+			 struct wakeup_source_attribute *attr, const char *buf,
+			 size_t count);
+};
+
+#define to_wakeup_source_obj(x) container_of(x, struct wakeup_source, kobj)
+#define to_wakeup_source_attr(x) \
+	container_of(x, struct wakeup_source_attribute, attr)
+
+static ssize_t wakeup_source_attr_show(struct kobject *kobj,
+				       struct attribute *attr,
+				       char *buf)
+{
+	struct wakeup_source_attribute *attribute;
+	struct wakeup_source *ws;
+
+	ws = to_wakeup_source_obj(kobj);
+	attribute = to_wakeup_source_attr(attr);
+
+	if (!attribute->show)
+		return -EIO;
+
+	return attribute->show(ws, attribute, buf);
+}
+
+static const struct sysfs_ops wakeup_source_sysfs_ops = {
+	.show = wakeup_source_attr_show,
+};
+
+static void wakeup_source_release(struct kobject *kobj)
+{
+	struct wakeup_source *ws;
+
+	ws = to_wakeup_source_obj(kobj);
+	kfree_const(ws->name);
+	kfree(ws);
+}
+
+static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
+					struct wakeup_source_attribute *attr,
+					char *buf)
+{
+	unsigned long var;
+
+	if (strcmp(attr->attr.name, "active_count") == 0)
+		var = ws->active_count;
+	else if (strcmp(attr->attr.name, "event_count") == 0)
+		var = ws->event_count;
+	else if (strcmp(attr->attr.name, "wakeup_count") == 0)
+		var = ws->wakeup_count;
+	else
+		var = ws->expire_count;
+
+	return sprintf(buf, "%lu\n", var);
+}
+
+#define wakeup_source_count_attr(_name)			\
+static struct wakeup_source_attribute _name##_attr = {	\
+	.attr	= {					\
+		.name = __stringify(_name),		\
+		.mode = 0444,				\
+	},						\
+	.show	= wakeup_source_count_show,		\
+}
+
+wakeup_source_count_attr(active_count);
+wakeup_source_count_attr(event_count);
+wakeup_source_count_attr(wakeup_count);
+wakeup_source_count_attr(expire_count);
+
+#define wakeup_source_attr(_name) \
+static struct wakeup_source_attribute _name##_attr = __ATTR_RO(_name)
+
+static ssize_t active_time_ms_show(struct wakeup_source *ws,
+				struct wakeup_source_attribute *attr,
+				char *buf)
+{
+	ktime_t active_time =
+		ws->active ? ktime_sub(ktime_get(), ws->last_time) : 0;
+	return sprintf(buf, "%lld\n", ktime_to_ms(active_time));
+}
+wakeup_source_attr(active_time_ms);
+
+static ssize_t total_time_ms_show(struct wakeup_source *ws,
+			       struct wakeup_source_attribute *attr,
+			       char *buf)
+{
+	ktime_t active_time;
+	ktime_t total_time = ws->total_time;
+
+	if (ws->active) {
+		active_time = ktime_sub(ktime_get(), ws->last_time);
+		total_time = ktime_add(total_time, active_time);
+	}
+	return sprintf(buf, "%lld\n", ktime_to_ms(total_time));
+}
+wakeup_source_attr(total_time_ms);
+
+static ssize_t max_time_ms_show(struct wakeup_source *ws,
+			     struct wakeup_source_attribute *attr,
+			     char *buf)
+{
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
+wakeup_source_attr(max_time_ms);
+
+static ssize_t last_change_ms_show(struct wakeup_source *ws,
+				struct wakeup_source_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "%lld\n", ktime_to_ms(ws->last_time));
+}
+wakeup_source_attr(last_change_ms);
+
+static ssize_t prevent_suspend_time_ms_show(struct wakeup_source *ws,
+					 struct wakeup_source_attribute *attr,
+					 char *buf)
+{
+	ktime_t prevent_sleep_time = ws->prevent_sleep_time;
+
+	if (ws->active && ws->autosleep_enabled) {
+		prevent_sleep_time = ktime_add(prevent_sleep_time,
+			ktime_sub(ktime_get(), ws->start_prevent_time));
+	}
+	return sprintf(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
+}
+wakeup_source_attr(prevent_suspend_time_ms);
+
+static struct attribute *wakeup_source_default_attrs[] = {
+	&active_count_attr.attr,
+	&event_count_attr.attr,
+	&wakeup_count_attr.attr,
+	&expire_count_attr.attr,
+	&active_time_ms_attr.attr,
+	&total_time_ms_attr.attr,
+	&max_time_ms_attr.attr,
+	&last_change_ms_attr.attr,
+	&prevent_suspend_time_ms_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wakeup_source_default);
+
+struct kobj_type wakeup_source_ktype = {
+	.sysfs_ops = &wakeup_source_sysfs_ops,
+	.release = wakeup_source_release,
+	.default_groups = wakeup_source_default_groups,
+};
+
+#ifdef CONFIG_PM_SLEEP_STATS
+
+static struct kset *wakeup_source_kset;
+
+/**
+ * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
+ * @ws: Wakeup source to be exposed in sysfs.
+ */
+int wakeup_source_sysfs_add(struct wakeup_source *ws)
+{
+	ws->kobj.kset = wakeup_source_kset;
+	return kobject_add(&ws->kobj, NULL, "%s", ws->name);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
+
+static int __init wakeup_sources_sysfs_init(void)
+{
+	wakeup_source_kset = kset_create_and_add("wakeup_sources", NULL,
+			power_kobj);
+	if (!wakeup_source_kset)
+		return -ENOMEM;
+
+	return 0;
+}
+
+postcore_initcall(wakeup_sources_sysfs_init);
+
+#endif /* !CONFIG_PM_SLEEP_STATS */
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index ce57771fab9b..67026c52975c 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -57,6 +57,7 @@ struct wakeup_source {
 	unsigned long		wakeup_count;
 	bool			active:1;
 	bool			autosleep_enabled:1;
+	struct kobject		kobj;
 };

 #ifdef CONFIG_PM_SLEEP
@@ -181,6 +182,20 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,

 #endif /* !CONFIG_PM_SLEEP */

+#ifdef CONFIG_PM_SLEEP_STATS
+
+/* drivers/base/power/wakeup_stats.c */
+extern int wakeup_source_sysfs_add(struct wakeup_source *ws);
+
+#else /* !CONFIG_PM_SLEEP_STATS */
+
+static inline int wakeup_source_sysfs_add(struct wakeup_source *ws)
+{
+	return 0;
+}
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
index 4210152e56f0..eebbc537321f 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(wakelocks_lock);
 struct wakelock {
 	char			*name;
 	struct rb_node		node;
-	struct wakeup_source	ws;
+	struct wakeup_source	*ws;
 #ifdef CONFIG_PM_WAKELOCKS_GC
 	struct list_head	lru;
 #endif
@@ -46,7 +46,7 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)

 	for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
 		wl = rb_entry(node, struct wakelock, node);
-		if (wl->ws.active == show_active)
+		if (wl->ws->active == show_active)
 			str += scnprintf(str, end - str, "%s ", wl->name);
 	}
 	if (str > buf)
@@ -112,18 +112,19 @@ static void __wakelocks_gc(struct work_struct *work)
 		u64 idle_time_ns;
 		bool active;

-		spin_lock_irq(&wl->ws.lock);
-		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws.last_time));
-		active = wl->ws.active;
-		spin_unlock_irq(&wl->ws.lock);
+		spin_lock_irq(&wl->ws->lock);
+		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws->last_time));
+		active = wl->ws->active;
+		spin_unlock_irq(&wl->ws->lock);

 		if (idle_time_ns < ((u64)WL_GC_TIME_SEC * NSEC_PER_SEC))
 			break;

 		if (!active) {
-			wakeup_source_remove(&wl->ws);
+			wakeup_source_remove(wl->ws);
 			rb_erase(&wl->node, &wakelocks_tree);
 			list_del(&wl->lru);
+			kobject_put(&wl->ws->kobj);
 			kfree(wl->name);
 			kfree(wl);
 			decrement_wakelocks_number();
@@ -153,6 +154,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	struct rb_node **node = &wakelocks_tree.rb_node;
 	struct rb_node *parent = *node;
 	struct wakelock *wl;
+	int ret;

 	while (*node) {
 		int diff;
@@ -187,9 +189,23 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 		kfree(wl);
 		return ERR_PTR(-ENOMEM);
 	}
-	wl->ws.name = wl->name;
-	wl->ws.last_time = ktime_get();
-	wakeup_source_add(&wl->ws);
+
+	wl->ws = wakeup_source_create(wl->name);
+	if (!wl->ws) {
+		kfree(wl);
+		return ERR_PTR(-ENOMEM);
+	}
+	wl->ws->last_time = ktime_get();
+
+	ret = wakeup_source_sysfs_add(wl->ws);
+	if (ret) {
+		kobject_put(&wl->ws->kobj);
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(ret);
+	}
+
+	wakeup_source_add(wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
 	wakelocks_lru_add(wl);
@@ -233,9 +249,9 @@ int pm_wake_lock(const char *buf)
 		u64 timeout_ms = timeout_ns + NSEC_PER_MSEC - 1;

 		do_div(timeout_ms, NSEC_PER_MSEC);
-		__pm_wakeup_event(&wl->ws, timeout_ms);
+		__pm_wakeup_event(wl->ws, timeout_ms);
 	} else {
-		__pm_stay_awake(&wl->ws);
+		__pm_stay_awake(wl->ws);
 	}

 	wakelocks_lru_most_recent(wl);
@@ -271,7 +287,7 @@ int pm_wake_unlock(const char *buf)
 		ret = PTR_ERR(wl);
 		goto out;
 	}
-	__pm_relax(&wl->ws);
+	__pm_relax(wl->ws);

 	wakelocks_lru_most_recent(wl);
 	wakelocks_gc();
--
2.22.0.410.gd8fdbe21b5-goog

