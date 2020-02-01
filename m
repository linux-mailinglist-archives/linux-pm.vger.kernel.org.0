Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC214F935
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2020 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBARva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 12:51:30 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:56048 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgBARva (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Feb 2020 12:51:30 -0500
Received: from naomi.gilbertsystems.net (d14-69-92-185.try.wideopenwest.com [69.14.185.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: floppym)
        by smtp.gentoo.org (Postfix) with ESMTPSA id AE21934E3CE;
        Sat,  1 Feb 2020 17:51:29 +0000 (UTC)
From:   Mike Gilbert <floppym@gentoo.org>
To:     linux-pm@vger.kernel.org
Cc:     Mike Gilbert <floppym@gentoo.org>
Subject: [PATCH] cpupower: avoid multiple definition with gcc -fno-common
Date:   Sat,  1 Feb 2020 12:50:46 -0500
Message-Id: <20200201175046.3948500-1-floppym@gentoo.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The -fno-common option will be enabled by default in GCC 10.

Bug: https://bugs.gentoo.org/707462
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
---
 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 33dc34db4f3c..1b69f25a1281 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
 static struct pci_dev *amd_fam14h_pci_dev;
 static int nbp1_entered;
 
-struct timespec start_time;
+extern struct timespec start_time;
 static unsigned long long timediff;
 
 #ifdef DEBUG
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
2.25.0

