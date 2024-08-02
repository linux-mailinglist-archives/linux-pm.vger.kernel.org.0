Return-Path: <linux-pm+bounces-11844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC09462D4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B16828289E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAEB15C126;
	Fri,  2 Aug 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tjxppv62"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA531537A3;
	Fri,  2 Aug 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621924; cv=none; b=fgQG3hy/GaqNcoStOUEyTEfvGCvxt0t/hDXVz0PtQk47u0jbTQ5rSlbyfq8j4LesRse98ZqOY4bEHCAQdZ5hn8W59wikosRzlNcyCXOc6+s5TtQS1k+IgHS5vS8wlvxjfkVNYu4KIinDvggNXujk6FO02RoJGi7VrGgzD2/cfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621924; c=relaxed/simple;
	bh=9MwyrPH0K+ij8DIY11QXXJjikxwVcrIG054NVN+XUdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7AtLNvAt6DiAz1g7wcOwYX4UJKGqDv949nbpmpg5AdlqptQdSWkDtz2Tua3mIBiwVJwFHvxUBUfb59fEo3EEzmiUBw/9eksUCBMT1erkFTppgexC8TyE3PmSmaT1TnQeWvvD+1bhyCjYhQ4gfTBvUg5eqItqlUxBRC/4lfmmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tjxppv62; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id efaced6ae34c55cc; Fri, 2 Aug 2024 20:05:11 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9EA9373B540;
	Fri,  2 Aug 2024 20:05:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722621909;
	bh=9MwyrPH0K+ij8DIY11QXXJjikxwVcrIG054NVN+XUdc=;
	h=From:To:Cc:Subject:Date;
	b=tjxppv62yjJiryAVkX1rBD0Y8Q8Y7gIfMFcZ82HEwqZ4KiTiUDnecWHlzQ11qidAv
	 nJOhlQVhBkacZjDcLm5MZxico6pyMJLX+Soy/1zbUtMkZqiduEpBFiznctPwuZzMWN
	 ZLSjDOnWQJISl3Pf2uYI/ps8mYe/VTZxI4gb7sMqLr2a64B6IeHwhgo3mZca0Ss/ct
	 6Ch6Uy0umxdlQ0KzIuY7uNclbUeZxqAltx1y7UePVl+4Lm2hhG+8OANpiVgKHpgnga
	 UT9DnQbI+YmmgsEbHj1bPGHveOQRDegeExQlCcHaq53wuMzHUieP1bGlFInRs2z9j5
	 GgF3IpujIglOA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1] thermal: Introduce a debugfs-based testing facility
Date: Fri, 02 Aug 2024 20:05:03 +0200
Message-ID: <6065927.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepudfggedtjefhjeffhfdvtddujedtuedvveegkeetjeffveejgfdugeelveelgeejnecuffhomhgrihhnpehthhgvrhhmrghlqdhtvghsthhinhhgrdhlshenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
 lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a facility allowing the thermal core functionality to be
exercised in a controlled way in order to verify its behavior, without
affecting its regular users noticeably.

It is based on the idea of preparing thermal zone templates along with
their trip points by writing to files in debugfs.  When ready, those
templates can be used for registering test thermal zones with the
thermal core.

The temperature of a test thermal zone created this way can be adjusted
via debugfs, which also triggers a __thermal_zone_device_update() call
for it.  By manipulating the temperature of a test thermal zone, one can
check if the thermal core reacts to the changes of it as expected.

Concise "howto" documentation is included in one of the source files.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

In its current form, this is quite limited, but still quite useful at
least for me.  In the future, it can be extended to allow "mock" test
cooling devices to be registered and bound to trip points in "mock"
test thermal zones, so that governor response can be tested at least
in some scenarios.  On top of that, a test scripts can be developed
for automated testing of the thermal core.  IOW, it's just a start.

