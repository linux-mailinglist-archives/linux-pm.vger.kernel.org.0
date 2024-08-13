Return-Path: <linux-pm+bounces-12134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CEC950046
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008D7B2349F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AAF6F2EA;
	Tue, 13 Aug 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UIJM+bMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B11BDDC;
	Tue, 13 Aug 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538950; cv=fail; b=iF8aPM5nAnDCuamUzvqzl5ZjGokWRq4/oDOqGEIcJc9zm1bb1BrQSORrl5Rbrt6Bbmxad5CkPBWOwnIMevk5nt6zg9CPIAFuuAMYziN06YTefzsvPcvvd5yEUqMtVdsW5E/OtJP7zWBpzyHMlWsn1eKo8lqqju6T89JYVFFcEIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538950; c=relaxed/simple;
	bh=N/C5TVpJMZFWPe7xAxKVrFelFkn0/jzrCkpZlr7EVWs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VvL3YGn8J0YqS/itsxtW8NofmRw+0iZzMOBr7kHuYzzWePWzq/Azd6M6tbPQKEEzlyyPJj8UTHWqtX860CF+ThoHMMzcR/b2hmhtpHegiVcbffP3LQA80VFTrJMqqJCH/QU1D6iY4/oxmTXPQYIzTQM5/Z8bCR7dlUByj1YER+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UIJM+bMY; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSsFqwov3YjgTvOGPwp/7LroOf1yQpZGL0agDfkZVHuvg1pg1xMVPrqVZh74zzzgMuR5ndhM0Wgj8Cts8Bbo6sHUBsjgZMg/z6rmig9ky5CInHjz423RzIbKCxC8lzSjOqIL9hK5bI/Cd9mBj/vfINAH+t0uWrWHTO4t9z3TWpdncf/SDMIpY0rA2T6DzY78130CBNXT2JhdJ0Fc9Mywl3LsMhir8/ZD3DtAjKe3MVKMGhzNtIgTbL9seAqktvEcRYdb38EMF20v7ldtXPrX7YgXdT/rkCpbj8xKizVyWjd/3/tHGFA0teWqIxAKVEQcfCNjOVBJMVQSq7e1pzBYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkPy3bXd/NT1EbLVQ4e2Q+MlKyFWfiMrZWCT85oy/CM=;
 b=xlXaD+sDSqOID4ui+A5l0S+1bB//rEDddd5mawUeu8uurvsCZmLxTRTNK87IFSIAlmG1uZCFWEIXJ3kppZQ4jozWH6FL+6vBNug+dlZXepX+HYurfEkf7j4m4Ow72pWxkufn3vfodxkci5D9Th27o6X1xG8R+6Fv3/18fc8si2CyDfKGORm0birWdczdIGwSdvjWhf7SnJt0uhIBdwcGypzL1qimQS+rZ4urfXmqRsVV5wnnegXJ57Fe8lCXuINMOXUKEseRDXAcw7PZj3jXXVI83QR01V25flfid02E7rOocBnXO8TlvKBJRMyVpJgeRGlf7PW8ZngWz/VbzIEqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkPy3bXd/NT1EbLVQ4e2Q+MlKyFWfiMrZWCT85oy/CM=;
 b=UIJM+bMY6IwJhvhbBxBEUznFSOjR1ZE+ixIwV9U+UasLnAxx3ECAtKTTziWvg9/o3kWZvH7DC1gT3zE4IEQRqGh2nBDBwWEpHnOWVImS4VzuLaEkxrpLr1UpyjNPi907mc+4VJzMD5sm7ItJe/RDCS1ptkf1NFHLCTm1bsE29jseeMKo6GFVvMB7IZkySizd5AMpb81kPgTHQkOJr/0KkJL15QYM6vSEGGAwuIx8cNDqd68r4T1OfDDvkRNXlpGMb59uvGVpkNRLY2GA59AhJTKkQMOCWnceHGwkzwb+oJzMxvbzqzL3z0JkpfILz65s+LYKY2QpCv7WfIrKXX2loA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:49:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:49:02 +0000
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
	Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH] pmdomain: imx: wait SSAR when i.MX93 power domain on
