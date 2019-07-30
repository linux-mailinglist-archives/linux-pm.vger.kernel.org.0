Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA779EDF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 04:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfG3Cpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 22:45:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37604 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfG3Cpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 22:45:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so18486509pgd.4
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awolIHo173FKQyxivZdn0VodRRHY/c/pYlKPw9VPrm8=;
        b=iQlZYQBaqIIh2wYSJfqgJ3KhF6SC1qkt+T8YrWePxLe9mX7Awnna2aMDyO6C5jj12w
         7R8WB+aiwRuMJcOpEynAV5EcCMUz4R+tiWVxBk5ocaZeewZYsDLJGcoNl8JxEQYfmSn+
         RsrbDDTOrPncLuR0G8VLYZjExQmde06zzAuIufZtq4M1/MLk1nU+CjDhQLrAbA0WiTK2
         +A4nXT2P1y5ysq4pYG8VUajL1WQz4RmvevHeDNU3rmJtNGqdDg41G00ty2xrPtqJhohm
         52HGtkPkCDRCZkv4z5jW4JSmrZYRQZ9/pWTfhAZVtOJNY1mCpGx9X0t2XbGRUWZMyKFE
         3twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awolIHo173FKQyxivZdn0VodRRHY/c/pYlKPw9VPrm8=;
        b=k1XX4ZHF0doMIOcsDhJOSbcK3pRaOdHFt1Uy492Mnx99Hh/IL5aGDz48cKV1wH7C9E
         4te9Lq+Tg9j6VgJvyb4qGw2Hj3Ie2mh/mpR2JYjRhOXus9LXfPDwW7i9at4fJmDvUqhy
         +8NDqBM5wzFo5bTYFWB5Ldt+803fVooolSIY9vDNF02g/pIpj2pnTOES+h3jF0yBD62K
         /KoCbHgp2FqBpAjNRyrtmm8p/3dWqJyrdezuoJNBlGfslOma4aa2NPD/trVmmtKf/Qad
         UfJYnVFCYaDKuVFDKduXfV7PGJ/acYtP9rWeJJEDf6Fxsqw2Sgdhf11MXt7GKm+GJbN/
         T/BQ==
X-Gm-Message-State: APjAAAXu60eLACW8omTnLT+sIErLYnlilzWoCK5f+j4/wcjPIG7hSTJW
        1lSAEK3lBBfoms68xi2L1Ts=
X-Google-Smtp-Source: APXvYqzjkulcLqztNaSVwb413h2L7Ya9plxkKmdyX1hrtcA+RjiUtuq6MHFmPW2z2Txo6uJ9RcX6fQ==
X-Received: by 2002:a63:8c0e:: with SMTP id m14mr92205177pgd.219.1564454738212;
        Mon, 29 Jul 2019 19:45:38 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id i7sm49878783pjk.24.2019.07.29.19.45.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:45:37 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Date:   Mon, 29 Jul 2019 19:43:09 -0700
