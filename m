Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B213A1458
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFIM3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:29:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39855 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhFIM3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623241671; x=1654777671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qMoC26aE1t/imsmMoQjUxEhGnzi1b1hiqgTM5NyeOBU=;
  b=lCv5jTU/vSx79683s1oy7AmNYl3Kvys7ZC1QF6LuDSMlwUuNKiGqDFJI
   IHw7jUVUa53XIQNUtTD9gBEOOAnhwIWc/s0ni14OTe/6+suLDtpt2TprJ
   AFx+/Q6B4V63j7MRUggariU1+aD5E+lO+ghoLoxiZ5C897HwlL4e/fhOM
   1gzj8cfcJ8bu8b0k0N9dJXqEaKrZ+ZiQFhYcTAqU/HHl6dtD8sIgE2DS3
   oOYBT6jD+rn2dEA+Oj5VO71pouF8X0Im8J4ZbWMH+p46yEhqiZhPBfklh
   cNnNPE3LdaBfpnhfi/Ldkg/tXRRy+XOqum9VnQH9gmZWgrNcLKOFTKehi
   w==;
IronPort-SDR: tfsHaM0w8h+akyO/rFgRCf3KBtXuQQfcSjsumDjGmSqEyeBsIDZDklE8MQJvLUPb5RNIH6vZ44
 eZbs44Ds1ZBbk8Htt7yGXKbOa6VPOI+kHaqlk9/8+hfRdO9LE+sxU86p79z4BwdQYw6Jj+swFx
 ytBuMcxzSAIK3sE1TCZU7iUmxCucUEdF+FZvDiVE7PtdAhuQjTb5roXKtpr51Z8dtGDLR4TdT0
 fHU9n2ms0JcoOI7jCIm5kobjdkteAWHfCdAb5judzdgFGcSh7HacyBVpYleTcYmzLEarN+K798
 jZY=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="170576507"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 20:27:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJD1MsLucIOCfRuiRC+h8BWuFrY09jT+ZNGhL1sneEZKsYzqk92czclw5mMKMqWP5nGNF0l9rPpOJr6FYJs7TdbJ63NWnLLvdz68VCRiXo/sB4FaDoH7wc4kSHZvoWIDZ/NmNcnKVWI/QMTW9epOk0NozwDuHp7ie7tO+2R2n0hkLaZND5S6Q9ah59nMYJU59NQoPjMypbitJvlrkQQhQVxG2rIr5oim9+BvKWXI5I8nVsvXTutQAQpeiDWuv70NlfyJntdOGPP4mX45B1qGx+329tffAGkGgrsStYAoVqGxeBIlY+v0g8FPxoJT83MYp/xK02irscsong269eRT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=F3G+8zpfzRUgEa5AEBTL4JPi9sx2hy1GvyXQfO3U57je4Ak/d6P8gieoNQNHJ3yI0VVNgDAxWkTDJ9ytnD42qwvXZYXyUdM7bmJZR54OkZ/WO+U4B4ZaoAtpAwO5/CZ11Xkk4mUELjW6hIWw/ZuAniDxpJ3Hga2X3kBYBaAUBSfA1JLmxEYpLMQNtFs/5lHFgjMybYqiCyUVvnRh9wpdrrwj5XS2EveIPCUIc3MQeIT2PTjJXMxhoEWLewhRidBMTyDqQyx7iA2fzpdG4em4YOWG05/33TGZ3Q5Vdr4uGu+ftH84DTjNJdhxcjnOz3AFB6YHJx566yMnwEzFQ8NE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=D0Nj55Fcgm2YDNXsQ1Ui2gykoRb0Du1rKNWcw+tWitHWRhZp6xSIqTiilywzEG7GuJfTgt0D33vfvTBh6PVT83kfR3Lg3RSVHwp1Aiu7EiQ9QKFzE4lhXYgxQHmRLBhHcPW1+6m5jNJU1k80MF16BP8eZhzC6T5WhYd2JSR7dPI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 12:27:49 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 12:27:49 +0000
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
Subject: [PATCH v6 2/8] RISC-V: Rename relocate() and make it global
Date:   Wed,  9 Jun 2021 17:57:09 +0530
Message-Id: <20210609122715.3389-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.172.176.125) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1cb98bf-aef5-4ba9-208b-08d92b41fe6a
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7843D00D92AC76D0ACDF10B08D369@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtJ7Fyilkn+FAzPhYYRMUiTv7fE0VxFRryfOVh0VOoyzsgrG9SXu0edZO9xxDe0SGW2GZ8md5ViN0X2+NNH8icmNqC9/JppVOc2ERrue6x8oatrQjOxfM0a1CDfZrqvvyB/LW5Y0Ch5K82I3SNbhcnfWGwRwCxdpFxOQuKM+zYh3AFtzaGUKA+9S3dTI2lqes5oAVykC2UiR1QNxUc9t76mfcJHRqtcn0v4MDaqh8kVj6SQX4JPLwe/iw6WdCjHitnMnFFA6GmC4vvjPn0SCQ09Xmjz7bSKsJHAkW83m6dtjR0+jVcZPMSsoMYkIB9V/QXPsZ4DAXRIXd7QJg2FLkkhvjEkvLa2lUmwsyg7WN14+4wNk/+Ets8zV851k3PbAT6fu6LvwGM7+Sj0ZEGwHS/t4+Q3c3FEvkLqmaD8dvoIyhOFf7Nh0c5W8jdYlAONWhZYz0+NC7Ymhvmyl42uwbHHFBB4SAf5PmEtICMzy0N4TjEFOcFIMDYcNwOzf7Ol2QtXA9Fr+G7bGNJGwRrJX7U0USKqxpxh5WVmQoBuXtSXqTnUSjHR382ha2l+uSu95OcoUWlKqfOH2TNVLn2WzawR9z6/ppdl67oVDVNv/rEEXkOqyz0qVJaKEAcccsCuyh5S1n8zRFBileQEJNXFYPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(4326008)(8676002)(8886007)(83380400001)(478600001)(110136005)(956004)(316002)(86362001)(6666004)(44832011)(2616005)(38350700002)(52116002)(2906002)(55236004)(7696005)(26005)(8936002)(38100700002)(1076003)(55016002)(66476007)(66556008)(66946007)(36756003)(16526019)(186003)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1g42yiLJYrS5gtP+/A5rctfnumkjrjAhW/FDQPnPyvGZwW95lfPayCfXd1E?=
 =?us-ascii?Q?+RLY0nP4WrsBB1eMWWLtJRjRZcRMOVmO3JvX1+zTpmZa2+kon3QInLAXalo2?=
 =?us-ascii?Q?ws8CvgPVxYSL1wpzH5sqcEYzOLlXoAP6ZEP/BD7Qi9JwW24B0UMkg/+GIPY5?=
 =?us-ascii?Q?hSQy4VDmvXBK6np6bmTORjgTfg+Iv8AOOIGKubiYFr3jWaZ+VFirR4ewpoIZ?=
 =?us-ascii?Q?hx46O0DZqKL0VJIaw+vEtCKObqXf7BwGGuGtVDNY4R4IV+9dm4Gs8NRi0Bvc?=
 =?us-ascii?Q?6GUxx58rsls0IAMY6dRNowKQMFaftX8jJSgZdABnNEdb2AJuN3r+IquO8GkQ?=
 =?us-ascii?Q?wDYJg3i8CJEiFaBz2LqtPWRoHh4RF5FmX3tp/EOpYnYzCJDGOy4C0Hq3ZDUh?=
 =?us-ascii?Q?QXlZ95co5o/dBtkHnsV1DuPCplPEVvBb1TaDVR4aVgMWcKftwS0rYxqWskSE?=
 =?us-ascii?Q?jHt2RE2I5oV/7Os89xgzr0kEcl5o+VrUmPX2jVeLxZ4mkgcH7ZV9f03rSbwL?=
 =?us-ascii?Q?iLE2a8LsBEliAy99aV6cVR7uZJ4JWcp7xMYiXZv9RHr0/q1IHBzDJMbELl/B?=
 =?us-ascii?Q?YQvxgxS34pTpMxyDyY8R0T+S76CZz5C/vMoL3n6yVua2bfYObg19WUkGqpzt?=
 =?us-ascii?Q?MlQEWZzhEBOXPdmcQtLxPYiNdnF2DnekfjSwJqAfaaaX7JUM322tdHY3tNhH?=
 =?us-ascii?Q?7d+mg9tg1Zt8RuvLKRrOg6rh714AtwQ3cSOZ4nGZmwDtbqgN6kMQi9HD7pqr?=
 =?us-ascii?Q?gOC/WZFce/X+3ave5nAu+z4ZZP+hb6zQOyhoeAARAaH+7BU6VQOstJz2ruf/?=
 =?us-ascii?Q?+oXJirQjQB3P6qMt/HVoyeN+R6W4fxO3Bs7Css2webPjVzxfxR+SK73MDVO9?=
 =?us-ascii?Q?7vpZ3EYdAuNBG5hEGtzBKkkRQ8B8kwLqiUlW1prWC8P9Yw8qpZQ5szI+BtNa?=
 =?us-ascii?Q?RZZOeonc8xWZUfB53pFteOLPrqgR7pL9KB6OzRfXzD6W/SnFC2w8+lBeRuMv?=
 =?us-ascii?Q?dSdiY7g01wdystWoyn7VwdNtg9NDzZnPpdwTcYN2mDzRuadfgC5wptky60Oj?=
 =?us-ascii?Q?hgBLdUtWI6C1aNFOHE2NYBBlsatqEs3hIT7/jIB9/zafBuxl/oF+c+8yuDQC?=
 =?us-ascii?Q?0tq2c7X3X/jH5Ly8PiiT413X+jBwoi/OGUweY6M8pyCdQjDAs94845Feowht?=
 =?us-ascii?Q?GTHK4II54w1vP3iwpV7QglQQnvY18a4/rQgk4WneBPqxfYVOZOhK30svTmsj?=
 =?us-ascii?Q?RA1vsZsWgjEMcrSK8oKF/f6SNRtp9SIbYNgo2UNerBHWssrWw57XjqYTHkCO?=
 =?us-ascii?Q?Wls+kSee3lrdVkQXkRa8Rt5Y?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cb98bf-aef5-4ba9-208b-08d92b41fe6a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:27:49.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k52SNAzSqtixTzYc8PqKLkO+QPc50lne7Oim6Q4E7MYlMvdJfavMXWB/MTSzNxzrUTN0mam6BUNKLTbpexfvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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

