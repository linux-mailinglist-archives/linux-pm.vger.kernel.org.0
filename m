Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8972E3A23D6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJFYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:24:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11455 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJFYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302576; x=1654838576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Pu9Io5ABNyIwu1+haflsV13kIurdSAe5IlMVtkIEsvw=;
  b=p3KmEycGstiufHSU4JwcVV4mgCyQLl8Ez2jaAP+bXnpDgYUTfKoqBuRC
   b74xlk7msc8FqXOnDVjl3+gHP9zDPkJWKm4dnx1biZY2JDqRE2yg0TTq4
   uyyyTN1SDwWafnWpGUKJCxGzn4LPKTlAlWeXRtaYIxdVmR1Eea6ZFCTpd
   OL4Di2rl4W22XAn6wgaAzK+PG7/ei/0MR04BPm7z9Dbw5gcQ9KyJMp3NQ
   r2ybgqnFXWBswk7+FJ7+BLtmHyxlw6alotXovDNfvss0wom1b4AFEyUqe
   x8G6xVtyRLK5NaroRGTzWYCoCUCyUibMVDyOAR85bR2oNvTKRrfftC98T
   w==;
IronPort-SDR: QvfQ5vvVFcvHHOHEXKeO3HyVvOUch7Ft2CPFYGOBnAkfxTjb97+bal5Ol6zv1LWggqrT6Uo2KY
 X16LTR2QAWMbbEGe+6S+vXyUA0BS5W2lCHAsZuLBC9Cry6j1WIvFQyewLRk6hUV9kCYXYHLVHz
 wV3MNHqJ+fFgQIpZtGEm34C6cW74vLIWCmDLbpn+qZquEjQfvyGYp55KFoL4V7hAy5n2WWDf1a
 uW+NJs3BkxgfhMn/E2ZbvNeiwlwiPshittMXGeE6jx8OvzL+VHuMOWdQhiWnQlHME8JAmjvYiB
 0Vc=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211776"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:22:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJCqwcCNvph4lgBOTUHrVpFJoRNKLGWwr2jyydgYlezmkMIkioV96O/csDpXQFx7+lA39hBPgfLaM5J7Pxp5U9jOyE+14L8SqZzN2bsIrPb4JpM/cfQDxHedIdrVH/edsRDxljOcUbsj8SEshlnNMSAob/S0ZkJl8mnCeRHlLi4++DRnwJQchas4sFjSlrk2ehk+VocZHdJsvh2ORodprgvq5v4xa1mgnGr+Ok/vv0Bv8IMIH38vs9STN7EdRa/98SDWbAO525w4QU1LUGEW6p1i5xI0w1aE6rJ9cpyj0zCzyv92fKdYI+/q5I/7KONfWSAB8fbcCZ81qT/S6uj6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=e96DWae29dV8oRBzRJmkLo1vMA3WAbC6XeAoZIbJq0Jl9V4VBu5DELMi1VxaeVhj4hbvR/gstCbjbP5sLKqyFUiXCQ2mGEfWj9Qq70HTkIFCQ1Z3xolxPVR9vso5NHzDzfV255pqgLDFAdrL88j4z0cyvchE16fG1bwmtYGAqtCs0Pg4OtW1TnEk2eUufb0XtKaJXUGi5KZk3Y6JcIvjnCm9D0jTDNZ8MKhKrBGs421jc8P1oXb1/1f+6MX/RiMqU4itL0B2nJ9srEZjAAuvVfj4NKjkF4ZuCKt6zTSy9ScdTbF22MD2Ggd/9rL3JmZVXgLpA7AotMFwbIipoEcKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=PA9A90cG8ZW8UIBe6liNaqReKLvKvx80q1i3WZpWCY8vsyaBY6hWw3Pbvebf07byVMD4ARFOihWWl2VEm6T3ZzYR8QRfggDS2TyxOPPZZyKjiue7yeH3DUVj32YbnEJzf4tj+x3aLjHQt2OLmruug7YUY/Ye9ThtTbqy7nfk8Ng=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:22:50 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:22:50 +0000
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
Subject: [PATCH v7 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Thu, 10 Jun 2021 10:52:14 +0530
Message-Id: <20210610052221.39958-2-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:22:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f77d6e-27d8-4157-f8ca-08d92bcfca29
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778FFC553214A1113ABC6CE8D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHcSjn6xEMBT+WGvqcw8zfMsjAz1DDD35yh/c+9QgT5opDrIfIleb8fn8qEZrXKtCWmUHcaHyYO3b7XZjRwLVgByzurMZHfLd3ebj7BDvlYAIQEvRc5a06WqT6AR9Zte5cfPUvH8VE0b1uqhgF7mERz2hO+uTXtzugBtYIXuhAy7dghZthFh7IUOCUyOR0b2KWTfcUbH10LbouY5rrPKdxeNKgi3I4+J0e6N2YKaLjwqK3jjJBkso7uxuBoV2tnAvfice6GYaoc1qGFNrdu8x7m0+8WpsEAmSQmPT146PBIPlbieqcsxK8V5HJfDEoOHxGLGgAARNjQsKov6Ka5zJNMygo2aPg5AsmMM5Nbso1G97duhOFc6RrF8JxQNh7XyIOk0b4XS/5A5aNb7JFZvBLKhr+z6TPck7BRFEak1D2yz+3Vmh3IXz891sZXCJ8x4BNZ6tJRWA9wf6YAKLVakIKKG3sMAnpjRbD+nth3pwgGV/zAL+EqVeyGhQb4ks2lAngpQxNpDGgBNnz6EAWdnB1aOyD/J7xN+LlR/pxtxrBEOQhJJJuIGFSccmZZYUkz1/FRsz+LCCJbyivSIi/EI04yXGN4thfYNS2r/HiGEuvrCxVUJlgNrZimrB6zSMbjmZ1UfjALRvTPzDWuXpz0XF6AElDmSngKavCj5JwudHvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZUgAb2UWUuZ8hNXnw3FS1E6+DRCL94F0z7C2qLm4q1rsJGw1Q28VsvCosP9?=
 =?us-ascii?Q?zQbBXKvIOTRQse9SbGCcTxkFcAIgCVKF9qTtFIsQdiDJVlR8vnF2y3ArhcCs?=
 =?us-ascii?Q?dTncQgHrbR8PqsDcF0eg9/U2l5AYg4l1quhgYWjesDBQDXTpEeXnsRYQByvh?=
 =?us-ascii?Q?FiL0p8jLO/xMGtsSnOCPbl1v9BDSfAxgccTAt9AZz0ErMFBd2EEFbqqP2Lzd?=
 =?us-ascii?Q?Q20FvaUNQctNPkdDWq9THKpue9N9E6n7Sa16xZJ89aY/kX6OFsJPnHpACmSj?=
 =?us-ascii?Q?wL9Y5tg/6AvNbrMPwU6jDhqm8eYr71cdeGn3H7qssBImvbIjCldw1RUb7uDT?=
 =?us-ascii?Q?dqW/Ma9t90hjSCdeQ36F69BE3Te0vhOt5uO2NTM+27ncNdOoggLMVKJS4oV6?=
 =?us-ascii?Q?5sBlmtI5RuujJ+NaJJ1bOArhipDRctvcSJ8RGi9mvmO/PuRWC9fw0jLvnAT9?=
 =?us-ascii?Q?lnKsGX/J80JOpXyzgMFCI9DGB76ZnbEEv23bRnYGB67ruGNt8cZCf5xmcRxU?=
 =?us-ascii?Q?v97FYcuKoFQdvj3DUjww8pn6JmHZ1xjDPNFhRM4dwzuZXQs0DveR65lwRfHZ?=
 =?us-ascii?Q?yDbYzw3vM9q9JfIZ38+QwUi0xDNzM+EjgM1XS9moHNOWPGOQJTFp8cAoGKQv?=
 =?us-ascii?Q?TNvpdEMoJtPXzXDkO4yEcW6UN6NET84H/hEcT7YcZAZzZ2w+SgXoo9xJdBPQ?=
 =?us-ascii?Q?7qTV5wDsNjEondCjmFbGDdgQZ//tJ7ovmzHU1lSuX1Q+i7n/+U/r7i/i2tYU?=
 =?us-ascii?Q?lhRHLXmUHdQ8uBiHKyJlaR3G9/xk7SqZ6dbLgGAY7KwwtqZt7ZJM1UxOyyA3?=
 =?us-ascii?Q?/846jtKDtmoXQYjmIcSmyPaY7p+W1djYmjDOUEFjAjyLb3m6NEPqxUzPYoxz?=
 =?us-ascii?Q?/YDvQP0XPazp4VILDtb40vCxwepHtu+1FCa7A0sXfVpnjWg5cQfXB+X8TniI?=
 =?us-ascii?Q?A2+d6AguljIVNx4q/WPlyjjDppHRSNLHCLKEGLIrHr0WfkRhOfSK7uqmRs5f?=
 =?us-ascii?Q?1QAnN7TaHcv866CRupLw6P5+xm12ZFNClKFtoPhd7Js8idxtDdcdP88aaelw?=
 =?us-ascii?Q?IMsal7SBDOpJbH+BBt+ELxHnb1PiYrDEI/XIyC7ijWb5USts6eLausx5XeCx?=
 =?us-ascii?Q?nqQzdNa2x/wszDq6FXGTnDyp7icJh6gV+DySnjqRIqEcbx4k0/055+5DNYZ0?=
 =?us-ascii?Q?Lc3ecu0uaDDtP9tKqvhpTYlNMl5essLHRg9N+9Arzcnyb+0DnlWiLK8MVsNv?=
 =?us-ascii?Q?cR6SLLQzydT6r8hG0m0tOD7NYomIM15Uyq4bi3cxBry2pj8KsW2mdmYEHKhf?=
 =?us-ascii?Q?Tx4tjc/GQ5d4xCY8Y2Av7Kij?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f77d6e-27d8-4157-f8ca-08d92bcfca29
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:22:50.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSfnpjbVE10tIydU+KFQninB3ScYQ4NH4br6nJuj+eFjMaiYReNvTSE8vQD6kNmWjbX2vCf9OmBPA6FV36X1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We force select CPU_PM and provide asm/cpuidle.h so that we can
use CPU IDLE drivers for Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |  7 +++++++
 arch/riscv/configs/defconfig      | 12 +++++-------
 arch/riscv/configs/rv32_defconfig |  5 ++---
 arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/process.c       |  3 ++-
 5 files changed, 40 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpuidle.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 31750d3d415a..e3646db8fd5e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -43,6 +43,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -556,4 +557,10 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "drivers/firmware/Kconfig"
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..57a24d40d43f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -13,12 +13,14 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
 CONFIG_BPF_SYSCALL=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
-CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -66,10 +68,9 @@ CONFIG_HW_RANDOM=y
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
@@ -83,10 +84,10 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
-CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
 CONFIG_VIRTIO_PCI=y
@@ -135,6 +136,3 @@ CONFIG_RCU_EQS_DEBUG=y
 CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
-CONFIG_MEMTEST=y
-# CONFIG_SYSFS_SYSCALL is not set
-CONFIG_EFI=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8dd02b842fef..97d899df2445 100644
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
@@ -130,5 +131,3 @@ CONFIG_RCU_EQS_DEBUG=y
 CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
-CONFIG_MEMTEST=y
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
index f9cd57c9c67d..461520222589 100644
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

