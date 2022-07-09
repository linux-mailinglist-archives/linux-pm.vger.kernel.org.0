Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A472156C7DC
	for <lists+linux-pm@lfdr.de>; Sat,  9 Jul 2022 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGIINj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Jul 2022 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIINi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jul 2022 04:13:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3CBE3D
        for <linux-pm@vger.kernel.org>; Sat,  9 Jul 2022 01:13:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEB791F993;
        Sat,  9 Jul 2022 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657354414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gy2PpldJielDWMNdKOG6sAQo9sguNL6C4AZzqvZXFX4=;
        b=QOcuquB/NvjmThgy/kPvsx0wsgvKj5bscACUFO0VztmnqbK4sk8XScra0eJFQI08HNQwLr
        V2yzBK+JEf3iOJtIq/cdNdekvziHrE11YOG2uwL0sEKibSIGVdV75JuxRpJE9DRLoIROlO
        8zbPMYHaAuA8blHwB8GeHUssM1ofDis=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B20AA13A7D;
        Sat,  9 Jul 2022 08:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8c0yKq44yWJtTQAAMHmgww
        (envelope-from <trenn@suse.com>); Sat, 09 Jul 2022 08:13:34 +0000
From:   Thomas Renninger <trenn@suse.com>
To:     linux-pm@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Subject: [PATCH 1/2] cpupower: Introduce powercap intel-rapl library helpers and powercap-info command
Date:   Sat, 09 Jul 2022 10:13:34 +0200
Message-ID: <2991706.CnP8uJEn3U@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Read out powercap zone information via:
cpupower powercap-info
and show the zone hierarchy to the user:

./cpupower powercap-info
Driver: intel-rapl
Powercap domain hierarchy:

Zone: package-0 (enabled)
Power consumption can be monitored in micro Watts

        Zone: core (disabled)
        Power consumption can be monitored in micro Watts

        Zone: uncore (disabled)
        Power consumption can be monitored in micro Watts

        Zone: dram (disabled)
        Power consumption can be monitored in micro Watts

There is a dummy -a option for powercap-info which can/should be used to show
more detailed info later. Like that other args can be added easily later as 
well.

Signed-off-by: Thomas Renninger <trenn@suse.com>
CC: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index e9b6de314654..a81fd88fe315 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -133,7 +133,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-
monitor.o \
 	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
 	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
-	utils/cpuidle-set.o
+	utils/cpuidle-set.o utils/powercap-info.o
 
 UTIL_SRC := $(UTIL_OBJS:.o=.c)
 
@@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/
cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/
idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/
acpi_cppc.h
-LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
-LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/
acpi_cppc.h lib/powercap.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c lib/
powercap.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o lib/
powercap.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 override CFLAGS +=	-pipe
@@ -276,6 +276,7 @@ install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
+	$(INSTALL_DATA) lib/powercap.h $(DESTDIR)${includedir}/powercap.h
 
 install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
@@ -292,6 +293,7 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-set.1 $(DESTDIR)${mandir}/man1/
cpupower-set.1
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/
cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/
cpupower-monitor.1
+	$(INSTALL_DATA) -D man/cpupower-powercap-info.1 $(DESTDIR)$
{mandir}/man1/cpupower-powercap-info.1
 
 install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
@@ -321,6 +323,7 @@ uninstall:
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-set.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-info.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-monitor.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-powercap-info.1
 	- for HLANG in $(LANGUAGES); do \
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/
cpupower.mo; \
 	  done;
diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/
powercap.c
new file mode 100644
index 000000000000..a353d2585be9
--- /dev/null
+++ b/tools/power/cpupower/lib/powercap.c
@@ -0,0 +1,290 @@
+/*
+ *  (C) 2016       Thomas Renninger <trenn@suse.com>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <dirent.h>
+
+#include "powercap.h"
+
+static unsigned int sysfs_read_file(const char *path, char *buf, size_t 
buflen)
+{
+	int fd;
+	ssize_t numread;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+static int sysfs_get_enabled(char *path, int *mode)
+{
+	int fd;
+	char yes_no;
+
+	*mode = 0;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	if (read(fd, &yes_no, 1) != 1) {
+		close(fd);
+		return -1;
+	}
+
+	if (yes_no == '1') {
+		*mode = 1;
+		return 0;
+	} else if (yes_no == '0') {
+		return 0;
+	}
+	return -1;
+}
+
+int powercap_get_enabled(int *mode)
+{
+	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
+	return sysfs_get_enabled(path, mode);
+}
+
+/*
+ * Hardcoded, because rapl is the only powercap implementation
+- * this needs to get more generic if more powercap implementations
+ * should show up
+ */
+int powercap_get_driver(char *driver, int buflen)
+{
+	char file[SYSFS_PATH_MAX] = PATH_TO_RAPL;
+	struct stat statbuf;
+
+	if (stat(file, &statbuf) != 0 || !S_ISDIR(statbuf.st_mode)) {
+		driver = "";
+		return -1;
+	} else if (buflen > 10) {
+		strcpy(driver, "intel-rapl");
+		return 0;
+	} else
+		return -1;
+}
+
+enum powercap_get64 {
+	GET_ENERGY_UJ,
+	GET_MAX_ENERGY_RANGE_UJ,
+	GET_POWER_UW,
+	GET_MAX_POWER_RANGE_UW,
+	MAX_GET_64_FILES
+};
+
+static const char *powercap_get64_files[MAX_GET_64_FILES] = {
+	[GET_POWER_UW] = "power_uw",
+	[GET_MAX_POWER_RANGE_UW] = "max_power_range_uw",
+	[GET_ENERGY_UJ] = "energy_uj",
+	[GET_MAX_ENERGY_RANGE_UJ] = "max_energy_range_uj",
+};
+
+static int sysfs_powercap_get64_val(struct powercap_zone *zone,
+				      enum powercap_get64 which,
+				      uint64_t *val)
+{
+	char file[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/";
+	int ret;
+	char buf[MAX_LINE_LEN];
+
+	strcat(file, zone->sys_name);
+	strcat(file, "/");
+	strcat (file, powercap_get64_files[which]);
+
+	ret = sysfs_read_file(file, buf, MAX_LINE_LEN);
+	if (ret < 0 )
+		return ret;
+	if (ret == 0)
+		return -1;
+
+	*val = strtoll(buf, NULL, 10);
+	return 0;
+}
+
+
+int powercap_get_max_energy_range_uj (struct powercap_zone *zone, uint64_t 
*val)
+{
+	return sysfs_powercap_get64_val(zone, GET_MAX_ENERGY_RANGE_UJ, 
val);
+}
+
+int powercap_get_energy_uj (struct powercap_zone *zone, uint64_t *val)
+{
+	return sysfs_powercap_get64_val(zone, GET_ENERGY_UJ, val);
+}
+
+int powercap_get_max_power_range_uw (struct powercap_zone *zone, uint64_t 
*val)
+{
+	return sysfs_powercap_get64_val(zone, GET_MAX_POWER_RANGE_UW, val);
+}
+
+int powercap_get_power_uw (struct powercap_zone *zone, uint64_t *val)
+{
+	return sysfs_powercap_get64_val(zone, GET_POWER_UW, val);
+}
+
+int powercap_zone_get_enabled (struct powercap_zone *zone, int *mode)
+{
+	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+
+	if ((strlen(PATH_TO_POWERCAP) + strlen(zone->sys_name)) +
+	    strlen("/enabled") + 1 >= SYSFS_PATH_MAX)
+		return -1;
+
+	strcat(path, "/");
+	strcat(path, zone->sys_name);
+	strcat(path, "/enabled");
+
+	return sysfs_get_enabled(path, mode);
+}
+
+int powercap_zone_set_enabled (struct powercap_zone *zone, int mode)
+{
+	/* To be done if needed */
+	return 0;
+}
+
+
+int powercap_read_zone(struct powercap_zone *zone)
+{
+	struct dirent* dent;
+	DIR* zone_dir;
+	char sysfs_dir[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+	struct powercap_zone *child_zone;
+	char file[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
+	int i, ret = 0;
+	uint64_t val = 0;
+
+	strcat(sysfs_dir, "/");
+	strcat(sysfs_dir, zone->sys_name);
+
+	zone_dir = opendir(sysfs_dir);
+	if (zone_dir == NULL)
+		return -1;
+
+	strcat(file, "/");
+	strcat(file, zone->sys_name);
+	strcat(file, "/name");
+	sysfs_read_file(file, zone->name, MAX_LINE_LEN);
+	if (zone->parent)
+		zone->tree_depth = zone->parent->tree_depth + 1;
+	ret = powercap_get_energy_uj(zone, &val);
+	if (ret == 0)
+		zone->has_energy_uj = 1;
+	ret = powercap_get_power_uw(zone, &val);
+	if (ret == 0)
+		zone->has_power_uw = 1;
+
+	while((dent = readdir(zone_dir)) != NULL) {
+		struct stat st;
+
+		if(strcmp(dent->d_name, ".") == 0 || strcmp(dent-
>d_name, "..") == 0)
+			continue;
+
+		if (stat(dent->d_name, &st) != 0 || !
S_ISDIR(st.st_mode))
+			if (fstatat(dirfd(zone_dir), dent->d_name, 
&st, 0) < 0)
+				continue;
+
+		if (strncmp(dent->d_name, "intel-rapl:", 11) != 0)
+			continue;
+
+		child_zone = calloc(1, sizeof(struct powercap_zone));
+		if (child_zone == NULL)
+			return -1;
+		for (i = 0; i < POWERCAP_MAX_CHILD_ZONES; i++) {
+			if (zone->children[i] == NULL) {
+				zone->children[i] = child_zone;
+				break;
+			}
+			if (i == POWERCAP_MAX_CHILD_ZONES - 1) {
+				free(child_zone);
+				fprintf(stderr, "Reached 
POWERCAP_MAX_CHILD_ZONES %d\n",
+				       POWERCAP_MAX_CHILD_ZONES);
+				return -1;
+			}
+		}
+		strcpy(child_zone->sys_name, zone->sys_name);
+		strcat(child_zone->sys_name, "/");
+		strcat(child_zone->sys_name, dent->d_name);
+		child_zone->parent = zone;
+		if (zone->tree_depth >= POWERCAP_MAX_TREE_DEPTH) {
+			fprintf(stderr, "Maximum zone hierachy 
depth[%d] reached\n",
+				POWERCAP_MAX_TREE_DEPTH);
+			ret = -1;
+			break;
+		}
+		powercap_read_zone(child_zone);
+	}
+	closedir(zone_dir);
+	return ret;
+}
+
+struct powercap_zone *powercap_init_zones()
+{
+	int enabled;
+	struct powercap_zone *root_zone;
+	int ret;
+	char file[SYSFS_PATH_MAX] = PATH_TO_RAPL "/enabled";
+
+	ret = sysfs_get_enabled(file, &enabled);
+
+	if (ret)
+		return NULL;
+
+	if (!enabled)
+		return NULL;
+
+	root_zone = calloc(1, sizeof(struct powercap_zone));
+	if (!root_zone)
+		return NULL;
+
+	strcpy(root_zone->sys_name, "intel-rapl/intel-rapl:0");
+
+	powercap_read_zone(root_zone);
+
+	return root_zone;
+}
+
+/* Call function *f on the passed zone and all its children */
+
+int powercap_walk_zones(struct powercap_zone *zone,
+			int (*f)(struct powercap_zone *zone))
+{
+	int i, ret;
+
+	if (!zone)
+		return -1;
+
+	ret = f(zone);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < POWERCAP_MAX_CHILD_ZONES; i++) {
+		if (zone->children[i] != NULL) {
+			powercap_walk_zones(zone->children[i], f);
+		}
+	}
+	return 0;
+}
diff --git a/tools/power/cpupower/lib/powercap.h b/tools/power/cpupower/lib/
powercap.h
new file mode 100644
index 000000000000..8f11081274a7
--- /dev/null
+++ b/tools/power/cpupower/lib/powercap.h
@@ -0,0 +1,54 @@
+/*
+ *  (C) 2016       Thomas Renninger <trenn@suse.com>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ */
+
+#ifndef __CPUPOWER_RAPL_H__
+#define __CPUPOWER_RAPL_H__
+
+#define PATH_TO_POWERCAP "/sys/devices/virtual/powercap"
+#define PATH_TO_RAPL "/sys/devices/virtual/powercap/intel-rapl"
+#define PATH_TO_RAPL_CLASS "/sys/devices/virtual/powercap/intel-rapl"
+
+#define POWERCAP_MAX_CHILD_ZONES 10
+#define POWERCAP_MAX_TREE_DEPTH 10
+
+#define MAX_LINE_LEN 4096
+#define SYSFS_PATH_MAX 255
+
+#include <stdint.h>
+
+struct powercap_zone {
+	char name[MAX_LINE_LEN];
+	/*
+	 * sys_name relative to PATH_TO_POWERCAP,
+	 * do not forget the / in between
+	 */
+	char sys_name[SYSFS_PATH_MAX];
+	int tree_depth;
+	struct powercap_zone *parent;
+	struct powercap_zone *children[POWERCAP_MAX_CHILD_ZONES];
+	/* More possible caps or attributes to be added? */
+	uint32_t has_power_uw:1,
+		 has_energy_uj:1;
+
+};
+
+int powercap_walk_zones(struct powercap_zone *zone,
+			int (*f)(struct powercap_zone *zone));
+
+struct powercap_zone *powercap_init_zones();
+int powercap_get_enabled(int *mode);
+int powercap_set_enabled(int mode);
+int powercap_get_driver(char *driver, int buflen);
+
+int powercap_get_max_energy_range_uj (struct powercap_zone *zone, uint64_t 
*val);
+int powercap_get_energy_uj (struct powercap_zone *zone, uint64_t *val);
+int powercap_get_max_power_range_uw (struct powercap_zone *zone , uint64_t 
*val);
+int powercap_get_power_uw (struct powercap_zone *zone, uint64_t *val);
+int powercap_zone_get_enabled (struct powercap_zone *zone, int *mode);
+int powercap_zone_set_enabled (struct powercap_zone *zone, int mode);
+
+
+#endif /* __CPUPOWER_RAPL_H__ */
diff --git a/tools/power/cpupower/man/cpupower-powercap-info.1 b/tools/power/
cpupower/man/cpupower-powercap-info.1
new file mode 100644
index 000000000000..df3087000efb
--- /dev/null
+++ b/tools/power/cpupower/man/cpupower-powercap-info.1
@@ -0,0 +1,25 @@
+.TH CPUPOWER\-POWERCAP\-INFO "1" "05/08/2016" "" "cpupower Manual"
+.SH NAME
+cpupower\-powercap\-info \- Shows powercapping related kernel and hardware 
configurations
+.SH SYNOPSIS
+.ft B
+.B cpupower powercap-info
+
+.SH DESCRIPTION
+\fBcpupower powercap-info \fP shows kernel powercapping subsystem 
information.
+This needs hardware support and a loaded powercapping driver (at this time 
only
+intel_rapl driver exits) exporting hardware values userspace via sysfs.
+
+Some options are platform wide, some affect single cores. By default values
+of core zero are displayed only. cpupower --cpu all cpuinfo will show the
+settings of all cores, see cpupower(1) how to choose specific cores.
+
+.SH "DOCUMENTATION"
+
+kernel sources:
+Documentation/power/powercap/powercap.txt
+
+
+.SH "SEE ALSO"
+
+cpupower(1)
diff --git a/tools/power/cpupower/utils/builtin.h b/tools/power/cpupower/
utils/builtin.h
index f7065ae60a14..e1caefd467cd 100644
--- a/tools/power/cpupower/utils/builtin.h
+++ b/tools/power/cpupower/utils/builtin.h
@@ -8,6 +8,8 @@ extern int cmd_freq_set(int argc, const char **argv);
 extern int cmd_freq_info(int argc, const char **argv);
 extern int cmd_idle_set(int argc, const char **argv);
 extern int cmd_idle_info(int argc, const char **argv);
+extern int cmd_cap_info(int argc, const char **argv);
+extern int cmd_cap_set(int argc, const char **argv);
 extern int cmd_monitor(int argc, const char **argv);
 
 #endif
diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/
utils/cpupower.c
index 8ac3304a9957..9ec973165af1 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -54,6 +54,7 @@ static struct cmd_struct commands[] = {
 	{ "frequency-set",	cmd_freq_set,	1	},
 	{ "idle-info",		cmd_idle_info,	0	},
 	{ "idle-set",		cmd_idle_set,	1	},
+	{ "powercap-info",	cmd_cap_info,	0	},
 	{ "set",		cmd_set,	1	},
 	{ "info",		cmd_info,	0	},
 	{ "monitor",		cmd_monitor,	0	},
diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/
cpupower/utils/powercap-info.c
new file mode 100644
index 000000000000..989fafe581cf
--- /dev/null
+++ b/tools/power/cpupower/utils/powercap-info.c
@@ -0,0 +1,113 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <getopt.h>
+
+#include "powercap.h"
+#include "helpers/helpers.h"
+
+int powercap_show_all = 0;
+
+static struct option info_opts[] =
+{
+	{ "all",		no_argument,		 NULL,	
 'a'},
+	{ },
+};
+
+static int powercap_print_one_zone(struct powercap_zone *zone)
+{
+	int mode, i, ret = 0;
+	char pr_prefix[1024] = "";
+
+	for (i = 0; i < zone->tree_depth && i < POWERCAP_MAX_TREE_DEPTH; i+
+)
+		strcat (pr_prefix, "\t");
+
+	printf("%sZone: %s", pr_prefix, zone->name);
+	ret = powercap_zone_get_enabled(zone, &mode);
+	if (ret < 0)
+		return ret;
+	printf(" (%s)\n", mode ? "enabled" : "disabled");
+
+	if (zone->has_power_uw)
+printf(_("%sEnergy consumption can be monitored in micro Jules\n"),
+       pr_prefix);
+
+	if (zone->has_energy_uj)
+printf(_("%sPower consumption can be monitored in micro Watts\n"),
+       pr_prefix);
+
+	printf("\n");
+
+	if (ret != 0)
+		return ret;
+	return ret;
+}
+
+static int powercap_show()
+{
+	struct powercap_zone *root_zone;
+	char line[MAX_LINE_LEN] = "";
+	int ret, val;
+
+	ret = powercap_get_driver(line, MAX_LINE_LEN);
+	if (ret < 0) {
+		printf(_("No powercapping driver loaded\n"));
+		return ret;
+	}
+
+	printf("Driver: %s\n", line);
+	ret = powercap_get_enabled(&val);
+	if (ret < 0)
+		return ret;
+	if (!val) {
+		printf(_("Powercapping is disabled\n"));
+		return -1;
+	}
+
+	printf(_("Powercap domain hierarchy:\n\n"));
+	root_zone = powercap_init_zones();
+
+	if (root_zone == NULL) {
+		printf(_("No powercap info found\n"));
+		return 1;
+	}
+
+	powercap_walk_zones(root_zone, powercap_print_one_zone);
+
+	return 0;
+}
+
+int cmd_cap_set(int argc, char **argv)
+{
+	return 0;
+};
+int cmd_cap_info(int argc, char **argv)
+{
+	extern char *optarg;
+	extern int optind, opterr, optopt;
+	int ret = 0, cont = 1;
+	do {
+		ret = getopt_long(argc, argv, "a", info_opts, NULL);
+		switch (ret) {
+		case '?':
+			cont = 0;
+			break;
+		case -1:
+			cont = 0;
+			break;
+		case 'a':
+			powercap_show_all = 1;
+			break;
+		default:
+			fprintf(stderr, _("invalid or unknown 
argument\n"));
+			return EXIT_FAILURE;
+		}
+	} while (cont);
+
+	powercap_show();
+	return 0;
+}
-- 
2.33.0




