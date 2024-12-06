Return-Path: <linux-pm+bounces-18687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077FA9E6D69
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67828159E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F041FECC1;
	Fri,  6 Dec 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IoTdWLwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557F1FA246;
	Fri,  6 Dec 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484484; cv=fail; b=J/H9tSwZVRP/GPUjhPtRGcIaO0pE9Gkkjwz1l2Ilwnuw0UaTSbIF0bOUEBvld76fpmchywNNOQy20RmetLkExAZccSrKBW9ChXbEmMAmnsOucS8pMXr1d1PjHoZeaIdg73/llDxoouEMaWdWkrAH+FQahHY/fq58eetOhveNSjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484484; c=relaxed/simple;
	bh=joqtT5t0k+vLndn//ck62T3DDsqnsXjxofADUyVBM/U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ibO7MMcyKZHl0RqmrfeSkVyX1JgUKEkNs8zN0uIwhgxM+Q5tUks7QHmy9BM3qWIu71ZWDwWa3AZdSmo+T/p5bswy5l1oeKR0ox7Dbut3XCTjgkMLs668Ii4R4SbVbNfY/HSZft8Vx9lXfh41ewn8B1Zd4ooqGiesxQ5/o9L8QBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IoTdWLwL; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2Wo+SNPETk2Y4c/trpcqYweVka+wWvuB/ABaaHortDCi0baujEbKkvnfv+Q73YFoVmD2xJndcJBlXk4RCwWoSSf/VGjzv2MZAOOKPFMptMm5dMbAobD3Ug0nhV7YvKLSBpoSGqHXZRMjtm+6pmftdPkiejMpn7v9U6VICxDBBotsgshLqgv1WrlgF8mZBoO18rD91vPmckEhrKmtqE4513AJjHh05v4GZG8y1+HdFo5Dp92BqGEllfV8vdlCNS0QUj1+HEPI22qubpEvfsSwO50Pc8IvbwwaSp30zWrFhwoPnUrBFaBWv5iBcF+jBeY4RGB53n6l6/mFnNkIiBm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7bLd5Br38YlumLf2aHqq/uFs355cLR87xVOfwcZYiY=;
 b=y8VKPLnSHw+NEaeOcTMKsZc8VwYeYB8JrrM7QdJliuzvd45/6V7f7W49/QDK+E1IH7c2DnhvusOrN+aDXdy1/NpIzz4RPvu3E91KZ4TbbTZ2/IjVFcD+xFIb5jjsMX1KH48gel286l/wIpqLKop3Lakc+Aj/SWItujw61V0KJ3LuDHyKwY3qwOIvebFtLqT0T2nXAcAwWDeQAh7VcjBhNinKqWdZaozKpSEMlCviCuhPGEdgzkcjv/ezx0H8y5yijrz752ilnMEjJNtTbfm2kUF0awBvQaVey2SuWLn4RwT8Or2wCeKyx+uA+2+NwhCs1dOAFFJdkkacUiTLZKjo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7bLd5Br38YlumLf2aHqq/uFs355cLR87xVOfwcZYiY=;
 b=IoTdWLwL11S8FMHE01iEIqsQM18+sIAdWEWmT2fQIRR8IyascE6A70ErJH5XSoszC97Te/VJJB6I4+HN2DzxEZsTOYbF4mM7ElCXAPoRXtuHRbuI397Yf0vrt3u3Zmzk4fLKxanVebsaFL1Kd+vYA3525UEy3m/cOpN/+gGbMMw4Ce2YTH1wFkdD8D55gaLp1fRLonFbfpzse0c8cSGt0WucxFDzBq0InS/sVfrjVKDGmXEsvnDE0W8kS6riOBRo69MTOUuXSmuhhLF3l5hnF+neX3bwu4ep5exzVnnt5xbK0uSsmGwJ5MPc60hUm+6ibssQNEyl0PygB0KQZpMYVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 11:27:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 11:27:58 +0000
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
Subject: [PATCH 1/2] pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs
Date: Fri,  6 Dec 2024 19:27:30 +0800
Message-Id: <20241206112731.98244-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-Office365-Filtering-Correlation-Id: d3e7efcf-3ec7-4e18-7f3a-08dd15e908f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0uY/Kc8FDmDdlkufwiZSprvmS7NaWYcM5cFdlAJNJWNxISuZGU2U+oFcADU?=
 =?us-ascii?Q?/TzQrCe8HoK9Ua6bcxJ3l4MBXPOQxzdfu+0Y72inpl3WfL+b4k3BtPEuG8um?=
 =?us-ascii?Q?awNxTcJouRyib/4DVbrJLzsTz/dfAZQwxBVv9PkbUUEIrHSNTCfqtKyYjpch?=
 =?us-ascii?Q?XCY7Mlfzh24m3xuWfNsVlEQpBfCisV0zbSS0hqS6plSmQQV/uw+dLsTnrgFL?=
 =?us-ascii?Q?8tt74pOgqIygTyaBPSBSv7vkmu7sMXWlJjYgayShs4t+ID1rBr3RS+/2ry0Q?=
 =?us-ascii?Q?V7xL77xeKRhW+nacmf65pfASnWg/x3m5neQh9+7BsQrD6JlrS6WAG+9LznyX?=
 =?us-ascii?Q?JGS3hBFY/m/RLtfWyWegnIzdbX6BV+91hNAZPCv9cnNjEPrH8VKf/M4TLw0W?=
 =?us-ascii?Q?0rgRgonLEUtjD/V+ib8RcPB6zids4UFeHyoXr4WBs1RH3asyGyFQ5El9xiey?=
 =?us-ascii?Q?X4/i+2ZLNXmfVE+Hpr6jljLz16y0bgneXlko6DGX5PNENHBLwUhxu7waPJ9+?=
 =?us-ascii?Q?aiirqNf8rEdxQKHzgQIwNHQGUqiKnzf19wnppBN6YQJ4uMeNXZfIFj76LSz5?=
 =?us-ascii?Q?BpM1sGYw6+d/6f15hGi5fJYvWvV/UfhNvPueKPE6Rxgv1hiqt9qQiDsfBENO?=
 =?us-ascii?Q?gcXX0hawtiaqolv7Q81l7/mqUcwueXKQ0kH8GMniAR4IafozPdktNpg6FZza?=
 =?us-ascii?Q?Fi5H7VcdBjmR+PcYb24b6ua6OnfV/d5aTqJLF7DI/fVdztCcoKeKGaS4OMk6?=
 =?us-ascii?Q?3dCq9LF7Oz/S8rhrQvhtdiFqNR5B6adB2ZDHZu8F47vZdSrBWOFV5lLEvong?=
 =?us-ascii?Q?rnErgvFBIj+C55Nq8e4jfShm9haq1jkGE8UQg/aYc4w8zgrLOQgVIqfGJsKq?=
 =?us-ascii?Q?icAJ8CF0KDGzZRaTx5e13PSOBOTyJWO/1+8wD+ASExlvTm9hv94397PK929z?=
 =?us-ascii?Q?3RYoSrMc2GFbEKN9ldb0/53PtwGR5/Fba5RQx9BtovIhwNI4mzQ4SB1v1+gq?=
 =?us-ascii?Q?5W50wBUUsnIzZxGFiQEF99Qu1WQ11sMfiId/+M4TimPurjRdT++FUVH7FEHy?=
 =?us-ascii?Q?QIC6vUF/svmGKrg3gSVxzWKBmsu09eOlyEZ/0DFUYLSslAi11eIWYAbUrEqX?=
 =?us-ascii?Q?GDuOAE931ujOKfw4vb91zn8sNSCSE3FGkVnDTJAeTOaLBUvNyRIQVlI1Ysp7?=
 =?us-ascii?Q?PRBSMqwotjW3uvHNjAbI9hNMwjvilNbZfQm1biXu/JBkbRK0drfmdlcNf5ml?=
 =?us-ascii?Q?CiTDy5x+nHgK2Fi9xND/gv4qdZMsNC07jNowiSgUWtwSQr1TrHPzaVUru5CY?=
 =?us-ascii?Q?mKCbM5neQvFOZbS3i3Ko07I/HkhZ0zaP/i2LbZEACmo9ZeqoC+kRBPjeS/Fh?=
 =?us-ascii?Q?fRO+vb+d0P+bnyWxoMZPNovYX+4aqHoboMl35lGVaAGPgBK3Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jwDkLvLDGoEOWMLz+hftZGUZSw5PKDqwl03KhprG8sqyG0tlWfYpPAPywPme?=
 =?us-ascii?Q?L6wUNrp/1iK6nRRgEIBX4jyLZG9We/xbLg1mTT2UuluH2kIwUie/6zpw6ALV?=
 =?us-ascii?Q?yok9vb5iKByAWC86YAOdHG4uPtIgH8mUSnFVmI7SG4RRcT+FS4Bq3nha2WG3?=
 =?us-ascii?Q?XtXkjYmoFDQ6Ze0fQuh51Ilfnz5cK7Dlbn7bKM3d6EBjiSjZsfglXikrcKeV?=
 =?us-ascii?Q?mAJW9THyp/t5q3fNG8Bv0Jua3vJc66NPNFstrYm3i8+KJPJmU77RI0HnQeK6?=
 =?us-ascii?Q?i/sOMsqTThJQoV2bn4C4lgBnB9Zd6ZU6HtJ4j1IWJ+nfoKpprZdbfcN4eQd3?=
 =?us-ascii?Q?mSMbuMsKp4O2yCV7zDPvN52/IO+rfIGUczSBiK7aHlWBYXfuQYmFVM5XeC3K?=
 =?us-ascii?Q?lPU7Z1lJnDdrOI7arGHRucP1kIDZ+xR6fEi0p3SKn70y/4PLCgSL8y9nbH8w?=
 =?us-ascii?Q?CNWLZKLopUoXlmWbWOhZDqpTPg5ExcyuCFanyVBetZ9reP7Xo0TzH+nN2LLv?=
 =?us-ascii?Q?axdvS5tQZQqGDHjh4vXFTpAlcV6yZjO/xtQYxFl8iFW7Q+NMKI05SADrTDQK?=
 =?us-ascii?Q?jEShr1XicE67HXwb7MPbMLiHIc6w0Vs5SGdPp+8S4XG+dNlZ/FdPdjKy+uA6?=
 =?us-ascii?Q?6RxL50yEIHZ8dn+clnZbGAES4LGg6vgBdq+Ge7rWR7oAlyRS71hDDiVydILK?=
 =?us-ascii?Q?BvBobzgChBzYQr5phk6/B3fqLfyuesEANImPGKfcqEuFO59Vonnk0uR4eECy?=
 =?us-ascii?Q?2ipag3H6yW3m/qouCLfcfxbhgV1ug3QRkRR3LVLOaC3d5BpwwlB6fcvHcMy6?=
 =?us-ascii?Q?J5YSpp6v+GuTHnMjnUP5yOMCPpyZZ59bWLMedILKg7SrAeIhb3B/ZdIcT5ZG?=
 =?us-ascii?Q?2y2V6krl8q51UoJFEXTe4mYgT0NcPfCPTF+wIK6zuX+k8IpCDXjAcp2q/Jna?=
 =?us-ascii?Q?RmfCq29u8OhDuDYjU+2CovtzVRtgIpudRjIShE2yej8a+1wTnBQWVVKY6GuW?=
 =?us-ascii?Q?OtBeaUNHyRxAf5Buey0xNpMomJfrS0Ux/WbWbftJbz5ibPPe8V/C7zAreUK9?=
 =?us-ascii?Q?2ktJ/QXBaxigcA1mFwywwQeK/oI6Gj8/BZPHZwHrJhvLH8/UcQ8/J0QjpRmv?=
 =?us-ascii?Q?q49xS5e3ZJ9p/HK5WnkuTNROU1oFECgGBWMJV4JsqXh3lUCTN25hdOFbb3Nt?=
 =?us-ascii?Q?Eu8NSN7xt2ZP2jexoVLYiX9Hzs0NLEvxvf7khiBthPoEHAjzraknD7Kxf8F0?=
 =?us-ascii?Q?xzw+ormSvccUi4qNTVwzFEVdv9gL6dJ/M507gGxg/hW590/I+efM9rpd8PiL?=
 =?us-ascii?Q?XM3V2gq4VPr3oWnvt5diidH5TqLSWtL/mtcrIhBW34PfyBxhEHxmtsCs74oV?=
 =?us-ascii?Q?fBluUxk5PPvf2RNk+gJAZPFROWx3jAN08BtrQmw+qn5sKgGgtgzTREirqV91?=
 =?us-ascii?Q?RnPTPsQH40VB79m9YFXzhdEckmdkMhS7zgatIpbbaohnJiiLJn1rQu646qir?=
 =?us-ascii?Q?gypSgC5BLmAGDW8a5fizUGnvl6ZQd3pxCnOhrK/8fsKCiPDj+mHKyUSq+tOP?=
 =?us-ascii?Q?6M8V0JA236TcmOKbrNToECX8/WH+KY8lwnuf/xlq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e7efcf-3ec7-4e18-7f3a-08dd15e908f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 11:27:58.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHM7j+sOL93Fc7N1S/CM8PWiT7xscAxgd1Ls1KydegGwxZlBcHBTWNlaDKnzTA1F2IfQnTS78jOpczoPrv+U9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223

From: Peng Fan <peng.fan@nxp.com>

The blk ctrl drivers on imx8m series are registered as platform
devices and this opens the possibility of reloading the driver
at runtime.

But this doesn't actually work. There are some hardware sequence
dependecy between blk ctrl and gpc, also power domains are used
by other peripherals, so fix this by explicitly suppressing bind
attrs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 23db85b7aa9e..912802b5215b 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -894,6 +894,7 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
 		.name = "imx8m-blk-ctrl",
 		.pm = &imx8m_blk_ctrl_pm_ops,
 		.of_match_table = imx8m_blk_ctrl_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(imx8m_blk_ctrl_driver);
diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index e3a0f64c144c..411dd548c67c 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -862,6 +862,7 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
 		.name = "imx8mp-blk-ctrl",
 		.pm = &imx8mp_blk_ctrl_pm_ops,
 		.of_match_table = imx8mp_blk_ctrl_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(imx8mp_blk_ctrl_driver);
-- 
2.37.1


