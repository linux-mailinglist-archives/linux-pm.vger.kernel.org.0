Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B71340658
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhCRNGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21386 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhCRNGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072762; x=1647608762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=x4KgaKkTuSTDs7W+KwB0YDqVJn55pqqtz7HQEAs74SM=;
  b=PWINx98sz2O6Tgyjp9mMha4ux3OvpY4H54ZdQ4ZJgj/oamh4uBO8j14Z
   zgLtAfcr0E4zsWn+RapSWxdP9Otfwtwuy1rBwiYUO1gzzZEm4/+Lb3Cvr
   HE5QrO79HJUdeoz5lI4cWw9So41FgLppeS5KUE3zo4fH8MflBoMFBIChk
   cRpM8I9Y4X/Pdv2a+FRBmaxRE3hq/SBK3aHXc46/DRfGh15ycdPWT4zoy
   V2U2gbTi1O20Uxfni2hnVDjKeRjAki63D1nMQv4vFimQknUDKTsbK6Wo1
   BmNk1LYOQ/+fQchOJRLsr3O+rPnPMl6rqCLkyi6KVhHBlSPJskggODm7t
   Q==;
IronPort-SDR: jZ8dVWhSrlQ/3C/aaWlm+oEg3BR8stwRuomf0mk7loEvftpAc+Y+IbR938sov3MDl1oAmrlS33
 /FVqCrjq73L6P2MnATw5yg7oUcKfEjM5UZ1McN5+LtuF4SgJ7pnjWY8pszOuoC4iyKcNxt8jc8
 /V9UwpvYzDSM73fGsuShtzQLZ6H2jUrRefpjj1v9bA1OO6YsdPJkRJ5xkr2vCcQ0Va8id6uJU3
 gPIYuDG7yMyiYrGVtw/OMGJ0/R52fUIPKW/JgtmNO1kmfdE2dzb4zm/zObeat4DEuSsEnw4uLz
 /UU=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273192108"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:06:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXfm1hT/9gqrRCSa+3z0Fo5eMWtV1UtXCGR0tniMWYDUHG2ifSC/HPip3Z/bRlMGuLBXKxYH5CTNSjPY5fneFLTJZA+SpysaA2Ba2zqxZstXyv5VyieSFgAgewWiaZxw/mtPx7jEp6k/mt1tMecFIL6ca8B4mYElImsOP6GVCCB1jl2tXpRofdBlZGkKtYENsk4WCuqw1V+M1mHrHI6oTS83OROA1VsRKBSyXsb9AYp48/xYodn/WvON4+8J5/wn3G5eNw0S66mTeAUjbU+oQSrMqCcZY2++JFvu76LXN+J68T3toZ5LMAFZ904zvvS/neCEDSqyQOpLLI2TpV8yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDcvlmi0tjBar+fQD5MnMHG7r/5NNePHjRo4ppQ2rj8=;
 b=CoX3Wy5zsMDV/BY9HncZq3zUq6PEgxkP0CXT/lLf9FhgC7Im6NTBrODZqB96LJiNOg/op/yOafxbzbGyIocrJDk2bVNTsoNVAQ6gSxx5smDt4ZaACCWelTVw/ass4gZovSpH4GHtXsI1qFGefefgRWiZL+H8d1XQdBlqCoYrvMStnJyvh9M+no4TfzOWHryZ3wHRjFAbCB3qBkPNV/JyZ5nPIiCHpI5nY2seR0qT0oI5FdwTeYLdhEzfXFnd3rxdh1LIc23BuyHpuP/0d7TWjqCba6DM2kVGliTCLK5Nhz/iOpQYyFBi3rCpouAhRgQqxkak6OkEoFvmd0pkN9HbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDcvlmi0tjBar+fQD5MnMHG7r/5NNePHjRo4ppQ2rj8=;
 b=mDvxpQ4pUT9UqXn643bf2NCmSEH8L3EBGdG2aLHI/gNfk9eObZg3aonaNnmo4Xo6uCEc0PmDpq0IaOwPSS2P+fAzPqhqeLDFMb+9ECdwiZ99yWtY8EwmFJdQqti0HicD+g4bgNXgjPLHnFjMR3MO166UMHoh7lv6rPyvNgIO7ik=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:05:59 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:05:59 +0000
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
Subject: [RFC PATCH v3 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Thu, 18 Mar 2021 18:35:07 +0530
Message-Id: <20210318130512.1025416-4-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7330ed45-ba61-4bc8-a496-08d8ea0e9341
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0826BFBBD0A209FB07545C708D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnthN84iUQLwXKQN93prhuf4DrhqZVP8tJA4x+03zS/GADTPNvPOO5Y7SMjpLHCknukxvVK2OUOtahGqdm+SI2MwCHKxGYq9k0EXtmXhO5dGrgUE9sBXz2jSXgbhuX8T8AMA/H+bRcFtFxIDOWDN6NjEHI7v281jllFQcyr2ISB70733DQLx7VDh95unQrVGDFH7sjpaEcuxhaTnD1j1eUKSZghuY1llCPgeZisCzw0dzWN5LzbOmBv6BtoOtJTGWpd44lDcZSpYbvFe0xQT8b89lur1s/35zaCEiFNjjAwo3MXnOsbvdh0gBM3t5+uzUuJ0xH0CAErtjVfpZ/iTjR13s+SsKwwY6iEZHMGysgv1RVZzW/uMkjqHt7BgPuLPLdn/WRhAIe7XljRpJvzEo7jIALiE/UYdBC3L0fVifkpo6GgyqhZ3E7rZhRAFAZcSUbFQf3NB8oKcgOoaEdMSr2+6EqyGBsmymCL3ojcsTC7F2KYnLa/EvaKODCcKudrbTjNzclQUHvrmGiXL2NoTiPcDdI0K6OEkYX6aPsG0qofhbtiFXi4qNvnr37bS57eg7XMLo8tHv1C8ZPbKtry/FBX0mYi1+qt2K6zdKsp0+MM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(15650500001)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BnvdM+Xsw5uQ5XKweKZaBvkYTnFoiJMIAxLtphJwsquueTT3TxP9/1WaVbrm?=
 =?us-ascii?Q?kpLKYmdAluhPAjVHNCJoYJPzaYEpcpPYxLP6biCAFFtRw0NeQZ6Eg1cR8PSY?=
 =?us-ascii?Q?ac5FLUFxgj2aN800oDFN6P9Fy9wIYVzfkbgh18bwoshI16IzON3pDN9NUJxH?=
 =?us-ascii?Q?SZqa93d7a1/IPRTvf6SAB2ehfajqWXJ63xMokF9+nUGBbgc0MYk74R4wqGYH?=
 =?us-ascii?Q?ChEUJKlHY1FapbCC/Z9ys9jIWYj6sWVOK/2uUAxwDrauHfGDAFN+7QJhXKgx?=
 =?us-ascii?Q?Rfc3bA5C3BrGdJ0xTLMDoUncnGL46YKvOLC/AvJLkrzIohG53yb2cGM5j46S?=
 =?us-ascii?Q?9woNT3MUOhVatFDOa0Ij98GDyKQAn8C0hMgoIQc9lzgUUajIPLc1p971N5bR?=
 =?us-ascii?Q?aQVkZGRj6tDPuvY5HLL9VJlb9qLMfn34D6/vkHwYImyHT/ICMmsxXmj8kiEh?=
 =?us-ascii?Q?jOn9JEf6TB5H1UnT2bvRiu/yGEag38vgHdY/cQ0kvgVuvSoPxB0QqlXaVEko?=
 =?us-ascii?Q?SY5d/6fSIDLoiJZa1BR/ZkK4gnS68vCMCtxiqAuCaoEAFEWLlnrkva8nSgY1?=
 =?us-ascii?Q?R9eRiRwGEY+aJol3oS9l7hD/CAs/fIepxKPIJTuhkOGsCRIXhvDXcGkHMZxI?=
 =?us-ascii?Q?tcNr9JBpTsBCSmxs4CQhG3w7h34RmkCDT3p7QgQVoM3MOaooR7q9/Z/99ICO?=
 =?us-ascii?Q?KzHYFIguAhilB7xqW5V0cxe+5HxzMXQFDd+jkN1dOxPTDb+Z+WJT6og282Qi?=
 =?us-ascii?Q?YVinAEoa6fWn356PC7o0SndJ5F2SygmLgllpM7dXwwmPzGbfSZS9Nt8bm3fr?=
 =?us-ascii?Q?YkLbnUGjjFYJ0INiEccAUqqK0LvUOsSJI6AXP6XpmCZ8RGbVVyMWhB9cPiEf?=
 =?us-ascii?Q?Ci4q4sleYDJTIasHCzpw87rxfTD10UQpDtD7EBKstcwWMV3j/4x6gamNZghe?=
 =?us-ascii?Q?L/BC696EcGIkrqDEzi7zh/10mHraKyVJCEdQNo18Wv3PZLFCiYbOsTtagVfJ?=
 =?us-ascii?Q?R9oQrqr/iEt5xwerZO3xHtv6NC3ZLsFJkyA322ho3MB3YGzY4rswnrBidNAQ?=
 =?us-ascii?Q?ezihnz5w9zEWeGCwg3A1NiJrp4WWmcUqWoz/gypdU5/gHyBRbz87sJiZosrr?=
 =?us-ascii?Q?FJTIkJHCkENtGvtKUZeOmMUsWMOJxwllwNUK6Ffh17410VbFIjqbSfCXO3Ex?=
 =?us-ascii?Q?juLQEHiuoys4K9QJpO5u7KM4tm9JRpg6mB5E41+vDpFItdlswNQ7Z/r/hNx+?=
 =?us-ascii?Q?KYcFWmaaYus8r1v80DJ0hYxU2ef2ofF31exlp5sPM/ATTvEwILMVM1gH1DiR?=
 =?us-ascii?Q?o8GQYTOk/KD5Yyj5ms7/xIMv?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7330ed45-ba61-4bc8-a496-08d8ea0e9341
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:05:59.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExSJIQYAhhQF263KzUcsYXy77lOYAU6bYfceyZXBjqawKoe7gsNeYWZTBLakSCI6H0dixlfxJsSKhBLZYPuOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
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
index 3dc0abde988a..b9b1b05ab860 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_SMP)		+= cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
+obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 9ef33346853c..2628dfd0f77d 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
+#include <asm/suspend.h>
 
 void asm_offsets(void);
 
@@ -111,6 +112,8 @@ void asm_offsets(void)
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

