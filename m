Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF92E1708F7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 20:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBZTeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 14:34:13 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:48504 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgBZTeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 14:34:13 -0500
Received: from naomi.gilbertsystems.net (d14-69-92-185.try.wideopenwest.com [69.14.185.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: floppym)
        by smtp.gentoo.org (Postfix) with ESMTPSA id B4CCD34F2CC;
        Wed, 26 Feb 2020 19:34:11 +0000 (UTC)
From:   Mike Gilbert <floppym@gentoo.org>
To:     shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, Mike Gilbert <floppym@gentoo.org>
Subject: [PATCH v3] cpupower: avoid multiple definition with gcc -fno-common
Date:   Wed, 26 Feb 2020 14:33:59 -0500
Message-Id: <20200226193359.1308202-1-floppym@gentoo.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224202029.877025-1-floppym@gentoo.org>
References: <20200224202029.877025-1-floppym@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Building cpupower with -fno-common in CFLAGS results in errors due to
multiple definitions of the 'cpu_count' and 'start_time' variables.

./utils/idle_monitor/snb_idle.o:./utils/idle_monitor/cpupower-monitor.h:28:
multiple definition of `cpu_count';
./utils/idle_monitor/nhm_idle.o:./utils/idle_monitor/cpupower-monitor.h:28:
first defined here
...
./utils/idle_monitor/cpuidle_sysfs.o:./utils/idle_monitor/cpuidle_sysfs.c:22:
multiple definition of `start_time';
./utils/idle_monitor/amd_fam14h_idle.o:./utils/idle_monitor/amd_fam14h_idle.c:85:
first defined here

The -fno-common option will be enabled by default in GCC 10.

Bug: https://bugs.gentoo.org/707462
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
---
 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 33dc34db4f3c..20f46348271b 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
 static struct pci_dev *amd_fam14h_pci_dev;
 static int nbp1_entered;
 
-struct timespec start_time;
+static struct timespec start_time;
 static unsigned long long timediff;
 
 #ifdef DEBUG
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 3c4cee160b0e..a65f7d011513 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -19,7 +19,7 @@ struct cpuidle_monitor cpuidle_sysfs_monitor;
 
 static unsigned long long **previous_count;
 static unsigned long long **current_count;
-struct timespec start_time;
+static struct timespec start_time;
 static unsigned long long timediff;
 
 static int cpuidle_get_count_percent(unsigned int id, double *percent,
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 6d44fec55ad5..7c77045fef52 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -27,6 +27,8 @@ struct cpuidle_monitor *all_monitors[] = {
 0
 };
 
+int cpu_count;
+
 static struct cpuidle_monitor *monitors[MONITORS_MAX];
 static unsigned int avail_monitors;
 
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 5b5eb1da0cce..c559d3115330 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -25,7 +25,7 @@
 #endif
 #define CSTATE_DESC_LEN 60
 
-int cpu_count;
+extern int cpu_count;
 
 /* Hard to define the right names ...: */
 enum power_range_e {
-- 
2.25.1

