Return-Path: <linux-pm+bounces-1600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810F81EE32
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC11C21340
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2452C878;
	Wed, 27 Dec 2023 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS+rQPOz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36132C867
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5aef534eso10058155e9.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 02:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703672813; x=1704277613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OcDR+Nega8FhnoPMRAPEOetFIgTrBFAnqGKFJ3ZWsQ=;
        b=tS+rQPOzfZP2OeRlqTZX5DoLH0HvEmUqdzGnC1NCg+5hgO6nncfw7CFMG/fyu2tHah
         +MJ6g87TRvjTjBZRkb5He3i3V1MbguNV6E+Ud51N1Wi3d7nqTRVF9OmO9Y690IEB4i/u
         vDpIh8T5tv8KiKdBU7rT/6BJmLwVFHkzDfnPx4kgmxRI5tefkgeOQOhJetr1Kgtn32wg
         8jwtiu2/Zcf5A+IOrYHOs4l7dr42Vv6d5az+2/43RqwH+4WuPW3NWVlglckcP8ABmzcA
         4P0rVnNlqmLta0xtuNcuNic+twg4LdaNgV/ASHVhr/rN5b9P4HlNpVvwU4LWSe4PBCqZ
         AntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672813; x=1704277613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OcDR+Nega8FhnoPMRAPEOetFIgTrBFAnqGKFJ3ZWsQ=;
        b=sg+JFB2tbwWN1KVaqk6mQmgta/Jeaf5L3MuE+1fdrgV2dPAnmtyVtJUhlrm943rAuB
         qYbEO8QGAk0va3oiQRfXhiCkB/WRZCEvao6VVHmidEBtkU68OEwBL+GGH9F0O4oX5E7U
         00mXakc8QPdE31ZrWX1vH8pr5AY9DPyPWxISJcreHgndyjj5E+7a4xQ5aVCdSc+fmDcM
         +mxfv8uZ8b/N8xIZatFKFM0F1xm4hWZI+Ib8ihx5+hdDtmFDaoFtcpvUCK+6ZQu/nhdQ
         9T+/McDrU6smsqhvhbHTpsutDX7A89S86mh0EkiGwT5Pa8pKaAl1bJ/+lhc3F9Axo0ya
         V+RQ==
X-Gm-Message-State: AOJu0YzfvrBYqWs3A/hoftU1f+dnXiTG7n91z5vTWaQyhOs1D3UrNQZc
	X9qeOrUK0dHxDQWLlVgbtRUqZz1ZSRwrFQ==
X-Google-Smtp-Source: AGHT+IF+ENqN1RkOAx7IyRIky119QRHlqQts9x8RpJWJcmVm8z1fcSTSAYWbv6fF5jnmALSVE/zekg==
X-Received: by 2002:a05:600c:1503:b0:40d:355e:ab92 with SMTP id b3-20020a05600c150300b0040d355eab92mr4671008wmg.22.1703672812971;
        Wed, 27 Dec 2023 02:26:52 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0033664ffaf5dsm14556763wro.37.2023.12.27.02.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:52 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/2] thermal/debugfs: Add thermal cooling device debugfs information
Date: Wed, 27 Dec 2023 11:26:42 +0100
Message-Id: <20231227102643.2655651-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal framework does not have any debug information except a
sysfs stat which is a bit controversial. This one allocates big chunks
of memory for every cooling devices with a high number of states and
could represent on some systems in production several megabytes of
memory for just a portion of it. As the sysfs is limited to a page
size, the output is not exploitable with large data array and gets
truncated.

The patch provides the same information than sysfs except the
transitions are dynamically allocated, thus they won't show more
events than the ones which actually occurred. There is no longer a
size limitation and it opens the field for more debugging information
where the debugfs is designed for, not sysfs.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
 -- cooling_devices
    |-- 0
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 1
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 2
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 3
    |   |-- clear
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    `-- 4
        |-- clear
        |-- time_in_state_ms
        |-- total_trans
        `-- trans_table

The content of the files in the cooling devices directory is the same
as the sysfs one except for the trans_table which has the following
format:

