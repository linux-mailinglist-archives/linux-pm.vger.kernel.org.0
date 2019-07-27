Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB377590
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfG0BKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 21:10:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfG0BKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 21:10:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so14785694pgd.4
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQRUQTGHghiSjnGyNmnjjwrP0SZFOBpm2WhpRZoAo08=;
        b=lOTX8HD+e4c0IunlU8eG4QDFm2WQaAqmq9NHqwzlR4pAY4WXgLz6Y515jqAXs/FCWD
         t/OxGTPi9MSC+MJtvLpyFBOm/vqXKY9rc2UYLMWDYxKV061as5Upk40OsRc/83JbZlab
         0pQETrKxlIjIBiEniO4A+ZKqIxrUpKrfJ3XTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQRUQTGHghiSjnGyNmnjjwrP0SZFOBpm2WhpRZoAo08=;
        b=jyOVOuOawGl9aHNDStCMdm1elBissh7lqCpeCAaue31ICeYFmUPnluiCkPf4QhkyvU
         kryUTW8UlaNXrcDyV8MjxVYooBjZfYdNFhKVspgND/XBjdPzDs34peYtHPt33VEH2E/6
         lO4cHKzjYTLbNhapNDUOuZmD11XshfUWKlYGEpb60PrZBLYztBsdbqoNjEzxAA1IY/HE
         gKRcgmU5EuLtC7rtbiWIgK3if807vagpOg1PQ8c6JAdqnG1euOVJQmvPGDZXC0C0dceE
         Ph6Tzrfcw3jjiSLXSLjN+DYCfLtOHfmifLmwuhD6EQm2NaPmN71IbghBuYJ+aTt6xWkn
         3MmQ==
X-Gm-Message-State: APjAAAWxIbJiiCxM8FKpyhc1lsZdUYtzFf22l/iB7URidsanNZXLkMS+
        icVHT7IXt0h4hbVoQ7LSja9ZZQ==
X-Google-Smtp-Source: APXvYqxHXffc+9fBQ+d3rjgjiSnbJ936ROEe/eoZFDWVMJFSb4dN5kY9mwHi+V7fALcyzoN7SNzsjA==
X-Received: by 2002:a62:e801:: with SMTP id c1mr25366937pfi.41.1564189841686;
        Fri, 26 Jul 2019 18:10:41 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s5sm30660483pfm.97.2019.07.26.18.10.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 18:10:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] PM / wakeup: Avoid dev_name collisions in wakeup class
Date:   Fri, 26 Jul 2019 18:10:40 -0700
Message-Id: <20190727011040.89582-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If a device is wakeup capable and the driver calls device_wakeup_init()
on it during probe and then userspace writes 'enabled' to that device's
power/wakeup file in sysfs we'll try to create the same named wakeup
device in sysfs. The kernel will complain about duplicate file names.

sysfs: cannot create duplicate filename '/devices/virtual/wakeup/1-1.1'
kobject_add_internal failed for 1-1.1 with -EEXIST, don't try to register things with the same name in the same directory.

It may be advantageous to not write 'enabled' to the wakeup file (see
wakeup_store()) from userspace for these devices because we allocate
devices and register them and then throw them all away later on if the
device driver has already initialized the wakeup attribute. The
implementation currently tries to avoid taking locks here so it seems
best to optimize that path in a separate patch.

Let's rename the wakeup class devices as 'wakeupN' with an IDA that's
simple enough to just return some sort of number. In addition, let's
make the device registering the wakeup the parent and include a 'name'
attribute in case userspace wants to figure out the type of wakeup it is
(in the case of virtual wakeups) or the device associated with the
wakeup. This makes it easier for userspace to go from /sys/class/wakeup
to a place in the device hierarchy where the wakeup is generated from
like an input device.

Cc: Tri Vo <trong@android.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/acpi/device_pm.c          |  2 +-
 drivers/base/power/wakeup.c       |  8 +++++---
 drivers/base/power/wakeup_stats.c | 31 ++++++++++++++++++++++++++-----
 fs/eventpoll.c                    |  4 ++--
 include/linux/pm_wakeup.h         | 12 ++++++++----
 kernel/power/autosleep.c          |  2 +-
 kernel/power/wakelock.c           |  2 +-
 kernel/time/alarmtimer.c          |  2 +-
 8 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 28cffaaf9d82..0863be1e42d6 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -495,7 +495,7 @@ acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
 		goto out;
 
 	mutex_lock(&acpi_pm_notifier_lock);
-	adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
+	adev->wakeup.ws = wakeup_source_register(&adev->dev, dev_name(&adev->dev));
 	adev->wakeup.context.dev = dev;
 	adev->wakeup.context.func = func;
 	adev->wakeup.flags.notifier_present = true;
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 2b8def0ea59f..7ba242b49831 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -201,15 +201,17 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
  * @name: Name of the wakeup source to register.
