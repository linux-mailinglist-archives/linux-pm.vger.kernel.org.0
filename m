Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3996439880D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFBLZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:25:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhFBLZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633048; x=1654169048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WRiii23Z6QzfuX16+FZ4tI7GR0aXkmDaWpjIGuDJwLM=;
  b=ed1MvM4jI6C7DQk7T6mWYPEWD6033NEzuxoN/JQaOrM8NsGGIlNVQht1
   tIDSEvciarHeuThTDXv5eMi0VgeUvqErjVfeeJdFKpKyeYP/sij8n97w7
   53jLx/f4LpLPCP9qEVm3R2GNDuWRHeovkDInpjrtFBaTFgS8ro5ZuPZp7
   EhWli4xYblqH4cZe7E6D7X+aREEieBUcSYjc9rN7O2f8mjDR+SmWzCvhG
   00CRvrl80fWvVYk2JixaZLV5uq3N9x/Wsgg1s7it2YsGC1WniXUfyuElF
   4Gkhg7j26onAuoY1KPzAH28saveLi0P7UjvfxOdaYXXXktBe5kC5DTGjc
   Q==;
IronPort-SDR: 09kqnf8eH6kuO1xmI7wZMzmvAxvIYtSHNG04tT40HqIyv2n2Tu8fqA1Wul6wXATqmQAXjsfegX
 iH5OkdmtVLwC+LyOsdDb9p/ZvV4q1HpJsiIUMYBz4Uub8gPGcJ4lkUF5+Tg11IQdnJroua/Wxy
 fkeSyRhEmIKSaHmE0o4FCTEMHWJRwiBF6VJEa11Tr1xJs4qUVzVsakDNdzRIlsWO4x51fBWSCj
 er8c3KpO5LAI3UYTxRdrUkDLPONqFO0VfLe5NnxKlmXrvvfo0QvytbwTUKlypgynyKV0zrcnzX
 ph0=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803659"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoLZ3wTkR5QSGQjpiCfANhREbv1RXs5EqmKqNfQL9EdRGya0w7pBm2dFY5jaFNxxhy+/WK1y4RaJtEoIY423KKF3JoCeT0KCzqIztxsxda7T4sHg6RpiwFuCo6fqiJEUVMMgPrJSR3dK+IiZW1mbVXfF5qbALvxiVXhvK9+5i9t9nHl2QQIEHG574F3OwJs7QyW8vtjCKM2QHrM+TBm951UikxRfpzoEX9LUJMkS1QyZ2WxidX4ZRN1Ial1FFDNu123lW1OJNtxaWh+EVEAhU4SQSRVthWJ/KIOO7a7S7zcmlrLtducXDa6V1dkdgb1Esou+N3m8xO9rM9+UfvDH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=htzmtSBVkulPIWCfQ2rcGRGDGJDJbCEWTHdrXCv6qpniTyYeg5958Jv4Vi31r+F4ajM6B1pEHCM8OSVbXN57euC3JCCbwGD2JxAH1PNzUwMvP2TLSGPlXhcwkZ/ppUX4PKj2O3zQqksKCuYquYhFbOuHUWvMErn0V7q9JB+vVgfZ/9V3UeJCt0rpyiLE23n2OFCkz9nmvoFUTdp2UZTKRJIdk5NxrrP1SF1VGH+aWma+pCrXJrZp8SaJFnkWLvLC5Dwdcg6y5aS+sTi1mgLVq5NyhDTc6RaJHIeGvjhTRr2R4Ehj15okzB5/2YuirNzwptIDqV7JAWlILqkUZ4a3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=hMz5k2peo+z7Ol/R6anT3/oiXSc47NGSNPjipXhILfVCQa64Nsuv+8NQlpu7TCyvviF8pjrE10XM7fSqgoevh3dkME2w+Pspf9UOJuhIg4rRVLDhuRqisndFgr5vs5GwOj2qTX+WApN1JOa1B2R1Sv5KaYhSWnxODeB0gzNCyhY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 11:24:05 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:05 +0000
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
Subject: [PATCH v5 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Wed,  2 Jun 2021 16:53:16 +0530
Message-Id: <20210602112321.2241566-4-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9113b5f3-c8c6-43a4-e0bd-08d925b8ee19
X-MS-TrafficTypeDiagnostic: CO6PR04MB7810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7810179D6422C988C008CA908D3D9@CO6PR04MB7810.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5bFj8PNf2/XUq/bSlaX61isfYmZjzb2bBPR/xjk2Ci5J2qAEcngEUe8RrjsCHojnPWV7IJsfC1pgFVXrq4H03UgMba06ShzzgU0IZ5ylLOtM0WXmBWyjK598nu6zyY5V8aYktdHlu9Y0RpzyWgXYSQMx5j4Hhgz4svN/aiy/aKaCp03RwcuLVipN5/ZMFUQEef6I1SyN+b64P6I5X1wQJ3ikQHjN68SG+RPS8sEcv34S7LvP32HL84quDwQwD14BDhNpnpdCYGeBnkiA7iyhXur6iL5QFqPDtskeZZx7V+jfQRDcB87Mco1fLxEQmKE232VaZA3/5YsoJHir6Bb5jwlSfVjy3jwv7R8EwrcNaR/QGeYTNBWasb7jphSvxGumRKQzdCtoPPp6A5oP4mQrVxOT/31riJiqUxf0Ny2jkIBotIRawzm73cKz+8tuZ7B6KaRwbjMyRmGOKVkWbXs9oVF8v1J/LnsMh962D9I7VYYh+EcdSXFkjyXG2og8SMPTzVdPtQhL2QObOgkwyKExs89eXGOKUNLvFPM5UH3fso8nfWOdqia9ZwpLd1XyR8UPIE+raAg0yreVSSVdp+oI9drO2g8p2X9yM2yXi3aYVmf3FOZll56RDQ2hz3lSaq5i1zcM6JACX1Orfi1olRdeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(186003)(16526019)(15650500001)(7416002)(8676002)(6666004)(86362001)(44832011)(4326008)(8886007)(2616005)(478600001)(956004)(38350700002)(38100700002)(8936002)(26005)(110136005)(316002)(1076003)(5660300002)(36756003)(2906002)(54906003)(83380400001)(30864003)(7696005)(52116002)(66946007)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5kub/iiBUuCawWv0ghItmJXQ+QvkR8jhNjYoZePrXPtSOSeazRMv/fOTqPAJ?=
 =?us-ascii?Q?oondNp0M0kIy/m6jDqzXd60/qe8E9CEx5fKhUysg8Htz7OGwRrl23XJU1Pfi?=
 =?us-ascii?Q?TMzSlCXt0KkB+cMelgsiyREyM9fkpCGuO0XlfcB2vk3ZtFUJOP4e1Ha1d04K?=
 =?us-ascii?Q?CtUxN7+ChV5f/6BGlLhx5gHMIkQNEl4Wh5fFOFrjDA8eru7jG6y97LUZC60K?=
 =?us-ascii?Q?bU1BNHMEizWi0m6xh+9ltGonoSunCRliNnySWH13q9oxTp57smTvSl3lDV5L?=
 =?us-ascii?Q?D68cQJjXBBcUcf3zesACFBd1ex+ECSTzbJjC5bNEF788bh5zp5KJl+slaaZt?=
 =?us-ascii?Q?Zg2vMsRKABJvIUMI+ud1pCUa2ii1g/1EQ9A+F82pKTCMop4cczbAJX40O14y?=
 =?us-ascii?Q?ZOFOmuX8J0C9CXMecVnuUUCzpWT6rmA4A5kIiNEvxNRCv64X+5BERlbbDikn?=
 =?us-ascii?Q?bVZnWvcscyDfcUCEJU/GsESdFcH/DKgJ/QpKaHUoUnDiMf3Aej+aeHn2ey0s?=
 =?us-ascii?Q?vk5FLiGZJnCs5B1VF9rfWfMQz9nNgctsZlPZ7aCyT0li1ps8xqrFBzmbv2Y1?=
 =?us-ascii?Q?6AUNsWjwp2kR7Xans/I5PbUwQfYSYCBOIgrK6WBhv+CmYQrEVwjLtfeIOZ6K?=
 =?us-ascii?Q?qf3nisVUE4n+bBqJg9PgNzuEhGAKyNBpnTq0Osh0XrLzubZOQiPoCX+vzvQR?=
 =?us-ascii?Q?IVaG7K/T+mSsOlvw4ASzqtSrc4x/tvnzfuRXu+bXV7AieEiQx0yUSlWDmnww?=
 =?us-ascii?Q?/nFYP2QkFevVK3SP7EnS0YCF9Rzhy8ssJVhiMOz4G9v68RyZjdw4ECgeY7/7?=
 =?us-ascii?Q?njXeOX8bmHYTeg4wbeWSyzzJZjidzZUVoSnv5h4sFN8PSOZrRgrwdhc0aeI+?=
 =?us-ascii?Q?HOqMrxNGdVcydWlYEFbSG2SMDktzltXJghLrRHAx7h/BHxBGQzdfBGOj31fJ?=
 =?us-ascii?Q?ZB0Wv7ZYbMEW7wOOe8mFvaWmSDRhAPaBjHx2PE3w00cGomJ5691Kt5JrqxA5?=
 =?us-ascii?Q?ARu5whFTPeirRnd5fU07Ee6FQ6hcLQfPWrg9gffJz9v1L3qHfdAQcEYnC9Bb?=
 =?us-ascii?Q?dgjAYemfh4/HOPZpslJvcYRgNMxLYwm6qpxmxjOfn9vQ7xcAdSlOBtuUrMnu?=
 =?us-ascii?Q?wTfEpU0biXEzHWVLw4Jfe5h8XoOrAYipE848rCdJ+tEEkjNCUSt/jRuONkcF?=
 =?us-ascii?Q?TbhqZsmV0zeESbNz+bn/B9NjnD0QezPYFqQwt8QT+5BqVfeMwZ2UlCXUhuR/?=
 =?us-ascii?Q?7LhcEhHyG0FtNF1Ur6b5EMSYDMjlvSUcgJ/1GWYvrWZ/BEDiznzepaRC7aQx?=
 =?us-ascii?Q?PZyo4nf+B4pji6lCB1VEqtXO?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9113b5f3-c8c6-43a4-e0bd-08d925b8ee19
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:05.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBc3hdBCyfo8Oed8ygBlY5WdgccvbIfbpOG/B/ciLq6e/GNErkHKEUDIiaLN/gkAMbrH0PDbP7P00lei+TjH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810
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

