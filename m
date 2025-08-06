Return-Path: <linux-pm+bounces-32001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD8B1C536
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E71623068
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0228CF7A;
	Wed,  6 Aug 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQAP5RMz"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCE28A725;
	Wed,  6 Aug 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480603; cv=fail; b=GnQfRBWBXiFCKM7EQvfrzpGNzhuEh/0ezuXGO15yMxIIX9h8FyJ9t1nIDgSPpGLKgn10LCxJnJ+FcaYLMWpMAaMrWzSJMzW38ksifUCPEnf3J1R9XzsEhoViTmvWILTP5ZzmzKtP+4ZJmiiCDtXvpO3cm0aeqWQq1TLQ7LdcQjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480603; c=relaxed/simple;
	bh=T0jWh9Ezl1rJLBBf8n1WVDE6sA5tweFu0H5TZfnZEqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6h8Nutn84zeOF/j6/Y2VA9fJ2I9tmjChXEahIgHoXxtbpZ732ieqBnTvnR9jQbHxPA3MXOC20IAM3B7cs+o64HXbRBG4U6OaSyEaPaUuiaiqufyQKzh/kA56F8uThu6OX5rF/TGWFD/yTvHOkNr/Ilz5SSU1wotCa3Vs2UxWhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CQAP5RMz; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg5vkagEX96ewSJ71HUw7Bvb4r64E26JU1CiByic2NwHfkFJW5AcL12CE64/wNDud+ruHCpQ6QWMJJquBdDZg1BO/TG+nK4hTM2pUiUGXSLR89izbHjKWulDKt7AgYR4yKBMz7xnUmfozNRxEvnCxM39JM/AYLjFoKjLOuTC/eaqNVwLkGmiCgWeEEqt+QFbLC++AbIV0oyxJ4V4ebEQJaaHE3Rw8MyiOM19dGwPxTsGE2Og6jREn4ecmcUIYRhs1EKLjnkg+PqRCi7r8AxuDJlIh+lVTQpDnUGAzGG33d5qyFG9a2Fubh1zYO89TOT0W6ay44egBV7Z4KpaQS0yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aNSYtF2uvjol3WYU9sFsLReOVjrTOtuP20YY3PLcyo=;
 b=r+08VT8nmjJaIkND5CISgZpZAtOPN74GwNsVhIWA8tkDV1lXQs/eXKJRzsehyZhUwToM+0pVs1jSW8I2DsjSYr94+5PKBwpgWD9rcmr9H/A5yXcpuVCt3/8N0Fgq0umQ4VzBBLx6tmB1yhXJAbwa+ebqz1XhZoE4FKyiokeo2OmbGUdIChyblz6WHyIwNPhG2Q8//z680J7Y6akeVbiqGqN1TdRIN39IbLF1zFeZEyJ9IjRs7yEDKNrGzEVOrSyYc3tXW7VDh6vWd2gYHT1hy5PUQo9TqJqUKy5o6Ga/15kfONDSEz2OODAs0vRGE1pBtfzf3ds6LDEScgUt++yibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aNSYtF2uvjol3WYU9sFsLReOVjrTOtuP20YY3PLcyo=;
 b=CQAP5RMzxXy4o6N/SUPy+DH36uz0aA8jGrVbLbkHIRQELfe9topIcrG0s97gE6x3BYK12SN3iKdTb1JBRMPwiAq64np9xxzGz4ydLUKuuXR7y8j/hZseZkFLd4xNr5x4Axa06Q3ucvD7YAOo9rtQcFw8/jMOL11EgASSc+VjiU8XYCU0qItx5UV6vTDJ8NdMPbQskyEWnmcD+bLxyyeSLcE776c+nx/C/SIkWTLP1YlS58Z+5/Y0Qw/oOfC+lgkHS0KjndDLDC/Nu+8gwAkUvKhSSlrG0q6sKFqExW/YDdxyU4DnmYcutRyFJdl8WFuGzKEUeoZMab83hi9vAfRwTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 6 Aug
 2025 11:43:16 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:43:16 +0000
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
Subject: [PATCH v8 06/11] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
Date: Wed,  6 Aug 2025 19:41:14 +0800
Message-Id: <20250806114119.1948624-7-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27a20f57-2cee-4cd0-a185-08ddd4de6e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBV3SnYe5td3r1Gr2U1BZD6b+rkS/yNGmxPovKCHrgVMhEZsvkt5wpnoz95b?=
 =?us-ascii?Q?JXZMn6SSFr9zpKnbaNXiRbhtrJPOms0ebZD2kIKzeLK832As/VXrlfYYKmQh?=
 =?us-ascii?Q?c0ltjf+4/JAlUSM9jqq6v16SkDARJ7UvKDeIecwUNvdyqfiV/3+ImfJwRWv4?=
 =?us-ascii?Q?d+Fru2mKClYLPcyZGjnloB+4L0eIWmCe7BxXv3OqGOjcQYlqBDqDv/CzDxNX?=
 =?us-ascii?Q?aHcTJbZdGRfRnqzlT0n1hOpXsOFPBGRjCpuh03eDeqS4Yd9BR/HsCh/maZyP?=
 =?us-ascii?Q?12TkQ35cImUN25unYs+n3lNQ8nTOZbM8oQBK1k+no4A0nDojkkJV/JXznM1L?=
 =?us-ascii?Q?iKxwkoth4tswZK5K1e8FYuT1+gnJDHwVwp8AxWb0FX6vP6ROM5p6EE4ytYtu?=
 =?us-ascii?Q?urnlvr3XBFoKTZdyuzfo3BTkBAED4mErkQiE3ZQ/wORpylcqUKWwhQ2j2MLF?=
 =?us-ascii?Q?Pg1kM8qAUtRbMoZw+biFT0JO3NTZfS5EcOzwiECENO+5YDuxbA+qS1Os0YCK?=
 =?us-ascii?Q?oPoTEH7nBvj5Ka1SC6lp2/2JCjPW89faiYTbrnOZmMlgfnEJ96+s6wrloufl?=
 =?us-ascii?Q?CFY5c4uXPKw+qV1E9Any/edlkbgE2p6t8D7STqqcT/3yhS5mIKFHwYpTfDvV?=
 =?us-ascii?Q?RvOvWPMu0nWqp5Yb2JTm1hIK2lwsTrUWGvxXHqbwsC+L9V/zkf3o10OSu+BZ?=
 =?us-ascii?Q?NQP0PmA6JLTJWBbFmmu4EbjdwNAxovkjdfID9EEm3RUdptCVNtAo8OQo3Zsn?=
 =?us-ascii?Q?yZNXOpp9iHYikbIDFekI9Wy9Gxo5XbDM3m0M1hmBunNNrGpMQFnmIKBdPhiJ?=
 =?us-ascii?Q?VpAmZcKRd1Nwj+s5s6ZJBorR9j2u3Lu4d94VjY6Xn+iquus7wFLIPTv8p/p2?=
 =?us-ascii?Q?0rjc/LKD52OM9Q0asfYS45TZhRg6Nii6oBN/x7CAOe83UwkZcZhyRsFla5Sd?=
 =?us-ascii?Q?0B+ABFDp1SmjDUV3lTvulPF8UOLU7vG4XGD1sDxNbeeOiHabAzjRV47hlvC6?=
 =?us-ascii?Q?7VIVIKV973EbIByb23QIhOxP+otOYCaloJguOK8P7vMW+bIwF8zG3NYVebmd?=
 =?us-ascii?Q?LZ522K/kO2i6hPVu6st8N2VD7cHEzi9+d5rl6od3zfHj3SK9akPwl4fX9LIK?=
 =?us-ascii?Q?pEDhrVGmr4riHn64+i8Oevqbpmx+4+YZa9SwlErObS/Lijn0oGhuLOyIolVD?=
 =?us-ascii?Q?/1CKwlIcKKKdzWDP4jZfoDcwj9vNmCRiqSqUw2nrwajFJfqjmCtOfCnLeDgh?=
 =?us-ascii?Q?fPdQjCf9QZNhqWEdgiinbMTIxWt2bbV17A5sSXZBZ7JWpMSRCLTfwXitofbZ?=
 =?us-ascii?Q?EdC02LQRaakW7YgZmtzlQ/KgOppdQXBV2pq61+asm5iA+ZGXgqXDg7EjyHHZ?=
 =?us-ascii?Q?ukVI/0ccp5dbv9oWqnvrwUWV92wwZIhYpWQVKncuPHp/yKKs5qxBQec7ghXc?=
 =?us-ascii?Q?gnDL/1WjfE04hluUVHA2eUxkNpvY/o8Wyju8AN82tdWeas4G8L4YIQkAQ8nm?=
 =?us-ascii?Q?yk2hQxjXTTCQ3aM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMnFzmNtAWXucq0/9tmIbap8zVn5olW6ikO8cX91JO7DDGPyLsl77wvn78S8?=
 =?us-ascii?Q?6PCnj70++SLNdDJbKsq76z+VLITgZIXM9Fszx74d7y8oJHi43Y/TWuJC4QQC?=
 =?us-ascii?Q?kCPLUlHHQ0i1hp7lN/YzSFzXatKMh7DzV6w+7Mi+MLNA1g1Zad06Tq2HKtTh?=
 =?us-ascii?Q?XCscBQMO6Fy4VA7DMUifL43hFH+Pu6hE+HO3NofHwVCtbzf327aGbV3FB9mb?=
 =?us-ascii?Q?xqu3RJanmuiXLSF4irwyKxg1USWF1OnVryZEiLqHZumzTvs4occhHUaUVkRF?=
 =?us-ascii?Q?mF8/q3lh2oRm1tfvKuPybV9NUrs9Vwb6tyAo7HLIcbWFHdPVRQDytnYWuqFB?=
 =?us-ascii?Q?z+f3l06fGgEmr/JfMVawL7vL7yz4WJGS0GUF4YfsI9PREVjIrcO5B6bbrUFo?=
 =?us-ascii?Q?aDSFzJRPK9s28FkAKFDF7i/Dtah8TWtNlFLPCIoSGMskmtFYVpJE7lflV9vH?=
 =?us-ascii?Q?wXPTa0oDxCqfwmC24FJPAUQnFspJEq/RR39F0m+KUxKaXAm8siUN308Dnrpw?=
 =?us-ascii?Q?2rufFxKIxgxB28Bl7lDpUzB/JRhZB+uw4p8E0ciQ/1Z8uuD+gQ4ANk4S/fhy?=
 =?us-ascii?Q?Zxqc+jRmgemZudsWxpolwt4EItlODHTjukYXOMTRLFZQ1eHMTuToE4ERbRBy?=
 =?us-ascii?Q?SeAghlUTSI7o1q6Q/+vWlWz1rcBxHjxftOVBtTkaieYY5gOsgDk4Le7PRAZp?=
 =?us-ascii?Q?RO1IZl1GkqQCwh+Jkzqsyj/JrnFyszn90j7D9U8pm6b9BMUSniQVdJzMeOqT?=
 =?us-ascii?Q?djjUDwXwBcffpx5GUdLoPdCzfV68BC/EjOTaY6oDbIIKDYjpp4wAoU+Ac2HZ?=
 =?us-ascii?Q?iB5o4A+1e9Kw1WYkJFng1z8Alf6FtaMUIPoydcO7CfcbSKzCRdKUjEsUsIRS?=
 =?us-ascii?Q?nqTbQrnwCV4V9OrDwoDeJ1aNEPza4gMk/VJyAj9PtmDVnLXETuB/ORddyduP?=
 =?us-ascii?Q?x+tb+cN0WF9N5ork6AL/rRdmcbagAB1TTYoRu+a2cSr/bF1tTi1H8VRjiCDy?=
 =?us-ascii?Q?9YjLIL890i3tspuDj5MgmjLFpklsFu7jw27SDmhFUkxDtdbmmctAjepdWUNo?=
 =?us-ascii?Q?PuIGMPyAgO+ZoXMMHmB5N9kwWf9YR2Vaecz66H9XYSfErZhpTRSfwwi9+oZa?=
 =?us-ascii?Q?rO6GO2W4EkFHNgfZPDf8vZlmQhroPv/W0RD+AfSfsptvhyvKkDJt+hbtq51e?=
 =?us-ascii?Q?3QDX9wZStAaLjwKuOr8LDtWC8sHJ1D3r4RiariHVclbwUvgdEw+v2B6TyMxV?=
 =?us-ascii?Q?Wydq9epXMnJGPD3cEuF9zHBdEgnrAj8rUuiG1/qhIZE5iL8N37BnzHXMuSNf?=
 =?us-ascii?Q?C5IYN1r6ugfHYibsyLP+p0TR7IJ+chdedz3A8Pjr3qZ7igt/rc7BnLOt/GdE?=
 =?us-ascii?Q?GJU+UOupYkaM40eSBNNcGuLCn5qNfChHscak9/phGGfdH2pDt8MosAPfsmBE?=
 =?us-ascii?Q?evnIp8JnLh+e+8l4wGfKmqhcgmPzKf+69nhY6uRNX/o6Y7T5jncz1ihtgPCh?=
 =?us-ascii?Q?hldy2UXDLNQlrdFJNuUxjo24rvpUWmQyTCunRa7yzkHQ/BOz+jqR6/xmDn31?=
 =?us-ascii?Q?SmL2qWEPNPH+2UtVHkTV4EwTGYdiNz4fATtuP1Jj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a20f57-2cee-4cd0-a185-08ddd4de6e6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:43:16.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ata0CMJusL4EgQS7Iw9sq/G5m2Y4WsWz1wi0zCR2+ycICRPC+kknWRLuPIVjhf+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v8:
