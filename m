Return-Path: <linux-pm+bounces-12204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CA951AFC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D641B23B75
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75019FA86;
	Wed, 14 Aug 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jfzytGQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E215C9;
	Wed, 14 Aug 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639139; cv=fail; b=av2322sCFnmmrFaNwbK4Lt5/KDQNx3zb6mc7qeF3Zr7JFQUJ87pQG2dnOlPwO9GNgNxyjBTTpc17kdM3SeJJL/Yz7zqkwDflTCzWP2mFJZHGZ/3s3qRIm30TYuee+BwL7kzcge5rhs+rTkTbdjf+nu84q7xnBTeQH0lNxeeUy5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639139; c=relaxed/simple;
	bh=hbQZ33KfTr7TmcNFv/iUiCeTw3z/GrjXiKz+smAKDqI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aY097XKsm8yPDXVJSCToKTECO5k0XzOfIDpdIONUB1t4NiX/mvX95AYO66wxHX9nJ2VKpd2xMaCVbG4gjZ6/GKM+lkjL3T4fnicrvWomOshUYBS+d6pLnC9b8LI90UmWHiggwgRgDy1PjtsGk4kc6ZhcSghP93nW7C5R/fUGksY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jfzytGQn; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/xwTIaqMCzusXkMDrIFPd1fwa9O9mLZHXEhUIi8q0y9JXT58ULgl1g4r9jSzeu+o4L4lmhmqmf6U2KnEsa7uH1kqYsTXO5vIjbgOcr1vLuaKbszIcWeJFxCAmni+AcifEO2ZsvSaOyr3vtJNWsAyrywzPXOL47cff6oh0+eK+EsdWc+cUhwqD+GX3DoH+UjU3Fs16pdjh68NSPh3p34dIEAd3b6By+YxqLKfkOyjDCitGz30u913C2LWmDDUITmj3h7LbrhbMRPF14wgrIs5iJnqMrWuf1zaLFDeuXu1uKaGVNk40tFZ6DJM+wMJNaExQv28JA383XeGw72PFyZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZBER3YRZSUbF3bopuTiDF4EIeQWF0Xsrrp7C8nUgA0=;
 b=qIf+e8dtKtXfkuwHkcsjHttc3Ynpzjpnjpp3Uds6WJD+JlgGcJeBQo4GjKLYT3WYEFKsR35C/90wRzTvj8WWnfMDlCYCDYB9FC4ymNBBx/qTkl8RbTspgOVTyv7igYQkUXVFB9ZvjSFC0RNviVzb/F3bZ4Cb41GzCLMQgEVu7rNWxeGIJE/5CcRWiFih9M6ivaowAL+gwUk2u+vklITkxfaqZXwYetWHBT6wFQSzJrI7Pwj6J0P1lXx68eyV6hiTZi54VMhaixXeBx8W4MRBwzDPQO72X+cc1Tx0Ez1grrEtiqSa1J+/xE+WPv2Vr8N4A5eIatX1XLNeqR/2w3zOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZBER3YRZSUbF3bopuTiDF4EIeQWF0Xsrrp7C8nUgA0=;
 b=jfzytGQnfRSEcDUuBmopdrrR755Wm7QR9tUYJX/AWtETG06gKVdckp8dXrDd7m17jAwbRDsaO44wI7FrDZ1SmT/OEmRAvGU80fiDdeC9eTbf8sv7cIDr0Cme9zW7KPrHjGQpKHBZA0jmGA5lkQVgMUj86xZhbYjlbTPmGrRiDHJLAJDtr+18Rws2SMYInmNlXxs7dG74LTwYXsED3yIQyCuuUpe/ctZ6HqKq6FpEYNJQQdczHYNjFcJJ5XjgMNps++Qx47MfvJm2DvbNMzB27r6mJO6CXeXv0xl5nEsiTlnFgLMPoDniu6tIaZWqa6NpPR0AIH2gLPs39+Fafh1iCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10486.eurprd04.prod.outlook.com (2603:10a6:150:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 12:38:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 12:38:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Stable@vger.kernel.org,
	Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2] pmdomain: imx: wait SSAR when i.MX93 power domain on
