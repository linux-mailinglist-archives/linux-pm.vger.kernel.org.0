Return-Path: <linux-pm+bounces-31737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9DB17E07
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3129F188DC2E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CEB204F73;
	Fri,  1 Aug 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZYv91oJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403961F4188
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035740; cv=fail; b=X/4pJdyMN9QRgaAmPIp9rXU/jBONasKy7sORaTK1I2W1rcZY7kMOT3G0TsmhBc4riMFTOdvu351rKeaQIcl7vjQlG6DEQpDnZ98CcSS165Z6VMeKw4xtPIpsayLqXq96+TPa7cSICYCqC/LKZ2KlQytTfkbq8Nwrn1CfeP2euyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035740; c=relaxed/simple;
	bh=c1i1RXXUHqh4F+LzqLhSwX2cYCaVH0Did1X71QGjXv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWSJiA8W/sJx6Q/sW1rdu8558K0a8T/O56U9kJqoCPvGNVJ0uxRRMs5GxoXKRrNkXQS2kmanVdxqrIEgZmtLtoy2tG/cus/kEY2xBOH/ONxMpp9WcUJXFPdMkGPSTUpg2GtAGT7qaPaLusdUskjvhVU582BsUUmpYj6rbBDvpGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fZYv91oJ; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCUu7qjNSHrGFyKsgtDE4rH/sb3rF7g/nzH/9aRO4o78kmpKXhkiLcJttvxhlNr1bradJKZgbkhBF1Fu+HlLQe3VM/JFqfvoNCjTvj/z0FeDajiRqDPZY97SN2nq/uRN2Jx2oRHbekVV+CWQ6QNXlVXKSItFlmrpjk/zD/F0/v2sgwo4yUyH1lIMQ4DddiJ/wUAvfrUC7Hca8ZeuqObiD7ecjfqG2bWOXEvjJfwCjpl8Ugmpc7l2ezZcVUp17ooqakdaa8QFnyONHgPfaz9rxvvtmt8ummS7WkqfUqBcT5bRi1kNiLhRS0YALXcLHjwWsv6SgSj5HCZQsSl35ZYlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hog+ORWE16HvaqAfdUvnaEf6jsNeHkq+qothxyfQVg=;
 b=TGTOoVdRVao+RyOAgqUkzM6zgL4dfA6dp9jtSCpko87jWxBFq2wHBEofBypaRccSsAQyoxyA8VZl2Ws07pwrmNSUXs/8/wyKbcPK5m5ubcFGmTgKR+E0vrsDaYExJqZCZsSe9FkTWVndbFzSfkRG88X2aeCHsVr5BGu53aonwYqBaoKxAKpMiWTa7E09bLxThsOH39Por+YjWMYhBLoZajM/i7pLtpdu1ugBi7SJvN1DgTRnUL/eTcfcV5811YKr/4jHnk47g0yJW3ECq6SYomMXBIIy19YBkzmOXWiNe1/Ctd+XaiFuw6xy71hege2877NGPpJ1USajmE2QSnAVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hog+ORWE16HvaqAfdUvnaEf6jsNeHkq+qothxyfQVg=;
 b=fZYv91oJjY5K2vnDQgUmxhLFNowAjrmpx5M+awidnKKxg4HVcxykYuB7gZOgDEi4EPZVifA/siTtAwvcuCV4mwzBE6WouMCKrCsAtNGevGVFFGvLKBieiB/Ev7bnz/5r6D1Feu81Q3x1E4aeRBeYwCVO57puf8H+GlV5WKCzU905SnUakgQOas/aqyfHIhnjJvQTa5A3559mbfYFvR+EuIoRa9fQfkiONJvSAMs5AchlI0fBSilOPjO0s0F4Cx+9eS54/JvNyxhCJX2WacNIsqCYPWj/Qd4S86ZD58qkdW4KGWc17czSD29NIWk0tKQPt4yE+4VpNFIEr90KFac7LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM8PR04MB7986.eurprd04.prod.outlook.com (2603:10a6:20b:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 08:08:56 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 08:08:55 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: krzk@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH v2 2/4] thermal: qoriq: add i.MX93 TMU support
