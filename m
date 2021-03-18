Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DD340653
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhCRNGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 09:06:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64214 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRNFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 09:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616072755; x=1647608755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ralm8k/63WyazuoS7AFhe+3kISfc1r0wmN3oTjhdH00=;
  b=BgImH2KYHpWgvHSBwa5ccTph/5HztUvoMQ06BAb0p2Yd8eJqlrh/KXfT
   v+XEkeLBhnypxEm74foYZ6ak/F8zyP9YT2nunV+SlflCa3Z4zAZzBUpOJ
   o1sliN28+KLXvNFQJ8eYbGOFYdurTcHSHBpva+ANYW2VJOyZ/kIoNOlvF
   LonSoI4d0OnngI8oh4pmcbquoVtRuqMipB9gLz6KT+GkXYR6fGSqr9Fi4
   5R/qGB36I1icwxy0UAo1qGeyyEF2L03ldOQ+XEOE8V25p/9EmIT8XZShr
   9du7EhP7Pz92KMQANxw7ZqmsTHFGNEPpVXpz4NyzO2TFBJHlDJaRfhBrn
   w==;
IronPort-SDR: 5iU+K88aTlFjHl02CQM4FUlWWtLjTL4bwvTHmkTny3Rn8o68+5QjKrfB3NpeSSknfW6FqjiCdn
 2Tx6lYtuyykBYcNTe8vJaAipZjmMfIhSkai7S5vrTiHdM/aY7iuMbvaQ2/tsc67o7ZWmdWvmum
 Ul7AVadKmnSz5MFK2mjCk4bct8yYAfElgeDPVPFtSjNPv7pu67m/fKZwmcr2St8APZAIH68GO0
 wXMY/sq1HpdmT7a2hevFIdabhUEwfTefogOsww5mNqqG+4stllgX39CTT85NtpZoxYn2SqEd3j
 N8g=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="162461272"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 21:05:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXCFXcJ4NfkwF/Y3RvjDXXJXk3UFlYee4b7GtEazKACwos9rvzD/of1F9atSJw8TAGd2nYCQlOLhmoiKJ5XweoUAjwHrbWfy8bkZRUizdFmq1tGAXtRkr4slqRdPPV+YsL9ioQ7Q4Fs80IzEvbtZsgQNh++Ar53T7uTvFI1iqr2aKtkpbQsZec+wD6pUrg4UAAzqg6qSXtaH4kGo3I1ntWJoCgwFnByfCc2sWHdayL89oOpg1DcA26FYQkP93HCohxN5uuRH8zXnEW1csyu96b8N5SrsBmTKVwnzGBLS0uxQg0wHfI+82NUW/AhPEIoN4Um2cHAXgmENS5OvFcRX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0wPjTixz4TiJoGCIyTd0KmxUTeO+KNL6ZCrnJLaXhQ=;
 b=jeN3CIxqJK59mgGsTP2soYB5Rw6UR43flBGYqOunzCp6Ts/gGnv1PYVqZfEMjUQDkkDfozaJigsEaZlRbL0KtwemmdkMBRPIYQ4r5j0VZKV9XwHGM4eKc8o0Is/C3jaZKYATy2QXAl360LpChjGdOJhY90whlAzywRZutTlUFccFZskJFmFuWs+WIiqT7YMSHJxdd2ppxKbUuLfr2DDic+xKfI6UeYqgt6+KO+ZabTYJR15fSwXCCv6a1euW04XNrGKD0IGjlnpNKQVLV8pId76XQXViFmrkgjCishjE3DkMlnKZC2Y8VdiW90DwaMSuqRnHY0VrZ21cPT4QptB8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0wPjTixz4TiJoGCIyTd0KmxUTeO+KNL6ZCrnJLaXhQ=;
 b=zZDCUIUrYuAt3HTCgK95pxEDkH+WlzQebmNDIdjqsTybfCAVZz+7SIdgWasHYFoi5B0BiGde4JZ79lu2tPb7iOu3aPJLCbI5IGFZ75n9K4sw4Cl/cnow1jsV8magqTZGuODPlr7qLofeNq10sBu7k0VzdZDlM/Pn1TbineKiP5k=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0826.namprd04.prod.outlook.com (2603:10b6:3:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:05:53 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:05:53 +0000
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
Subject: [RFC PATCH v3 2/8] RISC-V: Rename relocate() and make it global
Date:   Thu, 18 Mar 2021 18:35:06 +0530
Message-Id: <20210318130512.1025416-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318130512.1025416-1-anup.patel@wdc.com>
References: <20210318130512.1025416-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.155.94]
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.155.94) by MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 13:05:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa5a1555-36be-4767-4ae2-08d8ea0e8f40
X-MS-TrafficTypeDiagnostic: DM5PR04MB0826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0826516EAF038819BD21D7418D699@DM5PR04MB0826.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95wIXhUEDzKGp0bn3wTfacvxqYhZy1Vo4EHOxHSDySj6A8tloFrDrwAHCQzVeRTOk4YaQeLaf6U90T8evFuBMxaWo0sl4Eh8T6cTrB9TNAkvn1lTakS3nUPZfwUB9UV94pCv+og4sGIiwukT0hLgy1qR+0BeKUSTEYJnf+QVFiZbZFbNsX6vOGCq+sEL++uzph8uUvA3m3QXP0iQAzN91fLAoErzsWZI4/sdfyK728Gv5xN29Hnu3N7YFOM47+4AgPzxJnQQZs/n7/QQ1Ufd00KGRl82OEtp9r1sNdvLWYeRlVZyA2LdfLXB9tSHdnBT1ct7oinc876SDGBudf00+2kYpKBzhgaFbfLRJO4dJXjsknpXfkiq/YXc6VfWmZwBhFAPbBq1yZSAcDok/V7JnvKggTlGu1j96U34u4EwhThVded59bbnvp07vsQnypdk3dfuetyp/Bonzkqpw/tj33epRPdUBFJVG7ZH5LWHVrqKBZ/JKWiY1DjxGGPOHfaARGKYSM8EamTVuxZeHzQDV0KjPgvAN7BAtfpinl4UtAd/anrXXV6oOdpeN9HnmhPk3jW//9hwFi+Se+8muOi9imK25aXHwJiuIZByTIOmyvRsQLt687PTImAJxCJiaPh2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4326008)(86362001)(44832011)(2906002)(186003)(36756003)(478600001)(110136005)(1076003)(38100700001)(316002)(956004)(55016002)(2616005)(8936002)(8886007)(26005)(7416002)(54906003)(66556008)(5660300002)(16526019)(8676002)(66946007)(6666004)(66476007)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kLswbj9DTyVyHxj5LAHpN0XukWPukLzelXKwiQfmpbw3RMZ0WEi/Ro/Rtvch?=
 =?us-ascii?Q?GQD1WAikDCVX04OnRJgnzlQGCOZRe+uxiCsQPJyyEbG8UGbkBMLfKEHOE9PS?=
 =?us-ascii?Q?/yHFRf6CO/Lorj+IdxtN3q/7wwkQemzp5URMauTOmes+FPqL4GGnjP/u3AX4?=
 =?us-ascii?Q?VooiIZrZ0tuEUiKk+/6VsCkUvfIVfqhsH12nqqmxPvJyuzffFcUp2DAUHNiJ?=
 =?us-ascii?Q?jBdrspx+1yNPJQjv5wn0bcBs/H6Rmrbduqfn8TSS9ys/osEh0JRaeUb8pK76?=
 =?us-ascii?Q?nBAufOWG6lCGjKtpQXv1X0UJU+AtAbbE7n6k4Drhlbec/7H6UKsKskLHSGAv?=
 =?us-ascii?Q?FsEGaSXK1vpB/8dvIeEYtBbQo8vhQ3YSyt2Cdi6cTAY1i+5CZGBn7HlWn/HC?=
 =?us-ascii?Q?Zg2n5zUhXvGCGsoFyr9NcS/KWDMVZ3WjhZSxUvvTHzuM5T06RxROTwFQQn0B?=
 =?us-ascii?Q?cwtFPGG81FPnu95vuRt6AlR//dFfw/rzRHBTTBVcq3PxSmZiwzSa1RunJLqW?=
 =?us-ascii?Q?kE2O1c3bZWjAWGqaJAV+G2qC98w/kzkgmSmIFHZz9DIxOmZHTAX9FPNwohpV?=
 =?us-ascii?Q?JlKyuzPqSxqQAejPdAtsxX998Lw6ap9Qt5dWetvXgwSQ5NqrRDgrQ0qrLjag?=
 =?us-ascii?Q?iNhOHUa3BByJ9TrgJS6JpQQX1Wwy/2HI1bZUtr2ebz784PrI2NIhZlv/GY8T?=
 =?us-ascii?Q?IvdGBQTCiimYpb7aRD2y+sCwd6AIhCMLCgyQzB8/hAfohVU/RpKIz8UZMdwB?=
 =?us-ascii?Q?j4iVzbimC+cf4QPwcqlM66T8MDDIrEmLeRmFwxXgDNNFDZ4pyuxOCXi4aDmc?=
 =?us-ascii?Q?3tiFsf7WA3yCfM8W3kkW7adj0snEGxtITDq+ou3QMVu/77ui88TE4YIEkbXA?=
 =?us-ascii?Q?yPVF5K2IrJ5paqb6gAUwD4LJVRM/eF1pRYYLEM5rFE3SMX06FNtPLTYGrCd7?=
 =?us-ascii?Q?Uxg0jKssDgmoaIW6HXmObYpRxh6uHmW2Id5QTciMn5J2ezqqctkNTYBat5FG?=
 =?us-ascii?Q?RLl+dz8GYZFVTRmzcV+gjehNg/fMV10IGiffk4pQXqeOQHAEA/MRyQWgYJXs?=
 =?us-ascii?Q?onjcJvGgv1wxgBp09HzcstpVkvxHu/Wev0gsESe0RllPOyXlHEsr2j4Ac1ev?=
 =?us-ascii?Q?uWYFfgH7GavTt8rSZPuCu/bhWlPOVELKUvNGQQpF9WFrOr0C8fiOEnCj71T/?=
 =?us-ascii?Q?0RUlzv1AVPKN6VVKBMlmqYj/K4VpqUklmrOGHgxFSL5Bpsa4wqryzzBq6t1f?=
 =?us-ascii?Q?A3vpwtICfyLPJm96GwS4Ez6Yic0InaK5uPSCPtiI6KtlAvnqm6gGWalVSSsf?=
 =?us-ascii?Q?767A3zgGNqxNLN7iUo+yyJj6?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a1555-36be-4767-4ae2-08d8ea0e8f40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 13:05:53.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJZSVlK0zR8oa1ViDPaJEpdHEgOmW3fFz1vysWZs6KndfunLPijNRhG/CB0D16i/g9MXJp0ueYilPxdGbmLESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0826
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
index f5a9bad86e58..9d10f89e8ab7 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -67,7 +67,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	li a1, PAGE_OFFSET
 	la a2, _start
@@ -156,7 +157,7 @@ secondary_start_common:
 #ifdef CONFIG_MMU
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
-	call relocate
+	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
 	tail smp_callin
@@ -268,7 +269,7 @@ clear_bss_done:
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
-	call relocate
+	call relocate_enable_mmu
 #endif /* CONFIG_MMU */
 
 	call setup_trap_vector
-- 
2.25.1

