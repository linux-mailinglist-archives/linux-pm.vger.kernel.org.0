Return-Path: <linux-pm+bounces-32004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E3B1C545
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5045189699D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CF28C032;
	Wed,  6 Aug 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c7Bh3Ey2"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9F28BA85;
	Wed,  6 Aug 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480633; cv=fail; b=ksD3nINZyzDcbdX0Q+Z/uFIfTIFRCC9iCwriW3Q85XwgoWoemaARRmzeWAQvBuV4wRw2+YUaPYj6MA4MCRGfDZEY82eHZ3BnXraXlxG+nq1rZ5w9FdnJeHhDhbflpLyafoRdcAeMBC+ftFJ/95B5NploVIn83hVXT8ywITwx8Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480633; c=relaxed/simple;
	bh=s7nS3jQqvMQe6+C14ACGI9eIXsOKUcQQVW9rsmaDRbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDiPbtkg4aZmGd86/UErAdsARD03gIUEzrUFqvS80dOVIYFzYIzthoQ/FaxDrxhy1xvPE/aFFloG5C4ZIN8nWcE2aPscRZrpuukfjnfbBkpo/zxyB4KouRtbFwBeb/QzZw/HhahKGv5Bte0QulLUpF1pwL0t0/g7XZvgzLAONIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c7Bh3Ey2; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APasWF2WBGPFuoCyjQzN57KzbgJgOw4mQjdXpKmPjBPQAZF7Va4e9O9hqQRZbi0ys2XDuXJTgpnzJF42+0A7KlQgjhgzjy6p7xBf/aXQQtXvhyZtNEF1jGtxihdJkNdyomOigFNIjxVwyLSypm4kistuzlxEJR2MmXYTRvya4voJoi0UlTrtNA4q6Ht/weJQTkHpjcTurY8YzI8l/Ef0a9cBYK8UIrayIq0D5hiDn/XJqsvaCnndu0/QdV+xkDovk+FJHBR5SEQz7eMO3k2MRjUkE4dGZxAzdPCCreQGB/s6ZN2qAd8yIidBjyBmFQlVOsVUnkfdVOa5JeX0Z7QdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0UVDxj9no2QUIxaEfHeEqPlJIc0A5GJkUbBagrXRNg=;
 b=h6N1bP5wvDJMm++tP4uFFdJy3ek9e7svm5g5Pu05eE3cDUWHUTzGSCfaLrrDYJORPMbI7PAn0jl28KFmkwSMEa8e2DOSVymOpc2k/6ToWsZywdrGhQkZiI3WRUzhFy4tJRH5VkcljwRP2T0LW1R91MpK0DeQvUO0krTEXJwq4xwT7qHSa6mIV5WctEQUCpn6c35wBJVe6ucqcERtZVQk4EiAJJuaccn9W+XLI8uFxwZN+aTPSTSKsoJBkaiiei6+EOAmhMCTRkMp8288sbceiEZmH7Ej7OD/YSK+R2Ed5qMGoUyJw0odLtVGT7VA7f990SDWh8vptuFCzbl27KY7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0UVDxj9no2QUIxaEfHeEqPlJIc0A5GJkUbBagrXRNg=;
 b=c7Bh3Ey2K0q0PeN05Bi+H/ZfY8Qa/i74P7jAPQrRwMsgejEMF/1Zw+DGs4YJElr6JqGL1d2SNRzIpkNXkOHBsLoh8ACuY/Jc4+P7Zp91+YE9OZtvlcANpZz/mzcUTsan5AQjpqzGFPTM9Wogca7Xncg34KKOdb33pGJcNrFkRLhCMeLBgO3HUwSTspdSuDTAHKsts3qm7Tp6tN72cRaLEBWNMIoCBkuz5JDHyFqA7osGf9OIdVyVwu2DJkj/gq4PTwbHrEHJB5mjW5FeTLt3EuveaT8FGdQFySctaJl0PGBJpmuxBq/0Qfd68K5eKkR2+d9seleHPLtYOGe1Zo9+Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 6 Aug
 2025 11:43:48 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:43:48 +0000
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
Subject: [PATCH v8 09/11] pmdomain: imx93-blk-ctrl: use ARRAY_SIZE() instead of hardcode number
Date: Wed,  6 Aug 2025 19:41:17 +0800
Message-Id: <20250806114119.1948624-10-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b16ad338-1926-4986-1c1f-08ddd4de81d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V7pYG8mBfSqKm/hrJ94L0T6tqwynkYQPeQEtJ/D2qseRmmh4BjAW2bCfpgga?=
 =?us-ascii?Q?eXsX8mm0B+H2S0tZZYg5kp5ZllgDCXVOBgoG17ouCl1+FIenGPEJIdA/NYUL?=
 =?us-ascii?Q?beIorNW0tWP1ZKX7AfnVLX95XRfqrJRLZSCQbKtYP6Ayc+2xgKBsBPLej0l0?=
 =?us-ascii?Q?cVTM8RWk+RZB+t9IY2VfgLIR0OEKYWoyWfRj4Gy4tJ0zrHgGKuKmyrP3NjZZ?=
 =?us-ascii?Q?klWBBdfb5YYq6nXcZWrzl9vVZyLjvYwTAIUzYEXzEAZRyssG2ihKdyliaWkG?=
 =?us-ascii?Q?t7SIvL4KQ5ahe/ZOAq9tIynIyfuCAfEms9NniVBarqCBWp/Inh2CZA8zrPSX?=
 =?us-ascii?Q?kZmtlW8jDSj+MqpA+HdeuBTs3mUAZ6ptdvIPitf9I7HkGvrS4xVhKtL6kjRG?=
 =?us-ascii?Q?lynyC5nxIvfZBD5LFdpW4JOi3OAUaJnqG83NRSyaGKAMX1vTCwr5r+aj29Mc?=
 =?us-ascii?Q?h83bL7zZKDFxP172ETCIIBxKBvPuPvxJp3FwlTXO46vVIj8rgaEHJY0UQBTQ?=
 =?us-ascii?Q?OfxBOwBCedrm9eu2kt+9Rjw2rOmrUsu8IOMkv9AoPzVJb8oU/ZHvV3b8eETT?=
 =?us-ascii?Q?JIk1PF6acIGKVbAFt55NEFJXfAlqAnTEtHmS3wquiHUGCzpMsn2vQlFlbCcA?=
 =?us-ascii?Q?n6jJMdy0N/3p6v9gWpHgqKDFHH4k4Jm/zLIELupPCmP9dZQ+rmtThfvW4cBF?=
 =?us-ascii?Q?cK9CEc57GGnI6pLxQTieHhaV/J8yNJdXC90D9ADV9PROatAetvVp8g89qG5A?=
 =?us-ascii?Q?P4BZtj0tyDBFIhNw5hOCrRSn/xH4IeCESdK7YfRO9KLGuHSYbseCencF17AF?=
 =?us-ascii?Q?zxOoyF0G52jAec7pSoTDyR8fV0B4KC4VWT4q1zP+0OTPYLrK+eIVPdhMajD0?=
 =?us-ascii?Q?vP7Sir/wHTVc39kMTU6CYyMNg1Lj1+RrNsTuz2GsVVKFB9GXTgDew0QkkxtF?=
 =?us-ascii?Q?InpZ5kxStnQ/cON0hHQkdoOHj/xxs+SZkfz5JldScA6E5FSZz8Lry07TuqVM?=
 =?us-ascii?Q?cDKXnpcwlob67p3UWNOtW00shzkmCIoCVSolba8paHwNxamwby7Bt1VVy/1o?=
 =?us-ascii?Q?uVXGxGIiNZloiH2D49ENs5BE7p1TBfa6xruBXvhbGLo2z6VvMmx8nGQXVpJT?=
 =?us-ascii?Q?KHnvlB+kiM4jJ9SosKJqN71a8i9Oi4mQjCmcn4kKjgsnE5cSn+xvHCYEoVti?=
 =?us-ascii?Q?Ggl0vQoOWchhpJQSNHHh8xu2hCF5ygVNHOWii+fx3+LlA89du2DRi546R+BP?=
 =?us-ascii?Q?uvVGuLWeoNjLq8U/ORTA4t1LnMVgKcYNUyjh/PDe4JkG/qns+A3+729JFj/D?=
 =?us-ascii?Q?a3U5QYWCQYPhmprDUUDUfx3DnD1pk+9KJrqjVpeJYzeI+KFqzMiy6REaVuik?=
 =?us-ascii?Q?/I9EnQycsdHKosHsQql8C9gIt7f1IGKffANXtX8cee2+DTpbG4vuroXIw3aA?=
 =?us-ascii?Q?VB6steEGbCG/Hcnn5IKlMGf0inPq4JVI7dob9AlJMO8MLLE0HQCQJ6l7NStj?=
 =?us-ascii?Q?ErC8fZmAh2C+qS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K3yApO4E6kdOjB56WGZjFB4Z5G0xgFkgHpakZQgMvIBbsM+SEI2Y7BVBFDLR?=
 =?us-ascii?Q?YmiewncRoJ1ta66I43vTiUKtjf76sg3wA1UN0heFGsBqFnUAf9ZGwZ4mPL5d?=
 =?us-ascii?Q?7FDw4W84k3mENsW5qaZJAIA+s9gEUZ09Ic2hrvy3i2iBVHd/pZ/HO80AARNk?=
 =?us-ascii?Q?IIsMXL1lftgenyQCE7gAy3IG96064yLF63pyfdod/yrixfbiSprcUyoYrj/h?=
 =?us-ascii?Q?kDPDqQCgywbmNWSGWkOMtpSG0dq4F38ibJmPKNGi5XU8Nf+sYZnsPII8XUr4?=
 =?us-ascii?Q?aUUrvzzHscj54ltkLQpXBhcwDeIui4OCaBNjW7XJ5KY/JXzLDeh9cqzt0JxZ?=
 =?us-ascii?Q?7VEvo+3sKdq82QAE2hu09AogZE/XPz9hEDQO2Kn7gA0N7MeR3nAwB9TKvCNH?=
 =?us-ascii?Q?QBfIDJETOZwfrG2SgMwTEk6G5AB9WYAnXMD4RdKKNif3ukSZy/UvjuQU4pgC?=
 =?us-ascii?Q?fwE8mQJikb6m7xsf2ibCHPgUCz6OQcxa+XjkkPzN9OpmzQU9A5+Mn+qTehsr?=
 =?us-ascii?Q?Hy3l6QfaersFnl2vhERG+myplcAuj10StzxGOB7JB7FMhMEEH09wx/zbQKmL?=
 =?us-ascii?Q?9NOWZ+PEcGHAJXlXoz7494d0fKb+IMFvK7MDwqY0sTq0m+CwHMgkT1icChf+?=
 =?us-ascii?Q?ATeV5RsaunaGbP8b/nfkEgNLKdYVOLvM5Uyota68SJoLU276/nvSd41/gKSf?=
 =?us-ascii?Q?KH5syxwXQ04LRsh8iv9kyS5px+I4wbpHLKF9qgHsfl7qoi8VvfzOFiJC8LSh?=
 =?us-ascii?Q?SmyWXIPfv2Q5CxRaUbQNPiFAwx9ioWNtzxJFBVM9f3aYbkkhcX0kgRCrGzBK?=
 =?us-ascii?Q?5IIOncb8BM04ajdmPAWoqudmfThH3pThJu/4MO6k6V8UerGPK/p2KGsCtdHf?=
 =?us-ascii?Q?LW5UcQBnGFsrW5iDujKeU7m7i/93prN9k1Ie/JViKSyhPwfT4T2EXBtOOfI1?=
 =?us-ascii?Q?hLbNuZwTdqxUfidhOb06ohmEyX47pmigKmvVy8/HZyXiUYbUVjIjHX2Z0S7q?=
 =?us-ascii?Q?Vb59zC24S7dQhlNYsbOP39ktP4/TU6uIQp30HwbEFEMjTePyaDoby9tVvRwv?=
 =?us-ascii?Q?w5oNF1VWStRuAtj3nI+bIbmkFnLtkwcOgXiyWCEW4Eo29oYPaIuBNDynCseM?=
 =?us-ascii?Q?BKG7eQHVbvVemc30CWf4X3pHOG1WjfqInaMGSfYgOJcqrJgNvuiwCQX1lW4B?=
 =?us-ascii?Q?jyApfH0Rqfxc5WXxMD6bP2e3PaoEsXjsiG1d7fdrdFtZ3dgQARElh7IJ2EPc?=
 =?us-ascii?Q?X4ELbouoHt+i3PNmq588WTmnSsIuHZuhOWdJQk3SS3m7GETvry9/Y5lNNZSh?=
 =?us-ascii?Q?FVx9ku6lkTwIean2QUtgaiSOqKZ9LJ8MSFOWSvobR2enezETUINuni3/6I0n?=
 =?us-ascii?Q?UejoyDQUEd1PIVcdR8dtqgJJ0YVDMLkYo12ro+zCXoZgSS5XFQYJlUFjJALA?=
 =?us-ascii?Q?k6GjRIY+ynA2xCOLXDOWmeB/yPfUqn5oEL/61Xi//49u18fABZa6iW26hvRQ?=
 =?us-ascii?Q?YBEVdtO3+cOXJyRBzHLEGcF5I1GAKtNTKbdDj8+h98xUn9v3mDHsh8cQ8bGz?=
 =?us-ascii?Q?QzGB/3600Kqxt4d9n/jIyRdPqSS3gKsgFLdg1IIZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ad338-1926-4986-1c1f-08ddd4de81d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:43:48.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bs7tUIOyFfc5pqQw0wXj4q+Ad5jhBM9szeFKjRxOmFUR6dKHJLY0VJ2yraIhR7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

Optimize i.MX93 num_clks hardcode with ARRAY_SIZE().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. Add new patch in order to optimize i.MX93 num_clks hardcode
   with ARRAY_SIZE().
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 0e2ba8ec55d7..1dcb84593e01 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -418,11 +418,15 @@ static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
 	.n_yes_ranges = ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),
 };
 
+static const char * const media_blk_clk_names[] = {
+	"axi", "apb", "nic"
+};
+
 static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 	.domains = imx93_media_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
-	.clk_names = (const char *[]){ "axi", "apb", "nic", },
-	.num_clks = 3,
+	.clk_names = media_blk_clk_names,
+	.num_clks = ARRAY_SIZE(media_blk_clk_names),
 	.reg_access_table = &imx93_media_blk_ctl_access_table,
 };
 
-- 
2.37.1