Date: Fri,  1 Aug 2025 16:11:17 +0800
Message-Id: <20250801081119.1999298-2-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801081119.1999298-1-ping.bai@nxp.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AM8PR04MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1d846f-18ba-4be7-bb97-08ddd0d2a920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5eweEr8Dlbk10p2ZXFMfd+X1U1Od80GvZz8QLHyiGLvFSyXAiixf4S0a8bp?=
 =?us-ascii?Q?+X7LbAYM/FQkx+y9t5G71NJHpjuC6zD1jBMPpufcUKz7ctqaizMTYEN/I+G4?=
 =?us-ascii?Q?rmiWRxCfqPn8rCAt/19tOLur69f/MKBcD8L257xD2GLOvde78GCaVPvvny60?=
 =?us-ascii?Q?X+QFVMKYMVv4RNTYbweuyC72KCenI2lkaNFBNdqjQMmMffc4Qhq5jv8n4IvG?=
 =?us-ascii?Q?FTt22gczLDzmpTJZtedmJqNsF6MOw7vqie/8yqnn6tZnWUWMwx9DkRw4Q8rQ?=
 =?us-ascii?Q?jyIZ1jstm2GrDJUN7vw/u/HJdUmVBfd9ctFUy4/GzUQdAdIk2rZ1fdCxqACj?=
 =?us-ascii?Q?ky0rsda9lrbMWoU/aotO+L2jOkluiGg9KkPnB8DvnYX69XOIDveChGLcZuaY?=
 =?us-ascii?Q?B4HMVBh2k7INv5xeCjXIhRYnjcIve5lR2CYHVMRfS9CTdR+LH3SriX8SePSI?=
 =?us-ascii?Q?7bJA7HaPPaT5/f5067Nz+oqiCGXdrz6gszU8iwBp8aI4MWcuYAiDfA+y8kyk?=
 =?us-ascii?Q?XSMxCoWMPWkm+Q0BvfnvMTel8QiQMNHmsaxkN0Qd+yrbMaFoRMKNYKUlqijL?=
 =?us-ascii?Q?wDrlMr7GrIVqR+fUvbxXE6icFf/LFOmRTISK3z3wcwXUBW/h09soTcKZRch3?=
 =?us-ascii?Q?YkdsSemPFhmlF/1Cqu7MmxCnHKTZoWcjfwl9MJ2Kz8JVd12ZZsptR09He4n7?=
 =?us-ascii?Q?N2xEkU+d2dkVhQJ7sVJyHlsc3w+Fp1MvWNkSsNMrVvEuJp/NJ7QhEJMEYOH3?=
 =?us-ascii?Q?pQn9E7Wp7UKKQUNoizR5z85qrSiclzt5GgpVih9CX28stUfZ1eKjj+2imteA?=
 =?us-ascii?Q?DxtWEB2szXbt/E3dDvbMpBZOFJ8Qi3XUINyYkR63XKV3CnQ2LEIm6MdTR1En?=
 =?us-ascii?Q?vWQhCFDuEm6uR5uj8jGoexpcOyib1Ya8XSj9ke7GvmLLboavcqzlY33/C/z4?=
 =?us-ascii?Q?biVx7bJvqFQNNjvMen0tE6kx7B2nC1XqWLduRnYS+LActVIui+uk6S0cOgpw?=
 =?us-ascii?Q?ncbM1vXNnS/gbaJOTmMNAkpaYG4smAVJCS9nxmXIbnVG9qzLovGTAc18pHQb?=
 =?us-ascii?Q?NCPWdXS4UH/Ob+t4GtZyWLp4RwmAVogx5kcuTAinWyNdyIacpGAqcArS5XK8?=
 =?us-ascii?Q?w5jxDhmy2/VCoXvHA1wEJBD28j+iMA00bqQN6VbMvQuDowBI519IwRb+uWzb?=
 =?us-ascii?Q?U5vEgkpBdX5VmOPmq3K2DxdSC1RcURDihIHFi6IdGRqibSudR55hfljfDxXi?=
 =?us-ascii?Q?PAsZiYQu0ATe0TE/PLrLQsKWdsm+4r3Mzj3etuDnLu1ylBa4M8J4ScEG9cIY?=
 =?us-ascii?Q?buD35M6Ox8fx52vXKD/D4GoCmlc9SO8pd0Jw7qgyaxUOkDmDZSFAdmygy6uU?=
 =?us-ascii?Q?s1QA1KZC6rFrz3dgJP4S/ruq+K5QX5r+jntYziSNXhavgcVczwsT0b5V5lMy?=
 =?us-ascii?Q?ABRUVThG+MVzkAX7SozpclpRbeH4S9O/ngehXBfFLySpx0ANYQ2Uww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ka2W3vhBk7c0NPxZ76JL916zrYnusLUdXS3sCVlrXb19vLDVJuag4cCijDVN?=
 =?us-ascii?Q?u9LD/P7V/IANCYbeuBQZW76e0IMSoft2qBGOIIrUtOw9+uaBYc3GE9f9WJB4?=
 =?us-ascii?Q?O6b8QuJQD6KiMM+/ePirIT1X2ZrjoMoaZNr7TsyFgTil9avPHTAKIY3LhrCD?=
 =?us-ascii?Q?MyGTS5f0+Fqgc8RE0DKmNlS9STCseW4fMAnq6JT4PRv++y5N1BHdRJLHNw2J?=
 =?us-ascii?Q?t4CCJKYUYqjVc8YlYZJWROHRQv++GbW5CXKPPv9DriFXqD7A912Wroaas4fs?=
 =?us-ascii?Q?KKKkT2f0fPq+QZcZZ18Fp3lVilFP3A5IviRCRwTK8BePeKRd9glNEoj8TsDu?=
 =?us-ascii?Q?XQB4llWCv0PkmpgMvQWTWNDgmryM067K+WCmbxask66IuIpXT9REiFMN8q0n?=
 =?us-ascii?Q?1lQJJ8Z3OZgIPt2Yl15gZY/cQ/ELMDHBGz2b+/i75KbfM0aBInIg5BL66GKW?=
 =?us-ascii?Q?k5yyeLtieJ0SMklAFSqzVz4p1ZSLMLM2MA02zgpEjgcvIBe/WrBevq9R7vwz?=
 =?us-ascii?Q?tPxgGZZeWppPFDSYg6F8Y1lyxKNCkzjm/wFbV+DwLobKtcpPjvNHgkDSlN9p?=
 =?us-ascii?Q?2LrV/IiACWpvxor4Xtk/gdD6+b9Cr7NICANLxB0rLqlWa6uJIJnBn0Sr7Ji7?=
 =?us-ascii?Q?pU5kXZ0C2ehS0GXXOJfqhIrFARreIHJSesuT2ifpflLe77XVKdsIuDTwJhFH?=
 =?us-ascii?Q?nk3youQgxJPGzE5WsXJO9D6EGUHBYZ15xrKTnmc65/rRl3mhnk2JBThiGlEx?=
 =?us-ascii?Q?a5JPYkaevdJ4gOiQV8i+PD1iYRJD0ezr6Nt7+3p058IyQEqYe1Go+lebMDuy?=
 =?us-ascii?Q?5r7oCprCkKpvGuIC6iQXguMI6K4x/Q529L73xLtdgrcRxcT/YK4cLaG5OT3g?=
 =?us-ascii?Q?8b0tuy6qJZ6z3UMw2MOomWgQQl7RBLRsoqdBLzHvRZAnr1KNFnxlfHOMJhaJ?=
 =?us-ascii?Q?AVXUvUaL+mRJe/LPhYJgMfjg+81nwF4gBfoq+Q0OV0hUfcNiaFoTWaRV/m4D?=
 =?us-ascii?Q?phsa8Gr05tAMskGxq38EdGuTaMdeBQy5JxtdPWQneiIVC2vcXPqCoB0W1sic?=
 =?us-ascii?Q?9p98ZcM5nBCRq80gyijiVaugLCxkw120CzWKR+N2lMyb4PoPi5r7OP/BlxcS?=
 =?us-ascii?Q?RzCrbMGDvtBOZUWOP/sAfRr4JbGQFPbg+n2X0sYuPNLTGLBTGJ61q1PcUmmw?=
 =?us-ascii?Q?HJQEahGW/cwg+CRnSqmn2KDSyvEW7eBFR+Qea0aG9Ak/9GFb8h2wgGdIKvjE?=
 =?us-ascii?Q?n2XU5qyldzNdSAv3L2Z1cPszejjYI7H5kJExxZO5nmuKKS95l0VQrGRsbqu+?=
 =?us-ascii?Q?GkIhscjrMIcGpxS/e6se21Vi9mHY19gIMzrREfD7o9o3lwPaHnWQEyu2N1hV?=
 =?us-ascii?Q?wDfi9k9okPvHYibVP4tduNTtA3aDw9okxFv7HXPY36jFLgULeqtatuoU6bbk?=
 =?us-ascii?Q?0pPoEvpUDXawzTFCYb6ihb2K5RwR5jv7CRHkfOHI1yMi7npWXl5Dozlh4k0M?=
 =?us-ascii?Q?iOpwEEkUeLAePGXcLFAZ75L9btMm/pLHg2DcHNiRpT17oSO838MFIPPcuzqo?=
 =?us-ascii?Q?8QLYjEjO7QXSFRMtl/li/WR5aoRCrfQGnhQJHLZe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1d846f-18ba-4be7-bb97-08ddd0d2a920
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:08:55.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N970TrbnOFoeoKI9kdj+vr1LVaKwHYImLMAGuzNtiKB1xSt419bgfBRFD2amw1mK8fL1HXrfu76uUdPxCTNCTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986

