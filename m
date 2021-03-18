Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1A340656
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCRNGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21358 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhCRNFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072749; x=1647608749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yTb4qoGUflJi8m7HSJa5+nLEjyRfrdKGIcYDXHbPmSw=;
  b=kw35lgNNiUSWD9MtDQDoKn9Pt/3WufI0WTIA1zLA6yC7/Z7zBFNk3sla
   sNiQsH8gGUV0i2VEaXK/xI2jPusla2I3duUO0YujNOd0CHzXfbgjKHlV4
   GAk0lGN/9DH6+D6yhE19UAvYvBzhv8GJZ23wTAnYIqKWlt7QkiDvNwN0x
   JrE58wTINARs+OJX1mV23zsoxIg/54Mng+qhqMrTlqV48XmHt7Av1GX5E
   +2j/aGHlsPHMg1Qd8pAedRnygqbICSwBfBR7D+wLa50sZ6T1fpHcTVFWG
   xnh+4rcTVvwc4/JM7y/b5bwjtXAMr0tVpsPr3kw0DA451ogPFryZtz2IE
   g==;
IronPort-SDR: u0wl6+b+ywKEv6tV8uv7Xnqz9cpRscbmVu2963x/O7+QNhVxZydqUTGE2QKCqVJbBQsbkG76/F
 CKdGsed2B8BihtLaombnn33mPDhsFm+pw5aoKryWNVIpHK2/m6Lwlg7T4e9r84+r8bP/Hyl5Gi
 KVwAy9z9ppZUJ5yHgbza1yh7tbFaiccuWpS0oRkDlZmObwX3V2lup+HBptZ53s1kWN1SjjbKDg
 cogSMsFfHTeGQeIDnWYiBvAQ6EarrbU4pY3Hn8yZiUvMkLMGdN3VTr3O/0myKyx8Xt3vDsut/O
 oN0=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273192076"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:05:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecyXH3LRsUGGJK4fUV7UmP4wENp+SMMJ40yQCRRbvLQ4gIt83e4DGKMScLHRJtTe8LvGaI+Vv2QUmpJ51oxb2LLr5jBJk2svAF7ujcfh9aoEQ7DDE6yKXQc5QwBftcAV3fhVhkZ2BLlXGMB0wp76NKPd6WXa4tIFMEv5PJ9xediDXdeHx7Iydl2tg+ltytyENtx+CFS+jvk35S9gxh3AO4KeNSqXwbDdDciCWu772Ul6fjv5oaM4qi4uN2thJPDZdiseFnlHJwquWvsu5S1IIqfqz4DnACvqbphnUa8RT/Vh6hCcEiyOb0ukzSyuJ/oelftxENiXjtyo4et1rqbFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvODrHxjR9O17ndKUIDhzXHw4AWnkKpIZcsCTapVmys=;
 b=HMzZAEiG6CAFt0jrUrC+W6Pnkal+eQCdyIa9u9wikkpT3+qQPwZBZy7TgVlt3leeMy9db8A2lIEJMhk9sIXrRYqRFRDXc1UAAFV1GlcL6Mv5z5/YXpYf/dh53T8D/hDDmQyHn7eXwmEsc1ADcJhCx6wcVgFZmeF5GeCcnnSrhDcHJSscOKUq8RENQE1b4TpqH1FbT1x3axDvsVqUlHfJC+SmqH+aEDC4O/jXQRj7FD5YynjJ+J3yVVW4l74bm1XbfCYj/5GMzCPSxqgY4WCzCZUKYAHAxp7x0c/8t91e+k5GWMV/Oh3oHl1Akk7CntVeZX7PTCpWSKs6q9aSPJ7aJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvODrHxjR9O17ndKUIDhzXHw4AWnkKpIZcsCTapVmys=;
 b=Gnaht0D/y6Y3dzwt5sskuyJlnR2nZ5E7e+XgFVXavLjGg6NN97YwsEi+zl9yBotq8XN6skJIv0OQDVGRXzJFG9FSQ1gCZHAUuLO323jJGDsw+v1K9DD+gFg/KTiJjFMmezWkgTClFOHgGlsgjni0DkFympkAwybkvIWO0WHhdgU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:05:46 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:05:46 +0000
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
Subject: [RFC PATCH v3 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Thu, 18 Mar 2021 18:35:05 +0530
Message-Id: <20210318130512.1025416-2-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:05:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cb4b010-1d19-4070-1f59-08d8ea0e8bb5
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB082695C8942A99CC593B474C8D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS9w+NSYIRyJjyXY7adJzS+9gCDTk44yhVjCDIhCn/BIm7vlbRtNY2msOzR+GFgA/i7n2Xxb2/qPRjPG+9dhMa+K9jYhkCrex9fVu6SqWxs4kEiunwi12vVp1FE8CGAILUqobpcvtSGUjymIQ88QQhcgJavg/QD88BQ/yaO4yrIAoQbAwTpasWPS9rwFbwpth3B7kUSgD9mFUQhYUSuCYTekJ9BZoWbPPswfGDuqhbvK6AwD/ASCb+k8c5omm1pfZ5fWw/SDSNKaJRCbG1Sv/8vbluVhwqXBy1n19XxwipCSnpw0gvHFCfqNjkdTonfZupk87TJEvi586Ain686ahtnsQtOM7tO5jlyflF4IFb309bETtXkNsfqsNWssnrSjHLqODQbUfYL9ydVdkXCFU/XV/zzCDJ2Ryquv7EbNHtvccJhNLngL+wawv28Ti04OKiqovsh51vyw3nkjS9AUHgv374p/MD9Oh+q7zK/1IaR1QgYxhUi3hUFoobPPnh+wJkL+Zwpxywy9p7mWmXmewe0iTRGMps4qZp44ll6K09IVi4Wv3puDxdQGABDn1E5YWKj6PYGaR3qZnoTgdiPrdI+IJoeh7yJYgw3EOxQhBlYA/iujr6qFNL5UpIXZliGd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e4uymjveWFmNiTKiMEj/SB7woqljYOp82k9CjfpwVQLNANHcNY4FTphVG05o?=
 =?us-ascii?Q?rxCir+ugHDoQGyL1Skt5VsoZrhuHXSobjYunVbkWPwhv2J6HfxVLeq4duOL/?=
 =?us-ascii?Q?EKqIvVZJwCrWeLCI5zsXOvk8oFzX2RNAz55KFi93cuYU5xR22FJf0wEIECw2?=
 =?us-ascii?Q?wusfvpOLFoF5OMViEZBNCn2JzA+l47D0dBmV6VchmzJhLqShH78TAoDK7aCg?=
 =?us-ascii?Q?1dxryiMvIqzbyAgFtOxVUqfi9E2MMb7dV6A6d8Gcm3aeonXHyMo1rPL1L244?=
 =?us-ascii?Q?jePww63R1ANde1oBLif57w2YjDI/W75KvfytGTvMzykael7h3RVXsnHH07my?=
 =?us-ascii?Q?rmK/hYAF7diHVnfEjiMJitMV00uqL9SpOHvFbQZSBvsLtn9iZcOxIjXIUdVq?=
 =?us-ascii?Q?SsqWxIrcb3Tl0CySjKX929QeW+5/W4KkKm3Bc3+dvL/NiifZDgYI7Zavj9UB?=
 =?us-ascii?Q?74JVnsxZjR1Ki1odbHxxkumH3sdfxSc/id1HcVar59CAsQiJDqxyGJj29zCI?=
 =?us-ascii?Q?6VzP0qhfPyOfCQqhYIl3ppCTweIQWclcDcc8qPZgRna7qgK9o76ub6CZJakY?=
 =?us-ascii?Q?TcAb5hmlY6M9zVxgHID1Dj/4u2xQo8KZsdd7xsNAbAEFioiObbBewhrDtA3E?=
 =?us-ascii?Q?l8pdjiLtFBqf2NIeJ/5geGBFPlSGWoxq5IkPs8EqZ8yJnHyE1hY6HbK33A99?=
 =?us-ascii?Q?yna2S7w+noiGKWMjgqxBgnIC94O80ddSYqKr8pC2QkCHXjH3VN6VapXpilcT?=
 =?us-ascii?Q?H8S811Et0SNEfyYQVsE2vDO5RJdxFCgffK3q7CoYWoI7R0A9rZPiYEURCTas?=
 =?us-ascii?Q?upEv+9EwRp1bafVGku6YLDTXCd3+RW8p3E7oQR6og/3jwwOTd1+5BQnb9jT+?=
 =?us-ascii?Q?R0veHC4TgB5io0OA0yJ8PtWWCo2/SMymG9H+Fd1CiLCYfmbDXFLNKvUya9E1?=
 =?us-ascii?Q?BMT+GaebMYdPLxIRb4OsXkF3ZzbPX1pemwI9iemTWiUS7Ajj1B0DXNdl+576?=
 =?us-ascii?Q?kF4uKXW6mYvwpdI7RKC415/4zNlYjTmYzczJ4uvoKdiCbRPs0/Y0fxenlq60?=
 =?us-ascii?Q?ZXM9lidXVp/KmnY9BBVJnSyTj+FHZ2/TKSBcPNMIOel7vqdtPeOA4jchhGci?=
 =?us-ascii?Q?zkdz8uPBwTFREgdex/3vEibwhaHEII4Ov2f3+QcP6FSWFEeFKPboMVoLQAkX?=
 =?us-ascii?Q?liX9/9OfaCkRPgBa/0JvAySjmOvqUvrWw1G4zFc/PTwKlDJVbkHovh1+2DBS?=
 =?us-ascii?Q?zOpr9txRHkIEd3DgbpZ2zvVVXpKtDJ2MzqjkJaV67HRf3GntxCdOaZaHoCV9?=
 =?us-ascii?Q?h560Uof4SndHhuGIjspWA983?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb4b010-1d19-4070-1f59-08d8ea0e8bb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:05:46.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIl2+K+VK1t43E7LcMXPsmhPmsQdISpRCRlPWMVq3BV401rgapfKHoMnke1kev08+U/J3X+CmBQQP5LI+kAF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We force select CPU_PM and provide asm/cpuidle.h so that we can
use CPU IDLE drivers for Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |  7 +++++++
 arch/riscv/configs/defconfig      |  7 +++----
 arch/riscv/configs/rv32_defconfig |  4 ++--
 arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/process.c       |  3 ++-
 5 files changed, 38 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpuidle.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 468642c4e92f..19c9ae909001 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -475,4 +476,10 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "drivers/firmware/Kconfig"
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 6c0625aa96c7..dc4927c0e44b 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -13,11 +13,13 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -65,10 +67,9 @@ CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+# CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
-# CONFIG_PTP_1588_CLOCK is not set
-CONFIG_POWER_RESET=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_VIRTIO_GPU=y
@@ -132,5 +133,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
-# CONFIG_SYSFS_SYSCALL is not set
-CONFIG_EFI=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8dd02b842fef..332e43a4a2c3 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -13,12 +13,14 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -67,7 +69,6 @@ CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
-CONFIG_POWER_RESET=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_VIRTIO_GPU=y
@@ -131,4 +132,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
-# CONFIG_SYSFS_SYSCALL is not set
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
index 6f728e731bed..dd2ef18517f4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -22,6 +22,7 @@
 #include <asm/string.h>
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
+#include <asm/cpuidle.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -36,7 +37,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
-	wait_for_interrupt();
+	cpu_do_idle();
 	raw_local_irq_enable();
 }
 
-- 
2.25.1

