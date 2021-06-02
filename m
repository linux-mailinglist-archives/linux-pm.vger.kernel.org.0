Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0F39881D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFBL0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:26:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27647 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhFBL0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633077; x=1654169077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1uLrgPfppmFH2vM6/L/JqMHBvAu4tkt7ZHOK+EuhRKU=;
  b=mITV/XyaSq6O4a9XOCrBn/mw9mlKiwBEdWqJcghCy2tu2WWGmw6qITtG
   Z6fY8+W7ZRd0L7cKxIIQKi6njZuv5zwnEwGpySOWv1FvVcgYf+gD1ISEH
   NKxMxabvZHecGwZQfWrlgmuKCELlbCX3Lg9PmtMVnzSD53UtfRQe+v8ra
   dGJFh0gO5bks/KzO/StT3DG2xAfhuIU8WdEbGc94xvsYStP9sonKb6OJG
   43ib6+3l9ClGjFdjRnVmN/i3wpQ7F+xKre3LoSf4y/gH3AznoOP8g01U9
   38tC6OB2M/zvqGLjg0RXLTgNuVQ0y1Vpfc8L09O7H+ymDuTcrCsGVKGM3
   g==;
IronPort-SDR: etfxiaSgzIO/DfEo1H3PVrltS0flITHztoPp4IZMr0lb5B1cqPP6k/ZX4wr6DWfU6EvG+Dm7II
 JUAxL5WirOYHNANYhH5r9G0ZnaxdKab55iZR+Cj1kM33gAulD1tPRDfIeBm14UDe3kwh0nZbDf
 NfkCh9bIuSDS8Dj4xlqwkKBO0FDNoic78D3XJEIkqiZeNaXP1CQwF+JinIo3Vod1wPZWBj1iyf
 YN2scG3VHKAQwytd31ASKXecNtiOpwrms2WrXjMO9Luipq+z25UrkA3kjKpKsx525eaosgvNcm
 vxk=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="281803690"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgTi4cQncSvrxs4rzFpnYuFKwvl9lNBc+V8+HXn2RXLSpCFsR2dbBFUO4ROC6RllwfTLTiDviA0/57hXoxxnJs6SWullqLOlPx3M6O2HocRRxQ9Qrke3W17RZWdXgCEJEindgGfF7Wtk4CndzD72IZnjd1+UrnjorobR9vpDDfPRXvh653K1AocfShrj1XDNx7oM7mVxF4nMbdVirbdPeM2CuUBbe6y3ww7QH1bwQ5NeOsOrijCKy37uaw6g23GzS2fMtVOI1VgX8W/3500HYsJLfW049oJMpS2dfXbu1e54cCT+Itz8R+X3T0YrWoTShRPBl6/tcrWrmSl+wywK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=MuQuxOECPdfY9y9cEIv3MUDLtAcHj6TC+1f4D2ZYIW6xUjzHD8FXHW+ELXgWwDgxnHK3uzUO+7hC+c72//+mgfyMGLCgjoYi9zegIHOWW0tjK2IRHBMkSzQNNUAaVcMQw4PKK5tJfyZk4/6asAZjAE7RqduRxx1a8JBxR0WOBmJSDaWKGkiVWTAyI11c4f6xmZQwXhgD1MmIx8f3wK2EM23CrJJOVyS9pssNO6bSkjm/bz5X2fJdPNlJtz5t+wbw3UGLMG4YQDkFErjNw1moU6fHW3e5HH0fJwDeaUuaTE+EzP7ungDoUP2Fy3A1VJIf278+fccWKXgb/8p65aiEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rip7XFR0BFk/jcVrblzy2OjHhUZycRZYHU6/NmyDcb8=;
 b=bv2ykx495AZ6Tl/Zq9h125bTIQ6N0rA3sX4S/hLs9oWW6n7D6dHA76+mBsN1R2/OP+tvG9PutarIL1rsPeupIYIhPm5WmDsMIXF7mJUFf2I1SLJlxg6C+EGblo6kxdxV5249li6JewSKHG/5neIe78uNPh0BOYhVw683KZPFmrU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 11:24:33 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:24:33 +0000
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
Subject: [PATCH v5 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
Date:   Wed,  2 Jun 2021 16:53:21 +0530
Message-Id: <20210602112321.2241566-9-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 860ad3d8-7a80-4f86-eb4d-08d925b8fee0
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7747F6008D74215BA5C0BBCD8D3D9@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFWz8SXSTrDXa4sO9fqiZ7xX9bONDemirVBedKj0QT1SG2F4pl8O9cfce/Op0E33vr4UBbp0PH+asSCVP68WMyxT9g2PxU0Y1F+Trm+2euG1lpy5L+OVADoP+JWudU87WBBdwDkxMp40feKochAcv27WPsmzasT62YCkv6qVzGduEIhr86ZdlHFJ8SF7WZwAfS6nlXfp+8UVChQ+3mzOlZwgzg9i2VdTQ/K9wbxTvn+HRHbxcPhGagi//9cS7UQ+XFZYU4FPaXAatrOsr47VMN2N1vtnnrnz7rqpM3EcbW38ad6tP518Pw2Yw88RumgRSv+tpPS+tnbfHd/h4qxk9zDTlzzSy/JISk8uDzRADOUOn6mK/k7TfAWO8YEH8fY8q7aRBfv9NdE7aNZdwABQ1VLN5BClmKUMLIxahQJmHAx2zC75BQ8Kpkq+py9GS7PFBlRNWy/6y0inb4EMa1q1SWHKShRc/1JYD+5YzonZ9uzTwZsCzMYEqSo8//HEZZHrGFPxrXgDdq9yoN7gnNDPTAXtOp9GXytj0Zi0dXopbTHJcrx1blxp0sm0kvPvHHFsmxXfqRqrbjj934ayzAqoLcEhDGcxP3KX6S3gDrxR1uIhNmtAEiLHfOkpCDFiey7v9ECWYsxwodcJjE4M2ONGhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(52116002)(7696005)(36756003)(8936002)(86362001)(38100700002)(6666004)(66476007)(55016002)(110136005)(316002)(54906003)(26005)(4326008)(956004)(44832011)(1076003)(2616005)(8886007)(478600001)(186003)(16526019)(7416002)(66946007)(5660300002)(8676002)(38350700002)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z6m+GNnltHP2hMIdwnULQAVEa41+FlZhQVhoZ1VLsIVvcY6HpdF6KhtFdB/C?=
 =?us-ascii?Q?m+/1tXbZYzknbhsSGemwD3wxBsGuT3uUzN7bbnNQG5RLkynOvCGajNeyUchS?=
 =?us-ascii?Q?23fUKE1Qbbl5JnYOCEf6shzP7xTuqFyw2pJQ7pEHk4dlqmaChJj+dh2a2GdM?=
 =?us-ascii?Q?P5YHOQAw6qyghXGt4hCCgrGp6ZV5+R9bNOAyEaG/qTanjIZQYIrpRVQ0lpEi?=
 =?us-ascii?Q?ffOuJSNJNyUJZf95l+6+y3sA5REsfkOYjJw+UFpYUHu9Mwm0fE2hcCLoAskh?=
 =?us-ascii?Q?XskaAvnYZlyxPOrjSl9UxXdBYmYlYf96xCCxntT5OJ5dQZssiYFqxbEADO2I?=
 =?us-ascii?Q?w4UM61AyPNDNvfh3L1kqRH6qqY3UBvSY5zDVbiCJZ3MqXh0iRxlfznRuHI/R?=
 =?us-ascii?Q?nNV9O8Rogai3H1QXixwY0lE9ZthUA5dFDtuiOlpDFCI794BM4HyXANV9h0OZ?=
 =?us-ascii?Q?q3pdKTMMaD2xE6LSuTd97+oxn0HphcxT0XMEHEGO0Jb08sQ3xwdPvLTYGEC0?=
 =?us-ascii?Q?YBvquE+qyMyQO4V2mYKcVd5XhNgObCmJnStaT8EAxFnDbDMgiMGVS46vnEkj?=
 =?us-ascii?Q?hsWhitI6WSZ452x8Vb/Xdmtk9Xp3Z3BWjE1MtijwgaU8l7OjQtNNMWowQU2j?=
 =?us-ascii?Q?RN5MUWgHGreqs7eWxX2EWAUY8FDmjP5LH+FT+daAE1+Yy7L7T8hgneoyqlrz?=
 =?us-ascii?Q?OxY+zh4o24HamlYH4TTXZcQk1dphKLdwjWZV4tmigvlljlEudyBpgKAiv/Fs?=
 =?us-ascii?Q?XLl+ctzzHhi96cZXzPoJH83PlwAGRvOPWu+XzK1emGSX2viJnpO4qeMFDftB?=
 =?us-ascii?Q?lAWNWMU0mzNEKkjeBLXJ0zbxJYdIeq4lbfcZMdfyrzL0KV6v+dKHKpATsEPQ?=
 =?us-ascii?Q?ze3DpjFJmzVyFSZMMXOElhqU00WIAGSRWQSZwJmayRprc8zBJvptTB7PY8Be?=
 =?us-ascii?Q?9XR2l3B9djFvuRTDJIetB3fw59/NWto+m8HzbvY2hj/vl0KunXVqTOrKnHk5?=
 =?us-ascii?Q?gXn8HdIvMa+v4eVl+acl9zPRgtj3pUblPrRoAP+7shr4YYunJ5xd6YX60HaG?=
 =?us-ascii?Q?d2ZKvjkkqkVFAP3kVJSVmTnwKzfIHZOdN/fhy5bN/1eIVQzuwHocLVoz5Gen?=
 =?us-ascii?Q?bVn66XUaqYkJUukgTGhe+1wYSBwuYEOGFhrq77EnSwE7ChdRToCdH8iul169?=
 =?us-ascii?Q?vC22KhFfoB+xKmXuC0IAxF5QfT8HbkBqmJSA3iSXACyNPMNLXTV+hPvOjALH?=
 =?us-ascii?Q?4XyLfvEWYb23F87CfdLVs6X3h6g9xhuDaN/EuKjklBsRP2DupuVCMvJgBX3w?=
 =?us-ascii?Q?ZSy8ETNQBfVTc0QUdaQ8chAN?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860ad3d8-7a80-4f86-eb4d-08d925b8fee0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:24:33.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgM7tQR/WhvJHE99shpyySM+rYGA2d/3Fw5QU/NWCAqRbyoZ1efOFOx17jXAO0Si0NvceLtziZPgfsmc+gE7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
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

