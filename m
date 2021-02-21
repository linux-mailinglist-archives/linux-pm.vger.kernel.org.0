Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA87320980
	for <lists+linux-pm@lfdr.de>; Sun, 21 Feb 2021 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBUJl2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 04:41:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6875 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBUJlF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 04:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613900465; x=1645436465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jk9fTFbaFXNvhDz7mQpXyNnOO9hKg0QhgQaR5R99Gg8=;
  b=GYD3RPZ5Lcx4arT3QsTXjZMWPF2SWxaSbhbED3bsE7tiTjAw6XYDAmy1
   r4wGKp8eNX98M77z31zDMUJyw3d5AdgOlMThyfbirT3pyj96xQBHw7NCT
   5Rph4Nh2uZ0PmPKeR2AZzPKBIenL9Ks5128l9nQ2XGzs4+6pFWqaxMxvQ
   F0t2kkAT2OBvUQDHSq6TpWqAPWNrUUGooY/oMl+Bk6fG2XYG0191I/wly
   lhBuSNFkJDulQwycKVmfm8DrUCzBXrqxFNOWM4Ab4rguxOe2+r2Gjy2LX
   LHm6qzqbu07NIVCqXlLsC63JEXvXKxjRNeRwsWj7CggUXcOXUaklWyDmk
   w==;
IronPort-SDR: Smfc/kGTriS0r069ahVN7nrOdOplIIm312KXFDUEtxPBFlrDzJdZun/CvP0qyRBMvVaTQue4Vi
 Zrx2CVRIQIOVTHMtSPTPqwBEcM8ByVm1Mkal8+mNRh+Dbh4tysbxB+lL2BwyLl/VAWHgqQUqmF
 wHQrYmrSLM19JKD6QI8oEWAo79kOpWJ2IESGwoc9g1KWrnmigJzIPgK1sdbU6mf96iObFNx+aa
 eRriXif1YgSN3EFWckgGj6ACEU3usr8o0AFJxZGeYXPOZmG9nt0zX/mJfIgpOKNbDHfxQ7B3nb
 RCc=