Date: Wed, 14 Aug 2024 20:47:40 +0800
Message-Id: <20240814124740.2778952-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10486:EE_
X-MS-Office365-Filtering-Correlation-Id: 68138a7f-eede-4b4b-bdbf-08dcbc5e0e0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CN32gZoOIaYv4exeMJiIiccYMso1hRTvLV3dK/PEAvU5PCW6+byYf8Jui6ZS?=
 =?us-ascii?Q?2VoeE3Xt3ZTXvvdZo/fzWyjF9B2mRKbpMdZi3jAx+LyxFx96d9Eax6uJAOEQ?=
 =?us-ascii?Q?x0PJOe2p2DBXRwETALUQBGePnvAF71bwoxmvnXLmpKJbo0bdV5mZC4qZh0V6?=
 =?us-ascii?Q?FqBFzLXgCJ4saClK/lI2YdrPsFvqO8jDuDAxTvJPI9TYr6hwwE9MDdJvpIHn?=
 =?us-ascii?Q?2gQbr6GJxge/V7TyKX1Pf02kc1gbKduIFAfe6ZOGAYwdBP/RCW7+LOY1LpKo?=
 =?us-ascii?Q?5cGEJDhzwjKV+7Jv9VuBddodPDXlavk8Cnedobuvo38/5XqbjPGAZruu35M4?=
 =?us-ascii?Q?tpavYzOruxM327s2yswyE07VvnT4+aCtHaueBcWNFmQSyNFu1TNkMp+Riy+5?=
 =?us-ascii?Q?qvlSLybaL9ewXk0O6qCCN5wfN/y0vuey8Dd2LQi4gbAYzAbGLH7tp9Nycv2J?=
 =?us-ascii?Q?2pFUMmSO85BxCB2iVwaLw+8TxRMjzYWOMpnnGPptHgob1vrEgVLKuHiWFxYI?=
 =?us-ascii?Q?NCD2cL6k/cdtosJy3IwxKxmq5xLFZhaLn7tZ8fzyoIFBOJr22A4AYCmRxQ5K?=
 =?us-ascii?Q?xVnNC9o27h0f9fsGjX253CtVWR9Wmr7F5XiL4zOdIyJn5XIO3QTPBN/Smm9Z?=
 =?us-ascii?Q?+jSKBG/qVU/CVUqN/W/bRkMCSE9ms/bvuSoJfRClEcMSQ0OTI1ZLVt1s90PZ?=
 =?us-ascii?Q?6GDE5rSA0xVZ9a9Vozkl8j6y6Hty5AMGAUL9BPfUKq0uvPKpDmWiBgzju5f6?=
 =?us-ascii?Q?hoCO13sQ7DTU0/NlD2528vFcHptqDI7pHim9GDQ7NNXJbv/w9UklAhiTV+Du?=
 =?us-ascii?Q?WxM2Ab5K/aoaVLKYLrrE70Na2OI7NEUSUG+PDtVPAtDL/ypDlAAiPMCiIZ6b?=
 =?us-ascii?Q?qNO5PX1cdGWv90/7mRyybooqCKTou971w2mnj2uCsYeuiukDxb8pgZDTS5Xd?=
 =?us-ascii?Q?zWwKEWjIu73oh7fmJ9H5F1LRuiY4rjOHgXOJj1jeQeGqKCcypBnhSTXv0hhE?=
 =?us-ascii?Q?6IcgrHuSKOe31j0co34NUEyK3LlMH510xZTbP1L9L8e9X8hdUDxsvkaJNLnM?=
 =?us-ascii?Q?oTj7WQwtuPzewDLGrDkpDUq3rvKITnje5uCS5yAsr9KNGQOgnxVPO3xo5YbD?=
 =?us-ascii?Q?AYNAI1lXMjBIayd3UnjkqyFiIuqtMrY4yO3YMMmgq/jP/fHv/csdZmjTVo3L?=
 =?us-ascii?Q?PiAi0CwE9k0UQ+tktEgymM/Uwl5VBaBWb3Atb+akG7X3ncWaOBSx6KO4XRjr?=
 =?us-ascii?Q?a21LHXsS3iTQdkV9jtPAZr97K5m+tCz567Z6d3BJVEmfQ2QwzrukdUa0HZ8m?=
 =?us-ascii?Q?6FYDLowwXlzv8nRwQwofCByH62IsgTcvrcgwTvMPfIx/us2CEOmfnlsW8Kvw?=
 =?us-ascii?Q?TvttocjJNmmgFv0LRXUxUW2xYvjBRLuI1NodlVt5YecBKCKEKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VN3LSGdXhBBhOCPL7Q1AMrDepZURhDx70kdUon4FwbnJCuO0tsI08hco3BVb?=
 =?us-ascii?Q?UwwmyFu5iG6ja89o5FlhZU2TVL/KpD2IlELv0i0G7tVLLxIq6NfOUQGevvq6?=
 =?us-ascii?Q?WxNLEbUXXg7XBy1QZv857kqkQxBuakTBFbOcgyH3WxTy9riY1dcsoGGwAREy?=
 =?us-ascii?Q?X3Egdp78G60MLehlbVTp3GTokAZ2sRJAEx9BDjxkjIzhDdxg8BcmdZBpnqVl?=
 =?us-ascii?Q?QUARLYwYgx5SHjj9sRnODZceP/jhKO09+J3kuc2ByM+ypwu8R5aJOUY6Vp+r?=
 =?us-ascii?Q?P/lKKKcS+OASfhbM72T+TsLqXJDkUbZqfwwyxl/aPPcp+N2eolVobktyKDEk?=
 =?us-ascii?Q?3/BDAzKFsMRv8wX4ZIE3Ihd8pPWXRsqiLBKRxOewxFGFnYG3j9jYq4Inw61e?=
 =?us-ascii?Q?5aDqRqN1TWLXxWPNDaK5N4e2quOfQycQuJHIfwo+/BmJzmDmU+uPNzN1BJhY?=
 =?us-ascii?Q?/z8OmY3WhNNcXTGR/trSvqlLLH1QLR4Lj3K/RXrt7lMmv1S/4A0DMpOe1v6F?=
 =?us-ascii?Q?AqImeaU5OONV+psYPkig3OrU0Ibde9G9F1+6ws0c/ii0bvTTfzmjQnkrtVyf?=
 =?us-ascii?Q?sr9RH/ZID/bLYxalRzxdfEWhHmZZh7Y8U862gZJuyziKaounx/NQH7W5RhXC?=
 =?us-ascii?Q?JLi8dWe+mTFamcBdDCnlEDxYD5lbs8zlEIARHG1Efrv5tPXCVL/1AGNCkFxQ?=
 =?us-ascii?Q?ajiv0M+ypseKrEFennDOkLcAbr3RoVwjh/RrhlTjpLnG4ZDByY7HvfSOG2Xj?=
 =?us-ascii?Q?1R48WszNaXzcOOcK/0GNPaz8PtN3vH4l3Hau18MXbpxhbKXqVpOva//7IxZw?=
 =?us-ascii?Q?q0IW009xj4ISosDYUtnwj4WLbF5v83ykzDJXLysAzNByvmRV12bmztOaRuni?=
 =?us-ascii?Q?0FZitXTiX1rB74b5lNrbywnSbHXXJ7BZ0v1Wv+grlM0m5uea/aXcSQ1FuDGf?=
 =?us-ascii?Q?6SJbJ7YhY2z1xHMNmxx91MEzdCpt6MKuGCYWKoGxipHgqV6Ap15nomL/mxD+?=
 =?us-ascii?Q?nTaKovQ+yhgxGh8pCKh+TNgzcNvulvIuaIIT72fbVXfxg9ckrAlauvZMpxgT?=
 =?us-ascii?Q?cL2Q17CkvQAXeRDYv1c5hwqqXG90/KOuCeu9o16c1Xto1Mt5KiivRaE+KNKt?=
 =?us-ascii?Q?c56TS5WPTerltzL4SYTIWCeWdmfMzMV26aerCXC/Z4fMcnhd2ioCBK4HNhwB?=
 =?us-ascii?Q?bNAsCKsQYnGZyJ7WsCn4ZEPiVZfgpZtPdV/jTO+M68BWBAlw/S9WzMR1qjke?=
 =?us-ascii?Q?2OPffgqqXzT3Ak28ov+DyXroKu47RsNmiPfhhUKzFqQMfe4Wd08akGbif6N9?=
 =?us-ascii?Q?+ebdctDOWowzwFqBZHtf6RHZmXhglDy319wvDQF1WWMGSAcfk0/Bjano67U6?=
 =?us-ascii?Q?EdnXEWUs5sQb9r7H0ZGqwkpLDDYrEFm/yijyg+vXOo0aKeUW6e+kGvBvmnOc?=
 =?us-ascii?Q?6T3deTgRzaExRxUEpIAmQbTUmS0D0WRLC7PaPtc1wjN6ppc7vtlVLFPWhHck?=
 =?us-ascii?Q?On7fNji4mbDhsmzZfaOgyXMSkVDcuhd2J+6Tcdl2eBRppwQtypY5kaBGvgmm?=
 =?us-ascii?Q?FY8Dy3Sx5Jsz0Nt0MM3az8Phda3DbwpkTr0iSJtd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68138a7f-eede-4b4b-bdbf-08dcbc5e0e0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:38:53.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHvqlYREoAGOXVkqjl5wJwYQegeP6meCpyebNZUbYs1ECI5MliM2+wKELk+YPw/9+lsJau2HbAc6E7cNpXxxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10486

