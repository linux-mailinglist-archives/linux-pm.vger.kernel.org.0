Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3332096F
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBUJkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:40:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19629 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900421; x=1645436421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jVCDdhnuw06aCDCIEgZjyZCu7hLlseyeGOL9g0H5+X0=;
  b=o/lQH0tHWhaVeFtHIWXkrfF8tinTdgpRDk0R0XIPhoBqcqmyEm8WxYY0
   crwNZAw00FYXf91x8Gx929B+9o9gWttU+vH/P1IT7MlFqo+Z4QmwMtzLP
   ZnyjXTaDP6HlloSwgfAh9SPQvuWwo2LEMeNmevTFGWECf/ouS2WO67Cls
   afmczM5UT2gK2SJD30BH3VMUTRStQjHnd9jUNg5ZU9ASb9Lf87yGu563N
   ytW57/II6DAXb6Tnpj/hOGzHSqD2CPZWQTKOglkXoSyo5eFOMzNu8vZnX
   AKhTFTFYhbOOdJLBJHqwUECMd/yviPEggxMRcqc8dujCwbsn+gqNJpdcH
   Q==;
IronPort-SDR: FYdXMaU+P3kMf5yISspT2tfFrN0PPQ6xp4PYlFvORYaOlGpUFKqk0tUlV2I1mYsG+kZaGUxhuX
 WifaHxfI7OoJBM/vjBAOBSMN26cY/GZ49hbEMyK56oYEreBikC5gWHtJmcieZh8F9mEhYyCPFi
 JuQZY+9ogxHWb74ghKoUVDn0YNxrTm7TFPxRQwDSOWswlqKLla/wK0QX/+QC7JahYw3MbsLlkm
 I9d2cOcrk6SLt/81+qwfq9T69J74rQ1eSyZlsXSQrpUhv9j9GhJA168jlMFhZg1CaHmWNoQEVu
 4Tc=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="164916443"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:39:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNJmXKIpFvIyVlhPalcxsx7ZciTEovDrXjo0DJ7T0Urs+xjFZ0qU7ZeIyrhMkwAiDe7UOhNjRpxoObZykOqbKo3bwKx6dsaUW8t5Lv2vtqMF679RK9HskwizC102GYJrVYcgK5JBCbAzzuT2E/z77UjEk3tUTJ+1zICw26Lx+lCMWIeMdcBDgSKGA0lBCcyqhSOeBG5xMSCi54dgGMnAWWSiVJCdisoh3ZvI/Q2fFlRGKJZSVX3Y12d/moX23myggl+YyEE1+zN7yCMWHTIX0s5P/SNVdlbwqQWgmj4Omi+ncUksuIVd+YqUT1iTgklCPvkM3NhkD9uLxATul7c5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HstTyCZsxss865SbjQ0W4UysSn21AXFmC2SJiLuKFdU=;
 b=NbZtQsPRw8BZ30AxLRx8Jq3YjH1gY9BY61QVbEExmXSfZ2tKU2e5i+MrOcp0Q9QOIjHL8qu+2+VxZ8HojBrxUrxYVWwmv5hzS4ont1RawsjO1ilFZDOlVrca8WG2s64sPBysWigrnty8UUntumrOUYFWPTXY2MzpShpnmlv12IbM1oH+MQSKN1IWO4gq8Li8/uYvrh4JGLmT+ElVQ6o24IdKQMCkQ1HPET03L5me+eu5nAqzrOKv6usW+4oxepR7Ec1/ZRNFUNETF/aYuISkmhQze9hUj0nqZXppWMl53hgpU9lDpZKqU8dWSORxHBBOTdQWfmq9SnmpUhAHs9TzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HstTyCZsxss865SbjQ0W4UysSn21AXFmC2SJiLuKFdU=;
 b=I4xsFC9BeypYyIVXmNg81Ibk55O3d6w80nhS6GcdavWGBU7Ielz89A/9qeNZr9Y4x43h2OoNMp91g0IRVz6bQbqpMvrgr8cYdzKFPQIGkfyDl4WkpQ7pat36fOMoqFWe9ubUWd54iK0y2BO37ThQrEiG++5t8bIhE4HyyDm5diI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:39:06 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:39:06 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH 6/8] cpuidle: Add RISC-V SBI CPU idle driver
