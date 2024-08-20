Return-Path: <linux-pm+bounces-12556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A2958316
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66C51F225CB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086F18C34A;
	Tue, 20 Aug 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cmZ9KJ32"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010063.outbound.protection.outlook.com [52.101.128.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E218B473;
	Tue, 20 Aug 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147110; cv=fail; b=AtrMQkQ8r6pKmbO8/wZAlPTkXSjhesRW7M6Kq6Vt0m4QQKEcdGxifel+35v45l9/QJ7khf09fHw5m6lrVfyk3m17A4mVSDztlw9yyn07tuFCYuCgxXAT8eq5cU9bnpYKDCxBVHqJZCpSepgmL/JiOMnDawfK9i51CpwTZ/GM7rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147110; c=relaxed/simple;
	bh=wrf4IIeunXv90WZPQy/hzon8M6zJYWcQzgYbIh5zFks=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D6UU383HckVSOysdjz2CtpHRTV83J6FEJg3unaz7OSoI7XgNQqY32NHcZ49y1/jCJJFL+OyeRd7QxUj5RzJEoCQ2HnBJKUAlo6fG9BiLq41iOYVdIfTFXpEzZDAT0r84WbnfGp0zQJlqJmN4kqSr24m68rE0PScC2sDoB1+nWV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cmZ9KJ32; arc=fail smtp.client-ip=52.101.128.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9GhxQPUk8k2sdwvdJ37EdpkSSC3oYrDoBne/o/IusYCv2KnbPNZnZ43daZGbBLqcdFpFMSH2su/JuOX9eBWtixifEh5qIls17fD1Xp7UkZ0bbyhwopSuDRFlOR0f+VXURZ4L293d6MbfGa1R5sGvtxsFfMxXWIeaZS2kngvedKiiz+BUZJ6PBrLo5Suivo8Djj5cak5/NJR0e009udVkifmkezlQJyL3XgywslOrHmFdBVT9BmDsI0s2zi1IEWlqZLL8SKpDui1+NgU5vK5jGO60lCf32prdnm1ssJFh9PIQZ8Cs3rIjhetqNVIctMIR5woB9ODAf2o0/DGXYskeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v1nQCMlzXy/GQKKLqyAkJK11bMSVju6W9eump/aTHM=;
 b=thq7x6Coju59ruMKaZ85FZYefNPqxOhe4H3AvoGFXDpKXq+dbBksRXn2p+DvhAG3I4FaVn1PvA3s7I+kp3A6bGSgT77oOO9blcVFI9Hxanf1vdFzTNPwxj9gjl8FS2AyAZp0X7ZXGZt+jxZTzFCvwE1mWnqO8YOV38eDmNC8P8mmy3bnZVb0nWxIEEZVZuQgpTtCTsjj2UsFHx1rsflpF6Vkpa+plBWKDt+9jXjUvfMyEa41v6WUbT2+3rZGcOnMOzrpl4JdqxyVv62MxEIUy1rsLfG/GwhO64q0AD2D1AMt3TmPxl/kwfP4uQN22cuppN9yjpNZFw/O9jtbc4NmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v1nQCMlzXy/GQKKLqyAkJK11bMSVju6W9eump/aTHM=;
 b=cmZ9KJ323eOfrcQf6yPrJ41aMvnLPm1GtmgaB/Dvvx/yNR1UCAnJqKT1/0t0CtLsLubpuFk+J1Pt2R8Nbf2GOOT4fzVFyvHkUEFBjpmSHNS6HKNF3WHkMeja+mRho2OHONTMueK9JgIOfRtWRkvxDC/Q8eSKL30NB9Ypa7p40RyvpLtwLoqXVvlTGu5v61zU6RXJNnlpxmZUUF2MveOC7zts+5YFnlTTk4TP89DtUEqLoGiOS+xzNSfpbindL3WyLBi6CBKT6exgPuhSI7fos43sEXy7bDK5OrJyQ6FN3ZWCmjCSD66fAObqt+tu448oacMiFTO3244uT3YX+6tEog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5829.apcprd06.prod.outlook.com (2603:1096:101:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 09:45:04 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:45:04 +0000
From: Huan Yang <link@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] thermal: sprd: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 17:44:49 +0800
Message-ID: <20240820094450.101976-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acc8ec3-d649-4ce8-6b1c-08dcc0fcc4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VLP5QdpPqvOXnQDJRfTE924U4Bo4p6mubYfhP7ZWP1OVLqaWilyT1d79ARLq?=
 =?us-ascii?Q?HaJjVGV2gg3rSpDmJ54yt3+Op6Vb3sKcs25fe3CiFJOPrd58xUF3dx52zSXY?=
 =?us-ascii?Q?Ug/k61mZ7yYTKcBY95FbtQ1eJgivgqtXUS+z/wQhlWUAbK2HzTZGcm0hPOkT?=
 =?us-ascii?Q?1D8SwSxzsp8yAcXl5pUAkrHRdg2l3xbTNouevSYxonxvIdaqIJN1u3AdHbas?=
 =?us-ascii?Q?epU6tnNCkGIbDhisF5jSxlHBkBaS5VJQg06A7Jtp/ZoPvhl16+NIfLJKrYpC?=
 =?us-ascii?Q?uDSo3ncoO4/HMy60md8v95gVQpyG4EOkNgrF8LHZv/FOxv0IA6Z3nT8rT21E?=
 =?us-ascii?Q?+XrCQLgmYZvqrvEZWsDMlCmJ7Ux1L0qSZbSwzGSwj/CVc6u+tduS5GqEIGB2?=
 =?us-ascii?Q?0jb0hbIECb2uvKrtvLKpnMY2KaSnxHSQk6S1OgpyBJ5wRZYcqj/tVmcJQn9M?=
 =?us-ascii?Q?v1nIQOc2IUdDm+ADliiDDO3YRBZjXVtPo5xHSZ+XgzFTJFckbZZCwkWPy2uo?=
 =?us-ascii?Q?GVEzywAhwLEvWaCvtL2OtbYDGbonQM6JstkNjzfWv+5SqiCxGDxdoJWBsi5W?=
 =?us-ascii?Q?GzwQjQ2UTH1DnupQ9Hu61sOPzLVos3dqFw8pm0nFbYtEm1J9CzIZTIJUqEbu?=
 =?us-ascii?Q?badlizYGI8NieGGrGaabuinlJMQqLm9b3c28gWVuQ68pjrI8SycVvOBbqE1b?=
 =?us-ascii?Q?Nx8nyLDHSfEihDDsBWUV7FyG9Ad4mVx5tDcItk3eV8FugUS5m9A1ezIG+wZJ?=
 =?us-ascii?Q?pWuHaB53OXZzSkjzI5MZDWaRNQbPTzzTZP2H5Al0m8UJ2rzwXwAjdNnNEXo8?=
 =?us-ascii?Q?2WbK2UQTRlXZxu4TQHSPGFXjips03aA9Y0uA8qaCavcIS9D/iJw1en5A+luA?=
 =?us-ascii?Q?rk8n0dRT+WwabNSr/LpB4gQDr1YoNOv/YkM6oShcTrA4wuJcbXRTVwRDcNA7?=
 =?us-ascii?Q?k1mGRC51dVWLVDT5rvodLCx5IBTlMWNIHp3SxOw0mE6EI3usRI4WNXAM0LnL?=
 =?us-ascii?Q?RemY0Cj/96Isjd3nXbtG3EtpG+rBO1UDZFU8OFvZjn1yrkhR83qUYsS7yBFz?=
 =?us-ascii?Q?Oa4Rfm6qbNMaAaQFBgt22tM6tWppU4SIyNp2wasOmkgKp6Wl+QnHOP9FiBG1?=
 =?us-ascii?Q?q8YJG9GbZ0+pI+yTi84AvciyUUBdK8fmqhAicz3FHAZeOQANng/wVr9m1qT4?=
 =?us-ascii?Q?sBQB6r8CattHpbEd4IOjymNS6v0re1wD+DcJ/wXaV4CUMLQV1oQFd5OPMTYc?=
 =?us-ascii?Q?QCZgFM3UnZbB25fd2vryc/J2I4FiNAuvg4guHYlshA596LQBoQIsfiXYZhCo?=
 =?us-ascii?Q?CqFA/TLZylXmcWiO0Uz7wJwyx9pGc3Ewu25ApP8f0yQTstDkLdvCq/cTUskb?=
 =?us-ascii?Q?bM0GPxTJse1pr5M5MUN2erF/qEElk491psr+bKmsVZjYr8M6Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1tWsRIVYoWN6HS449xYy53AWMRwm++HqwTK1Wdh03WEZzgyCWfdebnoyySu?=
 =?us-ascii?Q?rgSRcJsIQJkDMqmGvABPxySlixASq00mh6b/SkpZl/sBT3AWhf2ocaJ0snj4?=
 =?us-ascii?Q?w3p44LxBXEsVeWfZtwW4wRQRcmWr1wv/XY7lV52+dVZ3TYUdl75eqDpWJjwl?=
 =?us-ascii?Q?3rDfjCmFjk0UcP7AQmIovWYzDYxHbuRt+RrX9+lDs0iWHBXaZr8AE44APX1s?=
 =?us-ascii?Q?H0Z1CDW3cyQTWl8o6x22AZePDu5laT33q5e7EVBiZMdZI8cpewlqOq9MAHQn?=
 =?us-ascii?Q?X8OimQE3IvPsbjAnZqD3tJoa2xXLH+D2RC2SShRWKANLhwZQFfejUNZhKuEN?=
 =?us-ascii?Q?0Y3F3d2iyiavgToW4BxNapdMBt3F1PRUOU8SUem9I9GGI2Lu1RjNVBU05UII?=
 =?us-ascii?Q?giiuoFzB4M3pcJpGFbS/q5rIh7seowW2kaNZ/oU+56ptBqAf0SuDHaCcXFKz?=
 =?us-ascii?Q?IRcNiDGduDJow+F7QgCmZTNs1hs7rnYzp6KL+xmAZv5cfBuy3Ad1ArIiiYTl?=
 =?us-ascii?Q?Wlj1CdeV2uwOJubtdy24w2aGQ3QYwvKwi2QXLbcTdLSOswKJ2QeflSy5C5j1?=
 =?us-ascii?Q?8C6IonhmNs1OGMioc72Mw3o8R4DYRXrSTYj70zQzGlZIHU1YT9nN3pNI/4qf?=
 =?us-ascii?Q?KqCkQbNtGP2sHqScy4rOSt57PGSqZcQyodcgdNKV3sTG6VNH70F96khvqQFq?=
 =?us-ascii?Q?Jc1SiecSFVObskK6xsxMit94hlvObFWuieZaOUg7N0rf/qE96gCyFb1FSRCa?=
 =?us-ascii?Q?Ge4vFGaLb/SfZGkp+88TpF1iPbXgOnb1qZFGbLPPozlS+MLNSAVQPFfUvtBr?=
 =?us-ascii?Q?mUDbB7rnnfZ0FPZSZq7SM+IWsjDXaIem/LzAHztzf0t530w8Yg4w+WCA38+q?=
 =?us-ascii?Q?HGqKRMwJrAZCD4dj83QFSKdV99UpllbLCGOzla57Tqt8X6y4l7beNPBHE6x+?=
 =?us-ascii?Q?DbwCmy9vghVQ+Prw199SMUxQr6GPHs09DSFsH8KQoiLeIdp+tkcfPbcluA7p?=
 =?us-ascii?Q?HURl2iXPYS0BUXnBBt/i4783JfvnKzHtUoKj1JykG+MOs8bSeZL+AlM3R75d?=
 =?us-ascii?Q?aNnUFkkCrmLTiqYVItXI/iWNoE8MDnyT155Si9WyWjB6wL0GLKWHutOxtvd5?=
 =?us-ascii?Q?JhhgMd3JC0Ai9BR4d6G3Y+r32kwYxZETMg8B5+QMtPF7X+SCwtHr6K6QHKPa?=
 =?us-ascii?Q?nkAKEMZ5HGEflSCbUSSkceif0oOHkwgFfQrOChmMB3uw/OXXT5AbpVcMCODv?=
 =?us-ascii?Q?pLuNhiPAHxyG0UsbKso6mbjku4QJLciEJOqJcdfK3rdrezGZPEeY0iI9gYGb?=
 =?us-ascii?Q?7UCC2wY6vccquLy6InTj3jyz1KKsL4bmQhzIqoqjCcMLd935jsp6t144z2Ar?=
 =?us-ascii?Q?KPoJYq5vZjUbjnL0/XYiAMBGuA+CuWChm7iATswHndE0qWbuc+HXIw9F5LiG?=
 =?us-ascii?Q?7xviGcs0YZ4mWCYs3/JyBM5G6cbp3ZMhQQy5jLMDc8f/xaOkgAbDO2cF6tBq?=
 =?us-ascii?Q?J9dwaFqbPjoLj0gYP1uL2sbGcbIlXJE7sa3WqR1e74lAoMQD2Ck/7T580MNB?=
 =?us-ascii?Q?Hwi6V56uT4zj1priMPI8lxo/lvxsritgLh1EJO+d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc8ec3-d649-4ce8-6b1c-08dcc0fcc4e6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 09:45:04.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjNoXFGDqubW94lsKNsTxBPR67xR2xV0t8g88X3I9dsjBxjAcGqn2Q4q/RoPFYStzYzSPAWY13wk+TQutp7/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5829

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/thermal/sprd_thermal.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 874192546548..dfd1d529c410 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -359,21 +359,17 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	thm->clk = devm_clk_get(&pdev->dev, "enable");
+	thm->clk = devm_clk_get_enabled(&pdev->dev, "enable");
 	if (IS_ERR(thm->clk)) {
 		dev_err(&pdev->dev, "failed to get enable clock\n");
 		return PTR_ERR(thm->clk);
 	}
 
-	ret = clk_prepare_enable(thm->clk);
-	if (ret)
-		return ret;
-
 	sprd_thm_para_config(thm);
 
 	ret = sprd_thm_cal_read(np, "thm_sign_cal", &val);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	if (val > 0)
 		thm->ratio_sign = -1;
@@ -382,7 +378,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 	ret = sprd_thm_cal_read(np, "thm_ratio_cal", &thm->ratio_off);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	for_each_child_of_node(np, sen_child) {
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
@@ -439,8 +435,6 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 of_put:
 	of_node_put(sen_child);
-disable_clk:
-	clk_disable_unprepare(thm->clk);
 	return ret;
 }
 
@@ -526,8 +520,6 @@ static void sprd_thm_remove(struct platform_device *pdev)
 		devm_thermal_of_zone_unregister(&pdev->dev,
 						thm->sensor[i]->tzd);
 	}
-
-	clk_disable_unprepare(thm->clk);
 }
 
 static const struct of_device_id sprd_thermal_of_match[] = {
-- 
2.45.2


