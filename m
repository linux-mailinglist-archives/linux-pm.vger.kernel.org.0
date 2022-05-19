Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A053752D2CA
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiESMoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiESMoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02969BA57A
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:18 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmkmUefM5DMyLOzszMyRFLuBCIyEDbmqDWFqeKWxq/0=;
        b=wIsllnc/dIKe5rj2BKzeP6x1iKXGzShlw2Pzi4cHRQNLEAZKLc4gJQ+aAMV9O81W1n3aRg
        3jOwGDoGPkG/eJskFpaaGcfpYyRA3t/rYWrSke6+zLAG70mauMYODhUJGTAigiDaQkedUw
        0KyL5hMYTuy1e/fhb7WH75YUzErQktGEexcoFpTAA17DOP0+ut1aQWYZke0Ebaqs2i2nF/
        I9/Y85eufwlx1khAcy6BM5fSqpx6aHmNaUmv5YiDQR1ctB6KQPsTs4Ms6YgOPjKjqt/jla
        t5/pYSB3gQgys/W0ehvgiaD0XLJ4xEMFud+56aIQ3U6N48q3oAQCAIE5sblg/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmkmUefM5DMyLOzszMyRFLuBCIyEDbmqDWFqeKWxq/0=;
        b=iFQfshrWmspO3wZGe9l8QB120eBJV46Ac5FfY3rgoC5LBAmTlgqGrVJARXj8ufztrAVb//
        dcdmpRF1YQxdmCCg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] tools/thermal: Add a temperature capture tool
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220420160933.347088-4-daniel.lezcano@linaro.org>
References: <20220420160933.347088-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165296425547.4207.129428809840616401.tip-bot2@tip-bot2>
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

Commit-ID:     110acbc6a4518145db3a1a9c0686d730bb258bf1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//110acbc6a4518145db3a1a9c0686d730bb258bf1
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 20 Apr 2022 18:09:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:52 +02:00

tools/thermal: Add a temperature capture tool

The 'thermometer' tool allows to capture the temperature of a set of
thermal zones defined in a configuration file at a specified rate.

It is designed to have the lowest possible overhead. It will write the
captured temperature per thermal zone per file so making easier to
write a gnuplot script.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20220420160933.347088-4-daniel.lezcano@linaro=
.org
---
 tools/Makefile                             |  16 +-
 tools/thermal/thermometer/Build            |   1 +-
 tools/thermal/thermometer/Makefile         |  26 +-
 tools/thermal/thermometer/thermometer.8    |  92 +++-
 tools/thermal/thermometer/thermometer.c    | 572 ++++++++++++++++++++-
 tools/thermal/thermometer/thermometer.conf |   5 +-
 6 files changed, 709 insertions(+), 3 deletions(-)
 create mode 100644 tools/thermal/thermometer/Build
 create mode 100644 tools/thermal/thermometer/Makefile
 create mode 100644 tools/thermal/thermometer/thermometer.8
 create mode 100644 tools/thermal/thermometer/thermometer.c
 create mode 100644 tools/thermal/thermometer/thermometer.conf

diff --git a/tools/Makefile b/tools/Makefile
index c253cbd..78615f8 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -31,6 +31,7 @@ help:
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
+	@echo '  thermometer            - temperature capture tool'
 	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting t=
ool'
@@ -95,6 +96,9 @@ turbostat x86_energy_perf_policy intel-speed-select: FORCE
 tmon: FORCE
 	$(call descend,thermal/$@)
=20
+thermometer: FORCE
+	$(call descend,thermal/$@)
+
 freefall: FORCE
 	$(call descend,laptop/$@)
=20
@@ -105,7 +109,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal
+		pci debugging tracing thermal thermometer
=20
 acpi_install:
 	$(call descend,power/$(@:_install=3D),install)
@@ -128,6 +132,9 @@ turbostat_install x86_energy_perf_policy_install intel-sp=
eed-select_install:
 tmon_install:
 	$(call descend,thermal/$(@:_install=3D),install)
=20
+thermometer_install:
+	$(call descend,thermal/$(@:_install=3D),install)
+
 freefall_install:
 	$(call descend,laptop/$(@:_install=3D),install)
=20
@@ -140,7 +147,7 @@ install: acpi_install cgroup_install counter_install cpup=
ower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install
+		tracing_install thermometer_install
=20
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -173,6 +180,9 @@ thermal_clean:
 turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 	$(call descend,power/x86/$(@:_clean=3D),clean)