---
 drivers/thermal/Kconfig                   |    9 
 drivers/thermal/Makefile                  |    1 
 drivers/thermal/testing/Makefile          |    7 
 drivers/thermal/testing/command.c         |  221 ++++++++++++++
 drivers/thermal/testing/thermal_testing.h |   11 
 drivers/thermal/testing/zone.c            |  469 ++++++++++++++++++++++++++++++
 6 files changed, 718 insertions(+)

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
@@ -0,0 +1,221 @@
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
+ * which causes a trip point template to be added to the test thermal zone
+ * template 0 (represented by the tz0 subdirectory in "thermal-testing").
+ *
+ * # ls /sys/kernel/debug/thermal-testing/tz0
+ * init_temp temp trip_0_temp trip_0_hyst
+ *
+ * The temperature of a trip point template is initially THERMAL_TEMP_INVALID
+ * and its hysteresis is initially 0.  They can be adjusted by writing to the
+ * "trip_x_temp" and "trip_x_hyst" files correspoinding to that trip point
+ * template, respectively.
+ *
+ * The initial temperature of a thermal zone based on a template can be set by
+ * writing to the "init_temp" file in its directory under "thermal-testing", for
+ * example:
+ *
+ * echo 50000 > /sys/kernel/debug/thermal-testing/tz0/init_temp
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
+ * The temperature and hysteresis of all of the trip points in that new thermal
+ * zone are adjustable via sysfs, so they can be updated at any time.
+ *
+ * The current temperature of the new thermal zone can be set by writing to the
+ * "temp" file in the corresponding thermal zone template's directory under
+ * "thermal-testing", for example
+ *
+ * echo 10000 > /sys/kernel/debug/thermal-testing/tz0/temp
+ *
+ * which will also trigger a temperature update for this zone in the thermal
+ * core, including checking its trip points, sending notifications to user space
+ * if any of them have been crossed and so on.
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
+static int tt_command_exec(int index, const char *arg)
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
+static ssize_t tt_command_process(struct dentry *dentry, const char __user *user_buf,
+				  size_t count)
+{
+	char *buf __free(kfree);
+	char *arg;
+	int i;
+
+	buf = kmalloc(count + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
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
+	for (i = 0; i < ARRAY_SIZE(tt_command_strings); i++) {
+		if (!strcmp(buf, tt_command_strings[i]))
+			return tt_command_exec(i, arg);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t tt_command_write(struct file *file, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	ssize_t ret;
+
+	if (*ppos)
+		return -EINVAL;
+
+	if (count + 1 > TT_COMMAND_SIZE)
+		return -E2BIG;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+
+	ret = tt_command_process(dentry, user_buf, count);
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
@@ -0,0 +1,469 @@
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
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/thermal.h>
+#include <linux/workqueue.h>
+
+#include "thermal_testing.h"
+
+#define TT_MAX_FILE_NAME_LENGTH		16
+
+/**
+ * struct tt_thermal_zone - Testing thermal zone template
+ *
+ * Represents a template of a thermal zone that can be used for registering
+ * a test thermal zone with the thermal core.
+ *
+ * @list_node: Node in the list of all testing thermal zone templates.
+ * @trips: List of trip point templates for this thermal zone template.
+ * @d_tt_zone: Directory in debugfs representing this template.
+ * @tz: Test thermal zone based on this template, if present.
+ * @lock: Mutex for synchronizing changes of this template.
+ * @ida: IDA for trip point IDs.
+ * @id: The ID of this template for the debugfs interface.
+ * @temp: Temperature value.
+ * @tz_temp: Current thermal zone temperature (after registration).
+ * @num_trips: Number of trip points in the @trips list.
+ * @refcont: Reference counter for usage and removal synchronization.
+ */
+struct tt_thermal_zone {
+	struct list_head list_node;
+	struct list_head trips;
+	struct dentry *d_tt_zone;
+	struct thermal_zone_device *tz;
+	struct mutex lock;
+	struct ida ida;
+	int id;
+	int temp;
+	int tz_temp;
+	unsigned int num_trips;
+	unsigned int refcount;
+};
+
+DEFINE_GUARD(tt_zone, struct tt_thermal_zone *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
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
+	struct thermal_trip trip;
+	int id;
+};
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
+	struct tt_thermal_zone *tt_zone;
+	struct tt_trip *tt_trip;
+};
+
+static inline struct tt_work *tt_work_of_work(struct work_struct *work)
+{
+	return container_of(work, struct tt_work, work);
+}
+
+static LIST_HEAD(tt_thermal_zones);
+static DEFINE_IDA(tt_thermal_zones_ida);
+static DEFINE_MUTEX(tt_thermal_zones_lock);
+
+static int tt_int_get(void *data, u64 *val)
+{
+	*val = *(int *)data;
+	return 0;
+}
+static int tt_int_set(void *data, u64 val)
+{
+	if ((int)val < THERMAL_TEMP_INVALID)
+		return -EINVAL;
+
+	*(int *)data = val;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(tt_int_attr, tt_int_get, tt_int_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(tt_unsigned_int_attr, tt_int_get, tt_int_set, "%llu\n");
+
+static int tt_zone_tz_temp_get(void *data, u64 *val)
+{
+	struct tt_thermal_zone *tt_zone = data;
+
+	guard(tt_zone)(tt_zone);
+
+	if (!tt_zone->tz)
+		return -EBUSY;
+
+	*val = tt_zone->tz_temp;
+
+	return 0;
+}
+static int tt_zone_tz_temp_set(void *data, u64 val)
+{
+	struct tt_thermal_zone *tt_zone = data;
+
+	guard(tt_zone)(tt_zone);
+
+	if (!tt_zone->tz)
+		return -EBUSY;
+
+	WRITE_ONCE(tt_zone->tz_temp, val);
+	thermal_zone_device_update(tt_zone->tz, THERMAL_EVENT_TEMP_SAMPLE);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(tt_zone_tz_temp_attr, tt_zone_tz_temp_get,
+				tt_zone_tz_temp_set, "%lld\n");
+
+static void tt_zone_free_trips(struct tt_thermal_zone *tt_zone)
+{
+	struct tt_trip *tt_trip, *aux;
+
+	list_for_each_entry_safe(tt_trip, aux, &tt_zone->trips, list_node) {
+		list_del(&tt_trip->list_node);
+		ida_free(&tt_zone->ida, tt_trip->id);
+		kfree(tt_trip);
+	}
+}
+
+static void tt_zone_free(struct tt_thermal_zone *tt_zone)
+{
+	tt_zone_free_trips(tt_zone);
+	ida_free(&tt_thermal_zones_ida, tt_zone->id);
+	ida_destroy(&tt_zone->ida);
+	kfree(tt_zone);
+}
+
+static void tt_add_tz_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_thermal_zone *tt_zone = tt_work->tt_zone;
+	char f_name[TT_MAX_FILE_NAME_LENGTH];
+
+	kfree(tt_work);
+
+	snprintf(f_name, TT_MAX_FILE_NAME_LENGTH, "tz%d", tt_zone->id);
+	tt_zone->d_tt_zone = debugfs_create_dir(f_name, d_testing);
+	if (!tt_zone->d_tt_zone) {
+		tt_zone_free(tt_zone);
+		return;
+	}
+
+	debugfs_create_file_unsafe("temp", 0600, tt_zone->d_tt_zone, tt_zone,
+				   &tt_zone_tz_temp_attr);
+
+	debugfs_create_file_unsafe("init_temp", 0600, tt_zone->d_tt_zone,
+				   &tt_zone->temp, &tt_int_attr);
+
+	guard(mutex)(&tt_thermal_zones_lock);
+
+	list_add_tail(&tt_zone->list_node, &tt_thermal_zones);
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
+	tt_work->tt_zone = no_free_ptr(tt_zone);
+	schedule_work(&(no_free_ptr(tt_work)->work));
+
+	return 0;
+}
+
+static void tt_del_tz_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_thermal_zone *tt_zone = tt_work->tt_zone;
+
+	kfree(tt_work);
+
+	debugfs_remove(tt_zone->d_tt_zone);
+	tt_zone_free(tt_zone);
+}
+
+static void tt_zone_unregister_tz(struct tt_thermal_zone *tt_zone)
+{
+	guard(tt_zone)(tt_zone);
+
+	if (tt_zone->tz) {
+		thermal_zone_device_unregister(tt_zone->tz);
+		tt_zone->tz = NULL;
+	}
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
+	guard(mutex)(&tt_thermal_zones_lock);
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
+	if (ret)
+		return ret;
+
+	tt_zone_unregister_tz(tt_zone);
+
+	INIT_WORK(&tt_work->work, tt_del_tz_work_fn);
+	tt_work->tt_zone = tt_zone;
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
+	guard(mutex)(&tt_thermal_zones_lock);
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
+	if (ret)
+		return ERR_PTR(ret);
+
+	return tt_zone;
+}
+
+static void tt_put_tt_zone(struct tt_thermal_zone *tt_zone)
+{
+	guard(mutex)(&tt_thermal_zones_lock);
+
+	tt_zone->refcount--;
+}
+
+static void tt_zone_add_trip_work_fn(struct work_struct *work)
+{
+	struct tt_work *tt_work = tt_work_of_work(work);
+	struct tt_thermal_zone *tt_zone = tt_work->tt_zone;
+	struct tt_trip *tt_trip = tt_work->tt_trip;
+	char d_name[TT_MAX_FILE_NAME_LENGTH];
+
+	kfree(tt_work);
+
+	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_temp", tt_trip->id);
+	debugfs_create_file_unsafe(d_name, 0600, tt_zone->d_tt_zone,
+				   &tt_trip->trip.temperature, &tt_int_attr);
+
+	snprintf(d_name, TT_MAX_FILE_NAME_LENGTH, "trip_%d_hyst", tt_trip->id);
+	debugfs_create_file_unsafe(d_name, 0600, tt_zone->d_tt_zone,
+				   &tt_trip->trip.hysteresis, &tt_unsigned_int_attr);
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
+	tt_trip->trip.type = THERMAL_TRIP_ACTIVE;
+	tt_trip->trip.temperature = THERMAL_TEMP_INVALID;
+	tt_trip->trip.flags = THERMAL_TRIP_FLAG_RW;
+	tt_trip->id = id;
+
+	guard(tt_zone)(tt_zone);
+
+	list_add_tail(&tt_trip->list_node, &tt_zone->trips);
+	tt_zone->num_trips++;
+
+	INIT_WORK(&tt_work->work, tt_zone_add_trip_work_fn);
+	tt_work->tt_zone = tt_zone;
+	tt_work->tt_trip = no_free_ptr(tt_trip);
+	schedule_work(&(no_free_ptr(tt_work)->work));
+
+	return 0;
+}
+
+static int tt_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct tt_thermal_zone *tt_zone = thermal_zone_device_priv(tz);
+
+	*temp = READ_ONCE(tt_zone->tz_temp);
+
+	if (*temp < THERMAL_TEMP_INVALID)
+		return -ENODATA;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops tt_zone_ops = {
+	.get_temp = tt_zone_get_temp,
+};
+
+static int tt_zone_register_tz(struct tt_thermal_zone *tt_zone)
+{
+	struct thermal_trip *trips __free(kfree);
+	struct thermal_zone_device *tz;
+	struct tt_trip *tt_trip;
+	int i;
+
+	guard(tt_zone)(tt_zone);
+
+	if (tt_zone->tz)
+		return -EINVAL;
+
+	trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
+	if (!trips)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry(tt_trip, &tt_zone->trips, list_node)
+		trips[i++] = tt_trip->trip;
+
+	tt_zone->tz_temp = tt_zone->temp;
+
+	tz = thermal_zone_device_register_with_trips("test_tz", trips, i, tt_zone,
+						     &tt_zone_ops, NULL, 0, 0);
+	if (IS_ERR(tz))
+		return PTR_ERR(tz);
+
+	tt_zone->tz = tz;
+
+	thermal_zone_device_enable(tz);
+
+	return 0;
+}
+
+int tt_zone_reg(const char *arg)
+{
+	struct tt_thermal_zone *tt_zone;
+	int ret;
+
+	tt_zone = tt_get_tt_zone(arg);
+	if (IS_ERR(tt_zone))
+		return PTR_ERR(tt_zone);
+
+	ret = tt_zone_register_tz(tt_zone);
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
+	struct tt_thermal_zone *tt_zone, *aux;
+
+	list_for_each_entry_safe(tt_zone, aux, &tt_thermal_zones, list_node) {
+		tt_zone_unregister_tz(tt_zone);
+
+		list_del(&tt_zone->list_node);
+
+		tt_zone_free(tt_zone);
+	}
+}