Date:   Sun, 21 Feb 2021 15:07:56 +0530
Message-Id: <20210221093758.210981-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221093758.210981-1-anup.patel@wdc.com>
References: <20210221093758.210981-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.12]
X-ClientProxiedBy: MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:39:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7429e729-5265-4a59-8faa-08d8d64c882a
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459ECCF5BC3F2C512BBABA78D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP/j7LxITp7NbTAJWu6ov4diiio+2Tr8eA7A2RtRS4yXXygyPlis73k5eWrcZbKp1hfZmvTBT4oPzfAdgZDby+UrAtZMio6KuZZWuYLdXLTHxN8ofpKqrkyimE9PELY08MSVSXILsy/1qLF/fz3gBpgjmieawgqwdtv5LEYbv0MvyYUwPzGkCHmfnl/ocynl/MscAx2sAlC2K0Kc83HwFwJqqKf8blhfe5moysT1SNAaWu+GvrC1FqJ1jOroWziiYXosMpjVbd5CMxjOO5CUkUZOMjv9QVmbsUWvJ3ckXjKy+pkMbbU/K9LO67ZLx4+gP8hGbrM6xbJPuITW1+gyn2W5TghCUx43vAH+dh5SY5iTG95B+hJAN0510LcEify8u0mxVRrooq92RbvrrS+ZRj3wks+rfrpyCxKpJj6XIVLCqbve3DKbSvzOJ5dbm/KJ1S3JT16eNgdLDj0KOhrUO6hInCb4WYGbQQjqcg56qvglCS+ye/Kg8YYDpKhkFb9ZgF1mBMIvx2LTig1/qVVYkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(5660300002)(54906003)(110136005)(30864003)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uPhTB86Yn7qmVIfui/vc6QzGnb4fBB7CEkSiVHcLNnE3XsLrnOVaSkXr8+A5?=
 =?us-ascii?Q?O9WTCjL3HoM7WD2/IC6N1AOzgUZOl7UEID0MvpR2x5YMzvSHJvYoQBZt7tNm?=
 =?us-ascii?Q?R1v8p4S/U/TejVJuDNfgSWgamQs8G5tBROO1zAuSh38E7JH3cFEhHcyMnHPl?=
 =?us-ascii?Q?YPugsojoPBfY1zP8wIrKWfR0yzy4hT1pyPBtFveIERk3EpIi9/L08etLO/6z?=
 =?us-ascii?Q?r9K0zcBHW+g5dzG/VPo+GCjaXDZxm0wFBIxLcVwXMVNaCPRhm3MpwCeeFbW6?=
 =?us-ascii?Q?XqDLoJ9Gtejjx7PJm2M/ZAxQpTSWIqzjO9RoMC0QGTCGrrnHinV1Ggd6L/b5?=
 =?us-ascii?Q?+iJXq1KZQRfgXx34cDl373oEvSJny2Q6jab+3/j56Xb4ihtBZMwPCkHTlzOW?=
 =?us-ascii?Q?YcCjDEC4937XW+Z9/9FQcV6PAb4vLOd17/cXp0bS4+mrVFpjYaKvhdMh0EuT?=
 =?us-ascii?Q?EjnLdO4rqUtVcewU4nHdwb4j66FIuJUyQBcVbZsPnq6iY3I6OhxevfuoB/qg?=
 =?us-ascii?Q?WMM6XcjtibnHKTkK/kMOQpwa4s8XGqqFvTv/WhYiszk8KmREhOW3BIJHDPKL?=
 =?us-ascii?Q?WEZg2AYdLJ5NxsLvvGftGQ1VSJ9KoufAzivORGw9N6V9IUAf1yEMI2OcrSaO?=
 =?us-ascii?Q?BGITfZqylA9npvCy1K4Lr5HfXUI4lppgwqgj0myGHGJrY0TLilADmGBpgYrU?=
 =?us-ascii?Q?b2tjqQ8j3ukPm5272qtA4aJJ+LoRdcLFgcYfUDPf5fyPMQqBQZr92BmNId3h?=
 =?us-ascii?Q?MOmRO3URbQ5nMdlgWOGuwtRvYXtpA/g89hgZtvFlxATWFx4LqNh3OMKQo6CN?=
 =?us-ascii?Q?V0j3E/f2PoMxytoNaUHNh2FDBgQhS30FNOzLEdJQcKggDfM4lbPsrUaXCHPm?=
 =?us-ascii?Q?j24CavBVlBG4Bu5BvNwoKggVXH8cnPlfpqYdryfU8HBCHa9kjasX6y19i0nq?=
 =?us-ascii?Q?AkXwn+Iaqrmes6DmX+xUOHaH5on1NvJMpAKEtQaNFBHOVh5tcjhSFJ4ysnbr?=
 =?us-ascii?Q?QhAJCgYn+p5bseeMCy8V5p4VZMKO066Wkz424qh55fdukAy1D8eo6anmbQgL?=
 =?us-ascii?Q?7JgypQNMoEhyg/JRF2318MWA0ugQD8xaPmj1TaEXcPcW5yrP0BnYuoOy4cNu?=
 =?us-ascii?Q?/EpWr+a0lUrCgreVZUn+L4+GUxTGWizEmaa5BhxBd0oOHgaJdpy2wbnyJAdP?=
 =?us-ascii?Q?2An0HE8RLpKmiErmCqdOvER7Dj3ff+PuVl5fVf2ue0kt15liSOkP+1MJCyq2?=
 =?us-ascii?Q?scEIyeaXViZIP3G3nMtN6R9ekhNoOK8GK7Qcxixu4GdnxYbUlri9qQsi9yIf?=
 =?us-ascii?Q?JCFwZirWW2dFfngj+xayTD1S?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7429e729-5265-4a59-8faa-08d8d64c882a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:39:06.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrNXpTVwHFBCLuYA4oqHzXzLp2J9DEAQXzVj3TX41RW2Wcu4hyzBx9FlVOml23fljY5LscInzLTtS8H5Jg1QlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RISC-V SBI HSM extension provides HSM suspend call which can