Message-Id: <20190730024309.233728-1-trong@android.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
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
/sys/class/wakeup/wakeup<ID>/*.

Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++++
 drivers/acpi/device_pm.c                     |   3 +-
 drivers/base/power/Makefile                  |   2 +-
 drivers/base/power/wakeup.c                  |  21 ++-
 drivers/base/power/wakeup_stats.c            | 171 +++++++++++++++++++
 fs/eventpoll.c                               |   4 +-
 include/linux/pm_wakeup.h                    |  15 +-
 kernel/power/autosleep.c                     |   2 +-
 kernel/power/wakelock.c                      |  10 ++
 kernel/time/alarmtimer.c                     |   2 +-
 10 files changed, 294 insertions(+), 12 deletions(-)
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

v5:
- Removed CONFIG_PM_SLEEP_STATS
- Used PTR_ERR_OR_ZERO instead of if(IS_ERR(...)) + PTR_ERR, reported by
  kbuild test robot <lkp@intel.com>
- Stephen reported that a call to device_init_wakeup() and writing 'enabled' to
  that device's power/wakeup file results in multiple wakeup source being
  allocated for that device.  Changed device_wakeup_enable() to check if device
  wakeup was previously enabled.
Changes by Stephen:
- Changed stats location from /sys/class/wakeup/<name>/* to
  /sys/class/wakeup/wakeup<ID>/*, where ID is an IDA-allocated integer. This
  avoids name collisions in /sys/class/wakeup/ directory.
- Added a "name" attribute to wakeup sources, and updated documentation.
- Device registering the wakeup source is now the parent of the wakeup source.
  Updated wakeup_source_register()'s signature and its callers accordingly.

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
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ee31d4f8d856..1c13daa3f891 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -200,16 +200,25 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);

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
@@ -222,6 +231,7 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 {
 	if (ws) {
 		wakeup_source_remove(ws);
+		wakeup_source_sysfs_remove(ws);
 		wakeup_source_destroy(ws);
 	}
 }
@@ -262,10 +272,13 @@ int device_wakeup_enable(struct device *dev)
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;

+	if (dev->power.wakeup)
+		return 0;
+
 	if (pm_suspend_target_state != PM_SUSPEND_ON)
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);

-	ws = wakeup_source_register(dev_name(dev));
+	ws = wakeup_source_register(dev, dev_name(dev));
 	if (!ws)
 		return -ENOMEM;

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
new file mode 100644
index 000000000000..edc0c98e5991
--- /dev/null
+++ b/drivers/base/power/wakeup_stats.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wakeup statistics in sysfs
+ *
+ * Copyright (c) 2019 Linux Foundation
+ * Copyright (c) 2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2019 Google Inc.
+ */
+
+#include <linux/idr.h>
+#include <linux/kdev_t.h>
+#include <linux/slab.h>
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
+static DEFINE_IDA(wakeup_ida);
+
+/**
+ * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
+ * @parent: Device given wakeup source is associated with (or NULL if virtual).
+ * @ws: Wakeup source to be added in sysfs.
+ */
+int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
+{
+	struct device *dev;
+	int id;
+
+	id = ida_simple_get(&wakeup_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	ws->id = id;
+
+	dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
+					wakeup_source_groups, "wakeup%d",
+					ws->id);
+	if (IS_ERR(dev)) {
+		ida_simple_remove(&wakeup_ida, ws->id);
+		return PTR_ERR(dev);
+	}
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
+	ida_simple_remove(&wakeup_ida, ws->id);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
+
+static int __init wakeup_sources_sysfs_init(void)
+{
+	wakeup_class = class_create(THIS_MODULE, "wakeup");
+
+	return PTR_ERR_OR_ZERO(wakeup_class);
+}
+
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
index 91027602d137..f39f768389c8 100644
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
@@ -86,7 +90,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
-extern struct wakeup_source *wakeup_source_register(const char *name);
+extern struct wakeup_source *wakeup_source_register(struct device *dev,
+						    const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
@@ -100,6 +105,11 @@ extern void pm_relax(struct device *dev);
 extern void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard);
 extern void pm_wakeup_dev_event(struct device *dev, unsigned int msec, bool hard);

+/* drivers/base/power/wakeup_stats.c */
+extern int wakeup_source_sysfs_add(struct device *parent,
+				   struct wakeup_source *ws);
+extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
+
 #else /* !CONFIG_PM_SLEEP */

 static inline void device_set_wakeup_capable(struct device *dev, bool capable)
@@ -126,7 +136,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}

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
index 4210152e56f0..826fcd97647a 100644
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
+	ret = wakeup_source_sysfs_add(NULL, &wl->ws);
+	if (ret) {
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(ret);
+	}
+
 	wakeup_source_add(&wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
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
2.22.0.709.g102302147b-goog

