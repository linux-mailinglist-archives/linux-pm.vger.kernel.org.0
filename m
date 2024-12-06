Return-Path: <linux-pm+bounces-18688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAB9E6D6B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 12:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B601699B4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88621FF7B5;
	Fri,  6 Dec 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UowEzd4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2911FF5FC;
	Fri,  6 Dec 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484486; cv=fail; b=Wf8c9WmLZ3cxLeNHZOy60gOnYX3pjmaTzr8WuT2jP0QSZVAYRxiFtLjIGrhN6UrO6BKwCe+k7vPen+4nmIZfscXiEIgq1ONeyE3cUFj96HZ8OikHXGELTyDWlNVNW30No8wBmG2VYI7EHoTFPuuJTULX02ohoRbBptBzunDciv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484486; c=relaxed/simple;
	bh=SQ9lPRkR1zenQjAodLto2VEsAzqIzkVy03Kfb+LD+yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRiQFEfbtIA8EQiR8kyCJBliA55mp3UHJae+sylhmjIQRFTrtmA42btQBHUwSuxXLvvrFf7tOfCxNUJV9Z0Eu5H0zW2pHcR3wXsi0b+cmU37MHEVNhdq09mLUedFdGO0r9XbRzube0PM98qTkx4TlwYPrqJ9YuRUV05cN3g4sww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UowEzd4a; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fU620jGyuVzc9bBP1Xi1ny+dQ22J4yP38gh8D8yAa1ZmGABYcWj01H903zIjOeefdwYdak4eNhvenCOuFdsoX6xUQc/8zl9MG/dfn4WrGn9UiTy3WHNrA8Hz6SJfM9ayfl+0URPtlLyW1HEj4M7Lf+mcUxBD2qYYhc9/9lGe3C2sLA61azccyAhy3Nhh4e6u/UXIghAS5C1CXlWBOx5Kx+gDZqInA+4JicRwPPWuQWdvGRCIlVJzrZSfTeriLeHVQ1YIfm5bd0a7lx/v8zDhfa3BhJbXx5PmlI0eSrqrnF9f+tRf7CuRVq4R/XF5PuZn6djqMn9tssjLWX2ykZ+wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoKBVXSQTxlJmPDvP3gyKy9wmOuwqhNnsYKMhwfRkNM=;
 b=K7nO5TqCcPjK6al7oG3cnfOGlKTiTTygpjLOLfkxeT0cIid0vUtQ4rY2oZ/FupVpOp0a35Wdv6oKAkdU0OMh/B6yHwnPYOTvis6tDaJK4Yj4hHdV9rjv3vGaxl3Zrjqx+cN1rsorRJ8VuIxPtFUrGjYzbX26j9apbYs/gf2z4v+VQM4TQIE1yjiLlBtd7NrqFQbyEW8xjmiU/t/DUFnKeMVw3Hg1cEBVW9U8u0ay+fUx7saTaFVwzjSqynRREPccWE575wQTeAQSHiZ8fAQZB+POOFKfeXm6M4sHnTlvCBEzoXl8d1bi54u9bFSNvdNc1jqeXsqpYvi5R58MUWUaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoKBVXSQTxlJmPDvP3gyKy9wmOuwqhNnsYKMhwfRkNM=;
 b=UowEzd4a1V5mohTtTbn07Yz2w4SHoh77uw2Nb+7lYCJubVzcS+hnZfw3bxclqQ1N00OCtNKuonbbqHYKqMZuk8NDiypVD5eC8OKb/p2yr4CJsghFS2zMNi5HNHsxtprKyL3hDimGCCtUOzfAPP4rZHgIIws/OmpdTMaTn/qPSzsxvYMPzQZb/K3InteZ7SOWq8r7Z8B+yORWXMgb4FoXba+09+Z7opbeqofJUfXkb+ZHwF/brekNMB9auiF/D5M2SwEPMeiobQrnMWCG1EgadpctLnoCSgcugQMC4w6F9ZFC1cIQJ2wm8JqPSRhNiX8z7yY2ITvCRUgIZnN14s7H4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 11:28:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 11:28:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pm@vger.kernel.org,
	aford173@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] pmdomain: gpcv2: Suppress bind attrs