be used by Linux RISC-V to enter platform specific low-power state.

This patch adds a CPU idle driver based on RISC-V SBI calls which
will populate idle states from device tree and use SBI calls to
entry these idle states.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 MAINTAINERS                   |   8 +
 drivers/cpuidle/Kconfig       |   5 +
 drivers/cpuidle/Kconfig.riscv |  15 +
 drivers/cpuidle/Makefile      |   4 +
 drivers/cpuidle/cpuidle-sbi.c | 503 ++++++++++++++++++++++++++++++++++
 5 files changed, 535 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-sbi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 667d03852191..eeeab188a8ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4641,6 +4641,14 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 
+CPUIDLE DRIVER - RISC-V SBI
+M:	Anup Patel <anup.patel@wdc.com>
+R:	Sandeep Tripathy <milun.tripathy@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	drivers/cpuidle/cpuidle-sbi.c
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f1afe7ab6b54..ff71dd662880 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -66,6 +66,11 @@ depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
 endmenu
 
+menu "RISC-V CPU Idle Drivers"
+depends on RISCV
+source "drivers/cpuidle/Kconfig.riscv"
+endmenu
+
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
 	depends on X86 && KVM_GUEST
diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
new file mode 100644
index 000000000000..78518c26af74
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.riscv
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RISC-V CPU Idle drivers
+#
+
+config RISCV_SBI_CPUIDLE
+	bool "RISC-V SBI CPU idle Driver"
+	depends on RISCV_SBI
+	select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	select DT_IDLE_GENPD if PM_GENERIC_DOMAINS_OF
+	help
+	  Select this option to enable RISC-V SBI firmware based CPU idle
+	  driver for RISC-V systems. This drivers also supports hierarchical
+	  DT based layout of the idle state.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 11a26cef279f..a36922c18510 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -35,3 +35,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
+
+###############################################################################
+# RISC-V drivers
+obj-$(CONFIG_RISCV_SBI_CPUIDLE)		+= cpuidle-sbi.o
diff --git a/drivers/cpuidle/cpuidle-sbi.c b/drivers/cpuidle/cpuidle-sbi.c
new file mode 100644
index 000000000000..abbcabca0e91
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sbi.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V SBI CPU idle driver.
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "cpuidle-sbi: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpu_cooling.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <asm/cpuidle.h>
+#include <asm/sbi.h>
+#include <asm/suspend.h>
+
+#include "dt_idle_states.h"
+#include "dt_idle_genpd.h"
+
+struct sbi_cpuidle_data {
+	u32 *states;
+	struct device *dev;
+};
+
+struct sbi_domain_state {
+	bool available;
+	u32 state;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct sbi_cpuidle_data, sbi_cpuidle_data);
+static DEFINE_PER_CPU(struct sbi_domain_state, domain_state);
+static bool sbi_cpuidle_use_osi;
+static bool sbi_cpuidle_use_cpuhp;
+static bool sbi_cpuidle_pd_allow_domain_state;
+
+static inline void sbi_set_domain_state(u32 state)
+{
+	struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
+
+	data->available = true;
+	data->state = state;
+}
+
+static inline u32 sbi_get_domain_state(void)
+{
+	struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
+
+	return data->state;
+}
+
+static inline void sbi_clear_domain_state(void)
+{
+	struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
+
+	data->available = false;
+}
+
+static inline bool sbi_is_domain_state_available(void)
+{
+	struct sbi_domain_state *data = this_cpu_ptr(&domain_state);
+
+	return data->available;
+}
+
+static int sbi_suspend_finisher(unsigned long suspend_type,
+				unsigned long resume_addr,
+				unsigned long opaque)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
+			suspend_type, resume_addr, opaque, 0, 0, 0);
+
+	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
+}
+
+static int sbi_suspend(u32 state)
+{
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return cpu_suspend(state, sbi_suspend_finisher);
+	else
+		return sbi_suspend_finisher(state, 0, 0);
+}
+
+static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int idx)
+{
+	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
+
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
+}
+
+static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx,
+					  bool s2idle)
+{
+	struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
+	u32 *states = data->states;
+	struct device *pd_dev = data->dev;
+	u32 state;
+	int ret;
+
+	ret = cpu_pm_enter();
+	if (ret)
+		return -1;
+
+	/* Do runtime PM to manage a hierarchical CPU toplogy. */
+	rcu_irq_enter_irqson();
+	if (s2idle)
+		dev_pm_genpd_suspend(pd_dev);
+	else
+		pm_runtime_put_sync_suspend(pd_dev);
+	rcu_irq_exit_irqson();
+
+	if (sbi_is_domain_state_available())
+		state = sbi_get_domain_state();
+	else
+		state = states[idx];
+
+	ret = sbi_suspend(state) ? -1 : idx;
+
+	rcu_irq_enter_irqson();
+	if (s2idle)
+		dev_pm_genpd_resume(pd_dev);
+	else
+		pm_runtime_get_sync(pd_dev);
+	rcu_irq_exit_irqson();
+
+	cpu_pm_exit();
+
+	/* Clear the domain state to start fresh when back from idle. */
+	sbi_clear_domain_state();
+	return ret;
+}
+
+static int sbi_enter_domain_idle_state(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int idx)
+{
+	return __sbi_enter_domain_idle_state(dev, drv, idx, false);
+}
+
+static int sbi_enter_s2idle_domain_idle_state(struct cpuidle_device *dev,
+					      struct cpuidle_driver *drv,
+					      int idx)
+{
+	return __sbi_enter_domain_idle_state(dev, drv, idx, true);
+}
+
+static int sbi_cpuidle_cpuhp_up(unsigned int cpu)
+{
+	struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
+
+	if (pd_dev)
+		pm_runtime_get_sync(pd_dev);
+
+	return 0;
+}
+
+static int sbi_cpuidle_cpuhp_down(unsigned int cpu)
+{
+	struct device *pd_dev = __this_cpu_read(sbi_cpuidle_data.dev);
+
+	if (pd_dev) {
+		pm_runtime_put_sync(pd_dev);
+		/* Clear domain state to start fresh at next online. */
+		sbi_clear_domain_state();
+	}
+
+	return 0;
+}
+
+static void sbi_idle_init_cpuhp(void)
+{
+	int err;
+
+	if (!sbi_cpuidle_use_cpuhp)
+		return;
+
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
+					"cpuidle/sbi:online",
+					sbi_cpuidle_cpuhp_up,
+					sbi_cpuidle_cpuhp_down);
+	if (err)
+		pr_warn("Failed %d while setup cpuhp state\n", err);
+}
+
+static const struct of_device_id sbi_cpuidle_state_match[] = {
+	{ .compatible = "riscv,idle-state",
+	  .data = sbi_cpuidle_enter_state },
+	{ },
+};
+
+static bool sbi_suspend_state_is_valid(u32 state)
+{
+	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
+	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
+		return false;
+	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
+	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
+		return false;
+	return true;
+}
+
+static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
+{
+	int err = of_property_read_u32(np, "riscv,sbi-suspend-param", state);
+
+	if (err) {
+		pr_warn("%pOF missing riscv,sbi-suspend-param property\n", np);
+		return err;
+	}
+
+	if (!sbi_suspend_state_is_valid(*state)) {
+		pr_warn("Invalid SBI suspend state %#x\n", *state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sbi_dt_cpu_init_topology(struct cpuidle_driver *drv,
+				     struct sbi_cpuidle_data *data,
+				     unsigned int state_count, int cpu)
+{
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (!sbi_cpuidle_use_osi)
+		return 0;
+
+	data->dev = dt_idle_genpd_attach_cpu(cpu, "sbi");
+	if (IS_ERR_OR_NULL(data->dev))
+		return PTR_ERR_OR_ZERO(data->dev);
+
+	/*
+	 * Using the deepest state for the CPU to trigger a potential selection
+	 * of a shared state for the domain, assumes the domain states are all
+	 * deeper states.
+	 */
+	drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
+	drv->states[state_count - 1].enter_s2idle = sbi_enter_s2idle_domain_idle_state;
+	sbi_cpuidle_use_cpuhp = true;
+
+	return 0;
+}
+
+static int sbi_cpuidle_dt_init_states(struct device *dev,
+					struct cpuidle_driver *drv,
+					unsigned int cpu,
+					unsigned int state_count)
+{
+	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
+	struct device_node *state_node;
+	struct device_node *cpu_node;
+	u32 *states;
+	int i, ret;
+
+	cpu_node = of_cpu_device_node_get(cpu);
+	if (!cpu_node)
+		return -ENODEV;
+
+	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	/* Parse SBI specific details from state DT nodes */
+	for (i = 1; i < state_count; i++) {
+		state_node = of_get_cpu_state_node(cpu_node, i - 1);
+		if (!state_node)
+			break;
+
+		ret = sbi_dt_parse_state_node(state_node, &states[i]);
+		of_node_put(state_node);
+
+		if (ret)
+			return ret;
+
+		pr_debug("sbi-state %#x index %d\n", states[i], i);
+	}
+	if (i != state_count) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	/* Initialize optional data, used for the hierarchical topology. */
+	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);
+	if (ret < 0)
+		return ret;
+
+	/* Store states in the per-cpu struct. */
+	data->states = states;
+
+fail:
+	of_node_put(cpu_node);
+
+	return ret;
+}
+
+static void sbi_cpuidle_deinit_cpu(int cpu)
+{
+	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
+
+	dt_idle_genpd_detach_cpu(data->dev);
+	sbi_cpuidle_use_cpuhp = false;
+}
+
+static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
+{
+	struct cpuidle_driver *drv;
+	unsigned int state_count = 0;
+	int ret = 0;
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->name = "sbi_cpuidle";
+	drv->owner = THIS_MODULE;
+	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+
+	/* RISC-V architectural WFI to be represented as state index 0. */
+	drv->states[0].enter = sbi_cpuidle_enter_state;
+	drv->states[0].exit_latency = 1;
+	drv->states[0].target_residency = 1;
+	drv->states[0].power_usage = UINT_MAX;
+	strcpy(drv->states[0].name, "WFI");
+	strcpy(drv->states[0].desc, "RISC-V WFI");
+
+	/*
+	 * If no DT idle states are detected (ret == 0) let the driver
+	 * initialization fail accordingly since there is no reason to
+	 * initialize the idle driver if only wfi is supported, the
+	 * default archictectural back-end already executes wfi
+	 * on idle entry.
+	 */
+	ret = dt_init_idle_driver(drv, sbi_cpuidle_state_match, 1);
+	if (ret <= 0) {
+		pr_debug("HART%ld: failed to parse DT idle states\n",
+			 cpuid_to_hartid_map(cpu));
+		return ret ? : -ENODEV;
+	}
+	state_count = ret + 1; /* Include WFI state as well */
+
+	/* Initialize idle states from DT. */
+	ret = sbi_cpuidle_dt_init_states(dev, drv, cpu, state_count);
+	if (ret) {
+		pr_err("HART%ld: failed to init idle states\n",
+		       cpuid_to_hartid_map(cpu));
+		return ret;
+	}
+
+	ret = cpuidle_register(drv, NULL);
+	if (ret)
+		goto deinit;
+
+	cpuidle_cooling_register(drv);
+
+	return 0;
+deinit:
+	sbi_cpuidle_deinit_cpu(cpu);
+	return ret;
+}
+
+static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+	u32 *pd_state;
+
+	if (!state->data)
+		return 0;
+
+	if (!sbi_cpuidle_pd_allow_domain_state)
+		return -EBUSY;
+
+	/* OSI mode is enabled, set the corresponding domain state. */
+	pd_state = state->data;
+	sbi_set_domain_state(*pd_state);
+
+	return 0;
+}
+
+static void sbi_cpuidle_domain_sync_state(struct device *dev)
+{
+	/*
+	 * All devices have now been attached/probed to the PM domain
+	 * topology, hence it's fine to allow domain states to be picked.
+	 */
+	sbi_cpuidle_pd_allow_domain_state = true;
+}
+
+static struct dt_idle_genpd_ops sbi_genpd_ops = {
+	.parse_state_node = sbi_dt_parse_state_node,
+};
+
+static int sbi_cpuidle_probe(struct platform_device *pdev)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv;
+	struct cpuidle_device *dev;
+	struct device_node *np, *pds_node;
+
+	/* Detect OSI support based on CPU DT nodes */
+	sbi_cpuidle_use_osi = true;
+	for_each_possible_cpu(cpu) {
+		np = of_cpu_device_node_get(cpu);
+		if (np &&
+		    of_find_property(np, "power-domains", NULL) &&
+		    of_find_property(np, "power-domain-names", NULL)) {
+			continue;
+		} else {
+			sbi_cpuidle_use_osi = false;
+			break;
+		}
+	}
+
+	if (sbi_cpuidle_use_osi)
+		sbi_genpd_ops.power_off = sbi_cpuidle_pd_power_off;
+
+	/* Populate generic power domains from DT nodes */
+	pds_node = of_find_node_by_path("/cpus/sbi-power-domains");
+	if (pds_node) {
+		ret = dt_idle_genpd_probe(&sbi_genpd_ops, pds_node);
+		of_node_put(pds_node);
+		if (ret)
+			return ret;
+	}
+
+	/* Initialize CPU idle driver for each CPU */
+	for_each_possible_cpu(cpu) {
+		ret = sbi_cpuidle_init_cpu(&pdev->dev, cpu);
+		if (ret) {
+			pr_debug("HART%ld: idle driver init failed\n",
+				 cpuid_to_hartid_map(cpu));
+			goto out_fail;
+		}
+	}
+
+	/* Setup CPU hotplut notifiers */
+	sbi_idle_init_cpuhp();
+
+	pr_info("idle driver registered for all CPUs\n");
+
+	return 0;
+
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		drv = cpuidle_get_cpu_driver(dev);
+		cpuidle_unregister(drv);
+		sbi_cpuidle_deinit_cpu(cpu);
+	}
+
+	return ret;
+}
+
+static struct platform_driver sbi_cpuidle_driver = {
+	.probe = sbi_cpuidle_probe,
+	.driver = {
+		.name = "sbi-cpuidle",
+		.sync_state = sbi_cpuidle_domain_sync_state,
+	},
+};
+
+static int __init sbi_cpuidle_init(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	/*
+	 * The SBI HSM suspend function is only available when:
+	 * 1) SBI HSM extension is available
+	 * 2) SBI version is 0.3 or higher
+	 */
+	if (sbi_major_version() < 0 ||
+	    sbi_minor_version() < 3 ||
+	    sbi_probe_extension(SBI_EXT_HSM) <= 0) {
+		pr_info("HSM suspend not available\n");
+		return 0;
+	}
+
+	ret = platform_driver_register(&sbi_cpuidle_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple("sbi-cpuidle",
+						-1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&sbi_cpuidle_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+device_initcall(sbi_cpuidle_init);
-- 
2.25.1

