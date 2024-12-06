Return-Path: <linux-pm+bounces-18725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E39E7C09
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AEE169641
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C681FA259;
	Fri,  6 Dec 2024 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTD0oXxd"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132222C6D9;
	Fri,  6 Dec 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525816; cv=fail; b=mpIqVj26jdps8KCzV/T+pp0owgsrfTaSBuGnbHSxD+K8m+Iji6G+Gl/GvWUjrxQn6aMXivlHYy+mGM01OZGoo1U1GiwqvqQctEhZBXxnC8hgisg/ZgR9dSx52B8GGNC8K/3HT66mCQ16kl3YCvOUjAanTLjI0wz0D3tKPpihgTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525816; c=relaxed/simple;
	bh=j7wOQdDYOjDgRutV9S6c0uBLOIXLM0FoulivhCdO1b0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TfVH0LmTdf775TEuTHZy2gjdOZkzCw7+VnwyrdG2ePuywNAuQZEmcwlxCwjtprbZ+Ds0r09zGdr6KynOgOa1wGG8UW9C+qFjBtE4koN4fHg3TRkccE7RNhuBDBJub/rRjXCHrQLVG2FZu0xBafEGTjYpukFfnQhy4vyMZVQ6VTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZTD0oXxd; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v04o04LgItfRL27H0elOm7DcsBzMgvMwpLc8OCZ7ldUryk0/rt0Bu2d5DqlAO2UHxmxjqg17ZkJc2Zh9Pf1lFah8rWWMW4FWE+LKe+inoboxnNRNoQvadFbp6dxXDP+fbMvggOeuqJx/MkWg9Mxs0CwWElUUsfTgK1TdRVgz/Or47jw9fHzQxYeEA8gBulOkSNdKuiKz47yMTLoKFfPCiyg7wF/c3OHMLw5s0ovIq2JKflyWJu0McyQpzUb7ef93+mKioQ5CLeSoCaU7R/Ew6O+BgafrvuU6Eb4FPHaqILuB+7WrquoJYcj5PneNHkbaw7oYOyykOP7xppI20rAf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UbVjsUn25a7WNf1SKOR+2RGeSyON1LpUXM+9JfAea0=;
 b=VeT4IGH+zsif8SV+VECK/jmuIYDcIa6gQ0LTJ+JtOjP/AYGoQpT5Z3adewMlieWB+m0B3IHy/x5/DcaNsqkANrtcESM0PK4mo+mcqY+Cwt07mSDcMkgqb5Qd50gJ9ZkJfT0icVKWTbOEDZb+ylzfF/Gig//B037Y9noRwYYEBb1/welDtLK1vOoelTiFZQcqPAMJBAs7kSGsilZB4+bgKduRxLvNRt28fhd2VspUySVDNGB/8ETcnN6HKo7Bs0/jiBeac7lwdCsii0dmWaZAtYXauBcKquTF+3PaVtlYmKCSUeKd/5RjEkqBXQbQDcF59wkbHt6gXmga/TS+znyY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UbVjsUn25a7WNf1SKOR+2RGeSyON1LpUXM+9JfAea0=;
 b=ZTD0oXxdrm2XolA+RNK7CPhkP9tEyy8N8qevsqYAzo1J04PEKGUYGTFPz1IR++eySjyfX0agE3f8nyMuinQRI8KQlLBd4mkymz2cK1mua4916a3vZiJQVM7svJe8Xl99G4txzZ3AyY3w/CebRCWdrOZabCKDh+Kx2Th1lAzegAtUeu8vEcP3Pr+7BQX9m6vMOCj0gi58MInKyh3lVofh2khX/jcdUxJwqD45YCCVPiHzeAyK2iDNYVg7BJMH+47e/31bR2P6yxSKwGNKSafgTelUskQ9TOd0ZXxfSRakMqU+TUE30S8AXH8MYgBwa2iP7RqpxrOvYXpCrzDPMqRKQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:56:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:56:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/drivers/qoriq: Use dev_err_probe() simplify the code
