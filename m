Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03D642A181
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhJLKBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:01:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28626 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhJLKBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 06:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634032785; x=1665568785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Z5nKpvhaZLHSAmj9tp9ZCQ+LFUkNITuAmDD6xERxspo=;
  b=bVdC9BFASmWcJkXGTt//LOberB4MgmfRzXuq/nwsYU71kSXyL4gKYWOZ
   g/hxQAYIUtDkNUPAfi3eM0VTdrfdVfS4pFhJVuUFPoHTiaHZGY2NbckZ1
   VRgpV6DqAy3+tFWBKzuG6rV+Llw0Fw845CzW2uW7nZXvOODzu8CxJbeku
   cvOk24P50CDB6MTjJZWY5GLn+7HU4ktADk0Hil3N68u85rZizpBcssxP7
   qazfDiefyL+NcSqyU01EN77At0XveTQgZh9Xht8KDWM1WXhvhFqE+2sQ7
   59igsL0PMc2zDHVdMnMyT7Ut9bPy7eqATByc7a4eV28/+dGWg6vFDYaoR
   w==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="181612325"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 17:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nvgjxgc5IqbG8kyvgLsl+M4jKrcLbynsJc5gqbHvR9JdsBHNdznOvDavMp7ah3mmR/MUQF9Yr6D65hdtJEHxnjQNzGaWfgAkSXTcCJCrhQmsUJBSKDQhj8v9GkkKu/BMK71g+2nMAbaTqhrAyP0LS/YEg01Yg7YkdUBX4ELXu3pYxOX99QMFP7fXamL5itRbizNJ4fTRdkAMafXnVnhHpXTe++CCky+xwu1ytNubW9HAyhPZHMuRaXftESpmNsFbSp84gsBZoJvHYP6W2aSjS+VfjM0if//lTKKV5UlaRGNg+vfnfMLZTrifsX8qOeR72+Cj44/mwTwY+yeeNagRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDupqxTCR6cE3vr0q9/GTcz1EhQ4kyzu+V6Mopyyaik=;
 b=ei5skft2EisApdpAJI6oOMqa+gBhhc2H8I6fn1WG8dpJsPVhR19VYOEhu4mbZSJXxjWxPwqhpH2Pq89nCaVK5ahR/VFyb8HuWmisiH7ZgwOcJPw2BL+VckHJzrsdxiOXu0ns1yUcWDiksy36YSIUwUBdFOC+Nh/NQxZnFU3miDcrlpywgsLfc3tPNE/z1mTSnyQxwSgjgLQ0mgZhckhdcpXzF2cKH/KCIO2ps3ZnoIW3++Kh3welbGvU5FX1iKWvQvxGm0hFwDVdRFZCzVjcIe1/S0/LDDmjKIDELv4tvMO62PKYc39YzbrmQm6ZMp2Ut+KsJolLHG/jTh2PqmwCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDupqxTCR6cE3vr0q9/GTcz1EhQ4kyzu+V6Mopyyaik=;
 b=yEejHAPpYbNF/YRZRCQsBFiUUDu6lI8Egu1RiYcI6oJq9LzDIk5V8Ez6ydH81MziOFCr9/tuVO9lwWMjtaBYG5UU5oIvXTWl/KOrhLikGkJVIkG2s2kNbGMcg4o0WoE0yx+oBs3pMe8XoAGot6uNcta1Qeb+LqL4rcWy9QbD9OY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8348.namprd04.prod.outlook.com (2603:10b6:303:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 09:59:42 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:59:41 +0000
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
Subject: [PATCH v9 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Tue, 12 Oct 2021 15:28:52 +0530
Message-Id: <20211012095857.1314214-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012095857.1314214-1-anup.patel@wdc.com>
References: <20211012095857.1314214-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.114.63) by MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 09:59:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ed93d0-9b4d-47cc-35cb-08d98d6702ad
X-MS-TrafficTypeDiagnostic: CO6PR04MB8348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB834822C06E689DC454CF54988DB69@CO6PR04MB8348.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFEJ9EFEpAq331Gu5V8jvfz7Dy42AadoUyyvAn6pv9Vv17kUqU1yu+dX69P6bMUEAn5soP9IUPriLSuUG+YQMj/KufycU9n/4mtNYP5qYfVQcOTDT+D4TRD2CO8uVSZKRgXQIvwfj9RI0I6FbpEuvTTbbn9VLAL9D2NQ8C7c8wnkTLJXe6JrjPD6BSuJ9uYui33T6a6Yz7oXVmFmZJW8F44f4tEDjomUHlan/7E4xzWFxQP+yeVn2Hy1IU5o5uB9bxH22v7taFdD9cYmB17ZN6+dOu7t4Xd4SsBEINN8bwdoTb9+alDvteMk4eONhCNvicu6+Vo7wK0cAtVzlgf+NcFqNw1bp38vhi068oJ+itTiMd6Vq2OYkgXxRzuEjcBUkV4MEbHygpiFmpULzvgapd/X/H5UR4daGA59zuG+9SPHZ/9rlk2J2LI5VdbE7L619D20wCjK7pKYy1KwV1/VJBNSM0cqtDCCUMcw9BUxe3Ki45dFCuCRvJENh3x7DrArDNmUqx6xaCT5tT3V9MImNBuUoxHIRDiU1r3loBxP8Gemj/E8gI5EIFaTZ45h/DlZWIEWhcrQ5GVy6gSNRlJg3hK8uV6AbvyST16kJhOQi9ln9yJS9JWK4ExCsvpJNltQHhawVkZY+1sXxnJvPS91ZDPvkD8iy/1swJj9L9W2VSRfNvzWXV308s2f3rtL9jfiZBGua9n1iSfuIXCpBm2/eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(1076003)(8676002)(316002)(110136005)(44832011)(7416002)(508600001)(8886007)(54906003)(4326008)(2906002)(956004)(2616005)(38100700002)(55016002)(26005)(7696005)(83380400001)(36756003)(52116002)(186003)(38350700002)(66946007)(86362001)(66556008)(66476007)(30864003)(15650500001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQR4s7bb2Mr3xa48UKBLiZiZbLgim+wH8Glv2W42PAoZgBtKSbGAO7ETPY7h?=
 =?us-ascii?Q?2b0R/3mWAVQa+MEzAkadVSA9yzv2phdcdVAOF3PiRw5cCWqKiKYRczAb/g3u?=
 =?us-ascii?Q?bGCua4IfKssWTYKh6v62CNkcH1BwhTHNgLMQFim11+sN9DZyx+2Wm2xJSORc?=
 =?us-ascii?Q?JAyZ3ctkWfamSAulOqcooLvEBDCE8g661E05+/GqHvpZtpn1XvRsqb62LH4h?=
 =?us-ascii?Q?uh5Yhr2LB+7X7hqd7H2pM95U5kyuyDkXA1ZBw0Q5jqfmc4RHtiZ2ndW+SfwH?=
 =?us-ascii?Q?TR47GkH/xGZyDxLaTfPSbt/eWmtAuTENJ477CMhmzaTSIY1h7Dexqjo9rIa8?=
 =?us-ascii?Q?6o/c0yOgRsxEEFrRsaDjJpaaxJDgsIEHxiG8J6UI+5PRzBCQlGBiCeXwiprE?=
 =?us-ascii?Q?tATf9Ld386BFLcCJq4pyf3mTKsbnNm+xxHX+zkoYip1E/y0xZ/feGyvI3+I8?=
 =?us-ascii?Q?/S2vtLGHzulQyf5F2wsnO+G/MiPZXl3aoBRpDXEnNR6uqzFGi1cOg1r0WCOv?=
 =?us-ascii?Q?dldxnUznbU0JKphJTQqNCOtNIz1RBMrjuJVhs2iSKvW3HyypUnmi/c15EGkk?=
 =?us-ascii?Q?xXHutcVtwiGZBjsaANDZzSh3TZxw7/nEFUzxBGQFKUMYbfNZ0KrniJJPl0Ej?=
 =?us-ascii?Q?8KDO6UaSxvIKJCZQLVxWk9vvRvO1YlfWNN5DTLOrh3or79aAaSeIl18soXMF?=
 =?us-ascii?Q?SBXebsTsnnGG0NaOb18IF2V/FtHI+Kq4AS9+9fNtsOsUopNtiBAVuh6+pnNB?=
 =?us-ascii?Q?OVVBx2SwsMmiRRbF46+U0+pLuoDsmEwVpNDFLFZyplOe9POUwz/MuWfZlAS4?=
 =?us-ascii?Q?6UkA/WJVgobHPDil7d57Q8rwugTtdm7SCILeNRZhgANZcGweszJ1KibowVuu?=
 =?us-ascii?Q?X11VP9J/mxGOImJTiEd4lpkT+dJ5d20OBoMZIQjUr3FLzVii350k4S+Ndxc6?=
 =?us-ascii?Q?S3oZtqkmeIkBp0gzkRqIqEaGws4lEbCjqldpMhcPTDLGpiFoGHibvsGwE/dP?=
 =?us-ascii?Q?tGowyAUSozGNOCEmN7xT0v2oXn4ebhGG4CgxYzT04pyDjC0yajOFbOFai2S/?=
 =?us-ascii?Q?55221djHnfA94IWBaho1dIdiTp6+uLnPqWAPoa6loykICTIA9ChEvRu0hont?=
 =?us-ascii?Q?5HWgik13H9VOGVyQ8OaZGWLT9LVHGsVsNM0vkixkA6zZRuDSo8frMdcLDPU+?=
 =?us-ascii?Q?ONVuD/trW/Z7W7cYF/ay4VKnqd0dnFUz3jHj2bB0YhTdAZBzPk4iRzGpsJkU?=
 =?us-ascii?Q?nYoOXZzmxL94aOZVw5TWRAk9EGda6Bqwb+vHikQeAAXTi1GwR1KzSHXjHjKG?=
 =?us-ascii?Q?hqxIoTcIC7skPLjkj8mHmA3C?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ed93d0-9b4d-47cc-35cb-08d98d6702ad
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:59:41.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XavPxIxumE8vQbtlGWRtPEB/4rpQBbxsoGnT9DIizGGI0vpAXhShhwh7dQCAuIjOI3Rt9oCb4Xm5rY2//9waEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8348
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
index 3397ddac1a30..4320629c07c3 100644
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
index 90f8ce64fa6f..5eae19971f47 100644
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
index 8ff8412db99f..6cb6f6eec575 100644
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

