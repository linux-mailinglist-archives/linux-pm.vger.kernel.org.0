Return-Path: <linux-pm+bounces-33004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9FB33A6B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388143A5676
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5812D0C9F;
	Mon, 25 Aug 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UID+LKC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6B2C0F60;
	Mon, 25 Aug 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113243; cv=fail; b=XmKQErodXGHO3znD259OlktFlDFrT+ogzIYHbhr0CCn5Ye28GzyfY+q/76UvQrnZnm6+LPJ6XtWEvX+ie7ftIAKE7C4WLhn3TeJmi6lx3G+gTy5EuDaI9smgAUD4DQKb5xcvNiVo66QXXT5RVEYhzpNCck6x9/avVsst2OBlpDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113243; c=relaxed/simple;
	bh=hRyxQPm/Z6PmmvYi91ovQt2xSJaLnAQXQVMDgo9N35k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frE3+9etuqrbTX2HVb48M1FRAtkbYKIqiE0BbpxlLG3DI/QsFhZ9FVtvaE70FG5t5tsFTc4gH25l/dCYmRRff0t2NvGyXArqKbgsrrQrjNjLGyWi523N3SYsqnXdwNGwQjAfo8UNl152dqzR9lXtxIcj7Jcl0oCwLFoIlP/NVEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UID+LKC5; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRA+wRjOPpdbbd8OuRM914RvEd2gX7RDnNjbr1PeXoTR2uDiCutejDqUDxHzN3WDc6HGpQHG1XgUVwKpJSPmJ3sqP63LSlneB0mk2wZ4D4D5qaU0F42HW8LWjvjQ3LkposLhn0efRkdVGu4ShUagc1fU/De47nO6o9B7Ob+8s4EgR9vKXL6q4JriD9w1mRChZv04NLuOMDSDbmNinPSYoNAfuaRlPz1MTzQgntLn4sah8KDfSy2QkIAUA0vR3j/qUfd4kKmLTyHOw/2EwI3F5/2uGKtgRQHIKP6zVwM8/GG7ZFXAFPbJjzdUGJ0+gS2hpmSI7AdZI6pbfB4qLOe1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaeZa1MzZ/XyUUwLRkPMVawdkNnH7iuYHQmvx7uuGdM=;
 b=x/eHiuU/cokT3mKEJmLfeyGZ8GseskWTRp9SgdI1GpvoS16esqlDZsd806gkF3W195K43F00PhGNWGCwDFHNEt9PEb6Ol9qXpj1AtyZJwNmMG4yPT9VnWTYDqfl4KDqRjCQLm63xKhQV3BvKD456lr6hydqRIgi6aly32dDL54nj82Mv9MmgXRRO1cWnfp2Ea/2VoJfOl/83Bo8lPJ2s2eYOKRtrF3o+ttQTE0m42K1fFM6XiM7zILpJqWsbXGTsVcfcJEzW4vC8/8SNqnvr8AHt59Kp12zTl3fv+65WGTkUT44Fjz3z9beilUdC3ngVVeiwqg9Dbvhfoo1WatXupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaeZa1MzZ/XyUUwLRkPMVawdkNnH7iuYHQmvx7uuGdM=;
 b=UID+LKC555icri+/S+u/9Ce+NRVahfqjGzFCU6xvfUydo79v4W+/11EyUoQrE14y/71vOwgV0MHA/Y9l/53Iq5h/jxCiIGjLKk3EJLhqRU1myrU8ECr0CFwsZ++QDop3QBngHk6ihjO/qWJsp3Kt+BieCb4BLW1VKz7hb6FygL6p65dVZLwNY1oH+B1BIwgcK8iinmvXxeUOK96Ij9SEZab7LV6Qk9NVH0FEnEAwEQd19hMYBS+fJu7NI3vwoNz1G8aw8AGaKIPce0X+scTaBdpKUaSR+CSxUPFg33DFE4G5+k3n9jnGtReiawkbwYNc73jRYTVw4V4AoNyM0hJBSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB11264.eurprd04.prod.outlook.com (2603:10a6:102:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:13:58 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:13:58 +0000
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
Subject: [PATCH v9 5/6] arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
Date: Mon, 25 Aug 2025 17:12:22 +0800
Message-Id: <20250825091223.1378137-6-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e66b9db6-49d5-43e3-6c7b-08dde3b7b929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/IcWvJPyIuzqDw7m2dTCiikWqlbqbitm4wopCSaQaTGYXGxOYFxskHtzHQzE?=
 =?us-ascii?Q?GxQeZJi3ELL0cbdfAYaL0NQ395Y+RScm1hsWpYLt52Ka4cTnSJ3e07V26IXd?=
 =?us-ascii?Q?bMUk8Jkw60gpga7X0wf/GeoSkUTenvK890DyWMoNslBS4+WnKkGchaFd8gcA?=
 =?us-ascii?Q?2D643cijA5WdK7H8ivXq56akql2WjNy4Hh97S9oRdivGNhzwlmdgLd7qATF3?=
 =?us-ascii?Q?hPhkBBPaZH3aoFtGVCZYJvTllrZHMZ2viJnGJ2qASQvTg1kAeXd2QxH47gZj?=
 =?us-ascii?Q?p253DeNuf/NUaGlhCXzptc+nDRS6bcLvQzZhuUEpoFSRO2tMxw1CZB+mKfoF?=
 =?us-ascii?Q?sqvPiQCyyfmeZqcW+tnXphuXR7i2FKkh410Jgk6vl+cEHtacH3p15xM7B4VP?=
 =?us-ascii?Q?0qsd26pmjULfl77Wxocj0vg98qczgPcrwrt7MKi2iKrDzrVGogmA1tSn7IzO?=
 =?us-ascii?Q?8ffaBnRk7G5G6xTLl1AbLyJd2HQT/PyAX3x/bN45uiwjmciqyMsTQC4x5EqX?=
 =?us-ascii?Q?2LRCa0c1gnNedE6G2cdyZz+q1OPlcmEajenLM60MHECz7nt0pASDFIjHQN5m?=
 =?us-ascii?Q?cZ6ffI3+pcs48HK8fVHAcEWZBn7lwOYt9pJQxsXMt2YyXFxcyWXgYSwOLljL?=
 =?us-ascii?Q?am8tG7kwWudLB0cR5HuIJaYUpswdq+tHok+Zzc+f0ozd8HuA8c7IJevCNLD3?=
 =?us-ascii?Q?I2Rif1SeR7SfM6yKAFKJSRrZXsIquSvDpuWwgD23NuPdZiBj1J/L2t8eeeNr?=
 =?us-ascii?Q?L5jTsus72mi6OLHtucmXxEhyk9I+pdvL/NFf1yFkORlFtbUkml9PaNKUh5ku?=
 =?us-ascii?Q?2EaanPg/eaM3Oydgta8Gp9380P7dU8+Mwn2FO5ga11jPxDl4hNDMnqofaGRe?=
 =?us-ascii?Q?E4AxpttsbQXlRxlyjgaPbO9MgxuWfNBphVoB0g6XIlEo3mHzOeTciEOPOgiC?=
 =?us-ascii?Q?v+sNUh36Veqmsij07myHFGnvEkJtyN9uy/iwag/pB2Ccfvaj/vw3Eyg3QJWj?=
 =?us-ascii?Q?vTkD5gOJnmhUF8gj6dw/87veprLqVEyKv/G6WU5Ibjp4B9Y2LVWx8WOybtDP?=
 =?us-ascii?Q?9wBJF5LdX/05yI4Q4gxU0+8BQ8tdfq4ZklJHMvk/6oL92HSKj7VH+Kb57vBQ?=
 =?us-ascii?Q?AKWITbUKh/OQvgwWchpw9+MiC1ZaNXJHthBT1AjjAlHa7lKjiM2CM+ryot03?=
 =?us-ascii?Q?pTO/ZQKN87bbpG52lA3vZdyMVxG52lp4KQ9c61gz2Fm2I0aEFYlwKyHLBqMG?=
 =?us-ascii?Q?3c20P78uw1HP0yxg9luAIpCZAQnNe6wL6itDEp7QauSJ58rgvwjX9xyPoDWe?=
 =?us-ascii?Q?Vh4gEZabfB7eUFT4a2xBaRT7WbnMyf5Nn7ccvTK5mi7qAausdzYKxGMQBIc3?=
 =?us-ascii?Q?Xg/wwwnZVccS2z8fYsBjNs9wlw7jPtkkr4bq1IiiUx8e125vvZv009t6JoGp?=
 =?us-ascii?Q?Mfw31l0hCL2hjd8XIXvigOkIw3LVhkGYM7ZkN7AA+xsJIlTTDbqDVyAt2C2N?=
 =?us-ascii?Q?zJj4Kun5lYoMm8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkCG/dLa1mUnPGuYT6x4wzoWuzdYtnUJq5PBD9gSReX+rslH/s3PpXidXKbr?=
 =?us-ascii?Q?zztd0f/Qa6BFy+S0k+trAUdnZsVTg5oJ8OEhjpN+gzpFkfugJt5MlKP6Jah0?=
 =?us-ascii?Q?v9h/7C8T1qI5L56w+rPfZHx9X3tqBu7PWvvdVTRVAeUpJ3r9mURwQqFs0Fti?=
 =?us-ascii?Q?IZaMImGY4zMcf/gxOJisi2xq59+0zzJ+qGwEnlvyy1oHB8kvYwNVhowOJHR0?=
 =?us-ascii?Q?l218PBHVEAFJqvCkJikMNfU7o0Ym8TY14eTZiQ66NMf3W4kkXD133J1MbI2r?=
 =?us-ascii?Q?u2wvs1P5Y4AIPTQs4jeJi0chA/bTcVhDgrJwedOHL1Oh+clPQBaHE088mUTO?=
 =?us-ascii?Q?fDo52Q4+oIto49A1BmROiIAwUvTqa/U2G1QiGxE0Y5NRaIf5i7gK7uX5MSfK?=
 =?us-ascii?Q?NT6snMkELMDAeoi2Es0puYU89u85LZigCUi7z5Z5IqqpKjLybi/HML8dtNcr?=
 =?us-ascii?Q?V6iJ3SQSJgNvgmd0eu83fczoVtseH/KJmp+0HtJAdtX3ju57RZXjPkoh4o7r?=
 =?us-ascii?Q?1qkMQlxGNeO4SsIzl8y13z5BakA4lgvOqpft4mrzKQKkMdKlFgmNjvTD4Axe?=
 =?us-ascii?Q?L1HzWpWBdtdvJe53jCTaCqMMdLDaV95szpcprYgCOeRhaYicNSP0AZfcmiz7?=
 =?us-ascii?Q?TcR/SaUIppusaAgxiyPGdLMx6nMtS42RVWB1QD7NS20QaIqyzUu7Y8pvsSS2?=
 =?us-ascii?Q?HUCZIL8UPoK8f/y8TJsKsnp153mqlDwHIEYnPemgwyixKCnlN6jc01tMnXE6?=
 =?us-ascii?Q?bFDQqBfk+Gidn/C4uXHILpZ3Ca9erNEOgm836wjDFjgpzudLA2oTnBCuoH+3?=
 =?us-ascii?Q?LuQcrkYhQID0rc48BSEZhLK8kE/7btUvI/4wLYfdnkLZi/v41feqClTEYq/l?=
 =?us-ascii?Q?xX9jUe4j8LArvLNn37HmEPWtzxWjKrcpYeWsVgfRbXqAVu0xTY8a4j2idSWP?=
 =?us-ascii?Q?KXwdW+3+mXEeeRE0hSQDI99unBtbwQiz4iamggbtm5jsaKmSDELF9ALR8VZd?=
 =?us-ascii?Q?vH/O8mVd9w1yKdEhwmcMUScnYesLthNvCnev4+ggBKDwI9c0rxmfl9QN/5Pa?=
 =?us-ascii?Q?u64dXjGAAO+9wzqvzuXR0rftxBKVnhTyGOJvsRx6E1wK/uvnfliwKqo98nhG?=
 =?us-ascii?Q?pbRPBImFgn9tKopYlYx5clG6BmuNkfNCMnbZsUIBgdwmMcJFlyU1tyh/poty?=
 =?us-ascii?Q?SOa6q/3z4Zb/wccjHY251WRGVCiMHCozyH/EnItad8hw1MWwp7/umUyN8sNb?=
 =?us-ascii?Q?xYP6m2b9St64EYnKajitnodjCWgjPPtYEjAdRp1fIiO2dyFqPhZsVq/EObyZ?=
 =?us-ascii?Q?jL9ox1XjjYt57EJL5iYzvBGsF+PXtaLzx3p/kaYGuLVXgv+1xaeuuqh4N8a4?=
 =?us-ascii?Q?R0voF455PJ0/YQ8XXuwNipQmWmaUBFOrrfEbbXj7jajCu1/zBSzEWJFWG0rA?=
 =?us-ascii?Q?q3EBxpoYiK20JEzzbxxEH3GXQSsS1Gept+o5hDbLQ2kBx3PL0F8U0mX3xu9W?=
 =?us-ascii?Q?izumtBSVjuAFpu8mt4mlmZXxpVTRVU3zPngCpOzkKSlax7zQCBhMSecKrNRa?=
 =?us-ascii?Q?KghPN0VH0R0cFGPmm17qPOAnebonoUWu+mLXi/1z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66b9db6-49d5-43e3-6c7b-08dde3b7b929
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:13:58.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfbOx57hovOV/OYnUi2wB5mUanNMUXH8i+NJfLzZl9CGvJvTddhrh1TmEcj+Thjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
links as a workaround for PTP sync issues on older i.MX6 platforms.

Remove it since the i.MX93 have not such issue.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. add new patch to remove fec property eee-broken-1000t.
2. The property was added as a workaround for FEC to avoid issue of PTP sync.
   Remove it since the i.MX93 have not such issue.
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 44566e03be65..b94a24193e19 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -291,7 +291,6 @@ mdio {
 
 		ethphy2: ethernet-phy@2 {
 			reg = <2>;
-			eee-broken-1000t;
 			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-- 
2.37.1


