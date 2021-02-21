Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED824320970
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBUJkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:40:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6875 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhBUJkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900422; x=1645436422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KCo5bCppzleLXYj4Ltwcw+vF0Pd7VQ9e1VcaI2J3aHY=;
  b=KtXzhhHVj52Zo5BeSuizkdPsFy4driuRa7jixxpW+ITvZ7BIwIJQB8bn
   VNYxjXWGz+pA5HBoKT0Xhy6F2XJlXnthtKsxpg37c/ikSzBOJP84T1dZX
   9+DobNPHRyEc3OkW3HCYpu9DkQkVolySxrEJSCbcbyju/JWAxbD6WaJdR
   NPpt8lOAtMiklVXMhlcyxEAL3qDgLCm0mT12caT3x0cBYx1aS9dK4cMpP
   hOLOfgRdmyEOWUdAtH/P28vgU7BQBAWgGGwb80CsaAlFGucTafTolYoKG
   WMN5TSmb5HBHId86DSoHbmgxLR9u0rkttiRzS7VyZV8b2WJxY9nu8LxEX
   Q==;
IronPort-SDR: DvlDx94+6w4RRAVR+NMOr2FpdtYovQPgTf0ilusZDPR6XMycmd1VBncHfeXpfiTmo7uhB05d3E
 RTpxCyQYz1j9PFM3Dl2HK5wJNoBVBi7tNbUcr5enfrQOIYNQ2yDb/KDDc886aqKpWVGnlFrn/v
 xboQSC9D3P9VJPtvZGfe67lp1LQQsI8EWJfxI58HZQ3LBNtmNvT6ZHnOIfxSzXAt2V7KagB6HO
 onhtc93PvuHEvqVyIC+QhognjEFdnfr1Mjg1SZqQP4vLFPxbP3IR5h9TPvWNKS2HhsxFdp7gMt
 C6A=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="161607386"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:38:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnrG0mfFIWAu9/0sVTaOEAdGWqWk+CE55gXbRRjL/oXWfod6+jGS6la/GQz/1gKs8RayJlbRMaCOemZdeSIA28nMtoYqiz2VY7hwaiqBuAG1Eb5IrpBBmZYmCY6N+kn5kVTWiovPR6CDeQigevkAzDO/+vhahIyf5vtddcv3BSV9GlEypxO+OKhvq4MKRtyjFAz4UKjjZ0/c7AHc9+/9Vfy0KLMJxobruIhBBocIyhAWlCmSsU03ogteWbHW94qldcAM1oddZCzu9csqM6tPKVC6+W74gciHKE4HnEFg9W3Smp54XhG+xkeYIQWw7sR4pig9lYqvydbbSmLK/vouaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOys0KUzThBGFKirZQw23uhlWWYQo/RXXrT2Aj1ZyZg=;
 b=ctBrIwwTGTQlcRpVMERZwWux39s0pQVX0oWeUEB8V8S1R/NsTn4XZGWXLjLSGu9Siz/CgNmc8Px2tb2jDIu5lSB+s6+Jvc817xovwv2YPN+3uHoQNDpPXaqxeWjbjaTA4a/eT5odW/ztsV5EzLMoDp7DV66PpgSnI+g9lS9eFP6r8n43JUFkCwriMaujMS3Vvaw1VQ1ERDJCpT/zhTCKnr1ui+BmQhS9tkTDj1M7L+JA6M/KuGqz7PMoJkuUbXdugbn3ancd96RH7RbmI7mc+ld/dd8z4t2T7rIRJMiL3U1sWpC+TrhiN1XbdDdoNzGHmOQxRgCLiYt/gdM6MFYHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOys0KUzThBGFKirZQw23uhlWWYQo/RXXrT2Aj1ZyZg=;
 b=j8iepW9mC2PNQ8yV9xIulQLK/BKQ4M/ASi0Ya1xREDZVSWxGELRx73D4PmHM1KjcUdyprb1IS1UKcBy3N5r4cjkie1BKSlebWikKeeWTi486Y+GiyqfSQZ/MI4iGlY/eF4vmMDnUNxkpUTvbT0v6XNc2zfIkItlNhIQvEEgJZv4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:38:48 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:38:48 +0000
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
Subject: [RFC PATCH 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Sun, 21 Feb 2021 15:07:53 +0530
Message-Id: <20210221093758.210981-4-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:38:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bc29b22-c57a-46ef-b957-08d8d64c7d61
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459D2DCD544D40BD1CF8CA28D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLiNgF9/xMoOQ50kFAPBQbvoaj6BtoTD87eYcPed6T+QFG9bleEWP085JkSlo1nYCOiIsiwEhKTHM3CxaLNi25oxnZeKed4W+52Q3vU9Ku9hOcFkoD4Su9VYh5Mgkgzyk7IpdmbgabCwGWF9+I4GPjVZxOZu4xh09scCAqc4Kg34uvgtHCvHp3pYHa+WHb4m9ij6iifAGoosWGxu6UTpff+frKl0b+NjWL94of72rk5mUfNHtLST6rQUbyzF5+UP0+g4w2QE7NaVuUDE2flQdWJI4005Hgwq5ETr9xyognclX5ej8o1QE2dJJwAV4uTc5uJe7RzXYzZoM0MK3Y0Fmf+tpaWlot0GISFAP12m6u4z0zjeB7xj6Rq7GeyRe4n8x8mOfSrKAL/TKPlBKR2jNDgH5tc4mW2ZtTDnabQgYKFcxXYok5nLrkcIC9Ozhl54EnYV24AxBJ2tnF9Tv/Pf6Y2LFTpOyinF8BTClU5m8jzAsweS0M/K2YfMac+/7I45g5V40/InOZTJE7p3fDt2Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(15650500001)(5660300002)(54906003)(110136005)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?USW9rQgAefcG0B1w1Hopr/oRVAgUnBTlLFUZQ0hclWlJ0v9QpesZ+JDsufz2?=
 =?us-ascii?Q?GUcZyz+X5hE2Tm/TR3QuegYs/cF5Hgko1WswoCBeVwUtHz7g9gEx+xC1MVDm?=
 =?us-ascii?Q?CvJ1oBn9RwITH9IA8ZqhQAxErIz6EdgT8YXCUXQM7T7VDciGFwd+TzY407xp?=
 =?us-ascii?Q?ydC2bK4V779552ARWd3IbhrZlD34dYAmmTPuKhNva5iRDEh+lV3ZW3eo5DEk?=
 =?us-ascii?Q?eTEftZYpjQbihzD+44/lS//E6ky3Wd0RD59B7ApSqgfAUizmPKSzDXthOs/d?=
 =?us-ascii?Q?YKIHcpA2lAHO/J0kLjUesp9IaREtitCssJdm3k5yX+e3nzJAeqbmhq957mko?=
 =?us-ascii?Q?4h4Hw5Vz+yFd3qKx8tQpYs6c7A9mo4CpsNkPEDS4mwUWtC/DPBLmfUUA8BGg?=
 =?us-ascii?Q?IwY+M5yHYoutL2/TZWc/HD7lySERb/nGUjCxztaqrBVmSM5lvbYhYr6ZJw20?=
 =?us-ascii?Q?HfarY4ikNuAjBJy4O8zgj7rYYaBhr4RC9F0NRCXHeEhHLB4g3/tYZW7cmD1p?=
 =?us-ascii?Q?gMFnmbN1upiShJI5f5svBudD4jJh4QcM+loTKfvofKqBthiepaWDKArX4/Ke?=
 =?us-ascii?Q?AUz6DBp5ZbaIaBMJuQ5aEtU/1YGY7RWjHQSxYliKfreF3BaHtHbqfdF/OejR?=
 =?us-ascii?Q?zuj+2jMfnTsNuQpM3asD+a/IqTn8ol6tgBDnIA0qK6e8UbtCb2wWMq7DMS3f?=
 =?us-ascii?Q?siAr+1ayIiXGBJivI/sN9Pbc12H0A62oToQmrc1j+qAoD68WiKGi5BhRWJ4g?=
 =?us-ascii?Q?STkDTO9RnxWMhp5FEK0/eHOw5KuwNhDa16/rhOr4+baxS0OaKxF6z5aaAo8+?=
 =?us-ascii?Q?SPBilf8254gqKfEoxqmXF1DWUBzdhcdUCZ1XeUjpAMURFo45+TncSlDLJI4T?=
 =?us-ascii?Q?w3rxDBXniYiS9qiVNYYrkBpJn7xdCK6AOFfIeyF6BXq6j4TGw8vxFriYGAgR?=
 =?us-ascii?Q?DZ8z4QDQyKaw9WC+sxd4qzj54vlbO5yZ8NS2JFVL7P9GUzdO16JT7usa3zV7?=
 =?us-ascii?Q?DNlqZhTGwjXZijhLjZ91I1YAu3ZCLwna50Qii/wyuEFi9G4kWezMn1qHsESr?=
 =?us-ascii?Q?FeWu93Uy+DrVBBGy/R/u2E9zEKzBIetbtm9Abh9NBnkFRpIELRHba8ja025L?=
 =?us-ascii?Q?Ml1d73kjT9xAeCILRu9a4kNDlAEw6mR+xQEmxZwblhRpeJ+EbcbNTK3Tn2hv?=
 =?us-ascii?Q?NcHwvHnNI1IuPkpS/t3ikNQAV7ZBdGRqakZhg8RcyKtbvoB/B3HnSwUUbhrX?=
 =?us-ascii?Q?aYHobR/CYTcEL9HwmI2C5ZxYD3MEhs5koMsMJgU5acusD+HtEQlUaAUmKNgN?=
 =?us-ascii?Q?3aGwaneoMJymMMsdYB8CyJ7i?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc29b22-c57a-46ef-b957-08d8d64c7d61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:38:48.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu9uR5X5As4L1rdaegNwX7HH2T9rfRVDMoNpO16CRHh8Zbjt5c+Wl5ATdPPPI7EFPd7cuHJKUEOW2bV642jj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hart registers and CSRs are not preserved in non-retentative
suspend state so we provide arch specific helper functions which
will save/restore hart context upon entry/exit to non-retentive
suspend state. These helper functions can be used by cpuidle
drivers for non-retentive suspend entry/exit.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/suspend.h  |  35 +++++++++
 arch/riscv/kernel/Makefile        |   2 +
 arch/riscv/kernel/asm-offsets.c   |   3 +
 arch/riscv/kernel/suspend.c       |  86 ++++++++++++++++++++++
 arch/riscv/kernel/suspend_entry.S | 116 ++++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+)
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
new file mode 100644
index 000000000000..63e9f434fb89
--- /dev/null
+++ b/arch/riscv/include/asm/suspend.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef _ASM_RISCV_SUSPEND_H
+#define _ASM_RISCV_SUSPEND_H
+
+#include <asm/ptrace.h>
+
+struct suspend_context {
+	/* Saved and restored by low-level functions */
+	struct pt_regs regs;
+	/* Saved and restored by high-level functions */
+	unsigned long scratch;
+	unsigned long tvec;
+	unsigned long ie;
+#ifdef CONFIG_MMU
+	unsigned long satp;
+#endif
+};
+
+/* Low-level CPU suspend entry function */
+int __cpu_suspend_enter(struct suspend_context *context);
+
+/* High-level CPU suspend which will save context and call finish() */
+int cpu_suspend(unsigned long arg,
+		int (*finish)(unsigned long arg,
+			      unsigned long entry,
+			      unsigned long context));
+
+/* Low-level CPU resume entry function */
+int __cpu_resume_enter(unsigned long hartid, unsigned long context);
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f6caf4d9ca15..d83038bf93b2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_SMP)		+= cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
+obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b79ffa3561fd..8259f5f16da8 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
+#include <asm/suspend.h>
 
 void asm_offsets(void);
 
