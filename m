Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627F3A23DE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhFJFZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11467 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFJFY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302586; x=1654838586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WRiii23Z6QzfuX16+FZ4tI7GR0aXkmDaWpjIGuDJwLM=;
  b=LPDLTgEXAOtjz5CO3xoD3Y4cc1TIQ++Us+zHxtNDQt2z7fBl/B/0HO0C
   am1IMeBsSjaC8ml+0XaKayZe3+opIz/Edxpv5XT6sjqiyDfwryHNNpRgz
   my0+0FGad1g+UBTL2OU4z2CzTpkj2L0F2gTgXBnEzKXL2z64qyO8AbDvL
   DEJC0d3Eft4pboOpy+rDutSiB9tRfavQTp4Htolk6Yd6UuBMHrIebDRQE
   jPa8IU4h/ha0MOUxWMPBATjx3L4Sq15x40P0x01nsEwJgj3OcQ5GW9LCR
   mKDcprYKJxVi6k40Mdn14MUBtc1jlso1DQERsTksv/8UogfskCpqIpP3T
   Q==;
IronPort-SDR: 6TR9A/Nx2IOP9vg2dU3Z+Q7o3mCbqv/CCziQJ1qLOW6GdpRqxdEFvx3/wCQV4fg97/+u+Kx89G
 yRD/EeiquQ4oFwJV0eFkkGwctSkFuhyMiP3HshShcSczStLQ/Z9wrYYZekvniQyyEmm4bE6aGa
 hdpCt6NIY73RizHOOGvLPXlSGPu2lWGGvJn79G31aLx0IRsnNRwvz6+qFp+xJLBl0S3JyQPufY
 BFLcdoSkd1giYjZv2ugXzaUglR2HZ9hqlwe0yPoNR9U+ms5NxOtUCxRMGwYGClsXu3dC9VdmsD
 oV4=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211794"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQImWRfLWX/aV4TxhfwUb2O5NJU9fLGE6c+YqtGLpndGVWeOV4Tj2kAOcieQzqiDhODpEAuf0fv82/xvU3uYHJEfgb+gKlNinW+jIRlQze5nhneUW9Fk51OeAsZoDMIlbG9vdFajsOiQZSd8BTKRKI/7eK/RZUE8bahUqwUKZgcsPasQ4phpSTWJZ1eykFashxj5tVRAtFQaTTz48NwAPwqZZD5fxwAQkCzFsS1LM+6aZcNE3+w5NRWvgVFqVtCXoFyvatZyQhiWKAgJjdhBbYRxg/PbmoIIkrjCUaRpCtBMmw0bHPK3dKJ8Jwl8XWXvYyXBURz///Fp0f1Bm4/JkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=U0Kk8ezfqW6GCsHnNFUm5fGiroprZx+RdG05A6wLRajsc5p1fmb/lx2yCEn1kMVCSQsqfqnBUOCjkf5ueE/Ohnu495wexysmjREWNSgabQyxt2Qb4+VR6fPd6Tq0acqirT1ZDshLfK5sh3esPtmOOuBvlQGPf5rVvUq9zRGghDLdE5APumyM6GE0ToztL0gbc9Y3C2CvlgPz99+Fj7j83A9773wvad29BcPrdafXjLnWbnHMzOUfLR+VsL3xLS2cINhBpgDiohqmNirDiwji/w6CcLggBTxO0KF0dzvb15xUB2cXx965Ji1b7eorY3Cvn8IG9OsCONo08onc2BEZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUYD4VxNiVhQdYFN5kCIwzDGeWn5RGAjIKEex8OoBz4=;
 b=bd6Zo6SIbrO93zD8CIUT8LzGg70R0v3J60JSFXxAbcMy6tN/h1FXIC8tq5g7QkOdNoA/gHYr8HU2Dc7YJN/XuY9CBAwaHdXJUcf8yCVPtvuc18ZfBTQWr4j5XLyxz5n0sY6F28TeQlxThPEUJmgunivFZ+CJs6fZh7MmCCmkee4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:01 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:01 +0000
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
Subject: [PATCH v7 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Thu, 10 Jun 2021 10:52:16 +0530
Message-Id: <20210610052221.39958-4-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:22:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4112b13-39f3-4da1-86f9-08d92bcfd095
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77784CE0CED459774B7E62D78D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJzHhTGn4wzDo8u9zk9OrMZn0uINmvjv5ZSse+S+qnmVMeXpX7IHtEOZzc4Dg6kW3W7w+v9dsnPW0SS/EY+yrK0jXNCyRMNzh6UZd24G4hLQg3C48AW3GSLyTKKqTbtPLUdzpdaE1GhoLA+9g2DMD3d/bWgfKPPNPSG+Zx2aYmFhN4Awz6CMo15a3sp/pk2kTeAp1PNxrwyQXPDakgffzxUBdNQi6/Fim7AEvow+tkF7zy8GPLrWyPZFEy6G5Vj8T0L/6L+cbWusrZJkUNww10MOpk8z/QFdz4vRAVQHMe7UzxrQwZiLJ9tqiqF1HEGUogG5Ze+B5Gd3JOBQf/+dzM4Riswmj0zfPkez+uDe/E1Vr9kt3DsjJ6C03ZJXNZMFOU8Hmq2f64VtGK8LlxB4IGB6YgnYMDgg/1yT88XEvRNFso04x3TFmYLBekPRrXAFVVEyaZmK47cjx8moCcZ5eSkBoxSsym9tO3LROBDeDgxrKugwm+t7dfcEoAh8w8s44bTBTfmhQP0buS30yuYZALUnf4LAqJsS6EJeLVlXeZZK9Z1av/zCKtGADLFnfzDYbjxmrI/zMkeL87pC4Y9z14dCWHHmuwvAu5YKNeXJXP83wBmvQPl2Ks1+EIFg9R8nSrJd9t3K8TYp4UDB96H4rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(30864003)(4326008)(1076003)(478600001)(38350700002)(2616005)(15650500001)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWfyOGrQl2nrdt+d5WaFtKXoZYRlhVli/OonWnEUOeYESpHPbLdvoRV/kZ29?=
 =?us-ascii?Q?3yVz/qV5PXPcv1uexQEU8jIbg5kqZc6nlPVgs6qaA6rVyGA73iJ0SA4zv9c4?=
 =?us-ascii?Q?ouF0SZBCBFmZ27HsyeSKUsjSCQszcDx+YGqr4p7ALvA8U0TPgYGzkkRfspMC?=
 =?us-ascii?Q?Z1lBm+pjcZwCSpqe/D/SWDFeixHbgYNcUAvVfB4ByBWUMKGZxZeRf9nku+AI?=
 =?us-ascii?Q?sJ3u4JRk0yFUrpog0ich6X6TugPgCT8SkT+HAs/CZPgqOBjBEEHxv5MfphOn?=
 =?us-ascii?Q?7JXNiZWc20bEzrAbqJbwdsN30CPinvJXEXlU5zNp9i7ZASGuHROrnYoDid/4?=
 =?us-ascii?Q?uF31uEiUBGioOis7am6FSLcJOiguUOxs7oyVb6kwG0/10bJFnXwNQ6G3gwnm?=
 =?us-ascii?Q?N2+kSc0h6vmHCb+W/76koDzpvW40y4W/Fjj0n0NRpZNdd44rlObRl/GWuCwC?=
 =?us-ascii?Q?nFg40BdqFQm5buKRetn4El5RQNUfh1P98zdeRYdrFZNtSUQU+mJUKVArEzjX?=
 =?us-ascii?Q?tD5XX0cVwUJpDyL0cCqgJLaDDR2OhWEQgmgvBm3BS0VAIu6hdRDWuvX1suIu?=
 =?us-ascii?Q?5RNTJulhUkfMYOQ0Ucm149Jw1aMp2VLsJMEViTC/2jmcyFGpdX2fKxIBOeMw?=
 =?us-ascii?Q?YL8LxQzxypA2YZ0VwKkWusdK8SXz5wWCHgFi61DogTaFFhce4l+SHrHzDfFU?=
 =?us-ascii?Q?c2DECcdJI14NSdru4pajuxuiExwU53JWD1wao4RRY/sWUweBksiU2KnIo9SR?=
 =?us-ascii?Q?FeDMkEVuLpbDnkTntPCAiiaYGmTm4c6Ms6Phu8JCm5Wnd6Tee1Rmtc3WZBME?=
 =?us-ascii?Q?HdLqYzp1bi3RoKqBqeW69i8few7BpRc2y2srWASm51B0uzd7dOBjqVbh8ilG?=
 =?us-ascii?Q?jAKX3iOxiafUlRaj9Q4XXmqtHCtXuDjMe0WatWLG8sLIo3zak9CVkLFKvgQs?=
 =?us-ascii?Q?FI90eO361XJdeDmEJGwYaAXPj90/H79/5VEMMw6F/af/ejMpX/42tusz+ohZ?=
 =?us-ascii?Q?jytwhKxwrR09Ok+v8ldXsicyJFAQey2sfVnjkWeQVlJOtVKrK8r1yMc8uVMB?=
 =?us-ascii?Q?HgCNHk7JO35ipN/yqgEzXvZ+dT7FG8u1ddzShfiw9tPmWo270QdZn6VIIal9?=
 =?us-ascii?Q?Svt1KgZB8TeN64ABLNOvwuN13Kbgqbv0RBobaOPr2VIyAHNOotd6MkssrLTG?=
 =?us-ascii?Q?pw82Qx5Y4+vE1ch4Nd9+tDPBk8NaXtOto5y6FoRjHKRVFXA143nVJ7qhH2yl?=
 =?us-ascii?Q?QlKCi+YPgT0TiWSU7hfz4OfJkKYWaq7VkLhxk3peh/a03mEuj60gcZ/tKsic?=
 =?us-ascii?Q?JYjgy6IfnBfwFWPQzoYVKbQ2?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4112b13-39f3-4da1-86f9-08d92bcfd095
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:01.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQbq3qn+YXZ/7QbXYwBmMSUlNCJW4Hag7KG4NVtayNP3tVRlqqUxnC0/SKMaDXWoKIbfKnN7jBjvW+HoEHfqfg==
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

