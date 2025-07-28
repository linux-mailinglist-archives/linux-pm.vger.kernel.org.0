Return-Path: <linux-pm+bounces-31454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9910B13567
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF32177683
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835A224AF1;
	Mon, 28 Jul 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOBd47Qx"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5727455;
	Mon, 28 Jul 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686940; cv=fail; b=UAnE6+yfUNMQJXLzZTnRcUygrwtH0zMTB3dLV8LpKMLpHHdkVQIU9X4ZSSNmVx2qXcN+dgX36V4IZb2MgJ15utcBnStv6fLV3Jub3rkTZsRkU4hCxKXf71nRzFvtq/5APKHXbLsptUFIneqdTnxYgglwZBr2DiVJQPwAicPHgvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686940; c=relaxed/simple;
	bh=L0KYFSyvC/PuUWxzE9dq1AJpejriMHYz+5kPd1i6V0g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mJv6ked98Z7t79epm22JqsleQid7Gq1gLDUWY8IVPWj1cJJQ3mTs93d9kGOr+fnTHJxLggoEzUL63zFR5O6uaN5PqFnK33nzxD1yFVBRvrwIods9vlP5T8VSE6GInmct+zJBgLKu84tqt5LYqFK9FJFm908TpkEQIdSmYuKP+zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZOBd47Qx; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObSzAhJZJtdNOdu55Lu81M4ygkKvkC92mcwatqeQ+k4IGF7BsuRoxG70hEfdxXIdCcg31sB/TfOsE/612ImrXM/KLCNi86wZGltd0VDP5p0oMbcexw/ke+tPpowixbY/6LFzFM9qXvkOQ+/OdV4nV4Z4YPJ7aJINPWK3sGskwLVNAwv1fhjTyXkDlbLD58BdzDu0y3/d0rZbBU1h3KkBxdYb86IjIuH5qQrHiOWdvEs3nS0tsdXOj+fh7UQ15zWZUk1ZTiNnaRX/2I2kFI5SSJznbNMt9v+4NlEEBF/gJjWtraEmljqSoaJX8J0Zj+dBXX5lZCUtULUbI6GagmMPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EUhxA6dHDtHhAOhtkUZopC5MX2zaWBGEHFiBaN22v0=;
 b=vFFVvXH0DakbpI4ke6TYyXyAKgq31Ck0Q3lNhyVSvujLD6437lca6U/2Trsue7Y3SL1Ds6If+Of+n+BdU+OffSwjIuwWzsjnEvj/YpHVO9ohUpNNx1fZRsABkZONLdzvDKm8F2GZd68qfchCS0GnOg5Yjc/AjteIHQ/0esXgc1A03bJsxjOaguaY/5CRAKP8NSzwGdnSFEHBgd8ZGGRKQ3giF9/KRmCl2D7Xv6Ro6E5k+y83gmeIXS/I7MCSwFuad/I5YnIz8z5QB13O5e1AyhD1EIQdGnniueUh9zAOk03XP6cHiXQ72H1WvSt+LSuiZBAW3Rw634/xUiZx1BtQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EUhxA6dHDtHhAOhtkUZopC5MX2zaWBGEHFiBaN22v0=;
 b=ZOBd47Qx8oW3QPGDX55kxP3uO6A1pNfWBujGsBT3l7VDL2DkE02ipg4TLXWQLe0zIl/S6nwZL6n5864HHUz1ixKjPnofDJezDgsu+/nLphTjZQeAYJqnvsPSvtOe/RKMPlcqF/jEN7sK9IQ7Ts/iAHmjqtyDO4P+vKnO9mWcaBarUjG8UuVMqRMbeT99qJHsLAsLqXEuz0UKb+y4JC0iKWiww2qTiVjqW4Up9cmHBxgTFDLDrF+y3dbu5hjJzYrP/gVv8sX6M66rmYs2PLzAXNKQZaf4LG9eQSo35hXgm1YfVM7Fz9fhYRDtwDLiMrMg/jfZ2aKWOOtHw/F8/j08ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by MRWPR04MB11489.eurprd04.prod.outlook.com (2603:10a6:501:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:15:35 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:15:34 +0000
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
Subject: [PATCH v7 00/11] Add i.MX91 platform support
Date: Mon, 28 Jul 2025 15:14:27 +0800
Message-Id: <20250728071438.2332382-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|MRWPR04MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: 193e5ad7-cec7-4959-1210-08ddcda68b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSCWz4u5DDlwk7pEz/F+KFrgMZg6X08w07lQmCmjWjOVEBgyx5QHrEKgeOSs?=
 =?us-ascii?Q?HGeV8p68Re+UhHo1JVVM61ziRPhrEBxzMhxAkwE9W0HSiHxB1VDVSNxf60A9?=
 =?us-ascii?Q?Z/clMFMcc/AwLuq8EKX/9sdG7uliDUgowM1DVGmoWnOuzxYSiRlga9tx7+to?=
 =?us-ascii?Q?2n24ExTzZxakRaWPQ1goUiVR0YrE0v+h+DUEg08u3fXP3+Sylg/6w4blsDbY?=
 =?us-ascii?Q?eF4Qe/dAWtJOlWerDCYy7sokCl4m1NoKaQzvBFGbxMqW7aBVmEqy4LldJ0dd?=
 =?us-ascii?Q?zPONbscvy2uc8HUPbgbpSQWDWqd/L66w6hoHPlG17ufvpuGjTSU+GJPrqav7?=
 =?us-ascii?Q?7um0YgYglHQZ5HUKxqkYorZ6qVs9FgI3st6kgb/7n4YQYr48j3oJiTbPe5yU?=
 =?us-ascii?Q?6mMMRuZUHkHQhsQwcoVJxMWL9y/+RvZArds6x0iDYDrkSnCP0udj2IQy3Uny?=
 =?us-ascii?Q?5k6hoJCDgxwWybpPzMWmpzXRbJm40i1PccjKbuRnvkcoogW7XjlnF5t3Whyf?=
 =?us-ascii?Q?8sWFtuxMmeC0yeefTCczslJdc5eS32nGqopZ7qsxki1WF5F3ReHpwg7W3n7U?=
 =?us-ascii?Q?rYAo9h19zT6YwVp7qWcvhOgAjvKYXJLm/6E34zM3IPM9V1ackjDPAMCS3U9c?=
 =?us-ascii?Q?etTvU84ADm9Ffy6dseJc+CE6ytlz1idFE3CK4M1TT368XcgFn3GAzEGcXtm7?=
 =?us-ascii?Q?kMv3Gufb7NWrl1FWpAHeItVggLo7u1vHWFSrGn+cqN6EoL0cLdRWDy6hILfJ?=
 =?us-ascii?Q?56lJbIn99teR/aERMcZ/aVQ+5XsqdncDdD+Kjv6+bNB9qOOr1yEHJwmlQZD4?=
 =?us-ascii?Q?UElTS06kjaeSUzoJrPgXR6tzP3u9f0LbLkquOLpgaZuzCZF7hpDwK0Pmu3zn?=
 =?us-ascii?Q?mcI5qxxi+iE5ZPFWpa5QCVF1osCOiPZKT6DPynncqffE5cZDySVaVoV0XEfE?=
 =?us-ascii?Q?Dy0lObjaPyfRuHwb3aflGOwARnO7Z3L2hn0ToqYxwU89ttP+jbT9UKHpTWhW?=
 =?us-ascii?Q?1pZprQOZ1lZNlbMoFs2Qs+d2skVg2yWt8SQAzTNt6a4KQBVOzS92cQnzOtaw?=
 =?us-ascii?Q?OruGfqbZ1XJqVd/d5j77nsbP+lk7DzY6ZFQtAxL3hBD2MjTiYwGvEhHJMvLO?=
 =?us-ascii?Q?11TILYssiOVsbkHChRcBKMquZShLsy5zFIVfnHvvk11uqurvsXudpp7xD/EQ?=
 =?us-ascii?Q?SwXgIKxzKS+hBDrYTaLNOF2rW1ilTo/uC/+5cVr90WGzKDXbw3laaBE9GC/9?=
 =?us-ascii?Q?g9mxBj8K/3S79Kroq3nsJGjW4VER6plzre1wBI6shNx5G1SpeLnUqAILZ09f?=
 =?us-ascii?Q?n4GavliTNBlESIakiMOjwGBO5D9pk7nxJLFLsfi+Lt9NOCAQNnREDMrW+snN?=
 =?us-ascii?Q?Uj7ZXcBkddFXs7/BmtT9pifkJq8Qe/YmTBGPUHj2u1VpcJJLbnuCiqBe8iTe?=
 =?us-ascii?Q?bSN3EbWwVA7CFGiWHe5xsedUWmM9r1UU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRn8tT8WK6faMR8yy/l63tNIOzwqNW5Txi2lbi7Rv1/c119jk9sIGCAIdHQh?=
 =?us-ascii?Q?dHW0O2w/GM/P+xjrtgy25C122HAQ1POHgRuC+iMir7xSINhGkIUAAg5KkIlF?=
 =?us-ascii?Q?Ms4O+XrK2+oi4fMXRAcQnZ1eTsPsEJEOElVym9C5y+QLrpDN6/Q1VwhqGI8u?=
 =?us-ascii?Q?Hiw2xoqAJAwEzGIjzmNghP0h4ubI6JhewZxLd46wpO9XGQLoo3CJKZtVc/v+?=
 =?us-ascii?Q?NRH68cJcRx7Uk7hARML+TWhyvew2h4cs0WHVtbkDVlx4C4JRbPGqr3DXe2VM?=
 =?us-ascii?Q?KWBgnc+CmasIjRoiyTSOvweHW08LKS3RlcwUx/78dqOXLRmfdjoaFvF7DRTf?=
 =?us-ascii?Q?bfxWsyyiuM2NmGqtYDbOvpdhJW1wLb72m+2wtClAMvSsCLPGP8F3jyb94H4q?=
 =?us-ascii?Q?F3VOxYTFek/qKXtFI2PT8j6WzX5ZXFBH0l2gOnaTxt9/6Sl4FFUNAEehsCy8?=
 =?us-ascii?Q?YIwMT8BBZUEA6WXyHye5vHe8un2IFxj6i3b7bwESpI3PUouKp+95puxcsYYN?=
 =?us-ascii?Q?ADwTP6dPCyGTbYs7Uxuv9VyN6jscxfARIML6lE/sf5pyAygrXClXEiGOq+UA?=
 =?us-ascii?Q?Ai72S3T6K/LmcLkREjUFaA77904sFAm6rdYexYzdoj8TkIlo1rlyEN0glFYp?=
 =?us-ascii?Q?r+XV8wdkizuuY5ivqOdyAHA3CK08NSues3DDwZtiZMwJYcssLNffFdgOqWD5?=
 =?us-ascii?Q?IYqUY0za1HztGOuSMWIcVlWjRGeU7qcwUJ8gBz4rz1A83RrDK8Qyd/3fPh/B?=
 =?us-ascii?Q?+jujfm4hIAnwpNjqqmJhkTcswSBjrWd7UbMXCDNqpeDUtHj8WwLNQQ0NSBM9?=
 =?us-ascii?Q?mQtY1ZL8V7z1wdXCvvjBApUF6osA0GRIjDzZnoX8KUvdXR+dDHw7uBbMijwe?=
 =?us-ascii?Q?SURAxNkMZDUGAp9hXSr5w1a0f9A8zdk6QsGbD/oq8FFCUzpKUOz8R9VZMeih?=
 =?us-ascii?Q?htlg9O67M8U+umUIWD6UdUPhw1oul12XLHhZ9gQUxI6Cvk5WSeXqa6eh9CFP?=
 =?us-ascii?Q?To0TpdKeOFErR2/ubRK5Zy6KHwu+vAznVckpnpu3X3tTXfiq6VE5NsKFJ8Fg?=
 =?us-ascii?Q?E+AhbFsF4tEhCpv3QjTEtzYAIp1nUQcBJFMIJi8lxx+yzElMm7p5UsB3HOQM?=
 =?us-ascii?Q?lXaQbVXxWsGYzfK7g0IaepNTJMRqSV5GVwAYptkmgAxwHOPKwZO+1Py/Zo7V?=
 =?us-ascii?Q?3frgKlspFpzV+NwbfsZAEHHCqQTKeE5xIkHJRI5fZm++3DZxW1dIUppQnh2u?=
 =?us-ascii?Q?Uc+a3JywotCGXsJV6IBDQMCH+yeuTfmdrMQt7EhGdfXjXNx8WoYuZcZEDtae?=
 =?us-ascii?Q?ShPOl6XjN2/QTYutqXuZWfzOkOvk/WXHP3ABs91XtDrcWYSA+tUt6Q4tvSoW?=
 =?us-ascii?Q?yaQGtfuFFSzIkIlxIw1UTUA+RrMYY4G9/c0Ri5xK+GTpcRZzaogZ29i4PiTy?=
 =?us-ascii?Q?zUBO45d/38FSw1DPK3L7Ticf+YbE5H6HFLS3EZagJcjD99Mqqoqv14sAz33K?=
 =?us-ascii?Q?bAU+i8ot98QTyZxEjFHYmPv+CErgho+vWsM8BJb6zVKgM2+BvlmJBUHUZYwQ?=
 =?us-ascii?Q?OFF8Mr45M1DrlGJG7T+xYVNrKXlIrKOlLyn3t1LK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193e5ad7-cec7-4959-1210-08ddcda68b4f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:15:34.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrKUCTn9rXe18H2cpNrEadSPW/GOXZnkANyWMqyQuG+swGYwuzGFCYojTm+9bPLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11489

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.

---
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

Joy Zou (10):
  dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
  arm64: dts: freescale: move aliases from imx93.dtsi to board dts
  arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
    modify them
  arm64: dts: imx91: add i.MX91 dtsi support
  arm64: dts: freescale: add i.MX91 11x11 EVK basic support
  arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
  arm64: defconfig: enable i.MX91 pinctrl
  pmdomain: imx93-blk-ctrl: use ARRAY_SIZE() instead of hardcode number
  pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
    i.MX91
  net: stmmac: imx: add i.MX91 support

Pengfei Li (1):
  dt-bindings: arm: fsl: add i.MX91 11x11 evk board

 .../devicetree/bindings/arm/fsl.yaml          |    6 +
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   59 +-
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
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1512 ++---------------
 arch/arm64/configs/defconfig                  |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
 drivers/pmdomain/imx/imx93-blk-ctrl.c         |   23 +-
 21 files changed, 1938 insertions(+), 1539 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

-- 
2.37.1


