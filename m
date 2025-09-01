Return-Path: <linux-pm+bounces-33548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E33B3E051
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AA1189F84D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CF30F921;
	Mon,  1 Sep 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lCY+iJRq"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64930DD0D;
	Mon,  1 Sep 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723060; cv=fail; b=J8xJjMx1DNQVkeBKV18/NZOz08pp7V1BisuamXgTk9/myobe9bkr0HBbY+SM9giRloJGrrFqL3FkwDzZoXsqgquAZ8Zl/RemRuZ4gQNFdefHQdqH3JXPzXiZEeked24mNbdmGTztRSUTOrE1UrAd3yfu2KPA58/OAyoKSuubvdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723060; c=relaxed/simple;
	bh=o0bqRls8+ojXHjeg2je+w61X/bnVGxGKrJYuiNRqmlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3XUDkpr5Uph8e1FWCOE2xtnQAQU0jwjOIfHdENcmVaZ9Bpsaw1rbYbXj3IlrH7tnNeR46KBHmSdt47Bybhp0dty45Hze3Pv2sw7xUHCdieQJGO//N5sFIJK2Hovsb/UeMFflf3yjyAM3uqJjLOpd4mp+pNv3oKaRaL5iZoILCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lCY+iJRq; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxl1UNgyWDHr/8IB5kTVoEKzUcCIeTFXtMl2nXSE6zvKROnWqbX6tK8SPfiOTtiVJfG2HWv0Z8SkwI7qZ1UuDoLb9owOdkZuFPycaBNPnJc1ipnC2yY1S1glWPKZLexy3Baes5Qz60s1ByvHkWedbdKXgjL8Z/f4gWxgGzSmOAi1G1NaRsJgeDgogWVqfTAnTExZGHOBeqbq3h0/RQGbVMqCNrORyIViX1+KQC3ImNYQ2fJzjrIj773dVzrwRh9Y7HBRByHxtqCzkICzdZhYLmxnn0QCSQmVG83D+Cvrs6lfHjeH7xLMSf6zAF3z46LerRZbS6aX08gD4iiVoSJH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KbL1/M7eBSZrNQ/Qlnj2l1ty3rUVQO5TQhtkqXUylM=;
 b=YA/u+tofffyUd13aQAUdxP5+yA6KXxIhGP3ZJYwY/HC71v5UM0IyeP/t03VKHMqqUGJWpcl2wBAAubZM6bXreeOOPgD9f0lMqBJjNUQaaXvR32sBlJjR4D+N1/WzK61b5g+CEgdrk+9/UNaTV81C3NopuNd7aVhNhVJWA2SQ3AWSg81Cfc7AZXHSopUcKZeEc7YpYv3l4Op/g6yZEw1iBnyESlGyq9QPLrMGy27aInlL+/22Twdld+PtIB+wDVDIc5lDv3hQnirvZWyP/o8xTUs0qk2TnU0vP4/VAOu2QEXgWFKqf1YlxVzbBz0xZ8MAuJXv9BLl4ZHFYY3K4mL1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KbL1/M7eBSZrNQ/Qlnj2l1ty3rUVQO5TQhtkqXUylM=;
 b=lCY+iJRq9oSHZMw8gKyklVDMQINWYELEUbDfQjLg4s9i/VSJMgmTbKUmBsEVfC43ouR/o9u1ApOCtp94an7ilVyYt2PtjHwschzt8Jswoxdu+Dt3qnnEkXnXlxL8fcITLr2RBU8QP8bxQ0jfZcJRmq1ERbUIrX5IjKyR/AhUv/lSA3tbnbTipS0uxUGn3EWaLbObV8wiKBPEuzjEHiZRMv9+ZIPdJC/61SdtaW9JOtdKogA7d4WVv3U03WKBQuwB8tDvayM5Tbft9TbBSN2bGSAxUt4I2PflfcqwhLU6DSqNpOcCteqvG7nPgfyV+dOXPysYmimVllX/U0cL4TLduw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 10:37:35 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:37:35 +0000
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
Subject: [PATCH v10 1/6] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
Date: Mon,  1 Sep 2025 18:36:27 +0800
Message-Id: <20250901103632.3409896-2-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4d78a31-9448-4aab-4fb0-08dde9439071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yy2XIxuM6Zk1A/1vLm7j0NQjButbiVECi0LzXu2m4vvvBJHz2FQDADJVBiJj?=
 =?us-ascii?Q?V1FN+mmmYMBqKmITwwnmNW39Yc0dczYCqDbapDbqiFZRovwnQf4EnPj2NPvL?=
 =?us-ascii?Q?nwPc4rMf1UO8JhNKf0CVEbE4xnJmbBH9jdo6ixxFfvjE9Z2rdIGSeFclHybV?=
 =?us-ascii?Q?zSQW2z5dL/l7BN44Q0kWRcTNnNGIvNgQb5qe0NxI3yZ6uW1RckAMzH0wxMvO?=
 =?us-ascii?Q?D6tC3WUmvwpaFKwQylU3DTO1Vpo+nhDfhpWR715nJp3+o47CYUwUGQg4907d?=
 =?us-ascii?Q?NdWsb9YJ2f1i2yANh5u7xATkDMPzozLHCzEc8sJbWKsU2vp7YnS2KzuCV7Dg?=
 =?us-ascii?Q?bm0EmE9GO2TlB1oaCcaMMZ94mPNy5TZAU0u4vBvbGMVF/Yf3b6Cg3bPpD2OZ?=
 =?us-ascii?Q?Ep1Jqpra4ZNgO/sGRkDgGMn4Wc0CXYs2SElDclgEdZzAntyhVRdYXdc4Cct/?=
 =?us-ascii?Q?0ETzcn8Mwy+MiMnFWMD1/tB3P9tcdNM8fYLKQCeF6HFapKIDxLqOiINk+DIc?=
 =?us-ascii?Q?1jGHae0ys0WkojVzgexfCm4YA1Zd2EsIKjU4AGaF8DrFtT/11JyPYqTIn4Ps?=
 =?us-ascii?Q?UOWpw7lDIO8++P/emSsYHbD1k5zBgibfzcKC1dKNxlGGmYC5h6X5XAig4HG1?=
 =?us-ascii?Q?wmDprj+rdch2s0xy4LA5IkvKrjbFDXDCiKaU9DDVXNCtNrXy+4g2dnyuqCWM?=
 =?us-ascii?Q?kJU3/tu1FCUKM7SbJyP0OHaTHZ2L+Dh+WeybWqUr3qT7OKXQxZ+anoleo2RV?=
 =?us-ascii?Q?w2JYBIcnRC2CVDRWLaeZlyDSNAZOfC82zn2Llo/XzdM1UryrcrAdlx14lyYu?=
 =?us-ascii?Q?Wh8vUmnPrm7DTjn2iTOD7qaU7XIKXzqc2XhfSZX+A0ofF9VhGcdZgxh5jIuZ?=
 =?us-ascii?Q?zfrAPfnzdvz3+57IOBqc35nm2n+AcCemesuzIcAAPs9ia3qE6PuxNQONzsg5?=
 =?us-ascii?Q?C7SJPG395FlqD3UoLMt7on02wJyP01el0UrPsboOTW/f2ASnFM1kO2WtSZiM?=
 =?us-ascii?Q?AtjqqqXHYB9/dp3aCvn4I1UHnG+jiFTvEHh84tknDt5KTDtLCH6StZ5Huw8P?=
 =?us-ascii?Q?RYjJ//0VyWqV+4oD5YOvmvY18H618tnJskG/4K0MmFtM7bpjU/+dD2mfQXq8?=
 =?us-ascii?Q?vzdDufTRViNylJ3FpJYnsK01eYd9MftuGw1Oisi9uga/2fNh5zHZxqsWjOL9?=
 =?us-ascii?Q?OLUFzb3B2PawFVEdjGmK97Jbj9cUz0gemnb5uk+ymckvh+jctiKmaywvILgW?=
 =?us-ascii?Q?xDUaQwmb95SwR/TGpi6kY/INKf59upTMCTyJa+qHWaDBjmaU0PuiySUBf44r?=
 =?us-ascii?Q?u6anDXaPcMiF/aK4wOiBlWUqjXq5MP1iLVoahjunHjErqgx9LehBTwWX8lU4?=
 =?us-ascii?Q?GVoeHx/zWu7/Zq1TtM8aOmmPh6utcKJQylw+/70QK+Vdp3r8mP0X+4/nU+8h?=
 =?us-ascii?Q?CVkSZJEZxhh75gsd5Sopdv27S4PgJlOWXlJWYCjqw15BfyAO7CPkdYRV0LXH?=
 =?us-ascii?Q?96AmU1n9AobtBy7m+wI/L9xPCKgVegddYFUt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgA7zR5Z4XI01Gf024llYp9WDbsNGkx3oBmBT0Zkw34iKdLee3D/C8Ww80qX?=
 =?us-ascii?Q?v3XOZD+PgfRFsyEbo6NVdWrdrhaOTyrfgp5cgbYJid9etuQCalVr6XA9CwlC?=
 =?us-ascii?Q?UvMdKmM8JAHqkLzRxMyDZSFWYbXLbj9xmaz2SM+p46eHW+W/C2oRyTyyysT9?=
 =?us-ascii?Q?hw7BrKLoeAR/IUXthw0eec8JIG5M5SMqSbWl/JsTgaJEzaHXal2plMX5Qn39?=
 =?us-ascii?Q?ORWtCbA6AiTnUGbVscuEd4NZ7BTyoou2cxXgm/qPi0e2jqOKWQWkqpbdzC+z?=
 =?us-ascii?Q?iS9Mk6/nZa/rMXqAL9CxdTcRCRjsmxndmnEuzB5n/PMFx7VYEor77suiUx1p?=
 =?us-ascii?Q?oWcFUyW9YmCmPppn/1Yujl95zDCoCCf3UvNDxFAEWYFOy45KNrdPncNA9uEW?=
 =?us-ascii?Q?dB2g/+BEAcTcCskUcllDfYTcvxeD4hFWbn/x7xqVYOnUvoE+Igej+9zFbVgC?=
 =?us-ascii?Q?gZsl0GeMoSeRq7PGBml5rxf9EzoEKjjHR9rTHPPZB5jvqldpCsqXAFdMnWwo?=
 =?us-ascii?Q?lqewIHtPzD69ZGIGF9AXsascX7YtCsgppg/36eCtXLgEYrBZItFYGaXInz8R?=
 =?us-ascii?Q?IjKd+glKliHV22cuL99j3TRDGR44xTUNxCJv1SWkzERCqYUda+qeqdNGjsZO?=
 =?us-ascii?Q?6BK9vq4xG6RPb2GO2HTiT8j7rtUJNZpJGKs/30RwprqiRechWhkwocoWZs7R?=
 =?us-ascii?Q?nALTYvSHrHU6y/7NE7ORHNsozDnQiflOPxhB8KQD5Io/fdWDu7fYsE+PvCdD?=
 =?us-ascii?Q?R2Ps+cCeSDgANepTdIlVROlv0mZO4ofjGpTGFeelh25CoiWn1J77ZHA/6/mn?=
 =?us-ascii?Q?620P/AZ6H8JRFywPI+Xp0SN7Oh31q9T6ZhEoIqHPF/gDLX65CwibxWNwL6uE?=
 =?us-ascii?Q?EOTqGVW/FVL313h6sFQRrHaceMs633j50wQtB5bFwRif3VX4ESZul+fQkx4N?=
 =?us-ascii?Q?5mP1kcoBZj5MQdxohVHIGbBTsW719MBHxYuIZwDCMqPLWUAXMrX4rXKIn4hD?=
 =?us-ascii?Q?RuUHre4GDMmE0m9o3GeNHU7J0KVydVS434qhFUshv+Mq9biHOpNw/lMoXLge?=
 =?us-ascii?Q?+jUynTKsyJr86uUkpwec/EfK4VObLekNzz1QUMsS4IstUatqxauj9zPg0E/w?=
 =?us-ascii?Q?F+FaihQyTT7AurMShJwBm1BOIt2QyrZd03qd2pMC+1qbtxI+iMNOP4DQhxmP?=
 =?us-ascii?Q?lEfBZbLuq5zYPov9pU9ywB1VPe3RWP/1RExJgGcqWWL3Kkv1ExRLu7k2BJNO?=
 =?us-ascii?Q?dIySZxQm6IhpZs7QXKUeqAERfjDNN9HYvfk5jp7hIiiSKWq+F/D13jsDoDNz?=
 =?us-ascii?Q?pid9KbRF1R1ejwYghrsHCQ4F6bTCH1Ikp/LKApfhHR9tBIaO6ed63hTkAcgi?=
 =?us-ascii?Q?gHv1/FwanxAw3Cnsq7j+nkFkRMfYqFt5kbfuJWDv6MWonU2ke9K7PtKyKkAQ?=
 =?us-ascii?Q?bsLi/83I5a6JGMSvw4S7Egl4/ZhHVNMTs9Ysm2M+3nISmx7RFl1uFOBzh8pm?=
 =?us-ascii?Q?03ttEfMqCjFByNKk+ZeWokFPFCZT+nAy8nQfOhNHcXXPBbv57i7jAWYRMKCm?=
 =?us-ascii?Q?uYdBFf2hihVfUTLxFdY9AexKD4ETyEJAH6HyjEGG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d78a31-9448-4aab-4fb0-08dde9439071
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:37:35.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyYfRBnftzyTJ03jgnPEJjjLwleGlCJK1eL23j7P57D5WzCH1IecnuUw0tHgbsxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

