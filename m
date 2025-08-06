Return-Path: <linux-pm+bounces-31995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2CB1C509
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F497B0694
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FE28A1CE;
	Wed,  6 Aug 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cS2ZX9H9"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01803274FFE;
	Wed,  6 Aug 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480534; cv=fail; b=Co7BnP2XXtogni4TPhaoHhMzCcuiiXxTb+sfHOKIjPTQxSDO+KMvxSGWIBWPNeuSVS37OfttEbE++z6snkf76JmS018706VDIITp9wSyxdetnbMjWf3tgUsUhJTlykqWVHii/nPWyANCR3Pe1XTmBc6nL3+PaE1TDWNyO8nlHtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480534; c=relaxed/simple;
	bh=VDMIlyZR1wUosGCWlSVapeVA1zbEUwC2hLR4V/m5B8I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AGCF/3HhjaLJXar3PWPYmLMITDvSF7PUaOlfTOCBFFRdrAMlkex1P8rMY7TEx5p1zSgftAyyITlT/TCRxcOocDE3MGZIgb3chnTOageR2LTVcA4s73yZ5QV7KaXap+NQUN6Oyh3DiolB9/OQ/14T5wcjfoBOSqz6TiemL+zXUxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cS2ZX9H9; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxGUIARjq4CZMMqQk27QqdjuQFMXf1BELXF0YDn/sqkSCWoBrWey8yQy2pGMyzjIMX2Bsv2/h6NSvpZSD6FCKhofdBCKR8Wj0QGbSw8mqEFSgHWC8lWsLpJAkaVYGlXdidX6lplxwlv17IYGMnOIkDXilwQLqre6r4M3gGpjOQ4AQgHgUmBBihHIao5oI7BYLfJwzx5J5f8iTp0Q8/7kzIaCuKUDVu0qESswXcGMxkOJTyEjvI5RT1Zoretf/0LVpL74GhIs843y0TRXdjEIgwcUgQXfWq/h+pB0YJWPE4TaBq/HykoU3VSEARihPTllf5bHJwvSt6fVtWLibnUIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqKHWw1mwSPS9FPjSAMko+hyTgzgjMm5s7ZkeYCv9jQ=;
 b=d0UZV+avoFhXHkTfPG1WGuYlONrrR4GoTtd65czrMlOLchruQz3VrMZs7XcbiisJvTQczSofqnhjt3Mvqugeh8AXCpK63Z8j29NoX7zqjipGdgCzGF1ibU8Wc1bzLOHO+MMTlsHZDHihelC1mk5Hn509bMCw1B21WKRvg23v4CUNSsikeCB7kyb/Nj74CWsCiqHCiZnq2tL3Xo8x86t0PWPg1UY3C1jVW8gvBIiRBAq4GZtNg7wUsmBSPv4jqPLp6NR3XDGZ0knExikjWx6yYXBclyQboZ8W/nreIGAjaWvpmcLX4dxVSM7ntQrPUHFuaFau7KSoj++EKl1UVCHLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqKHWw1mwSPS9FPjSAMko+hyTgzgjMm5s7ZkeYCv9jQ=;
 b=cS2ZX9H9Q4000B829iMQ5kPwosO4T8+3LSbBLjPfhFOIN4sA5Z0LIwG6VFOygq55vCApSpFnDzpBW1znp9COssioi0blEbCoEhiKdZRdeb93itR693WkXjMrHjeen6786yvjJDy4K5poltibBkghmghBz8yThJywtybq4+DO9pT4hi3mcFjHq/NZ1rfApUnl1+MJufuQdg14ASg3/ljAg38ICDZr7nS45KozDezoIIL/wrPFWh2+bkKutV3s9fBwdG1BMYJoC/YRznX5idqkLnYAUQhTQmzOot0H/3I3EnaelrTzqqy8U4KITwA4rwGSw0I85dyeCexO6QbAPunxUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 11:42:08 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:42:07 +0000
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
Subject: [PATCH v8 00/11] Add i.MX91 platform support
Date: Wed,  6 Aug 2025 19:41:08 +0800
Message-Id: <20250806114119.1948624-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: b537854b-4377-49cc-ce7d-08ddd4de45c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhTpALJwGdWzAUzrpO4Xso5/pS5jOJz0QG8ndbuzznsfAJBpRcb4xWALcAZF?=
 =?us-ascii?Q?J/8QSjTzXi72vUNzWvs0JzoxxZJhdzhcUb2MqXMgleDiLW9VRBqHoYKoLima?=
 =?us-ascii?Q?P6AMxvnHB1xN/mWbhZ9nbzL1So9W08aNGhL4Fs3rOxuO3/75k0eArL2okS82?=
 =?us-ascii?Q?O3MhQQEDQXHsvOCQIr6OALSh9PH1DNdrXicB4ik1tXJXCSfqqCg6sB8TerzL?=
 =?us-ascii?Q?MqSFNjG15uv8V5UAU0TucXHPoCcPo+a4CZB2fnokynv3z4CNevatOHy09As5?=
 =?us-ascii?Q?OQ3Sqn0zHySuXus0V4gYto+QG9TGrwis8cCKwZg2jYg8PgwQBiiEumjj5uMF?=
 =?us-ascii?Q?qe1rSkod//iKvmmddMzrsS9SkaQvDt+It7oEZajnRZuIEv3k9jpltJOgE5vJ?=
 =?us-ascii?Q?2jPO8sBqlBqpvd528tm+xZ6KDjj58V/uPdGOkTwU5YzLHwIO93If2HIMLhnI?=
 =?us-ascii?Q?bzVQqw/VRDqfQo+23YxW4F0CWo9WV/xL7rcRb4bmwJM5vYASHgLCINHSONi+?=
 =?us-ascii?Q?oZpTmrhR69QACgSe57pZVJ1IAX/DJaxHVNJmLDy0/qxQAGul6wn0tUD3CO8A?=
 =?us-ascii?Q?b/M7SKWhq5IlRA5z3I/nBqgnU8wH7SIe9hf0LAwdnIRNLI+50jJbfDvzgdIy?=
 =?us-ascii?Q?VrZxVXHusKDpeDxasXPLa7i2c6T2zwdsSCg+yG5+kcfRphZTXoW4Ax1aq4XB?=
 =?us-ascii?Q?Or3OCbyylAY6A/K9w2H2nh7XZTbpiwUAjD/CVN+zrgFkwrLEozBxhtM9ZETF?=
 =?us-ascii?Q?LX2Nq/AHOwVxQqf402CXbAUOCs+CZKaf/KshxzEyPUOk/GlLZoMwKnVPO2mI?=
 =?us-ascii?Q?ddtK+pID7Dc4P7f2D4opu96rQUBWazFjGQ5hSwhhmWBtkG9qBP1RHehqafwa?=
 =?us-ascii?Q?blmdON/KhtFpcTetRyqvZxL9tu9N7qg5sZ9hDVbnKBLjkIUfVcdklsphHkrQ?=
 =?us-ascii?Q?joeTNQdBZc2njXKJ2caVyiyDIG/mZbB6+x8195VbXg8h03izgmY6jS0EoAGs?=
 =?us-ascii?Q?Rv7alg+OurOnpVAKXsXL+vhWcNSB+LXyeXlFK6IK4jczPp2zCgZRls+A/AgL?=
 =?us-ascii?Q?21BQRmvOQv6Xj37pnOjLtUjTDH19S42rcCC8tJ7gnlVfGtbdPhAz6g+ohxFB?=
 =?us-ascii?Q?cBFLVgvWjSjrqAymV3f2Rs7hfvTxrLwooFSeEPXalFAi9Rx0bEKA48hBEFyf?=
 =?us-ascii?Q?6r3oCUo7QKuxhmt9Wi1X33eU/uL3dFpEaFH2WXeIKiEN4rR2pjQJa9/PTfkv?=
 =?us-ascii?Q?2xOOj2wBv+E5p1u17I0HmkdFm0L9xKL4NSKwinTHfrr3R68gBUtFVn+zvEKF?=
 =?us-ascii?Q?WmYix7R3NyqDCn63E7BD9h+veWNZCVvqE9vWY2cHCtE0BEZZH/RLl5b0eg21?=
 =?us-ascii?Q?LZf5Duc065OKO03r+I5XjVZO+zcm6Pn2mzhEhz8OKfYL00sOLtDse/vnb3nv?=
 =?us-ascii?Q?Ovrs8cg72O1F/Qqyb04MfaQGvtuqynH2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHEprWjcmExKaDTYKNjTKgJ9iO4I2g0qYQwF/bcdeOVu0eeGPrn5P9j4M+6C?=
 =?us-ascii?Q?pmbxWSgyntq605ulPlWjmT6NGpHG0/7866uNErIy/oVuXKE2QdQXo7TTL46l?=
 =?us-ascii?Q?4DDzHVpPZCYReZvcBTedmroMsokwhTGSKR2xF+SxcX9S2T4eC3Zjm4VFZy4g?=
 =?us-ascii?Q?nEuaU0AMFvlwXxc9rz7yfpdnHHZEuFcN/o6ESyMHaxU8Og4dY4x4bkOfWrO5?=
 =?us-ascii?Q?e+UR89zV0PWDZ6fY9gUx9NN3ZYsKY3OG9p//LzTKfWbfjpmj/fjynbJL5K0C?=
 =?us-ascii?Q?DuayVpd26KaHp80ssKipjHh3bGHd9rx1m9Uiemf+L4gf4mmk/crN5AjH3RK+?=
 =?us-ascii?Q?8aEs8Mozc0/eBJnzHl/bcLOBYEQ517+B7qhpk0U/bYncvDp0Qqp8dHF4Xw+l?=
 =?us-ascii?Q?C/zbBlpSHBsmhm9qZsQumtlX3efI/vX1XN4ADNlUCh05oBZniuzbDZrdA+bO?=
 =?us-ascii?Q?wTTs1RuIqvjPUf5oZ4iLzE7mDgI528DSyvzMQZ0vmV0u1KlYV58VqRvExT5a?=
 =?us-ascii?Q?144CpKqKJDPYOFzdVGFLmY6ZaPq3oHQTVqsNLCsdjn9YDGwhYaeX3gq5qPSs?=
 =?us-ascii?Q?c+7JXsM85daBtANafO71YPh1e/CpJRieuvCq+vek4umYOVfwmLIjKWiOdo6J?=
 =?us-ascii?Q?IhStqIKsvwOorFncYPT9ERx5XBRuzA1zonmHrA8TaQq9MJBBI7gmQB75Hq/W?=
 =?us-ascii?Q?ouJtLhtGDC5YqshtdlKQpHwRPq88oABzitd5Dci/u4lxAaQQ1S01b0zhE7Qr?=
 =?us-ascii?Q?ZVxikqrlYasO9U65n8TPvJXDL1cEapt0yEaUqTsfsIKAVbR1+GqrxP61034F?=
 =?us-ascii?Q?pUKsC8G5fmiv5FuBR3kG67CYtLThMcUPnYtn9ZrkYGL4cGKh7OeQYc32Y/st?=
 =?us-ascii?Q?iUi0D/SEbwiDAMr/oE0X0/cowl8vvcOBcHYN+3mUKHkSckXmBG0Kx/AFnt9H?=
 =?us-ascii?Q?ZYy5dQ9Z2EIlckAQk+7FbVGNrXFVV6GV9B0UYUDjl/99AGusCr//FwIsxQ7i?=
 =?us-ascii?Q?aoSnFPnq20L+kB7qLMnAX9y7RJ+Fwrq9T3vTbzl3NmieYRv+YZLhRJG0PKR/?=
 =?us-ascii?Q?LcQnnTP8JA5jIDkfkKx2Iy2MD/79juo0HTUUZWbh/MJ0NL0pxDElCUbjNXz+?=
 =?us-ascii?Q?XLeeE7ElE6l8kMBW3OHhPB/psLybamyP6A8hvz2pMcQLjd+/9rP2jGEOn1iK?=
 =?us-ascii?Q?5Hv1kJUlzdfVk2m2tWYIQz7WPtAb087leC+NbCOF9YlwGOtfMTUIUleKLf/V?=
 =?us-ascii?Q?k0hH3buDe9FtItWealMI3tSk2TjJLhhB25cwc+AEsCxOqmsSx8o/ags7g9NE?=
 =?us-ascii?Q?vBvhSmPootTowxQ7fkaNumCPqtM3HL7LMeA6oB0Ov3wJyr5Dd7PIoyY0PlHn?=
 =?us-ascii?Q?It/b2VmCEI6/vxeOt5uvDS60VpcBrxnAQdn44JFQhQaS+1SRWz5JTf56YBKd?=
 =?us-ascii?Q?lk1KF9VQwKiK3AYCauSlQI1tIWCNaIE25rAFsEO3yhw2q81OAe2olSIf+RnN?=
 =?us-ascii?Q?LcRzGw8UdVaRvQKWEXaS3jt+uw+jBovw7LCz7+JQNCueG1eORL75PoZOxBUR?=
 =?us-ascii?Q?p/1UWvVvqdo6bPUKRXf9QkJPmTEKCE8CvQqjpKjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b537854b-4377-49cc-ce7d-08ddd4de45c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:42:07.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my6sGuj44jZYkpfxnGNXmCgcZsXt1wUPNb8A8SgTsSmfSLlILeLIrXSUCFHLyexD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.

---
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


