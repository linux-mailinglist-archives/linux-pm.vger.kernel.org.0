Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915D055316
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfFYPRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:17:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:15842 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfFYPRD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 11:17:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 08:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="161946622"
Received: from syhu-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.173.95])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2019 08:17:01 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 03/13] intel_rapl: introduce intel_rapl.h
Date:   Tue, 25 Jun 2019 23:16:38 +0800
Message-Id: <1561475808-24839-4-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
References: <1561475808-24839-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Create a new header file for the common definitions that might be used
by different RAPL Interface.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 MAINTAINERS                   |   1 +
 drivers/powercap/intel_rapl.c | 101 +------------------------------------
 include/linux/intel_rapl.h    | 113 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 99 deletions(-)
 create mode 100644 include/linux/intel_rapl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496c..b51f2b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12601,6 +12601,7 @@ F:	drivers/base/power/
 F:	include/linux/pm.h
 F:	include/linux/pm_*
 F:	include/linux/powercap.h
+F:	include/linux/intel_rapl.h
 F:	drivers/powercap/
 F:	kernel/configs/nopm.config
 
diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9be9f20..adb35ec 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -18,8 +18,9 @@
 #include <linux/cpu.h>
 #include <linux/powercap.h>
 #include <linux/suspend.h>
-#include <asm/iosf_mbi.h>
+#include <linux/intel_rapl.h>
 
+#include <asm/iosf_mbi.h>
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -74,59 +75,9 @@ enum unit_type {
 	TIME_UNIT,
 };
 
-enum rapl_domain_type {
-	RAPL_DOMAIN_PACKAGE, /* entire package/socket */
-	RAPL_DOMAIN_PP0, /* core power plane */
-	RAPL_DOMAIN_PP1, /* graphics uncore */
-	RAPL_DOMAIN_DRAM,/* DRAM control_type */
-	RAPL_DOMAIN_PLATFORM, /* PSys control_type */
-	RAPL_DOMAIN_MAX,
-};
-
-enum rapl_domain_reg_id {
-	RAPL_DOMAIN_REG_LIMIT,
-	RAPL_DOMAIN_REG_STATUS,
-	RAPL_DOMAIN_REG_PERF,
-	RAPL_DOMAIN_REG_POLICY,
-	RAPL_DOMAIN_REG_INFO,
-	RAPL_DOMAIN_REG_MAX,
-};
-
 /* per domain data, some are optional */
-enum rapl_primitives {
-	ENERGY_COUNTER,
-	POWER_LIMIT1,
-	POWER_LIMIT2,
-	FW_LOCK,
-
-	PL1_ENABLE,  /* power limit 1, aka long term */
-	PL1_CLAMP,   /* allow frequency to go below OS request */
-	PL2_ENABLE,  /* power limit 2, aka short term, instantaneous */
-	PL2_CLAMP,
-
-	TIME_WINDOW1, /* long term */
-	TIME_WINDOW2, /* short term */
-	THERMAL_SPEC_POWER,
-	MAX_POWER,
-
-	MIN_POWER,
-	MAX_TIME_WINDOW,
-	THROTTLED_TIME,
-	PRIORITY_LEVEL,
-
-	/* below are not raw primitive data */
-	AVERAGE_POWER,
-	NR_RAPL_PRIMITIVES,
-};
-
 #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
 
