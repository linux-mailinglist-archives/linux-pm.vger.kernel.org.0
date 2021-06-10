Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4623A23F2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJFZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:25:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11555 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJFZZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302622; x=1654838622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1uLrgPfppmFH2vM6/L/JqMHBvAu4tkt7ZHOK+EuhRKU=;
  b=SZEUuBhFsCy91Tqn168dVWmzOYYrz1NQowfwxs043OoRbn2y4UenqbLd
   7HOtx0lmiFBLKQAJQAWMzXfJds2NlsnrO4QCeNk7kD4xv6NT4SFb3Qaxo
   j5FRv44I7lk78Rdh6zgiwHrDS/ppk/U0VVckkYWM0EQu0jNmOT9FJhL2z
   LZHznO3qEHHioybpfabLX2qiyMhpJyTJhhTiSiveHQw35GiHTR5JW48PQ
   Efiyvo3nQlFbihzuUL8WjutnUaE9WXGcNqNQMWaHaVv7yEhm/HbkAkoSj
   gJajdnnZ9vI1DKofehxJHDFmPNfpkRxeYl1xWVAyk74S40Fc9s38hXHjz
   w==;
IronPort-SDR: ZPkicLY17CKjyZW73V9En7wVxnnBzon7dWi6anhatNmJg4jtvYAIfIFbww8LiZMZNwHQcOk+Lk
 KSehGRgPPCtKCUiRJmF97QO8GVFZr0gz8YlXw8EbmBTJWjep5vIiE6rdip8SpiR8oJtd03cBbM
 EjQq+0tAzCvqtfxDUl2318K+rj56z1afwNnIVE2SYtGRgLwg++XWxna4HEX+aaHoj+XvhkRjyJ
 1/rL7081dLcnabeEWBzZa26RtmE5GhwFVXgukFBaB99DhbD1vZj1P8JpXTwIcnW7EXCaCMbzKJ
 zwM=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211825"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:23:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MskaA3FTBIsS48IqpvTut/0NjVKv0QQmLSivlDO57D4XRXIaZUsoDGJ9sT8tA0ysjnrUt0sRa+m5T/3aUy/K49u6yosb65BurPG6tIE2eXsNuXvkK/cf89VTK90GZJcwSQslHVakGTPDrxJWpSnir+wu/zsnFt03I6HFi7ymx0y5kDs+qb1FxWjE6Mlp5+pItPVmkmxzNswO+anqbl1VbEwBA9gLa8AciDfS1o6UpBlb8Aez+QPaGH+4DJS0zLHGuU5A2aMfNEjiWG+LOSDm5QyVvmKN/Hlx9Aco3ZGhHovUq/tIx7jfjubb/Cpg0Gh6iOxqZS5TftSC/mq/YiIFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=gqrx5ir6LpS/BbLaw8SpMxnNQ8MMvG6hzsi5iN3yRxVd19oxgE4BoMJ3sfvg/+QtxSYGL/yV8wr60ed/SDuUVqjZcgtvpZvIG6Bj+eRNWKT44etpOXOhODcUXNsAm1v15uFIIMv4ISCUwpeNVvDWNbdwfe50uUHuQMfrD7g2OeXeVpug0ygMyzy1KSUtvjyziyEXlz1+4JAfHEcQBbTQ0Q+JT0CTyG8Hun8YE9SyAHKP2M3tqguUPhIj5WrQAuNTfCJXluVE2acW1n7AOo3OTCppC2dG8GjcsOdlYoN0VQCbbein0zWZj/Lm+eGaIR1Iq39Z0KuPu19ccsXfrXaECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=DsbhytrE3l1AAbwa5PJx5r0ucL8Ps31/TWxV6SwclOCJlECHFvY87wwgFmdO/aZmHFes8sNRwmtJpufCbOe2TzM7C/qYMHm8Avxmk/CW4Yu6dTLyEcYGbrptxPOrYfUb+gA8ClxDtAFu6WQIpn4zOLhPesajMPB6Ba9xCOEx2rc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:23:27 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:23:27 +0000
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
Subject: [PATCH v7 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Thu, 10 Jun 2021 10:52:21 +0530
Message-Id: <20210610052221.39958-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:23:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65dac918-0717-48da-fdfd-08d92bcfe04e
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7778369BDE821BC939E0B9868D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJl/kSBCtZLK4vvMo9gTlfyNbuQxImThDfN5+/ewlEbEG42Bqq0Gtdf4z3UXVK0kba2eYntirfvZu+s33VLpXP1z3H2Nvzl8q0omAljtTGIMJHDPWUp6VCIpXwrCauFhUnBB98E9fGnCpn438iTGSUDMueHsF3svOYZ234f4oTsxw9ISx8JiA9Kl9tpqhYfeows9f/bF8sH90EWCxsYxOKWCYgjZeBvxqesHqwiSIHvN2TbUwi11zLQMdkHXtdbG7Xn9eeyrI4/bqVHflxlXvm7AlX04E03OjPTr/AZ1yCLYRFyfGMQ/nrCHjWr+6aweJZ6jzI6HSchUOgftaS/ncFYRJeRgkJ+/mfjYYMDRrIVrd8fLGapFZzQ0KmlDfDGfh7AAW1+1z1unckyssbCH+Gj6ZpZooZJJh50MhBNVUMcWoQf9LS0YCcrZbpe0ds41pFSS3qd6CNGSGbTWNiPhwfUPn7lCE3NrvfiI9+tWYeo5Z2cKYJJZ/GHEITqc/HrTKSEQgk9t3+gyLPK3M2CWG6rA0SJXu5XXvMXWyuFWJkV7WCUdHpUMO7ylUn72r7/gwLGd5/lLtC5+z4+wGBCANwadnq1MqhheQ23wdfOUh3RVnsM4E66Mp8vVDaY3kDssrfl34nzlikscSrshVaJciw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(8886007)(956004)(66946007)(66476007)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/jgfHwGsHrwXc383b48u6FH+tiF2VcIz34J6NYMjTq4gAXwO/1x7mH/V+02?=
 =?us-ascii?Q?bb7Zx12ID0IxeYYvIt4Sz2WZerTguZDGLKNu8E6PV8lY0sUvOcqn6ic8Dfpd?=
 =?us-ascii?Q?5j2hziyOI8XaBmKSyuehUlCLr5aeEZ0E2Lt4JQc2JfTaOxtCqmaKMsBGWLOs?=
 =?us-ascii?Q?ksq29OzoJwUiWO5F7sJ1nOMYlqPPBtFux9g2c8zA/d/ru/nu5IaHOrSqAemK?=
 =?us-ascii?Q?tNFxsTWe/Y/x8TkPg2prtc+IZqoBaqVLC+2hkGMiltWKTzJhlSs40+cT2dWC?=
 =?us-ascii?Q?SArob9JdnZcxoy3gO3nI4p2pM1GxObaj+yVSognASlb8e9DCnBKyj80I+Gjs?=
 =?us-ascii?Q?TY2RYxaxASgA/3HL4xFalKNtFZqdTIY6j/knmsnUZExI+DSBOzZLGHzldDbO?=
 =?us-ascii?Q?4Pkmhz0nIZ1XTDTSYJkm9kZiTJ+2sD/vtx8KjOJbJBvxGnRp0txTg3RMEjtL?=
 =?us-ascii?Q?mT5zFMWYpi9zZfGKligGzoMH3KMs4BhISjCpaKo3NehD3QPNENeECbZkZM11?=
 =?us-ascii?Q?rLiRxGuwPGNPXrpDYmiO7oLQ1ZEbSJIszLbf58YuwMaQXZExm2drGfifeN2W?=
 =?us-ascii?Q?s+qU5nqxxy1t4YummucOoo/Qv5E8hC3BpHG3gP+o/ouIS2ipG7Z8ZW6ftrPz?=
 =?us-ascii?Q?ArfpciKO8z4U13Ij+RoCtM0GqnpA7gCuNgTr0g7Ep5dIdCL+16/RWBxXat0w?=
 =?us-ascii?Q?RmSuFYPG0O/gdvlThqr98ZKBpQEpBDVq3go4knlGrGRTTw318k4bEMOoAYv4?=
 =?us-ascii?Q?Ya+FihwhUJc6eX8hN+B6SSbSq9ki/Yet5qs24K08uF425+GfrCrWxs7ZPotv?=
 =?us-ascii?Q?ImSjRHrUsA+Q1hSj2E/3f9mgrO43tq3yC/bNWHIqAq29GQwwkOTPR+2VD6kz?=
 =?us-ascii?Q?HgzLySLoZQkUKn67JpE+Zia2nj1N7/TpM3wrHAfl7DX+iCnMVTAeab1iholF?=
 =?us-ascii?Q?FgaSTT2m40IkK3uyOhSfm56YN7jmwcPB0ho2rPu2rPCT4BfKBGVAlysfmM/l?=
 =?us-ascii?Q?wu4mZncEWBDirzQqydni28G8duCPv6JCEjHT7In8G2CJoMq+Ln7UDZSdM75D?=
 =?us-ascii?Q?/F+PZWqILlgmEqwDybnurlz0Oj82mrWtUC7CkvBkC87Nzk+7jLxeTQfqHcdd?=
 =?us-ascii?Q?w9jNDfE+9Hv1ttnXGqfDeuPiML+MPXeLJrgp6LIwAFOQig0/kXnLC7y/W+aS?=
 =?us-ascii?Q?Ob9VXmy9M5RuVddiBB4Yf5Z0PLODMM+ZqEHsMx9/q6IVZlkOiCiIXKespumh?=
 =?us-ascii?Q?QBvlMwzAK3+kkN+n8uAT4Wg/cC1yT2wMbAbYekx/cbmqboVWgYlj5MhVwJiD?=
 =?us-ascii?Q?d5ym3XnID3RI1BRDiHrTMfv9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dac918-0717-48da-fdfd-08d92bcfe04e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:23:27.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh2xjQs/f38fCxsfV2bzfW7QwX83gmOEx8DmrAMrf1N4o4ZZmGAzNaF3+JMyjcXDdR3OHl/ZijwFH3YTKaq/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
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
index ed963761fbd2..3ae937121a77 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -27,6 +27,9 @@ config SOC_VIRT
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select RISCV_SBI_CPUIDLE if CPU_IDLE
 	help
 	  This enables support for QEMU Virt Machine.
 
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 57a24d40d43f..ed71f125cbc9 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 97d899df2445..0088d6989332 100644
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