From: Peng Fan <peng.fan@nxp.com>

With "quiet" set in bootargs, there is power domain failure:
"imx93_power_domain 44462400.power-domain: pd_off timeout: name:
 44462400.power-domain, stat: 4"

The current power on opertation takes ISO state as power on finished
flag, but it is wrong. Before powering on operation really finishes,
powering off comes and powering off will never finish because the last
powering on still not finishes, so the following powering off actually
not trigger hardware state machine to run. SSAR is the last step when
powering on a domain, so need to wait SSAR done when powering on.

Since EdgeLock Enclave(ELE) handshake is involved in the flow, enlarge
the waiting time to 10ms for both on and off to avoid timeout.

Cc: <Stable@vger.kernel.org>
Fixes: 0a0f7cc25d4a ("soc: imx: add i.MX93 SRC power domain driver")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add Fixes tag and Cc stable (Per Ulf's comment)

 drivers/pmdomain/imx/imx93-pd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index 1e94b499c19b..d750a7dc58d2 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -20,6 +20,7 @@
 #define FUNC_STAT_PSW_STAT_MASK		BIT(0)
 #define FUNC_STAT_RST_STAT_MASK		BIT(2)
 #define FUNC_STAT_ISO_STAT_MASK		BIT(4)
+#define FUNC_STAT_SSAR_STAT_MASK	BIT(8)
 
 struct imx93_power_domain {
 	struct generic_pm_domain genpd;
@@ -50,7 +51,7 @@ static int imx93_pd_on(struct generic_pm_domain *genpd)
 	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
 
 	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
-				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
+				 !(val & FUNC_STAT_SSAR_STAT_MASK), 1, 10000);
 	if (ret) {
 		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
 		return ret;
@@ -72,7 +73,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
 	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
 
 	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
-				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
+				 val & FUNC_STAT_PSW_STAT_MASK, 1, 10000);
 	if (ret) {
 		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
 		return ret;
-- 
2.37.1


