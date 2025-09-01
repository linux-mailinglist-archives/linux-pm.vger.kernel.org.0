Return-Path: <linux-pm+bounces-33552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B4B3E066
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95411A80546
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85393128A8;
	Mon,  1 Sep 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8Ia0Wni"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E543115AF;
	Mon,  1 Sep 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723098; cv=fail; b=Jz932YkkVnTdeLYNWKaQOXrjBpG0x/0iEuakuqlxzh52syVbjj4t1uWIWTtQEB3QEjuSkzWCGcqrqpJuUeNSym/zWF1FZRNxyhmnQEPORXYsp2FA9Gw92Zr+13p7vnA1PwD4ZeearRKhkxK1CW2zvpMsn8sdGvLL5U7nDp6FjNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723098; c=relaxed/simple;
	bh=hRyxQPm/Z6PmmvYi91ovQt2xSJaLnAQXQVMDgo9N35k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2/7SrkFOD9AyisY1Q+mAMM7KaQ5viCObxRK+3unWrmToY3eDQgs2lc2zGwnAv9PDZmheXF42v1bm7yxAPHYKoZFXtIaSaBHKZO1UEhPmAVXx3QI4UpxH+gPsr4wVAGUMyOiahnybOsMC+R9pwWbECdDDTVMs9YejIw+ewysNuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8Ia0Wni; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8pjhdVi1jDd7Z+0f/3XZpdr2cLRqsvr/8lTczN40I1xtonTDcjpL5S5Ox+2Gko+rQL9NxW2h9/Dl42TAwcKYk8AmNy76sGp0yMS4EBfIXLf0Yrhdn2g7C3A3L9HbI4jHxN8q9mDoag/sMwUbmVF6F+dVbah7ZBWaKtca6XXG/eISFZoxesn7HeUFMex9Ux8TWkP9dmXCB4MGUHdp9C2WfIw+rZISwuWPUNmnDsaDr+LB94T9Bc+LLMmrMXUipd5VHFOUpfGZmTWn3rhEQJpIfgziL8kJP1cK8f2jt9SBjobRB2mZLtsZi16CmWZ138SDNoxBfBpPLsL+rq6fFEgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaeZa1MzZ/XyUUwLRkPMVawdkNnH7iuYHQmvx7uuGdM=;
 b=ZbWzqyEjPvNEqfn+0pBO+evSuV4xZLYzeVjOyHYA8qjKih3yeUiknbLt5P1njiH6vXVTwLJA+cU+xVluQ6ubiPqZ22Q6pXMddI9LT4C6nKuHjLcLxXMCnTiCdP8DdlLnJmgEbme/ulbVu/0kOq4WG/MeQ1h27+RUXAJFqoAVe32slWffgrV63lS0rlayNxFqsk40PYtkUzeETkCRsOpwV+feYONxHd3Sh9DlQeWuienDbuLpFxB8mJD9Z43pC34tdGThHKWaBdFnyl7qQdEvvw0YwgcZj1+ah33PS3jRh8qoWUwG6aJLoHbR6Em/Onqpt/OpIcSfvV2yQ3V5mne+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaeZa1MzZ/XyUUwLRkPMVawdkNnH7iuYHQmvx7uuGdM=;
 b=M8Ia0Wni+OPCZKc7l0bsgmwFUPOg/M+ypMxDlGkHkAsGg3YifM8v/v2hCMWfi01YoW2SZZtc/DmzFdU6bN/yA7mcMHEYRZwgZFcwsW18U+ICJmNlfLL5yAkbunfBBpJAmXo799uvGhacVU/PU20ApKZbDvE53Bg6xI6MOn2YdQhf/8mnm8K5OiS8HFRG4lOfRSJuVqhmyyODFm03/0jkuWmWYQ9N636yLBYkTtW7keJxWV1Rfyrs+tP95UjxaGIQntIxepIo4vOryihjKkhU8SZjGCg8we2fo/HF055oQALGd0b0yoCK8n2PUp0g79NHc5jcW4TVRCDNcxFh0hIs7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 10:38:14 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:38:14 +0000
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
Subject: [PATCH v10 5/6] arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
Date: Mon,  1 Sep 2025 18:36:31 +0800
Message-Id: <20250901103632.3409896-6-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250901103632.3409896-1-joy.zou@nxp.com>
References: <20250901103632.3409896-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d080f7-1928-4db3-ea70-08dde943a757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rWZ85zu/lfw/69Q5VggEoIiAPj7oEy693bsFphcM7RXnPeVC0qnqynXoiLCM?=
 =?us-ascii?Q?F0iIMrNnsgmYIIItXeoGpu0t/xgm6owX4Kf1kkTDAywljwVvNpAN3De2dL6S?=
 =?us-ascii?Q?z+C7XU/ooASxKvLJkq+A7GTapQY4X19MkRps7PSshalsf+Ft2pFKExSQ6rze?=
 =?us-ascii?Q?V2z+CUyJpZ8d4Wv/iCT4DYb+kvB2X0XHN1ZaEs7uUT0kQ2aHbVmGghNbJsRm?=
 =?us-ascii?Q?Dgz6ZViNJYtnBcc1FWViI1jhmP6huZDXK3tUmsNWO9lVjod21HzmXntanc/c?=
 =?us-ascii?Q?rf2EVynenBkKZIF4kSXD90c1h35v8q96VRwClpoWd9kRMrqGou57JKU4ATtd?=
 =?us-ascii?Q?DiBTnS044sFJJAA44Pk2/gKf4BWbQ8Ki2NtP4Jom8/JXfazg2+xOGLsN70/o?=
 =?us-ascii?Q?ZuWZ6gqyLCz2T4Rr0dqzoHMYg0xCTiIA7Nwsag6vT58f1NnERbum05OUqrZk?=
 =?us-ascii?Q?NXgOVckEe3kj/xDSq6sh88qMuSTkuGV+OZeGhhoq9Ia9n3+GKA/3euTMThw/?=
 =?us-ascii?Q?zUJ+V6rIZoqtsOpT4m0wPk9L1xMuQR9H4gA90huvW0d40ZtADZ3WxZ/P2RyQ?=
 =?us-ascii?Q?Y2S02UPZjxQT7HYZMUEN2itPFc6kXXvqPo9Gg4NDHZsPztVvMluoPDHa08tG?=
 =?us-ascii?Q?KG9NSTOom+bjT6CQsh0uOE6s9YV83sv70b0HDOZRm9ai5wUV/ThaMzKW9uso?=
 =?us-ascii?Q?iBQ0CxjxkLQd0a08BM6mrkKLmtCFeOBm76o14pRWYjRfY+P9ebA046FvnDVo?=
 =?us-ascii?Q?Yf2fbkl4geL2Hht/FmSwrQbXYIAWQOTDTq3tw/7dI+kw3w0om7aesOh+rmBy?=
 =?us-ascii?Q?jBKik+9vqY1lWuZZlUpVnUxPNRz3i0qBjMpuiYcjhOR58rY7LOyDdULaahFA?=
 =?us-ascii?Q?iVLTkNhU0rG4/PGhORiNBr8fBgVQRoz2MNDxMFmGbQHclb8qViIq7zV9A87e?=
 =?us-ascii?Q?+9x+mVfXli7i4bN9VR+5DF3iUYgYJGZdo1mN06ED7IvmX8wzKjiqvBRIJg4b?=
 =?us-ascii?Q?Ebc0VHbgApj1YfH1m8Gdy3BnW6c7Gxz08nWDbW2qX6DoZ9ObkoENTCYA+F3q?=
 =?us-ascii?Q?hBQVnwuwaF+hOOvcG7/J35ScQyHWrW80E0HvO7BAjW3/vBx2Jfn56qDiL/Z4?=
 =?us-ascii?Q?KngOElIPoG6PLVHfi7ueuwU7ldll1osOCS7WEQiEpHu5PeOYEZPmEF5JHXb6?=
 =?us-ascii?Q?eEj7LzCeYna8Q68qmN8nHAkg+W+dnXyxqOLQxxHv1dIoC1CvzUvlYYrsUv4f?=
 =?us-ascii?Q?758IRW0NxZKtXJBtN72dpyXS2gzrmVSQ7Rio2HvsAqdonEOp1wCHbPubs056?=
 =?us-ascii?Q?vx5l1MXReADurBCLGDhgEEMBaHjhAbFjReP2buYqTNrwfuUd9peqEobi+kO4?=
 =?us-ascii?Q?OxX8hH7agKj24Xalrw0UouBYiDadanNErHOass6SHvQmnXpf7IXG9N19e5nT?=
 =?us-ascii?Q?ewomudS0N5moBCHB8al4I47WXxldasdBOf71BmEBmiJHlzSHWYoVY6I0i1Ij?=
 =?us-ascii?Q?V3Fvd0IJraCw0eY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1UmC8KPayA60EuRyFe/KVJUqnIU5OMxgfzin8IpkR6OShShrkANtPWGRrs1?=
 =?us-ascii?Q?O6raUNwLByRtBT68aGZKGxjJCYHuzwihwTb6qoh/WeM4ey39n9mS3G+o5/q1?=
 =?us-ascii?Q?FFfkw/xt2DMsGgqF1wC2GCGUTNINFyY6WR5nwfYR9kKOuhV8d/JzYDkICl8B?=
 =?us-ascii?Q?rEXZhF+++g4mwqeuTdQWEzpnNsX2fOQNyUEytRTSmdkWlSbD49EJuZHJxFed?=
 =?us-ascii?Q?3CbKVty/ZpQwPLPgp3J2LrDbu1mig2CHnQ3x0qY21ONettvvVjsiOEna/84w?=
 =?us-ascii?Q?wXZDE2pdWaCxo1XSGEINU3s1Bz9xnezis6E/ceJoqJWl2py9SAsdqa0G8wUG?=
 =?us-ascii?Q?dydwCSyJT8tnXg2gcGl4pOB9XqAqoFYBGMUOnq2yQBC3GNh5pRzjFd3VThqw?=
 =?us-ascii?Q?ZpdkLKctIl1WRmEMZc+cZ29Yvmm772xjH4EOzyc/At7M3KSrLTXWstKt4rya?=
 =?us-ascii?Q?nmGbHLLrcSRVsiMmjcRS+82+2JVpeAUcWQyR+0H78eA/HZxg4aXaUFv9AlnG?=
 =?us-ascii?Q?OXK47o8oizZeacLe2iU0Df/buaVGcg9YeFN/TpaZ46yVcyo/Ze8Kl2YRzx+p?=
 =?us-ascii?Q?Y2LN+aZieVe/vGn0wib6rp10YQoCGJPqxNe7kzFrqj6Q/vp3CzaEe1ZleEVF?=
 =?us-ascii?Q?fLEeeKN8iuy/fbgYJifcoB1KyWf5KKWfLdPYua5Rt9aAS48qJCHib/KhOdKf?=
 =?us-ascii?Q?kI/6Ojoc0TYvOQELlImOaJX+uGMEVjqHPo0jMRLCndg82RRAyYCs7ob4pVqU?=
 =?us-ascii?Q?VzO+1RQXIiJpCNB7rOJNLcvoEIfvcALWWWnafa7eqIzqfMGy2RH1HVfDULHf?=
 =?us-ascii?Q?0dt2irgCl9T6vtY8kQccTERmzJxXZo2eff/i7KkYre24JAUMcCJB9WrK6Nfb?=
 =?us-ascii?Q?DTfrfCqJ4leRRTKlMsndcJJGlmUQqXRVLVWRlXeCGv6pigz6WOeLIwn9y1pj?=
 =?us-ascii?Q?yucelVI7YNPd/kkIK91T9evKmX8zg8R60pyzwAr8ShIGym1g6WaWVBDdAgMM?=
 =?us-ascii?Q?z6lWl58uR8QI6M9ShhLYSZcDIXQ1GBnFXIPEHYmB79jBspbRtyZ5JXIia1Ma?=
 =?us-ascii?Q?qN/fLLQoftHbxse6pg/WJhhWWeyQqmCmgiCjc3qbNIG88u5zb4ecps+mWgM2?=
 =?us-ascii?Q?BIyRvhVkm/vRRBaWayitbCkJNkLFIo93x7lTVt29/7OSRZwpLMklCQrkY3YJ?=
 =?us-ascii?Q?TaADGg2lJKgVFBdmARYg0y7ur7VjkchG3T769lhi8n6EzXFGGbDWlWIoIrDt?=
 =?us-ascii?Q?o73fG8K7H0WRCKYr0IZX8iN51WxoHCRB3dDjajmRaIVeLnF7lDwDrgdZTWZE?=
 =?us-ascii?Q?1kLKnDrfhZvbI2nQnCMqd+cuf+sR1WttP6oB0PBAmm0/0m0d1pQ29mtAPpiS?=
 =?us-ascii?Q?gPaRfCyu/bCmtHIRP2xWdaEeVAXiD6wmmCR7mBXXOK9fMhbFCBN2xcU8NwnS?=
 =?us-ascii?Q?LsGLD+qRDenyYB3jZ53800FuHYCduqIn4FfG2fYEvybutd9f7KnqkZ9RulEN?=
 =?us-ascii?Q?w1njiBr6TLRnwecWcawwC17ZE7MNXygvZYBDWAT3CtexEuFjXrPFw3UhFy19?=
 =?us-ascii?Q?lO4rhDaX4y86VF31BOsNamghpokJE5RfdgQC4N6k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d080f7-1928-4db3-ea70-08dde943a757
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:38:14.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOiIg+p62iLec4WgkG626K3gBkZAy6F4HnlaQ7XETMvCartf9dvKqbwVpMGIm88t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
links as a workaround for PTP sync issues on older i.MX6 platforms.

Remove it since the i.MX93 have not such issue.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. add new patch to remove fec property eee-broken-1000t.
2. The property was added as a workaround for FEC to avoid issue of PTP sync.
   Remove it since the i.MX93 have not such issue.
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 44566e03be65..b94a24193e19 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -291,7 +291,6 @@ mdio {
 
 		ethphy2: ethernet-phy@2 {
 			reg = <2>;
-			eee-broken-1000t;
 			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-- 
2.37.1