X-IronPort-AV: E=Sophos;i="5.81,194,1610380800"; 
   d="scan'208";a="161607400"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2021 17:39:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9/n4+l58kwfxBphFlyOwMQpbCvvk9/azSRPpT+mo+O2F6gZveKH5oFLNQT32O4Ye0n9tYMC/SGOOlYBZZUdm5mGyxlvB7IiwFW4ftd3XnGj42fe9teGq/1W1dRzs/1pUOqAGYU+Ve5yCPE74B7TNzKEzlMZPydpXTLkrEGYJKyLE4qt5isNOkYdo51fO2x9ATJf6mzKxLYK+rQrY4LN0CPLOgSA8f42xEO2zAn6q9Rl5K+/IE+mmHUAJhIFHWuk58SqZiaA4f6dcpS2gTQseeAxErbQIFI9uoDYY/vcib2WPukVROokJNlbPcrH+uQhjeMNqocGqctL05dwoeaxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz4Mz4Q7C9L5oZSGm6C/uwSUovMMO3hthLrVA5MLpXE=;
 b=RD5lsxvl8PWY9Qw58ywXCfoGsH1W8ZcGAVZuvZA9o14OV3TEpfALNl+BEePNqSlso2BNoXFoan23ou8A1xG214uXOrMIndsqjqEFVFnbz8v13C1DY4FuJFNDoCUtcSCAxM9os1Vq7TH1Uis3PSDIictF7CWks+lwr4JVz02y40NuqsfPP4E+PHJAiRAAl13ySEbvTrin8rRm7cMasXV9O1B9wvI5FKaJR41gNCC4oN66Y5YkFil9N44F73feJv4thmC5sZ0EuHiV5ydT2X4abPH5un94ebyp3VCjc+n/PfBz3evgECtdyG5rJ+BGlvert/N0msixnu6WdkwRBhhV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz4Mz4Q7C9L5oZSGm6C/uwSUovMMO3hthLrVA5MLpXE=;
 b=O6LTnAl4Af/l5Uv0Fydk30c134pOlNiJG/5LUBzOyezATfr7dox2sR98sObS9VVdm8OLngQOR1merKuY8/hOkggrZ96er0Bg3gccc33C0Jk8xtWZ6EYSk8/TY1Bm1zjORjP8Z5MTWOtL4P6p2tWotYVcx8Gc2sTDc4OqzMh3J+g=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0459.namprd04.prod.outlook.com (2603:10b6:3:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sun, 21 Feb
 2021 09:39:18 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3868.029; Sun, 21 Feb 2021
 09:39:18 +0000
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
Subject: [RFC PATCH 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Sun, 21 Feb 2021 15:07:58 +0530
Message-Id: <20210221093758.210981-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.12) by MA1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sun, 21 Feb 2021 09:39:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a89fd469-a531-4f92-6311-08d8d64c8f34
X-MS-TrafficTypeDiagnostic: DM5PR04MB0459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0459F3A93FDB9618CBB8E89D8D829@DM5PR04MB0459.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tE9OkLir7zd2rs1U0zbacDO2r1C9EZ18Zu62+8Jw/3SQ/w0rjm86HyPVJDOkfK7nQ6hnYvwZogmGs6wnD/ME20D0EQ7iILrNtxPkvSasLbvCkC+P7pCKH57dkLHP5N+1XAMdWIEZ8b502rmN4+PYABcVt+ah4m45JLVC8SMhCFugnBknhDB8/BX6V/edi3+wpn9nUOdFVCxTuh5TaRu/YLsvE5DWzyEbaMEF5ziwVTJ0EUMDvzf48+g13bDYsf1XsBJPm+L9892YX4D6zOySiLOz86QMvkjlWMKwvD5YhCV2XZYvsv481hcRp8Et/1GtrlNaytCKfOAaUQ65qVnW5yybU+d9MXC960Jkb8r6fd0VsEUXYwDx22BSXqM2kW+AZBKP7F1DtRxQsTyCDq6Gjvi2htLBzvvcFzaGT49FTfJLzAJITdxyppppxVbeEI9ylMceXGfkVFK4rkywZp1HCbiEH06Fsyyz6J7s7ePjzUSfTUsZvcM63Uj0TabFPq2PrvfvLZopEIfaBcJAgEkNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(44832011)(66556008)(8676002)(2616005)(6666004)(16526019)(7696005)(5660300002)(54906003)(110136005)(4326008)(66476007)(36756003)(478600001)(1076003)(956004)(8886007)(316002)(2906002)(66946007)(86362001)(52116002)(7416002)(8936002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+p5XIvWMHE1CKtH0bnPvkZDmUVuyer0LPRcyKhqgT16KyPNge31u63NQrxEh?=
 =?us-ascii?Q?WvudbeiASYZC01Jg96+HblgTzpmZvwBnq31JNpzDbEAxbCgdleW1JViWvMqM?=
 =?us-ascii?Q?nFknPx8sUvByAZ0gzBsGjtx7AuTMpGi3TNexcJ8k6l0RSvTNRfbkXqYuFQFo?=
 =?us-ascii?Q?Nl2uzb1MArZzQ3gwofMnICSzVFud7pnI5q0JY0JdOv/NZy1qyPeOCTl3NEwy?=
 =?us-ascii?Q?VbtO6/lFAQyQEAYEyKkE+XrIo34t61nlsrwPcgHpwKN1NndRYZAd1htSNIxX?=
 =?us-ascii?Q?CtvgFXiJZb8WeoCVVqP1b48MhHzVAfW7TZbXv23l1JlsHg4Vz3OEWPEHOWyE?=
 =?us-ascii?Q?XnQjK8whGdKzilhh3PPna+iR7JxsiKsfJxwm6x2i3yPpYwQxhJCstDTATgGw?=
 =?us-ascii?Q?2I2F5Sp5tkvLQJ/H2xq1vSktNKJfZ2Y8V8Lhi4+uUi0FrXeCWS1GnUnGTdv/?=
 =?us-ascii?Q?dn8lq9PYGM8hJMNWMH4dE7lICMcbLITXycTs8bv/KxJU6WbUsKDjP0nUeqCW?=
 =?us-ascii?Q?g+YwkiYI/QPpE5gdSOgtvSiKim3w0XYfwwkdDJOL66R5jtJZE9Z/NUky/QLc?=
 =?us-ascii?Q?d6NGMhCd8FP/11Sv95OfGkn/IHa1uIEue0uZ9iZcvcwX6dXIpAovhkVW8oG7?=
 =?us-ascii?Q?TfkF1FV4ZtD5GmHu9GLNIXKd1ydCpN+KSeeLSCx6qjKgHkBnNZVA/EjHSFuH?=
 =?us-ascii?Q?cEbgytsSw/cLr8SzGvtiuWwPs6B0LR+HcNNHJZKnna5qod+yrFVEdoeS5zjC?=
 =?us-ascii?Q?LCrV9IbdLHWAJS8gRKkTrrkXDCIrMzlBRuBQQ0B5l3wR8LOuMhChv2xEv5/K?=
 =?us-ascii?Q?4obyniT+fzPZ+iKfu4DnjliF7XNfyTbNXCYkFK7y0J1z4Ov4IpRrEN4EfULN?=
 =?us-ascii?Q?eNJDeKvMZCiG7AuOArWx3XoKK38HSiUue9Av5BTKeM9FgDKPwyNFC+fW5cwu?=
 =?us-ascii?Q?fMCu0rU2c+4Uh4jJ5X1e6qW0V1YKjw+CoxMGIEG6A9hM/VvQT9+++0ZZ55pG?=
 =?us-ascii?Q?f4C0VTT/M7DX7DeltE+PvMRURu6fr+/4Zhdj26X75ufSvEKPFoDZbOsuMRBH?=
 =?us-ascii?Q?jHdQ4ANvRx6NYZE+o7sp7p/POwiAn/yVxgSYpM1Gwte3BH0AeI5bNOZAleQ3?=
 =?us-ascii?Q?DmIsL93JXy4Zr3BkVvaJ1sAFw+cFhbP28HRGpLHB22RzAr/QCb39+5CemPR0?=
 =?us-ascii?Q?nTgoCjIi7yaVnzToTs1OnbCj3aIjn2Fkavp0EV+lnkB0ugfKq+P51arAXHFs?=
 =?us-ascii?Q?LEYM10pD+KUpaJVbudqwZ1FhwhOaLbzw8GEqUL5//jv1103s/Cp6Rr+Wywwf?=
 =?us-ascii?Q?Dtaq/uuk8clkSIHUVdr8AlF3?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89fd469-a531-4f92-6311-08d8d64c8f34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 09:39:18.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTKccmaHJ8s/xfEJAH2NNkIMXe70m5VaXPNQY1CsfTk0nyIvFpEeAwfuFNZXUoInanIhew8kns59tyerEjsp4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0459
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
SBI HSM Supend on QEMU.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs           | 3 +++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 3284d5c291be..5f6f4a520772 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -19,6 +19,9 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index dc4927c0e44b..aac26c20bbf5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -19,6 +19,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 332e43a4a2c3..2285c95e34b3 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
-- 
2.25.1

