Return-Path: <linux-pm+bounces-32002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95079B1C53B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C6356217A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E528D8E2;
	Wed,  6 Aug 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="auUnx1E4"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAF28BAAB;
	Wed,  6 Aug 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480611; cv=fail; b=WKbDwVe1GHkzQXUPNGu/Yo0dUXaffiFa/l9KLYtnqcrHHMAnProVvCwGloe1jVjFu7awCnPo2nIHyVTn4zCUAOL5dvWVPKvNbtzq6GKiYd5yim84yUYSui6gIypfN0D4EaLDEi1Fdxvy02NvPuiLeiaLJW5rVNwfaYDAYkfvYjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480611; c=relaxed/simple;
	bh=MaIPoJ3/6Vq+4H7de+eORNtPKU6CkSMmzMzzfzwkAos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SMEkB5swfMKCYK2DENzDo29apkT85A1XM05rH/mNNxc+t2AgDCs96vau30Z2Hp1G06zQuadXTcYihV8NoSjcqLj4PzMCLkoRCrtAGJhU6hUrif6/TakjeDlVyQ7sc8Tbwc2LGTi9I4Bko7ZoqBekPoyWocbuPIMO6xy4mu5dDJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=auUnx1E4; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQP/SBWfMmJkb7Th3LFDkvIm77n9hEKd56J61nIrKBmgJBjzCv+A48SCVLnU2oO21C1cBR6twaG87mgyK5BdhDJW9VV/h9L0pTWgbcoSOmJvPyABbZtYwO7CkoQt7gjFRj1jr7CigEpB0PRM5lg/ZWROj0V232BzZWCGmP6uweCJHreIX+B5tBCv+AsCbj8d26w2ziuQpmONThoWWfQJ9v6hf4f7eqa+B2/WzN3TBniyfImXHqr1c+fmpFizwJPSs4fGbgL4Arr5j2nz/c4gArU0Ru3EoNbFzfPeynuLvk6AplacIUNDfux6J/tb+wFZa7oC+Mks/SXfGVVbVB1W9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8xGlCM2BflXtj+oSVMNr9Y1xK8pHkwBiuBrSliVopg=;
 b=wbJPyo+x9VjJ6HBRrYmuhUgTm5Bbh13pswNNO0Z1K/su5KDwZvScN47H4vR3xcxD2OMJvwf9E08zALkhXd+KwrAKoG3H8JriD5lDdQNaUGnmDn9dZk/JOhqwZJBjUYZPEvENRR0X0HPz0RVRVNXiiFJpsfFg1nMPMgesJKSFbip4snZrl4DHFUoLlNTwjBJj/poMLkeoQO37xmzTnD2TBLEzWUC+BiPAic4fXwgmZP/ZK6dCiKBjNhmGi12Xlt+eGsQQ9FErzEBKCz6nk7cryTdku8WgM0G8cjz4l9n1Sro+SqqWFl1V9UyTlu8gUu0el2sdR39AuLC+NwthfX0kzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8xGlCM2BflXtj+oSVMNr9Y1xK8pHkwBiuBrSliVopg=;
 b=auUnx1E4VYupJwhOhygyAs1DGIz+s+A6oYSQSa8EZwmqH0IcvTt+af9x7S+mKall5mMTTT/YNapE5ILIv+DnhTx2LWr60fhxJ3wMtkSIlJS3lyFlJSWfSCI2+DGpd7V4IxXGaqYo+ImC2I4q0QR70ML9GTuOJ0hsPHvaWmVCTCZcxKs7o7k5OQRoUgW9N0xTVn26JdEA0YHrqGWwVhwDVRRD+93GSenQ4IolDeaohNULXF8gQ0K1cToeRufg1kK5LgRybHWkxwpYDx6CGyoFch594n8+bAMlutQuFr6J0aCEHosYUDdgkWYXuZBX9Alz9OFqkOGshdvjjdHwc8q2Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 6 Aug
 2025 11:43:27 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:43:27 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	richardcochran@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
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
Subject: [PATCH v8 07/11] arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
Date: Wed,  6 Aug 2025 19:41:15 +0800
Message-Id: <20250806114119.1948624-8-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250806114119.1948624-1-joy.zou@nxp.com>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 728cc40d-b3f7-4fd3-a551-08ddd4de7519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuVW5DRbfmWIb+muNg88TEI2doIMFbHF4GW6oAf3UPMoMu2rR/ISe2i8/c0y?=
 =?us-ascii?Q?9OOB3xiXWzdOAp8bS6R1JvKBuprQneoCO9mef2KxYWJ6fhPlBgQCxhr+fd4B?=
 =?us-ascii?Q?DZYtKCQRfWeCto2YAspMN4v16xZQBfe1pIiPzKQaxIPUZp4A6zLkeqHOXFxO?=
 =?us-ascii?Q?zXKwJyey6rdenKYsKncEBw6eqy0LkhRX4xUF7jC9ZQzFV6i6tbj095g74uce?=
 =?us-ascii?Q?gyRDh+mryOHT+RApbbALK9B8YO1Umy2ppeh86MnebppqD9SCY5lw+YEut8qT?=
 =?us-ascii?Q?7qnRC7TOqSy3ieT3FrZ5AyilQJdVIQU1oKQgf7YjRJErca1BWWFJLGjwYHRn?=
 =?us-ascii?Q?9xG5KzC0OyUI+STz6tSltl0+TVs+bzyxAgP908LSJvNqzJTK0cLTCNt/p99G?=
 =?us-ascii?Q?P3WvVzgeSrnM+cO5+0PU/EHeSpVd+B+KeUN7ssmYGG1u+eEtKSlg+fjmwLAY?=
 =?us-ascii?Q?c0OECDEYjLFibuEGOaevx9Z1xvZ7DMcq4zRPK3eaoaEN5X0cWpb7pVeEteh5?=
 =?us-ascii?Q?khZcfrHSypuQbbGAf1e8PSaEC9FLg+igDN4kHWrIwO6D54mbMtK8yKh8zoNa?=
 =?us-ascii?Q?1z01OYHmgj9kl/Ujniwz2xlyiPY2yc3+XVlO4oOUhszrJVqDQmOs/GpObCPY?=
 =?us-ascii?Q?exI815OgeI7yBA668SgG016ciW7aIFXNX+QZPdWWrROKt/Njkgn/IbIGOvCI?=
 =?us-ascii?Q?DziMNMN0Bc5qUSWu/+cevuY36PdHgLfYElczvNKSVuj7v1uioANsjbjUrQMj?=
 =?us-ascii?Q?MNrxRvnYjEeV2O8Obf95O8B0FM6eA3/yqf0UsL3icD9UXanHJdNh2HZiMuRM?=
 =?us-ascii?Q?hjXH0LO9uITfA3BLnZs0FFIW0zTFfraJg1F10QbA8D+6vvhbrpCmj8+OWuGu?=
 =?us-ascii?Q?Bl/O6gnhbQccVcZenKfQ0aDjKpK6cHaeY1hGLqoI/YSHXELiN2qhoGA2s1hU?=
 =?us-ascii?Q?garO5QIEwSF+Jr/EU94zGhtdtQ/5mL31zXNszC0+VekB5mfXBnDOZAJH6iUx?=
 =?us-ascii?Q?645iw6BpTs89W+7M3+aCzKYW2LJaG/vJDISVNO/G4w+dBe0zdlnWQ2ukSSPF?=
 =?us-ascii?Q?gLis4Dea7xb8TUhUNw6VEsCD/pCuAQcZhLqVIXRXzjvWuWHAGwZ0gzt5BFCH?=
 =?us-ascii?Q?nGfK0Zipm/iYaOWR+TYFh5R6Y/AfxbITdI9dxbtZ3nAT5O/bn4lzhpSbSrtq?=
 =?us-ascii?Q?79kc5L02Vx4tSnjAaUQiLKAl9lWJaJY+rS+6YRrds46lNm2NOHIYS1DZ2uZB?=
 =?us-ascii?Q?tQD1BmRST6GsdznHhRYiqQ7c71QowR4RuLTXd2gFqfmQc40Y1PHCV5ht2WtS?=
 =?us-ascii?Q?IPNADEbvtzb4w1TyODlsEOILSSkB1waOXJH1fLIaFWgqV0+ayPTU6rkwDDEA?=
 =?us-ascii?Q?mM0Od7rM7KOiF3GAmlT0zrDbwONC6I262kEmsFAJs6rna2JGcyg2UmveC8b9?=
 =?us-ascii?Q?UQ/SqM5CJFEAg3hnAsp91tpS+FZzYp36ZOtQaCAMWFt05wVZbbFjtxAwglwS?=
 =?us-ascii?Q?yIxufSzNGstfd9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EftU0QdtFgbl1j9mjH6wK2pYS/zX/Ob2d8BS5t18er5zPmzO4JbSFydoGYwQ?=
 =?us-ascii?Q?X9aqDsCbSyYcfP+YYYp3fICMMNtF25ZA+X4cNZXLwbFahVhlkcb/uNJWdo0K?=
 =?us-ascii?Q?IWXl4ujDpt/C3cu87oAxDGCV6S06g/mcfpfx2mFD/RL2/Zj1fRbWpN2jMJjU?=
 =?us-ascii?Q?y5OAXxylzl/mPkMaEZ5hTwnWl7vFqMLZoGKerTkKJhujA3rC2YhH3PMOoOwh?=
 =?us-ascii?Q?djkitJas+s+o04Z/aPEZx4V2tvYkheJP+Aous4UmNfalzdljYUlIxpkjQCqo?=
 =?us-ascii?Q?k+GYuNp1fTG2ieKZQUYg1HWEGvtcLpOfjZRvsNiK8nGzPpWzg7ktOPgNxdSC?=
 =?us-ascii?Q?w8OHXZwskrctN47//T21gVqVfeP37lrvxtxFFSAiDoCDeO/JXm8q4dtiqkah?=
 =?us-ascii?Q?flTPNFuNdSeigevogsZTolHnIz5lPRUHe/Fr5bqI9I4ImQgfJJfsFIOFhChr?=
 =?us-ascii?Q?BNHp+lj2M8JhR88KOuxDiEFxrfKb8JSnr7aD3QQ3wY6Q6y5QCHv40hv0auC+?=
 =?us-ascii?Q?1Ra8ZD5LVTF9sFwRsa4uxw15oiw9cm7oGIPKfRDFBqEbQ29fHuihAD9usEda?=
 =?us-ascii?Q?ge3YTfPxTfGqAtFgwu5VbQjMkfc1GEsD0/rSsUnP5aavqKHSh/BEk0pRzm4r?=
 =?us-ascii?Q?D3DVqw1yfaRDHp1CceOVJbAYgXnzkYH9kF84L2qoCN94vwRluOGCnfKMmaNg?=
 =?us-ascii?Q?O090F283rwiumapnX+1DMxUj2Q1aDHXwV5cgSu5n8jDl0yvdjV34+pH0uWDR?=
 =?us-ascii?Q?c57AbzaX3S9qScDkgQAlVgk2aNpyAafPVYQ7nJVOqRBFjlAN6AQH++/IHLBK?=
 =?us-ascii?Q?mIfz3/fhTw5PrbH7Qw2k4pHVFfo5upZXtC7o7G+jISh7yaR3IVZedQ/szDIg?=
 =?us-ascii?Q?BxYAXkl2SOkPWfxAkCuCKuyqvrPuM5h9vEDeU0E2rqLFbG44m0cMp69p8JkK?=
 =?us-ascii?Q?9lXM9jSpyBK/N5nG/HZZTjTp+9qwVGLUzQ3BcroDJs1hwMS09uiVHqzAoZXm?=
 =?us-ascii?Q?7wpxtulHv2xVQ5xZpw1o06Z3BO3WPUZINPK91EaBhjmJGNPXAR+0wBWgRCuL?=
 =?us-ascii?Q?6mOPHUqjh2sVG1hk6vdIZczzC0QTxdLkqfcybj8G0+lPr/YddaUDjJM5Nee5?=
 =?us-ascii?Q?PiSIXneSXMJ2MHzmZkqE43xz15xN4Xh0IvH9itM1C4lzuHLGqufwk5DyNf6G?=
 =?us-ascii?Q?Dvc9+fVFaY2eT98Lc/jRMoSHRDLZpSm/GLtVGE8f27Qa4jClBdTtdDJsKvgK?=
 =?us-ascii?Q?lzOuCNF+XpjVxcynSWtiNJ7MAXHJGkpyO1BKIb67nVXXf026pG59qXaLBQk/?=
 =?us-ascii?Q?fNJxca3bs8Kq5ffZAv9UtOj0LvxivUAiGhPXYEjcITGgvw8B4AI4KCoHhpv/?=
 =?us-ascii?Q?ioYzKNBPBhdCFGJuoj6oLbq63bJOn5PGf58SK3piA9oWngfmzVAU4vzxAtwF?=
 =?us-ascii?Q?AJ5Jr90goFqKvyxEypd9DWtGv3eKiofSv9GScZJwU0CMuhN6Eir2XjgcMcf5?=
 =?us-ascii?Q?RQi40AWWN/cDlF/SB/liaV6czG5JKNeC/AAbuLVMSs7N3HOhwhpBlmu0wQaL?=
 =?us-ascii?Q?M7pL+BJa2t9qB0CAVbvmM7ivb0SmnPqJHykf8R1q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728cc40d-b3f7-4fd3-a551-08ddd4de7519
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:43:27.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX7fPqT0efzmwEYomkgc79YmPG9Hk/RXAn9ounWD8H70MO9w4eiKI/v2tuD6VnKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

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
index 674b2be900e6..5c26d96e421e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -260,7 +260,6 @@ mdio {
 
 		ethphy2: ethernet-phy@2 {
 			reg = <2>;
-			eee-broken-1000t;
 			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-- 
2.37.1


