Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139DD42A17E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhJLKBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 06:01:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54734 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhJLKBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 06:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634032779; x=1665568779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xfiKKU2D92LxFD91PWDY3j4rlGe5f1xCNcR6FeJ7upY=;
  b=W3XMtLak3fmEWSr+if4hAzK7gZ7zcXJa9DJ0g6eOcggo1vZ8j2tZIQ5j
   R9bee3HKGoF3SnaDLynzpIROlCvxZiYMLPH+JC8riQZXJlmA83cUq2UGw
   kmJi6RkS7+aCzMzxjbn70C9Sb6bAeRYrzmw2y2/dLRSEIt7Wby6NWcRSF
   5INsyBYpyNddWr897QV/7ZP7PEkdqnuQpC+736tZxFUzyI65ROs8/GE6Q
   SaCXODF7sp210JQ3Cca9JBumDPkLc8ad1fhIA0pNRDbQkZG//8EcpU4iq
   z+RDS/s6RSO8Dyol8I7ppLTlhMPvO72XAd/O/x0FjMVgxIIZVy+JavCL/
   g==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="182592142"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 17:59:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7SeTaJNkEV0BfD6rK9JENI3Rnd41eK2TbY/Co20axnRUaQc5gWL1j2CVHEhKFTcdl72xgWSBw3W3D1R2weOg3dgWy97qFPBSPUiatrHseyf+8qaSOKjwNa9NbCyFsFOUJFa34bIDH4RS+5aCg3BilhVXvM7hC5fiepTZl8Gzy48TyHPEQCyHkIsRPiEzldwhF/URu3pVp7fZlChL9THQDL2lXLlCVJxKycYSRJJQWARZ9A2f/tGJ4ZsGZu1eClS+jVSLS0+EO1zYpZrGyAYX1XCQ54JbznWJn/vIXm3mva/GxH6tq7boYlNF7B5xtcfnKoRXuiGIZr6fbGPGShdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB0r+rzkrWS+zQQTlAjsnrMWWHVWEZr99UXf0qaQoKI=;
 b=e0wB2v7yZ7kSNDRzpQDa87JGO4sUZTAmfdVXwQmjL4AlCJ+ss+KyADaz37cQ5W7TV6uUNMwafKj9XNwWTek73vk+XL/O9xHLXC3VI+k4kZaCHEbrVp5i7Xxabmzdn0Ra/IxrIcnb09c1UpSlRBp3klnhcVZ9A7gEHQEg2/2yLAAAtysD5ai2/rIypxn4M+xrZvRBFU1ZJKrO24GxzdxsNjQux5UpPGNv6OPpkrRLs5F02n8/jaZ9Dyyep7xJw1O2N05YtlCZo672gWP2dItm4kgJmiSXdzMyq1nRy1DuuFuc2ULafmfKhHiZcV+3OWKa6gXH5ZHPgB8iQnTJTC5xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB0r+rzkrWS+zQQTlAjsnrMWWHVWEZr99UXf0qaQoKI=;
 b=hxcvIFhyO6oScD3NQwh5+f6RiqPdJdaL4GOdcjsOIjIGYpIt0Z5TEY+hHj70ZWYfogRZWBkFXn6iPbhf06xssm4d7JyW6VSqWYQ/DB0VNUOyet9JCWGcPsr8KffdrLQS/9KaA/m8oJiTRzzpNH7VCiexpZ58lBTyRmMGpMsYuN4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8348.namprd04.prod.outlook.com (2603:10b6:303:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 09:59:36 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:59:36 +0000
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
Subject: [PATCH v9 2/8] RISC-V: Rename relocate() and make it global
Date:   Tue, 12 Oct 2021 15:28:51 +0530
Message-Id: <20211012095857.1314214-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012095857.1314214-1-anup.patel@wdc.com>
References: <20211012095857.1314214-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::24) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.114.63) by MAXPR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 09:59:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace50fac-07c1-4c88-d7df-08d98d66ff78
X-MS-TrafficTypeDiagnostic: CO6PR04MB8348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB8348D18827B6FFB3EBD8150A8DB69@CO6PR04MB8348.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdGxC/yWIMa6lFUAqhXIdjkCfApgmyG/P2pKb/7Tx2hppSQQ+d50olqUOYkdK03Vc5RChIciQ8uFtxvKwY4R4B73dqDBGdo1E+OxEYJ1lWN5LWBRAHGzdrdn+P1llyoHfyd9tOjAkqENDHQwWpcDTFrmFQK9HqMXXFH8pTYROYA066o3YezYuKdEKmO4/MxdhDPMjHeRryCO3o21nPDXvnakdzLNYN1w6rAmKCMNEcULb2MxhggZLGpY09e6/EWfR9XnwEthHowFBMGdzgM0RFmvP6eHJwwPMJsJw10/hBcwaJHvMvXVcmXdQD73eZV4SAHIzjYtoVP6L5RdaguaIY/N3Y6J0TpUw+A+gllIhb60X9VVcNg4oARAsN7c4tvLynh9iZ1K9DKC7FkYVLZjWM9RXEdCoVNToolHGc8QB6h+6ImiUJbCxT1G50YnOA7B987pBOvkijzYo5rzjcbOudhW8HJRg+rVnzEi0XDazCGo0tdfvvEsVqHCiYTqKqiHRLeZJW+wQeyNU7R2s8axc/oodWhKml4QHSXd1N73yXrX6VtVm7gIws5tjoWEKGThYJege0ACAScdKbNaxIL749wsd//wu2sHL2QRLB80xs96if16iwIrk2hiYWnlpQzVxWnLnbjrJ7zCSRo3hBIH27pIznaVzfpJsg6zK79JkkRDLwUVzAAIsisC4/ig92FEyMmQrQStmlhiAgRRTZYhKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(1076003)(8676002)(316002)(110136005)(44832011)(7416002)(508600001)(8886007)(54906003)(4326008)(2906002)(956004)(2616005)(38100700002)(55016002)(26005)(7696005)(83380400001)(36756003)(52116002)(186003)(38350700002)(66946007)(86362001)(66556008)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p2Ov4Pzly2CF5b0xytsWWl2G06zmAxd3TnnxTuyHjt2Fzfx15FwMgOykGIY1?=
 =?us-ascii?Q?rcpt6hstdg5ivVvxek5x8P1WLycpc3maLhYhqNyJp1eo3wnWdHMIC60Gehh5?=
 =?us-ascii?Q?8DaiT/on6EOpqV36Ip8qJtq33Wc5ykkFSfC1MQ0YN3NhSpFjX6Wu30zybrca?=
 =?us-ascii?Q?+G9MDIiy39xsdtIrvYfUh1p8efwBo3Z4owScOhP9WtONI0fE6gVNo04zsBhc?=
 =?us-ascii?Q?lMnXSfhdLrA5iOm4mH3H5bPDWntHqKJNSnqBmBJpFJM9xf279lIPTiK9SK2f?=
 =?us-ascii?Q?Quj39Xuu8y8I/tZ6rxPK4vNd2DcO4eKMSbLIZufMBXdTorMR77RL+gzNLUlr?=
 =?us-ascii?Q?zx5dlDDjZs9g/0feiZlYW3oKc7lbGmOqNcaTKbqbLGJYml6Hed/e9BUkl1HS?=
 =?us-ascii?Q?tS9uhQh3Ss6kTZtHZUeCxew9EhWACboQMwAujk4eNGeKTTKic7zaHZ6swoTm?=
 =?us-ascii?Q?eqzpQsqlDocDkYwl8izUofoC6hbLINEQHl7Qy5ZLRe0LPMoP7TTbBoN3kjyv?=
 =?us-ascii?Q?bpf5EjniYVEnx5o0MCch3+LHGE3Ssd47AgnCfn1nzeGPOqJWNUhki60yFB5u?=
 =?us-ascii?Q?5FvkOkyY1x1EcBOv/5jrlUndZWaSWobyNxgSJZNgdTK2z4wa15JWYxy0Uz4W?=
 =?us-ascii?Q?NYMceQ1V7/qax7pDuHQJblXFme4asSMGlvw258/HDCC4FgbLbibE6ebqV0T5?=
 =?us-ascii?Q?HXDRUnbIhWR9N7Cn2jpLG6jRLXKC5orgXo6/+OPQ6A08zGrEhQVxcooxAhkU?=
 =?us-ascii?Q?duCzSQb4BiZWmMWl6R0acBbu/Cj21TKAMAshLrUbIWC5Gpo0a7g5h1SZ+B8d?=
 =?us-ascii?Q?kC6Cvwnu9/KpysGaOxQSG2RdzPqq0GLd/S9jxsfFOyYhJjsOyR+KjvGZ3isQ?=
 =?us-ascii?Q?U2plaHGzqddmhCBr0WKKuFRfqd2A0rSNjlPKe8A9nPQXn9tPmCjY6tNqBGlz?=
 =?us-ascii?Q?seBcMkMFPYLe5IzR6hQy3H6x34R+keE0/Ko1l7Gg9T907SSUvLSlLq6Ssd7Y?=
 =?us-ascii?Q?TmI0g3CH1WxfKlpz0t4p55lXLmG7kq000bXwvAt3TMre3uCWL51Od4vc3WFY?=
 =?us-ascii?Q?71aKjANFCSCpU/9r/gHcmYAwyerGoMLH+E+BXm7wAtgvu4qkRYB10tpA5jOR?=
 =?us-ascii?Q?3h1GArspkcIqAkv0xW211CeGxjMfyJAjiO+JTY0FMktI2hIO4m8Hn8pmcR4c?=
 =?us-ascii?Q?kHuTekF2fuQfQChZ88dvpZYeQKgQZYnspY2LLEiHNcfOcK/WHXHStbg523gO?=
 =?us-ascii?Q?15MOj74uMyUQ8OfBbV8fUo9NTMJFFMqhemH5/e2cWrMtV9a/Jc6oBo2ORbqp?=
 =?us-ascii?Q?YF9KWKTtYNjnBw+19x8xQ5Jx?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace50fac-07c1-4c88-d7df-08d98d66ff78
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:59:36.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSeyfNKPXYVZf2Q+IKPaFDDRuyDk5vE7UVm2nW9pUNE0mkWNDQ4e0DKOmMC5e0NGc71kNFu9CzpuqW82riIlUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8348
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