Date: Tue, 13 Aug 2024 16:57:48 +0800
Message-Id: <20240813085748.2144637-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: a6de9a3e-59f7-495a-cc6b-08dcbb74c786
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5QyD8BQN5MrSmoOM9UAVq1dMv3B97KuUQ05YrZzpfZwB5YYrjAgI8Jk/Ko2?=
 =?us-ascii?Q?kv5MZOZ/IW9xD5YonDE9YFKoiuLg7S4AJsvn9O746gtZh22NJp9N/9/w2Jvo?=
 =?us-ascii?Q?/KPzOTvtS1QuEayAmG6OSdxiLCQDfO2pZkXlkOTpfm5o8+BZjpQ/UEPnQ6Co?=
 =?us-ascii?Q?4DJYvBYGwkIMqAVqClTQpZ0fx0HgJC61+Ow+T0zV1K/jUo4yAhVLis/ox3kg?=
 =?us-ascii?Q?UE0Scff8bW4sHY05JJVNPecRGQaWlr/uKG0cwIIF8Dw0EK44DqpruMYGV0d+?=
 =?us-ascii?Q?d0DR4u8mihZSPFpeBEcDNALq7y4tk47fr6bjskhuwkS8mB5lYb+4RsErFrpw?=
 =?us-ascii?Q?zEtdChWSlpdKJ0KVAHY8pMppgtweYxa85wpsyHVIgZg+35yvU3y+ceDfo+9e?=
 =?us-ascii?Q?8ugAKQQ2pVr1iMcn0kVHu6ppgA9BpRepwzhvDEJWOuwhX97FLG4wW7pquV51?=
 =?us-ascii?Q?JvYYknjvgrapu1pB13rx3m7EPjlGInFfFZSnuEFRWfinDo0bzxMdFl82s9Ct?=
 =?us-ascii?Q?zwHcZR/p+GK0XUcAzhvw2m/LJxRhC/rF8RaIHvEEyv2ExijgKe7Qmkkh4kXX?=
 =?us-ascii?Q?7auUnW410F5SE8VadCnFcIhskfg2uAJmvfey5NdVEe/dSV/BZPNdWp3Y5iCL?=
 =?us-ascii?Q?0RQvJ46H61KvTDyttqLn1leE6ixX/a/tEE6aUVQXud2xpv1p3ZpdJ03YaVTT?=
 =?us-ascii?Q?KG/4/IgYw9loZ4AErUGsZmC0lwLoezAdPmUQTzLXaRBVnI6lE8DXmHCi6viF?=
 =?us-ascii?Q?V9xFdAKqrK04rXCM9Sd1MexRl4m2NcWB8QUhphbQbYXIk0OtNdLjI/RM1c3r?=
 =?us-ascii?Q?2pNz6hN7z4GLYG1A7rwFICPAuvHWI1yYx7xI3H+u88S09zLTAwmEuTchInfK?=
 =?us-ascii?Q?g7FAoDw4efYzXtKoeid3vdxs47e9zKrTBFISoU0ot/NVup9CAkohWyBH3n7S?=
 =?us-ascii?Q?BedpMy1UeOdteMsfFdGRWIApCXE9FO/785+TDKq26Nnk2qPCDgbjoGse0/S5?=
 =?us-ascii?Q?4mZYzV/DbpMRfBT2l2P2Xn7PZ6vxaBY30hLbimavPwTtRFABxDeg7maQtWMe?=
 =?us-ascii?Q?WqjxWSyt0xRb8hFbmgwkmwO2SjCHnLiGcNb2P09vXN3Ilp8ggQjzmra+MPvM?=
 =?us-ascii?Q?n9BjKoixeSsLbLAC3BylMApW7blD2o1hxm903877eZVMyhKsHroXho54PY6e?=
 =?us-ascii?Q?hEP0aNUz3YmxUBPM1bQlqwD9GNlnv59RKMT3mo1VFUErKnP3em7+z0PwiXQ5?=
 =?us-ascii?Q?imF8ECjHkoTqmSlXTJWTtvZVrfsWsqW9CQL+8x6KX7hQ7bXg5rj/KM8J/wn+?=
 =?us-ascii?Q?oNVIF8F4CIPcVedZi1tnUcx9YyTKwHVun9Nqas6k2eBmhJy9bDcp/e4w1bT0?=
 =?us-ascii?Q?3EUAjiB3HVdQObVvEPOWcdBR9Ky3CzYKW7bA4svGXs/1nXV0OA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iopa+aPWtcM1oux+0tjScR5/Y6WgIfxN1KUB+g0BgZeE6xHxVTtQ+OSjssH?=
 =?us-ascii?Q?S6yuI+7c1vqRjoMuC0JIzofEvcfLIfgGQ0eSk3btnONrLJ5jYB0iGdeG4GpA?=
 =?us-ascii?Q?+FfOcv7mtBMtMYtTk1HXdc/f2BNKxNFr+S8UQ5EtSUPV1lY/+Yr/HDW/Ps5Z?=
 =?us-ascii?Q?48FmnNPdbM8jBlKG841IizxCDosMgxMtDDsWjscLsVRfKJ8q5v1Qd/QOAY12?=
 =?us-ascii?Q?VcnP9SzOH3WazZsBGY487xNfELfK0NxaBCwlPiKffo/KY9Z1Rt/wvNn3k7x0?=
 =?us-ascii?Q?FMMDrga+hNP/CVrueAnYTpF+cpk0G1nXV01MttR2da8ufki23lOJeccNGjK8?=
 =?us-ascii?Q?w6prSyNoXvdEdCndAGNFHSOPCgWbT494MlqXHtnrBut5LpF1iZfw5hLEs8lu?=
 =?us-ascii?Q?f2b7O0EPclRYAGNAGvDuaeMFGTrBGgbVtZI/IFNFyG0PZa6Rz6Yk7cSBCzht?=
 =?us-ascii?Q?lECm5UkUYojydjpz1H7hqvHNaIrIlsk1CVRnVwbS3iPZAM5K4N8GzMYFwWtG?=
 =?us-ascii?Q?Z38T/ZB5iG82secPvuFrt2yjRczylXfz4mdUXxNH5FYR0s4onXe9cTyVcJqT?=
 =?us-ascii?Q?ERs8QFBA9jVYP/OCJyva1KLboFH1mccRmQQwUFe1ZsT3Z05/WGuSbqojEuur?=
 =?us-ascii?Q?e/0kKMKoWWtnStDojFVRFy2Ccl9tx+S1JiyhynReAOFH/EiFSO7FO1JHDRfm?=
 =?us-ascii?Q?iwVMVpthzECGTACfl+xwEdKfXG6eFZxPWC29XGNFAe6MZj//YlNaqOLUEWA1?=
 =?us-ascii?Q?MtDHzwFMOH8+LtamJQC7BiA22a5odijUPvvGlACxSDdqlWaSTlVGZD8HngJx?=
 =?us-ascii?Q?Ka7Jrgwd4r0xzDaZs1QDK7QZ92lCKc7RhWnRecjRrIGmPLcT+Jqqv3og6VRN?=
 =?us-ascii?Q?52t1v1BZBOhLPtpMYIYEbZwTPLCQlQkJ2z4REN1lg8szY8mKY0wGPevfdWX6?=
 =?us-ascii?Q?xqd6LgKWjktAbyzX86clwh8MjiTU1rHbtsHlo9dy7jIIPRJZC859WghrOx2B?=
 =?us-ascii?Q?l99lJ3kLID1g/z9hC3SiV18uJ0H6JZQgYoC8Cd1iOkaYB1v7Lu0pQQY1lwLX?=
 =?us-ascii?Q?CayNAs4ySqOLLzV3wfJ/T2CAVcusS904DWq4gmbeVMfMPfyqXvCvezewjMFp?=
 =?us-ascii?Q?iNRsvl6OyWVRgyYzlaOP89QTBddYsavXEcQtj3e0//o7hFUR4ceSnFscpbVA?=
 =?us-ascii?Q?cqBgyi0TIkJmbc093g9KNLGAtMTZCelLHqvT1UlLhJfJxDYVSwHom/9e2NY0?=
 =?us-ascii?Q?snvKPatyzcIohAmeOMcz6DiNbpJUlu/dDILAa/fw858+2OX38KQ1P3+7146v?=
 =?us-ascii?Q?8DM/hS2v4WeIUT5ufVMBxMqL7Wif0XczLAdhp0v9hgkR0vXh5IRsrOsAqkb6?=
 =?us-ascii?Q?2gaZG5dxgseK+qUFrmJAPVv0aexMdkZesdm0/ieMF7Aa5jS7deVGxV6rTyD5?=
 =?us-ascii?Q?cIWdvf3oPnDk89aCqenKN0Tb1623qKXn5IQfPLm2kCKKKoFijz33rCg62z4p?=
 =?us-ascii?Q?lhngDBBkhQRYCtr7ntrBACwgmdtBy5KcUuB4a3xu5hh6codmFPhy9dn+Cg+h?=
 =?us-ascii?Q?oD6sTzXtu6dlXifmbC1jh7AjJeyGTGIfBqZnLBLR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6de9a3e-59f7-495a-cc6b-08dcbb74c786
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:49:02.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWJ/z4KtkZWEVRSqRnc2to+brz3cHQb2K8Y6nKIcFRK6Mqb9gaaU/VKS5umYY59yRxtkLpBodcZVdufTNIpX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8721

From: Peng Fan <peng.fan@nxp.com>

With "quite" set in bootargs, there is power domain failure:
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

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Downstream R-b tag kept

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


