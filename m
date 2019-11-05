Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29BEF6A1
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfKEHwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 02:52:37 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:37750 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbfKEHwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 02:52:37 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iRtda-0005c4-FH; Tue, 05 Nov 2019 07:52:26 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iRtda-0002NG-1x; Tue, 05 Nov 2019 07:52:26 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: fix integer/pointer warnings in acpi_platform_list
Date:   Tue,  5 Nov 2019 07:52:25 +0000
Message-Id: <20191105075225.9083-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fourth field in this table is a pointer, not an integer so replace
the 0 with a NULL to avoid the following sparse warnings:

drivers/cpufreq/intel_pstate.c:2667:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2668:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2669:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2670:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2671:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2672:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2673:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2674:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2675:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2676:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2677:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2678:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2679:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2680:64: sparse: sparse: Using plain integer as NULL pointer
drivers/cpufreq/intel_pstate.c:2681:64: sparse: sparse: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 53a51c169451..cfcf34e04c3d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2664,21 +2664,21 @@ enum {
 
 /* Hardware vendor-specific info that has its own power management modes */
 static struct acpi_platform_list plat_info[] __initdata = {
-	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, 0, PSS},
-	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
-	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
+	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, NULL, PSS},
+	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
+	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
 	{ } /* End */
 };
 
-- 
2.24.0.rc1