Transition	Hits
1->0      	246
0->1      	246
2->1      	632
1->2      	632
3->2      	98
2->3      	98

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changelog:
  - v4
    - Fixed kerneldoc description ordering (Rafael)
    - Fixed comment (Rafael)
    - Renamed s/cdev_value/cdev_record/ (Rafael)
    - Used union instead of a common 'value' field in cdev_record (Rafael)
    - Renamed s/cdev/cdev_dbg/ for clarity (Rafael)
    - Renamed s/dfs/thermal_dbg/ for clarity (Rafael)
    - Renamed s/list/lists/ in the place where there are array of lists (Rafael)
    - Inverted initialization logic when allocating a cdev_record (Rafael)
    - Moved now = ktime_get() closer to the place where it is used (Rafael)
    - Moved two lines down to a condition (Rafael)
    - Removed strange and unexpected addition of function (Rafael)
  - v3
    - Fixed kerneldoc description (kbuild)
    - Made some functions static
  - v2
    - Added parameter names to fix kbuild report
    - Renamed 'reset' to 'clear' to avoid confusion (Rafael)
    - Fixed several typos and rephrased some sentences (Rafael)
    - Renamed structure field name s/list/node/ (Rafael)
    - Documented structures and exported functions (Rafael)
    - s/trans_list/transitions/ (Rafael)
    - s/duration_list/durations/ (Rafael)
    - Folded 'alloc' and 'insert' into a single function (Rafael)
    - s/list/lists/ as it is an array of lists (Rafael)
    - s/pos/entry/ (Rafael)
    - Introduced a locking in the 'clear' callback function (Rafael)
    - s/to/new_state/ and s/from/old_state/ (Rafael)
    - Added some comments in thermal_debug_cdev_transition() (Rafael)
    - Explained why char[11] (Rafael)
    - s/Hits/Occurrences/ (Rafael)
    - s/Time/Residency/ (Rafael)
    - Constified structure pointer passed to thermal_debug_cdev_transition()
    - s/thermal_debug_cdev_transition()/thermal_debug_cdev_state_update()/
  - v1 (from RFC):
    - Fixed typo "occurred"
    - Changed Kconfig option name and description
    - Removed comment in the Makefile
    - Renamed exported function name s/debugfs/debug/
    - Replaced thermal_debug_cdev_[unregister|register] by [add|remove]
---
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   2 +
 drivers/thermal/thermal_core.c    |   6 +
 drivers/thermal/thermal_core.h    |   1 +
 drivers/thermal/thermal_debugfs.c | 445 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |  14 +
 drivers/thermal/thermal_helpers.c |  27 +-
 include/linux/thermal.h           |   7 +
 8 files changed, 503 insertions(+), 6 deletions(-)
 create mode 100644 drivers/thermal/thermal_debugfs.c
 create mode 100644 drivers/thermal/thermal_debugfs.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c81a00fbca7d..3ff7add3fb7c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,6 +33,13 @@ config THERMAL_STATISTICS
 
 	  If in doubt, say N.
 
+config THERMAL_DEBUGFS
+	bool "Thermal subsystem debug support"
+	depends on DEBUG_FS
+	help
+	  Say Y to allow the thermal subsystem to collect diagnostic
+	  information that can be accessed via debugfs.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index c934cab309ae..0f65ae86a9c6 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -10,6 +10,8 @@ thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
+thermal_sys-$(CONFIG_THERMAL_DEBUGFS)	+= thermal_debugfs.o
+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..33332d401b13 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -945,6 +945,8 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_debug_cdev_add(cdev);
+	
 	return cdev;
 
 out_cooling_dev:
@@ -1151,6 +1153,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	if (!cdev)
 		return;
 
