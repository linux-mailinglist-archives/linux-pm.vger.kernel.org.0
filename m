Return-Path: <linux-pm+bounces-28662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F270AD88D0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FE189CACE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170A2D662A;
	Fri, 13 Jun 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WIJJ75fj"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF122D5C68;
	Fri, 13 Jun 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809216; cv=fail; b=p6V5c8f/VsWoN38d+0jVJrx7MWyjVLWd/nNu0gMGnG0NVS/c4mr1hSYXgOdSWYwTK61lS9aMVQIkHid3U/Lv7DbulkwqbXUyqCzZf9YpX51KED+UJmK7N80l5DA2lMRmQ+1pqth0WSHrIWaSrgN58nxIUqg15Nx7xSnj2ITw7bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809216; c=relaxed/simple;
	bh=e8Wjr2j49MOI2rnVaXtcUKzeDDA57nfRWX5ausQdEtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HT1qCUDpY4hKqZOCeHiLIg9L0VAu1vlm5+HIWs85IkZr+GOLoo+gkSREp2z2Ipq7sMHAqzGw7750OSrrxYnT/o4KgyCh0pym37elXpfVygLKkfrYT/JfrhhRc62pWhr1VMvuykls2nLqmSLTBw6YAPPRzPvF+zjl5sWd8yozszc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WIJJ75fj; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpL1PrxyxTZK2doPy1kFm9OVu2EK/cFvjHfJ2Q4+8+D0uhhU76d7yE/JosN1bti5quDHHUXMP7Y8iz7V2qBZbucg6nv+COLVyJXy/pNurVv5RPUIDTFmlQ5LpMFKxAwa8oPMUud/8Aj0jKPr/6+IpUY/sVzTt59vVBfC/SfuAwPzj3/zmuUIQt73MbNsmkIpVgcYcWL7FJ5vugL7nxFSNwO3xGew27yaOh8YzYnTWW6OYTKN0tJ5Ir0Gjt8ZwUGq3qfKpZzTP00r2FSd1NtkTAmE1pcJCe9jFg0pamBvlkjo+u41MFurE04tgLzRzkq6pD6VlfZh913Wj/FLZxIA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=YeEFXHmYgfHi/taxOZWqLVNHFLyV4NVZeHK6fI0AhtN3pGl/nc0edG1IBb9yHGn2F/PTdruWQsc+WH53QacI9XEGx9at0+roWrRTMiV4DkGMDerj6wFF2jzCjFd7s/UsCr3SslRY/v3nWnFEcp0MsDy2/+6wmWiWeUrG2ei3dIg1sTp/id/YvigNpwvctBiVw6tpZWP69VEFGWsq7rxcA4JPy8f7euoXAeZuRwbSfTCZRJgilNjAPUMpD4Je7/gNGxfg9y4zDoj9ZU20fpENBW56LGa0si5584z5ZG5tDZR1JN4jFwZEmVART0YN7HTzT3FAX2izG42xKdH18wvv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=WIJJ75fj4yFESeaIgk9T2BZOfq5cIwkHtDK1GO7IkiXBOtMEZtppGDuUk04jO323K/vJmkUD1qe1G3+l37YlW+AMsaelFzmZpbND5DEerEDSXX8P3Dui0Yr6291qY4TUvL7v5RSfbgtCgxbpCoAVjJtI845bVvnMaCuZUwkwmCFm7d2Wm9fPvAdtgBg7RwC3kV4jhqWNQCAI2U2JaLX1wCdLugKPxoKufGb03keTT1Cu+/qnluRC6/w8THSw95X/9ZwLEaCv/kFWSzDmwCIgYvTY3KCK/w5LgE3QESjdT3GXVVECp4/2vnXnRunHpxzfaqXRbkyYajiEZFsJdGcI2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 10:06:51 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8813.018; Fri, 13 Jun 2025
 10:06:50 +0000
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
Subject: [PATCH v5 7/9] arm64: defconfig: enable i.MX91 pinctrl
Date: Fri, 13 Jun 2025 18:02:53 +0800
Message-Id: <20250613100255.2131800-8-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250613100255.2131800-1-joy.zou@nxp.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI0PR04MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: de559e34-d4d2-4d6d-0fc9-08ddaa6203d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vP00pz65UQjXUod+Gw6VfukapelKZusGDB+jY0e24HxOuFe3BIaKNYRF3rGh?=
 =?us-ascii?Q?1GQhKedTf3olZBFciz3UeEdf3RtvWb+PbDJJRRo7BGyy7SGo3P6I8QgG4iIw?=
 =?us-ascii?Q?Rh4G4EWbzbO7BBcG6Mzf+U8Qv5rexj8MLXa9nyCHJCbg7UQtUEWa9ZG8PLdz?=
 =?us-ascii?Q?XFs4/vkBfg4pAdVbhOh8B3TEMHJf8QiyX8MHuaogyJ7ihClpt1l13ZidRGIl?=
 =?us-ascii?Q?slbUVDYkyHN6oUOkv+SPUIVlhcOyYxhs3rMHxwx35VFNcTyZGc069zKq9sCs?=
 =?us-ascii?Q?ijYALkaW1Fw4GvnGI+bpN/AarTZ7NfKQ5vUW+XsgdZCQa6TER1pgDmu+I+9U?=
 =?us-ascii?Q?yHMy1NrdSHaCugKjN3u2UMnivZwvehMH4LEfAasi8CUboSZmeTCXj48vkGdl?=
 =?us-ascii?Q?8klzfBNFJ+Z1Lt/rdIVIJ8M7QyoW4kXwL/0QpybZ60SpbeyNSozTUlW74Z/3?=
 =?us-ascii?Q?HMbIdFhS8+n7+WzwxEg8Ji7a6/YltyEa1krHY/eYIuXjf5mbrFjjj7kj5GfR?=
 =?us-ascii?Q?1H4bWKmWfTPNY7NogkDNyv0du3HL2htRIbz64+7MgiUM02bCTBThSrYuPMGz?=
 =?us-ascii?Q?rN+xACBzdHZaTQ7fmWGZvaENfIShnuOGKVyx4cQ836OMSk74h5+E6A0BtZsK?=
 =?us-ascii?Q?w4K14EQ1Dx2CWVGUSabKQC727z8sUIBL8WIFOfJjtI9SjTPZBhUgWPsqBZeg?=
 =?us-ascii?Q?2HjmHzyny6N0YzMF6sypOaOxKb+W+EdeNolHC4FvEZZ56gfpYL0GDuyY4qcf?=
 =?us-ascii?Q?SXbp+TMyrWo5Jt6jmUobd6uu9D4VjFx2iG29h714E345wpi2OOnvyseIDOqh?=
 =?us-ascii?Q?dbobsT5ProOx6QsD8pKjdjk9Rl78RDiIREbfgaQqS6cIfi7YQ/ybY8Mj7DDM?=
 =?us-ascii?Q?EY0koP5HPXbuI4XHXHWNtPTBLLcwHjhJHvVV5kdVrrPnSn0OnWCRSjKXkfii?=
 =?us-ascii?Q?EWKq5eeieYBa18WdiDw2gjQI1NPbIsx2mgLchiJ3d2ta7lgP0BPGSM/165VW?=
 =?us-ascii?Q?YK33mbdrOa8JdWymCWm0Sl7OJd/ngqLKGN9zQIJtiL30XSP0T2u7yySRmP9I?=
 =?us-ascii?Q?O84Ngu9DiQwkl9g3sAA3juqyPmm0o+bFy3LRHcULAHQP1grG4U8VG06sMfOa?=
 =?us-ascii?Q?p2ZzecXq9iEn/GAx79hNjjmtvXOBxpTiahHz6Fc/8mbVPYSR0BDWk7rkM+gp?=
 =?us-ascii?Q?DvGje9jaTduORosPrOlCyL2gJ8NhN917MGsPagjG8ziaQQrLoz8CJDORH627?=
 =?us-ascii?Q?A6KcRO54TNYxtuy16C4DIt3lU/CkA1B8d5gA39oT4YRw5UoKWb5a6EVOTcCc?=
 =?us-ascii?Q?TUlOtE/7IDi2YKIeT8jFnSECTWuNbwAqNUE7cZ7NJLczgTgCZuymESn2iiZs?=
 =?us-ascii?Q?K7VEjt9CdCOxLmL3DtmcunOKPCjTwe5qyLxZdBfWdWfJ23c4YR2tM4UjkULk?=
 =?us-ascii?Q?dMlB3FZP1nkHTj87WrmiLVYxOuflAaUrlxfXVT6PApyp0iCCGTDfYvLNtMho?=
 =?us-ascii?Q?esBvrdNzvbQfirU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9f/eBvJlPvpglfwJ++jDn5uvIlLxphcQOG8/xkcLyi6XqGVu7Ved04BghTX?=
 =?us-ascii?Q?Hwoq8el2fnJP+XSoP097FkA8i8K5Y3IqFJYlneCtJ2ZMkdfgLSZUw2kdZhf6?=
 =?us-ascii?Q?ghDdsTgBQ83rvjkqYEbwq841sj1FoQadwNO9Ban9Ir8SDRRbUdv+XXf4aSif?=
 =?us-ascii?Q?1AAYIoV/4Gx+XlowpwSpERgeBtE5Uwx4ZpCtcaL8j1kPD4864yTewKWGD2JV?=
 =?us-ascii?Q?cao4RYo7op8nn2KwNae++jf4hxu13k1nQHI70EcX7fDzQtBLT/5R5OKa6tGy?=
 =?us-ascii?Q?Re/LAmr268inMkN9m/m2t2SflxIzfJjRZqg7C6Hgm1vo4K/ys3x0jLOKHCVk?=
 =?us-ascii?Q?9F2BkOolE9qr8AazkEU90jHwD+Vi4VsJRR2P9ktRcdTKS+AFa3MQsiVSDmjf?=
 =?us-ascii?Q?3vGGyMcrSWXK6CaQjTSxB1Pdfx+pn45l9X6O4z03Xoulb1WspzM19LYSstF+?=
 =?us-ascii?Q?FC5wiZ2U/K4J6TtD1ZMXfbyniLRLgXn37R/ME59oR2WscCs7vnWdTL0myGEB?=
 =?us-ascii?Q?dM9yOGonEw+QqJGWuU02wdcMBdjLENBlyGep9mB37PdxQjSMn09tGv9UC2As?=
 =?us-ascii?Q?9EQ4a8kTMSFpfF1Ni02t8ElOB4YYUrnv7nwvI5IDPeWw82rXjz8PoPDbN0P2?=
 =?us-ascii?Q?4ADm1wXuYDSvYArYlYaO7zRjtHC5sd+6wnn1DJQJZS9EhYqMzIOMnziM/amT?=
 =?us-ascii?Q?92/pz3/MGYUsZxMCp06SxfVek4rWhtyibU+K2rRcx9gctgXgpxghvEkQOW09?=
 =?us-ascii?Q?FiDp3Ut3ObSXGX8p/eNNu42LO+daPsG9gZPwOSj6a4MyXMniZrRK4UBDU0+N?=
 =?us-ascii?Q?eQpv6Lmw0X9aDIOutXLz7J2ONwVWF6gtWmxZVnJfLJp2IxPnorF1MGTTadXO?=
 =?us-ascii?Q?jYNGH8wxglYfuWFZ5BWg+UHNDl8dX8Ejc5D8TT++GUgTYYYimvNcSu3bEwKj?=
 =?us-ascii?Q?RDnSCO0EQpGYKXcRHJ1Uy6S2Ty+ChGP8iFhOz38n8TpINl+JMhPLZ5ivzs28?=
 =?us-ascii?Q?0dnP8itxw1me02LgsHSk9R7U+ro65gwssuxdYSd2lhYiNXahUWWGL1QYtuH6?=
 =?us-ascii?Q?Dcs5DRWno+mVn0xxXFnJExyrZfzj7KvRyE6IT6zVgtyOOGDkfCqLQk9fq6DQ?=
 =?us-ascii?Q?xil8LXu4z3eDoIWlEwSo6nmaapWL03nvVRbPMtZn0dcUK5rgHBnvvJkTjKSB?=
 =?us-ascii?Q?2e5yoPLkklNH7DYqp+/qj5kFSUyeBQLtQvE+L6BD8QiI77OzovOk8S0FcZhX?=
 =?us-ascii?Q?00FBBDBQtFtZQFZcOgkG1G3BvsR+aONI39hcBBz7ETOW7kGDAeyESgt0NLxx?=
 =?us-ascii?Q?wNSIBC9eSTyomhN2IrTSO82ofQh0L6PIsED75IbvV+FQbLkD4E4QkwoMxRyM?=
 =?us-ascii?Q?OlqSZXzux+092CBTDKtS9A/UokDyjRu5EtIzd4FHr9BnUU04Rv4BXKj+G2fr?=
 =?us-ascii?Q?J3ehKor+uupQU2Eh1p+O5bUS3whuyGGUAKHKphb359dXuNmOngM0YKPYZBJD?=
 =?us-ascii?Q?plSgHdB9pWKA1KXWkD/sgDDznjLIGE2Y0oWfAua1jJI6+29ttBAYjVSsVW41?=
 =?us-ascii?Q?KDQORmud7ON3m+/NnIw7N305bpXz1S6HYqNU1mqE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de559e34-d4d2-4d6d-0fc9-08ddaa6203d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:06:50.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcufW6qj62EcgUNx3APG6OdpK1fNEcf1SUeGt27Mns6QvQkoauyR6lffMvMiVC0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568

Enable i.MX91 pinctrl driver for booting the system.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1052af7c9860..2ae60f66ceb3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -602,6 +602,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.37.1


