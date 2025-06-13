Return-Path: <linux-pm+bounces-28664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18941AD88E8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B823B43B1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8532D5C63;
	Fri, 13 Jun 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E2FXSo1k"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF332D5419;
	Fri, 13 Jun 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809234; cv=fail; b=mnT2Q+MhEey+8KaZDIOC5ItxVBFGba89qRVzyYd3wrDARv8Oj1yijfAZDdTrfYnWOMzRoO1Zrc0GGwk6nHty1BcLscWouFgK+Caq4bf4AJx6QaZ9j1JmUCwLEDWA1hK0o7C//B8PEbCcn9BrXvamsCcWSGOEUauW1VDLiMb43gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809234; c=relaxed/simple;
	bh=PduwEW/mnQFT4m7e6eKl4dgQOSzr/mI2MPNIGVa+R0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q06xaqtV5Xch/06oyqTKD1qFtWrUu4T553bWGYuKpAhZQ5W6CgaMsxpCptS4eIm9ibK/5QcbwcOK2U419m4PVQ/CvXeQciIMYe+b6f50o8Zx/5qZvhYMcIP+9PHCUqKCW4bYOgGZt0pZzUNluUJkMHHub0F+3cMpVUddCK4rzKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E2FXSo1k; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP2d+Bp6NM6dkyYAvca6THW3xLyxx7DcAXysvEc8/ojonGs2vf8POzbXzfLaeoNaK15iOm4bwG53T+WCMQaQsD84YMZHjakeV9Sfsu+Q+xveb69Rni5IbkqoPfGZxGp23YMzvCAXArWqQTEg6kPVU+T+s65gtYpxHgxGgVeL8H+dQjwExUsWSghVDn5XRpnYbTIArSA9hp57f6QyEGkWOSHxy1B1Ynl6hDb3v1/FApfvkQryUe3v7xaE+1sRuiwkYdPVgpfWa8ggVcSCBgagekMLG/nzzR/fzJw7I3DeIn5N9TLmQNuI6S2ybq4259gLZwPrGBgn6grd3TGuOa2fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcdsNfz1suHR+t6n42U2LhlozDYfGbbAi45vCOcA55M=;
 b=uAeyZXss6iAFlP/89p2LHNBnBCcV2WFW45vHz4on6FM+AEqJ+Uj/+IBOXb3wSgEpFOAMiw3wSjmVtW8LZceZ60M/cLEBO22tkj8BrmUOtbfk5E0wj1ZcYqayhOimQ6PMGVxnA700Z5kRTKePUk6XA9tFF2P26za8li8ZTSNR7DXOs+w4MUD/iQ19RfQ0n0r97T8D6UkgTB/mTTUbog56yaIcbj4HE+6FnoVSo3eRGFWKCq62Scx1997TEbWBolHlgQwhzkaqCuCUWfAOSNPJDO8eFm5WS6Wgeb7ZFG5fT94r1xuyHTcToSzuE4OVDqG8QXXWzag03CrFtAxy7lL6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcdsNfz1suHR+t6n42U2LhlozDYfGbbAi45vCOcA55M=;
 b=E2FXSo1kJrifVO8GpKqbsajZphv6oKVs8YuMDXqc+No1JeiN6I/dDIwntEtCRbH6P5EcjXetzOvtbursBWQwjSX21mbdvBRiLg4srCIyxWyhMB5QxLUPeUpAuDIR8giepDCBG4Y7BZrUfAJaNpbmNKVIfGHnAWhPrsj5Q38IvDAHTTkb5HE5lwMRABbMrZGazHFJ3ei3GgWR8H/+an7vOszsGnTyeX8cpS7zOY7Vc+/cAERLPbAiCCkLlDYcvrIcTQJDny7PQRMyFEQR7Sx+iC7IVaS+FXVPLn8Qc7miR57mOmD4pvFWosJWEgFS0ulEvfijIOtT4RMUxp7l24kGmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 10:07:09 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8813.018; Fri, 13 Jun 2025
 10:07:09 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.org,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	xiaoning.wang@nxp.com
