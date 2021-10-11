Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8289542887D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhJKIVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:21:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7060 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhJKIVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940348; x=1665476348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3aBguAwg9xMnr2f+k1oBgzfaOPMtOKsiiTw1UbpW/dY=;
  b=a5bL0vwSDO394M5WWkmPzuP/73K5cz5UIwcwzeFMy4RLHUh12Zoh6Arp
   C4DP07zAQtVghki5zC+sER40VfAZ1YDert0aBYYukkqZPYkRe4C225+Pk
   CBythKkl7oXH7EiAI1tmUN2gyr0YYFAQ+aG5Kd4scHIy5GIcYn7N4+6Y9
   zCGcEHBj6fJVXQNm+vryLsv8PtK6GyxPIVytTEQBZnvuL0/Pg7kTfPuO2
   9cIteHLg4/wAWwDtjRmw5NThj+Ih6nQiMM3gpPP1sKm+d9VcNPKNC+76w
   msENO6ix4KuBpCHj99Xy8/mIG3Vl3/hOC9UYbAm0dsNXclL3WcJCxKqbo
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286313137"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlgPL0qGWfqsJIAVxqCItEaDwhJsp6aXbVnRwfQH5iRuAfzcBXEtTSuV5qXoI1t3LwAGOABJdbi3+xwEvToOYXIekxcknEbfCE4Kwc36pqtz3WOJRVFsNG1Xr5b6pskLRtlLG3HrT0D+U47y8JOM8tchkv/UeDv65SwR9V/A8pEii17kU1f258Pd06x+s2hWgbHDUnYfO+eUdDKGlGadCm75kVGeqxmA+G9PUvOTAPNjL/29Wjg8FFcOtspbL1hEEiSclCksqsUcYfz4YD+62jiplnjHIePH2X/R0+BtpyDTp8wkzdHfaO3Z6+E8GEdd5M1lY/MNhp7i2zFqaz87Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKDoWpDNMDiyvXMc22rFHJbNo7RkRGfnzHBaY7psMQ0=;
 b=cwi4LyCTi1CDIBa+n82z5VuFscxQ2l+KMqYkHqaOYE5oNyYeVz9xbkOHl6PDdyfJY8w8UOHT5mGFOh+n1V6Oh/pjMlevVHStMQT3QakOV6ZsqOCblTBUz9SONkjjQ6Ki69avrli/gmH47k5dyGU3xB8AwgFJcl1GHe3Ag7ogGFxY/eFXL4kN/s/AfiO29piD9WHkspZ6w2MGIZYKqNfnb6Sc1Nats3QbtNjs9TNiYX4H6o78gEpqoF0fjYoGChtSKEI7U0N83yzoywCMqskU9padbHtn5ZR92zVdsM9EOGEEDM8cxb3sFKfijyB2kOjMkQ8KW//zwo3PkDrRHsQQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKDoWpDNMDiyvXMc22rFHJbNo7RkRGfnzHBaY7psMQ0=;
 b=Qi6bL3shlpfoi1fVzDr/NMIiLvnrylQZvgOcXEqz6XwWqwA/nmtqYDVJUpifumM0S0+ugC0sJPdse6l+3Whkt8JwvjA/3uzEsgfkFYf0YwdLsJIzhxUpW2yIvpZ69zpnQzjWf44q4fpuA+PJaF/Uq8XlJHQuyMJJT4AJpuLnxvc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8345.namprd04.prod.outlook.com (2603:10b6:303:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 08:19:04 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:19:04 +0000
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
Subject: [PATCH v8 3/8] RISC-V: Add arch functions for non-retentive suspend entry/exit
Date:   Mon, 11 Oct 2021 13:48:15 +0530
Message-Id: <20211011081820.1135261-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:18:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95435e7a-3202-42da-6f90-08d98c8fc96c
X-MS-TrafficTypeDiagnostic: CO6PR04MB8345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB834567234B4B655A59C0D58C8DB59@CO6PR04MB8345.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihHGREts8Z2do7Ur2vyPyWfX0O10RAIK7VZTBeEXv5zJNqILAgzAvlj+AeVZz8opXdz8sbvL5eHtm/B9/FjGxg9Ev1los3KoLHGh1CQEMI6CzlPRo7nT6V7kt+dv+pv6wccSKjW5pHByofNVOOWPvyAplV+OP7NWE+m3qXk+fLVR8tglM3pSaAWY2ZA29jWCTan4K8Z17m7MUGfnZ7EL2u+b8Zoo8uPeoeFcAw+cTd3kBBM0HQ3oQGKw3cxvgyNvsSFs+TuYvUUB617pXwMoa/2u8OaXTEtzPGB5V7cz0tXw0HC/TUR60/LdLxCHLHb9cIQLUAmpv+3zuAodulCd85YWT6UIl+TlJMDecUrLGU0TPQ61XTXbcmvmVml/FHzMOKxCnZexBtSGqefOB8x02+C/WKhwbI7+edX124Vyq40nltEoWeEInOthmUGYthN/hZk6ZNx08vRBGTkR6h0NTMqR263a/8j+QO3wS77Ir6/jFQrH52cTlW5AzI5K/GfXcfNWq9dSEC8tWK7lqJ2+VPMzETpo6Q3KWzjbOUtd7CBS310jVs7PLN0puG4Jt1Et6EZO1IuaGxWG461c6oq4CO+OSSijclUlM/GguUAke8QaOmpQAymg9rSMJw7vbABjRQQcLYH/Hy7/KQRIkASM4dxIXjw+PEXk3rnwine1zkKAh++9YgP29r8Eqgp46ZFTVBu+oKEs9BvPNmaoWIPN7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(54906003)(2616005)(956004)(5660300002)(2906002)(26005)(6666004)(8886007)(38350700002)(38100700002)(110136005)(4326008)(8676002)(508600001)(7416002)(44832011)(316002)(8936002)(30864003)(7696005)(52116002)(1076003)(55016002)(66946007)(36756003)(86362001)(83380400001)(66476007)(66556008)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWm6OWkz9sp7agulNKccjKnAPny/sZye+pMHFNHahLPVGMiMGaFAzwlHos6W?=
 =?us-ascii?Q?/8nX+HvCVpJvD1qLYfMcB/OhP45KZjipfHdLpyLpOdSfVoVgtDrsAC2NECyQ?=
 =?us-ascii?Q?JW6UbqYXrg3Bay9z75CKH0P79+MsuOszV3iVLaVr9tH/kHYaMMNHTg94yKGa?=
 =?us-ascii?Q?0cEZBBIZkwOV9j3zOswTAkV+oW22MxlkkfOWKAfnogycBum4WckjB48pIpWS?=
 =?us-ascii?Q?PYsNxat9j+fwToO0EMYt/wK2A8BIz4TMTHCZ70AwZVC9hZSBh14/5n2rg8YO?=
 =?us-ascii?Q?E+Wdb59cZM6jSxnw6EqUjo/spqOKQRQP2+h6gNVp22kquMNUc/TIACJO79aM?=
 =?us-ascii?Q?HqjWknwxC46AJsm8h0+N8hEHCxNP09xQNLgcMiwDaRu2qKf4sMnbfCKJoZD2?=
 =?us-ascii?Q?TQN5izTevQYdSdRHVboemsETBm1dSglmopsrAV7VzTc6dWps1lQzVsR3us0N?=
 =?us-ascii?Q?Q/fp3AqVtaYiL3KgMIOfioZrfms0FKB/rAXG5KQyWes3PMxokdQx6dc6cl2y?=
 =?us-ascii?Q?qdYT+SwxxQv5ROR/c8zqI1DfcDMS+qLoFOi69UTSCfMHwuPv2UjBL61JYswh?=
 =?us-ascii?Q?bgiOeXClMsHNdgSyIbX1qknqM/L82qbcFIYcd+fLn9XfeXfoIzbMjGHj3axB?=
 =?us-ascii?Q?e1KPJTB5AJFRcsjMYE9BjGlPCGzclxCmjGn8vtG3FsDegxkfu5N+C3tUYTMK?=
 =?us-ascii?Q?4HoMXo6XFVNe8wqnpzzSrNMtgOQIF8RF9kocyxPVu1pWJGBYHc10FtiuhZqw?=
 =?us-ascii?Q?miuUwzjxRG+Qr0l+YObhiCEen6exFO+FQ6cSTl+8iL6AzViSnV+S4+dmXtNy?=
 =?us-ascii?Q?eEmcK6KJGeJq+KcDkl4kyFbNVBK3B7riUXbX4fqrJYbv25BodSKyWmXJqQ1e?=
 =?us-ascii?Q?FVOGzO5mQdc3Jf4r3ooOfY9R8kj+9KD1R5t54VojP+bH/VsSrAkp3nhtzK2s?=
 =?us-ascii?Q?N4frL3hAqzkjpXYu7s/yGkC2sGoQ8twxtCSi0ItWdIpZD3n7m2KPoBmRZgZW?=
 =?us-ascii?Q?zEBfEifCfHIqU+dLEilJPtBFOmXHKYEanEh1P92kFLOENuRUDZmezRtTNnhb?=
 =?us-ascii?Q?ECPkf0lbeFGrQXvpb9R5K5fgvvTtEdx1cnW6s/NWB09gr4UUxOKd4ydAZibq?=
 =?us-ascii?Q?Hl6KrKGBb0XOFqFLGzOS0uBOFOjli04hYGVmwZt1iFFKMcdR0QAdIzntsDn/?=
 =?us-ascii?Q?0Yi2vdCqalTJlzV5Nb9RvCyUwoZaI6LUJ0aFgNjAbtlYWA177rs5DTw/jRRD?=
 =?us-ascii?Q?gKLoXbJlgtDlTfiAY0sSa7fqV+MdXfmvoBABR14zGjo6NJPXy/PT0sbyHfNj?=
 =?us-ascii?Q?5u+q/JNuQlmJxJjWIRUQdk7g?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95435e7a-3202-42da-6f90-08d98c8fc96c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:19:03.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsVconLBuwsXTMUVKTRMWCD8GckgWv1XMMf3koQAdg6Q08uevOVIWGvjzH0AD0DKiyu8T6Lkvvy2ulJS7Z85lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8345
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
index 38b555edb2ee..65bcd8e344b6 100644
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
index 24d3827e4837..47563a191951 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_host.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
+#include <asm/suspend.h>
 
 void asm_offsets(void);
 
@@ -113,6 +114,8 @@ void asm_offsets(void)
 	OFFSET(PT_BADADDR, pt_regs, badaddr);
 	OFFSET(PT_CAUSE, pt_regs, cause);
 
+	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
+
 	OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
 	OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
 	OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
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

