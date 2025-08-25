Return-Path: <linux-pm+bounces-33003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195FB33A62
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F521B221A7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86D2D061A;
	Mon, 25 Aug 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUt4DG25"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323C2C0F7A;
	Mon, 25 Aug 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113235; cv=fail; b=rlD9TO/RVVrhuqq+Ox64dK4FxwJNkmpdZkAlwNfawlYkkTxivl7nseZyHRLaG7bBxkmZGId2ZZFU9d0qv8McfwQXp8cRUdXaq3Ib+/Ho9udg+Cp1/k8Od/ROgfZFi1i3/7/fgwkt6rmTXutjxq/UpE3qwnT+UUQ6s+abf5QoEAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113235; c=relaxed/simple;
	bh=pEp/M+xoGOaQF6jBkO/OoYf3CX3cUlTB8yqFvVjMYs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S31ATim8JlKjug0Sg+FHJk8JrvxU87ANOgTZaqEA/TAYle8iXoKvvjSUG5KPZaXP0mkqpZw/ohinYvFI+7yb4BtbJl06GuGalKa+QsHoMuOUWi9ylEWBskeRrjCXU3DAb4MadQD3uj8jZYuJZ+Ui6gm3Siy4YLKzfbMIjTCt0sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hUt4DG25; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohzMFADwurV4TVK8VWUpHO8oPT1PUxLLbg1UN11faC4CC+dIAeDrcI4UFpvkj9VEcbsI1tv2jpGAvR9MOfKXo13kT8+ShNMdHE3qbBdUUdRHiYPRNddzKpbR+ImbRoFBtZYfT883n3SxUBt1oyJNJTFSPHgj4p5OZlNFJvniDfuGVPduxGlKrBhTzcx2LTzjE1cU5UATM0cRJQKLnvh2535/j15OkmyaHLxt9Q+igZLyhaNqh+kxa0S3I5SlJiUkXBgLuOCsYGsObw+IkSz6XT/be82UFcfgQew3ggL8ibQMXUDW4xsj56jfTZTbRGpWiq3Y6BhFbVDhqzOGoVmwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkOFyUR4mqFX+Rk47bdNRZT43oBYB+atg3HoIYZ+6cM=;
 b=ZtIT/xS7YqdGmyXRxM5t7LzsGs8ka+NYLlSSSnOKVPM/1D1WPkr90bsuH/EEPhAyD4XJMep0wTsGMzlvRKYfxGZXKvxBBYrH3KVPEfvBNtJ2uo8gFw2XX6YnYnBoShJE7A1d216l8PRH50CfuhF5dAECRWP8d8QAF3sgbCJSK0Thv0gVtgX8TZny5QnQLfArrVPfxv8RDORgyzJkiZ2Ht39Jar2SEWiwnh0KS3jmMdG6NWa0EpgHXqpIm0Sfpn6q8rRwgiAhgocCNYDRli0HRQ1thh5V/nwaZJ8Mz1Z8yPS7sR8duJbrDo/b42OepqtoKxzrnICLyfE5n5rbgKWefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkOFyUR4mqFX+Rk47bdNRZT43oBYB+atg3HoIYZ+6cM=;
 b=hUt4DG25hp4pylpWJMxXCU5f4NKlc7fSbRxsmWK6+EjguRNwi0SwoaM4z/L7V3e1SgZ2+wmORa5C2eC5eXnaKtkPzgwVEAQboG4mmKeB4xU39Zs1BA4sqLlwhcvs1ZaXd2us7pgYd3SwmtPmLOGyCcFwid/Mp2qWKZZabntD9KSBAfDpBw/azwFamtIfs3yfkWPPmKT2HQFikJywWRqoe+HUiMvKPQ6B3clMitujvke+wkTSEPeY3STxep4vv+Yj+hRpREon19STSFiUyBFSJxfoOpf792cCfD/uPXv60lwBWZ0IM84eTpn4fBNMkweVQr/x6lzMuuLOOMNsmhho3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB11264.eurprd04.prod.outlook.com (2603:10a6:102:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:13:49 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:13:48 +0000
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
Subject: [PATCH v9 4/6] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
Date: Mon, 25 Aug 2025 17:12:21 +0800
Message-Id: <20250825091223.1378137-5-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1184ed01-ac3f-4964-cb0e-08dde3b7b357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0YR2takleQkL2rq4EpCDM7G9ToagnP6ZD7fqMIAS31+w8l6pHKzp1OMcoU3?=
 =?us-ascii?Q?sT6/0QW7WvP3CM+yqHBMBg3a7KZCM8FZEIKjvirrQH42mWNnCFH86HV/DMto?=
 =?us-ascii?Q?vKHANp7DkC1wDOUsaYXMP6RDOXG0PTY+HJtLWO6TLwxQDeEfMz3RbWgNi2l8?=
 =?us-ascii?Q?56vqsnxRfxdasfWjjEVutpZQpjhWUhoYIyqkI+1PDbuhkILNq0xIAOmfvcBS?=
 =?us-ascii?Q?bxpo6o27G9/UJHtFabnS9CG8WYD3xVLMnXL6CYgdmItMEYc4aEN9mm4icn+r?=
 =?us-ascii?Q?RAob4g/eH/tL8FbY+YcQAoRiMMV1BFDyQSwVAphLowB5JiWnW/Ia6L61OOw2?=
 =?us-ascii?Q?VidGB+vtGAq5TFnZ3HEdt+VXDvTVwK4d54FrJGc3LAFMGMDBNsFy2X4A5ojN?=
 =?us-ascii?Q?nj5dnG7pigO/+qSx+MLBPpiMwW76QllGPUHv+dc7b4VYHUv8Jyt2CslQoQtI?=
 =?us-ascii?Q?GkopTVCBpRwhSowsrR4pIXB8c0AfpGXxW7Ahuq0hy5phxgWBaizUuLnUdpnJ?=
 =?us-ascii?Q?cgBaRK3YBKiYYmy9vEsDm/44M5MwpLQl6K2kB7pHPOoEaYOQIjXHONcvc2V0?=
 =?us-ascii?Q?eQjU0eNKytccnHXDBkakd/ZQYS8A7mwuYwLeCuv3vjauhbe4LpDtMVV3fmlM?=
 =?us-ascii?Q?gXuEfTnlIV0E1GvyacntgGilXT65DioS+Zxz2+fVdfFzySUb+b5d8+gfWK/1?=
 =?us-ascii?Q?oRsvN8v84ROLwHgBtWhnxMC9jYvKOFuoWEBPzXeZ7lnv6XE/qGY8j9Jb6TgF?=
 =?us-ascii?Q?BfiQTLJsFAu6n4lWE8z3AC3yaBYDi023WQBrDhTcuJ8K88j+ztGANHPDP2q+?=
 =?us-ascii?Q?liGRUemZF9fcyP5zi5xDZVIytoYh1nbvcL7PTVFgaHuw2fthXySkFgdI/e34?=
 =?us-ascii?Q?IAYvtltvTeCfqhss8t7rQHFbTbzvr+w8C37zjY/4j+vlqgm/0TemwgWlL+eJ?=
 =?us-ascii?Q?7MDyyI6a68W387Choa/4uDD9g5NZV/87kuRe8ciTV/elD1fAI32rNe7W6dNo?=
 =?us-ascii?Q?oYSIeoXMZI+SiXMczzNKl///+o8d5LPTJbdOAko8oGtxlk6T3r0eNRkvSHp/?=
 =?us-ascii?Q?gsC9OsrGt9H3+ZgfABADi2lNTgdaTegn1av80yMzWPYx09Wh5DclJCSWp1h6?=
 =?us-ascii?Q?xpuuAGpHKD3sMkK+YQd3fTWJ0+B43FdcYPRj00EJrnI871AVKdCAf3r4LNQE?=
 =?us-ascii?Q?AacMVUsyFow6WLY5Itvoes+Uvp2sPDS+IRrwtdJrx5Ho7zvXUm17RpQYpc9U?=
 =?us-ascii?Q?ALdAyWQ3oma3EjBzBgJ7/ZU0etk69tg1lqLX9OJ7PdC9xOUufejTwWmq07zA?=
 =?us-ascii?Q?WqjhM+zrn8yJp1uYhSB5bPyubxsqXMRdmkvWAyMkEy3AOXBH6e+yYW/qcovO?=
 =?us-ascii?Q?WDtTeRfR2a+p/MEZIMJVSRcoekCufjYq7XLmIm9zb/PwtDkmGQE096SD04Sc?=
 =?us-ascii?Q?NimJkISDraZHtKWYx1jUo3nGPXS7knzrqYYjuqa6FB8dmzClS/U+sKj+wwIG?=
 =?us-ascii?Q?lP8PyRVTnKdLdzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxO+EyglqFIHXF5WmsOXOunQ1Qyu0dR8ZmeNAB7lPe8PLO+JT7kYjWEfs7o9?=
 =?us-ascii?Q?LAyHgoGN6KYCn23WhD6g3TsQkjMgp0af4OrAcA4hU0T3RahPcGGrdUXZIa54?=
 =?us-ascii?Q?BmxjlkTjFxE5txvQTIRu6775sr9fmLLf5cdbq7hDldiatVgfA9B/5TI+En1h?=
 =?us-ascii?Q?udogycdGIuRaOeIwuuAJ5mcFQpmWT45zKNNQRQkPhy1tj1qta0FZCpILP11M?=
 =?us-ascii?Q?JRDSceMxSMsE8gohp8tK5zBPzROR/TEvSbo27YOTAdddc2BVPKu870QkMkxV?=
 =?us-ascii?Q?ZDwobwnpLtgHpGMxUeEftL5SzJ4TRC/nK84ZnfJdv0p+Pji3JzJC+EAvRtup?=
 =?us-ascii?Q?wUroQSeHc1BCRZ9Vfx4/sZgHHvvRjLSruD0LCjk8E9kPEK8zD35YC7dzkdLT?=
 =?us-ascii?Q?faAPTfi9vKjiSYzFNztu+Z5ENJRHSKWS7yL2yOapx71ghG3i/iQp2Ucfvdwu?=
 =?us-ascii?Q?EWDH701uZs9Y8SeEENtHE3zdDp2z0S0mW8dJouEvX7oTTua0oRZTltdMA1PK?=
 =?us-ascii?Q?dyr5PmB3lUgEHsPIpxVonhfExM7+OzAdirEcE+RHDY+ptHs/s1GhAGurLFpv?=
 =?us-ascii?Q?OIFXDq9550KMxA9ZUTsWYFpfDq+9TqbvJ13b1mQwJ2olupC+iiqZwf37/5iz?=
 =?us-ascii?Q?TqHuE/imQUYtzbh+N59ABlbVQcW7FxkiH0BsUAB68mry18gAMnY0/dFhGdBn?=
 =?us-ascii?Q?LqC/AU0XWy9uSvJdhmuJYGOBsNntd6xViZKsndLs1aO0X1SDbpgoBbg9aTa2?=
 =?us-ascii?Q?6Jv5xtqG78vPsB/mst9K2qLgtWYebl9PQ57pKyr/mV7AUbMsaWXwCl2izczg?=
 =?us-ascii?Q?v17WrKMwBb5uAJ3mY/j+vSugk7181plMnU5x3VoKYlW/1hr55AV366p3AH6S?=
 =?us-ascii?Q?ZrZCV+uuh+8Fu3/KQuyTWFZOfIWGtzierPZfB+Uximhv8BYizynBLk7MtBng?=
 =?us-ascii?Q?8cTy5uHWL3Z7zEtb8OsB3Aa4QCJsq/Q4e15c0S1+Eg3DwACz+kc7pkPzRUgw?=
 =?us-ascii?Q?kS7A6b5FvGe8xM7sfQg3CouqIEzPTpi+slshKWtpZYkWgCap46Rozkqtsj4E?=
 =?us-ascii?Q?BdCQAqI+6/rihvNoTYKlUGs+LywdZaZxhHs06Z4W2Gmh+oo2/Oj2NUdGRaGO?=
 =?us-ascii?Q?LxjZ1V5RTlXBlwByrPum2DdiE/TIhv7nkz5gmWJtjFuu6PB0my4cDrjbXCLT?=
 =?us-ascii?Q?zVa+K8dOf0lXeTVacjCBzrtXwXz+T1nHFRS0mPdiAWcqWdNa1SnNWaJPzCAZ?=
 =?us-ascii?Q?In4bSebXK2V7aEXytok6QYNpovCvvb33j/Q22meVDH3wfA8JuxOoh5c11xT9?=
 =?us-ascii?Q?wAW6WgXi01i56gv0k9L9vNcmeQ5XGWtldFkM3V/TOIMBRMIyXEXmgKrltyNk?=
 =?us-ascii?Q?av6leZcjrWfUiah7m9gAbQ8qYZPCV1kbf6Ge/lhbPaUppl+o/QARuPTFAJLM?=
 =?us-ascii?Q?vTUeVVGRA7Ir9/yyWanPv/YKvjD2kDUfvooR+AwRjibZNqsc4vXTCkECkB4G?=
 =?us-ascii?Q?jBvXDl+HDvWd07Je6Xm4szRtRxyweCcoQskEwJKKRVOnBDN2dmqcAqXAy7NJ?=
 =?us-ascii?Q?WAebRAdRLBv3Qn3JgUkeRfU8R89BROqnegremzhq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1184ed01-ac3f-4964-cb0e-08dde3b7b357
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:13:48.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD/9SyUWisIMpKy/3H1jQm1N0PwMhf3y8EaxeCFX9UOLR5OU2BXlm+OKJlO5Y4U/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

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
index 23535ed47631..6c5a98406dee 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -333,6 +333,7 @@ dtb-${CONFIG_ARCH_MXC} += imx8qxp-mek-ov5640-csi.dtb
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


