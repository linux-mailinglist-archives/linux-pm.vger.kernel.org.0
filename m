Return-Path: <linux-pm+bounces-13224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06914965F77
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29CE2892AE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1418EFE6;
	Fri, 30 Aug 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MFzZXQRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066618E34B;
	Fri, 30 Aug 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014433; cv=fail; b=HM9dL9BYX9Pgwx48oX4g58KOZRgEs0zobsqETfU47kmQYWeGN4WVERvKwSvhqtLbxXKql1durc0/LD0FSUPM72m5737qBVg7cL72wtiECpdspOQBLmoaRjiVXEVTMj1PaMTv+nFIWUmUGKbuPr3tljfbKi/xe3jtg8VskNCZZKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014433; c=relaxed/simple;
	bh=PENPyhFloIeJJRsDjdsdmg1hcdqnsfRMhs0SEheZsRI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=paO3OASwrEd/u5VygJmEwsnxAGHVK8ZZlUH0a/7JFlpI2Xhpm3QOy+PaFxSgOq8TD8GNaNuyYi0Av7OGpALJxzFGZLLAhaeASpb+h6Cypxdrx2WhIo4fUneXiRxVTwGOHzlnz8YTPFVzSexkaC12LaiSCwccI8is8LQQCtUhreo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MFzZXQRD; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWTionfstYjrAYXNF66edDCYTz7wnVEMd11gCMXemBQy3eyG/OOQQLC2WboInV9kVEhUwAUllSbm/JmKxClwDzLxPbi43XgYnMgp8Jvrr4O/QLPLX/y10XV5dI0CTRAkss9J7n84uSMSRCDfAXp2TY0hUiCTp8jEXYympE3hYAHzGcKptSAyyDNZzlYqRTW9gH2zpucA350iM5Qv4iitUfaXilMpKxHlwlQvAKNxlXnaAfr4Dkwn4TwvL4fAeXOa8KwroAzSmpkIdX9lr8mGjYciK0CGzMvlmC5t6wHVRkIxSY5EaDaSLS9fPsNzGWf1d9cGA3UB5/rnOySIooU0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g9iYfqWRBrMxYc0RRK7XuXREFEuviqjtlU+5yC/izY=;
 b=G5zSFET4xwqxYqvvgf1O4hbwIE3+Na16G0EqgDoRyhKBPRbNLdR5gJlDz0h92ra/EMVprFmVoHCa8Cyc2p9KuwYkGuaZ49KW9at2ZQdBFBXRrborTDPIG8aUdzCui+8XZCum3VsU/883zW2Fs91cbTT+FzNLCOmcmpT1GaX6Kbc0w7SZWCBwnf70ogGE1NyVWIvVfLAaz36f3Q1dpZlC1AGvTkcsNK2Eh1eP0PcyQbYrenuq6U/rFGyy0NNnjt+mULD/vFszsCwz3sRF1fkcjuFpVDLIK3ehtSG4peVSz31ysK+eEs28FtUw8zBPbOVXwBNtegB7FbUecYsW7SfZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g9iYfqWRBrMxYc0RRK7XuXREFEuviqjtlU+5yC/izY=;
 b=MFzZXQRD57cp+QVTZq6sjewbslU6l1IzMBcv5WkyGtcQhEE++OGZ6sXQk8TcqqIqrqLCpP+EOBMkrA9a40u1G75Hb8J/iaLnHXmbD3KCSv0Eo0WoHy8aEhOcVrjy72eN5QOX/kubWDLiGEsXM10jHyfsEi5vcyENpZLULMLr6W2dPsGtqkdTRjJVR41+OCJCbDiwwnkg7237DUqjApG3fcCiW4pFkiB2o5GmsIziQV9JbnSwI0JqbsENTBEtNzzLrA2+j4Q5NP5TH2rPoV/7nx4MbCg+SvtMJMO1Tw3XPKuVGFY3hgRISf105VcFJ0ecM6ktwe1pHaRXl31uo8P1sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB6667.apcprd06.prod.outlook.com (2603:1096:101:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 30 Aug
 2024 10:40:25 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 10:40:25 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: mmayer@broadcom.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] thermal: brcmstb_thermal: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 18:39:18 +0800
