Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B27340661
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCRNGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56013 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhCRNGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072797; x=1647608797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xRjkSngl6JrbFhQW624YAadKdBN5mGoNhLFzY2zwGK8=;
  b=VzidpTIe7qZfVq4W27jQYBfUCl0LMdCYI77QM/K6PfyP7xwLl8ZdY3Bs
   WsjGxCyd+UkfxS8l87j7kqLg82Iez30vLvU4wTV6fILigr/jnC28Bf4nf
   xQeInTNJWyScBz3bDnr0EY1KGbAStvJ6KpZsJ2FTaxLoWq+uwHGnGTztG
   L4Xd55j7jmWkcTubci6ZB5SEo9+GAbp3Y8IDJ3jNz/IAUwuzzthuwd4ez
   zlUo0tWQmlvqYAGRIOMKSIg0xwm4tOTsTNdzU18CsUiTCfzYaSaBF34I7
   jEONS1RD5ww0FaVO86cM/tMwEV285AAMdgwjZSfe3rxsMJsnsSGYwHgh7
   Q==;
IronPort-SDR: VNT/A6IO40d374IFJfylZaypKvsQhG7Xg4rFYArU9AcD/LVsIMD16OtYKek8A/E1hbq52YXBGS
 6RHcsqtkLbSReL1/n6rVygu8RmKPjh1/e6cruMpdwvi40C9/jrakwrd69W/Ve7Zdgabm/P+GpT
 tG7Kgv5hE9Aj/QUJu+0PC72KRenVCbDPT77FcNhNYgut6GGcra9/SIA4vvUZ4qTr5svrcWkIV2
 /b2ZJhcomXSMOPfNwNRSpxr8IYiHnF2sr4rGzmAK4XnpWhOni/LJX8D8rqUcgNm/tkpLl+6+Wc
 q7s=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="266856988"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngC/7k/hY6b5jaADHBN2sPpz/laeA3667epRGS2e6Tf84shtHY0HJbeUJZP1vYJWKNL50bu9hoqsJ4JITHguVSaZMKBa2XNfNQTAPTTSfCLsDC7KNvTVrG+q2h0PBZVh+P7YpUDmvqsS1PW7tq0yy7t0efG/fJRO7bkzH7KthJWDZ5O/A66BPjyLU45uSVmbtu4aDPqG/uquiAdufNcz8+wMCFp6sCkchlii51jEvCtdaCSs8eWZRTfXyhUdOXB5QGop7y/CAaWbhEdkRwVfyt1lCa/ZAEvvfJxTezGbWrRxe1wkP/K8nsSkwshVElOaFww2Q+rcv6M3x/pooBZeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czXf1ICfMmkfzxSxs5d9LOjTxH0S62mIndNT9t7IroQ=;
 b=gGLHz0nw8bcjaDueRI08MLvScX+DQUKWH/fIRDECTO9+544F3aSOHI6VVmMfVJUAG9VpQ7n8opRua9zP/VwTZl1ztkmqo0jkSu8Rce/fsJxUB4T3PucLNUntvXAKz8TgjPjBDuZDRtkvR+YC/biir1jDplRIRnQgUgkzvejufcb4XDT/J1syQP46TuJk0iXJwOgbVShKOHpK/8FerQ2pyVz2zCxTs064b8UTqsr/teSCO9NpI/UnRYJ8J0Af4JA9wmUD2E03i4slGc6GJHi4Y3QBYnn9t6bbXQjRsVWovn8PDHJNPTGsGzMIBQJV0AhUuXBKGWJeaH7zkdNP27tZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czXf1ICfMmkfzxSxs5d9LOjTxH0S62mIndNT9t7IroQ=;
 b=oqtW2JOepN3332uO9IezDP2EaNxJKT0P1k0bHoao/JpAR6t1kRhMG3qPYSP0tfsgcwRUyBwO+cY4fVVo30ONuCI5SSuQjQh3LLlR9y22KKo/20SQ1EVJbmB2O6RM9dbycfA4qrbPE+aSHAIha5XwSv37v8IyAOW7/pvmpeI5sYg=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:06:18 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:06:18 +0000
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
Subject: [RFC PATCH v3 6/8] cpuidle: Add RISC-V SBI CPU idle driver
Date:   Thu, 18 Mar 2021 18:35:10 +0530
Message-Id: <20210318130512.1025416-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318130512.1025416-1-anup.patel@wdc.com>
References: <20210318130512.1025416-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.155.94]
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:06:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74da500f-7461-4e22-c7ea-08d8ea0e9e40
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0826C8853946BEF266078C798D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liVaOLrpiO7tPKAdnTxW84cq+L8uxkGF3Bj+ICvzzPmE4TkIflBw7AJDVmuciAdJlOimaF7TkpUFQ9rcIBrFG41oD/IVLwa6Wo3JoTnZBTZ2cFsu5f0AKZxcpDPTTiSAYXCcygO8XJjXwu3SR0A1H/N1Oizge0tMGGyfj5ZzappNiNeWagVJ5XsM1MgechqNiPlnYiVy52gHoXk664irPbXYaXFByhLf/Zelhact1vO7n5zjiBK77albxF7av4j1rBkTtPPcuqRgquHasDx5llCvl/kULB+kgiLR9FCCP9CxusvmDSd8ZKmd3VMavpngmsdiimxfOkaUR8LR36IZKA8p2OPhA5ggk+CtVSXakGtEqN+Q011YStshWNDM3tgaNsttaWWxGI25S1M/QJNY0fm7z7rdHYFAjboWx9c0bjdTgF30UctOM8WXLS2luDbuEBexjymO66hjb0UnEvZTUTPzn3V/CtxwW18F4p/Z9yhrYMUEv1mLkf4UISm6jSNcfqhm1vpZNF2uqxgqVeH59rCnH7PKfYkK3zRgcCyaKmLiXBGCg7t4M8FcMXJ7oxBjJa1ildvTh1L1vNImD81zF2rOLXi7DYpr82T2D3Jdzb5xX84pZecG4pPdlnZbA5YU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(30864003)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qBQ44aQSG8R2TsM/z453s9TP/P5SyjIWynzln8M/a+xNjT2BWfH3T8Rw25Ef?=
 =?us-ascii?Q?2/pcEZqC/iaYwejq5H9/X0sxWJvNAOLlfc4vX8Id0y55Npabo9xgCwSyS7Eb?=
 =?us-ascii?Q?xg4shSkxL7NXNGCkuHOSD2Nptgv7Kf+xlp9OzbfwpOavGgUVzNRxok0Ssgjf?=
 =?us-ascii?Q?bDijfZCbmB633w6B1xpvB1QeWZUcuAKl0+89NYuek5W4U21/8OMJaVK3pOEM?=
 =?us-ascii?Q?6pcgIofkMpJ3WmdLJYE4oivNeuE3znOPrZXBb1vOebvxbrJarfKZYD4geHLF?=
 =?us-ascii?Q?w3SBSbFlRrPh8YsI1Bv4C4nmWrZHWEOGO1OlSszMyshbsC9RYzqTI2RFJI28?=
 =?us-ascii?Q?C13rETQLLPu3zsP+ajoUVtyRL2F2nUH7yM2d4Nt9E44O7Ihz3Lj5PBoKD/zv?=
 =?us-ascii?Q?kz2XH/v2OHoOdCmIL+EFvw4HuJKtFFM+U579SoUIwuAh9tIXsEfp8xB78qLt?=
 =?us-ascii?Q?1wlWgQ+BZVFW+CjysSMh85HorfvFt2WS2ighX/cwgJz0v+kry3fkqnadS4OE?=
 =?us-ascii?Q?XgWVMnDj73xY1chcGE7htplKHK2r/msTvEWsVfvYnCgq+FeSXLI+GfnPzB7P?=
 =?us-ascii?Q?cFxptI4XxUH9/tXuqueQlKzbNd+dvWw7YuhMiD5l3wiVJNALTLEc+xK/99Q9?=
 =?us-ascii?Q?FCE4DBraMyiva9ycHP3CxB2aJbOYq+oz0Ac/2T466Cj0cnUnlewPHMO9f3xZ?=
 =?us-ascii?Q?caEDh7Fhkzg2HIywDdWFVimaSF+ogPyysO39dUvXzvpLh70HWGu6T8x1f6l1?=
 =?us-ascii?Q?m6VaLU1UgXiIDYie85CbiES55faVUQVZHcgGXeaX8cg8Vb1tYMyho3nWfpEx?=
 =?us-ascii?Q?O+SJ0d3s8zzvw00f7X9i/ei0yCgix+cEOoMzu+KrcrTPvfJwC9DKDlHRTW59?=
 =?us-ascii?Q?FIAgtcLmk1bPq2+pb5um7qNBnYZHFMSJZoxxR/IZ2Wh7eWxU1TymYlU6zH/Z?=
 =?us-ascii?Q?4wrv0UQ/kL6b/1eUUbivHSUFGQRobtJhcDkRn+S0bO6+QOwbkrqzemJPZcJ1?=
 =?us-ascii?Q?rgUzK7WWgWsN781ZfCkrCaC0CgcYRNuyERJB38YsYN1Os+3np8JIe56+jRSv?=
 =?us-ascii?Q?bpEfVRswt3HElSCSYKPB0kQXmqn367dfPSX0HSKAAwIBGrKCTg8c0anOpa8I?=
 =?us-ascii?Q?J30f6G9N996MgCbb/CholV5hSrnaK3qkrXLsHGv2OEWBoThIw5yPKCPdzol9?=
 =?us-ascii?Q?iqL5xiW1BK0wE2iom4z7Ce3lnTJF2eNxIn9YoDy4rreOmSGiaOxR1LRbAyBO?=
 =?us-ascii?Q?guYTN2wO4OenVYvPe42GjcOxA4Pg8HIhiWgHeghyb26mqs8QO2ehFl8mzxXC?=
 =?us-ascii?Q?a7v4qaYCZzARslFUTExafdQZ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da500f-7461-4e22-c7ea-08d8ea0e9e40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:06:18.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXxfK6dE30gek8OMwJrcjTrps02diMQ0+HSaSavYSg19YVrsADBFPtdFEOFdsXYALlG3QO7QeXL+e7EmCZ9CGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
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
 drivers/cpuidle/cpuidle-sbi.c | 502 ++++++++++++++++++++++++++++++++++
 5 files changed, 534 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-sbi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..4954112efdb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4679,6 +4679,14 @@ S:	Supported
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
index 000000000000..47938fff61e1
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sbi.c
@@ -0,0 +1,502 @@
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
+	pds_node = of_find_node_by_path("/cpus/power-domains");
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

