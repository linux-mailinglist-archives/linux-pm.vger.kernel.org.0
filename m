Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121F428877
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhJKIU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:20:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26738 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJKIUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940335; x=1665476335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pvvOIQks/6wRFP+2KW14fyEGLlAzzh070+OUPA0WSmU=;
  b=YlJ89vECM4RiwwjtrkZZjqcWAUtOYVDvaz57KJmpgMIpFJhUUgV4qF7d
   DyYg0JIYWcXzoaFqWoAZlJBq3z/+3Z9yVFd2hsHBiJzyJHbog2V5eIQTW
   Cfi8PNiWmNA6DgfSn2Ny95Zgo42fUwEiA7Gdfq8LcnMkrlYHESeRs7yLx
   5rzFSbVY4+FliR7PqoxNvWQQiwcI84nYhEMtiZktVorEgTdghyGJnQDq2
   fDfwtIbzhX5iXjo7u4xDCdjaNPhzAC4Suo5h+jSvUe6elwWj2gIA+x49c
   Kb9zlaEKrVuEFlL+NLT6/0fZaJD72CHOVwmjU13PEMbY5ZvQoJXkym8zU
   A==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="294191258"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:18:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSjZECtKqisO//XGnCrQolweprdJeUKr1qIfh+uoTOx1RbzUmxy4sroe+apUH5LzWmK+0ptmrink1DOBmZEjyorbZdxSKIWShrBjE+TVF72aOtqylopiIA7WUP7slb+is4Zr+p1ZwgCadTWJLbhwB+ctI8cJLlMxKjeeOSWKhwIpCNBBaYsfGZpCvi99GnUrMqk8QMnpKTvGC7bijAkgQdSiXaSipDJh3yj3JIl5TCu5KCTXMKTrcSGawyNcElEi3vWkGw94DAah/b6MPMOHN67RWxVKsKdh5rCqC+Pzt36oDl+108Vzjkcx6bnrJSHaKhe9zmXYyJ4zV51odYVmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+oETMoIfQ9AAnsUkPjL6eDmXNEzNa+E8ckmPglGmcU=;
 b=WZFThncJtLGTceYndh9sVnZgGO2fXnvC6eNBVpIkvSbyzhYj07J3OWterQsvikN8CtdVP7odx3dsgDRdKN+cuELSQZMooTHuVgR5wZIkVeAt3VsvK4Eo3cJLBJr8My7++rsDSRGvCEKMbzM4Gzu1XyczYabcKpUyKTFj0c6OrHO9klZmh10hGkAwuw4Q7ab8sgfLoo5hzO/xFJfWwjYfZhoR3AYMq6yW/olEYGVFcZTr35Xojlrbi31iZy3Afej2AM4m05BLXfmP6l9u6AI/oyLZwguXm77lpGusLUFFtTeO9De0QgJ99Xb0RDmiHgtds8RQWQfEKvc6kD+1xluhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+oETMoIfQ9AAnsUkPjL6eDmXNEzNa+E8ckmPglGmcU=;
 b=L6EYhK9UFjbVjlCmZbcSbUSf0seJB5PPcS9ASwVn18xlPcDJiFu/1iw/YIMLAlZk3YDcV60utQeMBjjnFJaDPJxS0EFRgMnte/bDOljC8IMy65RWBt6Zm03T53udai2w9y7kuxvN2BmnUiRlPWVEx0ZaxrsDjKs2otFZ+f6M0cY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8331.namprd04.prod.outlook.com (2603:10b6:303:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:18:53 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:18:53 +0000
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
Subject: [PATCH v8 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Mon, 11 Oct 2021 13:48:13 +0530
Message-Id: <20211011081820.1135261-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43dbe2d9-f419-4a92-2662-08d98c8fc323
X-MS-TrafficTypeDiagnostic: CO6PR04MB8331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB8331E1F12FA3BCDC1FB61CD08DB59@CO6PR04MB8331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4eJ45iqp2rbX1rDRZFmYkbuN94Rj/tG4GB3rRJYCV3sHcOo7/zxC3ntr8dQnLSsGCHPfGf1Y9Y29gYHf3EJRH6bTW33Syt6chJbmctUQDt7Ak5gC2Af87MhSWDgaZDKQU/PbDOBM+mz9w1vr1bkeVFw7KSUb086qOHH6hKUCVgt5lkDrXDqqyksTdZOXUzycWGE6bFnEffVWB64HIMf+zEJzPedxU6Z+OttrMkUVgDe2/rRIPA/1T8tn3Tn39Ln6fHTPuFwuX7k9uYVwGuhtkNKxtOGPNxFpIFMDI4E/ufpMt9aKplJiCZu1CWFLKDmKAKe01mdsV1N1ig5KMyB36hYb/W4HqS6fTaiY+s+8Y7qgSGN8H3XpLYAw4C2SJ40SdrYR9cbyr1orQ51evs3DDzu8vqDXJaKZOF/39Kcz7bhXVHVv5KF5gi01xF5vzLIddT+48Z99FME537HoqV9V1jmwQf8rqlPTrRoBPd8qAQhYrf2HXn24TWaosNJgm8+R8ONzeprOzOzayleFSntqdhe0c2/OtTvITm6C1d0hnaaiG2z+jEtU0RDKqz3gHEij4lVZaENn8jI58N0JyxX5WrPyJdbD+rs+ZyXOnOax539LFsVffSzsspxWcA3CWa1T1JTL/zixNmrW5uy3FhuX1NX5b6DjMae5Cd48qSKCGbmG87ivMsgYUrHhNOlYrBz8XX7hyopdUcik4PEfI/SBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(110136005)(2616005)(2906002)(55016002)(44832011)(316002)(6666004)(54906003)(5660300002)(83380400001)(38350700002)(38100700002)(8676002)(26005)(86362001)(7416002)(1076003)(36756003)(508600001)(66946007)(8886007)(66556008)(4326008)(66476007)(8936002)(186003)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nu70Uc2njrs3T84P4T+0bm3kdd1HwXpWtUSapdKcOknEyok+UOEasCBi4xJ8?=
 =?us-ascii?Q?sgZ6iph4SgWv3dzmkGgocS0I7oevC6535z9ebIx47Rnbg/hC9sLceQhh7Lkp?=
 =?us-ascii?Q?3+LJwF7BbvQm+LF+mX2ORkiNgDgm3gSVNtoDalg8B/ciP9bSS3/fCz/lNuGB?=
 =?us-ascii?Q?/pL2b06/v0m9bYFJajpINijUiBG2z4GlstnXw4QRlpLxsYHl+UdqVX+Oj6zp?=
 =?us-ascii?Q?OLp+xc1s5Pya62KHJ0cFvksyUC7+P7ohP6mcM9e5BF9gPv01Lrpftc4xsXLV?=
 =?us-ascii?Q?u1XO7GPA0TzToRXvE6g2fpK8vuzNaaRX+OKNQSorEcWsTdQPnIGy0CYDXCV1?=
 =?us-ascii?Q?kyIjMZuFjwwiXictVR+gxnpq2aueifA7ozw4DGyj6QFExpMPdPztgngiDx8a?=
 =?us-ascii?Q?4asezGF56AzlUIVBv4JvFQZzf42rEwTaVUCXxytibC7PQzLJu2sRqaPgquAK?=
 =?us-ascii?Q?FRNIThSwwnUSoz2PFV7pIy4YrMx0CvO49seEKuWQ8GuRCNGbOMR/mtPkBZwO?=
 =?us-ascii?Q?c9C76mWeXn+bgcUHG9k1JvhG2UO9Ld3NNrYXP2vmUd7LAjetdCOEgZ/DFhXY?=
 =?us-ascii?Q?sNfj4IGp/inVx4ZASIlU4NVwy1N6hgkdTFmItkfbvw/IHZmn7yZzZDCZ9f+r?=
 =?us-ascii?Q?7WI85mWgJWpWi7K7S7zsxpd3DutodUadxLkXCf4ETZrjXCZTS6LgXrm09M0a?=
 =?us-ascii?Q?/un+VCDsU9pIsAYc46+8grt/dd91rpwYOUQ8QR/aB45ziYDxwSPPGii+mj+1?=
 =?us-ascii?Q?moe6n24NJZbrJkDcz/A0KnFJCzZbmmJtCgrgHNQDMx7rwQOnvMWBTUtlUMcY?=
 =?us-ascii?Q?mhr9bmMAp/axrNnA5iqQfBgm62dUwGdEBysKBUkhLa74AuloP7pBzJ0p1+tM?=
 =?us-ascii?Q?SENDW9rWGtxDU1TjAifms/RihprwSY/i4aaYGHtQDL9cNHKICPagAPUhKGjr?=
 =?us-ascii?Q?YBgZUG9nNZKDGxg+T8pRlJID9LnVkHtcphhZXxSIMsV35T1Jawn9/KCTIXWz?=
 =?us-ascii?Q?kE1oTW4PDHq7Si20AE6JsZHfgr/8Z3QDFRK0jw2xWUODYDSrhDqefgE/QWdx?=
 =?us-ascii?Q?CHvPPnbDjKqghUrol01vei13/xc+Vo5K0t1WOAsKlkjKie4aWNVqN0tMS/oE?=
 =?us-ascii?Q?uPGFIQO1WD8Tq0Hp2wVmoMj2gpouCI1tLIcwUT3mTDMnsf6ndLxFcWSV650F?=
 =?us-ascii?Q?K5LesUvbivzw8LfRCrBVIAVR61uvLzO28KrN3pOHhdq4dDXtmG0C/iiC4Z6F?=
 =?us-ascii?Q?Via30WLSq9cw86cSypWGhVd1elEY2F0q2qbrrT8eHk7wzpFKbzGmx46rpY1y?=
 =?us-ascii?Q?rC5mxfXlfbvrkOqSnQ3QFlyC?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dbe2d9-f419-4a92-2662-08d98c8fc323
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:18:53.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSa1TPvwJK4uDhBRDJE8wrL0D0VIzy/5zEovFMQM9BSn6JhCCoRjr2HqQSKEGGPjjVSblGyEwLP+20FkhRSiWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8331
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We force select CPU_PM and provide asm/cpuidle.h so that we can
use CPU IDLE drivers for Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |  7 +++++++
 arch/riscv/configs/defconfig      |  1 +
 arch/riscv/configs/rv32_defconfig |  1 +
 arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/process.c       |  3 ++-
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/cpuidle.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8de2afb460f7..d02f1f5a2431 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -564,5 +565,11 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "arch/riscv/kvm/Kconfig"
 source "drivers/firmware/Kconfig"
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index be21f54e9b91..39b4c32e7997 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
 CONFIG_JUMP_LABEL=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index ad01f50c98f1..fed827c82a9e 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
 CONFIG_JUMP_LABEL=y
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
new file mode 100644
index 000000000000..71fdc607d4bc
--- /dev/null
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Allwinner Ltd
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef _ASM_RISCV_CPUIDLE_H
+#define _ASM_RISCV_CPUIDLE_H
+
+#include <asm/barrier.h>
+#include <asm/processor.h>
+
+static inline void cpu_do_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+#endif
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..504b496787aa 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -23,6 +23,7 @@
 #include <asm/string.h>
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
+#include <asm/cpuidle.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
-	wait_for_interrupt();
+	cpu_do_idle();
 	raw_local_irq_enable();
 }
 
-- 
2.25.1