The aliases is board level property rather than soc property, so move
these to each boards.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. Add new patch that move aliases from imx93.dtsi to board dts.
2. The aliases is board level property rather than soc property.
   These changes come from comments:
   https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
3. Only add aliases using to imx93 board dts.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++
 .../boot/dts/freescale/imx93-14x14-evk.dts    | 15 ++++++++
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 18 ++++++++++
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 21 ++++++++++++
 .../dts/freescale/imx93-phyboard-nash.dts     | 21 ++++++++++++
 .../dts/freescale/imx93-phyboard-segin.dts    |  9 +++++
 .../freescale/imx93-tqma9352-mba91xxca.dts    | 11 ++++++
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 25 ++++++++++++++
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 25 ++++++++++++++
 .../dts/freescale/imx93-var-som-symphony.dts  | 17 ++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 34 -------------------
 11 files changed, 181 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526..44566e03be65 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -12,6 +12,25 @@ / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
 
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
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
index 8c5769f90746..f9eebd27d640 100644
--- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
@@ -12,6 +12,21 @@ / {
 	model = "NXP i.MX93 14X14 EVK board";
 	compatible = "fsl,imx93-14x14-evk", "fsl,imx93";
 
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
+	};
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index f6f8d105b737..0852067eab2c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -17,6 +17,24 @@ bt_sco_codec: bt-sco-codec {
 		compatible = "linux,bt-sco";
 	};
 
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
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
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
index c3d2ddd887fd..4620c070f4d7 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -14,6 +14,27 @@ / {
 	aliases {
 		ethernet0 = &fec;
 		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
+		spi6 = &lpspi7;
+		spi7 = &lpspi8;
 	};
 
 	leds {
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 71a0e9f270af..3f9efa32cddc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -19,8 +19,29 @@ / {
 
 	aliases {
 		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &i2c_rtc;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
index 6f1374f5757f..802d96b19e4c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -19,8 +19,17 @@ /{
 
 	aliases {
 		ethernet1 = &eqos;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &i2c_rtc;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
index 9dbf41cf394b..2673d9dccbf4 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
@@ -27,8 +27,19 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
 	};
 
 	backlight: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 137b8ed242a2..4760d07ea24b 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -28,8 +28,33 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	backlight_lvds: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 219f49a4f87f..8a88c98ac05a 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -28,8 +28,33 @@ aliases {
 		eeprom0 = &eeprom0;
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+		spi0 = &lpspi1;
+		spi1 = &lpspi2;
+		spi2 = &lpspi3;
+		spi3 = &lpspi4;
+		spi4 = &lpspi5;
+		spi5 = &lpspi6;
 	};
 
 	backlight_lvds: backlight {
diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
index 576d6982a4a0..c789c1f24bdc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
@@ -17,8 +17,25 @@ /{
 	aliases {
 		ethernet0 = &eqos;
 		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
 	};
 
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8a7f1cd76c76..d505f9dfd8ee 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -18,40 +18,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		i2c0 = &lpi2c1;
-		i2c1 = &lpi2c2;
-		i2c2 = &lpi2c3;
-		i2c3 = &lpi2c4;
-		i2c4 = &lpi2c5;
-		i2c5 = &lpi2c6;
-		i2c6 = &lpi2c7;
-		i2c7 = &lpi2c8;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		serial0 = &lpuart1;
-		serial1 = &lpuart2;
-		serial2 = &lpuart3;
-		serial3 = &lpuart4;
-		serial4 = &lpuart5;
-		serial5 = &lpuart6;
-		serial6 = &lpuart7;
-		serial7 = &lpuart8;
-		spi0 = &lpspi1;
-		spi1 = &lpspi2;
-		spi2 = &lpspi3;
-		spi3 = &lpspi4;
-		spi4 = &lpspi5;
-		spi5 = &lpspi6;
-		spi6 = &lpspi7;
-		spi7 = &lpspi8;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.37.1


