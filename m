Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB61382CE2
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhEQNKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 09:10:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39727 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbhEQNKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 09:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621256975; x=1652792975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wEHH9KQgEMsvLCrTYZOkd42zk4RD29DDsOSgOkBr7kM=;
  b=HFMxekGhx7aUiYUHARHS1fOFPCd+/Y5TEIdWjzr2uSDLKQC1kBB32Y6J
   AeZT28LY0z/bWh2jbmcKl26dlw2cGVSXg95taVb8nC+yHYrgV5Z8lrDwq
   5s00KU/oQbiRHM/5xGPCJu1e3T90NGOSgakO0Wzff9UM5UWPrF1PerZ4S
   LT3Zcs7/F1Oab7wpNNh3qJLF/QauRtg7EINrUNf77NwzJ6gWgvsXYYZnX
   AQzOYwDexseC1O740USut3LtcNG/IRCULBQbcH//v7zjROdT5sqW4MQf1
   tAenOcx5o9cea9Jfe5ycouEvqnSMvTEe+KJbqOGmsi8iCx5XpggMyD5LQ
   Q==;
IronPort-SDR: V6FTQCZ7BY8UsiAR9wglK6g3bDPUmTw8Q0Kt6JlhZdQ453p9xKwyA8gyNXR67h1xMIVTgC84nq
 /3EhGjK4QCdue0fNtYqjCs/IaUHL9HbwkcFftadLCSRsPCEAmP783PRanYH6ak3mbCfD68dvsK
 5jIPWzETjLA1jk155+YOXyo0pxx34nO7mAVr1RPR8KPFdmngpgUYh9RdX8Qisx5zR+42Q/fwaa
 J1j1+L29zlcm2WxK2CgxI+c3vNztjFawT4NPDHpTRPnNPbLYf5D+5wG6fjgQARxHgCGW8W97+E
 TCI=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="279668200"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 21:09:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUw1TGYpqrGSSBFUBVrmYiUhAjq2cjNNU99M2cUtUedFZK5AAZilC/jpp7AlJlXkO1vSgXu33nhUNm+fk4Upmk3GNbTpWKLQ43lUVpxcMEjJbv7mwdGQzqh+NqpMRckKLY8nCM8/xJFU5kMqMYumIkVBU++/KMu84/XGo/R9jWpNr49T9K7VAaSFDtJecu67WWn3FQTDSV8au6K14w0h/KSRK5HRr6IRbbiOEFaS+CfxqO1lNMrmDJNp90J4HJ1gpwG0vnftz62krSKx3Bkcy1lj05y3UTpOaUDN5u1pAeET0K8sQYMKcNaCEnO1kL3cK+E0BhakZP10kHIzhXy/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd66ecKx9q2t9o7QVLlDpOcbqmauJmomlXUBQ5vOQpY=;
 b=X1Tr8EJn18TVkd1Wr1/SQqc4UT9HY+7Q4PATMNh/xHjQsqX9zrt+8WlfCZ32X8YEfsmWQ0HOOIYUAwo7dOt6TLD0Q4WpV97nfGWkKUc/TyNrinZ649uwYhU+jf0Mg/ghty92XLkIhITcAzE9lJwEiTFC+LgmHPHgA63bWCkZ+rwzOmAHxF1ssHVLmNpKaYsYkEH+2/FhxDhZet4vd2HV0LaSNj2e3hN2PUHApUHcXQWoYID+HmHwp3A88cYvEd8uU0EzNmqTewFBuphB8yMT4FAu1MEaEWkgH49WfptUb2jy1+3MWqBEFULUKmBfC+98AsRwBKJNU8MSLXVAh6FcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd66ecKx9q2t9o7QVLlDpOcbqmauJmomlXUBQ5vOQpY=;
 b=Gtn2Q4ZnBAwl0e4iSPFHCxZYyMbu6KgcBsS1GgLXw7R2Ph+jI+loQzO8mueRAz+IRkvbME7SB6TZsS9voEEux5HKaaa3qozd1nUD08BsmjIIiSCIigomGVpWvZHLAgIPMEnbpZ+bo1aX1Q1iX+zkI0Bn6IJULmzLDrVYzJzjVds=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:09:27 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::88a0:bf18:b01d:1a50%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:09:27 +0000
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
Subject: [RFC PATCH v4 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Mon, 17 May 2021 18:38:16 +0530
Message-Id: <20210517130823.796963-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517130823.796963-1-anup.patel@wdc.com>
References: <20210517130823.796963-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.32.240]
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.32.240) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 13:09:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe99f538-ae5f-4f0d-6347-08d91934ffb6
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77783750FBF8914BD1681F568D2D9@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBuHqQav0m3ziwtC7GFiGDKjJdCROHjpJ7mn0a9MuQqBy3MkdyOFdQ3IRgvB5hzXmaFts8xIL1n5f3k1rXHW2iFmscCbMJf/gVECLyuEfR5OYjFw6n2DJjuplfBrVUFqQGa+XitdFn4GaTEPg6nmpZIQeFkbS0Od/fpBnIJhUJBGRME9ys5aNKl0miQTiiXvDwHWJ9jyW9iQ0uYr1JakQ4+nZn0ZlHyDK9pRHN2ujWspItSJU+FAMCLGlKX5MfbK81jstW/WgI6KjmKJRTBpEHrwU7KggJrFp9abF3OHODUdh6xGhoiSLRsJyP2AT0ZfWbIgVGUr48dqgWbe37qVsvbZQrhMP4zMlf7vmg1LJZj20F8Jt35zChbIKRn7feL5buMs3qDByDW9hK/zbuhBMLcp+p4a+NcuIdnZeCjlQBZTLDGTos0S9GbRBoJI6A4WiY0PdPEpgpV3Ig8POpvkU5Jsn+45Y+O7DK8apjcp4pribFSDOf2lJCEbMV/ZEiAqqjMt+x+gN0jEyI9Xiff7gJckfSZK4sFiKeDvR3Lg2ODx/FTlgPS0HAqUglYvqmGdllhxSOd0bhF4Ggdj1SlmW18NO4QaBHjQ1qwAslVTvxZuNHkRNmgiX/YcQOIPbLgjYWSXwUpTASzd/xRQySBKJKv3Ifho5oz0r5Svmdx3BF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(83380400001)(38100700002)(1076003)(26005)(8886007)(66946007)(44832011)(86362001)(38350700002)(316002)(4326008)(55016002)(2616005)(956004)(52116002)(7696005)(110136005)(54906003)(478600001)(8936002)(8676002)(186003)(7416002)(16526019)(66556008)(66476007)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yfdgX473o2gNIkYp4bTSYVJH8AJhoaorQCbdE9M1mENpd0iIQTf950oVIrCR?=
 =?us-ascii?Q?7McyG/YyKR6zgCPBc3j/J+Q+EX+bFyWOUfhfCP4MMwl2rpjArDw27n4V7GlM?=
 =?us-ascii?Q?43YIfvQlo+xonZac16k0VhY8Grgi8fuy6Ei10NnQCR4325STwc7vJSa8YX52?=
 =?us-ascii?Q?WlUw9T+0b6kDyQAyNSZBkbCuknkf9Ypo/iCETFxqm7ZUTFxcm0YLLklo9zUf?=
 =?us-ascii?Q?rQeeMncoZpHog6nLvO6q1kk7DFuExUoxyjlEWnkC8Q4tRQo16GXu7l3ZfC3z?=
 =?us-ascii?Q?FyZDF5FchRktD9Dsr1pvKPBgSlegHv9R7hcbV6IILIRUlYEYsjQgZB3r1Ig/?=
 =?us-ascii?Q?bbVRfscmBKhL5V5TjFdvNQz7IIVLjLXO8dPr4oNvkcdLntCzz6O47SHp56ls?=
 =?us-ascii?Q?mDl8MJ12ecybfFsgYvFvz5IGltxhNTDXqo1gOmhFuxGXVDkdxcGoKO3ixA+u?=
 =?us-ascii?Q?jUw5POfmwPKth9B0aP4mRnRe/tk1EFwrD3fXsiNbstLvWPiwAxw30gj0aThb?=
 =?us-ascii?Q?v24j/llUYHH3xhC1ZJ1DJogLHK+wVoYyGstboPvziNKXgRizAlzKWd+dpYCb?=
 =?us-ascii?Q?XXQtX/boaqo8hla728p2Od3y4i1JxH8MR+WKisF5rmqTB+q53XhtILsrXw9A?=
 =?us-ascii?Q?xDIu87V/Nm5xcMAbKkyrr5naw/X+8QVJpne1Pqq8szbNt8kRVMfRGPAWEucF?=
 =?us-ascii?Q?CQWxnmHA+fdxDVuZN10QsAyA2m1wEAcb9pvSfMhazgJXMw0HlmzqUv+bN70c?=
 =?us-ascii?Q?CzAz+C36tSVZBA+9YJGsi4/B0rGLmnx3PGd7BfoAIZZt7n0TguvHYt5jNv6/?=
 =?us-ascii?Q?z765eNJNxyKD/f1Mzs1TdpltlIUGZOdepyB1CB8aDbIz41vl7zKyc5otKTnj?=
 =?us-ascii?Q?L8SdJ51ShU0Zs0GtlX3I0qlS9gnI6y4Dg3cHIGn2q6rAb3gRswN7AjXUTuFb?=
 =?us-ascii?Q?hmuKwuCpk7ybgUu3SjUE3XHdNcbEAUeDTeIjUYl6aP2m2CYITGX85Bpm1aaW?=
 =?us-ascii?Q?qzZabe9Fij8jfkFg24k46pP7LdDMD43jwvgpQj6xNLWY0y9XBTlQk9+zYqVk?=
 =?us-ascii?Q?MvVP9rFUJplOhTup3tQ78t8SEAVMp5urehtvOvmlKQlgOA4jMcQz1gKGVatN?=
 =?us-ascii?Q?Y6fZAUS+Z4teBd1MtrJK1K3PLjAY3snBr0kzP/6MIWh0OsfNCgMdOm7EUySC?=
 =?us-ascii?Q?zBOHAbxkou20qReLs37oLc6EtAs/gm2cdRMETHdOxbwzUtbaHQep5DogrZxK?=
 =?us-ascii?Q?wzO5Z1U2E0DmSN8V1O6iNDa+EIk817fMzKR8haky54lyoveMsbkKuxGmt3w1?=
 =?us-ascii?Q?zBvS7lLoJOdTDbKOARkoe/zB?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe99f538-ae5f-4f0d-6347-08d91934ffb6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:09:26.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY4hgigs6eVMyQ0tekNTaTZ/4x6wI6rydzBFiDjgXktjDSsEuiVkZV/4f8QLB3Y8UBYATjHXziOQXfEfJ0d5NQ==
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
index 195c6d319ab8..f607fd33014f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -42,6 +42,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -555,4 +556,10 @@ source "kernel/power/Kconfig"
 
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