Message-Id: <20240830103918.501234-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: a30b84dd-c04c-4236-7edb-08dcc8e02852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8YdyE93/zLyLSa5GPKtxWKE9xepuXDcJJq1mpQT1lgnJ6MAlX5kJURwhciW?=
 =?us-ascii?Q?yKLr9Q1g6wOkAeJBjyxbquOas6YRu3jPx5wsQSu6zNOp0MF2Ubh6KcS/Z2Ad?=
 =?us-ascii?Q?NngG0j1ZrMqZf15urRNI7lOwVOexWTVL23Wq38QQ8fSGPSrVccbm+V8Nlc2y?=
 =?us-ascii?Q?GVGJkpIpqT854Fx7NwW3czwbxqKekMsmleploC7LlJIzYhIgg/uVDHCIBGPn?=
 =?us-ascii?Q?mngA943cG8zeqfho0tHnxOrFQWFTlFJvD3yg5OzwtZEI7kUbp2yxnGVffWCN?=
 =?us-ascii?Q?PnUbPBcRSmjb/FmGlgZB+Yb0U7zpS65e/0S0z/jd2nvtnXtp9UwEl3vPwzIp?=
 =?us-ascii?Q?eYE5Iv5dzQ3QZJX7gNmqabCBNwOFsKud/4zLU4YFNLGR6HfKClpPE/7WE6mu?=
 =?us-ascii?Q?eVfTUrdDPbe0uM7vmsEBO75bHLhZcps4ljyDz+9DT+7s5sz0sOZ3ELPWUxZx?=
 =?us-ascii?Q?C/JnhSdgR+svr4+gs1Gt6CuxLdI9M7h8KaTOFqJLTGONBGfQBSfeLeGFOSkG?=
 =?us-ascii?Q?CikUHLamOwOj2ygEot/D1MdCrrV34U/TMH6y/jm/geWKVZMD1R9sjlpofsrB?=
 =?us-ascii?Q?H2KvweZZ21Op0MgEHowB4um8rFWUrVpzxfni2SLKKSSutLq1dPkhjYQ9Sxym?=
 =?us-ascii?Q?cqBvYq6YK71k1WBQIAdZvipEd4kuQ8/OppKXbcC2P8uMYPC08fE8KQLP4CZx?=
 =?us-ascii?Q?z21Fy6v0lFRw5E9UhLduJGfvg0ZZKvvn/zhTUBa3Go0iEWgEgpDFjFVZkeIw?=
 =?us-ascii?Q?SaImk6PEIORIxdfL1I8wy1O1vUmcqW+3gAE+qPtrScdzhcXfFc/r/PZ4yJpy?=
 =?us-ascii?Q?pm82zcqftZ0NKtPa2gbGgR3MjRhMbmQDJUgG857rQVtHlbTeKBNllYnJuPY7?=
 =?us-ascii?Q?va0n2+R1imyNQMYUlIxHqV4NuhQO7t+BFGajKe5ud2ED0WgHs+Gzh2bA7uKH?=
 =?us-ascii?Q?vd4XPC7o6bkJ0cYtf0HESQE1nRh10mPbGWCPWnK8KsJk5b/5YQFvnvpArvrt?=
 =?us-ascii?Q?qCncTjDnQLEf7GNDg0NKpxMbOQlri0EmllhzZGxg6vlJgeNgauLxV6ysdJaJ?=
 =?us-ascii?Q?ReQiTPh/iL2HRW4NPjXHZEgD3kBNPjK9lDoKhWxSJeVO0EB1hAk5Obh7MDyk?=
 =?us-ascii?Q?vSkE+aeem5RlMz3ghg7ow+uXRVdBFqkdAfglDGft6tO+qj38E0G9pYNSbCZd?=
 =?us-ascii?Q?553OJaLO+WJrh1TG864aJUj6sgx0Sk17UA/cMoSp9f0od0Jr39LzKB5pp10J?=
 =?us-ascii?Q?XLUIfJOkhu5OeCq9Z8hmTTc+V859csxlJ1M6Zr7gubPpek2GZleuPy3gGS4R?=
 =?us-ascii?Q?mi7vY1hIA1hyOQ+cNpOnrxOnsGv+Ii7Pvhvl4Bz9Ke6vd/R83Xt2Nllpxgl2?=
 =?us-ascii?Q?2xDvQ7NeWUNKpse2p1o6ZajKH6U6TF+K1W+3idNTP84I6YTVQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDpqH34ia+Ox2+OG1GlRNGyrVF/57K3XBe3a2pEXwgdYpxEPX0KGyh9GrETy?=
 =?us-ascii?Q?jdgpqV3J9LKJCXQi33cc/ae1YSyk3SHoxU+ukxz3M17k+XGAYU4+DtW2mOkr?=
 =?us-ascii?Q?Ce6dSmmTXSZtFHI7aiNS5E2de2mjeYXLdHCkx8DNXayBekBrGPndNnvE9am+?=
 =?us-ascii?Q?6uOq1SeQCD/OQOYjUNNhxJb0kMQw130tByv7fG8mmOMZK3mjhD/PE5S97dO5?=
 =?us-ascii?Q?fAvQopBJthnT/vliEqS90BM9h2/7WiuMDz2SnGBS0uabkP0xrbf2lotHxIGX?=
 =?us-ascii?Q?I05iC0ZedCitgRgrIvw0kHAWiEyGcSQjKyU/OxwMmzotuu/Mjl8f7djlk0Nb?=
 =?us-ascii?Q?WfCaydFe4Avgj9quKci6LS++tCxo3rkPZbqATVDOgtcsjbwO5WWz5JdtmUsH?=
 =?us-ascii?Q?QGSk5N44yzYxry061LsqVk1DgERawlNkkMACqZQwOF8bklbTZeW+Su/IVvGa?=
 =?us-ascii?Q?+erOX423MBJ9jCCrqATzysFq0O4yq37sLxGCOFBJzM2Jii4jiBaORr4VN1wL?=
 =?us-ascii?Q?1xA+jEar8+R7l836HQ1P55d2qxKmWg7m+0d5OhsotmuF3LxHoFNceqFpXrKQ?=
 =?us-ascii?Q?f5pOZBtPFWEsWEulqpXEpb4VtOn/Idpt1fg3ese8X36B70V2+a8x+2N8IFwN?=
 =?us-ascii?Q?i4BH+98HlIwXqwqYkpPtBt7o533b8FPTmYgnN7odLW6FECI8WIPe2qykziCY?=
 =?us-ascii?Q?QuIYqJcZ9dplTI0wpzp2pwRuKZDR6yFf0Iy2r7IUdcdr4Sy1H2ZnpZgjF6XG?=
 =?us-ascii?Q?QBWhDfh1U+E/gLFLu0R5ETcQGaN+dccQzjn9g56m40vWeon+gSn0sgY6TW+A?=
 =?us-ascii?Q?lUGbkxadpb88FxkWTfKb5kuq9bkKg+AgMEp4lB6K0CXicmdzjI6O21kp6Cyt?=
 =?us-ascii?Q?rScKyBvnrvOU0PX7XZxFu2x52uGtZtUAsP+v7mveaIEa7tAtt380xdQ+WuuS?=
 =?us-ascii?Q?AlP3L2ea0FW7i884KvWrLjrVN9Z3ffCdbtpzS4tqPJSiajWIHC6XV5bhXBk4?=
 =?us-ascii?Q?IJdUY7rDpXTN3ns9rZKA1usMSUyDJnTMSWA3EjEmzEX5qRaV1ESkugTGDWe2?=
 =?us-ascii?Q?cqNa03Ydu3uxI2darHeGIypP4q99tGsJ23lqfyMYmF18YM9fEJQ1pP6BNOYL?=
 =?us-ascii?Q?dSiv01HO5BFO+NiCSrkL32HfHSEYoYv7Mb4Bo95A82gfMYeY0YrUr0h1BMUz?=
 =?us-ascii?Q?X65euB27AajFSW8xnD8t2ZbzDhRBgRe7v2rabpS+eOuydqVDGY54SOyAZ7bg?=
 =?us-ascii?Q?pEKW65SRg4JDLu02Nuuh2a/JEdNW+sMc4Gwg1CinYeWBq3J/3tqGft0YyCX8?=
 =?us-ascii?Q?CpNPtos+P4+P6HEuvd/KP2VaRq2CtUsi1kPjc4gRwFdf+o003vXcuWHzLLy7?=
 =?us-ascii?Q?2xOq9QiUP/zi6jgcaniqZ6psjNZssk5DWWYW22dhpstH13+7SNtkVB0Mam5v?=
 =?us-ascii?Q?7wi3UKL8ujU25nkyzg5anlmc5c5VLoqYa+oDvtWtlnynrDUAdQdQF9YtPpXN?=
 =?us-ascii?Q?RvEvVUeXJpB2MRh4sQmsxoRKMV7QcH5Qkyq4E+tKqfd3jYvxVvzml13yKshr?=
 =?us-ascii?Q?amcB62Jc+LI5h+EKybnabTAxvZyJSkIWIpFH5hH9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30b84dd-c04c-4236-7edb-08dcc8e02852
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:40:25.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzEeL2lPVx7KpGUs8o4eMs7jEBG42Jg8GthhKi4SnEa+ghbzSWETDeu7FtPC9BB6NCfqBfgG04VMSqFsFqyqGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6667

dev_err_probe() is used to log an error message during the probe process 
of a device. 

It can simplify the error path and unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 9674e5ffcfa2..270982740fde 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -338,11 +338,9 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	thermal = devm_thermal_of_zone_register(&pdev->dev, 0, priv,
 						of_ops);
-	if (IS_ERR(thermal)) {
-		ret = PTR_ERR(thermal);
-		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(thermal))
+		return dev_err_probe(&pdev->dev, PTR_ERR(thermal),
+					"could not register sensor\n");
 
 	priv->thermal = thermal;
 
@@ -352,10 +350,9 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 						brcmstb_tmon_irq_thread,
 						IRQF_ONESHOT,
 						DRV_NAME, priv);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+						"could not request IRQ\n");
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.34.1