Date: Fri,  6 Dec 2024 19:27:31 +0800
Message-Id: <20241206112731.98244-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241206112731.98244-1-peng.fan@oss.nxp.com>
References: <20241206112731.98244-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b1a3af-8410-4627-466a-08dd15e90b25
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dv3OajVm7ThVSgCChaFLIhhBa308g2/NocnMIrx2pApSf/2jQLSdCM9FsD9p?=
 =?us-ascii?Q?Gx6DqGjHGNBoeMBBdLNdO4O8XqJLlsCbDkVXkk0S4q470bUsj4fRdOJHSM5j?=
 =?us-ascii?Q?7a7N05VtTHiQ1ypaopFngoc52n8xkGk0dJ3Dh3XU/CUBciWFA2t9RqTuytqV?=
 =?us-ascii?Q?AMjGRFZSuFZxgFRzmj2El222oEDMs4jjGLVPAukWebyImOwWfuurVBJcDiyZ?=
 =?us-ascii?Q?lxa2a3PewMynEJQfXcORUzIfdiFBZbUyuu9he/O2R3lW1MMA9iOe1AiMBcgu?=
 =?us-ascii?Q?OXavBLRkYC08dMsniMXoK9n7IEQ7jHkvdfPHIJ+sTNaPBH+3awhr14qOTrj/?=
 =?us-ascii?Q?N8DakCwZd8McnMymM1mLuRZPgE+wJowyZT5x5jQ6zCZDl8mU0e98/H86IN6Q?=
 =?us-ascii?Q?eWAhzFuNwJm1iXlhV9LaEYkJaRBfzaKmaOExvXelQl3Qr2u5mXJGbEgu3bM9?=
 =?us-ascii?Q?6xZY7BmSSs+Lb19kRR0tPhJ5sc6sXlzdRITiQ2zpGZf6m1kqAXFejHl9AcHy?=
 =?us-ascii?Q?HrFxpHloc3zJfGcfhRwFQyQY3rZKgvVW1YricNvDfPc84X6h+isflZru6D/t?=
 =?us-ascii?Q?tIIWoh9U+no8pYaclsEXxoC7/9sOZ1wIffuxj0KvsedD1f2TPT1hT29DAOzA?=
 =?us-ascii?Q?F7JSs5tjH0qOPcoJEE386iYXyxD3GNfTgm+qPynSb+m8Th99PElUce2Tl0QK?=
 =?us-ascii?Q?BUI11aOlgGfsNLMG6ZIsxMNJyQ5KnfQ8+zUxtoZnaxtxNk3LRqSEZtKdecIB?=
 =?us-ascii?Q?O40kwSLf32mBkkeDeo2zDPpwg86tIdZmtp1gVAqHS+8vE42E9nUdhFO1NVoT?=
 =?us-ascii?Q?zfRMQnzaPNHEE27ULH8tNyxunP7y6P4XazbNWI0+ClaO3NNKEDe9Qnkc6pml?=
 =?us-ascii?Q?gU40bxPLMVO4jhM+HpzZvslD2Md3QklHfvdvk48qmfvLfOKYPRTMdziR/CtY?=
 =?us-ascii?Q?CFU0Utl2NiB1LYFjrvpyNYMOTFgDgDP4wk0LH7eaon9x5BnF8wcJgGvYwhYm?=
 =?us-ascii?Q?RNRFA0jmQ7MdR2t0g0rquTid6WArBHyF8x4yNJL1Pwaxh07+7SR+XOoG8fV8?=
 =?us-ascii?Q?1J62dOt8wFrftQ+wprnsiWvtkragIdQwoOBl/++A4gr2dIWeCNhjkeIno2M7?=
 =?us-ascii?Q?+Uw7hxgszzpjFzj36Hiu+kw1Np8dphqoDsrlf40GrPHxFNlgB5bdRN5YhETI?=
 =?us-ascii?Q?lxMlYx7VaQPdsPtVGB43ghIex5zo4L1lQy2TFncYJ6t1x22OA/elxwoRJsKy?=
 =?us-ascii?Q?rG2EYczezHaByovNZ5UPP0PG4hjD5DAuVNx9BC6/uCcLCtUUgQIuQynrWjdO?=
 =?us-ascii?Q?tbp0G6DNpy4AhhfD3ARDXup+RbX+8CYJJSj7uObkjQy4TuodV5AuLtCWEv6n?=
 =?us-ascii?Q?YqaWO9f7MbG2gH65b/Nu6wtNecvtlrWAlnyGxmdrNWCoe1dyWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wePJJ6n/xKUR8bFs7ezbg51sogjdypBf25vBD68EQ+46UwXzoy2LYl/dPPX1?=
 =?us-ascii?Q?ga6esIClMNjeHfOq8lU7zJwQ+of0hwCF4vAY196CCnU0RljRaUxb6SSmdzHl?=
 =?us-ascii?Q?loL+2dUWBVChKewG27OFipJ/UbkpSL8VScRZXBaqUkVOl7QYSUKS4yNeOeKO?=
 =?us-ascii?Q?n7DK+zBwwr8C7u6FwrA3LHEILP5mVYHngNi24RicuV/0F63J//SJSMpuSz5Z?=
 =?us-ascii?Q?0HOVtygqsIPJqFRdOfsYr6V6sKnYSkeb23hSOJsx6p/1xhZTpGVLawhO44Nm?=
 =?us-ascii?Q?TYRDcuHRwu0miaWUQtMGOFAYkmbNZ3CEFuLDkXv4Ku9THxhzgckRv7Jx4Ds2?=
 =?us-ascii?Q?xXKA99rGMYHpJ/iZfwa3ShBwCIF7yX0T04XM2Euw42uuFQzqbypNQWaUwWkS?=
 =?us-ascii?Q?bhd1SkRNcMjbtAmgJ3zXVPZx1U2ajlmd5Gwa9Inz3Q5VVON6S7crqtQgs5Yw?=
 =?us-ascii?Q?FmvCncOKg5IX6ZP7WQR51y+vfK1DYUHUViRBsIRTvB8zlrJdXjCjb9D63cVS?=
 =?us-ascii?Q?/9HfTrZQe+bcJrJkA5U/4sZzAQ2PXmOJHHHxNaQwLJLaO7/aM4AMFt0Q0t7c?=
 =?us-ascii?Q?1rMti98ko45bFgellY4cH9ipsHhs0vtz1dI7WnH6kBwvX/Ecc6f6QgSN5Ena?=
 =?us-ascii?Q?+rNPrapEmrUWKtJaKMbPdRk/6peOS3vupykHwHscdeEUWc/JteGwrYoDm8hK?=
 =?us-ascii?Q?UNLmF+IoqyLdAOhXMRgbmZ3Iwn8S2boqYhAm6vOKbnBnja5VRQ3nqn9yonSV?=
 =?us-ascii?Q?UDYSfBqpBzANep6SHFCfN4D7S3Oj+WeZoRBlhRybIBfqoeccEcQxpqvpK2xv?=
 =?us-ascii?Q?9KKNPK/zEIZGDWh/s/dwkzYqiqW+6z3MoMc5qHG/28oXjKH0ywNM5ZKMuTH7?=
 =?us-ascii?Q?YLZhkkrkqlvfLnsJ1NSHWmglPmHo1U8bz3y0d/jzuhxi7vaVEpVg3kt6jaHv?=
 =?us-ascii?Q?yqVFhPAVnxqqfh3ojvYaRxun2Aq3Q+1lv0U+ug0U3HnzrG0W+5ArI0Zgx+5m?=
 =?us-ascii?Q?gGa7zAUOrOaHQZrBoEYSq8rE52WiP/Z5Lvo11hwJzpWwgCtEghteEKZ3cDLw?=
 =?us-ascii?Q?nhelNafinhjLq2UQihLr+2B3pOuWNzA/6kjw56u3EzPp/a99f0v9CAF4DPh5?=
 =?us-ascii?Q?W0dR34WGUl5gxU6NjAFlKyB6osIK1Y1tdZ8wvtS2orIDUda8/8Rpqnr6J49N?=
 =?us-ascii?Q?vW4gloGTnrsGT5bup57P3u/R1S8aSYeyhegrY7ssh6shxtWGz+Jiuxl6THwA?=
 =?us-ascii?Q?MAgaQfgYPLNjUXHyz40eDKtwlNjda0jfgznC04WrPmp1UJOPxNIdpBCL1w4C?=
 =?us-ascii?Q?1VMi8lWdAj43p0XJl6K6HXKgorwguhri7PdBWIddFE/ZU6uFrwPorSGuQrOi?=
 =?us-ascii?Q?+1N5gvKmcsCqam4DX/VM8Vm4/geSaFypkmwibKG5jRlCZbvh+uBvLEBC+G4N?=
 =?us-ascii?Q?32/wWG1EBN+l2ReuGIGa+ypZATPxZcToBZHCfJ/Udk7MDiijYx/NpQV08Euq?=
 =?us-ascii?Q?8K7xajee3Z7AQSp0XlRUnsjIO3WeUNiA4fVFzhXcJmLMjv3cZnuWumUMO8o5?=
 =?us-ascii?Q?SHdZ/pRz3mtPx/QXGhHIY78S/vux5jDv6zs750rP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b1a3af-8410-4627-466a-08dd15e90b25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 11:28:01.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5mHVhLHSMIRs9cEoh4rGrqYkBJkEpmK+a6Cg8gB6+RmQjFSNP4W0b9WR3QySUCxDZO7qxzynjp+Q0spv8wqKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223

From: Peng Fan <peng.fan@nxp.com>

The gpcv2 drivers on imx8m series are registered as platform
devices and this opens the possibility of reloading the driver
at runtime.

But this doesn't actually work. There are some hardware sequence
dependecy between blk ctrl and gpc, also power domains are used
by other peripherals, so fix this by explicitly suppressing bind
attrs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/gpcv2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index e67ecf99ef84..4db4d666f5bf 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1437,6 +1437,7 @@ static struct platform_driver imx_pgc_domain_driver = {
 	.driver = {
 		.name = "imx-pgc",
 		.pm = &imx_pgc_domain_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 	.probe    = imx_pgc_domain_probe,
 	.remove = imx_pgc_domain_remove,
@@ -1549,6 +1550,7 @@ static struct platform_driver imx_gpc_driver = {
 	.driver = {
 		.name = "imx-gpcv2",
 		.of_match_table = imx_gpcv2_dt_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe = imx_gpcv2_probe,
 };
-- 
2.37.1