-/* Can be expanded to include events, etc.*/
-struct rapl_domain_data {
-	u64 primitives[NR_RAPL_PRIMITIVES];
-	unsigned long timestamp;
-};
-
 struct msrl_action {
 	u32 msr_no;
 	u64 clear_mask;
@@ -138,60 +89,12 @@ struct msrl_action {
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
 #define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
 
-#define NR_POWER_LIMITS (2)
-struct rapl_power_limit {
-	struct powercap_zone_constraint *constraint;
-	int prim_id; /* primitive ID used to enable */
-	struct rapl_domain *domain;
-	const char *name;
-	u64 last_power_limit;
-};
-
 static const char pl1_name[] = "long_term";
 static const char pl2_name[] = "short_term";
 
-struct rapl_package;
-struct rapl_domain {
-	const char *name;
-	enum rapl_domain_type id;
-	int regs[RAPL_DOMAIN_REG_MAX];
-	struct powercap_zone power_zone;
-	struct rapl_domain_data rdd;
-	struct rapl_power_limit rpl[NR_POWER_LIMITS];
-	u64 attr_map; /* track capabilities */
-	unsigned int state;
-	unsigned int domain_energy_unit;
-	struct rapl_package *rp;
-};
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
-/* maximum rapl package domain name: package-%d-die-%d */
-#define PACKAGE_DOMAIN_NAME_LENGTH 30
-
-
-/* Each rapl package contains multiple domains, these are the common
- * data across RAPL domains within a package.
- */
-struct rapl_package {
-	unsigned int id; /* logical die id, equals physical 1-die systems */
-	unsigned int nr_domains;
-	unsigned long domain_map; /* bit map of active domains */
-	unsigned int power_unit;
-	unsigned int energy_unit;
-	unsigned int time_unit;
-	struct rapl_domain *domains; /* array of domains, sized at runtime */
-	struct powercap_zone *power_zone; /* keep track of parent zone */
-	unsigned long power_limit_irq; /* keep track of package power limit
-					* notify interrupt enable status.
-					*/
-	struct list_head plist;
-	int lead_cpu; /* one active cpu per package for access */
-	/* Track active cpus */
-	struct cpumask cpumask;
-	char name[PACKAGE_DOMAIN_NAME_LENGTH];
-};
-
 struct rapl_defaults {
 	u8 floor_freq_reg_addr;
 	int (*check_unit)(struct rapl_package *rp, int cpu);
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
new file mode 100644
index 0000000..9471603
--- /dev/null
+++ b/include/linux/intel_rapl.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Data types and headers for RAPL support
+ *
+ *  Copyright (C) 2019  Intel Corporation.
+ *
+ *  Author: Zhang Rui <rui.zhang@intel.com>
+ */
+
+#ifndef __INTEL_RAPL_H__
+#define __INTEL_RAPL_H__
+
+#include <linux/types.h>
+#include <linux/powercap.h>
+
+enum rapl_domain_type {
+	RAPL_DOMAIN_PACKAGE,	/* entire package/socket */
+	RAPL_DOMAIN_PP0,	/* core power plane */
+	RAPL_DOMAIN_PP1,	/* graphics uncore */
+	RAPL_DOMAIN_DRAM,	/* DRAM control_type */
+	RAPL_DOMAIN_PLATFORM,	/* PSys control_type */
+	RAPL_DOMAIN_MAX,
+};
+
+enum rapl_domain_reg_id {
+	RAPL_DOMAIN_REG_LIMIT,
+	RAPL_DOMAIN_REG_STATUS,
+	RAPL_DOMAIN_REG_PERF,
+	RAPL_DOMAIN_REG_POLICY,
+	RAPL_DOMAIN_REG_INFO,
+	RAPL_DOMAIN_REG_MAX,
+};
+
+struct rapl_package;
+
+enum rapl_primitives {
+	ENERGY_COUNTER,
+	POWER_LIMIT1,
+	POWER_LIMIT2,
+	FW_LOCK,
+
+	PL1_ENABLE,		/* power limit 1, aka long term */
+	PL1_CLAMP,		/* allow frequency to go below OS request */
+	PL2_ENABLE,		/* power limit 2, aka short term, instantaneous */
+	PL2_CLAMP,
+
+	TIME_WINDOW1,		/* long term */
+	TIME_WINDOW2,		/* short term */
+	THERMAL_SPEC_POWER,
+	MAX_POWER,
+
+	MIN_POWER,
+	MAX_TIME_WINDOW,
+	THROTTLED_TIME,
+	PRIORITY_LEVEL,
+
+	/* below are not raw primitive data */
+	AVERAGE_POWER,
+	NR_RAPL_PRIMITIVES,
+};
+
+struct rapl_domain_data {
+	u64 primitives[NR_RAPL_PRIMITIVES];
+	unsigned long timestamp;
+};
+
+#define NR_POWER_LIMITS (2)
+struct rapl_power_limit {
+	struct powercap_zone_constraint *constraint;
+	int prim_id;		/* primitive ID used to enable */
+	struct rapl_domain *domain;
+	const char *name;
+	u64 last_power_limit;
+};
+
+struct rapl_package;
+
+struct rapl_domain {
+	const char *name;
+	enum rapl_domain_type id;
+	int regs[RAPL_DOMAIN_REG_MAX];
+	struct powercap_zone power_zone;
+	struct rapl_domain_data rdd;
+	struct rapl_power_limit rpl[NR_POWER_LIMITS];
+	u64 attr_map;		/* track capabilities */
+	unsigned int state;
+	unsigned int domain_energy_unit;
+	struct rapl_package *rp;
+};
+
+/* maximum rapl package domain name: package-%d-die-%d */
+#define PACKAGE_DOMAIN_NAME_LENGTH 30
+
+struct rapl_package {
+	unsigned int id;	/* logical die id, equals physical 1-die systems */
+	unsigned int nr_domains;
+	unsigned long domain_map;	/* bit map of active domains */
+	unsigned int power_unit;
+	unsigned int energy_unit;
+	unsigned int time_unit;
+	struct rapl_domain *domains;	/* array of domains, sized at runtime */
+	struct powercap_zone *power_zone;	/* keep track of parent zone */
+	unsigned long power_limit_irq;	/* keep track of package power limit
+					 * notify interrupt enable status.
+					 */
+	struct list_head plist;
+	int lead_cpu;		/* one active cpu per package for access */
+	/* Track active cpus */
+	struct cpumask cpumask;
+	char name[PACKAGE_DOMAIN_NAME_LENGTH];
+};
+
+#endif /* __INTEL_RAPL_H__ */
-- 
2.7.4

