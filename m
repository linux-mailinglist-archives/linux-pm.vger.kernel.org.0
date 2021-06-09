Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A308A3A1452
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhFIM3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:29:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16006 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhFIM3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241665; x=1654777665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Pu9Io5ABNyIwu1+haflsV13kIurdSAe5IlMVtkIEsvw=;
  b=Dn25EBC5nv9CqvmTzv4TXqqUEJ13SnoYpsA2tb9V78h1yKgb3pyLzFo8
   kdDzrOcuNBOQ6IBN4zkt4EI38WJ1wRhbZol+oRPinZnQUpR5ag3tdpIaf
   aNuwJ8oGoSYyxwLxyjZNhzCP2EcURGwvKfjSlSnaDF6pYeToM6C7/+VmS
   401Dd9VMOhd1WdQnjJG1F2Z7c10UI2cbIEjN9e6K2KQAvG/VdD9/scXd4
   3dxlnR92QSUh0jCj5Xw7C5NvHln1uc47c+2Pyl5yiW6mvrejKmLbpBLjg
   9PTKlIKdT78R63m4BuP2W6hMkRRZRvBxVK1RiGXMDnfKLi5mccB2S2oy1
   Q==;
IronPort-SDR: WVNf6wf1IFkdI1xOHY67LSmMhrIw9LAW/Tl2SqSY4iyNTw0xgiuSSLBhpPFGd1fI6NhKn/gg6y
 X9MYxmVOSqXiYc/l/4zF8rONujCTH2lH7UvoQ3M44VHr/dHIjLTW23XizsJevSTK3tQoUYa0Dk
 2Rrp7/RMfHHuWD6/LBAXROSt5u8yJO3x7MKT+HyZI5Q9Qo9nikd97lF8OaHpW947MQLu5la4Ub
 Nk3wSrffsZdCmTs4vujN0lTpHoXLwrOiC6p1FtcSoZm5Ft+TDfrU+VbzUu0dyZJ0s1rnn35bfz
 dD4=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="176057718"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:27:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYSpzmtnQ1128XYkeINRehlA4UMyEVdLz+VrCO8nHZ33HNBILtdN9G9ujK58LUo6QmG1REQORYYPe1puxjzOuRP9vvz/+dDD0KU1CaNrhYjbwGZaFYOBwLdVaLiUGeMIq9N8stgP6fVKQXC5b+YpQyC3fALznFssj5hN5/KMUnnCQ02CFSdFvOy4ac4kTLfGOFpYTpF1O2u9xCMSToVp8s4GEAFKNG853hu2b3VdW7tuNg0aR4Qu9tddayBpwzWQoMSIiLqfbB9MIWEjxdr6+fWNEciqysFQRleIfb5gMS4iIA7U8Gio2UcxWjGKchMN1QlMHIM3TPN7bw0Pu6l6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=DaIG8giJPucapmTKP7hd1yQCYJzViQc0As38Dt0HKizfrBxUUWM0PY1wuWHe21pNSMJ0veutHFuUXwLlqMPt3HDzIfTMUv9J0MRrV72zL8wdPb0pYNUE0gjIq8AePbGMYQla1y5JxTQ/YWFH8ZC8w7l8g+d3f7Ewf3h7ILmVaxQRK5h97PPSpZAcq+enWBggDYYkYwUasg/0ez89Qsl0WUFVDAD2YjrdcgzHjHTrsHZMVPNRivQ63gEyoahSFPapfKUSgSk5NRTc0xQ/YG8uy2veDBqJlRsBLWIfF5M4OZPSqWs6f1AjURM4UFPPrXtD91k7UlYNOboF7JZyHpM9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J3Z51tt91nROm/qGQh6Y5Ld7cjzveYM0Ru5f9vIizU=;
 b=gjjrL24dSyRWIKwyAO2R1zb4n4GLOPI62ZySlfi2T/xGdOZg55BAqy93z7uCrpEkrPLTcb60G01IZ2L3vjnrFPrQ/6mSJjGF/dGv/sXRp1P+zgYrKTqwbfXmDRRldWNwWJRcvNHp3HPDQWr45ZP+4+niarJJIYgTKdsSaSPiZqs=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:27:44 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:27:44 +0000
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
Subject: [PATCH v6 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Wed,  9 Jun 2021 17:57:08 +0530
Message-Id: <20210609122715.3389-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609122715.3389-1-anup.patel@wdc.com>
References: <20210609122715.3389-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.172.176.125]
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:27:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b057f37-8e2f-4fda-0846-08d92b41fb3f
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7843075410AA9B215629ED1E8D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oavujgbm2iSFM4TAWVDNwTYuGKphe7kUhkW/BigT2WhuqEyv36vrUW2jwsfu82wNC/QZq/8BYaM5ipfmTuxo+sp+rOsv/XzVa8n8+TNfDZx1d6RqnPhUEoDyxh+dI7kMEAYYpeSG2WYfow6v7nF73jqQNq1WUzLw50r/Y8DIUS78oNHyTousZqsR0HN39reVc9JEiOpjk7fabw+QZOi17XptgCa+N1pT3hlb03r1YXUfgLsW8JqsFvIjm2Dg7PS6X3glfJQKysd4DAm15UfnnI+cyiOvSxJ5+dihyyYoBNk7aKwzkLwlX4al7IHl35rw5hiES1O3yOWVmQCrgTh3Zv/NCr89UaL3Zlf/4CRLa8+E7ZkboKdN8cSuQRt6ta1GBFwri6F+c4rQoVUQAoBLx9AhcxuKM05IcPO3h/CA/eNuY+CgYS3T9n+ltiM9oUafXMyhQwv8Dx/W+GqjGtmNifEr3aN7FkFOXi6sKItaH4qm8+0zgevK/7AssFsTShBhUd2nTcxmtFqSCpbjT5U610X7EpwQZX4LHmjmz+UkqrNe5IZM2Ml4zdWi8JROgcZNoQVeuFC0WkMf5sgqznXTL4/K942f+3WhCbXldhGY9QaALxHmPLiWu1Jd/6joMBPEzpOR2OSIIJ5v5W3pDBW/jEgIrRyxW6aWN9uqwvkiH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(110136005)(956004)(316002)(86362001)(6666004)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dluenq+J4JMstodwL+wKWbPYDMb5JpD5ytua/6IuCiDIZIgNNVE7R/59eIj6?=
 =?us-ascii?Q?OY7+78iGKL+1vKaz3JTAXxevAgKBLY6aZ1GUbeROQXPFg3Lrqse3GcOgis9I?=
 =?us-ascii?Q?LDHf1XQvK8zteRKAXwz9failHwqax/LAoBRRsc+8em2kXz6btlW61mt16myW?=
 =?us-ascii?Q?ZX4nNM/QyCIvrVxUcP5Igjylk6/Rgu6X2ML2n3LNI1/M8oD3HzDD6GNq1vRz?=
 =?us-ascii?Q?eNkaBvFSI7dvcAQeysqsQqrAdEjL+xxK8Yt+i1gTDyoww/rhj04DweUGIDc2?=
 =?us-ascii?Q?esgq7DtpT+YiaiHXNjMkQaLAbLKnrykElv/iOzSbua/W9klVrstKWv+0wGbO?=
 =?us-ascii?Q?NaovR5zZOEL858pM/m6F1pqH4xzCxsnYF8a57+dxZH4F5ndZlTU1GImSoIOU?=
 =?us-ascii?Q?pM62PjH/vIbPDdrTxN1pOd2lwNVLIxlZvHDJvU3s+uzDDIbH/oezNIXMu6p0?=
 =?us-ascii?Q?myDegJDDKboLWJyM+ZRhzGTkKrZFF9za2EA7EQ7uKJBRXdnpYs7u9rcVjfQW?=
 =?us-ascii?Q?yp+/YHtG9gk6gPz7iBRL1PPS87q70pGoxE6Qvzir23+XEm+W3iz+bSi3+qfa?=
 =?us-ascii?Q?pQGYOlVTlRT5uFca0nA+01A8XstpjNLY9FErEr4bD8j2uiaq6cVJSHu0MLjB?=
 =?us-ascii?Q?lYCa/a0R+8zXcZ20HZZbMwi/k/YCnBo3yQElnv4JGpfEGyVe2/ciu8k9ehsA?=
 =?us-ascii?Q?A6ero7JWcR3qgKIifBP77FOM+oZ1bIv9GuRG1oq3aWkIeO2K1nC55LAAQCvM?=
 =?us-ascii?Q?tYCTFV/0kUlP11Ot/Ydg7IxrzezphL3AnsmegP0kblb7MVIEudFwqdKiNbvP?=
 =?us-ascii?Q?8A4CcMGfq2MVEk2DdG8AWGXnnksnq2cWW3myNdj4dB31Fr5rhIWU+LN39Waw?=
 =?us-ascii?Q?cl+WeUayDG+z89RSh52bhZfSXeB89BDPRo/QWy74xOwlYmWBIGd97yfUviF/?=
 =?us-ascii?Q?6FhaprRF7jFE8lMrkuGIvD68gySGmCgmZTBlf5NIXb+yEn1KCDTDYRsSwC6A?=
 =?us-ascii?Q?Yn3Zl+C6WBMnJkZsGpqjChDMQYciBrxKWNp+We/bBh/9zYFgwS3XM38pWtsH?=
 =?us-ascii?Q?cbWlrCM+H111vx24LqDAztSvjQPZmgi7KSKvbiycdfxuiIEprUkgL9HcVTZ5?=
 =?us-ascii?Q?lCg5skpZHY+HlsyQFEdyP3Y+UIWTnc8bw8/wR8uNJBmCyKxWowfKI4+S8NTY?=
 =?us-ascii?Q?NQ6y6cVjtxS4C2mjw2RNDEHc5VTdou3CBxVa7E5mAjCgRZ+FbQXn/r7DRrWP?=
 =?us-ascii?Q?6jcqP8xRCKCfLoeW8T2rnMz754jyJg7vd8FmOeCSKL5ZHJN8HciYEJcVfU97?=
 =?us-ascii?Q?YSaDPKw5cS4jrn8cFKRHObul?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b057f37-8e2f-4fda-0846-08d92b41fb3f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:27:44.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1w2vWowGjr9eTbzdZmXqkKRnal3E2yvLqUmI9XJ8h+bISpJTlY6Dr4MYfjqtoUnf+VJymhRpKWz5A3V4Td0b8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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

