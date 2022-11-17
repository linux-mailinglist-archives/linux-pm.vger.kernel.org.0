Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB062D765
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiKQJrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 04:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKQJrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 04:47:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918882AC6C
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 01:47:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8796F1F8AB;
        Thu, 17 Nov 2022 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668678462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WwbAU+9DK69oK+zbOlIxCAegXsZiEaop0LhPn+NOuLg=;
        b=r/1R/nrzPkR4rjZLDsht1D2wZg07jn6ykWZU8zhPXa5l/tsgnJrPRro5C5UR9g7uFBYhVr
        HdrUnnT3sSt32EvkiulhKY/kNHzG0ebmlyTNvNgotYdDXegoFzgiOQHyazyz6oQ2AQ6F2d
        lAyiazFdtLXFqD90IOI2G/VxSQn1B9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668678462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WwbAU+9DK69oK+zbOlIxCAegXsZiEaop0LhPn+NOuLg=;
        b=l1S25G+FZokJ3ETGW/Jxpf0eOKfog29GuG1tC6B2eQ5sDhcPzqLt1lyk7oTWpMG/BLmZUL
        +2Cu+LK7Rc8rhzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6231D13B56;
        Thu, 17 Nov 2022 09:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6OahFj4DdmPXEwAAMHmgww
        (envelope-from <trenn@suse.de>); Thu, 17 Nov 2022 09:47:42 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     skhan@linuxfoundation.org, Zhang Rui <rui.zhang@intel.com>,
        daniel.lezcano@linaro.org
Subject: [PATCH 1/2] cpupower: Introduce powercap intel-rapl library helpers and powercap-info command
Date:   Thu, 17 Nov 2022 10:47:41 +0100
Message-ID: <3200810.N7aMVyhfb1@work>
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
more detailed info later. Like that other args can be added easily later as well.

A enable/disable option via powercap-set subcommand is also an enhancement
for later.

Also not all RAPL domains are shown. The func walking through RAPL subdomains
is restricted and hardcoded to: "intel-rapl/intel-rapl:0"
On my system above powercap domains map to:
intel-rapl/intel-rapl:0
-> pack (age-0)
intel-rapl/intel-rapl:0/intel-rapl:0:0
-> core
intel-rapl/intel-rapl:0/intel-rapl:0:1
-> uncore

Missing ones on my system are:
intel-rapl-mmio/intel-rapl-mmio:0
-> pack (age-0)

intel-rapl/intel-rapl:1
-> psys

This could get enhanced in:
struct powercap_zone *powercap_init_zones()
and adopted to walk through all intel-rapl zones, but
also to other powercap drivers like dtpm
(Dynamic Thermal Power Management framework),
cmp with: drivers/powercap/dtpm_*

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/Makefile              |  14 ++-
 tools/power/cpupower/utils/builtin.h       |   2 +
 tools/power/cpupower/utils/cpupower.c      |   1 +
 tools/power/cpupower/utils/powercap-info.c | 113 +++++++++++++++++++++
 4 files changed, 126 insertions(+), 4 deletions(-)
 create mode 100644 tools/power/cpupower/utils/powercap-info.c

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index e9b6de314654..9fd3b309b3a6 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -133,7 +133,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-monitor.o \
 	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
 	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
-	utils/cpuidle-set.o
+	utils/cpuidle-set.o utils/powercap-info.o
 
 UTIL_SRC := $(UTIL_OBJS:.o=.c)
 
@@ -143,9 +143,12 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
-LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
-LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h \
+	lib/powercap.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c \
+	lib/powercap.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o \
+	lib/powercap.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 override CFLAGS +=	-pipe
@@ -276,6 +279,7 @@ install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
+	$(INSTALL_DATA) lib/powercap.h $(DESTDIR)${includedir}/powercap.h
 
 install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
@@ -292,6 +296,7 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-set.1 $(DESTDIR)${mandir}/man1/cpupower-set.1
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
+	$(INSTALL_DATA) -D man/cpupower-powercap-info.1 $(DESTDIR)${mandir}/man1/cpupower-powercap-info.1
 
 install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
@@ -321,6 +326,7 @@ uninstall:
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-set.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-info.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-monitor.1
+	- rm -f $(DESTDIR)${mandir}/man1/cpupower-powercap-info.1
 	- for HLANG in $(LANGUAGES); do \
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	  done;
diff --git a/tools/power/cpupower/utils/builtin.h b/tools/power/cpupower/utils/builtin.h
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
diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
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
diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
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
+	{ "all",		no_argument,		 NULL,	 'a'},
+	{ },
+};
+
+static int powercap_print_one_zone(struct powercap_zone *zone)
+{
+	int mode, i, ret = 0;
+	char pr_prefix[1024] = "";
+
+	for (i = 0; i < zone->tree_depth && i < POWERCAP_MAX_TREE_DEPTH; i++)
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
+			fprintf(stderr, _("invalid or unknown argument\n"));
+			return EXIT_FAILURE;
+		}
+	} while (cont);
+
+	powercap_show();
+	return 0;
+}
-- 
2.37.1



