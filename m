Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F354F428884
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhJKIVh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:21:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7106 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhJKIVb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940372; x=1665476372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gCTLhVNk/KJ2ASHNuBLx2JfxsyUcDofq7SRivJxhhVk=;
  b=FdN7M2JJUZCxu4StWAd00FoqR2gTAl6DY+0FQzLwgmUnAhDA9q1lnPWk
   LSNoQW9z1dipkM2NsWPgkHe3RWK8WOJo0wwzleDBQVS18U6EEubwbbqBN
   zkiezrpVw4wMvruFTezWzdSumTjFvWwdRuHs693pLV7qnE0idXQND2n4k
   PPX2ThXF+Nvp6Pn43ejVvpPFoGbo93Rgf07eN18/CtQ54WYentvVAsH27
   fYPYppel+wUf6SzEZ/RHkd0UIDIiTor96s03Iq6/yT9pxlSzAzwNfRWNk
   rvPwZZRMYIRPTY2j8VHiw648A/kHKBoQco93Xs0IDWAUr7d+IJX/9lJQX
   A==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286313169"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYvgbxb0vo0yw5VCHGit6II5HPguh6JhHffs5TxwBfxzt0XXGskI0gGQxKQGIBgICeoWvJBsbwJQZeNwtUk7whdHz19ge0ebwFOa6LUp69W5YfT9UuhyoemG844mOv9k+UCrrmPHoSt1xz1YQKtUudnsGzwbydG64pHsV07XTn/1jfAZX3SDjNYUXiXOU4g1wFn4WN0VwyhOhBEjIdf+/CCKKhzNR3XTGvp0c/DsGWV4Gfi5nuKnCdwe1cYYoFEfOqrsWEanGx/tV22v+NUo1PK4r2Fp5rv15svDSclJX8wZq7bsP61MFJ0EaV3dFVqck2g2/m7lhsGrRqogQ5Z8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsbLAXNnCE4g5k5pcF2EWs1TXPmC7v/XY4+ibLz10Ck=;
 b=Hi02AOxi5QH3Kb8Zze6rQwBVkL60Cy9GwvnZo+f4rVD3RzycwkvYGuxuawPdrPfOaESo7wsmW+/ojj2IoHjMxN+lX6uvXndKXxXAtLB+XvW6ticKw7VH2yrV5bV4YlxrWtYvv8dGC/Cy41Mpj39sR8UKVneu/xybL6QXtpn6YmvxEShwriNYAghJFhFzYuscaOKKGUtEVKuuW7Mwyk3mJd+ASC+86psVK4KfD0ToIp3oxUobyRYJEfL7V3IxMfkiy4jtxyu8UsT2+/g/9fQt7AzaQp6gvwBnA5VN0aexWM3dv6YDiq+cPupox4of/y6Ls+jnoEHy51c0OuME2oTjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsbLAXNnCE4g5k5pcF2EWs1TXPmC7v/XY4+ibLz10Ck=;
 b=dYB/6vhEzuFfjseRwNxCzcXvRNZAZekZmQX10VoYKCN3fSY8/NRWj5bSCfNOha7gsKzozpl82PTJ7Hdj2iFJhTANKtpz6lLlwEpYK83Hy1BhzOidMQbyZ6fpPcyMAkeKB4I/AG9C50xBkxdYmUPlRBTKqvihfr/vt0GvALJURGQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7874.namprd04.prod.outlook.com (2603:10b6:5:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:19:30 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:19:30 +0000
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
Subject: [PATCH v8 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Mon, 11 Oct 2021 13:48:20 +0530
Message-Id: <20211011081820.1135261-9-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:19:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d34cd952-5dec-48fb-bf92-08d98c8fd909
X-MS-TrafficTypeDiagnostic: CO6PR04MB7874:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78742E9EB9BC0ABE27A3ADA58DB59@CO6PR04MB7874.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdhEdwdRWcvOHvjIhVkayTzg2rBAE7f2caSI/UiT1MPvfl5lZG5Cqm+pQLxP6HUbD30DSB1SO6ZLn6zSwvFGfWbx+JeHIufgryx0V74NG63MeP9zGoKjNIUVVXU7AvZN7DypD2grWrdmKNlJRppJ2CcP0MfPVTr2z8S4Mh9Ddc3ocda+WkNNrIMp5vpkrPCy0TRHDgpvTBhE/PSky4sgH8OHy0Dyp5Kgg+iiVJ9TNa9YxnIFSIwGz72Wsi4Xelw1N8gv/hnpzy/bxoZB0RyzhSoiiQENSj+tZ+g8q7VWy8hA6kkuyMtNPvhjaV7yFQqxJlb28IXrOOAddvbkVtYVt3uPCbgycHTmnMZ1dS0QlDZIjDAwIqFBw0wHQZMUmpXwKRaiwt4dIkVXPeGsuuVgEgyK3PwZTD9geOpuFZf86idGoJTIjuzyrn2QfTiLrMf4aJMNtBqVday3k7xoKHkrmu0HZLCEqIX40V8hMHtuscLSSVozTCKPOsfqCI7eWoWIVKo7AV1BozUIt3DuevxZdECJYAjjSIjTzpT1Eq7YcoU18qSgyVhKEZWmQEuw2wLlkAqnXS6LbznQs7oA4XaV/XAY3jQBDTAO45o5wq4Rma0WghIv6HBpm7YBupGfN3bgIFwbp+CGqtPeTasBz2eznBTKfmXf7dH8t5kXv5z0jzNlApAEeJ2ylEdcEmZMitn43VchP8wFbzqrArvLfI71AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8886007)(26005)(186003)(86362001)(44832011)(508600001)(2906002)(956004)(4326008)(7416002)(2616005)(52116002)(38350700002)(66946007)(66556008)(316002)(54906003)(110136005)(6666004)(8676002)(5660300002)(1076003)(66476007)(38100700002)(7696005)(8936002)(36756003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmLHpt1fYu0CEZQ5YqVvFrnhCcZFQX9IJjNWwbMcdWeHa6qBLIfhxdYaRSlZ?=
 =?us-ascii?Q?/vvl55ZgmnKskMykkwNZsvesL0R2VuhsO6uV067iLmhfoubVE61HNA3WHlom?=
 =?us-ascii?Q?JjBRtqqwNQNpRv1MtugA/sTRlBIjHIYCVEEQ4+7Dl9B8sVz19qa8hQjQPSYY?=
 =?us-ascii?Q?Ae06RSBVt163P04t40fzm88AvdNnNEWsQh8+MfCcM77K5eqvnBbyDs3LCScS?=
 =?us-ascii?Q?u/bmBgJh/E+J8bziLAnWDbD4qdPSE5zc94UW3deKydUUrjOuwRwo44higV/z?=
 =?us-ascii?Q?qigssbAJsmD98PKoGI1mNC9byZeeOG7RGCFq7uO0jdv/vzz8E0XL1a66NpWR?=
 =?us-ascii?Q?N15pPpTFO+7LRLPDKBaVS0aRP7QMJlwgUtAP+oQ0TW5Ivee7b4QHKO00Ymwh?=
 =?us-ascii?Q?DUfRREPA7gIBtIvxLQAAfTmbX5foD1K8tp7zrQKS5hRKZtyGtAlAVDtsHDbB?=
 =?us-ascii?Q?v7Y3ke+G0tn/GwRGmu1IjFyosQfHT8xjtQ50M8/JeVkh1lWofI+jPZVuNxGH?=
 =?us-ascii?Q?mVttOn6MGXTo1nf32pGeRQFpBEFP9278YpCtU6PJntl6le/cvxoqzgCk+Yxr?=
 =?us-ascii?Q?kJ59kTEVn4tLYyi/USiZ3D2uYtOviX3BIFvkPnjsymegyyqX5HU7/nYGE2qY?=
 =?us-ascii?Q?htdViIzJh2Eo3yIWyhB10qLHfFyds/M3fzuIUlB7nGehceDZWFT4fZM5q+Qd?=
 =?us-ascii?Q?TgxS6fIzaOiDhb7cobDl/IEhyTIfwOIi7ycAcUKvIggxTe8PcabmhAVVfyHU?=
 =?us-ascii?Q?gbej81n7ormFAMXcp4wqmAs2EHscDFoITqdjC5ILKgB0VFRwb0bqPfJpcOn7?=
 =?us-ascii?Q?tbNr0FQvHo1VmYgWAHk73+9h5uOEGinr2P8+g/FYqwzz+or43Vs5KlGtqGmc?=
 =?us-ascii?Q?ozR5LbF8iPnyek/XYpACOXOHdxfvAA+VCdwsDWFUZxnjwT5BeQKdNNuiXmHv?=
 =?us-ascii?Q?A4Uq53zQk4AQ9FCy3eWzevMod1mmiCf8FgHcML4d/4k8IB4QUVamnk7mtafA?=
 =?us-ascii?Q?Y41+DFmn19TGNEYK+ohvipl6nC1BXZmEm11TRQ1+/lvUz2yFZvkDmtHm2Dzg?=
 =?us-ascii?Q?fTGbkXvOhu5z2xEFbC7y5Al1Mi6pJ9l4+PSe9s8MPv9Xvgf5nnVveW1knrmH?=
 =?us-ascii?Q?nh3r6djScEwUhpNvvp/BHk4qYiksgn0a6w4KkGAxztyxFTOfrkFJrNMAUwJ8?=
 =?us-ascii?Q?z7OZFqs04uKfeZsAmYnK1tEYo3a7LftoKQTOMpZBLWgJyXrCQuXs9GRdYgA9?=
 =?us-ascii?Q?hpPkd7d3NlgzvTY2jE8G0TXCAN4LIn2ADV9r81QXpHXDfylNB5T4hTJ3xsr4?=
 =?us-ascii?Q?vAVh3q0iRiTDn7sM12QXlx6R?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34cd952-5dec-48fb-bf92-08d98c8fd909
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:19:30.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWWcdSZ3lPHppVnMijm2hw51IVIMteKTG+kLiZXZavZTOBWg/D7F1XsHh2OqsewrcBaRqXvsojM3FKDiRdF74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7874
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
index 651da2ed93bc..357299833396 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -29,6 +29,9 @@ config SOC_VIRT
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
 	select RISCV_ACLINT_SWI
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 39b4c32e7997..96fb9ba6318b 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index fed827c82a9e..066b7be65f49 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
-- 
2.25.1

