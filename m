Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC4196636
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 13:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgC1M61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 08:58:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43401 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgC1M61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 08:58:27 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 5bf184116b0b3e6b; Sat, 28 Mar 2020 13:58:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Select schedutil as the default governor
Date:   Sat, 28 Mar 2020 13:57:06 +0100
Message-ID: <2084178.yfvgZJeXvx@kreacher>
In-Reply-To: <2016232.ihCVsphvri@kreacher>
References: <2016232.ihCVsphvri@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Modify cpufreq Kconfig to select schedutil as the default governor
if the intel_pstate driver has been selected and SMP support is
enabled (because schedutil depends on SMP).

Also select schedutil as well as the performance governor from the
intel_pstate Kconfig section to ensure the equivalence of the passive
and active mode governor configuration options.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/Kconfig     | 3 ++-
 drivers/cpufreq/Kconfig.x86 | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index bff5295016ae..9f0e7e79ed14 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -37,10 +37,11 @@ config CPU_FREQ_STAT
 choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
-	  startup. If in doubt, select 'performance'.
+	  startup. If in doubt, use the default setting.
 
 config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	bool "performance"
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index a6528388952e..758c69a2e1bf 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -8,6 +8,8 @@ config X86_INTEL_PSTATE
 	depends on X86
 	select ACPI_PROCESSOR if ACPI
 	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
+	select CPU_FREQ_GOV_PERFORMANCE
+	select CPU_FREQ_GOV_SCHEDUTIL if SMP
 	help
 	  This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-- 
2.16.4




