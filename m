Return-Path: <linux-pm+bounces-32006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B329B1C54D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3375017BAA7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397A28C2D2;
	Wed,  6 Aug 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZJWXwYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997228C2D5;
	Wed,  6 Aug 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480653; cv=fail; b=BNVFJrGlN7zhoLluLgoTtp4rufObU1+Y3KXNl5MWOFNqQ3FCJBLaQYAPn6BVWOUAv0ZiZ0/HfwZjb1nyyEPGzPc+2LYmTpFXTZCBPZ5lx0yuC9UuiVo+z0dcUOyYYF0zK3NoLbEPihV7bRh8mbOgr9bnr+JSh3gbYd5+1ddTTS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480653; c=relaxed/simple;
	bh=3iHc2SsQQ9MjZQgbCxBO747dyFygcNOJ40xm/1I5MVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBSNjaI5mDcFbuTfCYgiBQt18ZmYkiGAJqg8BT4UF8RWs5S55E0oi0twZUGBRAOCqkknWujRgOSEncZN0yrc/jv+/tDjzp90jKh2xaE5mg6nBiU9Pvqz4vFLxSiv2jwReMa2GTj1CJWrwwcuJHDKvE0kn54226xZnMqBWUl3NKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZJWXwYf; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaEwUNb8BQK9qR0i0q6/CYoddd6FPJn2IU7aZTpwYM+sTgQP1THmT2KqViVYaULerswKmLBUYHQnmPqADSYdXK6zDfwxEhLghvlmCHcEH0q/nRqiFnyqDfXipELBtT+CuQFC3ZrIcil4qrkPE64saP2vPmMFf6QJVzgreb4qv5Wd/A5Y7hbdHyEJ0BpBqq76Rbeq5bAhBU0Vpc7/NAMT9Om4yMMPniZD8pJV9eH/pXghaWIQXVM9a5CCkXzPWZWP4cWQAS4EQCQFtYk2RFY+KBSYxQJD5Kvzh5k6IeoEH7V6++Yoh1A7J1Z+syP3H1Wd5+ZzjreESWPMQy77oEh/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYoqaBu7fYjbmRWy4+bmWCPbZ7C5Oi6/AZ9bX+E4/hQ=;
 b=Zrpdmcl3HvNx3NTsSr+M6adekLbxI1/wvD4NFamn6FaeMWiwuyOb24O6ceZHfnFcobcyAzONADtt4OacLCH5CeNUmIU3ogHAWs7wMhlcMVz3lI6H3jrm8ysmpAqI/SwaSO5IsFGFf+1RbV7u6mQeOJWrbF0hIdbTbi5d5oCkAW1cGoPLuAICl5r3IJAssACw1itldQ/wQKixctyjJuhIwmfcpNY6TwN4N2B4tQRNThe5pyUwythILQ/26sVmebVuWUjJIezD80RnD5W6RYLsTHPmSHNP8cUbWMFWmioXipgl616KVOqGHHMhZ4hG1mcVyyWLhWxWn5a0GJ7yPlBeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYoqaBu7fYjbmRWy4+bmWCPbZ7C5Oi6/AZ9bX+E4/hQ=;
 b=AZJWXwYfcDNmgyViNhuZHez9cwzQTnJtwVqw6cKbg2HpfM9XqgHFQ8gFUV6Xgf5DRjPLmlC/XtuDLcOgH3V2N5iDa2/kNp9o299qcqwpP9xta8f+Wjs2+03kdYYZ5c7Rkc2x8CPXuMEsOueq1o41xRPEjTuIjw+YtfQnZXSQDEdghO5LAFmY99VW2IIUVrBXotEfrBB1whFpkVF8I8/vl77573iASyQHfb5ZI72lU4YERKXHOVwqJ8u02/G9l4Lv3ibIPP7jlsARwyNU9r/tYDL5PaTTgtZp34MhLlaxHwp3wCzxlr2JWAi97bWKw4ZXYucHwYwlnEwUj4P1IUwjzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 6 Aug
 2025 11:44:09 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:44:09 +0000
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
Subject: [PATCH v8 11/11] net: stmmac: imx: add i.MX91 support
Date: Wed,  6 Aug 2025 19:41:19 +0800
Message-Id: <20250806114119.1948624-12-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80f62b80-1f51-49a6-c9a3-08ddd4de8e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLg5eDBJE0p1KKB9WtFGzisEYVSbojF2FvxZ4NqUmERWVQtGmWfpfY3OhQpt?=
 =?us-ascii?Q?MFkQjAX/HpyIQtEBVQ4gH7HtdcSiA43x6BWqRCONJbC36L/9Jdu+Bv+q7FoS?=
 =?us-ascii?Q?9XnzI4h31v0Noxz3IqA75kId90MaJCsSF8OLpof13e3hRg4QolTMucUkkkFV?=
 =?us-ascii?Q?Ymy1fJqPxMZrDO36yV08sGiTIvlF9/NysnkWnd91hcf9o5CjUoLjZ744pkBl?=
 =?us-ascii?Q?vlRTCaYZZEamk10wH/YrO5yYXeI05vL+wbC68MP0YncrJAU5b3Fe8FHUEYO/?=
 =?us-ascii?Q?MN03p6w7J/yyxLJx0iAMVEwi9sIGUnhbVgZZ0kIgZ0Sl90KJhYTtHM45LNrg?=
 =?us-ascii?Q?XTMfvTEpQOQNsIX5IqSl+YpG1wWjLeUPmQ44oAh5jxpViDkfPm6se2avH0OH?=
 =?us-ascii?Q?31nw0k2LEjqQX9c4Jva8s6r4tCsywOeCFWpK41fiyCKLdWcAxCRxVqnZhY/B?=
 =?us-ascii?Q?6n+9P5NiFzPjzpMLHgIsSZggCLc40lnPMwl3d5hstcFXAgxervH/dGeU3RYo?=
 =?us-ascii?Q?EJbh4q29ufQH8uAtmug0oRY/BYU+ErZXceVbJXe+6gvVqLcg2C7F0gJiwGiu?=
 =?us-ascii?Q?2OYiUk544+zUuFnighuoZl9UooUoZNISTrL8e5IlubcsnI4+YuTT3JuZm/JP?=
 =?us-ascii?Q?vugXlsu1bLxmlrz1E39eA18XKptm8E1Bdq+ZmcPkRX/xsxKlaVHI2b1ei5V3?=
 =?us-ascii?Q?0ojMrMewHJqoRjQAWXvueueN5WVKB+0u+KTwAGzqcKk//9NJ/rC0hNVmXrPV?=
 =?us-ascii?Q?Uj3CB/rPDys//uZZOaulOljhqz0OrT9zsRhy8Q62OGCuYSlCyeTbHlWC9ekP?=
 =?us-ascii?Q?NP9bVyo7wFYymikFtLtU/FRVhBny4vnRsY+GMuZQDXdsDDnAZMi0qHyqd3ZS?=
 =?us-ascii?Q?H2LJrr4H0N/i1pAB3OPOjSUVvF7gBVvNlUFB0/+83o26EpM5V696GEJtPUxN?=
 =?us-ascii?Q?JGSTCGJfRo8ircZSQNHo/7ySFr1NyVFJh1LCF8jGqiQqg1/sn2ZDLFySIYsn?=
 =?us-ascii?Q?gLseRy0m8skdMCxN7urBSVkhsCSGRD2iBWbMgMftT7brwhTwNlVorrqsKIyz?=
 =?us-ascii?Q?PODR11K/xPauvQNjdkngjvqbtCYFor3C4Rs0bjeZ1lQ1VEOU3UYDu5zhgDqC?=
 =?us-ascii?Q?RKMugUr+EDMSKWAS7mduYNwd4OSwX7HA4LsLuw0rEEGHqMTaBSXxiZGRk/A/?=
 =?us-ascii?Q?YjENI8yQN5vbxiN5wxHoQ+aphknzp6GdYwR/FCdLwQWjboWjFoxB9ui0JLO4?=
 =?us-ascii?Q?myHzTmAGFwBVncO2AC/a7t3NP5ZxUr9dmvdUc5trRFWO+OCgKh5LArXupj9E?=
 =?us-ascii?Q?fpWM4hOQWPeY+/ByKbT35R/1iVreyTGV5NATUS5niDyNSvUeL/e30IENb6KG?=
 =?us-ascii?Q?layt/jojuFp8dmc0H4TqQeluW8pYNuFdLpuVMrsMSyCbooE+ZRq06B4HuNSY?=
 =?us-ascii?Q?r8SvoTeuW+xD7+muKo8VhroSG1dbooy//VqJ4yQhKy4d5aV5G8XUg/KO1pHO?=
 =?us-ascii?Q?0n8P3w74HnMpocw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLY4NRGT33Wq3YIB8A5Tu8E+3m9xQdl2YJwQ8MnTl9OONBapKTQfWKZIjeu1?=
 =?us-ascii?Q?6vSiT0p61FArAQBWS81Q8wac3ENNgGRHMjj4aO1KnhAAi19exPrcD6416umL?=
 =?us-ascii?Q?PpHnKuvcu6r9UjG685sZ87B+hvr3SK22TsMzc7t+gIId13I7tpv285tq+X5C?=
 =?us-ascii?Q?J18F3Tzp9kq7GTTnGH0z+Vycmdpwa+qVYjSpRyMGy0nFNo2cf49SkF/+oDkA?=
 =?us-ascii?Q?+YCkxDtg6/f4Ld/GR0sLyLKmu9E7wH/epzwt8PNVKiI/3NaD2V4p4CP2y1zA?=
 =?us-ascii?Q?6VtgrjU3Y14o3MufxBWBVzNTvOmlqMYCnEx66sVuEi7bSnlF8iogQF3p11Up?=
 =?us-ascii?Q?lQoJeGhULR3clpIddfIjfJS0hgWZ2TW53E+rdQpIl3wj1EJh/qwydM0Ydua7?=
 =?us-ascii?Q?YYLnqypC3TJ+Wv6oSGKAd4tu8jkly9KMiFq1H3vrDZxMhyV1bO6mOk/OBrCs?=
 =?us-ascii?Q?qmmb6r+kx9eaW2S5q2saqb2R4yXvNSZf14ltvfMI4aZk/eSu22bIB4UpLh+X?=
 =?us-ascii?Q?LQDhk6GZgRiyoBfoJ0lF/IVZvDBSd4H+l1iwgHqjpTyjqqsJwl0h1u6mxsbr?=
 =?us-ascii?Q?Qj3k1I3RUOCccQ643HWu0R6XGgOkbwVWwgPb6hdIPGhK1uFHcO0GAnOE1Obf?=
 =?us-ascii?Q?mdF3ogda7wR3O3zpruMHj97fzinzz8uBSiq/CY/qJMlIJjYhS/ipOa4x0G6S?=
 =?us-ascii?Q?sotj8aOMIs+EszRa/Bdz5pjyqpfJ8L6l31CjrjSvPaqyEvW+u3yWfJrkvvPx?=
 =?us-ascii?Q?XjOeaz/xH4fmswtixxTF6WuGBPvUjmNwTmnX0xEelKUJ658iKS1bOxemecYw?=
 =?us-ascii?Q?4wMJj3snCbfvOBO3hC7AXy5170Tsn3/VjB25aTSpzvKXVehxV9p0WwcHzY8x?=
 =?us-ascii?Q?tUzsNfmi5UXWyuFozpINAGOLlFK4pegNCH6DtXrsNb7H0132+XlJz50YxVRs?=
 =?us-ascii?Q?EP6iBzz1avV0uQadZvoL3Dd36LhU5V5hSXTqepiBpVZD4k+ZNTqUAALCgtNM?=
 =?us-ascii?Q?GVU5fTuzsGIFCFBsnBLWZal3GrzSZFVbeIx72khwNXNYfPoHkJ7uaoNCzGyY?=
 =?us-ascii?Q?jfFym0ZHXpXsFDlUmro6CyQuafV2yIFbfYMpMdW6Cig5s2ktYCzwHPIuFYeX?=
 =?us-ascii?Q?MzWTX9XWze2wXnEW962ww0lAldxuIe+ZfUAfDoMkQJknmLVlbM8pZBVenhKB?=
 =?us-ascii?Q?QV49aZUiof1uMZDh81HKn1AeDotsUzywWtmjp5z4WB4Qmz2rP3vqwoRAsHdV?=
 =?us-ascii?Q?AGENbry4BNmdA27pHAuv2lB1wX/xN63nGE8Ia06DhMLy6PT0wFfDXynKQzs6?=
 =?us-ascii?Q?wWiVljgkeZvKd6YlmKZYWkn+k4eKESU0SglbAA+/eemh2vVZGrqKaUB37M4C?=
 =?us-ascii?Q?1dD+BqRdh41xHEAq//QSKCLKs8A4AbFYXS7okSOXdYonXiwWureWA3+yOe53?=
 =?us-ascii?Q?WQdz2fFPTClIvbmwvT1VuBNZSaglKCLK5ihKShEp5C6YShe1J23lb9gvl6Mc?=
 =?us-ascii?Q?t80I5e1FFoWDsArDahTOFa4Djnu7AakqTShzF3Ahq647hWbShXZg3iKztIzJ?=
 =?us-ascii?Q?aBcB1i2XDlqxKh5MK+3GIS5uan94aQMBEJsisKR4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f62b80-1f51-49a6-c9a3-08ddd4de8e6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:44:09.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCyIAW2ZnkNp05LukQfSDBvJLSTN52dkX+1D/BMpqY6YorlCjHVqOE30FY3bJQmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

Add i.MX91 specific settings for EQoS.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. add imx91 support.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 889e2bb6f7f5..54243bacebfd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	dwmac->clk_mem = NULL;
 
 	if (of_machine_is_compatible("fsl,imx8dxl") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		dwmac->clk_mem = devm_clk_get(dev, "mem");
 		if (IS_ERR(dwmac->clk_mem)) {
@@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		/* Binding doc describes the propety:
 		 * is required by i.MX8MP, i.MX93.
-- 
2.37.1


