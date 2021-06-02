Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD95398816
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhFBL0I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:26:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27614 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhFBL0G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633064; x=1654169064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=17vf1DRJhsFJsGqgZNTJlVplkmAQvsSFXxgGbfcQWrI=;
  b=nUZTu3o8MsQHrgOxHhdO6YXD1EAvkvoxuEILEdUHe74Xkg1TvFV0cdCf
   h+rO/X6W9SNXAB9jXby9D/C5WHoRj9tnqC1zTUD8uZVsPq+eL8Ut7sAm2
   jgeIBDF3UKx8h6ljgbsiqjHVma1YTOLq+zwOQI8Qk9HNJinweTFR0k8kS
   hjk667JrLWIslM8Ylb5+4bfdyMZCM0XJHageo371FbARRQH3fsF2CigG8
   uLC6+FvPd+thBj9OaAUAavbV8ifspHXchXdlI9rg1y+4Bpan6vLgjYQVw
   HOsYMzF3ol+2BNuLMCSnbqkdmqxRf3LjGnBZ60dnd1UoA7SILXWcedqfo
   A==;
IronPort-SDR: xvn0o02AOaVRpb0Yl0heZTTz1vANsIo+6OIxFsJDt5dcYUGU/TfU6wg3bo+t7j+MZNCsU0YrGp
 9xodfusxeViQJT3G0JhjFJ9XCywkHvBHZItFfbCY6TxYVO/2l10C5XhSZ9KIDUn6MjdaRJs5fy
 U8IXUlT20IIsa0cT8/XwEZ/hmmHf/cte4u47MgwVTlvDumyPFbG1KLa9lnUK8Vp8/UydtJakrL
 6r89n8Fq7/DSMd1Xg269+GTcVaT3JRnJBe/GNwiLXZmdEoO3KQMVu1++J2h5z6pyXfr2ihIq0u
 86M=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803682"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5fCT40p7edaIrPk8qxokWY1MSUhaczy/7W9GhiIqT+TOEiAVxF1f8e7ermFHsBtFgfPnDgQPpS4ziY1ebNNV10nA3yNJcD8v97+3HSjXgfwGeHC2ItGbqu2sIr6LOpPQQ+JmHeOcNIkbw+0R4ltnk0b+kb68/o8KNTYLN92BJ96LF4rJN33K19NiQYULuyVB3OIG1Z9ekpFNXCRtW2vd2mCQ8s6A/uEjCnhFErAZ7SZqxFM0O1XKnQ3FXHOsPFuKDXRybQLP+taXru1HZpg5Jr9Z7CEICFjETFBJkNCvKXNS61aD3NxFwSTDIddMEbDFEVF5DI502auzMrM19p2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjLmUz75445HyNBinzbk5M8o3LLpMojsQc2E52o+xMM=;
 b=iTZsoE4jXp+v7avHneCEJCCW8WIMk00Jf2z9d8exYFM2ugSFgPGX2g0soA2i7BsKPrZH+hAhX6HkKKBFELZ9Uvy06NKz2SqR+afLLl+Oy6zTUHvsunKpwY9oX/Q2MsU9FEEnyNZM9zamIVAT2z/Ja64xXebzcc7ioUN5r6Ebn9HRBUiK5pkbRPxQ+3ewspqUE0GEVhWekvB9oeHWFNGU5sFk/qDqjvE/RbTmcKZ1Ey+pTxjyaHNhu5K1Tfa9DWewAtws2K9LatA6h3wBWGj+h1HzIdOnzwW2Bhji1QyDwSY6klu5biLd2Cfh+yskHpPjPCtZ3ZGV0QgBS2BCYq0jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjLmUz75445HyNBinzbk5M8o3LLpMojsQc2E52o+xMM=;
 b=yz5E7h12I0U7kqAm49SIP6zmMs7SWNHBx2LhaTrJh7Ni1+jzFLxupKWB1ZG8ctOfeiIeLE9pZpx9FQLBBkRwEIZIlQ13sLqHLWc3K5yC+6QKRWlaZAuDoeYCD2PjtuUtI60ocDPpz4gCi7qUTsb8nIfywuwVmIljc4lTljFjDnU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 11:24:22 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:22 +0000
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
Subject: [PATCH v5 6/8] cpuidle: Add RISC-V SBI CPU idle driver
Date:   Wed,  2 Jun 2021 16:53:19 +0530
Message-Id: <20210602112321.2241566-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602112321.2241566-1-anup.patel@wdc.com>
References: <20210602112321.2241566-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.70.115]
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6ddc924-8f8b-4cba-ac03-08d925b8f83a
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB774774A9C931F6843B39515E8D3D9@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEikm16zMw2pd7Pq3zs87VprnU7PC4DlNuYaqfh6+hoZ2anEx8VLWvh0Zjdx4xsLdmambMX/mYjsuEG6WORvGeIVpYyS91CyS+CNiWqjd4OvYphVsI3Trxvo87BsJtfxgEULTuMCgGk4RMUFQevqjJKqtuD8MVJCXs0rVvkdaZe1bbCZXPmjTyfKdKGUIU3zAa8EvCs5cS770cKQxQF/1YvhZMcU2h35GMkprB6jY24D9lj2L963ohO5U3Bb8BD/NHcX19AqrNJtzsdHTKK/k46X/tNC/HfYmP1ftmYlOpMHTLX92e6MhIqg3lw1xkvPAuFgJwDX7tXy0nCyBph/tk5/0++xIRQse7NmHychU1r3J14fgnQNrmid8XxJJz5+rc6M3lwDgFRA+O46EOn/xB6enY8I/mbgpFC2qxMSLzVPTwYXPUscrCbi7pEjPkij3vy8yKUta7NJYUNbFavrV8Nat8ybOrT5QcSxKC85fXoWGYsApmsWUi4AY25S4UvXdPIM+Vs+yCPrR9saU+fzG4uP3rtEZpRmBdbqiSqVrIMNrp9wTDClel5Lxi1ULgk6/ftszXB/6HJAkQsB6hTMOqBwXklHqfqhp1YWHuDsqOLr1OKuth/slrbetffrpmJF9MfTUO2TX/siJGP2g8Fjzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(52116002)(7696005)(36756003)(8936002)(86362001)(38100700002)(83380400001)(66476007)(30864003)(55016002)(110136005)(316002)(54906003)(26005)(4326008)(956004)(44832011)(1076003)(2616005)(8886007)(478600001)(186003)(16526019)(7416002)(66946007)(5660300002)(8676002)(38350700002)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BSbgTeW0AVMP1H+Nd5UWK5St1tuwCUP0VVP8DB5Ty2YZwWLfubD6Bh2SwT9E?=
 =?us-ascii?Q?VEFwtRS926+YiomBzNvNINolUYUyFnWwpOqLZGrdnSKsdpcTFT0cIuHMo/dP?=
 =?us-ascii?Q?g1VaLJf2+adgV2VwMgCdBBIk6xnjWPXPiuYY/4N+5XJfJhHJLGRyTdKsulJy?=
 =?us-ascii?Q?4wXA34PQlvVBEBjjXexi3JRY/vM3AaoJXZWwIkRIdYDXatmNiI+QbGn+Fnbb?=
 =?us-ascii?Q?CI9UarjLs7oPwWt9GGazu3CFiiqEd/xBqTmumpbUNLLQrAvb5BS50Sd/U0gL?=
 =?us-ascii?Q?2k7Ko8wh/pB0kfFstUzkbOjmTf9LirAgItD6zvg0AjXNz8+kya4VcnfD87Bd?=
 =?us-ascii?Q?SSTp4nBsVrXz+rdaNJQqNgyxW25FZR3HjhTwKZhqT0vKMYVYkMJDK2a6A4Qd?=
 =?us-ascii?Q?Dvqu7Lm5ZCIcZE/zG8MtwjwVGcsVteh1/RUNVW7rmXRc5vDGF14rgZNKIX1i?=
 =?us-ascii?Q?dL42fmdCSBpaOLDp2fDDM7/pQrDCg8cL7bG5NlXhYsMjW5/nPzHm74K6oZ3/?=
 =?us-ascii?Q?cJEwKdgnfKeZtfFvJunSxnddz0SZcCbvUOMZpva3sAIjfWgBcg1E3Nvihi5T?=
 =?us-ascii?Q?TDyDusRavv2n0YMjMZWQmcZRJCChwAph8LlL18ujLmNziSdEgqLzHFjc0r5F?=
 =?us-ascii?Q?WCcRZM0a2GKC9hKdc5qYybFs0BYXQGBNOq8+Px6oLnHO8F+/GmndScIxWz95?=
 =?us-ascii?Q?yUWwRKOhZkKaZe9wPCFc27fG20fDCWQkEDpWutH3oABC9TOiPgY1ug/DQpED?=
 =?us-ascii?Q?XXASMV1CMtNXtap5DF1hi05NjuIzimXpILeJRObUS1LpVXYg22/VZXdl3G7U?=
 =?us-ascii?Q?7KOfWqptkAy2Qcxq9OALlPAG0rsKOfL2TrD0DhV4Z5YCI4u5sLgDCZMKsXAl?=
 =?us-ascii?Q?F0BQp3ELgor6rqJvvGOa7J6AzFFX5RHAc8zzLFYTRHKSAS4lAZ0ZMHwNzhzR?=
 =?us-ascii?Q?DjEezJr212srOiHMuoDWYjgqZaaDJnTHszIsXDLb09IExXSO3ODNvbafhk+X?=
 =?us-ascii?Q?Ua062vNDt4O1wj/zuaxga+JuK7DJ+QWVXcNaCY+uPSSKrFNAxhNsQVyMC+8M?=
 =?us-ascii?Q?3hRPfdGQ4M2KoPwPHIsQnZxZrXmozCFyVeSiZopgQkWk7HNyUVo/W8t6//io?=
 =?us-ascii?Q?OXlC648bIZWr6+xqtdKnFhelmv2WScrkKrrKT3o/5avT/6pyf30oXN8HTRI8?=
 =?us-ascii?Q?p6LVQhKDJyJeDvjKVi/0DK+ovH4h4XMvNL2AxyOEkLU/MJjAJYj3wZIZRWfA?=
 =?us-ascii?Q?wVTkq10S09asgc/T0TpNPeDoKk3eWm8z6UA9DNKsIcjpffLVrPagDdP+Tscu?=
 =?us-ascii?Q?nFo6MjW+XAu/3xic3r0qqvnr?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ddc924-8f8b-4cba-ac03-08d925b8f83a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:22.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53f4kNH9ey0Q1Q7hSAqhUDZqdNmOpaPUE56TTOmZy8fofrRWXFvun2AYh3jU4JBNrFjdYuiuRV/32jF0VTB9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
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
 MAINTAINERS                   |   7 +
 drivers/cpuidle/Kconfig       |   5 +
 drivers/cpuidle/Kconfig.riscv |  15 +
 drivers/cpuidle/Makefile      |   4 +
 drivers/cpuidle/cpuidle-sbi.c | 626 ++++++++++++++++++++++++++++++++++
 5 files changed, 657 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-sbi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa4bed38b790..64af5e4be6ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4795,6 +4795,13 @@ S:	Supported
 F:	drivers/cpuidle/dt_idle_genpd.c
 F:	drivers/cpuidle/dt_idle_genpd.h
 
