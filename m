Return-Path: <linux-pm+bounces-988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9980F1EF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0B1C20B53
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80677657;
	Tue, 12 Dec 2023 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hT0iimBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB17DC
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 08:10:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-336121f93e3so1965965f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702397456; x=1703002256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1RK7JzMelZDyBfB/mf80NUaBLDJ69+zy7KR/fDy0Fc=;
        b=hT0iimBsL0IdawYThGwLj51lIpx8h+I0GJbOQpdH2LkouZ64dPOY83/geS6gpKuZ0P
         511A54lvuSEO3IJFzZWhXkzp3Y0zd704wCzpyEWK6lhcVDYGQVhojD7ETqEZFu361YhM
         3UadUvieknHhUdXqUMJH/la1a3H6RninkMYl9ew58AVBi+Hs+yAtSV6yBQRMqGuq7Y1Z
         O0b+AirT0peGYUHq2l8XXhntFXXWKjax6c3hHPPbryIM0tfplF622v65tVOXr5TmxTbY
         SMRddZGPEO3HS+sEkIpA1m7FvKJncrEWVE0bakH36J98AkvTyPCYj8Zfu03tg5BvGmFx
         2oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397456; x=1703002256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1RK7JzMelZDyBfB/mf80NUaBLDJ69+zy7KR/fDy0Fc=;
        b=ueG7+u0+f8+a2WjDUYOSEkaaL/NtfVdBmHGiVRV2ETVMbl5vnbEH6O8ilWlxrBe9A/
         G55nrOCio/7HpotZ/NDZuI1RBLbk6ujuQk4NqZOAEEmzN1fsdAexC1RC1vaUo9awBVmF
         u8/wfchHb8hEIPIc/elQoc/sHwjA09I49TjTIX4S5e4Ea3HiZO5o4RVFOEeOXGy272K2
         s4vpQaSqKrjeweEfoO1/e5yFCpaCxgyCGOaUAxrVMGvOtL+9EQYnGnAMjHvTB4g+IN51
         ZXW1eTeAKeHCqp2y/C3/jxS4SDGaBW8bHoDz8Ari3zwbshzdrhfcnDzBXZ/krSW7iKOl
         SsIw==
X-Gm-Message-State: AOJu0YzahxInHcZg3mn9N458vk/dtCiIbw3TXjRg4QldTZfXjwduPFe+
	ENKTaef4KGkmCx1YzkoRxJ+8sw==
X-Google-Smtp-Source: AGHT+IG4F8vjwOKmwbC7QKAkbEaED11qb63fcMihwqHTGoIXOHgROzhAIm10sewxpN3AVDXzVxzgBA==
X-Received: by 2002:a5d:4a82:0:b0:333:3c90:fe16 with SMTP id o2-20020a5d4a82000000b003333c90fe16mr3540965wrq.32.1702397456381;
        Tue, 12 Dec 2023 08:10:56 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0033330846e76sm11168789wrx.86.2023.12.12.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:10:55 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] thermal/debugfs: Add thermal cooling device debugfs information
