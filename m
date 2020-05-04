Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536691C459F
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbgEDSQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:16:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:27142 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgEDSQl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 14:16:41 -0400
IronPort-SDR: VLJwayYw3x53mUP8Kp+OcOIC3+n0SK2gHXim9pd4+nYLP5WtZdQsBQ8+Hi71ZiEB9DZqQV+3cb
 pjUemP/yny1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 11:16:32 -0700
IronPort-SDR: oWB94z3vmcJwRlcip6yGYRP9hzAigw19BqdDV8aTAAD7ubvVwZLi41gRSjbl268guVtRt/XHPN
 RrEpp1yYzoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="259427109"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.145.237])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 11:16:31 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH 1/5] thermal: Add support for /dev/thermal_notify
Date:   Mon,  4 May 2020 11:16:12 -0700
Message-Id: <20200504181616.175477-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This change adds an optional feature to add a new device entry
/dev/thermal_notify.

When config CONFIG_THERMAL_USER_EVENT_INTERFACE is selected, this new
device entry is created.

Thermal core or any thermal driver can use thermal_dev_send_event() interface
to send events. Each user events follows a standard format:
- zone_id
- event_id
- event_data
- reserved for future, currently 0s

User space can basically:
	fd = open ("/dev/thermal_notify")
	In a loop
		read (fd)
			read and process event

or
	fd = open ("/dev/thermal_notify")
	Set the fs as non blocking
	In a loop
		Use poll() and wait
			read and process event

There are predefined events added to thermal.h. Based on need they can
be extended.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig          |   9 ++
 drivers/thermal/Makefile         |   3 +
 drivers/thermal/thermal_dev_if.c | 195 +++++++++++++++++++++++++++++++
 include/linux/thermal.h          |  24 ++++
 4 files changed, 231 insertions(+)
 create mode 100644 drivers/thermal/thermal_dev_if.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91af271e9bb0..27d05d62458e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -78,6 +78,15 @@ config THERMAL_WRITABLE_TRIPS
 	  Say 'Y' here if you would like to allow userspace tools to
 	  change trip temperatures.
 
+config THERMAL_USER_EVENT_INTERFACE
+	bool "Allow user space to read thermal events from a dev file"
+	help
+	  This option allows a user space program to read thermal events
+	  via /dev/thermal_notify file.
+
+	  Say 'Y' here if you would like to allow userspace programs to
+	  read thermal events.
+
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8c8ed7b79915..8f65832d755a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -11,6 +11,9 @@ thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= of-thermal.o
 
+# Thermal user space events
+obj-$(CONFIG_THERMAL_USER_EVENT_INTERFACE)	+= thermal_dev_if.o
+
 # governors
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= fair_share.o
 thermal_sys-$(CONFIG_THERMAL_GOV_BANG_BANG)	+= gov_bang_bang.o
