Return-Path: <linux-pm+bounces-13235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833F9660D5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B77B28D40
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72703199952;
	Fri, 30 Aug 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OC9qmQcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010025.outbound.protection.outlook.com [52.101.128.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF0190674;
	Fri, 30 Aug 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017543; cv=fail; b=qUvJnkxxBw2XeKJ4XwLaaFNswxoDvbbn62EXFPRsrXW7BT6jyUXKNS8fgAkAEvuADDKi0VAolTo23e1gmsXg3WoT4Xq+Q5ot2l27xKAXh/cUrXsXOoGaSatu1MsQ6u9Vxyu3sdii964RwHCs88YEF5ZZS7fraN1+HT7yeoC3j60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017543; c=relaxed/simple;
	bh=YY/7p07WAqQYLl+iSCRb9xNaYpUGyeotbX6wrrwxGq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bvcHijIirviyJiTGuKhs7Y3AwvZnMXELJV0G5+h/HcyghgSKNTavYoPt7BHD72vjC2kaYzcZR+qlUds4xYzIwKhjbKg0y3GJD9FE4Hk/o1TxTwfSVzHQ/O9CYWMaGIt/280w7qc1VhEHFt9CT1OVXDvdVg5zjhDJi52SGkyQj7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OC9qmQcY; arc=fail smtp.client-ip=52.101.128.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhGG6gvsMfrQd/rVutrfZMVOqA6BN27b7Avcthqk0cQH7DlfLKTcGOyLQUoH1NYbVEXLEqw6GK1dvcN+kF7ZlhkOlEV+gWcl0dlw9IVUxWbdYXqq/B/yC4dSaWVSyRDOjGQX5KwhAsSGyHxw+k1GPTPpEeVO4CkwNBWouWoMRHZJj/kFyUTzgK3Mjku/3QUfF7B9RIcvc1Yp3IndLuIDx+326XuG0FI4j6g/4snnmyHw/3bQcRebd5PzEdAUIb+0h7A2WgM93qXjhSHDcIhziJxztsGOGbrKRr6rn1rhNnLvZVC/CUxBOsqQNCn3PLhN58eZLVCfsRJF3peWabAFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2e+SuiI6h0Th0qla/mHy5UBnNorF/vGEgAUNLSLprs=;
 b=FL+Qlk5Kq3nmSxCOlJQI7HJ6eahUA5hxPV7a0w+mo0pl93q/53i2JzMA1di7P/MBn+VKnAG6ufnSoN8fXJeuHERyqFcBCrKIDoaP6/16ZYfpopICT1xpOOpvlDSGXCHgM8cv8mu+45Ey8qyx9q34LV10V7PxgiRu9zVhtEX1RUDKiCmYPPnTO0apATOyu1WUb7siYxNwaYUPZYQccbTTEOx7TohCiG+g4IKgb4pO5BxkbUb6gyqf9f3J5MivtUf0sokHXl8mcH9gZfxTTX83I3ec3RdHO3BKXqNItXABBGDR72BmjssVWXbT1VuxY042oScR22/9AsUYBZ2HpIMRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2e+SuiI6h0Th0qla/mHy5UBnNorF/vGEgAUNLSLprs=;
 b=OC9qmQcYDH105D8/YoMb6Bpc7V2uv9al7nEXZhggdwiojyrGxWfBpoyfqUMRCVhQr9R7617f9zrnojqrGOx8aJ96THaRiP0Kxl0EV+YTm7QqoZobQN+ljC+RXgivICirsQ0lQ8U6QhBzRcRNqzKl6RtUEhf+gMdErBX2yvZePkZmT8mXjhxACgAk46rZd7UtNciz33vmNhjXldvS/p4834KO56CW7/igDMEQRTEVNf4EsHgPAPwSa6wkKDLXEa+1GyEo5CVxVJxZFRriMmXZRkIJ9vX16wAmHBtXw49izveU70YSnJc+Ra+OmxJbhGkbDfUz72+AzaTHVnPNmJw+uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SI6PR06MB7220.apcprd06.prod.outlook.com (2603:1096:4:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:32:18 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:32:18 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: rafal@milecki.pl,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] pmdomain: bcm: Convert to use dev_err_probe()
Date: Fri, 30 Aug 2024 19:32:06 +0800
Message-Id: <20240830113206.5427-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SI6PR06MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 851bb199-aa2c-42ce-3dfb-08dcc8e76779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5bgdgAeCSAj31vPpI0nbZs4ws95DBq0DF8Cw0Mm5mAfvtj4IdnVWxJZe2gXT?=
 =?us-ascii?Q?/I+bH9BOuPSBsgZxIt2kdJidlCjBhcb5a/m/ng7QipugQ2Xr/6Cl/9G4ymil?=
 =?us-ascii?Q?P8MKSioKbUPl+fgfePIzFzj7CMVEUnXeBXrnAYxbqzHjzGjMWSayICZNcPag?=
 =?us-ascii?Q?mp16MMoQ/h8TAeV+7HtiS7Abn3uxleQespQ8TFIgA0o0FoRm12Q6miw6EjvZ?=
 =?us-ascii?Q?VE+AtrQNzr0AXiV5GF6fV8abuTaWjwUu2JYOwnHnKXn2Gn5uJgtyad9fC0vG?=
 =?us-ascii?Q?zmZn+BkZUTBJhTxANGW32SN6LODaW5dQgk7A1SYL2zun2/1htI7TVXyGB2yN?=
 =?us-ascii?Q?Fp4HkpgqPw0RxYF+ivUUzdGABQ0AjAAji8/t3zi/BxTIyHsAlPbxLlIWQIRh?=
 =?us-ascii?Q?/S/Wqakr+t5enhOGkNykIDqsDGk6tYa+HZaCvh0DwRx4ISdpjvOYjfdzN7K1?=
 =?us-ascii?Q?FFK2sTGs0/sBM4HssTZjOmbRh6bIQlqn8KZHZ2dZA5w+mKPESxSK/0/S/5gu?=
 =?us-ascii?Q?YSghv6MMlzYIAdy1Y7ABrjvJev9DyOSsCofUmRObVcrmk0wXwW5hqsA8FeW/?=
 =?us-ascii?Q?mGak2zN7cCfCr18ZiNnH35iouFrstJqo8qKK9lltdtby/al4nElOA6vavx2O?=
 =?us-ascii?Q?0sAqAwt8Wj7NvU75HeXAaIwxixpq+qgZlEHHe1pIjY+/2GHDH1o88iJCtxJ1?=
 =?us-ascii?Q?pULT2MALQur+ocBpWAAyCQbUTu1EpJ7O7aojtD9gJbU08iwGB5aTtgmRrVHp?=
 =?us-ascii?Q?HgR06aN53ip5nxFo2sXdPQsrrrcVXDz2etVMYuPL7u87KnRKh+7f+l4FtcN5?=
 =?us-ascii?Q?v83xR/XBdPYAvGfiF8LY9fnjA0BQZ5Hm+oblBh/YIjTYUw28J27vDfBXMVZi?=
 =?us-ascii?Q?dLaJZCFvv7QJ9TCZy1k331K9WhLv7/3VTpT7K9T6+gdeR9CieWaEUZ1vFb5M?=
 =?us-ascii?Q?6oPiO3A1J9Yg2fUFkTLSrOF4JQ4SySgs+dGGHCm3bnme+mu0eB6xAfzyMScV?=
 =?us-ascii?Q?xLhcIHH/JW4OCqzCLuNPwr8KxScABQsZTtY47q5cgrYiHP6hv6b8LFdPAhob?=
 =?us-ascii?Q?BmAJtOWK/4c5TEYsxEChbS3czAH5NjE2MsdEDGD1khYvRK1/Rb2BPis3jlVv?=
 =?us-ascii?Q?VWL0oW7I015vw4384lhVAUVGLrz2DCPYhi8P8Ig4ies/E0WL8T3OeB31Q3/M?=
 =?us-ascii?Q?jFgV+uhEmwlmmKsrOn+A0YxAIua7f3cWO7S9l1ryltaewTMPI8/sECSWw3UT?=
 =?us-ascii?Q?0Bz0CzUpiYFAWY8NzNiTxqCV/Awv3LBiFiSC5ZuU/CXZtQG0k7T6MbIrp3A0?=
 =?us-ascii?Q?wq96Ry1Q/MboiBsR3yTax58+BOBhvM6TQ6lD+ZnlQKQTm7nLu7SxH5Uxn7lT?=
 =?us-ascii?Q?MiSSXaLga3s/VrqO6/EVfWPJs5OaJhVFNWEduBD+IHMZrXljdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cX24wrbKWuQNKNIGPL9RbE9Sr+5LQ015Wb5B7AFCTQz58bDFSv9AuCLDw5W5?=
 =?us-ascii?Q?lf/Sm0xq+djNrL0IDvI+rcRxALqK2i/9Bo/FLQOjxwJ0BtYR/TAuK1Ceui4E?=
 =?us-ascii?Q?uW+gQnkk1OqieOolmORCuqL7lQkoj3ugylLPhVA73ezYiBIsrl3XjKcB59vD?=
 =?us-ascii?Q?ZenFATM9mky4gLNUhylzvNdOdKcq3jSFk+t0srfRiTBkYAFFMPR9p6cRl8vA?=
 =?us-ascii?Q?GK2ElgoAxtCUJhbXUr5JMZPqrX8isM+cLwuOUr9CQmXwLnoNpcSoSTG2nAkf?=
 =?us-ascii?Q?0eMQ3jmK0WAB5nvkMxh3dryI4doPmE+mEjTSOOg2vFjZ0aIJAF3acd56/lj5?=
 =?us-ascii?Q?uXOWjFTmqD3JTsWQJj78KtXn5BdZHEvpOoOlKDFHm07PuP4WC2HdVAkgMntO?=
 =?us-ascii?Q?LF8F5MU42MeGT35HmTcbTS2twOyJSd+paKkaU1e0JZiWlfrDmyDbj9o9q6XB?=
 =?us-ascii?Q?Qsw9qVKpl5t0Vpev6pf3o8fN2Bc+/pUD2SFhqRY+c2Pq0iZ0aL+s3oC/tMT4?=
 =?us-ascii?Q?Vg6e6FEdBAEmdHMRwDg+Kyar7srJOaN7Pq8kmxXXtU8sbrAfQHpFqjLvrVMx?=
 =?us-ascii?Q?XXSPg+55y6dlgNtpNtiVMN/2CN6PbowbNgItS7ro2h7jTlJpF/8YGb5fEcM5?=
 =?us-ascii?Q?dV4a3N7dpUFWy7qC135JEmZiuD5JktGP2Ndl9PBKiScpi+hz5ca8nCeBKOj+?=
 =?us-ascii?Q?aUwSbHK/hepOSN680bJGo8+GUS+O6GS4Uaxp4IrYegRcefj+ScwXKgS8JzSk?=
 =?us-ascii?Q?ATnNo6FjbvM3ZlJSoBS53IKzhsti5L4pbD8BVDzTnitVuOhSxjeI3xSOraZU?=
 =?us-ascii?Q?LTLtXPb9XQlvoyPtL6VkrgfBnyC9cN8RO5bea9guXippjdLEPq6bGz83AM5S?=
 =?us-ascii?Q?I4mjbxVWKemAhVjCm3k7f3kxZr5l6DGptU27g4xKMTjTVJXcR3e4IhQo/Dos?=
 =?us-ascii?Q?Lo464IAvWoRoVnKsqHAyHZSE2K8IrM9XGjw+HEfWAWRcjRwt5nYJLCrVFcRC?=
 =?us-ascii?Q?iq++jmf0Nl81LL+GxizXrYodKRm1QN77OQvF/nOIOOgGbR4JYBE6fhPNiptZ?=
 =?us-ascii?Q?lQHYXKmlfUTxT7h/PjZbvT96MVeRa691p826NXUIw5k4kUNyMBybwt+X5xLJ?=
 =?us-ascii?Q?StGiRJ09nnI54oTjPfXI9awmLrgTdoE+EFu+6KHGu8S20jKlkfN2p8Brc1M6?=
 =?us-ascii?Q?hGJgl3FykHW8zF4SNtu/0x+0lN7eVdH82LnNEdNWpDq25IDYQ3u1jQdhUBR2?=
 =?us-ascii?Q?ld3x1mFG88pyN9PipvzOLaWRQ4iWfNMd18SlbCqyxLig+MPGu7cXllzyyyCi?=
 =?us-ascii?Q?KFMdU9K6N99OCRRY4fEirZx12C/LrNjfdeLKkGgTMu+TXUt3Nnz4mBKx5wal?=
 =?us-ascii?Q?tdSEnRg5gVWgyNyZm2+7hHQjkDWQWhVt40cIIs5tASb3RtxXhPG0wt+u2ZUE?=
 =?us-ascii?Q?DI9r48YH+ifkxlMB+i+3CXDs3rAuAak/McAnGaeovAz/Srm6WIVbpQBeKiSX?=
 =?us-ascii?Q?OZmwqA4nExw9MPc+hXOKxSRdY+zikAx7HOK20bqgGkdr2qq+/1a2voHBLuzn?=
 =?us-ascii?Q?rbuHqigNz8yvTQl2I55TvmJ5/CXZgQ9Pr5DQhwQ0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851bb199-aa2c-42ce-3dfb-08dcc8e76779
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:32:18.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wiuz17iBSbUn//Rh0AODiSMCMeCeI41K7N3r23AcKvF0u+VPkPuQQPUerxPSyG5azvvPOezTOIfDYun06MlsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7220

Use dev_err_probe() to simplify the error path and unify a message
template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/pmdomain/bcm/bcm-pmb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm-pmb.c b/drivers/pmdomain/bcm/bcm-pmb.c
index a72ba26ecf9d..ffd08f13d9ef 100644
--- a/drivers/pmdomain/bcm/bcm-pmb.c
+++ b/drivers/pmdomain/bcm/bcm-pmb.c
@@ -325,10 +325,8 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 	}
 
 	err = of_genpd_add_provider_onecell(dev->of_node, &pmb->genpd_onecell_data);
-	if (err) {
-		dev_err(dev, "failed to add genpd provider: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "failed to add genpd provider\n");
 
 	return 0;
 }
-- 
2.17.1