Subject: [PATCH v5 9/9] net: stmmac: imx: add i.MX91 support
Date: Fri, 13 Jun 2025 18:02:55 +0800
Message-Id: <20250613100255.2131800-10-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250613100255.2131800-1-joy.zou@nxp.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI0PR04MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e46361-749c-46ff-45de-08ddaa620f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OfYE/3k/V1rd7+W07wIGmpJpTLkRfrSy0bGcuAKCJlBLAy3q2g7Tjhr6BN/5?=
 =?us-ascii?Q?qjzaVOZ54OgKbbtdIZU25YxRz7/k98rLKyicdr6Zk5wXmG7kPtriin9fEPkX?=
 =?us-ascii?Q?VZ8w2Vof+/6oBtdmXTRXRZozJGI9vVxIVd9DZ8Z36TQu9Ows7MEe+ChCUB1M?=
 =?us-ascii?Q?0oL51OKbE3D3UWZZeoI183HVplLGEsqVQzuYoGvgaHV2GppllpfadPvmIuT8?=
 =?us-ascii?Q?CIMz1YWZ54ajQ631PcirAWve/JsuOO5pS8fBLuCeRzUmz2pcvFB2OV9jnpii?=
 =?us-ascii?Q?yuHDf+bpVpy+uPdj+MygT2RC+XvPW6on3Ab7pU/G6yZYzych1ufo0Jn5aBnW?=
 =?us-ascii?Q?bLVlNc+MmEVBPAdqjYOvgd0kYUpxDR5jfWxEuC5S00z/ShA0YKQyTOb+zuR7?=
 =?us-ascii?Q?aKdK3OlTx3SYqClWdmf7VmIxGNxU7P9HasV3OthvAzzZt69/aC9C5dUWz9r6?=
 =?us-ascii?Q?u13TfBMDJbYVAcZtPteBlkzfS+c1alYrIJ88BcrMHqW1FwjJTDa5oqiOvcZN?=
 =?us-ascii?Q?/i9k/wQ3a9fRmKmMMNEh4E40Qzc+PlPJyvs0G73UfqC3YzStukdTeJHXVSVk?=
 =?us-ascii?Q?GOBXCQsK5tj81Fz4UQDzlazt15kvFfbv7mob+Q9ve/M9z01d70sPLhBboshc?=
 =?us-ascii?Q?AE6qHopb6jH88pv61q49KSKeCDba95T/vDCAS0WDG+0thwx1byVNH97NAmhA?=
 =?us-ascii?Q?KZ6/kCq7da+pm70J/KXbhqSmhNHB8bYsXgqHltcQq4VtqERuHu1H/J/cdgyE?=
 =?us-ascii?Q?v01dDUPrmZWObT6HyI73grO8LqjCzDzCOMsLJ66DjrPFOtRNMDQw1qMgF2+1?=
 =?us-ascii?Q?PbWOWl46qHmIjvOm16Ma/X+U9vDJOjx+pC1MNRkkZorOIMLLEAzjb8oo94Cl?=
 =?us-ascii?Q?rMnLuRnQebDgHqgVCXzfhyeKS3JmElX1/cpopBOy7xgpsGIOPjxhTHsd6FnV?=
 =?us-ascii?Q?ZmihCVdGnujPOvcJYt4Yw3E3K0WcXsW7Rzw6A0mAvnnlqn2XFVaNRztMcqM0?=
 =?us-ascii?Q?eI/gyvhQSDG6jrCVnE0uZbJkgKn0QLZPF9awfoTOZnz1stQ0gsKoZ99p1Dq3?=
 =?us-ascii?Q?P08Z9xSMfgQueooEsr1nGV17JWsLiIKJOGS7tJxSxKubMAleaMJlt+ldoMcT?=
 =?us-ascii?Q?bZ2+htZJ20jmiFlp5gsQovo0WNGTL/bHImf3HXUCXUJqvnLaeqoLHANuPrXo?=
 =?us-ascii?Q?4506p7Q7VCDH0tRWRP2YXUIillXMRGWv17IyjxIKrl7YK5ERBCPngYNAI23f?=
 =?us-ascii?Q?xRyjURm/jEDG3r6MX0XBPLhBklblYNvEoqzux3nnmC+1dadd6b51Yqx68RqS?=
 =?us-ascii?Q?51fjf1l4ZxN5S1mflBbLV4asV8qrEk05nZmWhudckio6/7s76A7z8e3Yhgnv?=
 =?us-ascii?Q?PZzUMXpdRiQupxqJjj9iQ90+u+QO79ds4iDcBZhDb5QL8rFezuXbMQEGGp70?=
 =?us-ascii?Q?ie2uAgqEZkwjkCtIpW3luYizBpS0xJ1Z0duMyhytcuWTQ8M7oh5HEqCpq7pT?=
 =?us-ascii?Q?m9d4wxrDXw3k+is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyls5GoAu+gcXZsytKBAhNIm4NynelPLH9IToZ9fxQSoLUEKWuIuiPZ4bYMJ?=
 =?us-ascii?Q?u+5qtuREu00CeD4oggo7SP1o8olFcXkpPtIISEHw8UzhRULqjK1IUmU0EHQM?=
 =?us-ascii?Q?W0Zmmc0bUuR6MW6DwQHdJaDJEv+QHSbKsSamogyWHo5godZ8MIe+b7NyfDCS?=
 =?us-ascii?Q?dmQexoIRcXMHFypViDkUOvXT09QmWT3VutR1W3Omsten3QxjhikgHExTwihX?=
 =?us-ascii?Q?nXaAFOmBi3/9u+FNKkSFMm7L+enwmOG9zOvJR7uu9PUplJOIVuA4RroCGW3o?=
 =?us-ascii?Q?N17iEqQSx2sLzq3hwAF//CQpHFqTSYAQxDsOyjLwn1aVSwWJJZabWgUQap8F?=
 =?us-ascii?Q?1O3XPNkWZ0U0r/34grylUSb4Ej028n+IPu1W3HHZIN4ucHR2vuilF4bYSqnH?=
 =?us-ascii?Q?39J7m6yDbS+CtpESvR8KRESYVtCS+W1gmqaYPkWxNPY1Hbjk31PZvBD1+ZNZ?=
 =?us-ascii?Q?2EBHiHRGIoVqYIoBVfwtM6sH0gZ1IRnWmOzWyXEW61ZeqjDHCG/UXbJhgH1/?=
 =?us-ascii?Q?Jj56PghYgNDbEkTAuLRVrfALyNfIF1uc4cfofXzmo4ENDzDqNnjWqZgZA4IJ?=
 =?us-ascii?Q?Mx6kgUAJm+anIO8ynsuAUd6ttTk44ZftBazhD5jrKz25cxpob8gKZoK9MBan?=
 =?us-ascii?Q?VQCtQPuQImrnbgdtijZHRycUtYLB+eLinHIatLfi9UgKhZJjv9dIU2gpezmz?=
 =?us-ascii?Q?ob9pS5E6ZLVZXeRkWc01U+trVC/9dog4lRKirX2nyopSWVueSM8euc4JWCal?=
 =?us-ascii?Q?KEXEUrvlOARK4SZhJKBrC2WghMgRDQHVTl/tmjRxmyDsJJGmUV0TI9FRiymC?=
 =?us-ascii?Q?SEtTcGumC9qGSB+tVRycA6Y+BsuAwikpZUMhOUQOAXzMPE8UyUzjmRZyHkjP?=
 =?us-ascii?Q?yZLGpHtLu4Hh4WiH0IYppGIB3YGA+5v3UmqpZ/nq4HftOETidVYSZSSEveQ0?=
 =?us-ascii?Q?Q8LKM/vUqoFGgY51xRf2nQzBXl+DayIjHvc92JKlZ3mYAyY7waaijPDp7Ghf?=
 =?us-ascii?Q?7Kks3etZ0WLF3glEtox96KXd07sD0WgY3bbxNZM+6YDL5B7XUh32hdTcjhU7?=
 =?us-ascii?Q?T3e6NCxf0/zd2cAEo0ebay6t/30K/VUaoqE9jwZFaEjLaTFnhljO6/kJljqL?=
 =?us-ascii?Q?NLKG/mjmQyNp3ksJIigJ9s6w0zbe7VA47eIKcqai6AvwSIqwqxOzOwpyuJ7F?=
 =?us-ascii?Q?SGBObV+n8u50oAWlEMmq4RcQ3pn40WOH61Av9nCBQ6IVx78/TapAKm2KB2ZC?=
 =?us-ascii?Q?MA8AxFVpD4wxm7CVyIclDbXtft6Zt9iPHt/5xtuGX/uPnISfqEaVUEFm5UMO?=
 =?us-ascii?Q?5XJwMJrZUHMl2jHrEewT3k15GFNlQtGXzqjhvJudRp1QEVt0ZYX2k7YXrAgy?=
 =?us-ascii?Q?whLD5uQ3wIwDM63HnC8y9ZWy2PVVPt2Nzw3/BEHC1j3gAfKfZrV01PCMGOTL?=
 =?us-ascii?Q?pVE0U98gqmkzk7zr7AzdpNQtE3ZY7wHJgVWBUfzI5ebMw6HCJ+Ozp6aQzQu1?=
 =?us-ascii?Q?m6G3a6xecqnlfPFdCGReO5Zvcw2FNSzdIhHF6mk9rD5bwLB7QqNmu1PwTMWt?=
 =?us-ascii?Q?eZscdChRFNGQNMTas19DmVe3NUjMTfmUlLpqYH72?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e46361-749c-46ff-45de-08ddaa620f20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:07:09.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDO/bLWWTLag3frk0raTsDRQhpQOwraKxnZIuoc5kM4dvGnDKMsTK93Yyk7rnsm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568

Add i.MX91 specific settings for EQoS.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 889e2bb6f7f5..54243bacebfd 100644
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


