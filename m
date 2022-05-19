Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6852D2C8
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiESMoU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiESMoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C51BA994
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:17 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FhTAgrgnK4U47+AcdZxtw0Kd4OY59r1Xi7X6uad4ds=;
        b=nLhLt3t4YFpELwPsqF0ebwt4PQ5rluwZwB68fQQgq3qFIPoppVP3DqjVJkl9zp4U52cMFP
        YlRYHrsEX6JMWqzsCdj729Q0/cp4WIvxuedXMjkRgvdb7GmTgSCp24y5dqFOPhyqaKA5AT
        gaZWXfOCtb8HjwF3mnqkHeVYIBhaahpM+gwB4gU3gwXQQE5PBHRkdpieZI9ixvUAruRUAv
        zqpc98EfEIh8HOfsXitQ4ucsgpOZtmTKgQ89b2EyhcZrL6PlB/PTgBqI8Lw7fB/VkCQR3R
        BMgUGuny0Dg5W2sezdwv9G82uytnaSwIKgzB0pCJBq6swjfVoSnxFNsOFdKEZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FhTAgrgnK4U47+AcdZxtw0Kd4OY59r1Xi7X6uad4ds=;
        b=/N93yHSxb4dsHB/y9axyeGzlV6qsMc++n/atXtzvm04MQcX45Fw5otMqK9jAD2Belbd81T
        SthRT/L14W5bdtDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] tools/thermal: Add thermal daemon skeleton
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220420160933.347088-5-daniel.lezcano@linaro.org>
References: <20220420160933.347088-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165296425459.4207.10578644542942390188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     077df623c8344e4b50a7ba6c433f9d6857a94d6b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//077df623c8344e4b50a7ba6c433f9d6857a94d6b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 20 Apr 2022 18:09:32 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

tools/thermal: Add thermal daemon skeleton

This change provides a simple daemon skeleton. It is an example of how
to use the thermal library which wraps all the complex code related to
the netlink and transforms it into a callback oriented code.

The goal of this skeleton is to give a base brick for anyone
interested in writing its own thermal engine or as an example to rely
on to write its own thermal monitoring implementation.

In the future, it will evolve with more features and hopefully more
logic.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20220420160933.347088-5-daniel.lezcano@linaro=
.org
---
 tools/Makefile                                |  16 +-
 tools/thermal/thermal-engine/Build            |   1 +-
 tools/thermal/thermal-engine/Makefile         |  28 +-
 tools/thermal/thermal-engine/thermal-engine.c | 341 +++++++++++++++++-
 4 files changed, 383 insertions(+), 3 deletions(-)
 create mode 100644 tools/thermal/thermal-engine/Build
 create mode 100644 tools/thermal/thermal-engine/Makefile
 create mode 100644 tools/thermal/thermal-engine/thermal-engine.c

diff --git a/tools/Makefile b/tools/Makefile
index 78615f8..b71cf39 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -32,6 +32,7 @@ help:
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  thermometer            - temperature capture tool'
+	@echo '  thermal-engine         - thermal monitoring tool'
 	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting t=
ool'
@@ -99,6 +100,9 @@ tmon: FORCE
 thermometer: FORCE
 	$(call descend,thermal/$@)
=20
+thermal-engine: FORCE thermal
+	$(call descend,thermal/$@)
+
 freefall: FORCE
 	$(call descend,laptop/$@)
=20
@@ -109,7 +113,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer
+		pci debugging tracing thermal thermometer thermal-engine
=20
 acpi_install:
 	$(call descend,power/$(@:_install=3D),install)
@@ -135,6 +139,9 @@ tmon_install:
 thermometer_install:
 	$(call descend,thermal/$(@:_install=3D),install)
=20
+thermal-engine_install:
+	$(call descend,thermal/$(@:_install=3D),install)
+
 freefall_install:
 	$(call descend,laptop/$(@:_install=3D),install)
=20
@@ -147,7 +154,7 @@ install: acpi_install cgroup_install counter_install cpup=
ower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install
+		tracing_install thermometer_install thermal-engine_install
=20
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -183,6 +190,9 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-=
select_clean:
 thermometer_clean:
 	$(call descend,thermal/thermometer,clean)
=20
+thermal-engine_clean:
+	$(call descend,thermal/thermal-engine,clean)
+
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
=20
@@ -197,6 +207,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_cle=
an hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean deb=
ugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean the=
rmal-engine_clean
=20
 .PHONY: FORCE
