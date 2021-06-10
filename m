Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A03A23EB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFJFZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11527 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFJFZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302607; x=1654838607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jxNSrEryjuEr8sDJcBYsY9HCSgDST5gnNG8YkzNiWj8=;
  b=iiI0rMGSpX6DgVfYMEBHBySJAPkELyFifDXHvLM1Q4h+4KTdvp5ZZ3pC
   hEKr60KUuG6CEjQFs0Mp4SuEjVSTFw8eguuGNhC+3Zy6aWfskbd8FZTfX
   8Kx4nty4wf4FlQkKf0GwNXSICAOsjDAtHrwmhy+A5Kt2TfK14E4VznSGE
   umnksH6VCeOdcYgQOZuGJhucOGV5lGSRenqgbd76FPHR3YaYxdtL68WZj
   1IQxu+k7vPPYQkz01Zq6Nx0uVPI1cYWcK7i01DmGSgWjhHNDwPdx4B+yZ
   K0Td890WMmlzh1NgpLQ/sH1oz/SkhecT4T5WrKRvGWw0fJ/DkvUWIPIPE
   Q==;
IronPort-SDR: oLqxTIGW28bg7g1TE6ODq+Y3+Kstjn8VVfWdeXBLe9XlWU7l8/6r7i839dXvYbtGGSwl0b7cLo
 N7l0ksfBGJpGUW4nDtauOqcP77Y3oTcrUFFbJx1VcoPoWeyrNW3Thxnh7kzaVc/VGro/GP24pD
 BHO7Inh/F/Nx10tL+jzCkqK5R0ZFSW+uUMwQZF+ToXSgTAn3wPhqQoz8N4LGkXkDzUGgNd6TwY
 18Qg19JS4BbwdvAj9NNXG8nURWGdHYAV7HSaC82SGLdwEkYIWOgk/wY+uOImJX37Cj4A2VffrX
 Dsg=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211815"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxViFRZF8j1BL+dJVxuXxvVWfMfcBgEcAwsTFmxI+rim4GGbv2daEPf4xypb6Fp2cz/vSiuptQ3xIo6BuRd9olvcmC4nHL7PuHVHQmL722dSBu8AE9bnVOd0cxDoOXFLIz7LeGUpUSmPDWsXFCq27wIOYJCg5tRpigEMGTL5xjkm6vH4qWGcqHUhs8JqgP+wWBVfKUbbcfVXMCpUN8OitSVtQ8wxJBZgQF7cQEcFuZVrMJIi/BFYUaSPdTcamZKaEdiDlJSH+RvGxjvI0w1UndgaxCfLwj4RAu/oaiZRHCzd3cwRsoiqIQeSEjgOB7zmuVGBc/0qS2RoZaacushBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ECZRh6NH9dNqWNXq4Q0uKl27Vnn8yb/s2D0AI9gGA=;
 b=V+osIgcJS7q5Xf0WYUZ2UAtD/mRX7fhkYpA74YZvkuylcdfDSiB8HPWG4PSYd8qiZhOT/JVvcdZ4chD7NuuGAEOmgKnNhJ8daanN9b3JPXANgZim41bQl2jSesY4xIZCdsFeodP++D1M2pGtFV70c4hH91d7xAqtvzKRkHHCo9ra62A8Q8ccWqQBudctJWQ1dhGPN0rdVeeKIujMNL+DA9u7cQNETki7a+zBoYaOo92A5x+aiCe09R9e1n5mLvWvVTWOQGpjsjiya0J7qkAx/c0vHG8OhGEMY9HByFSGwDF58HTLaoQ9AqXA7BVGjdGnvXK/ngIc7cuFIEarh253ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ECZRh6NH9dNqWNXq4Q0uKl27Vnn8yb/s2D0AI9gGA=;
 b=pNjheiobVTbnrlLO/3ij015NJOqQGfGhOdaoML7PgYoF7gh4c0ZVAfI5NXCbLdxMb9ukYHlsI97tlbBM4KgGShoUbC52hL6IEx3K9Gvee1XFrrW6YtjPDrFMkcsLJ21Vrp5s4JB1lbN8i6xEJE4cF5srCoUJsBU0lPuMfoVqL7s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:17 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:16 +0000
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
Subject: [PATCH v7 6/8] cpuidle: Add RISC-V SBI CPU idle driver
Date:   Thu, 10 Jun 2021 10:52:19 +0530
Message-Id: <20210610052221.39958-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610052221.39958-1-anup.patel@wdc.com>
References: <20210610052221.39958-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.172.180]
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:23:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f34f3e8-05dc-4ab6-4bc0-08d92bcfd9ef
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778EFEAB7E719E9F32A65208D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78ZgtwC3NjCUAwhlnfpUi9tquXMQQ2/B8eymXT3Ms5S46tlYqi3nNsXVDxis6orNdkO+8S982p18yVkcRbfuvKLgpRqrTPpVpuJfokkbAHYUN8oGvbNxtTSZxWf/sDmuiWYsfJSZeiRXGeu25tYqFQW6vBiXDya7IsP5FoNNv+a5BZczDkYEXKRxo1pg3E2by2Wfuf+0zh1Dzu5AEfgqSjBeQS1li8UFTKG61gX7o2wUIZmvW71gol2FYxkohksh1aaysfHnER52L0VcevKN4Yx2r17Yyl74boM1pMMgV18HhCY1VUaZ2aUbPO9BX+JnCcRm/GcdHBklGvXhvEzm5BXoAsrZU1o8/UmowVV34QcqihLPNI9Xc0yKTHIz+PSOkFXtJxPeAH7v20c7eCzb1OEUk9Egerb3+ehtA9Eq8VjyqDYVtwXVm/F8rrFrGpUaCQKAk/vZNTmCUTnlzlJMZFnvGVUADt34DCacUUQb1tUU8PqsWbIgdN2pyIpT6BKPoY3hxl04Bs8E2YimTYhbbUYi1VXacPAG9jnqOWSGq4W9XHC1NeYRYFrd+LF6wBfgZuk/PBROGZHBBpeatCxEE83cA5xTyV2FTVr5Fhs//jo1bE905d+4cHDdluMRMQrSbhSHGemhtqTic/LmasZdvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(30864003)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEKm4td7h35dcJkXP0B4vVYCR8CYK3mR3DdNEC7Js+gJOsXkQnK74nd3F+wd?=
 =?us-ascii?Q?T/Nu4HVnFlXpcbUqIIkoi/KSh/rzHUW8Mn/T1k32T3q12dDDGnugaplyF9qd?=
 =?us-ascii?Q?Fi7lScq9qOOyuRVkepIGfxLOkMYZ22owO6J4pcTOMaY7dZpfwAtPD2BLXYfr?=
 =?us-ascii?Q?iexO9saz2gOrmDIAKR5II7g0aK+KZzncIVwBGubE9li/++uMHRPNk56UgqDy?=
 =?us-ascii?Q?BDgVh8WRY54ScgtHRAadyT5kGKRCUkNjFTD7cxF1SM63lUPUnacpzGbZ7U7M?=
 =?us-ascii?Q?tORO1UZ3Qar8A8W09OFqwRuZXotCp13XAxeYLUDqmIp5JZkPrV6gt/H+vQMZ?=
 =?us-ascii?Q?VI/XJV3s5Jtey56QOMIYrQUnJwLOEzR3t7K0Me1DlqkdOGdgQIgZXjSbOaBX?=
 =?us-ascii?Q?ViPs9dYiOdfHj/fzmsbTIgMTrdLYrvP0CmNXxsjOKlWGIFzaKhE9jCxzNFfD?=
 =?us-ascii?Q?ylymt5a9qe3SJQ8fbsIkWmXPFQJuUFK5U+MJEQOQg40TF+/58n6PaDI0mF/v?=
 =?us-ascii?Q?OUKUiU0P1DyF+ofeTvsAD2Iw4wcGRdSwjAoD1aUDV8BOU3he5aaUxnFIBPcN?=
 =?us-ascii?Q?BPc3TSjVITV4LA2EAB9EQbzvVoZo6N+ok87L4dOywabKj+RIpJ5KZ+IFFIJm?=
 =?us-ascii?Q?ss6I56Ap7hf5a97eKKGrAZcp1UcUTKRIyTQICc3LAaDRxUdas+8Kr4qbW4YP?=
 =?us-ascii?Q?au+nMdjJcssZwJR7sWiOU0WpsAKRnAPjO1+WjsP+vU8r16JEwi/aMZ2UgAy1?=
 =?us-ascii?Q?eWtnGnljNrdp+5yKef6Q3aHaMqj1hpc9/G2WS/RFVUTBb0tquXkCVDek6Fhp?=
 =?us-ascii?Q?bRQ+wI3L1pBHeiiVcQNiT5neGFeojkyPGwySUUUgAx324UeeR+JD18Wg+2F2?=
 =?us-ascii?Q?BCTxpRl+1V4OPgv6DQ2nbbSzdr7gh+dV3t9ETNMdNPbllQxgbCDe9xuIJV3F?=
 =?us-ascii?Q?SSdgbZIzeJKd4nee5vs8uVIfKfrfsL0/kTIFhF5ToO1nDnyPalEu+7+4yLrM?=
 =?us-ascii?Q?CLZO7Mbv1iSl1G2FaM3leWFrxIX8xGdmfO9RAw6NBEvy9UfCvZj6lRl4CAYx?=
 =?us-ascii?Q?mpFsyzLzD0SMaJgB3eV/5j8sGjKG5ZhXf+uWCGiZyoBwJPZ63L/YHCzFdQ3R?=
 =?us-ascii?Q?EwvF2+mFgzKM64Img3vL5dotb4LFjTAz1DhRHy/Eaq6HrU6YARnREd3Qk9vz?=
 =?us-ascii?Q?7yBnF7EwfIfBZhq+QcYzZHwWrF0ajzdtF8PkcyQCMlZull6HzjYNIux+r3c7?=
 =?us-ascii?Q?J7b0E9HDhupLlPQYIK3Ftx49tb9i0EiSAVGlUvt7JiAt71ob8I2u/WRfeEZ9?=
 =?us-ascii?Q?f/3u+4w77LHEIBzhXBCox7ii?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f34f3e8-05dc-4ab6-4bc0-08d92bcfd9ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:16.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdyWQe99nHDOizlQbfO9mzHsYdcCOc31cTlSGtnXISAZHfvBaEL8tBh5FO5fERQ6cdd+ljl+uc9U20Gj/njVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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
index 5108b5058502..a16b14c687b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4796,6 +4796,13 @@ S:	Supported
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
index 000000000000..286172b0368d
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

