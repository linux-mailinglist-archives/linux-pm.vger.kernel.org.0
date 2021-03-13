Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4020339D9D
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCMKmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Mar 2021 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhCMKmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Mar 2021 05:42:32 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E12C061574
        for <linux-pm@vger.kernel.org>; Sat, 13 Mar 2021 02:42:32 -0800 (PST)
Received: by sf.home (Postfix, from userid 1000)
        id 34F4C5A22061; Sat, 13 Mar 2021 10:42:20 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] ia64: fix format string for ia64-acpi-cpu-freq
Date:   Sat, 13 Mar 2021 10:42:14 +0000
Message-Id: <20210313104214.1548076-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix warning with %lx / s64 mismatch:

  CC [M]  drivers/cpufreq/ia64-acpi-cpufreq.o
    drivers/cpufreq/ia64-acpi-cpufreq.c: In function 'processor_get_pstate':
      warning: format '%lx' expects argument of type 'long unsigned int',
      but argument 3 has type 's64' {aka 'long long int'} [-Wformat=]

CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 2efe7189ccc4..c6bdc455517f 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -54,7 +54,7 @@ processor_set_pstate (
 	retval = ia64_pal_set_pstate((u64)value);
 
 	if (retval) {
-		pr_debug("Failed to set freq to 0x%x, with error 0x%lx\n",
+		pr_debug("Failed to set freq to 0x%x, with error 0x%llx\n",
 		        value, retval);
 		return -ENODEV;
 	}
@@ -77,7 +77,7 @@ processor_get_pstate (
 
 	if (retval)
 		pr_debug("Failed to get current freq with "
-			"error 0x%lx, idx 0x%x\n", retval, *value);
+			"error 0x%llx, idx 0x%x\n", retval, *value);
 
 	return (int)retval;
 }
-- 
2.30.2

