Return-Path: <linux-pm+bounces-8244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D98D1ABD
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC521C22003
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052216D339;
	Tue, 28 May 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFPpHpfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5816D32F;
	Tue, 28 May 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898291; cv=none; b=S5S6yceN4wY0yPbauNh7EGQ9S0GGFj/NBuiLPVNPMsyXzEuEZfyODc1GdEReRixrwtou7i6TPU8VKHN65vU9Se8Dpbil4mJUMlQQWpUNOOs1ZFPaYJAecQIBbd3aGAG23k6HVAd7Hak3CFDHkNLzJ9Be5JKiG2O70fOufPsbAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898291; c=relaxed/simple;
	bh=lLoV8zixnH4tiCV5O9FGmiko/YIhlX+oWOkfbbm3RCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnTRq3L9jnI5P4V4v5rONUGxwB4kTMVRFmow71GfvlHEtkHijELQRpiCdOwdOUFef/vIiP0ATk2Vb3okEbmUoDnNwUs5NHpdwxVOLTwfhNsZI1EZn2nHKpybgOR5qrFdRZPFRPqtW3OqTlVbDrkDce4jksAP7eLNjLqLiqzXuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFPpHpfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E937C3277B;
	Tue, 28 May 2024 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898290;
	bh=lLoV8zixnH4tiCV5O9FGmiko/YIhlX+oWOkfbbm3RCY=;
	h=From:To:Cc:Subject:Date:From;
	b=rFPpHpfVC8Ft33sJQ0705o9b/6Dubf7liZEQbJ7RrmIMNulsXxrqcV+pgpU+DCwU+
	 tZSh9EonpGKRBo1VRD6gBo6+wzsvZD7/mM6h5w5ATGwn94U7ITOrFsN34l7CyBHTq+
	 la5kkhXNcz7LEYdythzgDgoxWNYuBhUuC0UmR6a9RXiIzMFYpvJXgR87OC0rP9fZU8
	 anIFRn0+uuPZNs4+/03Yb0spRIJEDvBAzjv9DTGSUORlEpHOoS9fLdchudJ8w8ED7s
	 5P0Y1AI06PaAaWFN6hjUt4BNn9gnaT+IQjgYeIIQ/3UINpicFGBR9x2zUsTZ7a2jgY
	 ZBf5xCZiHQtSg==
From: Arnd Bergmann <arnd@kernel.org>
To: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Perry Yuan <perry.yuan@amd.com>,
	Wyes Karny <wyes.karny@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Meng Li <li.meng@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: remove global header file
Date: Tue, 28 May 2024 14:09:23 +0200
Message-Id: <20240528121124.3588248-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When extra warnings are enabled, gcc points out a global variable
definition in a header:

In file included from drivers/cpufreq/amd-pstate-ut.c:29:
include/linux/amd-pstate.h:123:27: error: 'amd_pstate_mode_string' defined but not used [-Werror=unused-const-variable=]
  123 | static const char * const amd_pstate_mode_string[] = {
      |                           ^~~~~~~~~~~~~~~~~~~~~~

This header is only included from two files in the same directory,
and one of them uses only a single definition from it, so clean it
up by moving most of the contents into the driver that uses them,
and making shared bits a local header file.

Fixes: 36c5014e5460 ("cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                   |  1 -
 drivers/cpufreq/amd-pstate-ut.c               |  3 +-
 drivers/cpufreq/amd-pstate.c                  | 34 ++++++++++++++++++-
 .../linux => drivers/cpufreq}/amd-pstate.h    | 33 ------------------
 4 files changed, 35 insertions(+), 36 deletions(-)
 rename {include/linux => drivers/cpufreq}/amd-pstate.h (82%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 070a39b2b098..35a75ab8ef05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1107,7 +1107,6 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
-F:	include/linux/amd-pstate.h
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..fc275d41d51e 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -26,10 +26,11 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/fs.h>
-#include <linux/amd-pstate.h>
 
 #include <acpi/cppc_acpi.h>
 
+#include "amd-pstate.h"
+
 /*
  * Abbreviations:
  * amd_pstate_ut: used as a shortform for AMD P-State unit test.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1b7e82a0ad2e..91993647e09e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -36,7 +36,6 @@
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
-#include <linux/amd-pstate.h>
 #include <linux/topology.h>
 
 #include <acpi/processor.h>
@@ -46,6 +45,8 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+
+#include "amd-pstate.h"
 #include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
@@ -53,6 +54,37 @@
 #define CPPC_HIGHEST_PERF_PERFORMANCE	196
 #define CPPC_HIGHEST_PERF_DEFAULT	166
 
+#define AMD_CPPC_EPP_PERFORMANCE		0x00
+#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
+#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_POWERSAVE			0xFF
+
+/*
+ * enum amd_pstate_mode - driver working mode of amd pstate
+ */
+enum amd_pstate_mode {
+	AMD_PSTATE_UNDEFINED = 0,
+	AMD_PSTATE_DISABLE,
+	AMD_PSTATE_PASSIVE,
+	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_GUIDED,
+	AMD_PSTATE_MAX,
+};
+
+static const char * const amd_pstate_mode_string[] = {
+	[AMD_PSTATE_UNDEFINED]   = "undefined",
+	[AMD_PSTATE_DISABLE]     = "disable",
+	[AMD_PSTATE_PASSIVE]     = "passive",
+	[AMD_PSTATE_ACTIVE]      = "active",
+	[AMD_PSTATE_GUIDED]      = "guided",
+	NULL,
+};
+
+struct quirk_entry {
+	u32 nominal_freq;
+	u32 lowest_freq;
+};
+
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
  * with community together.
diff --git a/include/linux/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
similarity index 82%
rename from include/linux/amd-pstate.h
rename to drivers/cpufreq/amd-pstate.h
index d58fc022ec46..e6a28e7f4dbf 100644
--- a/include/linux/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/include/linux/amd-pstate.h
- *
  * Copyright (C) 2022 Advanced Micro Devices, Inc.
  *
  * Author: Meng Li <li.meng@amd.com>
@@ -12,11 +10,6 @@
 
 #include <linux/pm_qos.h>
 
-#define AMD_CPPC_EPP_PERFORMANCE		0x00
-#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
-#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
-#define AMD_CPPC_EPP_POWERSAVE			0xFF
-
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
  *********************************************************************/
@@ -108,30 +101,4 @@ struct amd_cpudata {
 	bool	suspended;
 };
 
-/*
- * enum amd_pstate_mode - driver working mode of amd pstate
- */
-enum amd_pstate_mode {
-	AMD_PSTATE_UNDEFINED = 0,
-	AMD_PSTATE_DISABLE,
-	AMD_PSTATE_PASSIVE,
-	AMD_PSTATE_ACTIVE,
-	AMD_PSTATE_GUIDED,
-	AMD_PSTATE_MAX,
-};
-
-static const char * const amd_pstate_mode_string[] = {
-	[AMD_PSTATE_UNDEFINED]   = "undefined",
-	[AMD_PSTATE_DISABLE]     = "disable",
-	[AMD_PSTATE_PASSIVE]     = "passive",
-	[AMD_PSTATE_ACTIVE]      = "active",
-	[AMD_PSTATE_GUIDED]      = "guided",
-	NULL,
-};
-
-struct quirk_entry {
-	u32 nominal_freq;
-	u32 lowest_freq;
-};
-
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.39.2


