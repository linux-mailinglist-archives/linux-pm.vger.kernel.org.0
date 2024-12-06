Return-Path: <linux-pm+bounces-18726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30589E7C0B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE5328403D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56124212FAD;
	Fri,  6 Dec 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O57G1RTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237E1FCD18;
	Fri,  6 Dec 2024 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525818; cv=fail; b=b8aeJhiCloGMg+2BIBbYU4E+oPoUnpcBZhn52jDAp8uwVAKc+3iXKZoLNFOg6n5DE8zC3Uv5KtBlFCiwm8uEAyoKL2RB1f57OIPo6z5EPfJXzU5DdVFdduYLMjN2bOBhM6gvnliyGPIWgGIaW2tR4RLYMLT37azAYA2igC5vNfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525818; c=relaxed/simple;
	bh=TEa9fpG06MCn2xXpnGSOftT79fDHkx5qEClt9npvHEI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBO/BQUsOR0bob3WtSXOUw2Ms1Qbm5tD3ZMxAApshpSI9/fVINJ1eJ918XzvqKpXREqFvNGY5B9C+uN9+pzIx3rY4UeCfsrLjXOO29dpmGBNVkzX8pXgIx5wSw5v2IeImFQuCfRg/ZLOvXQgFQjCEOEfmmAtlxVnw+As51U8weQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O57G1RTs; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPpiys0ZyUVkhktIIP5jYeOptJaqoJDkJLnGqAK0vB9NkKpg3aoHPl47J71IaCoEO/LgqS4+DFUspK81J72L5Fqor1WK81JIRQUmrBD+5HJ9bY8SRHRURLpWPjxk9y69OMsSdBcbgiXWn6N+Yq4TzoMfcHdwXTUe+ICw0+Hiy/t9NuxCPIip0DZoxfHGqN4nVT7ldQnDvjteMsh/6MWp8nALjDyE0VIHR46NpMPM6hmz5sfKAIFwh/SYVlAObUNFty6duHNxh14xdlptn6K52JZuKCFgRlYE7n6/KH+HUxXtmxTVTPed64aKL8AVJ8B6s8FMxll8gq+OKPxhaj6j1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7tO3a7IIm4SWWKLlTCppg9aJ4XfFcJLOY9+xpMscs4=;
 b=VLB+wSpQUmapweDWNYqNLkWfvK4aFh3/cHd6Ex99kRCxvnIq3dE0NJbPOSRv9D69XG27eubrXbaEhvVA9yhefPW1OubBfYJfd8L2472j7plI4q4JpA1P+EOf/X7f/+KibwU1mIFpIzyWDLcoHyydDtLrmA2GQKLfcIW1BG6oG1nZ6f5ZyCkm0nK2b7iQrZyIMCfciDakj5MsPzSij3bfjGiDm+ZQTObjIm7fcl9kg5P30jrp0mH6+ia3zGrKSLuhSqcwmeZPXTWy2Sr8PthULI4ECIxomdwsS8gqTcT3Gtfx40uyMvsOtPZ4L03CasHNstmtjWn16Crz+6QiqsR+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7tO3a7IIm4SWWKLlTCppg9aJ4XfFcJLOY9+xpMscs4=;
 b=O57G1RTsxyjlT8HtbIBrO7LGRVMQmHtWrl7QsUM5qPkQxQUsRNsa1hKz6O8xd2/lybUIOLYRowR8k/LC7/uge5L2QSWiV+nPHfKk3BEdVMEN5Os/sRtdAemNmQOx+8bVPJ5oG+at0YxjHGgfBCt3KpBqGguC7RkIgUoxJmfCNf1bkBOLIVpMjo9wEoZe5BnUVZsCkVOSHD7YIZYKwDi38NksCKsSktNN859kTALEqphpC5UYbK1EaDAF8MWwCBCydnuuNTeVShlG9THasdHyFGSXMXPKN4+5yNxxkWG26YUDMgQ4YpWOcwux3JlzYuNdNCAwccEE9gDHG1OI9tOrGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:56:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:56:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Fri,  6 Dec 2024 17:56:22 -0500