@@ -108,6 +109,8 @@ void asm_offsets(void)
 	OFFSET(PT_BADADDR, pt_regs, badaddr);
 	OFFSET(PT_CAUSE, pt_regs, cause);
 
+	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
+
 	/*
 	 * THREAD_{F,X}* might be larger than a S-type offset can handle, but
 	 * these are used in performance-sensitive assembly so we can't resort
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
new file mode 100644
index 000000000000..49dddec30e99
--- /dev/null
+++ b/arch/riscv/kernel/suspend.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/ftrace.h>
+#include <asm/csr.h>
+#include <asm/suspend.h>
+
+static void suspend_save_csrs(struct suspend_context *context)
+{
+	context->scratch = csr_read(CSR_SCRATCH);
+	context->tvec = csr_read(CSR_TVEC);
+	context->ie = csr_read(CSR_IE);
+
+	/*
+	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
+	 *
+	 * 1. For no-MMU (M-mode) kernel, the bits in MIP are set by
+	 *    external devices (such as interrupt controller, timer, etc).
+	 * 2. For MMU (S-mode) kernel, the bits in SIP are set by
+	 *    M-mode firmware and external devices (such as interrupt
+	 *    controller, etc).
+	 */
+
+#ifdef CONFIG_MMU
+	context->satp = csr_read(CSR_SATP);
+#endif
+}
+
+static void suspend_restore_csrs(struct suspend_context *context)
+{
+	csr_write(CSR_SCRATCH, context->scratch);
+	csr_write(CSR_TVEC, context->tvec);
+	csr_write(CSR_IE, context->ie);
+
+#ifdef CONFIG_MMU
+	csr_write(CSR_SATP, context->satp);
+#endif
+}
+
+int cpu_suspend(unsigned long arg,
+		int (*finish)(unsigned long arg,
+			      unsigned long entry,
+			      unsigned long context))
+{
+	int rc = 0;
+	struct suspend_context context = { 0 };
+
+	/* Finisher should be non-NULL */
+	if (!finish)
+		return -EINVAL;
+
+	/* Save additional CSRs*/
+	suspend_save_csrs(&context);
+
+	/*
+	 * Function graph tracer state gets incosistent when the kernel
+	 * calls functions that never return (aka finishers) hence disable
+	 * graph tracing during their execution.
+	 */
+	pause_graph_tracing();
+
+	/* Save context on stack */
+	if (__cpu_suspend_enter(&context)) {
+		/* Call the finisher */
+		rc = finish(arg, __pa_symbol(__cpu_resume_enter),
+			    (ulong)&context);
+
+		/*
+		 * Should never reach here, unless the suspend finisher
+		 * fails. Successful cpu_suspend() should return from
+		 * __cpu_resume_entry()
+		 */
+		if (!rc)
+			rc = -EOPNOTSUPP;
+	}
+
+	/* Enable function graph tracer */
+	unpause_graph_tracing();
+
+	/* Restore additional CSRs */
+	suspend_restore_csrs(&context);
+
+	return rc;
+}
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
new file mode 100644
index 000000000000..dee85c86e177
--- /dev/null
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/csr.h>
+
+	.text
+	.altmacro
+	.option norelax
+
+ENTRY(__cpu_suspend_enter)
+	/* Save registers (except A0 and T0-T6) */
+	REG_S	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
+	REG_S	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
+	REG_S	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
+	REG_S	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
+	REG_S	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
+	REG_S	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
+	REG_S	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
+	REG_S	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
+	REG_S	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
+	REG_S	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
+	REG_S	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
+	REG_S	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
+	REG_S	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
+	REG_S	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
+	REG_S	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
+	REG_S	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
+	REG_S	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
+	REG_S	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
+	REG_S	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
+	REG_S	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
+	REG_S	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
+	REG_S	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
+	REG_S	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
+
+	/* Save CSRs */
+	csrr	t0, CSR_EPC
+	REG_S	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
+	csrr	t0, CSR_STATUS
+	REG_S	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
+	csrr	t0, CSR_TVAL
+	REG_S	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
+	csrr	t0, CSR_CAUSE
+	REG_S	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
+
+	/* Return non-zero value */
+	li	a0, 1
+
+	/* Return to C code */
+	ret
+END(__cpu_suspend_enter)
+
+ENTRY(__cpu_resume_enter)
+#ifdef CONFIG_MMU
+	/* Save A0 and A1 */
+	add	t0, a0, zero
+	add	t1, a1, zero
+
+	/* Enable MMU */
+	la	a0, swapper_pg_dir
+	call	relocate_enable_mmu
+
+	/* Restore A0 and A1 */
+	add	a0, t0, zero
+	add	a1, t1, zero
+#endif
+
+	/* Make A0 point to suspend context */
+	add	a0, a1, zero
+
+	/* Restore CSRs */
+	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
+	csrw	CSR_EPC, t0
+	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
+	csrw	CSR_STATUS, t0
+	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
+	csrw	CSR_TVAL, t0
+	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
+	csrw	CSR_CAUSE, t0
+
+	/* Restore registers (except A0 and T0-T6) */
+	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
+	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
+	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
+	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
+	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
+	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
+	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
+	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
+	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
+	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
+	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
+	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
+	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
+	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
+	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
+	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
+	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
+	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
+	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
+	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
+	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
+	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
+	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
+
+	/* Return zero value */
+	add	a0, zero, zero
+
+	/* Return to C code */
+	ret
+END(__cpu_resume_enter)
-- 
2.25.1