Date: Tue, 12 Dec 2023 17:10:46 +0100
Message-Id: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
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
memory for just a portion of it. As the syfs is limited to a page
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
    |   |-- reset
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 1
    |   |-- reset
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 2
    |   |-- reset
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    |-- 3
    |   |-- reset
    |   |-- time_in_state_ms
    |   |-- total_trans
    |   `-- trans_table
    `-- 4
        |-- reset
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
 drivers/thermal/thermal_debugfs.c | 354 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |  13 ++
 drivers/thermal/thermal_helpers.c |  27 ++-
 include/linux/thermal.h           |   7 +
 8 files changed, 411 insertions(+), 6 deletions(-)
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
index 000000000000..295f7a2a7d0d
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Debug filesystem for the thermal framework
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
+ * Length of the string containing the thermal zone id, including the
+ * ending null character. We can reasonably assume there won't be more
+ * than 256 thermal zones as the maximum observed today is around 32.
+ */
+#define IDSLENGTH 4
+
+/*
+ * The cooling device transition list is stored in a hash table where
+ * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
+ * have dozen of states but some can have much more, so a hash table
+ * is more adequate in this case because browsing the entire list when
+ * storing the transitions could have a non neglictible cost
+ */
+#define CDEVSTATS_HASH_SIZE 16
+
+struct cdev_value {
+	struct list_head list;
+	int id;
+	u64 value;
+};
+
+/*
+ * A cooling device can have a high number of states. Showing the
+ * transitions on a matrix based representation can be overkill given
+ * most of the transitions won't happen and we end up with a matrix
+ * filled with zero. Instead, we show the transitions which actually
+ * happened.
+ */
+struct cdev_debugfs {
+	u32 total;
+	int current_state;
+	ktime_t timestamp;
+	struct list_head trans_list[CDEVSTATS_HASH_SIZE];
+	struct list_head duration_list[CDEVSTATS_HASH_SIZE];
+};
+
+/*
+ * The thermal_debugfs structure is the common structure used by the
+ * cooling device to compute the statistics and the thermal to measure
+ * the temperature at mitigation time.
+ */
+struct thermal_debugfs {
+	struct dentry *d_top;
+	struct mutex lock;
+	union {
+		struct cdev_debugfs cdev;
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
+	struct thermal_debugfs *dfs;
+	char ids[IDSLENGTH];
+
+	dfs = kzalloc(sizeof(*dfs), GFP_KERNEL);
+	if (!dfs)
+		return NULL;
+
+	mutex_init(&dfs->lock);
+	
+	snprintf(ids, IDSLENGTH, "%d", id);
+
+	dfs->d_top = debugfs_create_dir(ids, d);
+	if (!dfs->d_top) {
+		kfree(dfs);
+		return NULL;
+	}
+
+	return dfs;
+}
+
+static void thermal_debugfs_remove_id(struct thermal_debugfs *dfs)
+{
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+
+	kfree(dfs);
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_alloc(int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = kzalloc(sizeof(*cdev_value), GFP_KERNEL);
+	if (cdev_value) {
+		cdev_value->id = id;
+		INIT_LIST_HEAD(&cdev_value->list);
+	}
+
+	return cdev_value;
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal_debugfs *dfs,
+							  struct list_head *list, int id)
+{
+	struct cdev_value *pos;
+
+	list_for_each_entry(pos, &list[id % CDEVSTATS_HASH_SIZE], list)
+		if (pos->id == id)
+			return pos;
+
+	return NULL;
+}
+
+static void thermal_debugfs_cdev_value_insert(struct thermal_debugfs *dfs,
+					      struct list_head *list,
+					      struct cdev_value *cdev_value)
+{
+	list_add_tail(&cdev_value->list, &list[cdev_value->id % CDEVSTATS_HASH_SIZE]);
+}
+
+struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_debugfs *dfs,
+						  struct list_head *list, int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_find(dfs, list, id);
+	if (cdev_value)
+		return cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_alloc(id);
+	if (cdev_value)
+		thermal_debugfs_cdev_value_insert(dfs, list, cdev_value);
+
+	return cdev_value;
+}
+
+static void thermal_debugfs_cdev_reset(struct cdev_debugfs *cfs)
+{
+	int i;
+	struct cdev_value *pos, *tmp;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+
+		list_for_each_entry_safe(pos, tmp, &cfs->trans_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+
+		list_for_each_entry_safe(pos, tmp, &cfs->duration_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+	}
+
+	cfs->total = 0;
+}
+
+void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, int to)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+	struct cdev_debugfs *cfs;
+	struct cdev_value *cdev_value;
+	ktime_t now = ktime_get();
+	int transition, from;
+
+	if (!dfs || (dfs->cdev.current_state == to))
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	cfs = &dfs->cdev;
+
+	from = cfs->current_state;
+	cfs->current_state = to;
+	transition = (from << 16) | to;
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->duration_list, from);
+	if (cdev_value) {
+		cdev_value->value += ktime_ms_delta(now, cfs->timestamp);
+		cfs->timestamp = now;
+	}
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->trans_list, transition);
+	if (cdev_value)
+		cdev_value->value++;
+
+	cfs->total++;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_lock(&dfs->lock);
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
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static int cdev_tt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;	
+	struct cdev_debugfs *cfs = &dfs->cdev;
+	struct list_head *trans_list = cfs->trans_list;
+	struct cdev_value *pos;
+	char buffer[11];
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "Transition\tHits\n");
+
+	list_for_each_entry(pos, &trans_list[i], list) {
+
+		snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
+			 pos->id >> 16, pos->id & 0xFFFF);
+
+		seq_printf(s, "%-10s\t%-10llu\n", buffer, pos->value);
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
+	struct cdev_debugfs *cfs = s->private;
+	struct list_head *duration_list = cfs->duration_list;
+	struct cdev_value *pos;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "State\tTime\n");
+
+	list_for_each_entry(pos, &duration_list[i], list) {
+		s64 duration = pos->value;
+
+		if (pos->id == cfs->current_state)
+			duration += ktime_ms_delta(ktime_get(), cfs->timestamp);
+
+		seq_printf(s, "%-5d\t%-10llu\n", pos->id, duration);
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
+static int cdev_reset_set(void *data, u64 val)
+{
+	struct thermal_debugfs *dfs = data;
+
+	if (!val)
+		return -EINVAL;
+
+	thermal_debugfs_cdev_reset(&dfs->cdev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdev_reset_fops, NULL, cdev_reset_set, "%llu\n");
+
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs;
+	struct cdev_debugfs *cfs;
+	int i;
+
+	dfs = thermal_debugfs_add_id(d_cdev, cdev->id);
+	if (!dfs)
+		return;
+
+	cfs = &dfs->cdev;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&cfs->trans_list[i]);
+		INIT_LIST_HEAD(&cfs->duration_list[i]);
+	}
+
+	cfs->current_state = 0;
+	cfs->timestamp = ktime_get();
+
+	debugfs_create_file("trans_table", 0400, dfs->d_top, dfs, &tt_fops);
+
+	debugfs_create_file("time_in_state_ms", 0400, dfs->d_top, dfs, &dt_fops);
+
+	debugfs_create_file("reset", 0200, dfs->d_top, dfs, &cdev_reset_fops);
+
+	debugfs_create_u32("total_trans", 0400, dfs->d_top, &cfs->total);
+
+	cdev->debugfs = dfs;
+}
+
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+
+	if (!dfs)
+		return;
+
+	thermal_debugfs_cdev_reset(&dfs->cdev);
+	cdev->debugfs = NULL;
+	thermal_debugfs_remove_id(dfs);
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
new file mode 100644
index 000000000000..674eec369328
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_THERMAL_DEBUGFS
+void thermal_debug_init(void);
+void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
+void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, int state);
+#else
+static inline void thermal_debug_init(void) {}
+static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
+static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
+static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
+#endif /* CONFIG_THERMAL_DEBUGFS */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 69e8ea4aa908..c34e27e427ae 100644
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
+		thermal_debug_cdev_transition(cdev, state);
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