The TMU used on i.MX93 need some speccial handling and workaround to be
done even the revision info read from the ID register is the same as
Qoriq platform. Add i.MX93 compatible string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v2 changes:
  - use the compatible match data to identify the i.MX93 TMU variant
---
 drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc6..fd4d162fc188 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2022-2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,9 +25,11 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55010c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
+#define TMU_VER93		0x3
 
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
@@ -232,6 +235,9 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 
 	if (data->ver == TMU_VER1) {
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
+	} else if (data->ver == TMU_VER93) {
+		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
@@ -312,12 +318,22 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* version register offset at: 0xbf8 on both v1 and v2 */
-	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
-	if (ret)
-		return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
+	/*
+	 * for i.MX93, the TMU HW version read from the ID register does
+	 * reflect the real HW implementation version, assigned the TMU
+	 * version statically.
+	 */
+	ver = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (ver == TMU_VER93) {
+		data->ver = ver;
+	} else {
+		/* version register offset at: 0xbf8 on both v1 and v2 */
+		ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
+		if (ret)
+			return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
 
-	data->ver = (ver >> 8) & 0xff;
+		data->ver = (ver >> 8) & 0xff;
+	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
@@ -379,6 +395,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
 	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,imx93-tmu", .data = (void *) TMU_VER93 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
-- 
2.34.1