+CPUIDLE DRIVER - RISC-V SBI
+M:	Anup Patel <anup.patel@wdc.com>
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
index 000000000000..f743684d07de
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sbi.c
@@ -0,0 +1,626 @@
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
+	data->dev = dt_idle_attach_cpu(cpu, "sbi");
+	if (IS_ERR_OR_NULL(data->dev))
+		return PTR_ERR_OR_ZERO(data->dev);
+
+	/*
+	 * Using the deepest state for the CPU to trigger a potential selection
+	 * of a shared state for the domain, assumes the domain states are all
+	 * deeper states.
+	 */
+	drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
+	drv->states[state_count - 1].enter_s2idle =
+					sbi_enter_s2idle_domain_idle_state;
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
+	dt_idle_detach_cpu(data->dev);
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
+#ifdef CONFIG_DT_IDLE_GENPD
+
+struct sbi_pd_provider {
+	struct list_head link;
+	struct device_node *node;
+};
+
+static LIST_HEAD(sbi_pd_providers);
+
+static int sbi_pd_init(struct device_node *np)
+{
+	struct generic_pm_domain *pd;
+	struct sbi_pd_provider *pd_provider;
+	struct dev_power_governor *pd_gov;
+	int ret = -ENOMEM, state_count = 0;
+
+	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
+	if (!pd)
+		goto out;
+
+	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
+	if (!pd_provider)
+		goto free_pd;
+
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+
+	/* Allow power off when OSI is available. */
+	if (sbi_cpuidle_use_osi)
+		pd->power_off = sbi_cpuidle_pd_power_off;
+	else
+		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+
+	/* Use governor for CPU PM domains if it has some states to manage. */
+	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+
+	ret = pm_genpd_init(pd, pd_gov, false);
+	if (ret)
+		goto free_pd_prov;
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	pd_provider->node = of_node_get(np);
+	list_add(&pd_provider->link, &sbi_pd_providers);
+
+	pr_debug("init PM domain %s\n", pd->name);
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_pd_prov:
+	kfree(pd_provider);
+free_pd:
+	dt_idle_pd_free(pd);
+out:
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
+	return ret;
+}
+
+static void sbi_pd_remove(void)
+{
+	struct sbi_pd_provider *pd_provider, *it;
+	struct generic_pm_domain *genpd;
+
+	list_for_each_entry_safe(pd_provider, it, &sbi_pd_providers, link) {
+		of_genpd_del_provider(pd_provider->node);
+
+		genpd = of_genpd_remove_last(pd_provider->node);
+		if (!IS_ERR(genpd))
+			kfree(genpd);
+
+		of_node_put(pd_provider->node);
+		list_del(&pd_provider->link);
+		kfree(pd_provider);
+	}
+}
+
+static int sbi_genpd_probe(struct device_node *np)
+{
+	struct device_node *node;
+	int ret = 0, pd_count = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	/*
+	 * Parse child nodes for the "#power-domain-cells" property and
+	 * initialize a genpd/genpd-of-provider pair when it's found.
+	 */
+	for_each_child_of_node(np, node) {
+		if (!of_find_property(node, "#power-domain-cells", NULL))
+			continue;
+
+		ret = sbi_pd_init(node);
+		if (ret)
+			goto put_node;
+
+		pd_count++;
+	}
+
+	/* Bail out if not using the hierarchical CPU topology. */
+	if (!pd_count)
+		goto no_pd;
+
+	/* Link genpd masters/subdomains to model the CPU topology. */
+	ret = dt_idle_pd_init_topology(np);
+	if (ret)
+		goto remove_pd;
+
+	return 0;
+
+put_node:
+	of_node_put(node);
+remove_pd:
+	sbi_pd_remove();
+	pr_err("failed to create CPU PM domains ret=%d\n", ret);
+no_pd:
+	return ret;
+}
+
+#else
+
+static inline int sbi_genpd_probe(struct device_node *np)
+{
+	return 0;
+}
+
+#endif
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
+	/* Populate generic power domains from DT nodes */
+	pds_node = of_find_node_by_path("/cpus/power-domains");
+	if (pds_node) {
+		ret = sbi_genpd_probe(pds_node);
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
+	 * 1) SBI version is 0.3 or higher
+	 * 2) SBI HSM extension is available
+	 */
+	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
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