diff --git a/drivers/thermal/thermal_dev_if.c b/drivers/thermal/thermal_dev_if.c
new file mode 100644
index 000000000000..763bfe9eef9d
--- /dev/null
+++ b/drivers/thermal/thermal_dev_if.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thermal device file interface
+ * Copyright (c) 2020, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kfifo.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/wait.h>
+
+#define THERMAL_DEV_FIFO_SIZE	1024
+
+struct thermal_chdev_sample {
+	int zone_id;
+	int event;
+	u64 event_data;
+	u64 reserved;
+};
+
+struct thermal_chdev {
+	struct miscdevice therm_dev;
+	struct kfifo data_fifo;
+	unsigned long misc_opened;
+	wait_queue_head_t wait;
+};
+
+static DEFINE_MUTEX(thermal_chdev_mutex);
+static struct thermal_chdev *thermal_chdev;
+
+static int thermal_chdev_open(struct inode *inode, struct file *file)
+{
+	struct thermal_chdev *chdev;
+
+	chdev = container_of(file->private_data, struct thermal_chdev, therm_dev);
+
+	/* We essentially have single reader and writer */
+	if (test_and_set_bit(0, &chdev->misc_opened))
+		return -EBUSY;
+
+	return stream_open(inode, file);
+}
+
+static int thermal_chdev_release(struct inode *inode, struct file *file)
+{
+	struct thermal_chdev *chdev;
+
+	chdev = container_of(file->private_data, struct thermal_chdev, therm_dev);
+
+	clear_bit(0, &chdev->misc_opened);
+
+	return 0;
+}
+
+static __poll_t thermal_chdev_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct thermal_chdev *chdev;
+	__poll_t mask = 0;
+
+	chdev = container_of(file->private_data, struct thermal_chdev, therm_dev);
+
+	poll_wait(file, &chdev->wait, wait);
+
+	if (!kfifo_is_empty(&chdev->data_fifo))
+		mask = EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
+static ssize_t thermal_chdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_ps)
+{
+	struct thermal_chdev *chdev;
+	unsigned int copied;
+	int ret;
+
+	chdev = container_of(file->private_data, struct thermal_chdev, therm_dev);
+
+	if (count < sizeof(struct thermal_chdev_sample))
+		return -EINVAL;
+
+	do {
+		if (kfifo_is_empty(&chdev->data_fifo)) {
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(chdev->wait, !kfifo_is_empty(&chdev->data_fifo));
+			if (ret)
+				return ret;
+		}
+		ret = kfifo_to_user(&chdev->data_fifo, buf, count, &copied);
+		if (ret)
+			return ret;
+
+	} while (copied == 0);
+
+	return copied;
+}
+
+static int thermal_chdev_capture_sample(struct thermal_chdev *chdev, struct thermal_chdev_sample *sample)
+{
+	int ret = 0;
+
+	if (!test_bit(0, &chdev->misc_opened))
+		return 0;
+
+	mutex_lock(&thermal_chdev_mutex);
+	if (kfifo_avail(&chdev->data_fifo) >= sizeof(*sample)) {
+		kfifo_in(&chdev->data_fifo, (unsigned char *)sample, sizeof(*sample));
+		wake_up(&chdev->wait);
+	} else {
+		ret =  -ENOMEM;
+	}
+	mutex_unlock(&thermal_chdev_mutex);
+
+	return ret;
+}
+
+static const struct file_operations thermal_chdev_fops = {
+	.open =  thermal_chdev_open,
+	.read =  thermal_chdev_read,
+	.release = thermal_chdev_release,
+	.poll = thermal_chdev_poll,
+	.llseek = noop_llseek,
+};
+
+static int thermal_dev_if_add(void)
+{
+	int ret;
+
+	if (thermal_chdev)
+		return 0;
+
+	thermal_chdev = kzalloc(sizeof(*thermal_chdev), GFP_KERNEL);
+	if (!thermal_chdev)
+		return -ENOMEM;
+
+	ret = kfifo_alloc(&thermal_chdev->data_fifo, THERMAL_DEV_FIFO_SIZE, GFP_KERNEL);
+	if (ret)
+		goto free_mem;
+
+	init_waitqueue_head(&thermal_chdev->wait);
+
+	thermal_chdev->therm_dev.minor = MISC_DYNAMIC_MINOR;
+	thermal_chdev->therm_dev.name = "thermal_notify";
+	thermal_chdev->therm_dev.fops = &thermal_chdev_fops;
+	ret = misc_register(&thermal_chdev->therm_dev);
+	if (ret) {
+		kfifo_free(&thermal_chdev->data_fifo);
+		goto free_mem;
+	}
+
+	return 0;
+
+free_mem:
+	kfree(thermal_chdev);
+	thermal_chdev = NULL;
+	return ret;
+}
+
+/**
+ * thermal_dev_send_event() - Send thermal event to user space
+ * @zone_id:	Zone id of the caller
+ * @event:	A predefined thermal event
+ * @event_data: Event specific data
+ *
+ * An interface to send event to user space with an optional associated
+ * data.
+ *
+ * Return: 0 on success, other values on error.
+ */
+int thermal_dev_send_event(int zone_id, enum thermal_device_events event, u64 event_data)
+{
+	struct thermal_chdev_sample sample;
+
+	if (!thermal_chdev) {
+		int ret;
+
+		ret = thermal_dev_if_add();
+		if (ret)
+			return ret;
+	}
+
+	sample.zone_id = zone_id;
+	sample.event = event;
+	sample.event_data = event_data;
+	sample.reserved = 0;
+	return thermal_chdev_capture_sample(thermal_chdev, &sample);
+}
+EXPORT_SYMBOL_GPL(thermal_dev_send_event);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c91b1e344d56..f5e1e7c6a9a2 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -543,4 +543,28 @@ static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 { }
 #endif /* CONFIG_THERMAL */
 
+enum thermal_device_events {
+	THERMAL_TEMP_SAMPLE = 0,
+	THERMAL_ZONE_CREATE,
+	THERMAL_ZONE_DELETE,
+	THERMAL_ZONE_DISABLED,
+	THERMAL_ZONE_ENABLED,
+	THERMAL_TEMP_LOW_THRES,
+	THERMAL_TEMP_HIGH_THRES,
+	THERMAL_TRIP_ADD,
+	THERMAL_TRIP_DELETE,
+	THERMAL_TRIP_UPDATE,
+	THERMAL_TRIP_REACHED,
+	THERMAL_PERF_CHANGED,
+};
+
+#ifdef CONFIG_THERMAL_USER_EVENT_INTERFACE
+int thermal_dev_send_event(int zone_id, enum thermal_device_events event, u64 event_data);
+#else
+int thermal_dev_send_event(int zone_id, enum thermal_device_events event, u64 event_data)
+{
+	return 0;
+}
+#endif
+
 #endif /* __THERMAL_H__ */
-- 
2.25.4

