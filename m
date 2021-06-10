Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944863A23D8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 07:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFJFY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 01:24:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11467 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhFJFYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 01:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623302580; x=1654838580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qMoC26aE1t/imsmMoQjUxEhGnzi1b1hiqgTM5NyeOBU=;
  b=SZkuER4ge+Op7uKqUUwqoMptymwwvQVJTbbqx99kA0/sVyuK5bjC1MWb
   /VLThB5fxmqTrXxHhaDxej75N9FFmjGfieB6A9d+TBuZ3ma1UvU05b+tM
   7ikLPHAmcyF8hA4xZzuBQNNxYXSGTkMPMzKSfimyNhg58kYkEq4fXXIlk
   qE3XmJFjdY4j829qfK+n/ylP83CIw+xj56aXZJkndMsY7yhYri1FKcksH
   uU9BAc92DCwASOUPoWTsk91pzGckjgfAcdwF/Ian3JPeh4xANBpqIkFiA
   G4T1KTiK8EfD7bAw6u9ia+AHGzCkqULby1FUtvXcSlQtZuaDxoiAN7jEk
   w==;
IronPort-SDR: bmnYwauylbrZ3D4f8cu+z4W97mZF2ZHzqYtZOTFThh7V3YM1Ri6xRzeB2AwMcPSADmYIv4I0jS
 VzzlpqBifvO0V5g8/Fw85FBIfR4l0RVQHOSX3jeYNuq/cYjs/5IvHBCPlj1qjIrEQVcmRLXZPO
 z5R5RENilmc+GMXPaaJa8g2YD+iTJu5PbKjpeo/VIZ/To1nGAdu4bDwdiiQFVgDgIGFygRj3RQ
 9xp0hMpG6AMZQewFxq+gpeeF82+RsvOTvh33xH1oYcX3ck9D3gYyl4MGDtLmUZuK6pzyMPhfKA
 4/s=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="275211785"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 13:22:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhJzuCH2OGNqMNl7Sy9MuZV6GvT4Plq0D2zH81x9lpg0hjENWF0HDQ4j4IENXZVUHOwomkEN21RYtJ6xtuNXCuKGoaHKlQk6YnH3J8g0yngFse91z1SdXEJEhAn/7ZXKlpXyRVy+2n13s8GGSJn2tWdTAlTnsW0CmotL3w3k52GROMK1zWJWJdx3ZSJObpDbkxjjJQ/FX0s69TRt9uxshEb1IuEHad9l0FF9iILXsSN2aUPcs6ZTuelBYwG0h++ATELmKdtzvQBxb+vwha/BSzyL/Nax93Ya6dnxtRPaLE9P4S0qHX0fScFg6nK6+bxoN5Nmxv2QcpJZVJUvpOoCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=mnAeKrlow5uLDQOlGYSbrfjfj0/oNGaBPJ9gPku2CoFu42p4AaLkM7p1GuUXKspuLKQxNRY+yl0TXH2Ucy91se2qLxyMARZfehueRLiqyI/1L8sf74iGD29oG2JV9rOEixdflohhgm4Ue079bURoPYYopKHHyySRKECDiiIhCY/9IznYswUFxelxjUOv4grQZBkcDFxAtCcuZ5ObW4vIFvHyDnVxGAz3iY++v9QcV7U28DGYHlhuVIEny2nfSKpJpeJ5DJSKOORxD1eRta4fm7GuQPQBnyGBcy4YRm8ScXK3trOH7Vt6bPCmqbm3bTWcU75S1nh3LGeUl+7gMlZiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=OWB5hOZ26ELm5Gb6wreQe9AS7GH44pOcHk5Xa7uteWu7FaMxkZypbwxoluR32T7Q7DijbrkN5CbNAt4XEH8DwAAgyxROtF8JJ08CxXPVmov+y6f9ckKduLWOklhUsxZCYO3m4neAaLuRGXUuQ/Pabvd25Ie3mmT4OQxgv0GmD7o=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7778.namprd04.prod.outlook.com (2603:10b6:303:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:22:55 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 05:22:55 +0000
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
Subject: [PATCH v7 2/8] RISC-V: Rename relocate() and make it global
Date:   Thu, 10 Jun 2021 10:52:15 +0530
Message-Id: <20210610052221.39958-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.172.180) by MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 05:22:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58128431-17d7-42f2-2e4a-08d92bcfcd62
X-MS-TrafficTypeDiagnostic: CO6PR04MB7778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777828F1AC8D3EBA92C80B818D359@CO6PR04MB7778.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUnrDM3bRn56qKzFfEpcWy82D8iGW93h1KcLs25blpqOVLkIIDtfmWO+QOwLeOsR0I5YQRaScARyLsixT7M8LMnwIfzqxHkTGh+dCeINv1wJJumEfDk0u+3ewaso6Wjl+oPvOfO5Yryw5kl0h+Hnc3Wh5vQK/tCWal5VM5rympEpMQuou1RNIbtiHaIc9inafS9pxT1r53Qg/4UuYApBc9e9BJmG4TCabCIGciuzXTsVUz51WmUnSe1RhkIY0OqMEDb/AS+Xw4y5/x8QDA5DPNWTjqGZRFpG6DGv7zD+iw0ohDY38ULqTDJhI3CL6O8Nff4kkb+Q9SOaHySReW0auwlUy87rVZH1lVxXlK5l+R4M2jH7D+249jw+8HZQncb2JsIbvRdWnmhpRNB9etwjUpOXr7AWO5K+4vWRy0s9nuXETEQ5oE7BRPOgWLTXJRtdD1zf+w70QiN0dJ1OjN10aeXfpTOUaEMi6FV+0LqDnrZ39zN5SwgE5J+AMiWMYjJOrfgcIMxV1Wz+y2cI9aOp6YbD7BQlb7qGyMEpX8swdtlh3A69d3UfkGvvNOQEpdurIUBNmNW7bWRsW7kHk5MvBIyS8jehX72uvI51fes0JkpKP7lPHhpG2gCYVXbQ/ZYkuJhsovtvxy+rrZPUEp/aeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(110136005)(54906003)(44832011)(55016002)(5660300002)(7696005)(8676002)(316002)(83380400001)(8886007)(956004)(66946007)(66476007)(4326008)(1076003)(478600001)(38350700002)(2616005)(36756003)(66556008)(26005)(16526019)(2906002)(7416002)(6666004)(38100700002)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eh1XiF3wVl3LTYs7IQbhZBcPtYNu8sYTm+p6B3LBxwOXEiLrrY+4krbcHAix?=
 =?us-ascii?Q?VYGHuM0DcI0cRQvgwocQDV05oLetavleDIlJmocsyd5iZJrFMRMUPJltUyJm?=
 =?us-ascii?Q?mCRenFuZouf8GxkSybiFVZtj9hwHwV7hMtclOutWNA8t64XGIZ/NykcgFWEH?=
 =?us-ascii?Q?DBj6w3BjB2EEBWK1k7SraHK9j9t3/ZSLiFS/JUlSJsHESGRA8yLPrGUNkRfV?=
 =?us-ascii?Q?nkUebzangEW66Eh5lrdx5pvA5TrItN7n91sSXppV1zPKEPMkjbvRd3uCZxBP?=
 =?us-ascii?Q?aTwgae918FVfzALSpCp17ms8kgwwR3+7bwt8oFq92pEqRyvtvtwq02xj0xC8?=
 =?us-ascii?Q?haYtlhID45J+1G2V1p7g96YX8by7OLYUVHrVsxPJ35DkuVwWsOrqwz4Iuy2U?=
 =?us-ascii?Q?FXwtmIEq0qcHVxmpl/XymBfOGGACaV4bz3RwaN6MSDm/R8qXB/8mX0J5u94m?=
 =?us-ascii?Q?TNXC3tuQejSWsgZAvP6tWAThjJB5x1ls1VsiWhf9C2GMMSdZifChLzG27yve?=
 =?us-ascii?Q?GC9ECohyE3hVIR8zj7Ez990W6fMrwHkXyRJKLxYZ66WJ68SrSUQDjG4quVv/?=
 =?us-ascii?Q?e+MjIZVuF93YQ0lG7RemoKY5Pfxf+APGntq8pUeuqS2kybDq68mHavhtdT62?=
 =?us-ascii?Q?F8EVOA/d9/NjHweZEZNt3JFZ6az46UaSYQQS8rghaG2Je0gqlYWRty6yjuib?=
 =?us-ascii?Q?AHj6/FdKnWzaGzngq4kvkuq55QWfgkyw4XsKJ3INqm/CB5Ftkfl89nne14Fx?=
 =?us-ascii?Q?zImEBRBArgU2//9tNvkT2lnlvacIfkb9xMKI+5QiJ+OasptiEBExoJRqvEll?=
 =?us-ascii?Q?T3DgD44IBcfHPC8/OzTSVrKq+59WzDXhVr1t89v7JULP8gKfl9BGEbw9IN7c?=
 =?us-ascii?Q?HMp5iKqNU1wh5ltbxiJcm4+Z2xDHyTSr7+q8DR96GBtFA9l8xZstaVrfzZlJ?=
 =?us-ascii?Q?mH1rkQh/pbDgog/nNhRTz0QwcMKS2/5E4XfZZGM8gHNht+f8Pes3Vbf+ydqy?=
 =?us-ascii?Q?48fLqNE3USemgeINAWdKQ4j+peU9eagKRO+rLtyxAGfbn9ImPt+79kMP1Bbd?=
 =?us-ascii?Q?XiwGmBN08ncvQS8dnkvRY4oium4fPBX8DRVSjpbDR7OohjtBQ2RioPMtDgNn?=
 =?us-ascii?Q?Bmt8i2FA/h4fjTEstnML8Pr5S/RQWslHXfFJN1aLRZBpvN9IB8RdWIT/Q4ki?=
 =?us-ascii?Q?RJxR2Eg8OC1V8V+XRpI8WPGRxyQKAZVyo4DZ71X7Fh9cycYwIrWwYraC00V7?=
 =?us-ascii?Q?n90wJhe9GDIJcY3NlPBAuh6FHPUH44nuDr3UUpbs1IG0fa8uXAwiHVNDPLQU?=
 =?us-ascii?Q?KvSNg2/Tvobc53gIFcfdObST?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58128431-17d7-42f2-2e4a-08d92bcfcd62
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 05:22:55.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mjEBt1mQbQIz+k1lXLdFGntSmqCt8Fz0y1ihB+bSjQqkRpdyRIHX0YfumBUvbDPIWjyKxZUo2f8MyAuxon0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The low-level relocate() function enables mmu and relocates
execution to link-time addresses. We rename relocate() function
to relocate_enable_mmu() function which is more informative.

Also, the relocate_enable_mmu() function will be used in the
resume path when a CPU wakes-up from a non-retentive suspend
so we make it global symbol.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/head.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 89cc58ab52b4..a44c0bc9c2f3 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -79,7 +79,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_virt_addr
 	XIP_FIXUP_OFFSET a1
@@ -174,7 +175,7 @@ secondary_start_common:
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
 	tail smp_callin
@@ -311,7 +312,7 @@ clear_bss_done:
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif /* CONFIG_MMU */
 
 	call setup_trap_vector
-- 
2.25.1

