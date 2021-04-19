Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A11364D73
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhDSWDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 18:03:48 -0400
Received: from mail.ispras.ru ([83.149.199.84]:45050 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhDSWDs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 18:03:48 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 18:03:47 EDT
Received: from localhost.localdomain (unknown [46.188.10.168])
        by mail.ispras.ru (Postfix) with ESMTPSA id ACC064076B4B;
        Mon, 19 Apr 2021 21:57:23 +0000 (UTC)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Kconfig: fix documentation links
Date:   Tue, 20 Apr 2021 00:57:07 +0300
Message-Id: <20210419215707.10290-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

User documentation for cpufreq governors and drivers has been moved to
admin-guide; adjust references from Kconfig entries accordingly.

Remove references from undocumented cpufreq drivers, as well as the
'userspace' cpufreq governor, for which no additional details are
provided in the admin-guide text.

Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/Kconfig | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 85de313ddec2..c3038cdc6865 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -13,7 +13,8 @@ config CPU_FREQ
 	  clock speed, you need to either enable a dynamic cpufreq governor
 	  (see below) after boot, or use a userspace tool.
 
-	  For details, take a look at <file:Documentation/cpu-freq>.
+	  For details, take a look at
+	  <file:Documentation/admin-guide/pm/cpufreq.rst>.
 
 	  If in doubt, say N.
 
@@ -140,8 +141,6 @@ config CPU_FREQ_GOV_USERSPACE
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpufreq_userspace.
 
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
 	  If in doubt, say Y.
 
 config CPU_FREQ_GOV_ONDEMAND
@@ -158,7 +157,8 @@ config CPU_FREQ_GOV_ONDEMAND
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpufreq_ondemand.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at
+	  <file:Documentation/admin-guide/pm/cpufreq.rst>.
 
 	  If in doubt, say N.
 
@@ -182,7 +182,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpufreq_conservative.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at
+	  <file:Documentation/admin-guide/pm/cpufreq.rst>.
 
 	  If in doubt, say N.
 
@@ -246,8 +247,6 @@ config IA64_ACPI_CPUFREQ
 	This driver adds a CPUFreq driver which utilizes the ACPI
 	Processor Performance States.
 
-	For details, take a look at <file:Documentation/cpu-freq/>.
-
 	If in doubt, say N.
 endif
 
@@ -271,8 +270,6 @@ config LOONGSON2_CPUFREQ
 
 	  Loongson2F and it's successors support this feature.
 
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
 	  If in doubt, say N.
 
 config LOONGSON1_CPUFREQ
@@ -282,8 +279,6 @@ config LOONGSON1_CPUFREQ
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
 
-	  For details, take a look at <file:Documentation/cpu-freq/>.
-
 	  If in doubt, say N.
 endif
 
@@ -293,8 +288,6 @@ config SPARC_US3_CPUFREQ
 	help
 	  This adds the CPUFreq driver for UltraSPARC-III processors.
 
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
 	  If in doubt, say N.
 
 config SPARC_US2E_CPUFREQ
@@ -302,8 +295,6 @@ config SPARC_US2E_CPUFREQ
 	help
 	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
 
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
 	  If in doubt, say N.
 endif
 
@@ -318,8 +309,6 @@ config SH_CPU_FREQ
 	  will also generate a notice in the boot log before disabling
 	  itself if the CPU in question is not capable of rate rounding.
 
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
 	  If unsure, say N.
 endif
 
-- 
2.30.0

