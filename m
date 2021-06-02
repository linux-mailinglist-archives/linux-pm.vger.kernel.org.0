Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B152398806
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhFBLZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:25:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27555 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFBLZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633037; x=1654169037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Pu9Io5ABNyIwu1+haflsV13kIurdSAe5IlMVtkIEsvw=;
  b=BxCapEHDf+V39JWtv/Iu3Ao+u90Y1D+6YT13gSngfwRSaZDZ9V6NN2M7
   do1xSCitBsZONLEVmi0pbD4LNuXEYHdEkIitdsBcz+a/FTyfju4aPvUIz
   gpqq34LI+g7U7BTM2UXyoNAE9utMAQqYVhvH0j57lE6fv6Pd4Jf6kiT4C
   ubVlMmUxNKyVB8Lb18lryBL+I+VdkL4CosxH7zQhH9F4hcl2CW0IlDVc+
   pr8bBPBTiM5MhTf8vgpBJBPSDIXmRh/gSARi6WQLQx3Ci0j01giZ3WXCT
   1pLWyu8x/NdR+eqBdlBS5t7/f7WsdlWUfMCGK4bzVWydn6bvfEwxBAJ++
   g==;
IronPort-SDR: HolUbt469BgLCVFz1yhlQtCw3TSQNX4adXqXC/9CxqfdlC+7LT1z84biTBSFiiTq4kYhi+F58/
 lMQ9uDlyRLQJVVbFyV1ZgNm/LE20HHBPISOqj+y4Fs9lgwbdNVx0McKlV16txSFkgdQV1HBKFh
 b0wFcSPtGdlsBgq+TDvxGhsCLfdH+kYDwT65aBm3RQRQfxIdL9zP+2pxJhPNy4H2hQT9GPw8QY
 G7GSuwPR5GG2EhtaRojsDjcf0YRDiusAn+EEPlk/MFgOMooUW24zhRIJITLBQPX/72PqpYBva9
 Uj0=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803640"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:23:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXvGJfdFFIc/t7SrCKYx3UAdzvB2oHKO7Ev7bKPvun+SqlUdW4f6RU3Ye1FB+Qv+ZnanxJBRH4Glq1UMk1gd2ks1up0lh/j4bKZ6S+8tsBM4yOKVdIL6CIbrizyrHHDjDfsLQOA4FsaEubxX+ekKq2LzyyvYskDoGmG0v/Icjs6Jex2kJjDDIrkJaGC8hMn/0ZumFTGztbz6CWxYAQJo44onO/R/otZ1jwWXXS9/MIRZo77oGz7mXXiYfZczHCBZ9senOrfA7LMqIqhA/l9drHVmKFG21rukkEN+3L85cj5As6tjt3noO7AazE+dDsEem8JMSKt2nhyfGGzSXzLOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=DnCwJ3jFA7t2LEobg+vHWBdQK6tXGvsTvPfUQ+D9Xj+uCh4gHWX7BZuh3VaN4Sar58c3yhsluvixR6aQRf/SRpSHTcSH02Sgp3myd9RHpcJG4Q3TKsHzZC5r/hYgLoIL4jvjYk+0ov5ZZnasJe64QDyl4StBS9ytkVQ0Mivx3t0yoEKfLAmoD6N9JeE9bjcOxP9xYneYnI0OT5KSwLV0N3D5dZBL9Xb4viIgwc1S9aYPbt8ovJjyCiTCvfG+KbT2PCrX3SHgqyBwrWXar+AV0f368oosDvVrZgu+2FNZ3MP/R/5/gYVddCV014YZ/MUChSyLwUvATthmf3xGKoaq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=UjUZFnoXuWeAKxRUnEJuohsPHx3TtVfWEBfP6A6gQ5sxLxuLQw7sKL5fsJlqPpKToTwmX2WwO3jWa8zU+xyM5qS8iqfXZ7/eVDYR4ZVsTn0SDOYL0tbXvNyv+V3GzFuScCOpMHB52t7VyOAIoaT4/SqlImR1q79QPYI8k7+RJqI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 11:23:54 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:23:54 +0000
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
Subject: [PATCH v5 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Wed,  2 Jun 2021 16:53:14 +0530
Message-Id: <20210602112321.2241566-2-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:23:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ccca327-a792-4229-2177-08d925b8e7a7
X-MS-TrafficTypeDiagnostic: CO6PR04MB7810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7810A6F6EEF1BF4898AED63A8D3D9@CO6PR04MB7810.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9U4dhAyCUCm1cA7aNRbmzNd7wQauEYGFev63hfzAXtlCUJcccWjFam+/OClsUMiQnnhgGYDWthlu4Y36zAcvcjkKhUKXbiHHh1AbePrzAOMdUXlioaDLArYPSxDZRwGH/QXeZeXi0SXAXuJ+g1yXPQCWSlH6wiR821VfBKh/bSusYB4Ob1qJtt27+H2oEO4J2vdb2DY3DHR9DW3lPfMIQrDDTNemcKHbnzlT4FnydNn4XHqNVbsMZ0wsrVkzjZ9TZHwErkmjAopPMNM3wEQXnnPjYZFbkgMLSJ1QDwoBuZbWIBYMv6SGlvR5O0H14beVF41HdLvo9jimmKwvjkI5AQox8ThBnjyaeJloZm/oYjreIY3jjeFloURShUMhI5OiR+Pu5nSVatR9QdYjEOH1ayc7SkSnWtYIgTsQdXSdj8SYjAOQpnkpibHD4UV8gXi3QCto/WdUFY4StuCDDDdycS1CYTZ59nmbnZlzIcKH6ezSE8ULjwD7qVUBSNt/G0T3jMK4plCPMovQ1r/IVVZDqXPLhnIeOlclYLtSrWnHsgBYWqpc+fj0ASNjATn/ZsrBGPRFHYlceHVDnGEob9pb7GO8yo1tKQXgS//A723wk5+ccHX4Zh+XKn759OCbhcDqovE+tJpCjE+NRUvZprWG3yYtNs//FA6n1LB6PQHuS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(186003)(16526019)(7416002)(8676002)(6666004)(86362001)(44832011)(4326008)(8886007)(2616005)(478600001)(956004)(38350700002)(38100700002)(8936002)(26005)(110136005)(316002)(1076003)(5660300002)(36756003)(2906002)(54906003)(83380400001)(7696005)(52116002)(66946007)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PS5RwVum567Ue6X5UxgMmy45g4PbnpXzEJ5HLutAkhASw7Hxy2/69FT7w2yX?=
 =?us-ascii?Q?0QNeqTTzhxmSWm8fhPNf2K2HZpLeTkVH/2bjWZ3NkVQDxAQu8TAwHIT4+y70?=
 =?us-ascii?Q?yHYfUod6ufRiZKvgdiPX3JoNkKKrTa0GOVlkeqfAQpnYCa3tvuiShsGh0Dbu?=
 =?us-ascii?Q?lnxf9sdTaaU41md4beI/vWB4+S7xVjiqgHD2H71+5n1C1Gm2BbAAKvUpY1lT?=
 =?us-ascii?Q?e4PVd439YxwBJmR2MzzijADmBEJpZMZbIpT++oA4jCbY8wNeh+zX8afX+2bu?=
 =?us-ascii?Q?b97EBfZLpG0K5v8saFuyZT/13FqW5AuWT5a70t2ledGxzeRTuClz0pQND148?=
 =?us-ascii?Q?i/E3SRBBpJZ/34AUL6Ka8RiJLm5IFAlGs2ib5j1xG+8iUwJLX/su5SUG3K44?=
 =?us-ascii?Q?iK+3ToTWkPyncauCNPinpek8Uj3oyu04QViP0cRo3HPVNxxmmK359w1E+enk?=
 =?us-ascii?Q?1odg2/6EHeoDl7rTI5E4uvD4dNHcx2C/Ozid4e+71Ie6QSbWJWlO5p2pA7wa?=
 =?us-ascii?Q?khqFOSz8HZIlPL/Q3wboFd9bdKykAf/nK5nfrkxezVdZ29IyRqnM+aq2y4fH?=
 =?us-ascii?Q?KUC8GeWsW0DhjonWVpmF6WIhfsP+ES9yYzUkBuFz+4Hf/z5Ce4jtoKVo/rCK?=
 =?us-ascii?Q?CLBjMkVENC+g8Fp2g0VdxDmyQwDBsOZcNcvjD4L8EipzqfV47//nBmSica/i?=
 =?us-ascii?Q?YF4YvJl3FV/97rvQs6iZ1nk7++Rr1go7udrhdnbKLRrIBy1BlIdzDX1mAvRZ?=
 =?us-ascii?Q?Ketu0pUrR4FcjPSCpDsY+Eo2mEvo8iqbBVGMZhj4lrj8EVO17xMF8uhesX77?=
 =?us-ascii?Q?KlOwDKvhNsOk8Mx/MjFF3uW+7zZt2bnrmUIB/24aTmqx9WPrHBPj9WIJjp6w?=
 =?us-ascii?Q?U9UQEkQAeUzyEDtTZ/2/joZObUpIu4qXzWw42ALHbyMxXrxwj6li813Nprwg?=
 =?us-ascii?Q?1lvrnP0MBxtFgRUn5WDurZKAmCI/Ii/vsCzxHqx3IyeHjXLp2rQ3WRgSvywm?=
 =?us-ascii?Q?L04SGKK1ILb9rhuAVZjgwzUBsxeFR7RuXsdIQo9f+zEBgeCBb/+JM6iy6OkY?=
 =?us-ascii?Q?VOUKRfVAGmEEJQEhJkNZRpsLfOvyArIllpTNp6/Z08wXvOuXnvPRVaqIomO0?=
 =?us-ascii?Q?Q3OLbK9yFHIr+WcijazUa55cL00F0GAt/yB7j++BaCllrDQTr+muNhW89iCz?=
 =?us-ascii?Q?4KQn2OgEG29/wxaS/VnQPDAQoYY2DpzU0T6w3A+Zg/x6YjnPr0dNaNBEys3T?=
 =?us-ascii?Q?FlpsxDljyiurXWeBWoVhXcloXMKxgAutWBXkdRoUPFxos86/70RopvPHzvWG?=
 =?us-ascii?Q?n0lX9rY8protEdvAGnLuRBqs?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccca327-a792-4229-2177-08d925b8e7a7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:23:54.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOd0ZwqcpI2ihZ6/BfCVW1MfoFPWffFKDyVOdBCvh3Nyu1fmpERQhP6MR+n/qNs4CvV6SHIlxlwDoB6Qb7jL2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810
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

