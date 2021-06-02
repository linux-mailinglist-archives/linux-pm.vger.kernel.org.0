Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFE39880A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhFBLZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 07:25:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11637 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhFBLZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 07:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622633043; x=1654169043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qMoC26aE1t/imsmMoQjUxEhGnzi1b1hiqgTM5NyeOBU=;
  b=cc6EM8mhEetf2kZx0Q5Z5knGyhlEG5mANVyT5nS8ARRPQcbkFp7axQBi
   ScOkUdXHXtj6C4DDVG1WGSbAH3YXkX5N5dbFDmw+1HccxENTI2O8czhrE
   rxjDOdHnCUzc5ij6Y1X8eaqVE2hqXiYGSuoIzJ9smVzDwUfOuIV5DVO8i
   XRdjJsmDcd73IG++6HA5pCx6zjS37v3G5ux2ifW7Jv9SRaGNXeFvjtc3I
   ye9p4cfqLDLd19yxWiCPYtr6LEVYF+SLQEmyqi2aRpYWIfKj3NURCIpqY
   X/o/FZ4qhhXqhOx6foKg8q28597uIFHMaZ7NIdvuAGzJenYFgc1LtvVKe
   Q==;
IronPort-SDR: MDV/m7P8xo/A/1bZWoB/tzyzw0RStxB0OO0HaCygc1UVbyONPF9hOYifz7jsGlD9Gm78RFD3L9
 JAfLP1TMzcTu54eBMHM3lYIyHecD8ZtrSgaz8H6VhqDvMb1FbiQ/tQzRkpeRKT5cwj/0AW2Y76
 GijT6wOprdDyUHGqSU5n7SMavcoeoyiv917zKhCmUC+o4eIptCdfe/MASSoEYhrRgX4Lnrls+m
 g6IZYHD0cjkBxN1q2SoYmoJuDo252jxcUfJNanxtaBKSpIAs1T0LIqfEFOkK1MRXNeLqkpB2tp
 7oY=