+ * @dev: Device wakeup source is associated with (or NULL if virtual)
  */
-struct wakeup_source *wakeup_source_register(const char *name)
+struct wakeup_source *wakeup_source_register(struct device *dev,
+					     const char *name)
 {
 	struct wakeup_source *ws;
 	int ret;
 
 	ws = wakeup_source_create(name);
 	if (ws) {
-		ret = wakeup_source_sysfs_add(ws);
+		ret = wakeup_source_sysfs_add(dev, ws);
 		if (ret) {
 			kfree_const(ws->name);
 			kfree(ws);
@@ -273,7 +275,7 @@ int device_wakeup_enable(struct device *dev)
 	if (pm_suspend_target_state != PM_SUSPEND_ON)
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
 
-	ws = wakeup_source_register(dev_name(dev));
+	ws = wakeup_source_register(dev, dev_name(dev));
 	if (!ws)
 		return -ENOMEM;
 
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 9c01150f1213..927cc84d3392 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -7,8 +7,9 @@
  * Copyright (c) 2019 Google Inc.
  */
 
-#include <linux/slab.h>
+#include <linux/idr.h>
 #include <linux/kdev_t.h>
+#include <linux/slab.h>
 
 #include "power.h"
 
@@ -80,6 +81,15 @@ static ssize_t last_change_ms_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(last_change_ms);
 
+static ssize_t name_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct wakeup_source *ws = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", ws->name);
+}
+static DEVICE_ATTR_RO(name);
+
 static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -96,6 +106,7 @@ static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 static DEVICE_ATTR_RO(prevent_suspend_time_ms);
 
 static struct attribute *wakeup_source_attrs[] = {
+	&dev_attr_name.attr,
 	&dev_attr_active_count.attr,
 	&dev_attr_event_count.attr,
 	&dev_attr_wakeup_count.attr,
@@ -109,18 +120,27 @@ static struct attribute *wakeup_source_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wakeup_source);
 
+static DEFINE_IDA(wakeup_ida);
+
 /**
  * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
  * @ws: Wakeup source to be added in sysfs.
+ * @parent: Device wakeup source is associated with (or NULL if virtual)
  */
-int wakeup_source_sysfs_add(struct wakeup_source *ws)
+int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
 {
 	struct device *dev;
 
-	dev = device_create_with_groups(wakeup_class, NULL, MKDEV(0, 0), ws,
-					wakeup_source_groups, "%s", ws->name);
-	if (IS_ERR(dev))
+	ws->id = ida_simple_get(&wakeup_ida, 0, 0, GFP_KERNEL);
+	if (ws->id < 0)
+		return ws->id;
+
+	dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
+					wakeup_source_groups, "wakeup%d", ws->id);
+	if (IS_ERR(dev)) {
+		ida_simple_remove(&wakeup_ida, ws->id);
 		return PTR_ERR(dev);
+	}
 
 	ws->dev = dev;
 	return 0;
@@ -134,6 +154,7 @@ EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
 void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 {
 	device_unregister(ws->dev);
+	ida_simple_remove(&wakeup_ida, ws->id);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
 
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
index 500f9cfe2db8..822e74f45384 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -41,6 +41,7 @@ struct wake_irq;
  */
 struct wakeup_source {
 	const char 		*name;
+	int			id;
 	struct list_head	entry;
 	spinlock_t		lock;
 	struct wake_irq		*wakeirq;
@@ -88,7 +89,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
-extern struct wakeup_source *wakeup_source_register(const char *name);
+extern struct wakeup_source *wakeup_source_register(struct device *dev,
+						    const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
@@ -128,7 +130,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
-static inline struct wakeup_source *wakeup_source_register(const char *name)
+static inline struct wakeup_source *wakeup_source_register(struct device *dev,
+							   const char *name)
 {
 	return NULL;
 }
@@ -186,12 +189,13 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 #ifdef CONFIG_PM_SLEEP_STATS
 
 /* drivers/base/power/wakeup_stats.c */
-int wakeup_source_sysfs_add(struct wakeup_source *ws);
+int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws);
 void wakeup_source_sysfs_remove(struct wakeup_source *ws);
 
 #else /* !CONFIG_PM_SLEEP_STATS */
 
-static inline int wakeup_source_sysfs_add(struct wakeup_source *ws)
+static inline int wakeup_source_sysfs_add(struct device *parent,
+					  struct wakeup_source *ws)
 {
 	return 0;
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
index 32726da3d6e6..826fcd97647a 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -192,7 +192,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 	wl->ws.name = wl->name;
 	wl->ws.last_time = ktime_get();
 
-	ret = wakeup_source_sysfs_add(&wl->ws);
+	ret = wakeup_source_sysfs_add(NULL, &wl->ws);
 	if (ret) {
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

base-commit: 0c826a07dd696d99784c68ec1e8def4399cc4a0b
-- 
Sent by a computer through tubes

