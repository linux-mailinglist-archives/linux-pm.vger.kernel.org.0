Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69B33D20C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhCPKnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:43:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12450 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhCPKnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891381; x=1647427381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4ds/DRIrv63enKd4gbTtluhlQ9Tr4y2t6F0kVQdmG3A=;
  b=h2Hf2hxRdUKV8PjtlEWkQ+uHQjLQiZJcvS/ZhouoRheTX8Sn5JFNxamX
   eRMtzo3yhd8YHWrqsNr4+wpOfovN3kJHPULGcc2WulcRsQcfjBw9jkshD
   /wTyRLJzl7teeNnSzxGj/zb6AZCY24jTA0rAkEMMHlGHDQBkZIrSuj1dh
   cqxZ88e3SzV120qDB0Vp9xKM7VtCdrnMB/ZwKKG6tvT3Jqeer0xOtAx4s
   Kb48L3e9AcxXtEvCRvMCKXV74qdfd4JPGYhjPs5jNXCL6owDWSt1/V5nM
   /06DPS/yFW3SgUk75uq641m9icGX1Yst9RXl+lw3Vm5KFjkfyy8m1XpOa
   A==;
IronPort-SDR: xex13+JMiAlVTQBwBRbU7H5rpT9pN6pLAfhDx0GQJpet3u+z2yaoory0JLL72quhBDcvIyojJY
 RWasXL76Pmahs6y9cZfN4tOT/7rXL5hjRALj0hVGnyt6672829p2vqPrnoYW83wBEcg9/Es5J3
 xVphFSsOzNj3XwoAs+JO2AtnlfrjfhObudsBOKVHV4nwzdVcyDMkU8Pefn65SW5b9CZlnMN3+D
 qSHTeuLqx3niOns8GWdnIjoGQalLCm0/ExJ0JrIt7LNB5WjjmGK3ePRIXj9zeR6AL0YpPEDKo7
 qyw=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="163398527"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:43:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXOfO4JnTRWvRADi2BY9RG4dwr8bxjZWTrVG6fhDZxdXUJ2uXbcnkdL41KBmDVTL1AX0GTtGQcsSBlUgk/GGv8+znks3Mm6T3/NxozKpcsskSAcsZ0h/8TOKdyiodU5EfiJe/aGIAk1eU8fnqROlBvov0M9mNSN8n7T86HDTYrUHKQM3AhCow86eXZoQ7EvF3I7i6u4mz4uVzaZncvxZHIe167uUHHIhljZjW+aqbgrDb7SDXyRhVhjCcRmr9oEOxDH2WIqFzHE0AT08DKFtCd2BBJv/I3zrwqB3lbAIEbhn6WkXMjoN5rXrMr6V/Ss/FnyYRcZvuu9no5DVYcTAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRKAcytJ/VRtOkvDqrJ5/QVgSgs1BgggwvCEHOH5WQ=;
 b=bAzE9h5EFpCytlVDFAal4m13bRZpduG/C3908QtNq/UXP21AK/KyZCAn8k8wcpWXepNkJW9Be0ZqE3f0OpZPXTDAj17tRzpy77bXnakDw5yJVEjhB0m32dPzp3jF0JJNzaR/fBGIQyCOAiX7WhP4+c0ORdr69SESCgfODay6wjWVUR04OrZRriFT666RdN5mfIjVX+uObB1HNcYTfVqZHzRdQbVezFooo6Emtm6hQgzwrzWV5JQFQZA2Ba10pr7dSjEQ1L9zSRR582wBlV7B0S+as5zgTAKEPZjCAvcDUbHCCXdeuIXWFL4kexYXYzmTRdWN84YgU8yMsmmoaQY7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRKAcytJ/VRtOkvDqrJ5/QVgSgs1BgggwvCEHOH5WQ=;
 b=Gsd5sX6D6ARDg/So51rHMo1PQHsKstd4V93S16ZadyoW9QrN9aT3xjCKnq/ye2R694YR5WYZsGTEXpSepy6W6Z/OB4//IzIcgzICirx57sTb7ZVTKf5PRdhlqpI/54Vj06j7hbpI2Cd0MEaMBu04QoPN0/wmB1MD/BEXRPwa6BU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:58 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:58 +0000
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
Subject: [RFC PATCH v2 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Tue, 16 Mar 2021 16:11:40 +0530
Message-Id: <20210316104140.878019-9-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316104140.878019-1-anup.patel@wdc.com>
References: <20210316104140.878019-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.218.45]
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7c4d238-d950-41dc-2d66-08d8e86843a1
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6377CD5A921A29A9F7F75DBF8D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iohx4AFwIQ3nDq0mbZtCDxrfz7ZRCzCbtsVqbWteyk9moGoSxUDFLVUvhFVQt8S12Ey+4D+vfQEWoE0e2k7rVbN5u+rl7DyqlBuwvjN4dgNz/UTBrCQ/bjC7/Nxl87qWUhHmSC3N1gylRSGzZm0f0413bSOdKTPlXFeS0II2cVp7JQ7M7s7OQITNITR8EDnHlLBLI5YLDdCp7tWwbO5oR2yt1PqEfZ+fFMcmoRlgpRNVuNFfLFAA6KJCu6vG7AxEFwD7asKXd5jTUXt0pvJH0xHSzoKGSaH4vH+tjD5kytM2GYSER3FHxoxI4c+Ra6kXWm+EssF4E9hPg+i3KAzaMk+shJTGgbnMQNyHqICOC/6aOypSfoOF4WZO9qZxy6XBcSqQLQBQpusl6RGH6eFU3vuUYfQoxBD6Svcgbf5ZjNitE9AOeafwiASL336KTS91g2VHEmj4d09qVWJscbFySRFSRqCL/4GyzZim3JaUsBlEzE+Hp7qLIUHo8MvLGliGyVgMK8JlvnKpeIsaI6s8IJDylZAgu+OOabb6scMkKachYG+3+InD99HegoPQmGxd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(110136005)(7696005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(16526019)(66476007)(26005)(956004)(2906002)(2616005)(4326008)(6666004)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8AMEs3ElL6cTKI/75vqo4eyfNprOYpqp0DXUbIixV5h/zRE250/g4v6V7aUT?=
 =?us-ascii?Q?aTI+ELyDojUFlWFd6TPHtQeMTGCmngSE66B00Z4OnjXCPWuH34R4iz/yxcm1?=
 =?us-ascii?Q?kcAM53eKfiWHm2ALMveiYYiXyO+nhnjIk0u3D9a9l+upGDiyIZZr9twLZdo0?=
 =?us-ascii?Q?PmCP618pXcx3AOSp9l66bgV2R1zpOLqnLykw7t0abzX/5/Rozbx5oQa6pW9n?=
 =?us-ascii?Q?l6hhrKdfZDFrG6cjyjRqUbREaiOQupkx8L63ZWq7B33h4bcsyo6mMVFtJvDL?=
 =?us-ascii?Q?7HdPXxynHHk/1+1/YjqC2C40OvcrX3cDEDyu5yr0CxTz+Bt3Fypo0AwrGIkN?=
 =?us-ascii?Q?kM7XBok79Mmpb4Cyv4Oycsg4cnWuA09qQJPv4am7+jim1wU/V7KUqvOAXmbD?=
 =?us-ascii?Q?KxzF77wchDVgWLIrt8HckxrvZRU7kRI3LUSvyo8epUD4s20UDbTRlijQInIu?=
 =?us-ascii?Q?KiNxVuOxTq7dWv+a4zkCdLUsa0pqYaZmEBgv5QklD09akZKcxI2fC6L9HBGx?=
 =?us-ascii?Q?Ko7z5/XNGVkaF62LiL9FbsAuyrDasnkTD1tpzg3X/Qm/TMJkseflnA8X6G5q?=
 =?us-ascii?Q?7QC7qFUra/TQeb4yK4eSfwakCcoXmXzjeOGYjIWEs7xpGXv0YTr2gDFWZLHA?=
 =?us-ascii?Q?VEtPzdu7q2PDDv8i6ouDMljLog9UNs3TNRMnxWigw6sYRZ50aUaTTjj4mtCs?=
 =?us-ascii?Q?yq7SIC5cR6ifnsT284t50x7Qu2YxEWb41X5V5BVxR1X2EUgDyDiUQWjmQksp?=
 =?us-ascii?Q?QY9hTIBFRl9pyyNTN2Al97H9mfQ6CaR1WKrgYGHCmZVcRJkeFLxhOiQSETfo?=
 =?us-ascii?Q?L3zNL6/ZUgc1uXjuFLiUaRFHEOMQ7LgWUUzMBxSOKTfxxuCkMnu2A0CWBPLr?=
 =?us-ascii?Q?05bbJoHvQtQWTS1Lv+qLRv5Kl4MEyTK2yZHqZ+9Bz52h92cM8AiM2DCe+oAr?=
 =?us-ascii?Q?cCJs1arBTO6y5VSbwedT6OL6/wSM1tB1fD4cKQpoQW2lF9aJfRi+K4uOrOwT?=
 =?us-ascii?Q?eKQnXuWihCzzvT8c3L4EPzkwSCBrV2J4fymJoleD29lUrlR7+KVXWRry5i0s?=
 =?us-ascii?Q?Zd9/YrWGjHivS/yJCr3XcqBwvN+qDa3/nyGBdedM4ZmgSs764FqHaV9aiBuZ?=
 =?us-ascii?Q?LOlA4XXWsA0pwCrmtWjoLfY+APpkdMEGqE7O66XGGa16pHhmO3F50Lbzkm6w?=
 =?us-ascii?Q?AlzVSMykWMr4r/SCAZHnZwGAGq3FvTwV1b3f93JcxdNKIgNaYJQUTEVgWH72?=
 =?us-ascii?Q?5dhC261bvxukGBObmTqZ8VV+G3RQ4/Rd3oP+BIBBYVlDmtLVDE3ohOlr2qhI?=
 =?us-ascii?Q?5fTtpKcfM1otDaMs+wkLqDux?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c4d238-d950-41dc-2d66-08d8e86843a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:58.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1TNaH+bIuLQ5U/BEGVCx2Ht3d30kJtdn46zScPzztS+e4dLAkh2S1hd96koUKXrAGJ/qdpI8t6VRrmY0yJIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
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
index 7efcece8896c..efdf6fbe18dd 100644
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

