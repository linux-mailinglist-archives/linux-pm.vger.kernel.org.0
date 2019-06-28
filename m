Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51A59E77
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfF1PKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 11:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1PKo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 11:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E02208E3;
        Fri, 28 Jun 2019 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561734642;
        bh=ligyUh0vl6BN5j4X/ghSB2LgzxPsWEqkQwkM5Z+7GDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AD4395igOE5xfYXd/8fX1lRQtW8EMyRyzm1jzFrrlg80ljkcHFVf/H0iYUtUUpWAm
         aGtoP7MjVO/xCjl6N6UmX5jxz+dLXxefQ3wXqbrkwjl6y6ii6GbKrq+63ZJMbAypEZ
         mBE4Atc4corK1VJ3DtKsXMGSJPaxUuNmSpXMF2Vw=
Date:   Fri, 28 Jun 2019 17:10:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190628151040.GA14074@kroah.com>
References: <20190627000412.GA527@kroah.com>
 <20190627225335.72107-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627225335.72107-1-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 27, 2019 at 03:53:35PM -0700, Tri Vo wrote:
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
> 
> However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
> 
> Embedding a struct kobject into struct wakeup_source changes lifetime
> requirements on the latter. To that end, change deallocation of struct
> wakeup_source using kfree to kobject_put().
> 
> Change struct wakelock's wakeup_source member to a pointer to decouple
> lifetimes of struct wakelock and struct wakeup_source for above reason.
> 
> Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> source statistics in sysfs.
> 
> Signed-off-by: Tri Vo <trong@android.com>

Ok, this looks much better, but I don't like the use of a "raw" kobject
here.  It is much simpler, and less code, to use 'struct device'
instead.

As proof, I reworked the patch to do just that, and it saves over 50
lines of .c code, which is always nice :)

Attached below is the reworked code, along with the updated
documentation file.  It creates devices in a virtual class, and you can
easily iterate over them all by looking in /sys/class/wakeup/.

Note, I'm note quite sure you need all of the changes you made in
kernel/power/wakelock.c when you make the structure contain a pointer to
the wakeup source and not the structure itself, but I just went with it
and got it all to build properly.

Also note, I've not actually tested this at all, only built it, so I
_strongly_ suggest that you test this to make sure it really works :)

What do you think?

thanks,

greg k-h

------------------



---
 Documentation/ABI/testing/sysfs-power |  73 ++++++++++++-
 drivers/base/power/Makefile           |   1 +
 drivers/base/power/wakeup.c           |  11 +-
 drivers/base/power/wakeup_stats.c     | 144 ++++++++++++++++++++++++++
 include/linux/pm_wakeup.h             |  19 ++++
 kernel/power/Kconfig                  |  10 ++
 kernel/power/wakelock.c               |  40 ++++---
 7 files changed, 280 insertions(+), 18 deletions(-)
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
index 5b2b6a05a4f3..a5e5ffaa4532 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -147,8 +147,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 
 	__pm_relax(ws);
 	wakeup_source_record(ws);
-	kfree_const(ws->name);
-	kfree(ws);
+	wakeup_source_sysfs_remove(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);
 
@@ -205,11 +204,15 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 struct wakeup_source *wakeup_source_register(const char *name)
 {
 	struct wakeup_source *ws;
+	int ret;
 
 	ws = wakeup_source_create(name);
-	if (ws)
+	if (ws) {
+		ret = wakeup_source_sysfs_add(ws);
+		if (ret)
+			return NULL;
 		wakeup_source_add(ws);
-
+	}
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_register);
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
new file mode 100644
index 000000000000..e0c4767304be
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,144 @@
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
+#include <linux/device.h>
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
+	return sprintf(buf, "%lu\n", ws->_name);				\
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
+ * @ws: Wakeup source to be exposed in sysfs.
+ */
+int wakeup_source_sysfs_add(struct wakeup_source *ws)
+{
+	struct device *dev;
+
+	dev = device_create_with_groups(wakeup_class, NULL, MKDEV(0, 0), ws,
+					wakeup_source_groups, "%s", ws->name);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+	ws->dev = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
+
+void wakeup_source_sysfs_remove(struct wakeup_source *ws)
+{
+	put_device(ws->dev);
+	device_unregister(ws->dev);
+}
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
index ce57771fab9b..18ebc4ce817c 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -35,6 +35,7 @@ struct wake_irq;
  * @relax_count: Number of times the wakeup source was deactivated.
  * @expire_count: Number of times the wakeup source's timeout has expired.
  * @wakeup_count: Number of times the wakeup source might abort suspend.
+ * @dev: struct device for sysfs statistics about the wakeup source
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
index 4210152e56f0..dce02c2f4496 100644
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
@@ -112,16 +112,16 @@ static void __wakelocks_gc(struct work_struct *work)
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
 			kfree(wl->name);
@@ -153,6 +153,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	struct rb_node **node = &wakelocks_tree.rb_node;
 	struct rb_node *parent = *node;
 	struct wakelock *wl;
+	int ret;
 
 	while (*node) {
 		int diff;
@@ -187,9 +188,22 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
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
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(ret);
+	}
+
+	wakeup_source_add(wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
 	wakelocks_lru_add(wl);
@@ -233,9 +247,9 @@ int pm_wake_lock(const char *buf)
 		u64 timeout_ms = timeout_ns + NSEC_PER_MSEC - 1;
 
 		do_div(timeout_ms, NSEC_PER_MSEC);
-		__pm_wakeup_event(&wl->ws, timeout_ms);
+		__pm_wakeup_event(wl->ws, timeout_ms);
 	} else {
-		__pm_stay_awake(&wl->ws);
+		__pm_stay_awake(wl->ws);
 	}
 
 	wakelocks_lru_most_recent(wl);
@@ -271,7 +285,7 @@ int pm_wake_unlock(const char *buf)
 		ret = PTR_ERR(wl);
 		goto out;
 	}
-	__pm_relax(&wl->ws);
+	__pm_relax(wl->ws);
 
 	wakelocks_lru_most_recent(wl);
 	wakelocks_gc();
-- 
2.22.0
