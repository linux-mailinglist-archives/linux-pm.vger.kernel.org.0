Return-Path: <linux-pm+bounces-11034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A992F9D9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82941F231E2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637A16D4FE;
	Fri, 12 Jul 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hin1YZeK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931126AED;
	Fri, 12 Jul 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785725; cv=none; b=rFR69aXmVXT6ItXtk6VumoC+nqdjt4bVFDSruQ/mWYYGMYHcRiKTBPZ3sHyuzLFJw0QRqcVSAYXnix1QbMRNCOmkuCeJgYDqwBQI/pyeMlJ2oHDeICZV88cLFhLUqHwmo/oOcHEmbhDfFSX7ymPAC0eivsMOlriuqimjlOTgPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785725; c=relaxed/simple;
	bh=9pX/W00fGI1o3+ovIefaqPvMLi085zC0eO3UHD4r5LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjI0AwWrtpFah0I0q7+lpbSBu3x/xBUCu22B6VArWjYxIGtf74zebx4N+DCQcaceIDtyVTZAjUpdIp2GdzPK1pniB2auGuB0GDHgFPPdNAo8PhrWgAK330HCpvAXGwH/tDrro9rZodQBrZHNL+5/jibYZwnXF51vRxG4yGNnUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hin1YZeK; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 54bcffb89d1428a9; Fri, 12 Jul 2024 14:01:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 32DE9A03391;
	Fri, 12 Jul 2024 14:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720785713;
	bh=9pX/W00fGI1o3+ovIefaqPvMLi085zC0eO3UHD4r5LU=;
	h=From:To:Cc:Subject:Date;
	b=hin1YZeKQS3Jne11r2oXV30GJw+CFIrEQQLKq/WBkU0+SF3zu5L/moMKuGPmV5oep
	 Vn7P8ZzA4X9MnUNhzCpYS+QKeizk6SVIq9p6E/D0DY7SrpMxx4gFMixWR4yEBY4b9z
	 sb4JTYoJC3e+ovOqlO5s/p4aKXKA+/ikOU+K0INT2DZxf5QUvXLwvV6LYu/KG+xGa0
	 qu2+bkI8++rnuxQ7+XalmG4u4zxfusQSzBxTBnkb+MscL6D3v9BMFQyvi+WvsAZ0dp
	 W8ViGj2h3jnkyeCiXLlBHXKrCbDoviB3qUgIGISpEmXPfjHXyLXTV4Vn4GPjgl/MEm
	 Ign+Vk9ZcHKeA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [RFC][PATCH v1] thermal: Introduce a debugfs-based testing facility
Date: Fri, 12 Jul 2024 14:01:52 +0200
Message-ID: <5804761.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedugfegtdejhfejfffhvddtudejtdeuvdevgeekteejffevjefgudegleevleegjeenucffohhmrghinhepthhhvghrmhgrlhdqthgvshhtihhnghdrlhhsnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
 vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a facility allowing the thermal core functionality to be
exercised in a controlled way in order to verify its behavior, without
affecting its regular users noticeably.

It is based on the idea of preparing thermal zone templates along with
their trip points by writing to files in debugfs.  When ready, those
templates can be used for registering test thermal zones with the
thermal core.  The temperature of a test thermal zone created this
way can be adjusted via debugfs, which also triggers the execution of
thermal_zone_device_update() for it.  By manipulating the temperature
of a test thermal zone, one can check if the thermal core reacts to
the changes of it as expected.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a small project I embarked on in the face of some thermal core
testing difficulties.  In its current form it is quite limited, but
still quite useful at least for me.  In the future, it can be extended
to allow test cooling devices to be registered and bound to trip points
in test thermal zones, so that governor response can be tested at least
in some scenarios.

It is targeting 6.12 (roughly) unless there are strong objections.

