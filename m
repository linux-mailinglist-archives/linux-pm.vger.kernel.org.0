Return-Path: <linux-pm+bounces-33005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2287B33A6F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C690B3AF1B8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CE2D12EE;
	Mon, 25 Aug 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H20DXT6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AA2C08D1;
	Mon, 25 Aug 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113253; cv=fail; b=JyOjP6v9EtsUT6v4+27cnUzME7pCnR0d8elDL3Hk6axUrEK4HjODSyZwVVQVoTf8tmgJFjkZZpo0Lw+i/oE1t7iHMuT/xscPmjc1XlGwrY40fjux/xPDLaroXUobzB7C1jRDmW47JJuvi5+fduw/EchGMhy6y5vDOgCS+BlZasc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113253; c=relaxed/simple;
	bh=/Fahbyja02rrK7//bPUeGt5VV2VCr3lqFxMo7kKm7cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qoadi5eB6IA8MDnLBgbrmn4EbjS0cQTxM+2d4bb4dcPczLajuEQM3bD73ClZe5Kp7AKRv6Iz3Ig25Xu2DRjuOkBQ3HmH3RtUrOZK/M0lZtxUmD7NLcoravKg0bMnK5Vxb8fltEJ2+ESOzyOXkZDoNC/eA3sfM2m2wnmuR8zUxJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H20DXT6L; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTWrOA84gfKS6tT0AZqSnSEa/0vwJ0Lyfcz8fokZ6E/L3zvGiguy83slCPXEQckNmNiQY/FAotrpQXGYxR+S3OO6qVEN8QsnaSGsQdWUkSL3YB43TlCtW70RyOjM5k2Q9V5BFUKq1a5IEHi4TVh2K40jKrnTRkluNQzCLqZ0p92IJgRRxdZRQq/e9pD6xbBTq5NEEm7uz8Ns3AFCkcCgogyWUdjgRWrZze0Uk+cyvPHpH5h8IprUxdf07CBBeuOfHnSNpo6gsrAJmdFmQCoM27q/1Z/dFcd7tVVuBgZk2OVXZtBX6kHsTJMf83QK+SsnOF931uNayzC0S7Luz778Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPV8PRxqsCNfyBeBipR1fJu8YIdtT+rZtobyVL42r4E=;
 b=pBLQeU/diwD9nZfwrKzY/1yrDHN8x9Jw44jkCJOtVY92RVAb3uR+kYr76HrVeLazofNYf9tllT96EkfHkC8N6LJpN8sBYjBKMQdM3QYUezDweylmh5z1sOWZufGs+y44mob0jHIQFfXgt8kh5aY3osKZ9c1ZvZasj8gglIx6zkfzx4zXGYuUDhZvZIWr0MLIn8/QMz/ETGpauyBbIOPn9CZLPzg2XfwK74l38x84/b5UEfRWRcYk28Kd3AnLYBkuxlXYeQ4elVaTO17Z99O5A/7XoHLCgk50VYC2pEc1eJXbhKrLpAPaECnTAQ+S8DRR0Q65HNrn4XR8QA364zm3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPV8PRxqsCNfyBeBipR1fJu8YIdtT+rZtobyVL42r4E=;
 b=H20DXT6LkQVaT+huxejpIJRduOhaszOwmDwBAHHHJTgHTWnCua2a9yAovd1XTZyWGeGwDIAV+lC/yw5khStOALvN18tnpHbFy+dNcm7GsMZft9Nqb5dB6MjPm82M0J3FluYBDeoUm/De3pJHFgfkqcu5PxM27jw6s/7ZjvY7vdpDeAHshZ+SqBXCvQzrdcTvxeqd1QHlaw5Keb4G+p1eUKaZkGhX9v8Kuf4M95sHvtQm5O3edYA3poTbh0nDB9NhJo6TCtwSQ0XS7RqZrUzI8veCIedyBdzsMrL1oNG9OdWswuEx+X+p46QqtD3sdkJCuvSNzp6U2s+gwrFiDQH2Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB11264.eurprd04.prod.outlook.com (2603:10a6:102:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:14:08 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:14:08 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de,
	primoz.fiser@norik.com,
	othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: [PATCH v9 6/6] net: stmmac: imx: add i.MX91 support
Date: Mon, 25 Aug 2025 17:12:23 +0800
Message-Id: <20250825091223.1378137-7-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250825091223.1378137-1-joy.zou@nxp.com>
References: <20250825091223.1378137-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB11264:EE_
X-MS-Office365-Filtering-Correlation-Id: 053aca53-8261-480d-4392-08dde3b7bef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUdi9s/xcQCLWKahUOxHaSfmAp8kyjGPkqXIXCEzxbLoYNXWUsniMl/RLMlW?=
 =?us-ascii?Q?UnwkwI3y6Ydxe95ZuoXc3cecifWrxjzOxROe2id66lIAcIaW1EFVg8/ts7RQ?=
 =?us-ascii?Q?ADUy2qb2ifER3rCEsHHFBkFL8IcqkwrKWXO/uAxD1reRnHyULg3eLKD9B1uA?=
 =?us-ascii?Q?P28rHIeDkfZJwNNIAgOQqiUiYItTOYRZ1VV5BYoCi/drzJzrS/9ZPWaZ8SN2?=
 =?us-ascii?Q?Bp1X5WBlDYmXYs/Q5Pu7pbnsLP2BKL8nfv37BcFscR+flViE0tHWwNIRqs5N?=
 =?us-ascii?Q?7BiZHSJOC5K1fVz59H5qHX9ZX89gjz+EukVjBwuHJMxu81IIojMo4EE2trQB?=
 =?us-ascii?Q?zQMPqPMi4jWhY+kQSL16vXJQg9vUSt51/br+tcj+9z8iWD9Jt7UoQd8SZjxs?=
 =?us-ascii?Q?R6SRdLKSJloJpas+D/T0deUPki85xbSDxC1NXT5eSJTGxT/KbThmFFMfFaTY?=
 =?us-ascii?Q?Bx54ai5AtGNUMo+I/bv5410Ur1TdNishhdDXkZn8d5cSK1UNBMzR4Ljn5Kec?=
 =?us-ascii?Q?f5tkvVLV7BPO5rbBcBb/r7oGsAjsi/7ivnSYg55IvRt2XkF3jONW3vV3X486?=
 =?us-ascii?Q?zFSOt88tnWJNxMf+U7yvHIf5q8OjfuDXyzjqYwIm3LSRzmiW5CMwADFgdd69?=
 =?us-ascii?Q?mashRJkr1Typeb1H0Pdk+vzMQyPG4wdtf3q85jiylPIdpGxYuHNQ0GUDiot2?=
 =?us-ascii?Q?p9apkMsM4P9sPf9EuMCr8zlWD35KAccvJEq1YPJ7/JtG4DAbEXjrOC3s2euU?=
 =?us-ascii?Q?PZ1CSp7Yuqvi90yFHQguQX7F6/cV1YyvCS2BM6Yl2niXzc+wIiWRcfBPfvRV?=
 =?us-ascii?Q?txga+2GNdDlyChs/GQSnDgF5pjYrZb4d5tzuZEZPIdntwM0vETsvHHS/hJ2n?=
 =?us-ascii?Q?QZYModgAFk01a6GPZ3vKbDez4R8grAL90TYCayw+06kQ1hH0mZI3AoAXgieW?=
 =?us-ascii?Q?ssboeO+euyCDMpPuOE9cdxhJGsbGx/o6MQGKEkyA2wNbHSodS6PVKc7qWzD4?=
 =?us-ascii?Q?GF0fVa+v46dzLWM3E2GZizIZ2iqUGZYivberDUMsGh1hyCj8lQLSBpq3oJXo?=
 =?us-ascii?Q?BwLICMnWHPfKsu56lW/v+FjHTQofJaUuDnzHgD/drBo4bjxYb14ggl1yQPE0?=
 =?us-ascii?Q?O8slru+qd2UeqlypUCVdxNb34xVm1UA6cuZKdvzOCCl8tvveHh5Bkq03S1nR?=
 =?us-ascii?Q?kBtGkuQdHhfgcs8o3c3ArvyEWUDuaY9Z/jtDOgwNa92avW+7nSgbH3JTg7aE?=
 =?us-ascii?Q?Q0oxV29LFuwb4Hh+0vjAXUPmuCw5DtC3nfcnZmFOt2hNqu2xQ/6YSJmZB18l?=
 =?us-ascii?Q?5HKkRDUvm72Uha5kTfi8/ZeEE52JtPU2d4AK3/qA22/PiCY4FN+zwiExFYNW?=
 =?us-ascii?Q?6FWYFWtQ+iMYcajccgj7I7WvV3A9mvrUKrQKGlLJYDVzfq2Gpra2Q66qiUmr?=
 =?us-ascii?Q?4nYe3E4g1MBAdYcu197bC42tFygcYavXYZ8HfMx8GgPexwxcDhXIdkI4IXzb?=
 =?us-ascii?Q?p1TVYO0c0ea1BIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9wcTtPfHw4taS4FsBOr/2g3AA3uaBw3M+LaWNyGWd5RXm+ngE3KCeYjabHsb?=
 =?us-ascii?Q?UTIc7mJfg5iJ2INuDWli0gRVTTKAxbYumD4WWSWaKZsx2YvmRG4eS7iQSozB?=
 =?us-ascii?Q?6oVvuGAihxcDEvp+x3ruGy6lm8hsLwrZCZHb6I6DBu61Nx7FE7j1TXZ6UkO8?=
 =?us-ascii?Q?0RlJWZyYYSVcU3gVbn8Dg2FNXbGD1GKugQJ9S3wwT0t1wTnN/nqWw6Rz7AZe?=
 =?us-ascii?Q?6JrVo1W7qjM4kF2FP85sRliXtUEe+CVUbAmvxDMieVCavysoL7vaxKdhnfxP?=
 =?us-ascii?Q?0L+UK4tfev/VS2h8Q2D1CUluiNWcHn5YWTEGFqPfSXrBHEfdxJ5dyAa1HDVy?=
 =?us-ascii?Q?Zj32kf8vLU8ekZn3W45xdwnidW9AW7ZfeyD2SD9E2yGIr9roAu8tXptLW9/a?=
 =?us-ascii?Q?+Ldqt/ymMkp4ivyC9HEOcdxoN7KcIVqSV/CQphvEN//jaZEfyDG7ftz0Jm4q?=
 =?us-ascii?Q?xVybKrGeZG5WthwZVnfyBDNSv8LbiRML28S3P4kDBwbDA3+4aqTUUEF+idyT?=
 =?us-ascii?Q?ao/42zGOOdl+0cac5J5dEVXcbFoZjKuHT2isQzET7C+8zpKM6J0bpx/EWP/H?=
 =?us-ascii?Q?lS2PRJu+G/0tEaf05iCJwgNMy055gKumVtYpnRfN3beqf7zXtOsuYI7wvL+f?=
 =?us-ascii?Q?cH9n0hCPPly56WavyzB+6PmW4/F45ujFtmzhWZ4ryTkaKev2acXf+uDtMY+T?=
 =?us-ascii?Q?/O5oDhkd/r1bsYD8OU7qGOSMaIeJVQAQBFKq63wCUhyh47sIYELDdbmmc36k?=
 =?us-ascii?Q?cBy4iTnuWkvtlNURwJ/2GN21KYxNgBRoUcguuNfbFyaMAT+Ja1JomLocu9XC?=
 =?us-ascii?Q?n+yPqpsgqjneC0ggLcthEU8Vy0SkYoMnYSl/ObhjcqtVCIhVDZ92PMeBsDxQ?=
 =?us-ascii?Q?cxJwUkegYjTJ3fL5GNbWDXb5oBlxZjpodPXqc330xjnZmGR7XO8lWNYY36FF?=
 =?us-ascii?Q?hF/WjGBagbTY3tneE9JViQVsUQIIwhsVRWSVTmboeoG5biZVr2Ah/QfdN2/q?=
 =?us-ascii?Q?C1WuY8enOJQtpT4hnxRFZpjq1YzWqCPTXJatIwy+mSw51XShr5xJBZycC5ha?=
 =?us-ascii?Q?l8w344btz3WX+A3n6BtIWlcf6/IgkOnceSGx8oKQgUnbdpThGlsPRAI+3jqA?=
 =?us-ascii?Q?EONPPwdH+5vhZkmJU88HrREJit+GctqIaG4DmYt1fWAYnL3TRy+1ktghHDxD?=
 =?us-ascii?Q?Gubqsjw1X9CYAkhXF+6C9HrDo6wAk0ayCdX8zOa2FO+T2WtLcLQfPeJAe7Fw?=
 =?us-ascii?Q?n5MFl/Bm01XVdm2uQh/+2eOpLmmwRzOhKAlWHtvsUBjUZZBBSpWRt3xipgmi?=
 =?us-ascii?Q?XpHYBA4Up9c/TJSD2/L/etKuFDyxlhgjS+vjGme82ncUeyx6/PZiayttnCg4?=
 =?us-ascii?Q?44tbrNkGPW5zCGJxzEdPA2PycxcwdfsVRD+MaOvdkGtSGAlUPawaf1Vx9xKg?=
 =?us-ascii?Q?V87vSkDoixaBsqSg5n74wByYzNZtnltk4uYA6JUmJaVCqJ8ffW9VbktCQ+p8?=
 =?us-ascii?Q?OQudQuxYdjtp3YH9UdwGmpc6NHSC2JTMfa5Jl8DGMNTkpx1z1UQGrDtg8BaH?=
 =?us-ascii?Q?9VYRxodsJGRPcJUTpTP/5LWrpcSxxh4GfXd+YpHY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053aca53-8261-480d-4392-08dde3b7bef7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:14:08.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVei2+tTISsHQGFTltQBUJodBt8xPl293L9IMga39gChAI9IfbCIIO/qFWDwT1dh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

Add i.MX91 specific settings for EQoS.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. add imx91 support.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index c2d9e89f0063..2c82f7bce32f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	dwmac->clk_mem = NULL;
 
 	if (of_machine_is_compatible("fsl,imx8dxl") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		dwmac->clk_mem = devm_clk_get(dev, "mem");
 		if (IS_ERR(dwmac->clk_mem)) {
@@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		/* Binding doc describes the propety:
 		 * is required by i.MX8MP, i.MX93.
-- 
2.37.1