Message-Id: <20241206225624.3744880-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206225624.3744880-1-Frank.Li@nxp.com>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: 80893bb5-070f-4d38-0077-08dd1649463a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWdvtBVthSXb1TkwIXCHIzoj35QAtEepVyvDKtMRGRZBRBNZP0ZxSPZo0jHf?=
 =?us-ascii?Q?sJVILnfXsZM/YCzpU2wmX/XnwIRTf+Oc4C5NynBS2ucBL6NaoRD8/hBD+rBn?=
 =?us-ascii?Q?Zu/7suIzzvGxCW5C4joLPGxaX8YnrRQotMiPuGhnnXrAAkOdbvmP9pptJkbF?=
 =?us-ascii?Q?HdOh0ba3O7ylINPWPFXJO93jdz8OQIGGuwx7i6RQ7iXSGyLhkOSb4hdbs94y?=
 =?us-ascii?Q?W3myHkaZiQq0ugTHNv313jHQMcoyhYgXLv4Q37MvFAjOhX90Gw3GPXBnUFH4?=
 =?us-ascii?Q?kHDuhT4vmc4o3o/prCGINlUKR3B4taZCgC+TAhh579jvBrqVTLS9Uzx0m7dK?=
 =?us-ascii?Q?ZlHwMMHJDNzC/z1UIDbMhB4/zxuAc6zYA33vndubkyd14SF7KoOUCaXY8zUi?=
 =?us-ascii?Q?r5baWx2bUypDo5x8PuiGxCMd92QURY+HSb4/uoklcY+Cf+q3kh2Gu53/sMri?=
 =?us-ascii?Q?k8c9/4kJIQQdfYiKVGamxpDfZtG0KM3YTydS06hnXjyMb5eNDMr5UZWIXM/e?=
 =?us-ascii?Q?+e8EtL/bBP/R2pwxhCc/Fu9WP4YMcHKk7B4d5EAVNRqmlRi7jgc2eLU7aOUk?=
 =?us-ascii?Q?WxmDQqnKkjiUmGHf1l2GpUSWDcW7r+jRYdft8cJnLFc2zKmlkYcsTO/LoUdZ?=
 =?us-ascii?Q?nGMeVLLxH36zMqCzYQa55VSXCirQq+KlRFMXBHufR43gCXD7dsvmnIRy/0B/?=
 =?us-ascii?Q?VQfspqtYnyGKdZG4kUMPERWNJyNfH/XpD22rmzmfl2mnZ0w9Rh+o+7uzHm5F?=
 =?us-ascii?Q?FsabiZtsTGzyZqnfsswkAflFHOSUtOfhvp8CPtN+R0vnaZJ8zqMDzylMgxDX?=
 =?us-ascii?Q?1IBicKmlkXbVlJQslYlyAF6J1EiqGnpxeNCGtSl8I/PKoJTcmcdPklSpRZpC?=
 =?us-ascii?Q?wbK19V1nTSB9naXopDqfOi2etAXWAVs9C341PpBBHc/o4+LhjpIqU1Ps3icH?=
 =?us-ascii?Q?QmxdMxXfcW64wtqzwh5+F4jjNHvOeX3+BgalxA0ysIIFiwO3XuscEEAvBRY+?=
 =?us-ascii?Q?B4p9Jn52eFTh7Nt2h/QnIWyxA7pKwwj0gERlNR0WIIRHVVovC3FhQj6TjzUy?=
 =?us-ascii?Q?2bGRft1707vZEEdwS5+SjKwVS9wO/7HsTf00nzad0xKPwvFOjRWmPTDFEJx9?=
 =?us-ascii?Q?OuukYHZLC7Y0+T4tU5pRZKFefFDoWwFmc9p7ocqka3pa0avoQR8UCW0+1bC6?=
 =?us-ascii?Q?EiFPkDAWc5bUDd9AbGOXPFSXLXtBPu2sOIVQHbHONu+5Y0asNePXCYp0CuiD?=
 =?us-ascii?Q?02REKN18C7j6ggE3cEDAbjy7HJ08szJQ/fyBwAMan608ptqBTxBgFTKz3Agq?=
 =?us-ascii?Q?kfXDjGLeUfMCTlEwEui83IFIYuhVmir52CRyO7cNbF2OV+8WDNmVQFu7mBwl?=
 =?us-ascii?Q?be/DfSEryw5hz0uTGqpfdo7xVVPiDSNPGNl89QV2XtgJ7SLXGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fnqMsxwiJpgFMzCAZrSCTXHteGO7pWPMGzUnDDpuuJ27FLnOmD3XzV0lVyd?=
 =?us-ascii?Q?YGstqnZ+UAQCVevPSQx8FotS5UrFfV8EDzgvDof4TIeOrn+Ud6IQFxko+GPu?=
 =?us-ascii?Q?ZhYnuCxc8YlKcJm7QcWZgpqbbfjO2wJlOXn/H66KEUypeUXFvQhTENzjpXTX?=
 =?us-ascii?Q?chq7xvfZTH9tMuK8ISqxfokiKpi5tHT8jMIaCeRqeN1P3o1wsTCV5CVc4QrF?=
 =?us-ascii?Q?LIxrnU6GJzNJOhC6RXMhSJFUrUu3aCGJRvUnymTYcluOlfItYNLqO5ihNNFD?=
 =?us-ascii?Q?KUDsAblgEKStpMQy9xqkogwjZ2mk0JxxCorZL4MEEXO4Q5bfT0skOknXLY0c?=
 =?us-ascii?Q?uqlGZ5KgQYYIjlFonQ1eUatsNLaTMDUXPKJNICyUqWss68Mf9O3RN5KNY731?=
 =?us-ascii?Q?VvGnCYSQG/sHkkLSL1RlMobMBytMVcQ4HO6kL40JrD5KBBaB5QxyDl3Sv1Do?=
 =?us-ascii?Q?akxH/sh0J/kbwd1uKClOPMtqmaoTSGy8oLM61ZkEriEh4Y7dytcfaShmA5hM?=
 =?us-ascii?Q?p6OcXECMGrvCl1zu1XujOSTrwy20rKCFizFcjj8QuFJKW41i86Bl1TWW3Qhv?=
 =?us-ascii?Q?SsCP82J+2q4ANLGWa+LKeRo/k3Zzs6SVBOCQzE/y3FmkTFjV0QiKk8y8ygCO?=
 =?us-ascii?Q?1C5lIABWZ5w/aN31QB/rbp+xBO/MDooUqOd7wzdIJKSvFZaDcDpK4JMIS6oT?=
 =?us-ascii?Q?xdYq0Bg1shyj9XpzS53I0zdP9eq78fHj/uaC4+l90P7VTwgeDpx06KfUbKqN?=
 =?us-ascii?Q?BpQi5rpxQ+tqMk7uhcahwKuCxXkR8DOFniXuO8BLNw6sNv6YnY2crsZMWrpb?=
 =?us-ascii?Q?DixG5JeyIR7yERBh7TyZuwuLawsGRDNZtKjztpmI7Po0MH4PeJkdSU8eLZFp?=
 =?us-ascii?Q?kfUBe8e5b/+bAAlUQOz7JkdEtWY7aJjV6mjZi7PPNb0Yyuiq3hL3ywRD02vk?=
 =?us-ascii?Q?Q4ld1YBXGMmwT5ijBXpWzPzNpMZVO3pLa/runqbBmOhvO8+MWP9e6zJg774R?=
 =?us-ascii?Q?0CSoIQ0wEhM6OK9KVGayJK2kdnMRXChSOA/AgRuXe1lyPP6IW4KKqoCfOwff?=
 =?us-ascii?Q?fNh6hEf3UChj1P3khaNSa6+Xu7eP9mKOKJr3YesRqmM9TeieLiHMbqHcy/FT?=
 =?us-ascii?Q?5DwBd66UJSyZ0fGKy8OwzLrxlyKRQPlXnQnEVUfDlDPhhWlG+7aSYhVmd6np?=
 =?us-ascii?Q?RuIiNmHmdeHvyiuNMiGD2bLTni7Q7CsdAB9iJLMOVHhtqjuNEtjvYMMRbz8A?=
 =?us-ascii?Q?yRU+1ryIB2IRa3KNZ06Mz9aLVrPRoho4Vf3Ki6rz2buuBXHsXDg9newQIvl1?=
 =?us-ascii?Q?OA8xB9OSOLfQSCZhWFtNcDMfGeMyGVVnmc50Sj/ixCtgBV+csjyEgi6Gx+3G?=
 =?us-ascii?Q?C3U21KrYv54UKnJ7QbezRDwRUoMwOKBzozeNiumUEMjZyFiWAtxd0zP1qNUR?=
 =?us-ascii?Q?cQ8aqvb+uCyuD6eJMbbG3+14qoMyQiRfChnee06h8jtPmH1RkL6FnZx7Gzo2?=
 =?us-ascii?Q?9hghkA44roUbVh637g/17tjOjxlu48A4SM3N6L2v7h6+HsTPFrXr8rCnphUq?=
 =?us-ascii?Q?OOSK1oz93sv6oWOlmfUGguC3HVTRtCuuEdnxn1OV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80893bb5-070f-4d38-0077-08dd1649463a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:56:52.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUfJhNH0Xs09Qo8423VvOpUZH1ji761jsbQJ7z4hErgeJzbaMamSTTAoX7H/eqPnP1j6aTwZZilZGo0QNtJRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

From: Alice Guo <alice.guo@nxp.com>

Enable power-down of TMU (Thermal Management Unit) for TMU version 2 during
system suspend to save power. Save approximately 4.3mW on VDD_ANA_1P8 on
i.MX93 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index baf1b75b97cbe..d95e949321ce3 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -18,6 +18,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -343,6 +344,12 @@ static int qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -357,6 +364,12 @@ static int qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
-- 
2.34.1