=20
+thermometer_clean:
+	$(call descend,thermal/thermometer,clean)
+
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
=20
@@ -187,6 +197,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_cle=
an hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean deb=
ugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean
=20
 .PHONY: FORCE
diff --git a/tools/thermal/thermometer/Build b/tools/thermal/thermometer/Build
new file mode 100644
index 0000000..1b96c15
--- /dev/null
+++ b/tools/thermal/thermometer/Build
@@ -0,0 +1 @@
+thermometer-y +=3D thermometer.o
diff --git a/tools/thermal/thermometer/Makefile b/tools/thermal/thermometer/M=
akefile
new file mode 100644
index 0000000..d8f8bc8
--- /dev/null
+++ b/tools/thermal/thermometer/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for cgroup tools
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
+
+LDFLAGS =3D -L$(srctree)/tools/thermal/lib
+LDFLAGS +=3D -lthermal_tools
+LDFLAGS +=3D -lconfig
+
+VERSION =3D 0.0.1
+TARGET=3Dthermometer
+
+all: $(TARGET)
+%: %.c
+	$(CC) $(CFLAGS) -D VERSION=3D\"$(VERSION)\" -o $@ $^ $(LDFLAGS)
+
+clean:
+	$(RM) $(TARGET)
diff --git a/tools/thermal/thermometer/thermometer.8 b/tools/thermal/thermome=
ter/thermometer.8
new file mode 100644
index 0000000..d090fbc
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.8
@@ -0,0 +1,92 @@
+.TH THERMOMETER 8
+# SPDX-License-Identifier: GPL-2.0
+.SH NAME
+\fBthermometer\fP - A thermal profiling tool
+
+.SH SYNOPSIS
+.ft B
+.B thermometer
+.RB [ options ]
+.RB [ command ]
+.br
+.SH DESCRIPTION
+\fBthermometer \fP captures the thermal zones temperature at a
+specified sampling period. It is optimized to reduce as much as
+possible the overhead while doing the temperature acquisition in order
+to prevent disrupting the running application we may want to profile.
+
+This low overhead also allows a high rate sampling for the temperature
+which could be necessary to spot overshots and undershots.
+
+If no configuration file is specified, then all the thermal zones will
+be monitored at 4Hz, so every 250ms. A configuration file specifies
+the thermal zone names and the desired sampling period. A thermal zone
+name can be a regular expression to specify a group of thermal zone.
+
+The sampling of the different thermal zones will be written into
+separate files with the thermal zone name. It is possible to specify a
+postfix to identify them for example for a specific scenario. The
+output directory can be specified in addition.
+
+Without any parameters, \fBthermometer \fP captures all the thermal
+zone temperatures every 250ms and write to the current directory the
+captured files postfixed with the current date.
+
+If a running \fBduration\fP is specified or a \fBcommand\fP, the
+capture ends at the end of the duration if the command did not
+finished before. The \fBduration\fP can be specified alone as well as
+the \fBcommand\fP. If none is specified, the capture will continue
+indefinitively until interrupted by \fBSIGINT\fP or \fBSIGQUIT\fP.
+.PP
+
+.SS Options
+.PP
+The \fB-h, --help\fP option shows a short usage help
+.PP
+The \fB-o <dir>, --output <dir>\fP option defines the output directory to pu=
t the
+sampling files
+.PP
+The \fB-c <config>, --config <config>\fP option specifies the configuration =
file to use
+.PP
+The \fB-d <seconds>, --duration <seconds>\fP option specifies the duration o=
f the capture
+.PP
+The \fB-l <loglevel>, --loglevel <loglevel>\fP option sets the loglevel [DEB=
UG,INFO,NOTICE,WARN,ERROR]
+.PP
+The \fB-p <string>, --postfix <string>\fP option appends \fBstring\fP at the=
 end of the capture filenames