diff --git a/tools/thermal/thermal-engine/Build b/tools/thermal/thermal-engin=
e/Build
new file mode 100644
index 0000000..20c3c47
--- /dev/null
+++ b/tools/thermal/thermal-engine/Build
@@ -0,0 +1 @@
+thermal-engine-y +=3D thermal-engine.o
diff --git a/tools/thermal/thermal-engine/Makefile b/tools/thermal/thermal-en=
gine/Makefile
new file mode 100644
index 0000000..6bd05ff
--- /dev/null
+++ b/tools/thermal/thermal-engine/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for thermal tools
+
+ifeq ($(srctree),)
+srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
+srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
+srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
+# $(info Determined 'srctree' to be $(srctree))
+endif
+
+CFLAGS =3D -Wall -Wextra
+CFLAGS +=3D -I$(srctree)/tools/thermal/lib
+CFLAGS +=3D -I$(srctree)/tools/lib/thermal/include
+
+LDFLAGS =3D -L$(srctree)/tools/thermal/lib
+LDFLAGS +=3D -L$(srctree)/tools/lib/thermal
+LDFLAGS +=3D -lthermal_tools
+LDFLAGS +=3D -lthermal
+LDFLAGS +=3D -lconfig
+LDFLAGS +=3D -lnl-genl-3 -lnl-3
+
+VERSION =3D 0.0.1
+
+all: thermal-engine
+%: %.c
+	$(CC) $(CFLAGS) -D VERSION=3D\"$(VERSION)\" -o $@ $^ $(LDFLAGS)
+clean:
+	$(RM) thermal-engine
diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/th=
ermal-engine/thermal-engine.c
new file mode 100644
index 0000000..9b1476a
--- /dev/null
+++ b/tools/thermal/thermal-engine/thermal-engine.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Thermal monitoring tool based on the thermal netlink events.
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@kernel.org>
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <libgen.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <syslog.h>
+
+#include <sys/epoll.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <thermal.h>
+#include "thermal-tools.h"
+
+struct options {
+	int loglevel;
+	int logopt;
+	int interactive;
+	int daemonize;
+};
+
+struct thermal_data {
+	struct thermal_zone *tz;
+	struct thermal_handler *th;
+};
+
+static int show_trip(struct thermal_trip *tt, __maybe_unused void *arg)
+{
+	INFO("trip id=3D%d, type=3D%d, temp=3D%d, hyst=3D%d\n",
+	     tt->id, tt->type, tt->temp, tt->hyst);
+
+	return 0;
+}
+
+static int show_temp(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	thermal_cmd_get_temp(arg, tz);
+
+	INFO("temperature: %d\n", tz->temp);
+
+	return 0;
+}
+
+static int show_governor(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	thermal_cmd_get_governor(arg, tz);
+
+	INFO("governor: '%s'\n", tz->governor);
+
+	return 0;
+}
+
+static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	INFO("thermal zone '%s', id=3D%d\n", tz->name, tz->id);
+
+	for_each_thermal_trip(tz->trip, show_trip, NULL);
+
+	show_temp(tz, arg);
+
+	show_governor(tz, arg);
+
+	return 0;
+}
+
+static int tz_create(const char *name, int tz_id, __maybe_unused void *arg)
+{
+	INFO("Thermal zone '%s'/%d created\n", name, tz_id);
+
+	return 0;
+}
+
+static int tz_delete(int tz_id, __maybe_unused void *arg)
+{
+	INFO("Thermal zone %d deleted\n", tz_id);
+
+	return 0;
+}
+
+static int tz_disable(int tz_id, void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s') disabled\n", tz_id, tz->name);
+
+	return 0;
+}
+
+static int tz_enable(int tz_id, void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s') enabled\n", tz_id, tz->name);
+
+	return 0;
+}
+
+static int trip_high(int tz_id, int trip_id, int temp, void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s'): trip point %d crossed way up with %d =C2=B0C\=
n",
+	     tz_id, tz->name, trip_id, temp);
+
+	return 0;
+}
+
+static int trip_low(int tz_id, int trip_id, int temp, void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s'): trip point %d crossed way down with %d =C2=B0=
C\n",
+	     tz_id, tz->name, trip_id, temp);
+
+	return 0;
+}
+
+static int trip_add(int tz_id, int trip_id, int type, int temp, int hyst, __=
maybe_unused void *arg)
+{
+	INFO("Trip point added %d: id=3D%d, type=3D%d, temp=3D%d, hyst=3D%d\n",
+	     tz_id, trip_id, type, temp, hyst);
+
+	return 0;
+}
+
+static int trip_delete(int tz_id, int trip_id, __maybe_unused void *arg)
+{
+	INFO("Trip point deleted %d: id=3D%d\n", tz_id, trip_id);
+
+	return 0;
+}
+
+static int trip_change(int tz_id, int trip_id, int type, int temp,
+		       int hyst, __maybe_unused void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Trip point changed %d: id=3D%d, type=3D%d, temp=3D%d, hyst=3D%d\n",
+	     tz_id, trip_id, type, temp, hyst);
+
+	tz->trip[trip_id].type =3D type;
+	tz->trip[trip_id].temp =3D temp;
+	tz->trip[trip_id].hyst =3D hyst;
+
+	return 0;
+}
+
+static int cdev_add(const char *name, int cdev_id, int max_state, __maybe_un=
used void *arg)
+{
+	INFO("Cooling device '%s'/%d (max state=3D%d) added\n", name, cdev_id, max_=
state);
+
+	return 0;
+}
+
+static int cdev_delete(int cdev_id, __maybe_unused void *arg)
+{
+	INFO("Cooling device %d deleted", cdev_id);
+
+	return 0;
+}
+
+static int cdev_update(int cdev_id, int cur_state, __maybe_unused void *arg)
+{
+	INFO("cdev:%d state:%d\n", cdev_id, cur_state);
+
+	return 0;
+}
+
+static int gov_change(int tz_id, const char *name, __maybe_unused void *arg)
+{
+	struct thermal_data *td =3D arg;
+	struct thermal_zone *tz =3D thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("%s: governor changed %s -> %s\n", tz->name, tz->governor, name);
+
+	strcpy(tz->governor, name);
+
+	return 0;
+}
+
+static struct thermal_ops ops =3D {
+	.events.tz_create	=3D tz_create,
+	.events.tz_delete	=3D tz_delete,
+	.events.tz_disable	=3D tz_disable,
+	.events.tz_enable	=3D tz_enable,
+	.events.trip_high	=3D trip_high,
+	.events.trip_low	=3D trip_low,
+	.events.trip_add	=3D trip_add,
+	.events.trip_delete	=3D trip_delete,
+	.events.trip_change	=3D trip_change,
+	.events.cdev_add	=3D cdev_add,
+	.events.cdev_delete	=3D cdev_delete,
+	.events.cdev_update	=3D cdev_update,
+	.events.gov_change	=3D gov_change
+};
+
+static int thermal_event(__maybe_unused int fd, __maybe_unused void *arg)
+{
+	struct thermal_data *td =3D arg;
+
+	return thermal_events_handle(td->th, td);
+}
+
+static void usage(const char *cmd)
+{
+	printf("%s : A thermal monitoring engine based on notifications\n", cmd);
+	printf("Usage: %s [options]\n", cmd);
+	printf("\t-h, --help\t\tthis help\n");
+	printf("\t-d, --daemonize\n");
+	printf("\t-l <level>, --loglevel <level>\tlog level: ");
+	printf("DEBUG, INFO, NOTICE, WARN, ERROR\n");
+	printf("\t-s, --syslog\t\toutput to syslog\n");
+	printf("\n");
+	exit(0);
+}
+
+static int options_init(int argc, char *argv[], struct options *options)
+{
+	int opt;
+
+	struct option long_options[] =3D {
+		{ "help",	no_argument, NULL, 'h' },
+		{ "daemonize",	no_argument, NULL, 'd' },
+		{ "syslog",	no_argument, NULL, 's' },
+		{ "loglevel",	required_argument, NULL, 'l' },
+		{ 0, 0, 0, 0 }
+	};
+
+	while (1) {
+
+		int optindex =3D 0;
+
+		opt =3D getopt_long(argc, argv, "l:dhs", long_options, &optindex);
+		if (opt =3D=3D -1)
+			break;
+
+		switch (opt) {
+		case 'l':
+			options->loglevel =3D log_str2level(optarg);
+			break;
+		case 'd':
+			options->daemonize =3D 1;
+			break;
+		case 's':
+			options->logopt =3D TO_SYSLOG;
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			break;
+		default: /* '?' */
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+enum {
+	THERMAL_ENGINE_SUCCESS =3D 0,
+	THERMAL_ENGINE_OPTION_ERROR,
+	THERMAL_ENGINE_DAEMON_ERROR,
+	THERMAL_ENGINE_LOG_ERROR,
+	THERMAL_ENGINE_THERMAL_ERROR,
+	THERMAL_ENGINE_MAINLOOP_ERROR,
+};
+
+int main(int argc, char *argv[])
+{
+	struct thermal_data td;
+	struct options options =3D {
+		.loglevel =3D LOG_INFO,
+		.logopt =3D TO_STDOUT,
+	};
+
+	if (options_init(argc, argv, &options)) {
+		ERROR("Usage: %s --help\n", argv[0]);
+		return THERMAL_ENGINE_OPTION_ERROR;
+	}
+
+	if (options.daemonize && daemon(0, 0)) {
+		ERROR("Failed to daemonize: %p\n");
+		return THERMAL_ENGINE_DAEMON_ERROR;
+	}
+
+	if (log_init(options.loglevel, basename(argv[0]), options.logopt)) {
+		ERROR("Failed to initialize logging facility\n");
+		return THERMAL_ENGINE_LOG_ERROR;
+	}
+
+	td.th =3D thermal_init(&ops);
+	if (!td.th) {
+		ERROR("Failed to initialize the thermal library\n");
+		return THERMAL_ENGINE_THERMAL_ERROR;
+	}
+
+	td.tz =3D thermal_zone_discover(td.th);
+	if (!td.tz) {
+		ERROR("No thermal zone available\n");
+		return THERMAL_ENGINE_THERMAL_ERROR;
+	}
+
+	for_each_thermal_zone(td.tz, show_tz, td.th);
+
+	if (mainloop_init()) {
+		ERROR("Failed to initialize the mainloop\n");
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+	}
+
+	if (mainloop_add(thermal_events_fd(td.th), thermal_event, &td)) {
+		ERROR("Failed to setup the mainloop\n");
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+	}
+
+	INFO("Waiting for thermal events ...\n");
+
+	if (mainloop(-1)) {
+		ERROR("Mainloop failed\n");
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+	}
+
+	return THERMAL_ENGINE_SUCCESS;
+}
