Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01078320969
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBUJjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:39:46 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6893 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJjp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900385; x=1645436385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GSyq46Kh386vlSA7f6N79b4W+09hMrCXcb23kedwI88=;
  b=phxcEYCw51gAkZaG1eAbMZbNeeWbvNlmqpKuJAj7k8u/BAd2m/3cuvxl
   4n/3u6YgcRJaSMVFWZZmdGcV45kQ4EC+Y8Pd/XxFqETqfvD4l3OAoFcJ0
   1L2LqbWCzFkZF5tK2wvZZ5UooVfSwEsOVS5dTTHvVP+Lel9ca9CgrqgmS
   NFdr5is27OyhCelE13hB3zHK+/qR1h69cmQwkvglounFl54WBp80iW/vH
   eacbxZCf8NLuJ3mOw5xdX58OXSDgj3pNsZUbDIuxzHbRFcD1NL2EgkbB9
   h4gqYeVNEvSMSdhDonI4CyN00eKhhcE/Q2Vv5hfyVVdI/C4nIVmw3IBhF
   A==;
IronPort-SDR: WtJYk3jRCVFT7IyfIumH9Jol6rEpPCe1MJKnY+yjPno5gPpHmkXl9LSjqcHgpxpocLe6rcZd70
 NGRxEdqSoAQKlPKqR7jyv2Lyi2rXC+RV2W/3AfNGd44mmmNFd6alC00n71TPqrztogYzf6RD6E
 TA6rHxUFhXvwOe/OfmVbUxDaXezYJvH87szyI8yUOGsLC5ZkDwXD8IzWCl+N6CBEGdR+XUOeFH
 v7Fd3zl2NpTdX83YXIThgANAnMEd3wtMvOJxW3goJgua5gNufOCbdDfs1Xx4UoiDaTYTbnEz6R
 uHI=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="161607379"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROiJQnLYG9GrHYLvFjmvwEL4pXtUOYmWEvdn7XOUuuasZM8qfJAqEu8c//rnLr2Ds5wuZC3Em/SopUEIVnzy63CxRNEr9DZZLYlW7q6e81dkHp5Py8FOiDmtff2cDGo7MWDVks2wUOzX5GI9EY8r89yOFZt45TwpidpWqr/atuLqoWecfNQJmduvEcyQJ6xtBscl1JALENE0U2h+B5k7V3DcQjXsJPmOQJR1fLoKHsP6REqdlq3FYtvvTsCrutnzwuX0glUouFiXbuzdesRkGUTcAqiMMiEaOlrw9//IkeqU7WYQ1Wl9ANFLUvHx7ARI7eLvse2CvuoTZEAdYNZtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UOxOXZbmPH070jMsqjDi55WVPIG9EK1c13OHU28ZG8=;
 b=aeJ0WWvc+8ymUDGt6hFv8lAXXgTUSwpxZn8CJ4uQ4EOjjLtpb9DBbFQ6Bcp0LwoX6keIPIbrOKnOhRGdzqAVT0a4PSR5YnyYcxRkM98HGk1n+0sPyLECMl5mJYi4+rloG5qeUqC9vbLKq8O1iEh+4Xk4M/EToNjVpUJJWqSpfkv/Wf58TbQTtvin3yNHoQYwZ9pFdZoCOcDHl3KLDjMym6AOJ+xAdsKF5bfUOtx5w1/Y20MkcxwJoOSzKcOz+25h4KCJrRfwIuK99K9n0yZ2hgrxA8EhJSQhvzkUKaTfsqtaKeePjNUfeCfQYo5MctJRerA4EBzPe0rJQBsjgDej1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UOxOXZbmPH070jMsqjDi55WVPIG9EK1c13OHU28ZG8=;
 b=VZjiJtKn2jU4UzDNLWgWIkvkobuXbZhqMoKGi9tdIbcAAPVMNDQenOPzOdnSqio2KvQ8m+ybgQqAzqXKIdUk3emQqOFCuBhm7BHFacOoOxVulFXizi+N5uVUZ8CFfPnXH9XdHgTq8Ps7RXFuIyg7FaSeysHSSkZdtI0SbpOO8Kc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:38:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:38:36 +0000
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
Subject: [RFC PATCH 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Sun, 21 Feb 2021 15:07:51 +0530
Message-Id: <20210221093758.210981-2-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:38:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4b777bc-c42c-40e8-741a-08d8d64c7633
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459F7434745FCE6A197B05E8D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8LhvY7TOTKBXAfWbxKBvI2EgUW/yWyK2KUO+3cZQhal3RXPmnXrzOnOysDHG7iELeUOrSB2BWKpzwc51uuxYpK+9iJ7Qpy/82W9Y6TOWB62opJrn9kz7W/37EJoGbN8whhh1tEKUYa4glUmgDmqLyLF+1qMQdsKo8dU0ys514ox/WetJKpg0E3pUEY2RmxanHJ0m04xWZccvz9DnlMZ/g4I2h2+LamI4LDHyQ6iQHWyvfIQe81BiyrrB/TDYfGqklNc6KC0eZYWy48a8LrwftHboci7dysB1tLYZeRxwzPwst1tLIMPb1Og12yaWOvo3w334CwhFKV+gy8Tq3lQWwhTINAjxuE7kfZm4184yulOhH7BkpuzrL+iOAANgfAyhw076Fr+UDYWgwn/orCsus3YbPOY5ytHuhlQnFa4AuZKqLBAtL+6LS9BwhZ9N9eGJ8Q/jeaaowv67o6sM4x6UFURKBvlMmgLQ9aBR5N5yfnfymkIjYvqJEj3F57spmI9XeCU7CihcUbxilL95xrwoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(5660300002)(54906003)(110136005)(4326008)(66476007)(36756003)(83380400001)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RUZAMJOXJDMqTCkCKvsiB294w5bocfbScPvqpg59jA82hm1YHeqLTR9YNEZZ?=
 =?us-ascii?Q?AyslXB1q6tBJVgs5oZxyZYTv8785hcjnILCYZ1s6Brgq2fQAQq90cmlaIgPc?=
 =?us-ascii?Q?5qJP5sOafdDOvDuNLYeEguog//U2v5JmyJZsF+F3+VYkXLG5vhrwPdU9DUBW?=
 =?us-ascii?Q?fWynzHCwzMWdyIJ6F9neF8hoZjxsoo9lMOuVofgUDj0cmi0+EG1NSoI8sBmY?=
 =?us-ascii?Q?jT5bzW8qEOViIN5BWPMWyfB7oIxN0kGF0475j4QT7aCbsV2SwwIVb1Z3m+ri?=
 =?us-ascii?Q?NL33oZdJmcr7cDE4teja0KIjmuKnVG543kGp0kEYJg8wY2nYsyGzTdBds6+q?=
 =?us-ascii?Q?wn3Hb2WqH8bcRQAR6/5YiDf+Ude+cICQMKB80xfHKwMRxzIMkxaRSHVlxHxE?=
 =?us-ascii?Q?y3z3EC93SV1yeiGWMGtF+6Jgq5zDoGCmMzyCzw/KdVynuY/Ga0GRjK34TqcA?=
 =?us-ascii?Q?L1qqnjMVYyXOn45aulO8InzGjFCfivAIhu5wYa9UIgD5C+OAs/uAbHEf7MO7?=
 =?us-ascii?Q?cji3r4bNSQXgNtfT6kmeGy88I5Q6jUEiJ9uduflKNgIsksv//43kXgToEcgm?=
 =?us-ascii?Q?DjI0lFPB+oVFTMi8rkEinjUkx3vszXYi8xFP5aNzqtwd1lwRk29nPMRyQlA1?=
 =?us-ascii?Q?6RxFoIa5tn/Glbl2dJaQafY/JYyS7X8NpKPdzZZHnvtrXPDnKHPtIjFND5mV?=
 =?us-ascii?Q?2n9LCtboZl9zfAjwDYUK4ERFjg5qGg/rJ1ha3klTjoIpYfxtdqdU4ILgTqO8?=
 =?us-ascii?Q?cLLzTnS4RlwCrSXpeOJaYSqnTDQjAr57oKqFBAC34FSlkkZxVhfYsaMWWtAJ?=
 =?us-ascii?Q?mIFEMtvmj7zcSqoUPni4VRCbyM3MlpfR1JcJIXNR248H1SaI7TCIGPpnKXDV?=
 =?us-ascii?Q?Zw5V/fw6m3enxg2QokhwMmdRSEWCzqI9X+JNJmZfeMZ8tt01AdcM6S/sPlhI?=
 =?us-ascii?Q?c67ksOngXcAvjP91OsuWTZCoOiSlxdGXPtm3GL+Zw0x0p3mVzH4dGPcHpvMt?=
 =?us-ascii?Q?AuwgtVfhri+QqW/JrjtORVBb/q8itA12aldejMee2iS0D5AjyBMJEATa6PXf?=
 =?us-ascii?Q?PLx1iQKu4i8yxrcHu1XMdhxQI7jE6bfQOBd3PBTaC1UNVoedAHt/6xA+sShe?=
 =?us-ascii?Q?qHfl/w68KcWrzMtHdo0D3Ptu39bbb2ORoOMiB2Sh8z+FeVUuykaaKEzjHjtv?=
 =?us-ascii?Q?W0rhjTUvB2S+9Njm0DR9Gqf8kreNTTPyF+EBbRq6/aM68q2+wqtrwqRyklMT?=
 =?us-ascii?Q?pl10aXND0farTpqpM/Jh8tHPs0aYhL2d1hYu0uIVahzvznPGj/95Dy/UF52F?=
 =?us-ascii?Q?pJD4zkzfAZeBy+X3t6d0jxs2?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b777bc-c42c-40e8-741a-08d8d64c7633
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:38:36.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9rQAC9iDfHtUEHJid+/+KyKgp7HAFJA9UX0/Rgevu8s0VD2Jd0YNW4f5UEtH0zn7b92JoLXvf+P7rCI42kWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
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
index fe6862b06ead..4901200b6b6c 100644
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
@@ -430,4 +431,10 @@ source "kernel/power/Kconfig"
 
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
index 000000000000..1042d790e446
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
+	 * IO/MEM access are completed prior
+	 * to enter WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+#endif
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index dd5f985b1f40..b5b51fd26624 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -21,6 +21,7 @@
 #include <asm/string.h>
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
+#include <asm/cpuidle.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
-	wait_for_interrupt();
+	cpu_do_idle();
 	raw_local_irq_enable();
 }
 
-- 
2.25.1