+.PP
+The \fB-s, --syslog\fP option sets the output to syslog, default is \fBstdou=
t\fP
+.PP
+The \fB-w, --overwrite\fP overwrites the output files if they exist
+.PP
+
+.PP
+
+.SS "Exit status:"
+.TP
+0
+if OK,
+.TP
+1
+Error with the options specified as parameters
+.TP
+2
+Error when configuring the logging facility
+.TP
+3
+Error when configuring the time
+.TP
+4
+Error in the initialization routine
+.TP
+5
+Error during the runtime
+
+.SH Capture file format
+
+Every file contains two columns. The first one is the uptime timestamp
+in order to find a point in time since the system started up if there
+is any thermal event. The second one is the temperature in milli
+degree. The first line contains the label of each column.
+
+.SH AUTHOR
+Daniel Lezcano <daniel.lezcano@kernel.org>
diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermome=
ter/thermometer.c
new file mode 100644
index 0000000..914986f
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.or=
g>
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <regex.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/signalfd.h>
+#include <sys/timerfd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/thermal.h>
+
+#include <libconfig.h>
+#include "thermal-tools.h"
+
+#define CLASS_THERMAL "/sys/class/thermal"
+
+enum {
+	THERMOMETER_SUCCESS =3D 0,
+	THERMOMETER_OPTION_ERROR,
+	THERMOMETER_LOG_ERROR,
+	THERMOMETER_CONFIG_ERROR,
+	THERMOMETER_TIME_ERROR,
+	THERMOMETER_INIT_ERROR,
+	THERMOMETER_RUNTIME_ERROR
+};
+
+struct options {
+	int loglvl;
+	int logopt;
+	int overwrite;
+	int duration;
+	const char *config;
+	char postfix[PATH_MAX];
+	char output[PATH_MAX];
+};
+
+struct tz_regex {
+	regex_t regex;
+	int polling;
+};
+
+struct configuration {
+	struct tz_regex *tz_regex;
+	int nr_tz_regex;
+
+};
+
+struct tz {
+	FILE *file_out;
+	int fd_temp;
+	int fd_timer;
+	int polling;
+	const char *name;
+};
+
+struct thermometer {
+	struct tz *tz;
+	int nr_tz;
+};
+
+static struct tz_regex *configuration_tz_match(const char *expr,
+					       struct configuration *config)
+{
+	int i;
+
+	for (i =3D 0; i < config->nr_tz_regex; i++) {
+
+		if (!regexec(&config->tz_regex[i].regex, expr, 0, NULL, 0))
+			return &config->tz_regex[i];
+	}
+
+	return NULL;
+}
+
+static int configuration_default_init(struct configuration *config)
+{
+	config->tz_regex =3D realloc(config->tz_regex, sizeof(*config->tz_regex) *
+				   (config->nr_tz_regex + 1));
+
+	if (regcomp(&config->tz_regex[config->nr_tz_regex].regex, ".*",
+		    REG_NOSUB | REG_EXTENDED)) {
+		ERROR("Invalid regular expression\n");
+		return -1;
+	}
+
+	config->tz_regex[config->nr_tz_regex].polling =3D 250;
+	config->nr_tz_regex =3D 1;
+
+	return 0;
+}
+
+static int configuration_init(const char *path, struct configuration *config)
+{
+	config_t cfg;
+
+	config_setting_t *tz;
+	int i, length;
+
+	if (path && access(path, F_OK)) {
+		ERROR("'%s' is not accessible\n", path);
+		return -1;
+	}
+
+	if (!path && !config->nr_tz_regex) {
+		INFO("No thermal zones configured, using wildcard for all of them\n");
+		return configuration_default_init(config);
+	}
+
+	config_init(&cfg);
+
+	if (!config_read_file(&cfg, path)) {
+		ERROR("Failed to parse %s:%d - %s\n", config_error_file(&cfg),
+		      config_error_line(&cfg), config_error_text(&cfg));
+
+		return -1;
+	}
+
+	tz =3D config_lookup(&cfg, "thermal-zones");
+	if (!tz) {
+		ERROR("No thermal zone configured to be monitored\n");
+		return -1;
+	}
+
+	length =3D config_setting_length(tz);
+
+	INFO("Found %d thermal zone(s) regular expression\n", length);
+
+	for (i =3D 0; i < length; i++) {
+
+		config_setting_t *node;
+		const char *name;
+		int polling;
+
+		node =3D config_setting_get_elem(tz, i);
+		if (!node) {
+			ERROR("Missing node name '%d'\n", i);
+			return -1;
+		};
+
+		if (!config_setting_lookup_string(node, "name", &name)) {
+			ERROR("Thermal zone name not found\n");
+			return -1;
+		}
+
+		if (!config_setting_lookup_int(node, "polling", &polling)) {
+			ERROR("Polling value not found");
+			return -1;
+		}
+
+		config->tz_regex =3D realloc(config->tz_regex, sizeof(*config->tz_regex) *
+					(config->nr_tz_regex + 1));
+
+		if (regcomp(&config->tz_regex[config->nr_tz_regex].regex, name,
+			    REG_NOSUB | REG_EXTENDED)) {
+			ERROR("Invalid regular expression '%s'\n", name);
+			continue;
+		}
+
+		config->tz_regex[config->nr_tz_regex].polling =3D polling;
+		config->nr_tz_regex++;
+
+		INFO("Thermal zone regular expression '%s' with polling %d\n",
+		     name, polling);
+	}
+
+	return 0;
+}
+
+static void usage(const char *cmd)
+{
+	printf("%s Version: %s\n", cmd, VERSION);
+	printf("Usage: %s [options]\n", cmd);
+	printf("\t-h, --help\t\tthis help\n");
+	printf("\t-o, --output <dir>\toutput directory for temperature capture\n");
+	printf("\t-c, --config <file>\tconfiguration file\n");
+	printf("\t-d, --duration <seconds>\tcapture duration\n");
+	printf("\t-l, --loglevel <level>\tlog level: ");
+	printf("DEBUG, INFO, NOTICE, WARN, ERROR\n");
+	printf("\t-p, --postfix <string>\tpostfix to be happened at the end of the =
files\n");
+	printf("\t-s, --syslog\t\toutput to syslog\n");
+	printf("\t-w, --overwrite\t\toverwrite the temperature capture files if the=
y exist\n");
+	printf("\n");
+	exit(0);
+}
+
+static int options_init(int argc, char *argv[], struct options *options)
+{
+	int opt;
+	time_t now =3D time(NULL);
+
+	struct option long_options[] =3D {
+		{ "help",	no_argument, NULL, 'h' },
+		{ "config",	required_argument, NULL, 'c' },
+		{ "duration",	required_argument, NULL, 'd' },
+		{ "loglevel",	required_argument, NULL, 'l' },
+		{ "postfix",	required_argument, NULL, 'p' },
+		{ "output",	required_argument, NULL, 'o' },
+		{ "syslog",	required_argument, NULL, 's' },
+		{ "overwrite",	no_argument, NULL, 'w' },
+		{ 0, 0, 0, 0 }
+	};
+
+	strftime(options->postfix, sizeof(options->postfix),
+		 "-%Y-%m-%d_%H:%M:%S", gmtime(&now));
+
+	while (1) {
+
+		int optindex =3D 0;
+
+		opt =3D getopt_long(argc, argv, "ho:c:d:l:p:sw", long_options, &optindex);
+		if (opt =3D=3D -1)
+			break;
+
+		switch (opt) {
+		case 'c':
+			options->config =3D optarg;
+			break;
+		case 'd':
+			options->duration =3D atoi(optarg) * 1000;
+			break;
+		case 'l':
+			options->loglvl =3D log_str2level(optarg);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			break;
+		case 'p':
+			strcpy(options->postfix, optarg);
+			break;
+		case 'o':
+			strcpy(options->output, optarg);
+			break;
+		case 's':
+			options->logopt =3D TO_SYSLOG;
+			break;
+		case 'w':
+			options->overwrite =3D 1;
+			break;
+		default: /* '?' */
+			ERROR("Usage: %s --help\n", argv[0]);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int thermometer_add_tz(const char *path, const char *name, int pollin=
g,
+			      struct thermometer *thermometer)
+{
+	int fd;
+	char tz_path[PATH_MAX];
+
+	sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
+
+	fd =3D open(tz_path, O_RDONLY);
+	if (fd < 0) {
+		ERROR("Failed to open '%s': %m\n", tz_path);
+		return -1;
+	}
+
+	thermometer->tz =3D realloc(thermometer->tz,
+				  sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
+	if (!thermometer->tz) {
+		ERROR("Failed to allocate thermometer->tz\n");
+		return -1;
+	}
+
+	thermometer->tz[thermometer->nr_tz].fd_temp =3D fd;
+	thermometer->tz[thermometer->nr_tz].name =3D strdup(name);
+	thermometer->tz[thermometer->nr_tz].polling =3D polling;
+	thermometer->nr_tz++;
+
+	INFO("Added thermal zone '%s->%s (polling:%d)'\n", path, name, polling);
+
+	return 0;
+}
+
+static int thermometer_init(struct configuration *config,
+			    struct thermometer *thermometer)
+{
+	DIR *dir;
+	struct dirent *dirent;
+	struct tz_regex *tz_regex;
+	const char *tz_dirname =3D "thermal_zone";
+
+	if (mainloop_init()) {
+		ERROR("Failed to start mainloop\n");
+		return -1;
+	}
+
+	dir =3D opendir(CLASS_THERMAL);
+	if (!dir) {
+		ERROR("failed to open '%s'\n", CLASS_THERMAL);
+		return -1;
+	}
+
+	while ((dirent =3D readdir(dir))) {
+		char tz_type[THERMAL_NAME_LENGTH];
+		char tz_path[PATH_MAX];
+		FILE *tz_file;
+
+		if (strncmp(dirent->d_name, tz_dirname, strlen(tz_dirname)))
+			continue;
+
+		sprintf(tz_path, CLASS_THERMAL"/%s/type", dirent->d_name);
+
+		tz_file =3D fopen(tz_path, "r");
+		if (!tz_file) {
+			ERROR("Failed to open '%s': %m", tz_path);
+			continue;
+		}
+
+		fscanf(tz_file, "%s", tz_type);
+
+		fclose(tz_file);
+
+		tz_regex =3D configuration_tz_match(tz_type, config);
+		if (!tz_regex)
+			continue;
+
+		if (thermometer_add_tz(dirent->d_name, tz_type,
+				       tz_regex->polling, thermometer))
+			continue;
+	}
+
+	closedir(dir);
+
+	return 0;
+}
+
+static int timer_temperature_callback(int fd, void *arg)
+{
+	struct tz *tz =3D arg;
+	char buf[16] =3D { 0 };
+
+	pread(tz->fd_temp, buf, sizeof(buf), 0);
+
+	fprintf(tz->file_out, "%ld %s", getuptimeofday_ms(), buf);
+
+	read(fd, buf, sizeof(buf));
+
+	return 0;
+}
+
+static int thermometer_start(struct thermometer *thermometer,
+			     struct options *options)
+{
+	struct itimerspec timer_it =3D { 0 };
+	char *path;
+	FILE *f;
+	int i;
+
+	INFO("Capturing %d thermal zone(s) temperature...\n", thermometer->nr_tz);
+
+	if (access(options->output, F_OK) && mkdir(options->output, 0700)) {
+		ERROR("Failed to create directory '%s'\n", options->output);
+		return -1;
+	}
+
+	for (i =3D 0; i < thermometer->nr_tz; i++) {
+
+		asprintf(&path, "%s/%s%s", options->output,
+			 thermometer->tz[i].name, options->postfix);
+
+		if (!options->overwrite && !access(path, F_OK)) {
+			ERROR("'%s' already exists\n", path);
+			return -1;
+		}
+
+		f =3D fopen(path, "w");
+		if (!f) {
+			ERROR("Failed to create '%s':%m\n", path);
+			return -1;
+		}
+
+		fprintf(f, "timestamp(ms) %s(=C2=B0mC)\n", thermometer->tz[i].name);
+
+		thermometer->tz[i].file_out =3D f;
+
+		DEBUG("Created '%s' file for thermal zone '%s'\n", path, thermometer->tz[i=
].name);
+
+		/*
+		 * Create polling timer
+		 */
+		thermometer->tz[i].fd_timer =3D timerfd_create(CLOCK_MONOTONIC, 0);
+		if (thermometer->tz[i].fd_timer < 0) {
+			ERROR("Failed to create timer for '%s': %m\n",
+			      thermometer->tz[i].name);
+			return -1;
+		}
+
+		DEBUG("Watching '%s' every %d ms\n",
+		      thermometer->tz[i].name, thermometer->tz[i].polling);
+
+		timer_it.it_interval =3D timer_it.it_value =3D
+			msec_to_timespec(thermometer->tz[i].polling);
+
+		if (timerfd_settime(thermometer->tz[i].fd_timer, 0,
+				    &timer_it, NULL) < 0)
+			return -1;
+
+		if (mainloop_add(thermometer->tz[i].fd_timer,
+				 timer_temperature_callback,
+				 &thermometer->tz[i]))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int thermometer_execute(int argc, char *argv[], char *const envp[], p=
id_t *pid)
+{
+	if (!argc)
+		return 0;
+
+	*pid =3D fork();
+	if (*pid < 0) {
+		ERROR("Failed to fork process: %m");
+		return -1;
+	}
+
+	if (!(*pid)) {
+		execvpe(argv[0], argv, envp);
+		exit(1);
+	}
+
+	return 0;
+}
+
+static int kill_process(__maybe_unused int fd, void *arg)
+{
+	pid_t pid =3D *(pid_t *)arg;
+
+	if (kill(pid, SIGTERM))
+		ERROR("Failed to send SIGTERM signal to '%d': %p\n", pid);
+	else if (waitpid(pid, NULL, 0))
+		ERROR("Failed to wait pid '%d': %p\n", pid);
+
+	mainloop_exit();
+
+	return 0;
+}
+
+static int exit_mainloop(__maybe_unused int fd, __maybe_unused void *arg)
+{
+	mainloop_exit();
+	return 0;
+}
+
+static int thermometer_wait(struct options *options, pid_t pid)
+{
+	int fd;
+	sigset_t mask;
+
+	/*
+	 * If there is a duration specified, we will exit the mainloop
+	 * and gracefully close all the files which will flush the
+	 * file system cache
+	 */
+	if (options->duration) {
+		struct itimerspec timer_it =3D { 0 };
+
+		timer_it.it_value =3D msec_to_timespec(options->duration);
+
+		fd =3D timerfd_create(CLOCK_MONOTONIC, 0);
+		if (fd < 0) {
+			ERROR("Failed to create duration timer: %m\n");
+			return -1;
+		}
+
+		if (timerfd_settime(fd, 0, &timer_it, NULL)) {
+			ERROR("Failed to set timer time: %m\n");
+			return -1;
+		}
+
+		if (mainloop_add(fd, pid < 0 ? exit_mainloop : kill_process, &pid)) {
+			ERROR("Failed to set timer exit mainloop callback\n");
+			return -1;
+		}
+	}
+
+	/*
+	 * We want to catch any keyboard interrupt, as well as child
+	 * signals if any in order to exit properly
+	 */
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGQUIT);
+	sigaddset(&mask, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL)) {
+		ERROR("Failed to set sigprocmask: %m\n");
+		return -1;
+	}
+
+	fd =3D signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		ERROR("Failed to set the signalfd: %m\n");
+		return -1;
+	}
+
+	if (mainloop_add(fd, exit_mainloop, NULL)) {
+		ERROR("Failed to set timer exit mainloop callback\n");
+		return -1;
+	}
+
+	return mainloop(-1);
+}
+
+static int thermometer_stop(struct thermometer *thermometer)
+{
+	int i;
+
+	INFO("Closing/flushing output files\n");
+
+	for (i =3D 0; i < thermometer->nr_tz; i++)
+		fclose(thermometer->tz[i].file_out);
+
+	return 0;
+}
+
+int main(int argc, char *argv[], char *const envp[])
+{
+	struct options options =3D {
+		.loglvl =3D LOG_DEBUG,
+		.logopt =3D TO_STDOUT,
+		.output =3D ".",
+	};
+	struct configuration config =3D { 0 };
+	struct thermometer thermometer =3D { 0 };
+
+	pid_t pid =3D -1;
+
+	if (options_init(argc, argv, &options))
+		return THERMOMETER_OPTION_ERROR;
+
+	if (log_init(options.loglvl, argv[0], options.logopt))
+		return THERMOMETER_LOG_ERROR;
+
+	if (configuration_init(options.config, &config))
+		return THERMOMETER_CONFIG_ERROR;
+
+	if (uptimeofday_init())
+		return THERMOMETER_TIME_ERROR;
+
+	if (thermometer_init(&config, &thermometer))
+		return THERMOMETER_INIT_ERROR;
+
+	if (thermometer_start(&thermometer, &options))
+		return THERMOMETER_RUNTIME_ERROR;
+
+	if (thermometer_execute(argc - optind, &argv[optind], envp, &pid))
+		return THERMOMETER_RUNTIME_ERROR;
+
+	if (thermometer_wait(&options, pid))
+		return THERMOMETER_RUNTIME_ERROR;
+
+	if (thermometer_stop(&thermometer))
+		return THERMOMETER_RUNTIME_ERROR;
+
+	return THERMOMETER_SUCCESS;
+}
diff --git a/tools/thermal/thermometer/thermometer.conf b/tools/thermal/therm=
ometer/thermometer.conf
new file mode 100644
index 0000000..02c6dab
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.conf
@@ -0,0 +1,5 @@
+
+thermal-zones =3D (
+	      {	name =3D "cpu[0-9]-thermal";
+		polling =3D 100; }
+      )