X-IronPort-AV: E=Sophos;i="5.83,242,1616428800"; 
   d="scan'208";a="170932564"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 19:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeGpWjkkmstD1LMKv1jh7gp3YHeQlMSyw7wH5tMpVvHj4fDLJF97REs++EI05xN/1a6k7pTDG07bdikun41w28YXjhqI3gbTs0YCsxOaF7Nrz89sJkWo98Q4F+2vpsmYcOscHNIla+LgJ7lzH9inJ0EvrGHSZ7zVcqrK6JX/E8LsbfTFzUPiVxbVZIgFzpEiMkKrlSpDBDnK+B9uqjWIPLbe075yoyIYfMXwKJRL4VkYPwpG/6RSNpD7Wk39q32oWss0wM0pkzYODH/spm7pEQ2OV7UTL562f3ZrAGP66zsc0S9NOghwTDDtHsPPxTxLgbesJFRGXquKo+bs1zt0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=DoFVKPV3D2GYkpX1kMdP/epbifdsw3s70MXga1niS6F6VxyUSwfGkLKNqkt7fvP2oilifWONPCynsRQf3W1Wh1Sk3j/5ZrAHU/xZcE4Q97TnwZLvQBFpfMnNbjMj+3qJqy2Nodpl7iWMsOl0g8iSZQ54EzF891ZGLNoNtDXNrGclZMjfCuKHbRGNrHo/1sF26aOkEo4RsQIeId2BM0yIM7ZI44PRvXicdi5CwkS7jZgvQR1rOO6h6WqUSu0fsjaa1Vrtrybj2MKvv/QMWypV32T0uVATrRILEM7FaYa14GrGBBYtEtoNv4cmtTLpR09mw6EGd+TpkESFiFJSt16DGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdFS0rAEtKE6yd9Zx3nNwSnuIUcrKnIom98JvQmaI1w=;
 b=A3x7MWGgSSCj59XXjhtvsjDXzVWvlJBPiplC97EtReEvLcKwhUFrHkFRAK56Q4C33PUfL2Pewx0/7ifUEETTtadwcKywIpAc6dOtawD5NKCI8FB9gePMi5OtNhURHl4PFmRmYiFukwKRvqUbigi3LmrvyOMl7mWukQpavd+ma2s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7810.namprd04.prod.outlook.com (2603:10b6:5:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 11:23:59 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Wed, 2 Jun 2021
 11:23:59 +0000
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
Subject: [PATCH v5 2/8] RISC-V: Rename relocate() and make it global
Date:   Wed,  2 Jun 2021 16:53:15 +0530
Message-Id: <20210602112321.2241566-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.70.115) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:23:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5115730b-b324-4e0f-1f52-08d925b8eace
X-MS-TrafficTypeDiagnostic: CO6PR04MB7810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB781064AACEF184414F704A638D3D9@CO6PR04MB7810.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nL4dnsIAFhO7XemKy0TEB9O9/mwydpWCdpxamnoS025Jc42U7NZ2/ol2vp+sa+7a02nDuZ0wnGq9slwRi4RmiY9mRZSR44AkHY9LRk+HqP8Z5K5cLaWP5AkebwNrXJrJay4+shEmrY0+PtpNov0mX0n+qsSQ8Abfb8PKFEIOQq9TlmkDX+VJxePYVuxWjmxpFltT7NyTNqDc3UVJ9+OPRt6/sF/G/bKfF+IiVSye7XQAcVDiQVlzz047vlFGsHeprlY5yzUjSkgR5XuJmzE0EBu3JocNoZaf8y8YED+ZSY/WvEcLcsRqB0yvwveBQOl6eTW7FEA9Rw+iH7YdrWr7I9h0FreJADu5xd3Yu8BVBmqJishtaaMRtaAV00EFtZxJ/25Rj3dfG2IdhwWBO4d0CmPxkDwBGP1Bk0P1lMCER4ahvMGBJtFhV9Wcz0ZGeIdgTzVgtiInTsH73pnU2wMIgyWg1J9Ql3Wejj4uPy4cjA5CeHfoxxX0b/DpXBWmxUlf2gCXL+U+C0sOIXXpPeYWKIPY/RJMZ9Kp75pZqKU/GZS4/1BsT2wF1eQRi6IQbaiLfIdlnnJgY0uZMC2gYc+TPZIwMcm9RLghrvQ1D2XBeEG5XCrImMDm5fU8NBxL/EuquOL6PuEkCJifzNLhWa64g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(186003)(16526019)(7416002)(8676002)(6666004)(86362001)(44832011)(4326008)(8886007)(2616005)(478600001)(956004)(38350700002)(38100700002)(8936002)(26005)(110136005)(316002)(1076003)(5660300002)(36756003)(2906002)(54906003)(83380400001)(7696005)(52116002)(66946007)(55016002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pF+HheLrh7kNnBYEsWJE3tnyVte5Yzsi2G3pa23s0TQfvXFdPZ1LzzkVzHp/?=
 =?us-ascii?Q?vBEWkNYHFSMYD/oGZu+azEA+f/kuBASdH4WJty3//LRz1YmGhIwTY8vDE4i3?=
 =?us-ascii?Q?URq3ngPcfS7bxAOmfdViUT+goGgWwpRnaroB7galntkeXFdI+hJuwnRE13LY?=
 =?us-ascii?Q?bSDGMaQWEWyL/GLiLSsjxmUo0pJ38GwHrNmar+7XoaUHd45GZZ/ag7DysV0y?=
 =?us-ascii?Q?hOPMTxd+M5tsQMM2cGmGZm2OeNYYd+FPC1/9zuS6uid3XyP1x+0Ra+hV/wQq?=
 =?us-ascii?Q?IATFh59mb47+rX3CUIo2KL08iOm0j6FdoAR8DcfsnnLUIgzl/k8QAzKxET9K?=
 =?us-ascii?Q?Dlv/IiQ0TIgoWqnccOVDD+aNFdp03+iyX7JoHwoy6EgHE76ZGZg3/Amivf7M?=
 =?us-ascii?Q?TnsxhIVa5X8LckFp1gCnPMRJP09ivPRaZhoatp2Ys88ikrM8RE6rzKUX/aol?=
 =?us-ascii?Q?DE4drZ3COIfodrMWGCoZyKg/tZJQLhUob5US0FtU1rf3yal+OGRa9e1Rxa8I?=
 =?us-ascii?Q?Bm5OPPcgUJpduWuL1hE+Zd+ispLrOtAvf4BOjlDMPDeiOb8g2cBoNFnPNOcg?=
 =?us-ascii?Q?H1VDFvCE7OIPu0IPq6ZwJ4E5bhANdv2mPnTgtI1xO8OtU9rFitbqCAvQRQOc?=
 =?us-ascii?Q?CMygcG6dvq7PhNrnN6nUe0Ohq8P9+M5/cyOjohncvqUKe+ZL9LcVn2J7QJbt?=
 =?us-ascii?Q?JWF0AfsAcsjk/DgqTLKCxFfXBSmgarkhDm+djAgisoO3BYTLtM9mAPLEwbJk?=
 =?us-ascii?Q?sz43J1HqUP85cHo/POALxPdY86U2HT1w6vE9svgU39Zdvr8qGfW5KPRbA4R+?=
 =?us-ascii?Q?G9oH8WBYNuVwcL0yq29r1bip8ATDAruOWYIrECzMqy+Cc2GQcI1Rz7TWtWcR?=
 =?us-ascii?Q?W6nskPsSCuOJRoyUExd0zHsL/LuO0uM4W9ijE8Gxfq7/IWb2KdKHO3oRvAzs?=
 =?us-ascii?Q?F3E2sGdlUsvwiBfiHFTslR00hyA/7vxMrIhJHxiW+3xMk1j90FRJp+JaA37U?=
 =?us-ascii?Q?1E3NgBRFiV7vJvbRV3RtiAsAkjGg8Cfb+Ty5u6wXbThoDfxzWIXVud4hxFww?=
 =?us-ascii?Q?O9OftdOVnWh4UFj10Er8+6gg5YnjcQbIEamg30ZuL6SljO5ngCGfjBK3gDt8?=
 =?us-ascii?Q?a1mtWlZkRNjWN6AT1UWuQwoTfTmdNhRv9/PcsYxtZlw75UZY5snqjnKUd6XK?=
 =?us-ascii?Q?1Xx0CLZK0/T+NqzNgnD5pmg1a9mLq7fybK7CYTGRiUi0rtiWaVMFxvAg+d+W?=
 =?us-ascii?Q?nJL+T4p5BzXSNfTWmMtl7uZFh/jGSQMKYnELTXblV162VMyS2oJLDe1ouy8n?=
 =?us-ascii?Q?2XTvnOMj5q5GBQhCsY+P+IsI?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5115730b-b324-4e0f-1f52-08d925b8eace
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:23:59.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59Qn+IebNwNLMH3NxHU76u+eFx3s52SQr6j1SGxe2/0Sv5mLB5Ezx4PnrX7GmbGqhrkfR5YlNB4RqV19zq/KjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7810
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

