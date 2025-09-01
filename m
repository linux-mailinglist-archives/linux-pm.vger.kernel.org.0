Return-Path: <linux-pm+bounces-33553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD3B3E06A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B81200429
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE7313541;
	Mon,  1 Sep 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FAVQfgTl"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6160311C0C;
	Mon,  1 Sep 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723108; cv=fail; b=sgTKLo8Qbt1hPguTdRHFE2GACj0zfAAif7V8qAwCMn/myzF8kQBAm2Dve+mK3qFNg71P7iZta8clmJGPqoscg/fVaCHPQx5PkFU8VXCHyj1XPPzbIIh5rJFI+hhGzL/TdXi/STE1GUrkBNN8B8MD3tT86++fBJQb+VN7ItVw/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723108; c=relaxed/simple;
	bh=Tq106xXyRvP9y8TuzNRpvz+raMXkqcjOXntNgGa4KOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdvSuAwpSzhCHHIgL1fuMlMO3uLLlmjBxxER5UNn2sqQK8t+6fuuNfOo2BnDAQZF1HT7WH8wKE6EKCjgNLgwlmHODK66rZp7Yg1qVRtu0OpwhilluZTMPLCHcpfpLHLk2gxJUR1YhKG/Vi5cRAsdRilw13VVtHZ75Me/2tzThOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FAVQfgTl; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nieo6Ssv7N0mBfWn8HJAEKC75MtS46LwFWzkVsWSROO/DjaFNwadvkfTGlekSNJqX2rVRsu4mWDCCSswwURzhZNrUwFYEUPUGe1zcAU9ILD4O0xi8x/Z58VKydcSWHxYBtzgARPHEd19RPBO/VMIRwsfqj5/VkaHQUjkHVLR4Ag2Awf4Ix0bEe3oyfurCNvkZOYBqYr78njp5gr7GuAMm4qP49hUyZ3vCitkYXKZ3fbAgq2JS0VjTt9UQAYH77Tv6E5QqEe/q5xvfVC+GbSWLItt7d4TyFtS2XrA7d5JU/jpzZKu48+A9+6ZTJCAz7/BmahJkXAz7Kn61eTQlsH9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMZN+NwLZWZnJh2YXdUXQQp8MCjx2PoMhftNqaBYNJY=;
 b=DBTfTsXIo3Iw7BHBwrWDb7a1vNz2BbZU/FlKmLGaEJ+YZkRZN4xgHNPyOs1BBi5EHNVbAyFKT34FZ2sjGKbNFmgh8U/6Q8GKZTLe2nVGUC+fxUuG0JLTYm64Ntz5Nms1NayZsjHHtSg5Dznzn7riOSGPLSNV7OuWeIAIGnKfjZLesI4pEohyGHd3OxyIh5X+3aSt4Aw1XmadHtqD5037sVdT4OqLf/HbfBzAqp237vOIQ36/dXQSLmjmgWwK0jnnHCp34qTnBvWLe52zyCrBit3BpMfw40qEjyyj2jG5405B9lLvQhuJXssNMnD6gXmhkHtSPKNweYP/hrzpB3XNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMZN+NwLZWZnJh2YXdUXQQp8MCjx2PoMhftNqaBYNJY=;
 b=FAVQfgTlSzReW4w+rgXWghI6wSmG44IeH+mxF5KiRwnO/QXmnYdjw8CNqeUSI3YKb6lQZEs3xxT4g2L+6jsFkLCJD1/C5HF+K/4rJT9XfkzLSAfV2LY9oEOCM2WQLUi9enB9IBFD18fIsliWwohqPyvEVbPZOxkqUIgTT4GKfVBhsPlXeHIEUBm2TLYMhh6mSCXx1wWdbuMXoJnISAOTpyeOw5AnIqQB/4JkSXNCddVtwujOVwJTeXpsZVOsFZ96r9KmwsN5JwqOvIydbBWOiF0e74nUCEzbh6zBR3rLsFqAQFeY2yc4RqVO8Z4ERw/By57U+irADiuNuZHO01Mrwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 10:38:23 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:38:23 +0000
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
Subject: [PATCH v10 6/6] net: stmmac: imx: add i.MX91 support
Date: Mon,  1 Sep 2025 18:36:32 +0800
Message-Id: <20250901103632.3409896-7-joy.zou@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: c4602c28-04ca-4cbc-964b-08dde943ad17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtusrc1sfAVqqagru0PBbKFve/oCSy4xkG0vt2gmV8VHtkrvmPOHXLkcpoy9?=
 =?us-ascii?Q?SUbkoYhxDRssfCUq6Ng+FZ1IAMCl+QV45b4WpCdy49t6cOdDOVUXCa0sa37T?=
 =?us-ascii?Q?jDcBA0F9DKOOMSPMmiBT/8p6s0uprvvT8LqkrW0Wz0VTw+ZdaJEJi4KlyFHT?=
 =?us-ascii?Q?vDWkWKrxFpX3opC5k6ag67uPyxyPFcrWrlnfjyxIhmYzuPEQV0V5bHpnS3Op?=
 =?us-ascii?Q?1BXIaZhMKsAiUMUC/lqtd1p2lq9O/07F93djgpH/PgcezpZGy18hIYc1+dHx?=
 =?us-ascii?Q?BXrSCOL+xzoRM0nbknSLAe+VdCgagLth3u1UUpjrvXxBecR8v7XGYKFI6/c3?=
 =?us-ascii?Q?3cBtv2x6+PzH8ERUQClHjue93mXZc7+zAxHYjxmTfJpfCICGLJ77utxl11rI?=
 =?us-ascii?Q?PA18I62nPtfmgar6yGdRcp6VxzUtiepiOw1xsb+8J9KM5Ot69lF48I5aOje4?=
 =?us-ascii?Q?5wyTvHWlC5uafYbBFPN8O5bWTNrPXOOUywsTLHOscPir238Nh06HPOWV8tTI?=
 =?us-ascii?Q?JWT5TtlAzbVAt/caJ/zP14r3Gys3MvdBFBDlgpngLiYw7qRn1nNlb7K9Bo3Z?=
 =?us-ascii?Q?OtDaVbVaQeN/vwTevFheR8Gl9aFslNNTLzCpmwsezTXUQTpIdAVDNWHX4I3g?=
 =?us-ascii?Q?q40CdmXzoGEUkduSwd0ojqigafKQUo68feaSkYlUDtaQ4Kn6n6YHsA1dhy6B?=
 =?us-ascii?Q?raOynHY1j1zY3630XM5+ZL/BWJctCzwOsnkovblU7ErknrF8M89Vu8UeNGFV?=
 =?us-ascii?Q?ZhKVhDyRlty/K1JE83yzdX/3vWtWO9YJPZ5rcax+07xXxSZ1lDMG1D/pU/v2?=
 =?us-ascii?Q?lxxph76oPk6vCAe36LKBMd0GZIysUbOpR3AOyVZJnjTuMdElR1+BINQN3JSh?=
 =?us-ascii?Q?siWGxjlj9d+9tSy+1MfYccCUl95F8s9+a+yPJ5k3gl2iEIjV1QVssvsQGpzf?=
 =?us-ascii?Q?B+Uu93h+AlypFC8l/XwvCWbAlbK9F/kku1fFDppisf1s3JIvVbFtf+5p/YWK?=
 =?us-ascii?Q?PTDrQfsvGSRcb/G5OdcuZN1VFaa2FjoTagwjQWsRXb5wDw4RJa0+IEh4qX9g?=
 =?us-ascii?Q?lOoUiI2sfx0jEdCL8Y8ITPuUPeX7D2zeaT6pyMZqboWPcShvyOoTyZ+8P02j?=
 =?us-ascii?Q?Hvt9Sza2xvAjwVrtmWXrVawwAIwIbco87RkfVboZi/yI8CsoTVNMPz3xbAJK?=
 =?us-ascii?Q?TjqijkDp+ZvKiZ07L9GcCrzgtA6ldHDQ3mHDFeCBcSFNfPL4VAweuR//S03t?=
 =?us-ascii?Q?WMSNWjuG4pXK6Um8EspP6XT7NCQ3MygmK7LcJgTFtji69RDrOlgQLuF5xd6b?=
 =?us-ascii?Q?dLxOQbYqIvv5HbbKQBLTunx1elmx00xIQaDyLqSeDHjUr53+Gd6Zbn6Jt6/l?=
 =?us-ascii?Q?tgPKXATnJkf7ZP9dILtnx95WBKRAbxzdFFSIm2wIBMcLjIN0aMHHfwC9KKhu?=
 =?us-ascii?Q?fQgmcKJRWDzOdLFFlbKrRVB0RyLz9OpAuDlGSPIsgVi6AIYNU/JEghEyBgnX?=
 =?us-ascii?Q?d8DivWxzRBDjzmE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?auTaYntUq+hJAO/ImdeiOMjMJYAcwAcaKPbPA1tsGX/0psEZ6AserhwKmGdS?=
 =?us-ascii?Q?ND6zjzJiN+e9BQ0EFdL9M9ex140UAVMrcriK8nTi1sP2aoqhJy3Ny0XAYr5a?=
 =?us-ascii?Q?F/MVBD/VNVvvVkmo4qtwKCUSZOHq0f+92StXT+ZiunQdQwFdAwykMTwKUdUz?=
 =?us-ascii?Q?YoSWsY4ZZVTHrPSTunm96H636Xc4rE7ajOpB71jnyXq/yJJipucyS13WMoyQ?=
 =?us-ascii?Q?tm3ZENDHv815FGuwWv532TURNzvMWr2SnDV60tzkOeX3XkapgQZGNE3e1WN/?=
 =?us-ascii?Q?oz1BZWHlIv6i5UtR6cUj32TwmVHW2mzL8eT9OVerq7QKFz5K5tsGYMkOPY9W?=
 =?us-ascii?Q?HgZqtFQbCMdGUPSPyMHLgBuuQjWA+T7ig/O5uacwUsjq960VOtdrBJwllpaK?=
 =?us-ascii?Q?gWBTxJc9ab5mnWJw94tAUFtA6Iz1jWS3P6t6pgk3YZECpNi0pwqY4gH42GsO?=
 =?us-ascii?Q?PgQlQhLi+sqrPQT4k82IlZyVSjIil0hVtuPaNMF6nQ7vdRIqgjjrKUOu2iiH?=
 =?us-ascii?Q?mmwkFIeTYq+KzN0tZ5cdS616IaLk32Ni22qeK0zh1dmDgG+hKPalCQwKV3X+?=
 =?us-ascii?Q?25c4FChU7KwGI7se5+CSkTTTqbuGjQBsLXWj7/9cDTN2WEwCdaberZVaJLS3?=
 =?us-ascii?Q?5b9uEWki7RFkz6u9xtJfpuAPBcVTP6qRRXKGsxyc7JBX+jt180eBHXoTzcND?=
 =?us-ascii?Q?iV+sHXOQx2BP151u0feHl//wp5kDxWp0D/5Kg6bc7VR2KCD7DUsbQZ0v7rvK?=
 =?us-ascii?Q?/Ofo2MVQsDavG7bcMAaVCK09HmsRCaNwo6GA8vx1dWnHZGo713GzScx8e7N+?=
 =?us-ascii?Q?2R3MBCR5ftSSiLwmo7tNKsYffCWb3ur/uhQfHNsFK5KhlE2IxCPl0UfBg1b1?=
 =?us-ascii?Q?2PSK4mCsiKiCeFl2mmmd5GjF2Kr4vMUJWJBhAMX9ViruoPvg0PxJBZH8Ti4R?=
 =?us-ascii?Q?d7SPwiA3DvecIgP7UD+qCjTrt14yD7eeCDdX9B6C5LdM1KlUPGP6lt6BPq5G?=
 =?us-ascii?Q?TpWCicIAhVGbWjwK2BA18B4Ps1pnLK3F5mCPtV8nxs7Dx387sNfljORNM7Ye?=
 =?us-ascii?Q?rvBn4f5T8NRFsL0k6ombgAdVIh4qU7yVvOlmxHzwkcSUAeFbzc53gRkTKGNo?=
 =?us-ascii?Q?HGfFSlTGAlsjnl0T/oDY8d2NLHRWWXf3iVll6CualET6sTkbyx1POc2FPavr?=
 =?us-ascii?Q?gzEglE3lIW2dg7nT66o/xmgLzpwljEllFwgtIdh/NIGymQ72GIiLqE72wPFX?=
 =?us-ascii?Q?hwv7sSftWax0MBlw/EsNRCB0XOmkIzLVVqfIgZfS/NkEujzH9jeLPNdKOP/G?=
 =?us-ascii?Q?DbF7Pl1uK+Yl29hR/VV3L9Qpvo+nkas5olzvVz+x7M2un51xQ3zxNWUgYbVn?=
 =?us-ascii?Q?2PrvyHt0RvBmwbluW5Ia3t7yhjg/1NxlWS3NgpbmYndyv86zHuXyw9kFmSY3?=
 =?us-ascii?Q?cNyM0tyMyMZNClLAnn488odgCjn8vwOaTRNSt3Z5MkttJhCu72fPnR+DVCm6?=
 =?us-ascii?Q?0HIUDqYjXxjdiDODjg09R9FNtVIzaheunTEl7fqjHnNv0gPPoJHwX66RM4c6?=
 =?us-ascii?Q?voWzOqhKkDX6XQFg7EAIIS+pxUULAjMc7uOqpzTk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4602c28-04ca-4cbc-964b-08dde943ad17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:38:23.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ21fEMDIJ4ZlXakkCBsrYEC3Kc+NU1JYPKfNXblR95TDRsKIvvezemQuTx6Rmum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907

Add i.MX91 specific settings for EQoS.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v10:
1. modify code comment indicating that imx91 is a required property.
2. add Reviewed-by tag.

Changes for v5:
1. add imx91 support.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index c2d9e89f0063..80200a6aa0cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	dwmac->clk_mem = NULL;
 
 	if (of_machine_is_compatible("fsl,imx8dxl") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		dwmac->clk_mem = devm_clk_get(dev, "mem");
 		if (IS_ERR(dwmac->clk_mem)) {
@@ -310,9 +311,10 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		/* Binding doc describes the propety:
-		 * is required by i.MX8MP, i.MX93.
+		 * is required by i.MX8MP, i.MX91, i.MX93.
 		 * is optinoal for i.MX8DXL.
 		 */
 		dwmac->intf_regmap =
-- 
2.37.1


