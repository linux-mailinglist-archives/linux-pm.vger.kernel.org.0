Return-Path: <linux-pm+bounces-32999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8474B33A4E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F29F48370C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9342C17A1;
	Mon, 25 Aug 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEHOK/8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5D2C178E;
	Mon, 25 Aug 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113195; cv=fail; b=Z9PBeo8gqQ7b7o6tv/CWg7ACzxHch7Qd+IHT0Sf0m3WAME/7ol5+A1Lm8cx6x2DjLXeCJAczrQ3zlNEXg6/uSCoFX/0y1jwlyb/oqvxxJsU5d1sCSH6hMxDalnUB4xYpQ6rjz1rmI/4fLnzs9jU51QfbA06VludaDYHqm07VGp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113195; c=relaxed/simple;
	bh=adnCaT0YHEWCveQJ5JE/3yiyqfmQ+AI5tHM2lol1/T4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BycmHCmpfdDs3t50JJ4/yllNxkUc8j/NCe2K7i9N0fNxBiwsp4v9a7b6Gu2pYziKCChdRP7MMlepkOjASWUXBp7o7+38tzietysuo/RWpFWH+xXGAkd+0GpmuV6orwWsYJS85JJtv1pdgxDqJXXUZZ25mpjPTAq8RJOPWv4AGbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CEHOK/8o; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOVYc1Qnc9QpzW5CPxD4leEtlBHM2YuOz9i7cVk2Qs271AHgpNSJgUMWFtQv7h/2f/D1iTlZOrLnp8g7WHxyZIftcH10V5liQATp4gN9MiO0gh0eGPOx7mKYttve6nPhX1EWdJdfx0VPLMhycWzew8WoTDMxP5mf5OD9EMjml09FWR2YDp3hkOeVey7+Kq2CfyG7uqP/BIvpy9JGQ6i0Wlry9ubGo4Izjbtdd9lhysjPOkPLtUgYLAvDoswe9WbatdSNDINN6Xm/ARKuWkHxi4ltSIyMKK6Xt53nG9qqIoJprUoRtSUQP/MaApWdKoAOtWpBBxGvumLyQ5Mi4i1X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3kBJo4KkeodiRRcOGr+KTxjWBva96RFH+FgArO6/WU=;
 b=U4GUWFF1LNk7QrEhppQuvT69JKMMyOrNuaOHKnSVzxM62VPm9/Y71HFd1lUTUYQo89iOljxs8UQiwmOsFqKnqCmYXU+8ZXthukFwKK1PCowb3kDOwBHhQPiuUuxa0VaPmZVe8BMsJgN2FAhLqHm12fWEhapcK8qMCtnkNU/ynArADfRdpzHuKKPw+HWVMO/JgfGYigvDPk1hN/62dQBct/21huwTRL6uqw7oaIOMUOJE/1lgIAjFABHNQOQUoH8TISXuyCrrh//NxHFiYMzVgcIRqmCvA2KH5PmD4CedRXAIO53Ri+ZdS5iipIKmh2zMkjWx+2YlE4CGWBXb5rtOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3kBJo4KkeodiRRcOGr+KTxjWBva96RFH+FgArO6/WU=;
 b=CEHOK/8oTaldzWLeVq2Xk5V3MjPbJXyQiSBpSd2nlo7833nwPY/Ytt1H1H4oPRxoyQo+8Sk2GgvfHGjYa9JUNNEq1g6taPL+vD3VtwEgySjZI/UzJ0Vvy6ZZfveQbb2BOoUj3zCk/XNkRrTyg84wdl2W1Ugmj35kGSyYdhJhfrgOo8eAhtPALpqrL4MYRqkyGplVYH8DVIy7PtY4evC9t/c+kP9M5y2/VUK2YXfPEmIwqxEU3/Tr1eKhV/n5YVUQvSERfaEDg8PDzwpF4X8fkPEhcnlrOVG7ld8OGynHvJzv5340f8sQjC9h7ZLOu6KOhL/eIT4qvl2kyazsGNA5oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB11264.eurprd04.prod.outlook.com (2603:10a6:102:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:13:09 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:13:09 +0000
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
Subject: [PATCH v9 0/6] Add i.MX91 platform support
Date: Mon, 25 Aug 2025 17:12:17 +0800
Message-Id: <20250825091223.1378137-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-Office365-Filtering-Correlation-Id: d03893b9-895b-4e05-8b9f-08dde3b79b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGUiwdCZWPjuLgY2OffsLMWkWity4iT36dTsshXPnBTKrI+KfdQQDqwULdoL?=
 =?us-ascii?Q?oIsOa6YjPLxQjsoLRDmKYfsOetRwdyWo6TYLI3HvW6wASwLP6uI7J477XSRX?=
 =?us-ascii?Q?BXtuL01D37Ks1Sc+su+DlGIDnJlmdHOdIVznQ3jrp2ljcwCg6qMXZ3BtID06?=
 =?us-ascii?Q?F76Ee40h1HLhRuI936Icg2EPtKRciGB0GDb9xlJYKT63vUWhsBY8QTukd6DH?=
 =?us-ascii?Q?hZA5FxxWPdSjNQbIKDNpVvvQjMOyWIrrVHmIpexfzeKs00QEdwLB1rfR+v40?=
 =?us-ascii?Q?+TCimj0Y2XhzVfmA+dbY99ErfSgb+sPaxc7tVN2y57/vG3eIA5rPX8DgQG7e?=
 =?us-ascii?Q?VvNgQpZHfGmsioGyODTDBhqxPkDJEapH20GqFXizyzxdKASHAGVZl1iK0wdV?=
 =?us-ascii?Q?yBjjPRVzOGjyw1vkYevKRZC1VYV/j4sfFhh4jP0fh1yTH9G+hah0kV4jJy2U?=
 =?us-ascii?Q?6wTDn0n/J7ZmL9xY3SyyBhLdspW8b3RQjlRg14wiK7mOjFVYs9CiKdOM4WLg?=
 =?us-ascii?Q?y+9Hil/5cIVZTP83uESBTxEJnty1YOHlbgBnQYW1MvPnHOFB+9qFofz2gWLr?=
 =?us-ascii?Q?78J4btEo10qnQQ4oQUV1uS/+A7Yy6DizBKEXJZQL5lUxsud88SE9sa9Y+wTv?=
 =?us-ascii?Q?bfWJKxsRdk65o24/qur2pjzHbwc3sQ1T3/GWrE3F22rTq2cHkkGCHd/p6aUi?=
 =?us-ascii?Q?kCSdOMoX3m2E92yZrL21BUQzNNgW4thJ1dIz4HDqYwZent7HZiDMWLeUi0uZ?=
 =?us-ascii?Q?n+C7Kq/TED7ztO52FCxTWkMe1dDfx6VahAj+Fmyv/5m/K8cCmu8oshch+TJ5?=
 =?us-ascii?Q?79XSYXz2sfBt2vHgWuJvwgj3aPMDWSB8GB0CGXP+usJR1sKea54PBLvhUHRs?=
 =?us-ascii?Q?E5DiSSCh3O51RVkf8hSJE1NkH/z8IzyrI0mS2NH13IzR2TQK5IqOq5/huJfG?=
 =?us-ascii?Q?zcuUubYC/4YDs4QnHTO4re3t7e8XkPvWDJ12dDEiX9r/+ROu/o8rgY33zBEi?=
 =?us-ascii?Q?QrRCYkCICuHUtPHsqEVH4BgW7+wAQZYfpMk2X2Y85DSKo/Ak45HMwhgxD7v4?=
 =?us-ascii?Q?Gp+PZe7GwiQFoiPtLLHT0y96a6X6Unuw+1xy3jS8uKB27LT5Lu3AM5SRltIh?=
 =?us-ascii?Q?dRHgF+Rz1EXf7Kihlb96FYfetMejA/0mXgQXWIfN6mumqB/yhQD1A6WB7Vfe?=
 =?us-ascii?Q?ygTlqJOxwl+ViDlNSneg03dJqub1NnmNzR6DbQR1aSrbfnj74OMBXchRIObq?=
 =?us-ascii?Q?UaDp7tXhpuH+zBT01nAnkglD0U3+HrA6kX1ivQoe5lm6cPQk9WGKPNYE0mbZ?=
 =?us-ascii?Q?nk9TcKabbd4KYpqPDykac6GMHBZanzvyP6VpACIpDmHTzCI3g2zSea8W3SC9?=
 =?us-ascii?Q?ul7Eus3mLRV7QPKCCzIVPki6PM3uarG7BC26+0gCtQeh4yLhTXOImnpMGInY?=
 =?us-ascii?Q?nPxpLPn0KAykXCbaDWqzcDQxj/8KZfUv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hUMD/Ats8L/zpFAzej27S2OyTYA9Wz8RqcPE8qCDwQncybO9Bvv3z8ZX9ndq?=
 =?us-ascii?Q?i8NZ+jsff/KBZVhdftl8t0PMmrbxPz1EsFdQnHCN8w2uzu8OsKI5rIKNbL9L?=
 =?us-ascii?Q?mIuRs3MTmJGh9Q6COy0rNwQ2wSe1fN6R3wKRPv246QdGD9iTWkuDhysh90T/?=
 =?us-ascii?Q?s6/YDsWCyHSaqtPELwBIqPNIkBsXh1jXl1EtruLlLxYuptntA12+prJk0+D2?=
 =?us-ascii?Q?gFrW1w9CSqkS8FR1WYgBycIiBF6AdKagJwksZHPFXQNnMMRTpZt89AcHwRkT?=
 =?us-ascii?Q?83P6z9tBA+aRQ4YEmGbeA+8QlSMFpH6aYalWRqzWUsLoomeiL2t7S1f9+3EC?=
 =?us-ascii?Q?RdqMswX00O5cpsLrIPRLejOohntKPeaYkIQous//d3vDLA+ICyQXPtUQuhxv?=
 =?us-ascii?Q?kFutKOGZ48f1D1pJ3nltwMG46j5cfKjMcEw2NC7NboZT4pBeuzf2PeTy8mXb?=
 =?us-ascii?Q?3joI8JBX68VGMBFjNQRbaEExDLpQQtR8btnPwu4wlr1X8IhZMsBsqTUU0vxX?=
 =?us-ascii?Q?pbw5v1XjYH9UGkAvAXK0zBUjHSV/Tehnicpn7O5TVSgj8ud7TsR33WCE/SXD?=
 =?us-ascii?Q?PxmhLdFkEbHcbkQESZ25atdTBQvC7pdWcbXLjYs87EXDmrq1LjZTNT5iqk0q?=
 =?us-ascii?Q?BQ9LwVGFRbU7g7wwRM6VyZF11VG9l6OgzyKmrdWvmIocswxzpIrfH6vKs+Dq?=
 =?us-ascii?Q?POk7ITRZ2zBSOsXf3JLDWU82TcXQVfETWwUfVHgENY8nOU2vI5Rp6EAgdI4F?=
 =?us-ascii?Q?Tw/LnK8RkSidYxZ+uYE8jQU52db9oL9LxQxHttuLJYQS08guEJ0LEVl1pQLm?=
 =?us-ascii?Q?SBFgxWmZgkzjxPe3HXKE82F6LzyOdDxRiQb7phsYcpLPtgXq7ixMLPunWlX8?=
 =?us-ascii?Q?130LkXtvLXik3WuZndC7B52r27vIQ0ikGOJqY/9BA8ripiS4zeaZ+C5H/d4G?=
 =?us-ascii?Q?7xd9wKJPzEYuRF9g+spACbZfmOE0mCAkkZOVd9ZZ3NOsNy68k29/d61TN80O?=
 =?us-ascii?Q?OICkhOZnTmWxtLbumx7czXxjcxDCLFed9iB8symLyHfZHRGq+D1+lNtdTCP4?=
 =?us-ascii?Q?357o/zw0zTVb2MUZr3296WDDfD2ZXuTJ+/TQ92VzkeQLl36/EBiH4gKcRX7Q?=
 =?us-ascii?Q?2xQF90BCOje64R0DG1/dSBtVya/DstS+5KYfL54mIshG9fnlaqi0UxSBCcCx?=
 =?us-ascii?Q?VSrYFDwE4Pmbk2YWvqX5vH97anIyEYZM2iS92W61QZ8gYPLrmDjSUkStI1Oy?=
 =?us-ascii?Q?PSM9pP+brx+pQfMRJOhTQ4WjPB1jxAoLwPuT2aK+hCJvness5eM0uj0+Xwn/?=
 =?us-ascii?Q?Qn7AZvxX7rSbBYgcMCJ8U1A1PsivcPEuqUYE2NJWoe+yeFNskOjOpD4Hiat3?=
 =?us-ascii?Q?R8lJFtla4BeC8n7vhtij3v7kCX5W9G5eMrcKz7AC7BaubJSt5dh7SMvPnRFD?=
 =?us-ascii?Q?/3hLcOOrqfX6dHO1cU7NLu1Inlsst9oSADGf8QmbZxdFf3zrVkJWQsJO4363?=
 =?us-ascii?Q?LuP3Mh9DVJKy7vHMCf26HMA//+2QHSozEV3L+1im6I9yvBMHnWEG/UsANeGI?=
 =?us-ascii?Q?zXtItYnTGZuREt5v1wCsmg6MoKdCPAqxMNTAiwml?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03893b9-895b-4e05-8b9f-08dde3b79b5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:13:09.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTWaLaSLw5vdzb8meYwyvZL9TNP8EoEpVr1JQGRMTJMxV9smJ1kZw8oCvra+d4eo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.

---
Changes for v9:
- rebased onto commit 0f4c93f7eb86 ("Add linux-next specific files for 20250822")
  to align with latest changes.
- there is no functional changes for these patches.
- Link to v8: https://lore.kernel.org/imx/20250806114119.1948624-1-joy.zou@nxp.com/

Changes for v8:
- add Reviewed-by tag for patch #2/3/4/5/6/7/8/9/11.
- modify commit message for patch #10.
- move imx91 before imx93 in Makefile for patch #6.
- modify the commit message to keep wrap at 75 chars for patch #5.
- Link to v7: https://lore.kernel.org/imx/20250728071438.2332382-1-joy.zou@nxp.com/

Changes for v7:
- Optimize i.MX91 num_clks hardcode with ARRAY_SIZE()for patch #10.
- Add new patch in order to optimize i.MX93 num_clks hardcode
  with ARRAY_SIZE() for patch #9.
- remove this unused comments for patch #6.
- align all pinctrl value to the same column for patch #6.
- add aliases because remove aliases from common dtsi for patch #6.
- remove fec property eee-broken-1000t from imx91 and imx93 board dts
  for patch #6 and #7.
- The aliases are removed from common.dtsi because the imx93.dtsi
  aliases are removed for patch #4.
- Add new patch that move aliases from imx93.dtsi to board dts for
  patch #3.
- These aliases aren't common, so need to drop in imx93.dtsi for patch #3.
- Only add aliases using to imx93 board dts for patch #3.
- patch #3 changes come from review comments:
  https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
- add clocks constraints in the if-else branch for patch #2.
- reorder the imx93 and imx91 if-else branch for patch #2.
- patch #2 changes come from review comments:
  https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
- add Reviewed-by tag for patch #2.
- Link to v6: https://lore.kernel.org/imx/20250623095732.2139853-1-joy.zou@nxp.com/

Changes for v6:
- add changelog in per patch.
- correct commit message spell for patch #1.
- merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
  specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
- modify the commit message for patch #3.
- restore copyright time and add modification time for common dtsi for
  patch #3.
- remove unused map0 label in imx91_93_common.dtsi for patch #3.
- remove tmu related node for patch #4.
- remove unused regulators and pinctrl settings for patch #5.
- add new modification for aliases change patch #6.
- Link to v5: https://lore.kernel.org/imx/20250613100255.2131800-1-joy.zou@nxp.com/

Changes for v5:
- rename imx93.dtsi to imx91_93_common.dtsi.
- move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
- modify the imx91.dtsi to use imx91_93_common.dtsi.
- add new the imx93-blk-ctrl binding and driver patch for imx91 support.
- add new net patch for imx91 support.
- change node name codec and lsm6dsm into common name audio-codec and
  inertial-meter, and add BT compatible string for imx91 board dts.
- Link to v4: https://lore.kernel.org/imx/20250121074017.2819285-1-joy.zou@nxp.com/

Changes for v4:
- Add one imx93 patch that add labels in imx93.dtsi
- modify the references in imx91.dtsi
- modify the code alignment
- remove unused newline
- delete the status property
- align pad hex values
- Link to v3: https://lore.kernel.org/imx/20241120094945.3032663-1-pengfei.li_1@nxp.com/

Changes for v3:
- Add Conor's ack on patch #1
- format imx91-11x11-evk.dts with the dt-format tool
- add lpi2c1 node
- Link to v2: https://lore.kernel.org/imx/20241118051541.2621360-1-pengfei.li_1@nxp.com/

Changes for v2:
- change ddr node pmu compatible
- remove mu1 and mu2
- change iomux node compatible and enable 91 pinctrl
- refine commit message for patch #2
- change hex to lowercase in pinfunc.h
- ordering nodes with the dt-format tool
- Link to v1: https://lore.kernel.org/imx/20241108022703.1877171-1-pengfei.li_1@nxp.com/

Joy Zou (6):
  arm64: dts: freescale: move aliases from imx93.dtsi to board dts
  arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
    modify them
  arm64: dts: imx91: add i.MX91 dtsi support
  arm64: dts: freescale: add i.MX91 11x11 EVK basic support
  arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
  net: stmmac: imx: add i.MX91 support

 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    |  674 ++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |   71 +
 .../{imx93.dtsi => imx91_93_common.dtsi}      |  176 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   20 +-
 .../boot/dts/freescale/imx93-14x14-evk.dts    |   15 +
 .../boot/dts/freescale/imx93-9x9-qsb.dts      |   18 +
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  |   21 +
 .../dts/freescale/imx93-phyboard-nash.dts     |   21 +
 .../dts/freescale/imx93-phyboard-segin.dts    |    9 +
 .../freescale/imx93-tqma9352-mba91xxca.dts    |   11 +
 .../freescale/imx93-tqma9352-mba93xxca.dts    |   25 +
 .../freescale/imx93-tqma9352-mba93xxla.dts    |   25 +
 .../dts/freescale/imx93-var-som-symphony.dts  |   17 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1518 ++---------------
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
 17 files changed, 1863 insertions(+), 1531 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

-- 
2.37.1