---
 drivers/thermal/Kconfig                   |    9 
 drivers/thermal/Makefile                  |    1 
 drivers/thermal/testing/Makefile          |    7 
 drivers/thermal/testing/command.c         |  223 +++++++++++++
 drivers/thermal/testing/thermal_testing.h |   11 
 drivers/thermal/testing/zone.c            |  506 ++++++++++++++++++++++++++++++
 6 files changed, 757 insertions(+)

Index: linux-pm/drivers/thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
@@ -40,6 +40,15 @@ config THERMAL_DEBUGFS
 	  Say Y to allow the thermal subsystem to collect diagnostic
 	  information that can be accessed via debugfs.
 
+config THERMAL_CORE_TESTING
+	tristate "Thermal core testing facility"
+	depends on DEBUG_FS
+	help
+	  Say Y to add a debugfs-based thermal core testing facility.
+	  It allows test thermal zones to be created and populated
+	  with trip points in order to exercise the thermal core
+	  functionality in a controlled way.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
Index: linux-pm/drivers/thermal/Makefile
===================================================================
--- linux-pm.orig/drivers/thermal/Makefile
+++ linux-pm/drivers/thermal/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += aml
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
+obj-$(CONFIG_THERMAL_CORE_TESTING)	+= testing/
Index: linux-pm/drivers/thermal/testing/Makefile
===================================================================
--- /dev/null
+++ linux-pm/drivers/thermal/testing/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Thermal core testing facility.
+
+obj-$(CONFIG_THERMAL_CORE_TESTING) += thermal-testing.o
+
+thermal-testing-y := command.o zone.o
Index: linux-pm/drivers/thermal/testing/command.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/thermal/testing/command.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024, Intel Corporation
+ *
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * Thermal subsystem testing facility.
+ *
+ * This facility allows the thermal core functionality to be exercised in a
+ * controlled way in order to verify its behavior.
+ *
+ * It resides in the "thermal-testing" directory under the debugfs root and
+ * starts with a single file called "command" which can be written a string
+ * representing a thermal testing facility command.
+ *
+ * The currently supported commands are listed in the tt_commands enum below.
+ *
+ * The "addtz" command causes a new test thermal zone template to be created,
+ * for example:
+ *
+ * # echo addtz > /sys/kernel/debug/thermal-testing/command
+ *
+ * That template will be represented as a subdirectory in the "thermal-testing"
+ * directory, for example
+ *
+ * # ls /sys/kernel/debug/thermal-testing/
+ * command tz0
+ *
+ * The thermal zone template can be populated with trip points with the help of
+ * the "tzaddtrip" command, for example:
+ *
+ * # echo tzaddtrip:0 > /sys/kernel/debug/thermal-testing/command
+ *
+ * which causes a trip point template to be added to the testing thermal zone
+ * template 0 (represented by the tz0 subdirectory in "thermal-testing").
+ *
+ * # ls /sys/kernel/debug/thermal-testing/tz0
+ * temp trip_0_temp trip_0_hyst
+ *
+ * The temperature of a trip point template is initially THERMAL_TEMP_INVALID
+ * and its hysteresis is initially 0.  They can be adjusted by writing to the
+ * "trip_x_temp" and "trip_x_hyst" files correspoinding to that trip point
+ * template, respectively.
+ *
+ * The initial temperature of a thermal zone based on a template can be set by
+ * writing to the "temp" file in its directory under "thermal-testing", for
+ * example:
+ *
+ * echo 50000 > /sys/kernel/debug/thermal-testing/tz0/temp
+ *
+ * When ready, "tzreg" command can be used for registering and enabling a
+ * thermal zone based on a given template with the thermal core, for example
+ *
+ * # echo tzreg:0 > /sys/kernel/debug/thermal-testing/command
+ *
+ * In this case, test thermal zone template 0 is used for registering a new
+ * thermal zone and the set of trip point templates associated with it is used
+ * for populating the new thermal zone's trip points table.  The type of the new
+ * thermal zone is "test_tz".
+ *
+ * The temperature and hysteresis of all of the trip points in that thermal zone
+ * are writable via sysfs, so they can be updated at any time.
+ *
+ * Its temperature can be changed by writing to the "temp" file in the
+ * corresponding directory under "thermal-testing", just like the initial
+ * temperature value.  However, after a thermal zone based on a given template
+ * has been registered, changing its temperature will trigger a temperature
+ * update in the thermal core, including the processing of its trip points,
+ * sending notifications to user space and so on.
+ *
+ * When it is not needed any more, a test thermal zone template can be deleted
+ * with the help of the "deltz" command, for example
+ *
+ * # echo deltz:0 > /sys/kernel/debug/thermal-testing/command
+ *
+ * which will also unregister the thermal zone based on it, if present.
+ */
+
+#define pr_fmt(fmt) "thermal-testing: " fmt
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+
+#include "thermal_testing.h"
+
+struct dentry *d_testing;
+
+#define TT_COMMAND_SIZE		16
+
+enum tt_commands {
+	TT_CMD_ADDTZ,
+	TT_CMD_DELTZ,
+	TT_CMD_TZADDTRIP,
+	TT_CMD_TZREG,
+	TT_CMD_TZUNREG,
+};
+
+static const char *tt_command_strings[] = {
+	[TT_CMD_ADDTZ] = "addtz",
+	[TT_CMD_DELTZ] = "deltz",
+	[TT_CMD_TZADDTRIP] = "tzaddtrip",
+	[TT_CMD_TZREG] = "tzreg",
+	[TT_CMD_TZUNREG] = "tzunreg",
+};
+
+static int tt_process_command(int index, const char *arg)
+{
+	int ret;
+
+	switch (index) {
+	case TT_CMD_ADDTZ:
+		ret = tt_add_tz();
+		break;
+
+	case TT_CMD_DELTZ:
+		ret = tt_del_tz(arg);
+		break;
+
+	case TT_CMD_TZADDTRIP:
+		ret = tt_zone_add_trip(arg);
+		break;
+
+	case TT_CMD_TZREG:
+		ret = tt_zone_reg(arg);
+		break;
+
+	case TT_CMD_TZUNREG:
+		ret = tt_zone_unreg(arg);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t tt_command_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	char *arg, *buf = NULL;
+	ssize_t ret;
+	int i;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+
+	if (*ppos) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (count + 1 > TT_COMMAND_SIZE) {
+		ret = -E2BIG;
+		goto exit;
+	}
+
+	buf = kmalloc(count + 1, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	if (copy_from_user(buf, user_buf, count)) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	buf[count] = '\0';
+	strim(buf);
+
+	arg = strstr(buf, ":");
+	if (arg) {
+		*arg = '\0';
+		arg++;
+	}
+
+	ret = -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(tt_command_strings); i++) {
+		if (!strcmp(buf, tt_command_strings[i])) {
+			ret = tt_process_command(i, arg);
+			break;
+		}
+	}
+
+exit:
+	kfree(buf);
+	debugfs_file_put(dentry);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations tt_command_fops = {
+	.write = tt_command_write,
+	.open =	 simple_open,
+	.llseek = default_llseek,
+};
+
+static int __init thermal_testing_init(void)
+{
+	d_testing = debugfs_create_dir("thermal-testing", NULL);
+	if (d_testing)
+		debugfs_create_file("command", 0200, d_testing, NULL,
+				    &tt_command_fops);
+
+	return 0;
+}
+module_init(thermal_testing_init);
+
+static void __exit thermal_testing_exit(void)
+{
+	debugfs_remove(d_testing);
+	tt_zone_cleanup();
+}
+module_exit(thermal_testing_exit);
+
+MODULE_DESCRIPTION("Thermal core testing facility");
+MODULE_LICENSE("GPL v2");
Index: linux-pm/drivers/thermal/testing/thermal_testing.h
===================================================================
--- /dev/null
+++ linux-pm/drivers/thermal/testing/thermal_testing.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct dentry *d_testing;
+
+int tt_add_tz(void);
+int tt_del_tz(const char *arg);
+int tt_zone_add_trip(const char *arg);
+int tt_zone_reg(const char *arg);
+int tt_zone_unreg(const char *arg);
+
+void tt_zone_cleanup(void);
Index: linux-pm/drivers/thermal/testing/zone.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/thermal/testing/zone.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024, Intel Corporation
+ *
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * Thermal zone tempalates handling for thermal core testing.
+ */
+
+#define pr_fmt(fmt) "thermal-testing: " fmt
+
+#include <linux/debugfs.h>
+#include <linux/thermal.h>
+#include <linux/workqueue.h>
+
+#include "thermal_testing.h"
+
+#define TT_MAX_FILE_NAME_LENGTH		16
+
+/*
+ * It is both questionable and potentially problematic from the sychnronization
+ * perspective to attempt to manipulate debugfs from within a debugfs file
+ * "write" operation, so auxiliary work items are used for that.  The majority
+ * of zone-related command functions have a part that runs from a workqueue and
+ * make changes in debugs, among other things.
+ */
+struct tt_work {
+	struct work_struct work;
+	void *data;
+};
+
+static inline struct tt_work *tt_work_of_work(struct work_struct *work)
+{
+	return container_of(work, struct tt_work, work);
+}
+
+/**
+ * struct tt_thermal_zone - Testing thermal zone template
+ *
+ * Represents a template of a thermal zone that can be used for registering
+ * a test thermal zone with the thermal core.
+ *
+ * @list_node: Node in the list of all testing thermal zone templates.
+ * @trips: List of trip point templates for this thermal zone template.
+ * @d_tz: Directory in debugfs representing this template.
+ * @tz: Test thermal zone based on this template, if present.
+ * @lock: Mutex for synchronizing changes of this template.
+ * @ida: IDA for trip point IDs.
+ * @id: The ID of this template for the debugfs interface.
+ * @temp: Temperature value.
+ * @num_trips: Number of trip points in the @trips list.
+ * @refcont: Reference counter for usage and removal synchronization.
+ */
+struct tt_thermal_zone {
+	struct list_head list_node;
+	struct list_head trips;
+	struct dentry *d_tz;
+	struct thermal_zone_device *tz;
+	struct mutex lock;
+	struct ida ida;
+	int id;
+	int temp;
+	unsigned int num_trips;
+	unsigned int refcount;
+};
+
+/**
+ * struct tt_trip - Testing trip point template
+ *
+ * Represents a template of a trip point to be used for populating a trip point
+ * during the registration of a thermal zone based on a given zone template.
+ *
+ * @list_node: Node in the list of all trip template in @tt_zone.
+ * @tt_zone: Zone template this trip template belongs to.
+ * @trip: Trip point data to use for thernal zone registration.
+ * @id: The ID of this trip template for the debugfs interface.
+ */
+struct tt_trip {
+	struct list_head list_node;
+	struct tt_thermal_zone *tt_zone;
+	struct thermal_trip trip;
+	int id;
+};
+
+static LIST_HEAD(tt_thermal_zones);
+static DEFINE_IDA(tt_thermal_zones_ida);
+static DEFINE_MUTEX(tt_thermal_zones_lock);
+
+static int tt_zone_temp_get(void *data, u64 *val)
+{
+	struct tt_thermal_zone *tt_zone = data;
+
+	*val = tt_zone->temp;
+
+	return 0;
+}
+
+static int tt_zone_temp_set(void *data, u64 val)
+{
+	struct tt_thermal_zone *tt_zone = data;
+
+	WRITE_ONCE(tt_zone->temp, val);
+
+	mutex_lock(&tt_zone->lock);
+
+	if (tt_zone->tz)
+		thermal_zone_device_update(tt_zone->tz, THERMAL_EVENT_TEMP_SAMPLE);
+
+	mutex_unlock(&tt_zone->lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(tt_zone_temp_fops, tt_zone_temp_get,
+				tt_zone_temp_set, "%lld\n");
+
+static void tt_free_tz(struct tt_thermal_zone *tt_zone)
+{
+	ida_free(&tt_thermal_zones_ida, tt_zone->id);
+	kfree(tt_zone);
+}
+
+static void tt_add_tz_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_thermal_zone *tt_zone = tt_work->data;
+	char d_name[TT_MAX_FILE_NAME_LENGTH];
+
+	kfree(tt_work);
+
+	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "tz%d", tt_zone->id);
+
+	tt_zone->d_tz = debugfs_create_dir(d_name, d_testing);
+	if (!tt_zone->d_tz) {
+		tt_free_tz(tt_zone);
+		return;
+	}
+
+	debugfs_create_file("temp", 0600, tt_zone->d_tz, tt_zone, &tt_zone_temp_fops);
+
+	mutex_lock(&tt_thermal_zones_lock);
+
+	list_add_tail(&tt_zone->list_node, &tt_thermal_zones);
+
+	mutex_unlock(&tt_thermal_zones_lock);
+}
+
+int tt_add_tz(void)
+{
+	struct tt_thermal_zone *tt_zone __free(kfree);
+	struct tt_work *tt_work __free(kfree);
+	int ret;
+
+	tt_zone = kzalloc(sizeof(*tt_zone), GFP_KERNEL);
+	if (!tt_zone)
+		return -ENOMEM;
+
+	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	if (!tt_work)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&tt_zone->trips);
+	mutex_init(&tt_zone->lock);
+	ida_init(&tt_zone->ida);
+	tt_zone->temp = THERMAL_TEMP_INVALID;
+
+	ret = ida_alloc(&tt_thermal_zones_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	tt_zone->id = ret;
+
+	INIT_WORK(&tt_work->work, tt_add_tz_work_fn);
+	tt_work->data = no_free_ptr(tt_zone);
+	schedule_work(&(no_free_ptr(tt_work)->work));
+
+	return 0;
+}
+
+static void tt_del_tz_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_thermal_zone *tt_zone = tt_work->data;
+
+	kfree(tt_work);
+
+	debugfs_remove(tt_zone->d_tz);
+	tt_free_tz(tt_zone);
+}
+
+static void tt_zone_unregister_tz(struct tt_thermal_zone *tt_zone)
+{
+	mutex_lock(&tt_zone->lock);
+
+	if (tt_zone->tz) {
+		thermal_zone_device_unregister(tt_zone->tz);
+		tt_zone->tz = NULL;
+	}
+
+	mutex_unlock(&tt_zone->lock);
+}
+
+int tt_del_tz(const char *arg)
+{
+	struct tt_work *tt_work __free(kfree);
+	struct tt_thermal_zone *tt_zone, *aux;
+	int ret;
+	int id;
+
+	ret = sscanf(arg, "%d", &id);
+	if (ret != 1)
+		return -EINVAL;
+
+	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	if (!tt_work)
+		return -ENOMEM;
+
+	mutex_lock(&tt_thermal_zones_lock);
+
+	ret = -EINVAL;
+	list_for_each_entry_safe(tt_zone, aux, &tt_thermal_zones, list_node) {
+		if (tt_zone->id == id) {
+			if (tt_zone->refcount) {
+				ret = -EBUSY;
+			} else {
+				list_del(&tt_zone->list_node);
+				ret = 0;
+			}
+			break;
+		}
+	}
+
+	mutex_unlock(&tt_thermal_zones_lock);
+
+	if (ret)
+		return ret;
+
+	tt_zone_unregister_tz(tt_zone);
+
+	INIT_WORK(&tt_work->work, tt_del_tz_work_fn);
+	tt_work->data = tt_zone;
+	schedule_work(&(no_free_ptr(tt_work)->work));
+
+	return 0;
+}
+
+static struct tt_thermal_zone *tt_get_tt_zone(const char *arg)
+{
+	struct tt_thermal_zone *tt_zone;
+	int ret, id;
+
+	ret = sscanf(arg, "%d", &id);
+	if (ret != 1)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&tt_thermal_zones_lock);
+
+	ret = -EINVAL;
+	list_for_each_entry(tt_zone, &tt_thermal_zones, list_node) {
+		if (tt_zone->id == id) {
+			tt_zone->refcount++;
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&tt_thermal_zones_lock);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return tt_zone;
+}
+
+static void tt_put_tt_zone(struct tt_thermal_zone *tt_zone)
+{
+	mutex_lock(&tt_thermal_zones_lock);
+
+	tt_zone->refcount--;
+
+	mutex_unlock(&tt_thermal_zones_lock);
+}
+
+static int tt_trip_temp_get(void *data, u64 *val)
+{
+	struct tt_trip *tt_trip = data;
+
+	*val = tt_trip->trip.temperature;
+
+	return 0;
+}
+
+static int tt_trip_temp_set(void *data, u64 val)
+{
+	struct tt_trip *tt_trip = data;
+	struct tt_thermal_zone *tt_zone = tt_trip->tt_zone;
+	int ret;
+
+	if ((int)val < THERMAL_TEMP_INVALID)
+		return -EINVAL;
+
+	mutex_lock(&tt_zone->lock);
+
+	if (tt_zone->tz) {
+		ret = -EBUSY;
+	} else {
+		tt_trip->trip.temperature = val;
+		ret = 0;
+	}
+
+	mutex_unlock(&tt_zone->lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(tt_trip_temp_fops, tt_trip_temp_get,
+				tt_trip_temp_set, "%lld\n");
+
+static int tt_trip_hyst_get(void *data, u64 *val)
+{
+	struct tt_trip *tt_trip = data;
+
+	*val = tt_trip->trip.hysteresis;
+
+	return 0;
+}
+
+static int tt_trip_hyst_set(void *data, u64 val)
+{
+	struct tt_trip *tt_trip = data;
+	struct tt_thermal_zone *tt_zone = tt_trip->tt_zone;
+	int ret;
+
+	mutex_lock(&tt_zone->lock);
+
+	if (tt_zone->tz) {
+		ret = -EBUSY;
+	} else {
+		tt_trip->trip.hysteresis = val;
+		ret = 0;
+	}
+
+	mutex_unlock(&tt_zone->lock);
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(tt_trip_hyst_fops, tt_trip_hyst_get,
+			 tt_trip_hyst_set, "%llu\n");
+
+static void tt_zone_add_trip_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_trip *tt_trip = tt_work->data;
+	struct tt_thermal_zone *tt_zone = tt_trip->tt_zone;
+	char d_name[TT_MAX_FILE_NAME_LENGTH];
+
+	kfree(tt_work);
+
+	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_temp", tt_trip->id);
+	debugfs_create_file(d_name, 0600, tt_zone->d_tz, tt_trip, &tt_trip_temp_fops);
+
+	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_hyst", tt_trip->id);
+	debugfs_create_file(d_name, 0600, tt_zone->d_tz, tt_trip, &tt_trip_hyst_fops);
+
+	tt_put_tt_zone(tt_zone);
+}
+
+int tt_zone_add_trip(const char *arg)
+{
+	struct tt_work *tt_work __free(kfree);
+	struct tt_trip *tt_trip __free(kfree);
+	struct tt_thermal_zone *tt_zone;
+	int id;
+
+	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	if (!tt_work)
+		return -ENOMEM;
+
+	tt_trip = kzalloc(sizeof(*tt_trip), GFP_KERNEL);
+	if (!tt_trip)
+		return -ENOMEM;
+
+	tt_zone = tt_get_tt_zone(arg);
+	if (IS_ERR(tt_zone))
+		return PTR_ERR(tt_zone);
+
+	id = ida_alloc(&tt_zone->ida, GFP_KERNEL);
+	if (id < 0) {
+		tt_put_tt_zone(tt_zone);
+		return id;
+	}
+
+	tt_trip->tt_zone = tt_zone;
+	tt_trip->trip.type = THERMAL_TRIP_ACTIVE;
+	tt_trip->trip.temperature = THERMAL_TEMP_INVALID;
+	tt_trip->trip.flags = THERMAL_TRIP_FLAG_RW;
+	tt_trip->id = id;
+
+	mutex_lock(&tt_zone->lock);
+
+	list_add_tail(&tt_trip->list_node, &tt_zone->trips);
+	tt_zone->num_trips++;
+
+	mutex_unlock(&tt_zone->lock);
+
+	INIT_WORK(&tt_work->work, tt_zone_add_trip_work_fn);
+	tt_work->data = no_free_ptr(tt_trip);
+	schedule_work(&(no_free_ptr(tt_work)->work));
+
+	return 0;
+}
+
+static int tt_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct tt_thermal_zone *tt_zone = thermal_zone_device_priv(tz);
+
+	*temp = READ_ONCE(tt_zone->temp);
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tt_zone_ops = {
+	.get_temp = tt_zone_get_temp,
+};
+
+int tt_zone_reg(const char *arg)
+{
+	struct thermal_trip *trips __free(kfree);
+	struct thermal_zone_device *tz;
+	struct tt_thermal_zone *tt_zone;
+	struct tt_trip *tt_trip;
+	int ret = 0;
+	int i;
+
+	tt_zone = tt_get_tt_zone(arg);
+	if (IS_ERR(tt_zone))
+		return PTR_ERR(tt_zone);
+
+	mutex_lock(&tt_zone->lock);
+
+	trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
+	if (!trips) {
+		ret = -ENOMEM;
+		goto put_zone;
+	}
+
+	i = 0;
+	list_for_each_entry(tt_trip, &tt_zone->trips, list_node)
+		trips[i++] = tt_trip->trip;
+
+	tz = thermal_zone_device_register_with_trips("test_tz", trips, i, tt_zone,
+						     &tt_zone_ops, NULL, 0, 0);
+	if (IS_ERR(tz)) {
+		ret = PTR_ERR(tz);
+		goto put_zone;
+	}
+
+	tt_zone->tz = tz;
+
+	thermal_zone_device_enable(tz);
+
+put_zone:
+	mutex_unlock(&tt_zone->lock);
+
+	tt_put_tt_zone(tt_zone);
+
+	return ret;
+}
+
+int tt_zone_unreg(const char *arg)
+{
+	struct tt_thermal_zone *tt_zone;
+
+	tt_zone = tt_get_tt_zone(arg);
+	if (IS_ERR(tt_zone))
+		return PTR_ERR(tt_zone);
+
+	tt_zone_unregister_tz(tt_zone);
+
+	tt_put_tt_zone(tt_zone);
+
+	return 0;
+}
+
+void tt_zone_cleanup(void)
+{
+	struct tt_thermal_zone *tt_zone, *t_z;
+
+	list_for_each_entry_safe(tt_zone, t_z, &tt_thermal_zones, list_node) {
+		struct tt_thermal_zone *tt_trip, *t_t;
+
+		tt_zone_unregister_tz(tt_zone);
+
+		ida_free(&tt_thermal_zones_ida, tt_zone->id);
+		list_del(&tt_zone->list_node);
+
+		list_for_each_entry_safe(tt_trip, t_t, &tt_zone->trips, list_node) {
+			ida_free(&tt_zone->ida, tt_trip->id);
+			list_del(&tt_trip->list_node);
+			kfree(tt_trip);
+		}
+
+		kfree(tt_zone);
+	}
+}




