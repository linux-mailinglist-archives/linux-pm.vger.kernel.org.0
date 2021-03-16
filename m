Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE00D33D1FE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhCPKmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:42:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhCPKma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891350; x=1647427350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=x4KgaKkTuSTDs7W+KwB0YDqVJn55pqqtz7HQEAs74SM=;
  b=QdlCQ9daOQTLjeK41HLDueVUubDCsZsUesK/flwrDBCfqX4lI6b9Y5vC
   m6jMea7YD0Rz/cZDYwSsfOe8f3Sb+qJeKOco5pjfxvj63BrDpm8/qaEEx
   pxBtEd18TOoZESRaXNioQpZj0XkNEoS21bb5SbVT9CL4fY/uJV+/MSAz0
   a4jkBWZia3v+OILI+Xfp8OIRxMnEMeAyY2Sm4J3kNckKI3o7dnqAm2wJ3
   kiqlFeOI7rB/y+andt7phnaIvnwHGhycxK+SbM5ZQOEZVcX0GvVAHdwzx
   MerLaE1vKvsDHcwfjauoD1LEb2KEa+IGhJcmNmpEZEHILv8kLsY6cb0U9
   Q==;
IronPort-SDR: ujmx74Kr5JBVqQFU8ZrxAThEHMddPP+9g/TgZ7UU6AGjlfVVN+o0KQ0/8bS9oGr7nRG0OiV715
 fLD5CFVRa3G8Evhl6XjRGKXS9mORDVgxgi4bZV13NuQvt+aXP0X7kKkmIo3ua54T5YiWWb6F2b
 bT3HZh9pkddbWC69bYrsVQHuXqaZKXVB/RiDC5UpEp+uKborWkMWKa1dkFc+QbaCXCsSYkD85T
 H8nmudd0MOOLlGGkw5+zR3NDIsZJOGo9w90shxAgeSN9kGIh0wf837RRs9qudF7p0eWdfThpYS
 OQQ=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272971754"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDexrY+3Ro9ZP3C+hiNg5715nTyvT08zFHoZQwC8kee1j5hugKwcBN9BIYvpYD+hFswkTnnKtlQ+rXSFuh2OBfDWg72ZqdZt2KcZe3yRT8GU+KYdb5Q0IZQOwg0e+zBgUGkNbiH4jjxa+JbfVLfCDNwDrGxqAjAZJRzWi17aOQlmzUO4hSx7KYcWK13mJIz3vP465GnlCKovnY6OEXid1YIaqhSgVGYEe0JgWVFHFKNVMa0Ak9SBSkUXNCptEXL78BS30+bY1IlWrA85OByQt+erRr237E6jSpwvREuKb7YDSUGTL+j+ZmVF0ac1JQS9r9KFe9wGovzsZ+q+3yIp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDcvlmi0tjBar+fQD5MnMHG7r/5NNePHjRo4ppQ2rj8=;
 b=XaDu6dHDILRIS3A+hNjKjqhkE+pINJjX1K12lOMTYNXfg4NpXUKNgd6qIovfU4SFdzf+p90CYLx20ru31bb0NYx+eHXmVgKLfsvLG3rY1iE80rCgGYPUb/TgXyvNH5feXeD5eapksT4LJoc49GxPwvvVNdnfOMSq+/KE62scyuOYM2WH2HU4q4PQ61ai0vfnErpoQNPNIwKC1wglo8jvKMeqFGMjcJaNDOc6koMZcI2UDKxnPSESix/PjWx/TeaIvOpHgdKyYzu7ZJ0/KfasX4rX79ZG2jI2yZPttIa+SDslWT2m/ZzTxjS0Sppcw0zTXD+dUKN8BMnzINVTk8Jq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDcvlmi0tjBar+fQD5MnMHG7r/5NNePHjRo4ppQ2rj8=;
 b=KuohIEiPmBHISc80ceD6q6d2RP30vSInKZedHmhNNS27WNI6LVKtU5IXdG4MGrm05Rlp+j0NbMDCb/nFMca6rKI09p8AV/y06Uy6CLqKlRMaxbHnIzrkabezUdJLdJ2QxsC9LlrHAoFawNqKkxs7N1ib8WD5peeJ8f29XXIGNpg=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:28 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:28 +0000
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
Subject: [RFC PATCH v2 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Tue, 16 Mar 2021 16:11:35 +0530
Message-Id: <20210316104140.878019-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316104140.878019-1-anup.patel@wdc.com>
References: <20210316104140.878019-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.218.45]
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7031f415-213d-45a1-4dad-08d8e86831a2
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6377495F91CBACE51620508B8D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cI61CDkfIWb4MgVTwgm9IlSWYVtFOA0ke9yKcJ7S7xOI0gtH6F4zmY5XqBdDxK7mNZa12BknqQmBQwPwkW8wRLp5DX5gghYVRSTfYN+nb16KrvNtEzBQ6iEDHIcz4EH7QXZ8OdLaIkzd7pRlW492VkKvnZr66yjcRYZTA78mM2xkkT3xwszmYABT4DE1P6FXfCMadLI4Rke4+vE3906wO8v2aU9GYwppsVUA8EKj+xrVQgWfCt+Qc2VGqFM0CfsTY9ObzBI2szIGpL/Y+xTJZWfmDYhM0QTnYv4msmcRGv6H/GM9Yn1EJY57axOFYeD8aAXhENTeOcnRRvlWVV1ogOw0tPDwqwGgj6YIib9Yaemsg0z2O0Ab802MjA2Ue4uCR+HlRcE3rj3pfHwdFV3bxyS0WL2OwbpeLBd2lVM1IQuNbHyeUWf1I3AEt2ObmQWB0v/o8wLEGaZY+dP9woh0g42qlamq//82aT/ZmfGh44AE+b7qZO64VHhMkFr3qqv01R8xSklbJcvkz18jeVEpJ5K8p8cANy47JuoRwzthL6ZmpYCE934Qb+bG9zoYZ4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(83380400001)(110136005)(7696005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(16526019)(66476007)(26005)(956004)(15650500001)(2906002)(2616005)(4326008)(6666004)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BltdjKgx3YSNrowpBu1EeGg/1sQxS8h54BBVnOZDwIsqI56nV7FhvSSOfulm?=
 =?us-ascii?Q?KGBGmF5X0umhjIqBHSVvx/O/X5Qd65RmSur9QLNGeZiynU68cyaIHhKRUzAr?=
 =?us-ascii?Q?F1l2QEaoQysAeGjfX2aOkNtdqGHCGRUaHW8/WP5n0If2aL8Rghx1qHM84CJp?=
 =?us-ascii?Q?2Pwn9FgAeR+cZxJLutiD1XfR6c9G2RdgGlw6edZn7in1iI9oCGFCSrvoP3w+?=
 =?us-ascii?Q?6km2ZasJX603cuUj40DdbRuVQaxh1L+DV8Mc7jPP6GPZWeQY6QoESFwsbkNu?=
 =?us-ascii?Q?L6sIXsY4f6xbG1pKroxCPFxJFalgWLFjnChIvWuJfihdlmQch38tS6+pkEHi?=
 =?us-ascii?Q?LGyxs1LwDmQ0kM7/Z29Tcz7WrnrpnDQW1FPH/hlLwkose3GC/HKnWAx5nJIA?=
 =?us-ascii?Q?DlCEq3s2QcCtRje3p3fmT7PBIQfc3vY/UzxGVwMadYz6U/E0xNqIbBQN82ip?=
 =?us-ascii?Q?kmEwjcIaJBPX7VSJjhv7JRktqnALphIDSqrn6vH4x/WRibzHAg+OCuoKDHxM?=
 =?us-ascii?Q?IFEgveyTCP/S3UQw/v73mbbrw6TBjS1rb0eHV+fMOVaazXGMqjD6b2mBLOcl?=
 =?us-ascii?Q?MZxe95MqSJw5d9uSWMJgNtvAo0FJpg4SV0Vz+JkOcPiMbm1mlv53XdPLbqXV?=
 =?us-ascii?Q?tVS+yiSO5ehOHTmACPhBoAYHc74aEb8imZBON8On2HCqURJ9XWUVgLX+sL4j?=
 =?us-ascii?Q?GMyTnVwe4d8DDdwcA815WKTZhq/H6S3krWVJpAMa5X1erNK88zWEoWXxJn9D?=
 =?us-ascii?Q?x0SAd3NNtK7sdWQ6XPEIeZJZaN58oZw3N1kRT7ivZQHru2aZW088oa5GxHe3?=
 =?us-ascii?Q?2k1FVDbiXvmGkjM16KdQt4PtSkup+Mzmu2zcm/Uct8Fl8f28J34VfUZ5phzl?=
 =?us-ascii?Q?dUdAs4OGMbqNnjODAvnbiTpCKO49mOO7BjVueqCO2chPVAguF+86j/ACFJFb?=
 =?us-ascii?Q?Dv6uKH3VRj3pqRHJ1jxR1ne2YGh6PLHLIXfc5J1OeMRkrcfW/gVUw/a5IYei?=
 =?us-ascii?Q?HjR/WDcw4rMtTJvQnxV79CCIe3hDVb/2/7P0Xge9l8NkvsyMU61sTKQ8+7DE?=
 =?us-ascii?Q?HLIiTc1KbgOdmZ3gfLPZKZ5KwuKuJ4tLBaKtLMORBYVTcAPi/3c1rT2m2CiC?=
 =?us-ascii?Q?D/yXH/5gdxWxk/zJRTP/FpCDhxsP+ZquOyPISHUJ7tFGwFW9KIizP/LZORAI?=
 =?us-ascii?Q?nwrhbRwux+0zQvom76+Iyjw8ToslWLN2cUIKFwrWZzGGkGZVROWNRxE1m6+z?=
 =?us-ascii?Q?UYeTGCRTvCcHi9zdKOSkV8EjR4SlSoxCJi3/yVoUc0xClvB964RU9IB1d/Pf?=
 =?us-ascii?Q?O9tNW0TIBxDLxmqOeBVbSecn?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7031f415-213d-45a1-4dad-08d8e86831a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:28.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCtGUeebLfgM6MZnVoCek4j0Su/rbMgY0zDiGnwBjCQ4TrsHEUSi0dSwgiz5EcKOhK+YbuNOSrwMM5N5gLHuow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
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

