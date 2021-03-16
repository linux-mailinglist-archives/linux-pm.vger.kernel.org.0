Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5F33D1FA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhCPKmr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 06:42:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhCPKmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 06:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615891344; x=1647427344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ralm8k/63WyazuoS7AFhe+3kISfc1r0wmN3oTjhdH00=;
  b=BSxjoPApf0O3Fxct8XQcTxh+/Pgi3WJWuBRhnrmVfH1PrNMy06kPptnq
   ezEa0j6KauSOYXh3J0wRiVIAnX6FfFzOgVp2Dzi3781mhSdqjfuL2sAq2
   m1nOwZF1wpQOoTUB+mjnCKI+LbVkf6f1aEsLNLk5vAysSpE46tWIH/r/S
   WnxktZcC/pCegxkKOcveaniSLsBYZFI9S0oDxMQbO6qV1YCZ+xh98T4HE
   2Z8Viqj5XWjCjKbkkGcHXJP+T6Hij2oq6hXP21CxgHjLIjlydSdf0WgQq
   jZiTnjdMunTXNXL8JWOFepy5WVWx4kZVbzRLeBM0PBtiwx5tKxaszJx/2
   g==;
IronPort-SDR: aJtyj2JWiG5p0bPLD61m0hyJ79uNfH4G/67sooyV5pywKLlqzU+tq/tzAF9rSEcjkmoZWP7Tni
 wYZqtUBKpsE4ZhSkpzlyKSGGgRcnbxGxMMIXOtUjhwaP/HLyvtlLP16p6T4PSUcFedhUzQ73CG
 xjY5a61c8AM3vMAqhpvOXkjvozS19lhJRKtA5+IZCrZSUnUq3RtQ3bjNvt+zmBfcrjmGrGm+sS
 k+OM5LXpIUmlZZoijNJDEWsOx+reM4gGljhnf2TDhhKYdkD/C+zpMhhzWPkP+GMoq1trrmS1xe
 y0s=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272971741"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 18:42:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/Wa8aoxe0bTDuMnNwrf6U8Hrk/hYnhOupwo6aVNPLHfrtDpXmEDDbwvvc6xZ5Xt2YN9xumCb2MmSd+NcxuHg9l/pzarAMSXl5tItvyXeUbzRLA2VNQ3Nl71ux/dkefi/n8xGXD4nJc0hyOuaKTf2JO9SYX498QKos7COUxefRQ090JL67TSg7wxqgg6N/HqUr+kBIqt5wxb+QA6jgkfmsrvbzLli4Gtk4xzkfGbYB4HC0/FNDkIQmwiJvz2xsRhPpH+S24UCuNvDfJ6Tn35GoNc1mM7UYGiYxYqPjK4tJef7RUEe7irJ8wT3sBwO7nGt060Bl8V7t6+Vj4DYMHa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0wPjTixz4TiJoGCIyTd0KmxUTeO+KNL6ZCrnJLaXhQ=;
 b=MfHtJzZhEmwo9B7at7zb5QwOuC377iE7KdjI9QyscgIiGJgkiE/220idb0zBBaMTSD4Se0S3Y5P9OpRjZ17j3qUIUghazDMiQYQxzFgKaUCW4NVqgCkG9K03BUgRQ+dYTTEPIOPDtfmxTIwQpnpGdijO+/K6F/1O/fJU6ORYTVgZcStIj2KdwpIjlfaTkPLG9LafjYyLz39ZIAA790dX+/qmrYgaSX4ZNKYfhA7nNslxY6Fg0B0xo9OHyKcRqAH+WS4DdV3pZXKju5i3Srvbtzkl/yArIfOHapRfJ3IpI+QxWzZpSSDsdDQHdVD8BURAXSO971aBPPlLOpiov3yBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0wPjTixz4TiJoGCIyTd0KmxUTeO+KNL6ZCrnJLaXhQ=;
 b=CXlCzGdsj0boJhttmT6RL2fymLnGQkuVahiX++CYBeW3y9TZAqi7Gblyfl7zqyRCAQP9WzBic8bebjUit+jKuedNW+EFJDjBWzeKfbDBBwkHOnyv17yNMziVGLtwPCtXn3NAJuU6xIL8YGUnWRRIskfeZu56VxCL1okS7hR7ZIM=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6377.namprd04.prod.outlook.com (2603:10b6:5:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 10:42:22 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 10:42:22 +0000
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
Subject: [RFC PATCH v2 2/8] RISC-V: Rename relocate() and make it global
Date:   Tue, 16 Mar 2021 16:11:34 +0530
Message-Id: <20210316104140.878019-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.167.218.45) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 10:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d43ed711-2149-4d60-a00e-08d8e8682dfa
X-MS-TrafficTypeDiagnostic: DM6PR04MB6377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6377FC44C782419D8318F7758D6B9@DM6PR04MB6377.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeULs70o4zk9xrup/fBFEW/FVqb/dR0ETV5mInQM08NiiDIMAb/7SauA9LSXPFoszu67rTsRfBBZQ6t9mbCh1eabB6lQ39iLVCAonsndZKcnmR8FaKTF8Zqh7saLUOrfPf0P2SLKesQM2cjvO6IUcIJQ+4BDbcvamSW/0mRSdI1knvCVxpcVFIVjulPdzJKYM1GpxmLVz4swMTBH5JS14Ngb/5Qdk4HiBJ0Z+dzJ0621XDVO2E/M0ixvAIzyIL/HBa+vtjVX0heu3nIYa2n8YyAxECd1VIY7VjSCs8IQlC0P84xhugh/TL1G4uTKLYlA7hoEi9XykgZQCB2yG010IggogVW5xS+1xsB8RkYEEEQ+5tGgj8OZKxvVzNcarPRmY9QOogOijYvepgYBNl0M8WPXFv2CCO/6SEW+4woR0oghonCM2VN8LDMnjvXqkLX6D9b30PhOOuitveDr0bjWLG2t4zLktDADafnaLkS5kp8b61iP+990TpA2itmxSLzf7CtitladtTjxssMyL1VLpVnSbDGIlEU3yZFQMkqYKJ7d7OS6UUIbCo4nbxwgZsbv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(44832011)(52116002)(86362001)(83380400001)(110136005)(7696005)(8936002)(66946007)(8886007)(55016002)(7416002)(186003)(66556008)(16526019)(66476007)(26005)(956004)(2906002)(2616005)(4326008)(6666004)(5660300002)(498600001)(1076003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?poxuE+jsx0N0iwmSJwl8qbyrmuzEwkx8joonPNWb9Xkmo3/GuCT9puolsyOM?=
 =?us-ascii?Q?GMDOJH9Ho1qgmySloVGSihs7nQPwIKKHRXgEScLzOdJzw2/utObIfF5nbwRr?=
 =?us-ascii?Q?HgioD3/l1WpOzUz6aq2dV6UKJoN5M/VfM3CWFqGrRYjkalSazPU/QFKr/ecQ?=
 =?us-ascii?Q?ZRs7FQ7NwshO3uIqUXOgeBwgCjU7ETr6TDUKhFg7/Xr5XtHewvCww9DyUd7N?=
 =?us-ascii?Q?gxvR9FPE1wCrrRMbZ7mXb/Zyv/2zgg5KEfzL5ZDtId3g0EZUHcS+wFOsV0bH?=
 =?us-ascii?Q?dXrUJyIMc1lzv1aQtNuuSAO31HCaX1ID4tTwLzZVkuryV8MD2+5Lx7RhHNE3?=
 =?us-ascii?Q?vWBnfeZ3FGfSqT41B6y5OA/n5JHhYGHbP2AszykiPtn1cadqg8yDKi4q59PB?=
 =?us-ascii?Q?meOTSrodJUAe5j5Bd7leRdXUcpqdmYxuO/p/IfMu9H/OqVnObRDKSz+LtF2L?=
 =?us-ascii?Q?OJmyxaWz/+TOYZY5xyB/j/yFHKKicyghm1ryHUxrAWbP7xUeCVW/e2i/Cj9+?=
 =?us-ascii?Q?+wOlho+99EBwZIWbIgjc9Z9GkALjPfzbQG4OqH9kxhFLhUBtJMD1LFqyMMAm?=
 =?us-ascii?Q?kDJfRWdbH7PcsrK12HEqhluQNvgsRFtU01vBd1tYjVnFujbVOocIdbHNgpeH?=
 =?us-ascii?Q?jGW8r7KNecw15dGBOYw0PEhxDJU4ItZOPXY9lcatwLLjfuTqvivw1qvjyaEv?=
 =?us-ascii?Q?LE9zPaA2HeSu3z0DVbqrEX/keUtN2gP3zmiHH10eylsJhMztOxBVreJDyF+d?=
 =?us-ascii?Q?DzJYqFvSRqfOFjFEv3gAN4U323wASvegFzPfYZz8wsY2P9+h+y+YFPILkqpP?=
 =?us-ascii?Q?W9oHjJwL8mfRl8OEPqcbWGT5DWRBNj+WUvDEOa1Vf+xTWHGAF/+AQKK9O1hq?=
 =?us-ascii?Q?/n+SKaUoqPxuOHuoDd+kjecCVsrMcELcFOCia3JRJJfevrulbnDQdaDIoTpT?=
 =?us-ascii?Q?plt8zadMm0KAGjoAKIn6WE8u481Tb3yeZXOTv1klKIAycum448vQHN+Mf+E4?=
 =?us-ascii?Q?i1jHc3nE0mikwAa1W6cRXgB7BucuJs00n9xgEANfVnbBcF0VXLnkTseRSxKa?=
 =?us-ascii?Q?3CTd5AMXSyw1L+1ErKvlQW47G1TmSXgOegxehnLYUSgaVZd2X2M6EwH5t/22?=
 =?us-ascii?Q?73XB6/xkzVvUUQ91IzjsTJTDZNNVykjV5c2pXeQwjcoRB5TOASmHx1PCVshs?=
 =?us-ascii?Q?Cu7xs545rUJ58aIRXy2OXL8iN8XcxKWVq1/o3iAdXIRU7jIOAUePMDTK1DYU?=
 =?us-ascii?Q?oqUh1pBtvHOppCV9f+oYSsWZQDJepjWF/8SwymFo9HmtygIbM2ktKQq0Lt0x?=
 =?us-ascii?Q?yG+QNjrzfIOsAwcSkU+305Ez?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43ed711-2149-4d60-a00e-08d8e8682dfa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 10:42:22.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCMid6aQGvxrewXkPHnRrJL7qfWeDyfDxfafHZMXR4aDHp8FaD6bPbaw5lV88zYdWCdWrtPHPO8hz5BHwnbOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6377
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

