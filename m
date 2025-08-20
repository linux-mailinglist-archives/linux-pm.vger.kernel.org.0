Return-Path: <linux-pm+bounces-32669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53105B2D2D8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A77A189A96D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658523816D;
	Wed, 20 Aug 2025 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="no7+KU6p"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012018.outbound.protection.outlook.com [40.107.75.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E2353349;
	Wed, 20 Aug 2025 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662697; cv=fail; b=RAFI3oYt+xmG+wA3CAPyr5/UeqdB2Z5Wn92BjD2nWGQyb5w5MxA4pEfEnpff1YsqpZDSZZnUVIrjTJyDJPdZ6G44rbOq994QGKggpV18zB89t68jqRikE4XaH/M0r/uJdUHW1gGAr3nc2fDsTMPfcKTWWWgRYKpSZCmsyNksyco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662697; c=relaxed/simple;
	bh=/EM6qge21NKpwGSLjvRuLUYzetwA+F+6NEG24dox+jM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fXpLWh9qnbGGSIJOFg8479iEAmdfpupf04Ah1kuBWyMp+CgqmzGC2MHSrSs/ihg1w/b1fMv6uVA4QtR2eT2AN+2s59nGjUFJofQXOE+57JZ29oe7sIWxVfxQ1ofxD135Pa+SHOQfm9iGNjaROvOAddJiPC7G1NTBXkAEaaH66wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=no7+KU6p; arc=fail smtp.client-ip=40.107.75.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPZYHbBGtm/zYBGl8FVXISA2YYbFKOU0HrHh2dLielrJdrk9pOiUx0P0Jtz4mJZ6XqWtqo4ya4/BrjbSS4IPlgWsp3gocLzUt18q+K/lscY/Ce6xQsTOrUZ48XwDGIddaUGvCeRxSXUzxLGTnv3TBv1rwdfKiU27DDR0LQeIa1y69WOjnXkaicBTwtK8Ttj9DgapibmmA3Mah0OZYxpDSQwaolovOG+NzXGQ9EDXjv4H1f3VY5aosQEg9MMCqZHBwepgtO4qoP9BV6CcIkgp3/ql9HIw1OBtC8eO4CfltBNGjq5E40Wa6HoQwHJxU69/N5rQjDkEQ3xW9NOIIMk63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFsTF8zIP752OyqOXo5CAHHh1fUhFKvJyPQtQdvElLs=;
 b=UUHRRmc3VjRKa2DaSQBV//NyIu1H7uec+1I6nizPEpbyMmMyEgehH1Y6ny5soTYLXNRBREHEthev/KdquIUCf3mvWW11dLskPc1fr0Uo1O2BmR+uykNLgS9oNpqdmPyx4xHnN7OHYZDFunqqYtDoWSnneQIYXKO0MUsoI7H/CG0nM8Cn26uxJsuH6yGWECr7KuCaYUccYEkzWxY5dLkvGLWmiyvAD5PmvtowHjYV1DyvAdMRPcjO4i4GGadZEPXv2b4HH5JFqpE4AXUVX1Lt2BONYDfRqLbN43hPNqbAd72tJ08dGPN2Hb58y+Zxa4PRDJ57FGypdF/P66DImfGt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFsTF8zIP752OyqOXo5CAHHh1fUhFKvJyPQtQdvElLs=;
 b=no7+KU6pYh9r3f9EDh2tLQdtUdknM85QJC0oFQtXH7qM5F52+U7blfmA2z35PYLCoxA+Cr/C+OJCydKhYYTMN3R805bQlG/uZAlBv3M9Pck97ayd2/BeQd4kxj5Zo70yNrqQHf/P4unYeuAti13xrkgJNvCouvN8pgb/x3L04DSiGMUulPx6kQU34d3TPvmyCBnYSsTuEy6k4czy61ndNb3LattGYR/ZQ7AVF9M5Y5xuXnPIWpkZ6GRXSM+iZMSztNvF9PByHUlNmgvMV1EV0M1FtB/+tYB89uQE+DcTbyRJVa9rVWUlqZcee/zZ5b4W1VYSJz6WZ48eBBkDlgxP7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KUZPR06MB8024.apcprd06.prod.outlook.com (2603:1096:d10:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 04:04:51 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 04:04:51 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: sre@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] power: supply: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 12:04:41 +0800
Message-Id: <20250820040441.124894-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:404:a6::18) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KUZPR06MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1fc83f-4aa8-4e36-2ef2-08dddf9eb67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aaOOUslZzmeS6yn6UyjKLSL8KIz63VK16ZVxQcZXVGTk6ucBYKql4FC/H26l?=
 =?us-ascii?Q?k6ZDMp7QF/7LdcakLouarUJiIbV4RAiBTi8ECAvZTFWNWYUb7Pe/bAEpbiLo?=
 =?us-ascii?Q?Juocjon7grFjjQRAmHRGPxA8vN2Zl9CtOWgbGD66G1GCnSMg5MUgn8NiZGQn?=
 =?us-ascii?Q?zH9Ow8xbBloJ3KWJWKi/2AqJF0maBqb+wjKdwRtA7t9+LcjWnlhcbg/naX6O?=
 =?us-ascii?Q?QjQb8bXruElUa5lpnB/Ns02b3q+KgZVNaH7tM3pcM7FWRAkB4EHsDiJwUbRz?=
 =?us-ascii?Q?P//nq8evHOf2aS1a/hTolJLd4+3f9tsbQb0qQ6q68MyKzRvlKEaxVAkDz/+m?=
 =?us-ascii?Q?WhyQrfDwRuC38FqmULp5HFxAM1q23RoVUDwPicJrijdHX2vyOUVXy5nObny2?=
 =?us-ascii?Q?Dy5y2RdsFOMH7csOQQsNe64+KnOlVveax4kD3Hxx+iu3nM+iyKQ7cEYNBciB?=
 =?us-ascii?Q?zb7cWwDaS3ogw6VK+dlq5xK3CNgrzDwhLK+C4DCXPirWiA+7Y5rEgZw9hxmz?=
 =?us-ascii?Q?w6Wo2gswFsUTortO4OhDA8ydV8NUxexfW1a9r4Ud+IMARaEaNmnOP/8MpY92?=
 =?us-ascii?Q?AWoXIAFJEIMc8Xyxf0bO4cX9MDPAgmNMV/5YINGCZ9tdF8cb9aQR+bO70crX?=
 =?us-ascii?Q?+FrLXf+LeGXCizklz1Lc/ag+AV6BF09hMmWEoSNTTnOUIQTiBmiSZyJGPrfM?=
 =?us-ascii?Q?S3JmOW+B0eB0OSqydKye0PBEeWpVe82p4N7rZjA8vSomkQpZBvxwqhhDJoH/?=
 =?us-ascii?Q?v1PzQOEshXW0lFG+WGQZTz6POC502mBvLj5OAgmrvXQzD32sPWKRzfahr9hN?=
 =?us-ascii?Q?ls8AWT3sphTizJLRNu+niSBZvTN2bE/MHXF8CTkU613uJavKw20tPvXbmaCV?=
 =?us-ascii?Q?UM2xMmUPmCDWBgR4d1v94tbV0kllbGs7qrP+aWCWPnblpyDp4M0ozpGRTwQN?=
 =?us-ascii?Q?N2FZQhTEhSyDqrsD3dQMIdKovhm+Pvb5ra5aIB82ALCA0EkE5WYru53SP+vE?=
 =?us-ascii?Q?W7AdvYQE/8fFIjcfmXmAjRIcXJG6kEw+xEJ2RBIRycGBSdCjlRl3oIOWV46r?=
 =?us-ascii?Q?wAJROC/SI84LQA4OstVdMi/URTCbIQ7EzjYbj9gFgpTfhsMisDqfW1ngkfxs?=
 =?us-ascii?Q?T0AEF+j54QZGBQeRod72Q1XBiOIKl4pHG0JERdDJ0c7rnHFXPP+Jk3v1SXYr?=
 =?us-ascii?Q?jV/bRda3hi6y5s4xrhxF8i4gfkJJzlzapMnfc1ynUAMEgErWI/AQ0TuRXwl/?=
 =?us-ascii?Q?ahveE6sv71pznRg7iVHCrFJg5cRXLe7q5KAaJTDID/CFDhnrnne3y+0Dk693?=
 =?us-ascii?Q?UjkDj9Y3yvBgr+NOQXsPx6hmvloZ46WLIV96pQuUygTWZ5GI6Yof/I4d0oku?=
 =?us-ascii?Q?doV5EVHiKdIN/5L/5VGpo8BXMiAvkC2UC7uJG53LIoW3RhoCLddY2nO5Swjo?=
 =?us-ascii?Q?ic0gDUjztP3VXgS/xQBLxxctNZnTf2d80H9pF5kygdJRbA4mG5oAyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Eg79n9peSKOmMpW1FOD42ATk7DP5Cwxfafy7uI1pFTBNQen3m4DkIm+5Xhm?=
 =?us-ascii?Q?UXJrvVJlnlaolrSuBYlWUwKa9xjK2zDYZwWTigW5M6rpxcziXQA9xm/QAVJK?=
 =?us-ascii?Q?p/Wq7oI0Ca75JaY86Ba89NGX/LDktoRZ9IyNrrYBnB2UV4flh6+IkR/YelaO?=
 =?us-ascii?Q?uWqSmUGWlQWp7a5YmvzHxlZ0Z8vh+ZxSt3M56IkGfLPl/Zsod0ZIYvMIJaOq?=
 =?us-ascii?Q?60w3QcLtPop1iCfelzCbJbVHHVKJ2DWCNXMd5da+haEPHcd6/oM1IogJJPX3?=
 =?us-ascii?Q?j+YqN+u2/EYUwdOe3DdUEgWkY/sQiaeijfUPM5BmM9KwSsTAgL3YGHyqRTWl?=
 =?us-ascii?Q?c+8b69b9NE23ccuJngwTWbiRHCuJH+t8VQD5PmT0iIsPgzg6xuRg4yK5zXUA?=
 =?us-ascii?Q?krHE7dE53s5w8nx7i6CCNEYzvo729GTopllFSRPnIdOo6uCgd45E+pJYrHBY?=
 =?us-ascii?Q?uN2VjDZTX/diwDUHPH4WzCbMh/B+k2oECto9Kw4hI/7jYrNDujRPod4hzG+7?=
 =?us-ascii?Q?kFh1DIjA86AHLIyYOpA++hhEGixVg3jbU0Njn/s2nBYPSiyXD4wrZKJUywx2?=
 =?us-ascii?Q?kOXOy+rc7h8jtW2Xx1y4hMWgXFWANE+GlDdU9ujJNnOBvhYAStq1HjANyJfk?=
 =?us-ascii?Q?l0QRUTLLcoqjz5t2meEC+pqCwaNupw2AsP3IjQNSJeDiQ/Bnd8vbeRgFuKiH?=
 =?us-ascii?Q?QnZlv6ARR2jDQRsHHowC1laPpTXw0EA6dJoCA7ExXw0RYiQPYTdYzF8iydkR?=
 =?us-ascii?Q?dkxHZRgU7rHfAbCI1gSAsK4m1KaInB3qT9q8DCeLrijfJ3mqXHEZ6YzPsMMI?=
 =?us-ascii?Q?8cVTwHX5g+SC+bMTAN06HgcU0I7Kbtyd46SoqvyJQWhDxYzd8hIm9D4Fl/Is?=
 =?us-ascii?Q?C/mXWaw8x3BNR0kKcU2m/knIZ8Brh6pShxGzRcmW/cpXF1O8LiExNZ0S4mFd?=
 =?us-ascii?Q?JDOdCOSy48D+2d70sp+JV9ImVJqY5bNuxWZjpkYQJDiBwGPoNWYZgDpwNHTi?=
 =?us-ascii?Q?ZzP/vo74bSq/JrE4TffMobzuoiH0H5z6I5M80p8mYUOLK4d0oszNYblx21r6?=
 =?us-ascii?Q?LChuHbLm2B4/cnBCkqpq3ACuWDCwGYDYmbyr9r7y9UZjswS/x5cW1VWqQ7Yj?=
 =?us-ascii?Q?BoSoNP8TVVkfiZ2QAaNFfazqbCSyWcs+bSSTPFMnbzQ3SnHgcHwPBMtdmL7g?=
 =?us-ascii?Q?ivQLDZrqTeQ2CY5CIce8xM6DoMydQmTAr/14ad0Zh1bPPKEY2wVFGoF4sJSa?=
 =?us-ascii?Q?hH4QWuGR9lhVMlk4tGmlm7EtZhCNl34QmMLJnOIQMijphYOY4NlZ6RZ5yIAs?=
 =?us-ascii?Q?0cSMsf3RSIY5bdJraHQ+2iTBvOynjIwH6f/xsgp43d+lB5e+KFjrfAzPAK5t?=
 =?us-ascii?Q?DEGNiKe7d9C7ePHrcU25rtLQcDNr6BSeRoW6AdLM16Q9Pv3uH+CP2zmRCtP1?=
 =?us-ascii?Q?a44mwtaFpoyUaZ+2Fs4MJT7b2r2UdCIfPoLBxc/zB0ztSU15eXJ12sKeGB5J?=
 =?us-ascii?Q?m+XaKZcBaSICqKDFcF1XOGH/9lKn9c+LO6PwrdS6uFMA7WFov14Gq/Y3eaCu?=
 =?us-ascii?Q?Gv3dRZIMxu9bmgP7icqx2eXjc1kIgTQOEEWARmz4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1fc83f-4aa8-4e36-2ef2-08dddf9eb67e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 04:04:51.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKZKjY0HlR9UUP/ATVHSxVMz8bQ4y7YhfQfZ/mvPWvXIL7Z6382jZ6Gqr7eZaync6dgWkWzKHbo3IY6PPO55yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8024

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/power/supply/max77705_charger.c | 2 +-
 drivers/power/supply/mt6370-charger.c   | 3 +--
 drivers/power/supply/sbs-manager.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 329b430d0e50..59090703cc7a 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -546,7 +546,7 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
 	if (!chg->wqueue)
-		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
+		return -ENOMEM;
 
 	ret = devm_work_autocancel(dev, &chg->chgin_work, max77705_chgin_isr_work);
 	if (ret) {
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index 98579998b300..b7bb7aafb067 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -904,8 +904,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 
 	priv->wq = create_singlethread_workqueue(dev_name(priv->dev));
 	if (!priv->wq)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed to create workqueue\n");
+		return -ENOMEM;
 
 	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);
 	if (ret)
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 869729dfcd66..6fe526222f7f 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -348,7 +348,7 @@ static int sbsm_probe(struct i2c_client *client)
 	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
 				   I2C_MUX_LOCKED, &sbsm_select, NULL);
 	if (!data->muxc)
-		return dev_err_probe(dev, -ENOMEM, "failed to alloc i2c mux\n");
+		return -ENOMEM;
 	data->muxc->priv = data;
 
 	ret = devm_add_action_or_reset(dev, sbsm_del_mux_adapter, data);
-- 
2.34.1


