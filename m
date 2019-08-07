Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21E841D2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 03:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfHGBtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 21:49:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43783 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfHGBtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 21:49:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so31602304pld.10
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfxjrekdfJFwuPBA/fTcfe+/pToCLjODdfhKs+8ZwhM=;
        b=SvKRPYFj9U8muVerte+FwOuRcPWHfE4jnuPz4J1CiBp+oxGoJlgqF0/9cQ9pQFi7mM
         Cg2bvf7mw5xg9XC1ZvtTvFIE5kWzOIbFLYtV8opqubMMR2gkANklciUJ3ugwhvpi/4Dw
         KO0pxLoUINSwHCMtpJzLKheiDSkSyxlWSZHyRfuuLtS0vfAiMJ2yO7AksrwRObCmexfG
         mGeqp7V3+Q7bTuWmOwJxziwlg2kyd9ZM8Lcnn+I3aKZrDahox2GFZ2f3OuKbmBhBniqV
         mWhDaFshOf4zKZtwJ/JG0BTMeh2jJFhngBo6c0p2qMVYGmAioag8kBdJppSu+8teiihi
         91BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfxjrekdfJFwuPBA/fTcfe+/pToCLjODdfhKs+8ZwhM=;
        b=AjRNlHfMVSU1kqTUerTRisZbOlfDSU2P7jahEarhE81KB1qvuZkRjPKA58QkCBG2Ys
         Qslm3XF0F8n2nX9WjOPC9ks4qdzRUCZ4dE1qoV8JEHVVhkFdqZ0HNKZ7Mt1xvuQ5d2/0
         86lrxHvHfGeAGXEKqRLWQqrNwkp0ntPvn9qmK22lYwH0oMxV8m7QFRfQaaU008XS6Swi
         G8Z9wx12cuVVTcTSTTjl06Vjsq9rCt5mtuYtbXFBb6XAVw+LbfSz3vy0sJNIzh+cGigX
         2NXgOt4x/hzfYaemVS7lDXzb1v5oDIhj2fo1a7NuQUkLd5xBjwmCtmimhppxJlc0AmWk
         qz7w==
X-Gm-Message-State: APjAAAVS/p9PeobIgOMY6stI7BQd/EuuJXQ07PHhYWclj3UoKAyObfTG
        4ZIZTmz28YQ6XCmRsqDruclJKg==
X-Google-Smtp-Source: APXvYqyQwpZKUV/3fU6ogCfXELkAxr0zLA3MSQVxykU9UScb49KInzS/U2AKziX6OPPQhP5ULt6yAw==
X-Received: by 2002:a17:902:2aa9:: with SMTP id j38mr5650509plb.206.1565142552678;
        Tue, 06 Aug 2019 18:49:12 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id q1sm104159076pfg.84.2019.08.06.18.49.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:49:12 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v8 3/3] PM / wakeup: Show wakeup sources stats in sysfs