1. move imx91 before imx93 in Makefile.

Changes for v7:
1. remove this unused comments, there are not imx91-11x11-evk-i3c.dts.
2. align all pinctrl value to the same column.
3. add aliases because remove aliases from common dtsi.
4. The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
   links as a workaround for PTP sync issues on older i.MX6 platforms.
   Remove it since the i.MX91 have not such issue.

Changes for v6:
1. remove unused regulators and pinctrl settings.

Changes for v5:
1. change node name codec and lsm6dsm into common name audio-codec and
   inertial-meter, and add BT compatible string.

Changes for v4:
1. remove pmic node unused newline.
2. delete the tcpc@50 status property.
3. align pad hex values.

Changes for v3:
1. format imx91-11x11-evk.dts with the dt-format tool.
2. add lpi2c1 node.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 674 ++++++++++++++++++
 2 files changed, 675 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..31916ed8e015 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -314,6 +314,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek-pcie-ep.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..aca78768dbd4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,674 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+	model = "NXP i.MX91 11X11 EVK board";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref_1v8";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-pwr";
+		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&fec {
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	pinctrl-names = "default", "sleep";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	audio_codec: wm8962@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
+	inertial-meter@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio3>;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2237500>;
+				regulator-min-microvolt = <650000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK4";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK5";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK6";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1600000>;
+				regulator-name = "LDO1";
+			};
+
+			ldo4: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "LDO4";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#pwm-cells = <3>;
+		gpio-reserved-ranges = <5 1>;
+
+		exp-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		status = "okay";
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+		status = "okay";
+	};
+};
+
+&lpuart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC                           0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO                         0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                     0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                     0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                     0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                     0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                     0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL               0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                     0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                     0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                     0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                     0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                     0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL               0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14                          0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24                          0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25                          0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26                          0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27                          0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23                          0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                       0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19                          0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18                          0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17                          0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16                          0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21                          0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                       0x51e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL                           0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA                           0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL                           0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA                           0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA                          0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL                          0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27                          0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7                         0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX                          0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX                          0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                   0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX                            0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                   0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                  0x31e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x15fe
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x1582
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1                             0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2                             0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3                           0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4                           0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5                           0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6                           0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19                        0x51e
+		>;
+	};
+
+};
-- 
2.37.1


