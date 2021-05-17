Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D0382CF2
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhEQNLO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:11:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48853 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhEQNLO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621256999; x=1652792999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WRiii23Z6QzfuX16+FZ4tI7GR0aXkmDaWpjIGuDJwLM=;
  b=m8x+5+e7LYzMZ2l3VB0AuealuUvbCOqMa09ECquwctNb9svV3qWsSpep
   ree+JGC8FC+aNTsGB9fqMI4cqaGgrO7+tnENPtsTOK+Jhf0WdJ2aRDz97
   WofwAolVWYLPbS7ftwtohx249PHmAv7G8C6C9XwTCpSHLSnD4iEytXoyP
   oJpzrdlUC6gWnOUu4J/uYLpkM3lawDlRxZaxaIQ0p2h3W5tt5UgmooLIu
   O9AA2paSidZaHX3YmGSqv+k/r0KxEbDlML30ree0cxiYQThxZuOuc/0rN
   EGpLlwSPfvI51Kc2/AwP5nErHQRDBTnkpb6UduQ8TpeJ6Evz3XUSY/L4b
   g==;
IronPort-SDR: d1+BZb2ifKf6YE3HGZYR8sIEMEQ5+eNfeAH6S0WtbPtCEFEn0XnGvoLmWjmHvNfECzYwvpXvYE
 lY9ztGdVZ2q37Q84dFYGOSyso3rPfeJNIf0nOciPKZguhn99Upr+3WNkHCLVt/I8jbCijxoPC9
 ZdJbF6VNlJ/+rdSRs6TnXkCdZCW/6KXTo6T7EaE/6vrv5eSO7vbXpV82WYIXldj0vVGj0k+f95
 59hl9zfdiSBTAMW55YZ2818E3k3sRDva+tpundqqZ0Kr9da4v292ObP1ckCsuhr8+wbBAFKccH
 ghI=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="272394624"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:10:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCVSHTYcikP4dH9ZhCTu2W6Y/xrZA4g4Ej23BAEmC0VOIW5NrjGIfAInnPUsryTXnGuO8RMwhbMV29E2SsznUMjiusYY4w2iPYtZDqWf0JLTt/muxqykNBH/KVrrdu78kDUWdrPqH+Rm0Y+Tu/qogDqKIFpbA9Cdp6synImWzIBdiFDn28RS8//xvRnDC8TFOCe0BHJ+YL2m5Cl8RFB7NAMcRJG4RxrqgOiOxlZ0SxK83tZY3NVQXIj4xUj560EMzjPNIT/NAbsedKHpazQhRlaVECnIbFiqLMGS9yC2er3HydYXFY+QUCo7qDqQjJ12Rm7Ue7KzDg9/J1J48gpr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=LVnPZClGgeLXGlOHF3ec/yPfheYl3qLQk3EQfBOV8bNghYkOp5Y6Zuab82IyqVgrx2EPpAwVjw95IlQL6wNm+yID57WKBmbY9HNoyyQp8zTQqLddS3QugGbC7koGmJSoNcRDeqMQ4z6gqy/D1fG0s6fVDy/MgwHN3uEnRoB04RbMykBZnJvC3ixchGCec69Hr1zx9QK1fYogJ28MtfmmNFfI7FWY7mc4e79yfJmfwp02t5nN42o/PIF/5IH4LZ2R6FDoU4v67IPjEHFaRuGqPUZIgElBsG46mWOEWf4BCD0H2qWgFitDu6vVhG7MlhcWRhWW42rb+LFRlFqNR0Y4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=vxTzOSUFjtBYTWPLHJiTCQFt3zwg2okSAL6SiF4Jtjhkw6BrYKtI8TOP7IPwg5CpmExEz3qPZFcz12lxN04qSVnVXeC8Bq3HxQzaHjgpLQmmp7yewAyDnSrGyCJNRO8QkoR5grywpUsDzz6P5Z2PO2QmQ1lPStFYo1MVFI9pnNw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:09:55 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:09:55 +0000
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
Subject: [RFC PATCH v4 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Mon, 17 May 2021 18:38:18 +0530
Message-Id: <20210517130823.796963-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517130823.796963-1-anup.patel@wdc.com>
References: <20210517130823.796963-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:09:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7fb3298-ae22-49fd-bb35-08d91935108b
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778C0AF4B04C7D2F0452C868D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4Pe9kx5byXeBhCuQlnsbzvWZ/Y9bsnM0iSBMySGjZpxmVrWnMGEOnZOhCv3+xpoyIDFqDhgzlNxMpNZ+wccmXeeohhd3Bw5p6m6kGwsQsUsXVCIlU84Os6ma0LI/B3EurGha0kR/97AZRGkHKsR9qQ23uGORq0B0qAH8YiqLWzXU+l6Nfq8+jnlbxI6yeBzand0vCBvpyA1/vw/DXbKltbIRejRhly7nKwxLvTiEC0F8pN5Bn45gi0QLX3s5z+fP532K7SKfKlcqX7/BePnwYXbs/8lN4wTMU8yeJlHssZk97f4oVyOY4JuXPEXanKueGBEMiCqDcNXwYuNUnZrFy4/mXtkGaeQe/JzbRI7/puc+HEzBvgfwZNsTxbnCml4nK0tILE+TS77uSofx4Vn6s4XrHGnnjdLh3kH0RNa7UkYnxhFAtqpL07GNV1B95qa24G9cCJ4UYpOQe49Vy85N5Zg83ITSBa5XfUQ8TicLGIBe9WznOSBzKlne91MsHBJOtaUCiAY0lVXmf87KI7LvHyJ5GsbOhcFR6Lb5iTxltMwTqWTVSsQUlTV9rZZalQaJq57tM2jxC894IQJWEEPBxwSi8EADCOotjJ5OKLlzKIctOp8S+xGG2ILafpoAhoeb8yZ4kwO+mMH5lOL8XD4Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(15650500001)(83380400001)(38100700002)(6666004)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(316002)(4326008)(55016002)(2616005)(956004)(30864003)(52116002)(7696005)(110136005)(54906003)(478600001)(8936002)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P7HM+L3p0+bcYSSFwr3LJlgk5OopXDn8S34v3XxLpZomw+B3k4AOrz06t6NF?=
 =?us-ascii?Q?CYse2ljDJzC+ANHcS394NnSxMK7HejU/vGWztE73aXotVIUKjR10Gkr4qSQ+?=
 =?us-ascii?Q?fOheic8OxYL9pueD23R8RNVr4ujFyqNT+XuLd6YT2fEq5M5kBZQHDFIFv/TI?=
 =?us-ascii?Q?Mr9WqhQhMvXpngGdVY4PX1YKX9nTsxQhUNY1VQvOWuoT6Opsdt8ez/qaIcdN?=
 =?us-ascii?Q?J5iPF3zVdPvMwsKMrR4S1NvjUpbqep7sfOE8h7QLz+DA2k9oxzm692TPdR9d?=
 =?us-ascii?Q?85O5GXLxeSI79KE5UKaeNWWkq42/HrpaXe/g3oyF3pRI8ycyaBCjvQAMLCVB?=
 =?us-ascii?Q?SMcB8HX+IX/5TFcrdDs+n4WoUDrkaUezVby7FSDzP2jYRKdnoglRDSFzI5ww?=
 =?us-ascii?Q?ViK/gU+SJTc3yenUwqDpYim7GKpfH+Cy21Udm+N0B5pB8SnBlrdxsqymlBUE?=
 =?us-ascii?Q?Sed0NYSMKuq4FHAZH991+L9MuYfzfZ2WM4a0u6/R1urTtH7djHLopJ8HU+P6?=
 =?us-ascii?Q?RptgiE5dPc2NxyHB4FRUI0roTmthWgO6Njm5nxwfLacOWwWWFX5/um+z8nBF?=
 =?us-ascii?Q?3D/vxQKFYucXNAxsHg9lXlw0aMrv7WQ+5akufp9Y1eyK6obLfLpn+qfHp9MB?=
 =?us-ascii?Q?t5dFuXQkPW3j/c8a6kXaY9pp0hlMv3Egonq6IjcuDiSLXkykJxaLYnyV9bIz?=
 =?us-ascii?Q?4BWGZDCYWRi2fo1h/43U1phDPdAdbTVfnNKfKay9oFnVKj3+g7HB6L9o1R3R?=
 =?us-ascii?Q?URCksJfhWcWmbXWxLOso3EBzpxCGnPZfKjM2dWvlK+lfyspf7ijzvu/btbY3?=
 =?us-ascii?Q?bWgFC4UEV/TUFpFguK5zH2UhsOhSEOowsaJeHMCDDD01fL6nkJqj/isEDTLy?=
 =?us-ascii?Q?Fe7Hene7iPkAT3JMWFEMrWaCtMpe3rDkORkOnoWA6YZdD3VU2Q6mqrGSoWQ0?=
 =?us-ascii?Q?GTa/uZnHxUwqzA5cvJPG4mkT/foeeRokHO+6RBUPEtC4AKZzmpy9qD27bD/X?=
 =?us-ascii?Q?afDgS3XZdsjTmQ2PdH58AdqE7pk3EZ1vxaJHJwAOUk49yn7+xuLjn0pcb3nu?=
 =?us-ascii?Q?q3Hc7jugRSsaw5ukq2ihuzADdfilKXf0mkQRk+8Pv1hz5PputuNKEk4NpWyL?=
 =?us-ascii?Q?OmNUbjN1WUUNIp0mJrs3cAILgvxWnXHGIyHJcsicNoqbOa2eNpOIGhmjK8UP?=
 =?us-ascii?Q?hbkgYW4M8Ylnd4z0YbNXv9A1G3HcXa6bdD8gsUi8hc0Gc1BNha2+tB6dH+9h?=
 =?us-ascii?Q?TnBQ2B7jdoRntVGgc3aQNIHgTxbMjuC5KKiHTsHVcCLLBSvsvIrhU41bWxMZ?=
 =?us-ascii?Q?tC8FG+6YPxpz/N0l4y0vCSD8?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fb3298-ae22-49fd-bb35-08d91935108b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:09:55.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzL+q2bnYEHYiRNIUCfJU32nujt4PsQjOuFxCf4hhnQvpq1B1Zv1RwKCRr1uuWj+T4R9c4wD6klS6R2cL2Ob1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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
 arch/riscv/include/asm/asm.h      |  17 +++++
 arch/riscv/include/asm/suspend.h  |  35 +++++++++
 arch/riscv/kernel/Makefile        |   2 +
 arch/riscv/kernel/asm-offsets.c   |   3 +
 arch/riscv/kernel/head.S          |  11 ---
 arch/riscv/kernel/suspend.c       |  86 +++++++++++++++++++++
 arch/riscv/kernel/suspend_entry.S | 123 ++++++++++++++++++++++++++++++
 7 files changed, 266 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 618d7c5af1a2..6c93f2806eb7 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -67,4 +67,21 @@
 #error "Unexpected __SIZEOF_SHORT__"
 #endif
 
+#ifdef __ASSEMBLY__
+
+/* Common assembly source macros */
+
+#ifdef CONFIG_XIP_KERNEL
+.macro XIP_FIXUP_OFFSET reg
+	REG_L t0, _xip_fixup
+	add \reg, \reg, t0
+.endm
+_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
+#else
+.macro XIP_FIXUP_OFFSET reg
+.endm
+#endif /* CONFIG_XIP_KERNEL */
+
+#endif
+
 #endif /* _ASM_RISCV_ASM_H */
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
index d3081e4d9600..5a2fc649ad11 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -47,6 +47,8 @@ obj-$(CONFIG_SMP)		+= cpu_ops_spinwait.o
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
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index a44c0bc9c2f3..03bf2edfe9b2 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,17 +15,6 @@
 #include <asm/image.h>
 #include "efi-header.S"
 
-#ifdef CONFIG_XIP_KERNEL
-.macro XIP_FIXUP_OFFSET reg
-	REG_L t0, _xip_fixup
-	add \reg, \reg, t0
-.endm
-_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
-#else
-.macro XIP_FIXUP_OFFSET reg
-.endm
-#endif /* CONFIG_XIP_KERNEL */
-
 __HEAD
 ENTRY(_start)
 	/*
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
index 000000000000..b8d20decfc28
--- /dev/null
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -0,0 +1,123 @@
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
+	/* Load the global pointer */
+	.option push
+	.option norelax
+		la gp, __global_pointer$
+	.option pop
+
+#ifdef CONFIG_MMU
+	/* Save A0 and A1 */
+	add	t0, a0, zero
+	add	t1, a1, zero
+
+	/* Enable MMU */
+	la	a0, swapper_pg_dir
+	XIP_FIXUP_OFFSET a0
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