Date:   Tue,  6 Aug 2019 18:48:46 -0700
Message-Id: <20190807014846.143949-4-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807014846.143949-1-trong@android.com>
References: <20190807014846.143949-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add an ID and a device pointer to 'struct wakeup_source'. Use them to to
expose wakeup sources statistics in sysfs under
/sys/class/wakeup/wakeup<ID>/*.

Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++
 drivers/acpi/device_pm.c                     |   3 +-
 drivers/base/power/Makefile                  |   2 +-
 drivers/base/power/power.h                   |   9 +
 drivers/base/power/wakeup.c                  |  28 ++-
 drivers/base/power/wakeup_stats.c            | 203 +++++++++++++++++++
 fs/eventpoll.c                               |   4 +-
 include/linux/pm_wakeup.h                    |  10 +-
 kernel/power/autosleep.c                     |   2 +-
 kernel/power/wakelock.c                      |   2 +-
 kernel/time/alarmtimer.c                     |   2 +-
 11 files changed, 328 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
 create mode 100644 drivers/base/power/wakeup_stats.c

diff --git a/Documentation/ABI/testing/sysfs-class-wakeup b/Documentation/ABI/testing/sysfs-class-wakeup
new file mode 100644
index 000000000000..754aab8b6dcd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-wakeup
@@ -0,0 +1,76 @@
+What:		/sys/class/wakeup/
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		The /sys/class/wakeup/ directory contains pointers to all
+		wakeup sources in the kernel at that moment in time.
+
+What:		/sys/class/wakeup/.../name
+Date:		June 2019
+Contact:	Tri Vo <trong@android.com>
+Description:
+		This file contains the name of the wakeup source.
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
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 28cffaaf9d82..91634e2dba8a 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -495,7 +495,8 @@ acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
 		goto out;
 
 	mutex_lock(&acpi_pm_notifier_lock);
-	adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
+	adev->wakeup.ws = wakeup_source_register(&adev->dev,
+						 dev_name(&adev->dev));
 	adev->wakeup.context.dev = dev;
 	adev->wakeup.context.func = func;
 	adev->wakeup.flags.notifier_present = true;
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
index ec33fbdb919b..57b1d1d88c8e 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -149,3 +149,12 @@ static inline void device_pm_init(struct device *dev)
 	device_pm_sleep_init(dev);
 	pm_runtime_init(dev);
 }
+
+#ifdef CONFIG_PM_SLEEP
+
+/* drivers/base/power/wakeup_stats.c */
+extern int wakeup_source_sysfs_add(struct device *parent,
+				   struct wakeup_source *ws);
+extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
+
+#endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 3938892c8903..973675f24314 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -72,6 +72,8 @@ static struct wakeup_source deleted_ws = {
 	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
 };
 
+static DEFINE_IDA(wakeup_ida);
+
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -80,6 +82,7 @@ struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
 	const char *ws_name;
+	int id;
 
 	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
 	if (!ws)
@@ -90,8 +93,15 @@ struct wakeup_source *wakeup_source_create(const char *name)
 		goto err_name;
 	ws->name = ws_name;
 
+	id = ida_alloc(&wakeup_ida, GFP_KERNEL);
+	if (id < 0)
+		goto err_id;
+	ws->id = id;
+
 	return ws;
 
+err_id:
+	kfree_const(ws->name);
 err_name:
 	kfree(ws);
 err_ws:
@@ -140,6 +150,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 
 	__pm_relax(ws);
 	wakeup_source_record(ws);
+	ida_free(&wakeup_ida, ws->id);
 	kfree_const(ws->name);
 	kfree(ws);
 }
@@ -193,16 +204,24 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
+ * @dev: Device this wakeup source is associated with (or NULL if virtual).
  * @name: Name of the wakeup source to register.
  */
-struct wakeup_source *wakeup_source_register(const char *name)
+struct wakeup_source *wakeup_source_register(struct device *dev,
+					     const char *name)
 {
 	struct wakeup_source *ws;
+	int ret;
 
 	ws = wakeup_source_create(name);
-	if (ws)
+	if (ws) {
+		ret = wakeup_source_sysfs_add(dev, ws);
+		if (ret) {
+			wakeup_source_destroy(ws);
+			return NULL;
+		}
 		wakeup_source_add(ws);
-
+	}
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_register);
@@ -215,6 +234,7 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 {
 	if (ws) {
 		wakeup_source_remove(ws);
+		wakeup_source_sysfs_remove(ws);
 		wakeup_source_destroy(ws);
 	}
 }
@@ -258,7 +278,7 @@ int device_wakeup_enable(struct device *dev)
 	if (pm_suspend_target_state != PM_SUSPEND_ON)
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
 