+	thermal_debug_cdev_remove(cdev);
+
 	mutex_lock(&thermal_list_lock);
 
 	if (!thermal_cooling_device_present(cdev)) {
@@ -1570,6 +1574,8 @@ static int __init thermal_init(void)
 {
 	int result;
 
+	thermal_debug_init();
+
 	result = thermal_netlink_init();
 	if (result)
 		goto error;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7dfe6c8deb8e..4b3452a65a2f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_debugfs.h"
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
new file mode 100644
index 000000000000..84e5ef3dc16c
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,445 @@
+
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Thermal subsystem debug support
+ */
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/thermal.h>
+
+static struct dentry *d_root;
+static struct dentry *d_cdev;
+
+/*
+ * Length of the string containing the thermal zone id or the cooling
+ * device id, including the ending nul character. We can reasonably
+ * assume there won't be more than 256 thermal zones as the maximum
+ * observed today is around 32.
+ */
+#define IDSLENGTH 4
+
+/*
+ * The cooling device transition list is stored in a hash table where
+ * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
+ * have dozen of states but some can have much more, so a hash table
+ * is more adequate in this case, because the cost of browsing the entire
+ * list when storing the transitions may not be negligible.
+ */
+#define CDEVSTATS_HASH_SIZE 16
+
+/**
+ * struct cdev_debugfs - per cooling device statistics structure
+ * A cooling device can have a high number of states. Showing the
+ * transitions on a matrix based representation can be overkill given
+ * most of the transitions won't happen and we end up with a matrix
+ * filled with zero. Instead, we show the transitions which actually
+ * happened.
+ *
+ * Every transition updates the current_state and the timestamp. The
+ * transitions and the durations are stored in lists.
+ *
+ * @total: the number of transitions for this cooling device
+ * @current_state: the current cooling device state
+ * @timestamp: the state change timestamp
+ * @transitions: an array of lists containing the state transitions
+ * @durations: an array of lists containing the residencies of each state
+ */
+struct cdev_debugfs {
+	u32 total;
+	int current_state;
+	ktime_t timestamp;
+	struct list_head transitions[CDEVSTATS_HASH_SIZE];
+	struct list_head durations[CDEVSTATS_HASH_SIZE];
+};
+
+/**
+ * struct cdev_value - Common structure for cooling device entry
+ *
+ * The following common structure allows to store the information
+ * related to the transitions and to the state residencies. They are
+ * identified with a id which is associated to a value. It is used as
+ * nodes for the "transitions" and "durations" above.
+ *
+ * @node: node to insert the structure in a list
+ * @id: identifier of the value which can be a state or a transition
+ * @residency: a ktime_t representing a state residency duration
+ * @count: a number of occurrences
+ */
+struct cdev_record {
+	struct list_head node;
+	int id;
+	union {
+                ktime_t residency;
+                u64 count;
+        };
+};
+
+/**
+ * struct thermal_debugfs - High level structure for a thermal object in debugfs
+ *
+ * The thermal_debugfs structure is the common structure used by the
+ * cooling device to compute the statistics.
+ *
+ * @d_top: top directory of the thermal object directory
+ * @lock: per object lock to protect the internals
+ *
+ * @cdev: a cooling device debug structure
+ */
+struct thermal_debugfs {
+	struct dentry *d_top;
+	struct mutex lock;
+	union {
+		struct cdev_debugfs cdev_dbg;
+	};
+};
+
+void thermal_debug_init(void)
+{
+	d_root = debugfs_create_dir("thermal", NULL);
+	if (!d_root)
+		return;
+
+	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+}
+
+static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
+{
+	struct thermal_debugfs *thermal_dbg;
+	char ids[IDSLENGTH];
+
+	thermal_dbg = kzalloc(sizeof(*thermal_dbg), GFP_KERNEL);
+	if (!thermal_dbg)
+		return NULL;
+
+	mutex_init(&thermal_dbg->lock);
+	
+	snprintf(ids, IDSLENGTH, "%d", id);
+
+	thermal_dbg->d_top = debugfs_create_dir(ids, d);
+	if (!thermal_dbg->d_top) {
+		kfree(thermal_dbg);
+		return NULL;
+	}
+
+	return thermal_dbg;
+}
+
+static void thermal_debugfs_remove_id(struct thermal_debugfs *thermal_dbg)
+{
+	if (!thermal_dbg)
+		return;
+
+	debugfs_remove(thermal_dbg->d_top);
+
+	kfree(thermal_dbg);
+}
+
+static struct cdev_record *
+thermal_debugfs_cdev_record_alloc(struct thermal_debugfs *thermal_dbg,
+				  struct list_head *lists, int id)
+{
+	struct cdev_record *cdev_record;
+
+	cdev_record = kzalloc(sizeof(*cdev_record), GFP_KERNEL);
+	if (!cdev_record)
+		return NULL;
+
+	cdev_record->id = id;
+	INIT_LIST_HEAD(&cdev_record->node);
+	list_add_tail(&cdev_record->node,
+		      &lists[cdev_record->id % CDEVSTATS_HASH_SIZE]);
+
+	return cdev_record;
+}
+
+static struct cdev_record *
+thermal_debugfs_cdev_record_find(struct thermal_debugfs *thermal_dbg,
+				 struct list_head *lists, int id)
+{
+	struct cdev_record *entry;
+
+	list_for_each_entry(entry, &lists[id % CDEVSTATS_HASH_SIZE], node)
+		if (entry->id == id)
+			return entry;
+
+	return NULL;
+}
+
+static struct cdev_record *
+thermal_debugfs_cdev_record_get(struct thermal_debugfs *thermal_dbg,
+				struct list_head *lists, int id)
+{
+	struct cdev_record *cdev_record;
+
+	cdev_record = thermal_debugfs_cdev_record_find(thermal_dbg, lists, id);
+	if (cdev_record)
+		return cdev_record;
+
+	return thermal_debugfs_cdev_record_alloc(thermal_dbg, lists, id);
+}
+
+static void thermal_debugfs_cdev_clear(struct cdev_debugfs *cdev_dbg)
+{
+	int i;
+	struct cdev_record *entry, *tmp;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+
+		list_for_each_entry_safe(entry, tmp,
+					 &cdev_dbg->transitions[i], node) {
+			list_del(&entry->node);
+			kfree(entry);
+		}
+
+		list_for_each_entry_safe(entry, tmp,
+					 &cdev_dbg->durations[i], node) {
+			list_del(&entry->node);
+			kfree(entry);
+		}
+	}
+
+	cdev_dbg->total = 0;
+}
+
+static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_debugfs *thermal_dbg = s->private;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void *cdev_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void cdev_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *thermal_dbg = s->private;
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+static int cdev_tt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *thermal_dbg = s->private;	
+	struct cdev_debugfs *cdev_dbg = &thermal_dbg->cdev_dbg;
+	struct list_head *transitions = cdev_dbg->transitions;
+	struct cdev_record *entry;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "Transition\tOccurences\n");
+
+	list_for_each_entry(entry, &transitions[i], node) {
+		/*
+		 * Assuming maximum cdev states is 1024, the longer
+		 * string for a transition would be "1024->1024\0"
+		 */
+		char buffer[11];
+		
+		snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
+			 entry->id >> 16, entry->id & 0xFFFF);
+
+		seq_printf(s, "%-10s\t%-10llu\n", buffer, entry->count);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_tt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tt);
+
+static int cdev_dt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *thermal_dbg = s->private;
+	struct cdev_debugfs *cdev_dbg = &thermal_dbg->cdev_dbg;
+	struct list_head *durations = cdev_dbg->durations;
+	struct cdev_record *entry;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "State\tResidency\n");
+
+	list_for_each_entry(entry, &durations[i], node) {
+		s64 duration = ktime_to_ms(entry->residency);
+
+		if (entry->id == cdev_dbg->current_state)
+			duration += ktime_ms_delta(ktime_get(),
+						   cdev_dbg->timestamp);
+
+		seq_printf(s, "%-5d\t%-10llu\n", entry->id, duration);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations dt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_dt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(dt);
+
+static int cdev_clear_set(void *data, u64 val)
+{
+	struct thermal_debugfs *thermal_dbg = data;
+
+	if (!val)
+		return -EINVAL;
+
+	mutex_lock(&thermal_dbg->lock);
+	
+	thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
+
+	mutex_unlock(&thermal_dbg->lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdev_clear_fops, NULL, cdev_clear_set, "%llu\n");
+
+/**
+ * thermal_debug_cdev_state_update - Update a cooling device state change
+ *
+ * Computes a transition and the duration of the previous state residency.
+ *
+ * @cdev : a pointer to a cooling device
+ * @new_state: an integer corresponding to the new cooling device state
+ */
+void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
+				     int new_state)
+{
+	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
+	struct cdev_debugfs *cdev_dbg;
+	struct cdev_record *cdev_record;
+	int transition, old_state;
+
+	if (!thermal_dbg || (thermal_dbg->cdev_dbg.current_state == new_state))
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	cdev_dbg = &thermal_dbg->cdev_dbg;
+
+	old_state = cdev_dbg->current_state;
+
+	/*
+	 * Get the old state information in the durations list. If
+	 * this one does not exist, a new allocated one will be
+	 * returned. Recompute the total duration in the old state and
+	 * get a new timestamp for the new state.
+	 */
+	cdev_record = thermal_debugfs_cdev_record_get(thermal_dbg,
+						      cdev_dbg->durations,
+						      old_state);
+	if (cdev_record) {
+		ktime_t now = ktime_get();
+		ktime_t delta = ktime_sub(now, cdev_dbg->timestamp);
+		cdev_record->residency = ktime_add(cdev_record->residency, delta);
+		cdev_dbg->timestamp = now;
+	}
+
+	cdev_dbg->current_state = new_state;
+	transition = (old_state << 16) | new_state;
+	
+	/*
+	 * Get the transition in the transitions list. If this one
+	 * does not exist, a new allocated one will be returned.
+	 * Increment the occurrence of this transition which is stored
+	 * in the value field.
+	 */
+	cdev_record = thermal_debugfs_cdev_record_get(thermal_dbg,
+						      cdev_dbg->transitions,
+						      transition);
+	if (cdev_record)
+		cdev_record->count++;
+
+	cdev_dbg->total++;
+
+	mutex_unlock(&thermal_dbg->lock);
+}
+
+/**
+ * thermal_debug_cdev_add - Add a cooling device debugfs entry
+ *
+ * Allocates a cooling device object for debug, initializes the
+ * statistics and create the entries in sysfs.
+ * @cdev: a pointer to a cooling device
+ */
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *thermal_dbg;
+	struct cdev_debugfs *cdev_dbg;
+	int i;
+
+	thermal_dbg = thermal_debugfs_add_id(d_cdev, cdev->id);
+	if (!thermal_dbg)
+		return;
+
+	cdev_dbg = &thermal_dbg->cdev_dbg;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&cdev_dbg->transitions[i]);
+		INIT_LIST_HEAD(&cdev_dbg->durations[i]);
+	}
+
+	cdev_dbg->current_state = 0;
+	cdev_dbg->timestamp = ktime_get();
+
+	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
+			    thermal_dbg, &tt_fops);
+
+	debugfs_create_file("time_in_state_ms", 0400, thermal_dbg->d_top,
+			    thermal_dbg, &dt_fops);
+
+	debugfs_create_file("clear", 0200, thermal_dbg->d_top,
+			    thermal_dbg, &cdev_clear_fops);
+
+	debugfs_create_u32("total_trans", 0400, thermal_dbg->d_top,
+			   &cdev_dbg->total);
+
+	cdev->debugfs = thermal_dbg;
+}
+
+/**
+ * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
+ *
+ * Frees the statistics memory data and remove the debugfs entry
+ *
+ * @cdev: a pointer to a cooling device
+ */
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *thermal_dbg = cdev->debugfs;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+	
+	thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
+	cdev->debugfs = NULL;
+	thermal_debugfs_remove_id(thermal_dbg);
+
+	mutex_unlock(&thermal_dbg->lock);
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
new file mode 100644
index 000000000000..341499388448
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_THERMAL_DEBUGFS
+void thermal_debug_init(void);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
+#else
+static inline void thermal_debug_init(void) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev) {}
+static inline void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev,
+						   int state) {}
+#endif /* CONFIG_THERMAL_DEBUGFS */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 69e8ea4aa908..435c123b721b 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -151,14 +151,29 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
-				       int target)
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 {
-	if (cdev->ops->set_cur_state(cdev, target))
-		return;
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
+static int thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int state)
+{
+	int ret;
 
-	thermal_notify_cdev_state_update(cdev->id, target);
-	thermal_cooling_device_stats_update(cdev, target);
+	/*
+	 * No check is needed for the ops->set_cur_state as the
+	 * registering function checked the ops are correctly set
+	 */
+	ret = cdev->ops->set_cur_state(cdev, state);
+	if (!ret) {
+		thermal_notify_cdev_state_update(cdev->id, state);
+		thermal_cooling_device_stats_update(cdev, state);
+		thermal_debug_cdev_state_update(cdev, state);
+	}
+
+	return ret;
 }
 
 void __thermal_cdev_update(struct thermal_cooling_device *cdev)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ea99f50d57c..8461f008c3de 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,6 +32,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_debugfs;
 struct thermal_attr;
 
 enum thermal_trend {
@@ -110,6 +111,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
@@ -183,6 +187,9 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
-- 
2.34.1


