Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36CE62D769
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 10:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiKQJsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 04:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKQJsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 04:48:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69951C18
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 01:48:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 883A022601;
        Thu, 17 Nov 2022 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668678495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SvgEWTp7c9loGhpwJu2k72IdYmUaElpD7EL84RLe2qY=;
        b=aJGUqRCFWCD7XrNU8ztr3njAUL34v48T32f3SH7iMppHN9HOhou1e8GJTmZnh5cdrmrba5
        IE7RyZSLeSYrTjJ2Pbw7lNUeEpPqurf7pRxnUSJ01ipFYCNNKwRxFthvUzs9BFCIq/o8Hy
        ymshDFFBhOFdRInIO/2DvJ7fNAwgLOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668678495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SvgEWTp7c9loGhpwJu2k72IdYmUaElpD7EL84RLe2qY=;
        b=Rz4fVco1FXmNdB/gqkibz5KE52L+UivdRnuoHbUt2LnLhVjj3uqXjbL0XMD1SqojAfWjKT
        ZxC9bFUJp5Ro0QCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 629AA13B56;
        Thu, 17 Nov 2022 09:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ye3NFl8DdmMHFAAAMHmgww
        (envelope-from <trenn@suse.de>); Thu, 17 Nov 2022 09:48:15 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>, skhan@linuxfoundation.org
Subject: [PATCH 2/2] cpupower: rapl monitor - shows the used power consumption in uj for each rapl domain
Date:   Thu, 17 Nov 2022 10:48:15 +0100
Message-ID: <14777287.JCcGWNJJiE@work>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This CPU power monitor shows the power consumption
as exposed by the powercap subsystem, cmp with:
Documentation/power/powercap/powercap.rst

cpupower monitor -m RAPL
 CPU| pack | core | unco
   0|6853926|967832|442381
   8|6853926|967832|442381
   1|6853926|967832|442381
   9|6853926|967832|442381

Unfortunately RAPL domains cannot be directly mapped to the corresponding
CPU socket/package, core it belongs to.
Not sure this is possible at all with the current data exposed from the kernel.

Still it can be worthful information for developers trying to optimize
power consumption of workloads or their system in general.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/Makefile                 |   1 +
 .../utils/idle_monitor/cpupower-monitor.c     |   7 +-
 .../utils/idle_monitor/idle_monitors.def      |   1 +
 .../utils/idle_monitor/rapl_monitor.c         | 147 ++++++++++++++++++
 4 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 tools/power/cpupower/utils/idle_monitor/rapl_monitor.c

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 9fd3b309b3a6..59bfa05dec5d 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -131,6 +131,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/idle_monitor/hsw_ext_idle.o \
 	utils/idle_monitor/amd_fam14h_idle.o utils/idle_monitor/cpuidle_sysfs.o \
 	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-monitor.o \
+	utils/idle_monitor/rapl_monitor.o \
 	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
 	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
 	utils/cpuidle-set.o utils/powercap-info.o
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 7c77045fef52..075e766ff1f3 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -459,9 +459,10 @@ int cmd_monitor(int argc, char **argv)
 			print_results(1, cpu);
 	}
 
-	for (num = 0; num < avail_monitors; num++)
-		monitors[num]->unregister();
-
+	for (num = 0; num < avail_monitors; num++) {
+		if (monitors[num]->unregister)
+			monitors[num]->unregister();
+	}
 	cpu_topology_release(cpu_top);
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/idle_monitor/idle_monitors.def b/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
index 0d6ba4dbb9c7..7c926e90c87e 100644
--- a/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
+++ b/tools/power/cpupower/utils/idle_monitor/idle_monitors.def
@@ -4,5 +4,6 @@ DEF(intel_nhm)
 DEF(intel_snb)
 DEF(intel_hsw_ext)
 DEF(mperf)
+DEF(rapl)
 #endif
 DEF(cpuidle_sysfs)