Date: Fri,  6 Dec 2024 17:56:21 -0500
Message-Id: <20241206225624.3744880-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 94b0d223-635a-4cad-9675-08dd164944e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vL+hbmKALdpITLiii7sy9q9AkbB7ZCXS27rpo4sIZBjVRcNJ2UrRRdqLhmyy?=
 =?us-ascii?Q?CDH8g5eSPnKSOlnKMFmWC3omIRZ2ESqZopnZayyKX2mMlmpnerrfmA3tbq96?=
 =?us-ascii?Q?vHDuei4jwGuE68THiMd5RHyLs4Y7GJb3h+4ZMNoRA9JMB9X61HKzpnlYjAUd?=
 =?us-ascii?Q?N8pRMDytbuDUKohrCN/prbKfrFm8jWNNZHzniVBQc+rXGUfH6Yxxz7geZf45?=
 =?us-ascii?Q?SSzk2SIMZDeOr7447PzlwCB4Z8sAareAnnw7HMzeZQp9sKGKr6VSChMstHLT?=
 =?us-ascii?Q?sRx+WAK2lPxqYWpjwpY35Kag7O4W/8rpt8lpXqPTxIBjMjDoIhX9R9mCug21?=
 =?us-ascii?Q?zUQgRRsR9QOXWJvYzkZ2AIfMX8LAjSc26c8GhG7TAVVINvQZFGwrG6HObCaT?=
 =?us-ascii?Q?ddwgXBtwyszcpa5pYioy6VifgadM7v1yG/O9dwT0yvmeHrhnLLkQbxUZ+FF2?=
 =?us-ascii?Q?JBdBIo545AtU9c1yrSp6v9APLwS55n0OMDUJrAFT9id7JvS/+jB+7gyGJh29?=
 =?us-ascii?Q?BjoBAonZ/Z/R3sAqyH5TJMOCOkukEeWdo/eLwbmcnNIQiOrUgjdw+EovWZqt?=
 =?us-ascii?Q?NYuYZ66YA8EfkG0wyrTgnW+lOMJGL0lxmk7ICugnznW92rAYziqQO1AJZPEn?=
 =?us-ascii?Q?GN5hXHpEbJOhbi0ktNRtNLGrhv8FGT94VQFreLdOu/0od0L5EiJBmvIVec+s?=
 =?us-ascii?Q?rvlsfwGeRK12EGcmTkxLaleMbmVdbd/E9cMdGvfKUhmnM965CrnXw1poLsoi?=
 =?us-ascii?Q?sBiSOxKnvocYax9APTTGlZY6w99+KpqIqcvE1ZHjMjuz6XhkpgD3Ydx3oCa9?=
 =?us-ascii?Q?o9K42anSnjWW4omKwm+4qS2mplv/JZaaQRkVc6F4HwnIh94vZJhxQcCApSBM?=
 =?us-ascii?Q?iVNWP91cdtBIHL2hOJkgc850lrwPaOgtWKNV0ot5XUa/3EyyGuT4IV80HLds?=
 =?us-ascii?Q?y1TUmeM0ubYqjU9HhExJs7BWyAo0TeqYO69rRIJSIGHSlZnGDzyvLZ7D0grF?=
 =?us-ascii?Q?M44UJVTQqYE+I+TfCqVCYgHnTara2H3GCAGGAFuvB10LDa7AZhcNatNE9ePz?=
 =?us-ascii?Q?bOPObToFA4LUv1gQqQtFpfpd0cGHcpwYFruDGDdRrHgMkTLRaThiL6zSFh52?=
 =?us-ascii?Q?ytcj86Mw9XCqTDI7LvRkrUd0qs99jmfQnDugveWLs3RFhCN1+vGQm8eJ8nnS?=
 =?us-ascii?Q?GIvj6bexx9HY4Nlvx26YduJb/LmUkQf5uJjPTeWaw9oQmk1r4uTFWz8Hnbh+?=
 =?us-ascii?Q?Zw57RswHgB3aZrN135/Nn9ddF2OThPSoOVZw+Tpy4JLfrLreRwT42a7+4deI?=
 =?us-ascii?Q?u8gsrs7dzQme6kTmPwAe7zJHhXDvlb0/lztV0jLM2/vAvTiDRNuExFtpHz4L?=
 =?us-ascii?Q?FiTe2ft9KBMdYqkJkhAnu2fcTkf9ITCLOC05CdVHwGZMr7N0kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdiuvHAwFWNsVkCPR6R+E+mgd1fdLEiEPtrHPJJLzAFr/5Uo0ySKRlQDHH1q?=
 =?us-ascii?Q?lo8qQi9XnP6mCwhpn26sGIsOGVhzXtLscxL1f2/HjaPF6T9wFWlNIwwcwj0W?=
 =?us-ascii?Q?Ne1HHICwiaGTlWTFfj51brh3HlE0VxgSLgFgs850t5mYu4v+WR+wremKwSnS?=
 =?us-ascii?Q?69Bv767M4st1/WhZUnoqRA+nb7hhfvRpru/kXe6If1s0CKDkC4G5+SC68pw8?=
 =?us-ascii?Q?NYA7vWUwI3rwcMFXJtRXpiWHNmcmejB4kAHMxdmKIb/rsgH//WohtPvwJ97+?=
 =?us-ascii?Q?2/dmw7/i98qccpeU3pWTzX09AwU51q3t/UYfPCWWZGIFUMw6N7gvpnjUh95D?=
 =?us-ascii?Q?M5qdX6EhIxmXQoGDJ5fyv1WjdXrdK/n4AokguuMCW9pQ113bnvG188L69+Zo?=
 =?us-ascii?Q?AcELIwZQqkSaN1yS7V0klf7orsVoSaeddmR1gHitTGjs38NzbZ781RUsLujV?=
 =?us-ascii?Q?+zLMM92N8x5My74JcToO70du9HGtBstaYcjbyVwlNh5E8ZTEk/IgJy9++puH?=
 =?us-ascii?Q?7W2nmIhUL7WvDwMsA25bven7gktS7OcBaWBQZ/WVeRAcJ2KQdXv9GLsPl3ge?=
 =?us-ascii?Q?YWvpvBQIJ6trpXRdeEoHJCmu8i1Gljvi/F18X5kn0f8kSNnocXz0hXHLofKd?=
 =?us-ascii?Q?Bq7nZ9Vp9riNcfq0q2M/p3BmR+nkC83O2bv189TCE2xUfWiysgWc7hMRbNek?=
 =?us-ascii?Q?3PmSmEOnOytamIqtsCOPK7VWnYviLYTdOmfcZKULColIsgCTEKGh2JvMXZJK?=
 =?us-ascii?Q?H6j9C2u5MJBlK9BvQ+9ytB3D009WS66lU2L1259NLrcWgat/Ch1eEFszuDkP?=
 =?us-ascii?Q?/NDOyycEX8NhAghMGB+3JhCLJkbvmknBjyRdAa9Qa1/qcd8LyNSIjOIA+CSu?=
 =?us-ascii?Q?kAsYxG4fu4e6zxtyWDKbDt8WutpnU2/8e0npbZsNl7PZVkN3asdmTaQOxIWN?=
 =?us-ascii?Q?cLNmRlUtnYehD6GQswK3OfuSGJ7Ly1aHGUzd3fnWcz9YFUSJDFUZjfwOKKva?=
 =?us-ascii?Q?XThdFg0vDp70k2RA/4KoebK3thqewBthotH6i/b3PI7Gk9MYt3Do3O/CJ7z7?=
 =?us-ascii?Q?yJ3jjnJO1k76KmYbHNGp0IzQDuMJU4iZHTEAZdJPwPeKTwAdNzjj6WfRdP6p?=
 =?us-ascii?Q?LL9xSUmoIFIstahwlqCx9JzMEBkZOcScFO6Mwin1AHI7wWiD3VPdE+TYQNb4?=
 =?us-ascii?Q?wbWA33xxq0rCjhGBGzYzG8q9YrrOBAUrz/X1eg/n7dKcVJ++MZ+TN7I7G6SD?=
 =?us-ascii?Q?IxOIRdHXos9CLSBNiPE4iqlL+t24cbige3hrJYbCo3+hqoxmR4wdclQQX/yD?=
 =?us-ascii?Q?+qWzJ2HROMgPQr5GxskyQgIU2gTURgkF2ati8yu28YMW4q7av2A9s1mIPeG/?=
 =?us-ascii?Q?Z8D04pmWNwWqx2UPp9ps4pVwa4LDDsDpEcWfzyhNQcM65XhJh8DhulC2WZ3j?=
 =?us-ascii?Q?baL6oF8brnVjqjHwgqxbEu25yeunkpS6VIdbcvHaxFwFACEZLwzbUugilEhB?=
 =?us-ascii?Q?2mhJozD6RtsGRnLW0ON4vKjaQ7Zsw+A6JIdpqaw9mcAmnnRJy1H0wYxdFR7C?=
 =?us-ascii?Q?WnbxgLjh/waJnNG9FnQ4qnh/eUJ1A9qK3Bai80nj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b0d223-635a-4cad-9675-08dd164944e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:56:50.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEyRjmZeSjdnHy4q2IThT2jNgnM/DLbnEZeDoz+fx/0YsWcqyMnD56ngDgBCPGt95GxeNiYv0w2PaXwc4e3epg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 52e26be8c53df..baf1b75b97cbe 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -296,38 +296,27 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(base);
-	if (ret) {
-		dev_err(dev, "Failed to get memory region\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get memory region\n");
 
 	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	ret = PTR_ERR_OR_ZERO(data->regmap);
-	if (ret) {
-		dev_err(dev, "Failed to init regmap (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regmap\n");
 
-	data->clk = devm_clk_get_optional(dev, NULL);
+	data->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		return ret;
-	}
-
 	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
 	if (ret)
 		return ret;
 
 	/* version register offset at: 0xbf8 on both v1 and v2 */
 	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to read IP block version\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
+
 	data->ver = (ver >> 8) & 0xff;
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
@@ -337,10 +326,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register sensors\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register sensors\n");
 
 	platform_set_drvdata(pdev, data);
 
-- 
2.34.1


