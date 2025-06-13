Return-Path: <linux-pm+bounces-28655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3044AD88B5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C8E1E18F4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBC29C328;
	Fri, 13 Jun 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDZYZR/8"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A6189BB0;
	Fri, 13 Jun 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809147; cv=fail; b=ZWrP0d4iPmWUWBZWa/6z/HwTKs2JvlBuckhk6oI9UXqyiXipRJ3vIC5J4eLnP7yyZZQkD6Eq1WTmdCqAEql3DABA5fCjZH/JSXTfH6C5F9cXo94r4Z5bPFxC53g75Lp1AdzqEVw7muwxNZssYNE+ox8FbKx8KhI8RINGHLE7/n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809147; c=relaxed/simple;
	bh=9WJaUCGkWGrjlz/VugcKtuIzQL1zcRX/VbWa3ibu7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VSjNvTV2Y6dJ/Fgv7uLmhFHfWEI/wsvpYpOLCdMZ6sR3dJJVndAcl50sLeV5jqQapg2I1qx1lyWt93kKws+21sCurUtEoRx6WFgWVFrLUUacv2ScoB5glTj9fBb+p8Z2z5JVXq1tCrIq9E6w57e3v9sslqvTlX4NXX+C6fozhyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VDZYZR/8; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaxKoxmHnLSTF2PuuQ8RIF3CYaPRJ1/T3+ZGXuH2AVdyAsjFbw71GvtjjebxigLEQ/9wnKJSf5btbkhQRN6typ/8mCaowQfAexbPT/u5j+IQTHB1PQSSjAdG1AYiIE7F1jCUbKbyiA2sRswBc2PawzSzXaDkWTrPtP8nmHmnGKj6uJcfCNk8HE5xBZzdDnrSz1PhPPbFLELNIfljtn38tMssN3qcn/kOtlqTtbLZpQTM5wYeXkFWRxSx//8vCYRGr4uOOjabhMa0DBZWHJHqSxpPm3ZcUSIqWY+j9Vub46ih8wAfS0IvcEJ18GWjJQv8CLBWCnjo3v6q2sg6KB4/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP1qAjWPTNOSFlnv1KdFQenJ78MrI9mcZoWHWMsliQY=;
 b=huionPsr9tT1G+uuDx2twgVVC34EGCn3YDFPFKcpsswIv2Bu03qBqJDy/clBV0Y4DWiSh5gQkVrS2AYyr0jn43/CO3mw18fsIJcmkgAMvYyhSI27SGndg29h3bf2PMBtfQVsJXgz5TLuL8dr65JXE6BA0NS53QVn7qeNiHnrsrkyfDw6X0pTSwwcNrx6ixZ3YI2VCZrnz+WQE3Zk85s5E3FxgSC6KdF+lVRtpV80LsZcnzgs6WyDQVhzG6GGM7BwdqpnJwZENE3VCPvxt0I5E11E0/sAIgASS9O48n0V2eIhjBaABr3cl8qka+14mNRSiSvTDixEaIRBvCx9JDg9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1qAjWPTNOSFlnv1KdFQenJ78MrI9mcZoWHWMsliQY=;
 b=VDZYZR/8jhpAl7Bf8jRL9uPreJ5yT4TRV9Qy5c79zu8+ShYIGu/kiL4eKjcGlKLbs2sgh4XrHOW0wNT11dgV/qvUoINXMLIEjD/QGt+J0+Yecqf6qsc2knlqXiC2EGVrwkgfJSgP7DfzufOdKawrQnp/UzZeE4FtlgeK9tuvY+yO217qrPe11tOkGH8ZHAtbDpD491pqc7dlkBfGEvQQ9mCTEtQ51amhLiGexBZrfZ1HKX9NClxupAK/vcnifyYpNquk/gfaFkmgQtle+vh6fgmZqwwQ7RdmhqHDAHjLJw9UpEgKPCUH7lNwhpJaqpGJ2czocnIwOCFBvuMeOdl+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GVXPR04MB10681.eurprd04.prod.outlook.com (2603:10a6:150:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Fri, 13 Jun
 2025 10:05:41 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8813.018; Fri, 13 Jun 2025
 10:05:41 +0000
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
Subject: [PATCH v5 0/9] Add i.MX91 platform support
Date: Fri, 13 Jun 2025 18:02:46 +0800
Message-Id: <20250613100255.2131800-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: a30d8ab0-fc5c-4393-4dc7-08ddaa61da6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ER4wbpnDw4cnvuh1eW16LRtApO5y1k+Tter62x60hSM0nKmK1zXsRt4cutuy?=
 =?us-ascii?Q?l6ZsMC3qjUqN7WnAgwEsVDUU91Z31vp5VLSI/G67K28d2/Cmncoc4o+Fm9Pa?=
 =?us-ascii?Q?q/eH8rgYZ5pF0n520Zj5JvH5QWkGoOTBlfFZHqJDtA+D3EASqVyKhsCQwS6d?=
 =?us-ascii?Q?Z04+YfxZOwTBGIhHoYqRdN6swPn909SpNFaerG3B3rnSav5wyy8rYKSSyPrG?=
 =?us-ascii?Q?+a7AsefDiYIzhHLX7yRBdmHBK9XTpEMN5PKqEfgDAeSE3CGJG5sm9aGBpnJL?=
 =?us-ascii?Q?fUN4A7Ms9jpSW2rKXeaWdis3z7WAAgYzUY8TWS04pnyU9naGJ7K7XLxGQWpQ?=
 =?us-ascii?Q?aHyUisAsNH1W7Oxi086bUls8tOE4uIvkcuyFrSe9KbjYYjFlq61HW+1/nKii?=
 =?us-ascii?Q?z7BEmwimGIbM/uxlWmyKmoFF5fM43N2xUdoqoYbanh6v49jA10iwekuUL2UZ?=
 =?us-ascii?Q?lK7LM3v9l5xxL6WPcMp5r8X8XK2w+hy1bxtdlGYZUE7W+ED1qkEOFK5Gc0Du?=
 =?us-ascii?Q?8Bx5u/okHscqeLvS6U9paZkXQVbaDUGfefLDe9vIeH5PrvWTmXvj+snwL2h1?=
 =?us-ascii?Q?F+hYvTPOTt+rlQ/6K7w/XgG/B9z1PiNbPcf4YIgHjXmva9fc7FfstOLi4b/b?=
 =?us-ascii?Q?5DNPvjauzX0v7gkzgxxXjjK99tvvbxJTs1+j4XfrObSSAZzPcdu+NOBui7QI?=
 =?us-ascii?Q?qH18F+B+/NB1YPZPQg14gJNUf1DSxsYHM4SOpJM6auERrijSuJof2hAZEBJx?=
 =?us-ascii?Q?fhCtk37PUQmDdNBFrRCqa2vIPIfIxlEEVMbPSdnxoDyJyCL4eAcoSuL4SUBN?=
 =?us-ascii?Q?bqeanC1/9D5xufG+h2RRkBvZtIGc5kbPo/8ll29W+GGUsXJxV0b3bcEwjXWv?=
 =?us-ascii?Q?NwQ0+QRyqlgo+mZ0lwJr5bPqBpQZQSRIssgb+f6S0ZOz/OdpgS3qtijxIu9u?=
 =?us-ascii?Q?J5sF0udCvkQvP0z+nLWDAXec473GjrMrP7Np3FaRdmnz9d46MRp64X0/hRox?=
 =?us-ascii?Q?w0ZLUNdHymEwspHNfBI8hu3YVjLe6zNRSATbEhl6Q/bfx/Pd/rdHXxkTiIN3?=
 =?us-ascii?Q?3Hskf4G1X0HExqIVk2FY09FdAxaoqbN00E4lVyIykvhCtSzo2e1rgayBrdnl?=
 =?us-ascii?Q?zmDzOtjQmn9CIf4MtctA2FCo5fjLvZhe4A3g+dgTcUKO06TafaZmfGeucbQF?=
 =?us-ascii?Q?nbIO+EEv0WyU966U66Bn869Z/DdC00LI19V5ncnzgwtoeL+q2lwvvMwSH43y?=
 =?us-ascii?Q?iiH3FmnWcBTtEHEzdDHuJ2/t9LOhHysLvgwMQ6zJTy8/B5W2tldC4aQwzN27?=
 =?us-ascii?Q?thybeywFLBETvO0z6a0uYkOeSqpEu6gjEbMwnoJJi3JtoYbnQ9xLLPM+p8lP?=
 =?us-ascii?Q?BFt1THp1vLenZCRugM3m592ulCTKu0qg71aWBjqBfUlAI6zoPriNzNLkHJKb?=
 =?us-ascii?Q?lsjztsam+VL0D5zaBexYRl/PRAIE234wM2UbN2Xr0x2Vg0cEif7sll5kpQnO?=
 =?us-ascii?Q?rJXTbE0zevx+QCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ff2uX0WfSI3iL40U4Lxt+5jJ33bC1nPY9Ai4Yi9t9wTYOJUEd5CZkSbSngOv?=
 =?us-ascii?Q?bzkjZFNKYunDOXLZHmmcQws67L85WKT+JeoOmIAOC9LiaooaQrvNE5fvXm/L?=
 =?us-ascii?Q?M9RGlt/P6hyPGSZFHG5MUqzadEmBaobGaNS+AQg8Ey5TIksoYwZ4X42OuYYh?=
 =?us-ascii?Q?4Wa2K7StJWITj4i+uDATuh/d9fN7PPyydGInOeaWq2cGyBJxRxufdb6oCLdZ?=
 =?us-ascii?Q?xfVHGN0xBdIP2AR+hr0ckFNDINn6mdPrnUit0wEGvgtt1TmqhS6iy331Jt+C?=
 =?us-ascii?Q?YNxSiSHvN4ztU1LimIUU1d7vAP2jhMrext5aOCvWMZQerPj6jgVgM6U4/RAC?=
 =?us-ascii?Q?KYWHj6fvXD7rxXjGG4gEjDSqNpkI/NIu5LkAVySsZ7wTJvp9Gz/7RZpN5ABQ?=
 =?us-ascii?Q?ZrpamyzeOn9VlmVYeeLGid1JrJdE3qqrS055GiebWUFs1zL+nW4kjxNNNN9w?=
 =?us-ascii?Q?Z9dFXdX98cEAT92+Ar0tIMyJCnuFNt3WJn2urblKZkgRh2p8zkgVZvHjsr5a?=
 =?us-ascii?Q?Va0hjiEYTHQLUdJ2aqxitjkbhr9TNUm/21AOyxklZ+rSpiPdSIDP8gPL7JR/?=
 =?us-ascii?Q?Ym7xDHcusW1n6fTNv+KwFsuN0e/JTatLOICkUfgBajFQ8DTkgcRf5UhVMbP8?=
 =?us-ascii?Q?1buaJZj+pjrMfqbeI7xE3X75AfMX470SKULh1dBbkrMW2wgbiuQiUZLlUezh?=
 =?us-ascii?Q?MTp6bFJxY6FhEIifL0e04lXl2RUYgwIXBreCp+yJoDZ+GtHECQwT0EZYwnQb?=
 =?us-ascii?Q?TrQgd36Su/xIpCyUQZBK0MxF6wYkGtPOxwA51RMyk3uhUBgkIYRyoWMe8s7f?=
 =?us-ascii?Q?j3Na3tdu1CCCpow16M3uRhc6uLshNnAzF97+i/UxyL4vh6FeVzph9Sm6xHcV?=
 =?us-ascii?Q?Yefv9qDYY03nDDC6Jwa0TqHqTO8ATYSe5iYSIfIE8pw5f95GdmqsXtYgMpe9?=
 =?us-ascii?Q?AAoLoBWsDlSYJKZ610Gm8KHoSrnUgvKSY3WiZTHZn8/SjNmC7f6snWRdW70Q?=
 =?us-ascii?Q?bXKCS7ohzmsmK6z6C9ZROPEUrpBytU1iSoN+Vg99+E4QEwyyaQHh/hNwCdDl?=
 =?us-ascii?Q?kFdYEnGIyyqgarJ2eWbnAV4zyzCjzO0J4SsWZD9zoFC0XWvT174WPVt/Afv8?=
 =?us-ascii?Q?otRK0sLr3kBpoVADN1rafuzOc8O5R3mroui3aLwaPfK4kFH6yHOacmdfExiE?=
 =?us-ascii?Q?HpizTLhPWLd69/0t85J+WMYLVtRrUw5xfBfiqL9u2nxtGV3VSbOssDH5eWiA?=
 =?us-ascii?Q?bQEWkCCKpr/JxYAg6OzzsJlWifZfkfMbha7O//lD4lOd1kMVCw53Lx4YQpjt?=
 =?us-ascii?Q?pp20AFYlFAtR2OOKC6BmL8xQ+wWcnPYaJ8AZgPdPn4gzHmlYqSRFZ52Cl6b2?=
 =?us-ascii?Q?5Aps0oMYyiYJwmHFU+sEJSaH2Fe+e/rQJqnOH+PgKhc8Xh4LKjl2egHEcYbF?=
 =?us-ascii?Q?X++/87eOL4bj3N6rJB2cTGqK539YE18yLmy3yZLqysK38mzDV+rJHyc20n2e?=
 =?us-ascii?Q?btdqiZUT6p8DyJPn7g9mjwpa/BWCF0FdNTbqLtRwZfbWcN1gI/4ZzNx0xIc/?=
 =?us-ascii?Q?zX0+ZVn4E6HiA6PqmYLE29VtpTq9RUQUKSEpKzwp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30d8ab0-fc5c-4393-4dc7-08ddaa61da6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:05:41.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wXLFGpoBTw+jXfSxCpt0dwyqMo/Zdc4XY6OwIE+gLgPWzMxi0/Wil6ek9bM+j78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.
- i.MX91 has updated to new temperature sensor same with i.MX95.

---
Changes for v5:
- rename imx93.dtsi to imx91_93_common.dtsi.
- move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
- modify the imx91.dtsi to use imx91_93_common.dtsi.
- add new the imx93-blk-ctrl binding and driver patch for imx91 support.
- add new net patch for imx91 support.
- change node name codec and lsm6dsm into common name audio-codec and
  inertial-meter, and add BT compatible string for imx91 board dts.

Changes for v4:
- Add one imx93 patch that add labels in imx93.dtsi
- modify the references in imx91.dtsi
- modify the code alignment
- remove unused newline
- delete the status property
- align pad hex values

Changes for v3:
- Add Conor's ack on patch #1
- format imx91-11x11-evk.dts with the dt-format tool
- add lpi2c1 node

Changes for v2:
- change ddr node pmu comaptible
- remove mu1 and mu2
- change iomux node compatible and enable 91 pinctrl
- refine commit message for patch #2
- change hex to lowercase in pinfunc.h
- ordering nodes with the dt-format tool

Joy Zou (8):
  dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
  arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi
  arm64: dts: imx93: move i.MX93 specific part from imx91_93_common.dtsi
    to imx93.dtsi
  arm64: dts: imx91: add i.MX91 dtsi support
  arm64: dts: freescale: add i.MX91 11x11 EVK basic support
  arm64: defconfig: enable i.MX91 pinctrl
  pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
    i.MX91
  net: stmmac: imx: add i.MX91 support

Pengfei Li (1):
  dt-bindings: arm: fsl: add i.MX91 11x11 evk board

 .../devicetree/bindings/arm/fsl.yaml          |    6 +
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   55 +-
 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    |  878 ++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  124 ++
 .../boot/dts/freescale/imx91_93_common.dtsi   | 1215 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1412 ++---------------
 arch/arm64/configs/defconfig                  |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
 drivers/pmdomain/imx/imx93-blk-ctrl.c         |   15 +
 11 files changed, 3166 insertions(+), 1313 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi

-- 
2.37.1