diff --git a/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c b/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
new file mode 100644
index 000000000000..1acadf5ef90e
--- /dev/null
+++ b/tools/power/cpupower/utils/idle_monitor/rapl_monitor.c
@@ -0,0 +1,147 @@
+/*
+ *  (C) 2016      Thomas Renninger <trenn@suse.com>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *
+ */
+
+#if defined(__i386__) || defined(__x86_64__)
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <time.h>
+#include <string.h>
+
+#include <pci/pci.h>
+
+#include "idle_monitor/cpupower-monitor.h"
+#include "helpers/helpers.h"
+#include "powercap.h"
+
+#define MAX_RAPL_ZONES 10
+
+int rapl_zone_count = 0;
+cstate_t rapl_zones[MAX_RAPL_ZONES];
+struct powercap_zone *rapl_zones_pt[MAX_RAPL_ZONES] = { 0 };
+
+unsigned long long rapl_zone_previous_count[MAX_RAPL_ZONES];
+unsigned long long rapl_zone_current_count[MAX_RAPL_ZONES];
+unsigned long long rapl_max_count;
+
+static int rapl_get_count_uj(unsigned int id, unsigned long long *count,
+			     unsigned int cpu)
+{
+	if (rapl_zones_pt[id] == NULL)
+		/* error */
+		return -1;
+
+	*count = rapl_zone_current_count[id] - rapl_zone_previous_count[id];
+
+	return 0;
+}
+
+static int powercap_count_zones(struct powercap_zone *zone)
+{
+	uint64_t val;
+	int uj;
+	if (rapl_zone_count >= MAX_RAPL_ZONES)
+		return -1;
+
+	if (!zone->has_energy_uj)
+		return 0;
+
+	printf("%s\n", zone->sys_name);
+	uj = powercap_get_energy_uj(zone, &val);
+	printf("%d\n", uj);
+
+	strncpy(rapl_zones[rapl_zone_count].name, zone->name, CSTATE_NAME_LEN - 1);
+	strcpy(rapl_zones[rapl_zone_count].desc, "");
+	rapl_zones[rapl_zone_count].id = rapl_zone_count;
+	rapl_zones[rapl_zone_count].range = RANGE_MACHINE;
+	rapl_zones[rapl_zone_count].get_count = rapl_get_count_uj;
+	rapl_zones_pt[rapl_zone_count] = zone;
+	rapl_zone_count++;
+
+	return 0;
+}
+
+static int rapl_start(void)
+{
+	int i, ret;
+	uint64_t uj_val;
+
+	for (i = 0; i < rapl_zone_count; i++) {
+		ret = powercap_get_energy_uj(rapl_zones_pt[i], &uj_val);
+		if (ret)
+			return ret;
+		rapl_zone_previous_count[i] = uj_val;
+	}
+
+	return 0;
+}
+
+static int rapl_stop(void)
+{
+	int i;
+	uint64_t uj_val;
+
+	for (i = 0; i < rapl_zone_count; i++) {
+		int ret;
+		ret = powercap_get_energy_uj(rapl_zones_pt[i], &uj_val);
+		if (ret)
+			return ret;
+		rapl_zone_current_count[i] = uj_val;
+		if (rapl_max_count < uj_val)
+			rapl_max_count = uj_val - rapl_zone_previous_count[i];
+	}
+	return 0;
+}
+
+struct cpuidle_monitor *rapl_register(void)
+{
+	struct powercap_zone *root_zone;
+	char line[MAX_LINE_LEN] = "";
+	int ret, val;
+
+	ret = powercap_get_driver(line, MAX_LINE_LEN);
+	if (ret < 0) {
+		dprint("No powercapping driver loaded\n");
+		return NULL;
+	}
+
+	dprint("Driver: %s\n", line);
+	ret = powercap_get_enabled(&val);
+	if (ret < 0)
+		return NULL;
+	if (!val) {
+		dprint("Powercapping is disabled\n");
+		return NULL;
+	}
+
+	dprint("Powercap domain hierarchy:\n\n");
+	root_zone = powercap_init_zones();
+
+	if (root_zone == NULL) {
+		dprint("No powercap info found\n");
+		return NULL;
+	}
+
+	powercap_walk_zones(root_zone, powercap_count_zones);
+	rapl_monitor.hw_states_num = rapl_zone_count;
+
+	return &rapl_monitor;
+}
+
+struct cpuidle_monitor rapl_monitor = {
+	.name			= "RAPL",
+	.hw_states		= rapl_zones,
+	.hw_states_num		= 0,
+	.start			= rapl_start,
+	.stop			= rapl_stop,
+	.do_register		= rapl_register,
+	.flags.needs_root	= 0,
+	.overflow_s		= 60 * 60 * 24 * 100, /* To be implemented */
+};
+
+#endif
-- 
2.37.1




