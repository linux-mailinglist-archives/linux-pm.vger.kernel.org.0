Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4521D40D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMKzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:55:11 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:55846 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgGMKzL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 06:55:11 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 57D4ABC06E;
        Mon, 13 Jul 2020 10:55:08 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] cpufreq: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 12:55:02 +0200
Message-Id: <20200713105502.33482-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/cpufreq/acpi-cpufreq.c    | 2 +-
 drivers/cpufreq/davinci-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 429e5a36c08a..29e8ff422b91 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -612,7 +612,7 @@ static const struct dmi_system_id sw_any_bug_dmi_table[] = {
 static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 {
 	/* Intel Xeon Processor 7100 Series Specification Update
-	 * http://www.intel.com/Assets/PDF/specupdate/314554.pdf
+	 * https://www.intel.com/Assets/PDF/specupdate/314554.pdf
 	 * AL30: A Machine Check Exception (MCE) Occurring during an
 	 * Enhanced Intel SpeedStep Technology Ratio Change May Cause
 	 * Both Processor Cores to Lock Up. */
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 297d23cad8b5..91f477a6cbc4 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -2,7 +2,7 @@
 /*
  * CPU frequency scaling for DaVinci
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on linux/arch/arm/plat-omap/cpu-omap.c. Original Copyright follows:
  *
-- 
2.27.0