-	ws = wakeup_source_register(dev_name(dev));
+	ws = wakeup_source_register(dev, dev_name(dev));
 	if (!ws)
 		return -ENOMEM;
 
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
new file mode 100644
index 000000000000..220a20ff8918
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wakeup statistics in sysfs
+ *
+ * Copyright (c) 2019 Linux Foundation
+ * Copyright (c) 2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2019 Google Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
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
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", ws->name);
+}
+static DEVICE_ATTR_RO(name);
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
+	&dev_attr_name.attr,
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
+static void device_create_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static struct device *wakeup_source_device_create(struct device *parent,
+						  struct wakeup_source *ws)
+{
+	struct device *dev = NULL;
+	int retval = -ENODEV;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	device_initialize(dev);
+	dev->devt = MKDEV(0, 0);
+	dev->class = wakeup_class;
+	dev->parent = parent;
+	dev->groups = wakeup_source_groups;
+	dev->release = device_create_release;
+	dev_set_drvdata(dev, ws);
+	device_set_pm_not_required(dev);
+
+	retval = kobject_set_name(&dev->kobj, "wakeup%d", ws->id);
+	if (retval)
+		goto error;
+
+	retval = device_add(dev);
+	if (retval)
+		goto error;
+
+	return dev;
+
+error:
+	put_device(dev);
+	return ERR_PTR(retval);
+}
+
+/**
+ * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
+ * @parent: Device given wakeup source is associated with (or NULL if virtual).
+ * @ws: Wakeup source to be added in sysfs.
+ */
+int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
+{
+	struct device *dev;
+
+	dev = wakeup_source_device_create(parent, ws);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+	ws->dev = dev;
+
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
+
+	return PTR_ERR_OR_ZERO(wakeup_class);
+}
+postcore_initcall(wakeup_sources_sysfs_init);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f5011fac..c4159bcc05d9 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1459,13 +1459,13 @@ static int ep_create_wakeup_source(struct epitem *epi)
 	struct wakeup_source *ws;
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register("eventpoll");
+		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
 		if (!epi->ep->ws)
 			return -ENOMEM;
 	}
 
 	name = epi->ffd.file->f_path.dentry->d_name.name;
-	ws = wakeup_source_register(name);
+	ws = wakeup_source_register(NULL, name);
 
 	if (!ws)
 		return -ENOMEM;
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index c0cad2d8f800..661efa029c96 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -21,6 +21,7 @@ struct wake_irq;
  * struct wakeup_source - Representation of wakeup sources
  *
  * @name: Name of the wakeup source
+ * @id: Wakeup source id
  * @entry: Wakeup source list entry
  * @lock: Wakeup source lock
  * @wakeirq: Optional device specific wakeirq
@@ -35,11 +36,13 @@ struct wake_irq;
  * @relax_count: Number of times the wakeup source was deactivated.
  * @expire_count: Number of times the wakeup source's timeout has expired.
  * @wakeup_count: Number of times the wakeup source might abort suspend.
+ * @dev: Struct device for sysfs statistics about the wakeup source.
  * @active: Status of the wakeup source.
  * @autosleep_enabled: Autosleep is active, so update @prevent_sleep_time.
  */
 struct wakeup_source {
 	const char 		*name;
+	int			id;
 	struct list_head	entry;
 	spinlock_t		lock;
 	struct wake_irq		*wakeirq;
@@ -55,6 +58,7 @@ struct wakeup_source {
 	unsigned long		relax_count;
 	unsigned long		expire_count;
 	unsigned long		wakeup_count;
+	struct device		*dev;
 	bool			active:1;
 	bool			autosleep_enabled:1;
 };
@@ -85,7 +89,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
-extern struct wakeup_source *wakeup_source_register(const char *name);
+extern struct wakeup_source *wakeup_source_register(struct device *dev,
+						    const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
@@ -122,7 +127,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
-static inline struct wakeup_source *wakeup_source_register(const char *name)
+static inline struct wakeup_source *wakeup_source_register(struct device *dev,
+							   const char *name)
 {
 	return NULL;
 }
diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index 41e83a779e19..9af5a50d3489 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -116,7 +116,7 @@ int pm_autosleep_set_state(suspend_state_t state)
 
 int __init pm_autosleep_init(void)
 {
-	autosleep_ws = wakeup_source_register("autosleep");
+	autosleep_ws = wakeup_source_register(NULL, "autosleep");
 	if (!autosleep_ws)
 		return -ENOMEM;
 
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index d1eb7fd98b64..105df4dfc783 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -188,7 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	wl->ws = wakeup_source_register(wl->name);
+	wl->ws = wakeup_source_register(NULL, wl->name);
 	if (!wl->ws) {
 		kfree(wl->name);
 		kfree(wl);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..93b382d9701c 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -97,7 +97,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
-	__ws = wakeup_source_register("alarmtimer");
+	__ws = wakeup_source_register(dev, "alarmtimer");
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!rtcdev) {
-- 
2.22.0.770.g0f2c4a37fd-goog

