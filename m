Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CA242887A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhJKIVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 04:21:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7044 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhJKIVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 04:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633940344; x=1665476344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xfiKKU2D92LxFD91PWDY3j4rlGe5f1xCNcR6FeJ7upY=;
  b=nRT3vT+qCejXXOP0xliCW2fdyEJD5C/1jGsgtC6GUKqHjr/hG7VdZKli
   8sdepG6nfURIpmXlgbdUROZ9NPn1kfcW7lgHrZZzwHaVeNxYgzq6cfWnZ
   VAz+OZBKUP79ReNEYii9S+HetLk+EDCS0RAvwoSA1kDb31BcRIzFLFcZv
   WUXP2bORdiSiRIltLbeREbeH/Nm90FnVVvzOygc0Cj9LCJnCBWRAOBt60
   U4ZPVvTS2DmvxMsZwxmAxfJzzUXfFoGNpAuGWwgdUZZHo/2AKVs9rVoxg
   VkCx9RGOv0p8/7BG8xovVNfz7GvrlmcBkJIp3p0QBs/2kpK0iCFg1TvG8
   w==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286313133"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 16:19:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpeLLCMpomRtb5ss4HA3gWhbJSQYsMCW2oghS7doQ/2DLO+qaLkun7QqR+9Y2FIzuCUyRmO2U4uagHtvEdQII0eE7H3MvzBzjUw94eBR1k7D5lw+XjpSZ5l64Gy6kml8ZO8UsEf8rGpBd8JAQq9arN0I3SIX5Ak8flTBvsKmSkPG327dunzBgHrOiTFHeNPRwfV6TUhLQfH2RTiv2Oa/akvREis3eKk7Py002rHNLMGwlWQECxOsql73Okou27pGMdCYPUhnCtS+EOkLsaOp58FN/ENbNR3C+nGMx7f3XoM3kKDm6B48pHXJjTIve0V9ZaSYwA2lSzQ6g9Uifw1uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB0r+rzkrWS+zQQTlAjsnrMWWHVWEZr99UXf0qaQoKI=;
 b=aAxzL0l3KSSZbrC09IOdx36aygHKOKEd6WV12CC6jK5bFv4vFj+XbzFONlkP1gxsGBntt7Fdt1IkoX/7UBiP0pKOOgQmY6VhJuUkUiHQkR/K7DicR7WftLOxhbqYQZ/qvrEf3geole+4hOvid3sEywUq2XN452ym3YA5RRh3hgM3SdpcNqFmx7Tilbtk5d1PXCT5veZxYMREQ7C9mr4W2fbJ35ZIbT5YVtlLOXUac6rBmdGfg+DZFkKe/8jUXYRh6HGyv+XtVC9aQH0KISnfGvyXhgg39mQZ8UUzPahHffiBgM8+QsUkItn4VKtV12wirRLrFmkt0ucIZyLGnAV8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB0r+rzkrWS+zQQTlAjsnrMWWHVWEZr99UXf0qaQoKI=;
 b=IBHXXvp77Y1w7V/J1PNyjlWIRmEU+ZW/pZ5IFticN423JoTrY8y9znkDZYTzf/v9g1oMcJoBh7P8E8I5HfqG+wx4Ih3j5HQbhqvm1D9RCAZSs+Rl6DIEt4qffPU3D6R5UbCWfp/KD3zNlPC5Ee+R1Nm6P+fd/iV4P1BH36vSv6I=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8345.namprd04.prod.outlook.com (2603:10b6:303:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 08:18:59 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:18:58 +0000
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
Subject: [PATCH v8 2/8] RISC-V: Rename relocate() and make it global
Date:   Mon, 11 Oct 2021 13:48:14 +0530
Message-Id: <20211011081820.1135261-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011081820.1135261-1-anup.patel@wdc.com>
References: <20211011081820.1135261-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.171.184.84) by MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a50a941-8b21-4f09-fb76-08d98c8fc644
X-MS-TrafficTypeDiagnostic: CO6PR04MB8345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB8345FF98032AAFBCFBACD8D88DB59@CO6PR04MB8345.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHTejd1yQGiNE/Aix+1jdRXaDyoGZlA6fmDZeABL6A1uAwDUPc/BsNY3e+hRsTo8hTWbCehkoStHNkA10H4rQIPPRXbMqk9zNDaj2+TLoa3rUjkebvnJ5t95bSSuMbF2Psj3hmie7zlFb+ru+/oGryGDaqZRUyva+CwRqhcmfAirGjsk+7FlB79xWWigG/DwPon5jv8nU7oP4y8hcPDxI0MKcXs6+4+93WIIhM0gtejt++OePeA0gHlY8N+VJqhDu0Wm3eJkTJllidf7h3fOD+WTvaImTsxdHkM1+nq1qLuZa9VKcrkiEa5axDOu8y10V3w1xTK7hAofFxoS2MpJR9N70pqmGlpkwFKhCaRqiwopAYO5PCwIuW3QBvUP63Dnngc0+z2k3lnbcAYmn0cI5cmEINdiTvbTjWwC5w46GxLfg3SP9JkagKYAB5busQPO6alUeanZjtSzTyFfT3Z8heHshqh5dJ+SbBOIFiL1leAYc+N61qSzFJ4wPiDOR2IDY2kWmAzmUITxGjHQGlHov7mAs+Mb/Yi3gnPSA2aTNiQMnqOkIg/qPL9JqKGUvPVLNA6xmLKZZ4ORvWYD3ylC6HDoY3n6syUU0Fk7hYUWVdK+xLuUp71FN6drr4UzAVoUBVxkpZ9F37WnBzvlgFCM8tUvAfhjoejhyk2+PJUnEzb6ZqbXCR8Qpj0/K7vhWqfhal7RUDQxiX3YS/RaOAH6Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(54906003)(2616005)(956004)(5660300002)(2906002)(26005)(6666004)(8886007)(38350700002)(38100700002)(110136005)(4326008)(8676002)(508600001)(7416002)(44832011)(316002)(8936002)(7696005)(52116002)(1076003)(55016002)(66946007)(36756003)(86362001)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g6TWzDHI6Zjme1uemLT6FW0XsOUGXSmk1uZO5aUyLRFDF+bJPYzUT3UGC6+7?=
 =?us-ascii?Q?Gh5fma1woayCTswtJmf2bVssiwxT3bQf58H6eBRwfjmSmsg78d5FZ4pHUIqh?=
 =?us-ascii?Q?Qf7+ExjShYq9u6O7+lProl7tvwtDq6/rboS47L8OvXa/AvVNHHFnkoNimxmE?=
 =?us-ascii?Q?x24/ozc13suBDW2WDTmcbCD20mZTG6f2QuudGKbXpYI6+ozXgYOlAO+Ykpoa?=
 =?us-ascii?Q?CWHPdeqUQL6cwRsxJXDRpJNiNUw1p7vBuAL+6WtUwjp0T96BMiDkdVLKrQM6?=
 =?us-ascii?Q?BuHKMP5kyK3pr5oyZu9nenznilJ1lsjhS1DRrhl59ecVlsesZ1FOETg0VAhr?=
 =?us-ascii?Q?m++RYoQSi/TDr+Hu3efh54HwfB6M16UsVkHqZ845e7v3QEFlmdHGKObIGXq1?=
 =?us-ascii?Q?XaXsL3r5MRlTPNr7ywgsr5GOGO6SbxH+TaBTId8L/jUKxwtMK5qXvX7rJvXr?=
 =?us-ascii?Q?OgC9t6NEEHlEM7l9JxwVWTYpXNAFgDCU5EBdJvPZDc950Sb8+ASn4p8zfuFq?=
 =?us-ascii?Q?sjXz+oh9KUyxWNEtGUi+Cq0W3/mhGpRtzQmEd67amShqeZdMjsi2LzzCYQld?=
 =?us-ascii?Q?BWsmXd1oZ4a8sFe0tuLak3termWrQYOW+t3t1reykavuXjk64nPqNegzMD1X?=
 =?us-ascii?Q?esSknTRweaZSSrErlNuzRUy50A/hyMOYJuLvuPB+VryoPUz0WGrK85Aeb0Df?=
 =?us-ascii?Q?LeOwxZctbpU7+TB7azHcb3svyEfNYIJ6Dcvye7mPRh7a2nPcoaRPLFyizCFQ?=
 =?us-ascii?Q?q5g1waKEy6kd/oJy7l5RoMY7Z0pELlmeafR99uB+1hvZguuxfjGDxSPGUZQJ?=
 =?us-ascii?Q?NB9rJSlwUKyBc/VLkKVSPcdEV9e2SRbPys8cfXpL0KxKVDuTf8/MHbbAu1HM?=
 =?us-ascii?Q?tNWC8hI/5Tg2xGQgr8fIPvTWy6v6NE2obDVPc7MBm1ywOU2bMaFPKN1UdFFq?=
 =?us-ascii?Q?HkLhYijC3akQ7F9qwAR6uVhb/fcfOMRIKOlx3sCqeSLijHGsuMZZglKBYlR8?=
 =?us-ascii?Q?9OEzreXKalqgCgdf1JGW11dyD+23E1SmS7XgiaKrelJdh7cOP3JQo+whwdLE?=
 =?us-ascii?Q?adiVIa4T7Qnnnt/jsQpI0dThSp/pzRIdm2YW/sj409Rx8dDaZXk1/pIutJBQ?=
 =?us-ascii?Q?Qx9ijpApyRSotx04vykacvHOS0rcIMop5Asua48kAe3cOqwuQSAUV7ASRuDj?=
 =?us-ascii?Q?3rMJMXXpDXm1BbyenvSy54dtPFhPIFjq1s+STP++Ahz/2dI28++mF8i/gHn3?=
 =?us-ascii?Q?HNuQgvPgdnCBhrWiGn3qqe5nXC9Lg6S4YOOFQ8Z68x9J5RYSGn/TT5fLzalh?=
 =?us-ascii?Q?a50pD6RnUhsj4nfLRgsYz0lm?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a50a941-8b21-4f09-fb76-08d98c8fc644
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:18:58.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyINJ2BRgajV59UeAhmdjbnBRSeGeH4BQMovSvqKEUKCWFj0foirnZ5nyayBETceJrCz7+Uy6sltYIy8fG6bvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8345
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
index fce5184b22c3..8ff8412db99f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -79,7 +79,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_map
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

