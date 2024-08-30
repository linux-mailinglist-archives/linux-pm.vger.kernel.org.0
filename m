Return-Path: <linux-pm+bounces-13225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC171966006
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC21C227A5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0CC1ACE1C;
	Fri, 30 Aug 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OODc2dum"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82992192D7E;
	Fri, 30 Aug 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015880; cv=fail; b=WXaUJOFtb6lNu7PZbj/hKX85/17mQPa4bhFwGMCvHNo3PTwTCFuw7ZxTBN3XMGxbRSQTKgEkCiVHCR73OJ1sdu2R0N5YY2Nl3fobeaUWMP3UpbkFNreYCzEidAzy9ZlGZ2zu44tPeciatZdTVZHKMLTpN4QP94+XUUgT3dmgAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015880; c=relaxed/simple;
	bh=TYC36C2BbH89gDM0dgaq/FkpueHnepXdv9RPowUFiaE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ebeFJ3XlCXDixWSwYFljX7tJ4qo5bOFHs29OAXGG2gPQyPZClCWpaGePFdzJf/pbUzYJehW8Xi+8oMwH6+rxFdS/61hDMTRMkJzzVNJedt1UbgYU6zvpZBfeOgs4oJH44392fx5vHAiq9oGgaXaNdhMXYY+el5JUBTGUtyBMhng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OODc2dum; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxAfsvhlUcuR7YfMuXEDq+MDy7UO1//6r8EhDiv1ZCnLrYVEF7PddkzZox5Gifx+LAkhB3dAI5m4Exas2QwHqUtv+IaNlse+7cGayYsX8XjDADK39aVLKW5ANKz4Rx8CpYJ9cYKu51w5EDqjpyZCK7/ajoH51jxSA4Z7MPZq6Zu9WFTYRWyhFFgWXysvqIj7ni0p0V4JFnBmukJbitYMt0Z/plBMCdaM57v1A09f/PH/Wtwt4sY0wl29eJ6xxhVqNKxd7NodEHWB6E6whMEOTGK8PWYPIv95Pobt0Od6FpoRZW4eziezkCcBBnA7C/gdUFIr7dHAjBctd06MXrEvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUwiPDcuYn9Hd5t30PyjpANSQ6ebHEF2FYkW3T6IzPQ=;
 b=bM+OW9vKeJjClpJ93nSkCpx9nS5ObwETconpCm0s8ptDvWJtCPwQhpd5U+at7m50G/6oN49rGTg+Bc067B3ZTiPBBBrNVnz1mCp2LttnDrij6EwSlKab4MC2Xw4EqXyyCjZF99+wWfbLuzJfZRzQQQ4fDxK6cXyItXzcUr4oGjWFULj+FumRfMoWQE1ECjxahd04vE8/cdZzLzhMti38PwoL2py7P9BIaTT3iZwbySAgGaHa8Tk0DWGmAnotRufaa61CvR4z2flHB5fNUrCO+Ts0Y8TlM0s4euV6fIHTM6twLHb+6Co/XWNSmrDgi62bmG27qWin5vP04vKfLk+w5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUwiPDcuYn9Hd5t30PyjpANSQ6ebHEF2FYkW3T6IzPQ=;
 b=OODc2dumwUj+d7b9iUofV+Ai41kxBHn28dVAZcahiqD8EB0knvRGdQC2eEezlvw/2Dq4BJgZrOZCg3oNdNTZgFDGCJltt5H+Ec8VEYbBMSOypZs/vECIod1KzbvCyhGCEmWaOp5MoESpg35wlRkCmHUnWTMDtbb0q5LmWbmi6EsuTyYxVtqHFn350Yjm8grn85EaRqHnvMEeTqwAgvdgHpmtQOcs8ZJhg9f+C7QKogdiXchBTtox8WRWkpHFxE1BXIczwsFF8dZSR68cO1PslfeAWnQLWLx0YMYwq6VfrtTSAhIHZyais5GeYgJuP9x7fMGW+v0lCAODM6q7xl4pnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB5370.apcprd06.prod.outlook.com (2603:1096:400:1f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 11:04:33 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:04:33 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: ulf.hansson@linaro.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] pmdomain: bcm: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 19:04:21 +0800
Message-Id: <20240830110421.62980-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: d42dda5f-55fd-4a0e-cc37-08dcc8e38736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhwwlfePqXyEZfcLQBaYjrks4Lh01+ZZPt60HKMb6+iQPtHBsCn+uJ7ZLBta?=
 =?us-ascii?Q?W17cgbp3hy2ocMYm/cPgIpQ8SRyxpJdck7P368uwQsDIzeZ7sZYMxvvXhDwL?=
 =?us-ascii?Q?uJrR/a/+8Ff/uUWo0y6wmFNXtfDIx5yHxMTCxGwWTN5+NsJAxeKajpyOJ4iA?=
 =?us-ascii?Q?weKKx/dnvSgJiJszGjL9PphF80MXvLzcbAKdz7kRVMVKMRoonOsFdfi/5fuZ?=
 =?us-ascii?Q?uMkOYmL73vKsgXDIjrqzkfxSpCNKIggfADmoQjwcLUZJ/XIWhtPtAMH8UU0o?=
 =?us-ascii?Q?JWTN8eGoLXWPlYqiWA+AiNcLTsOq8O0FyJV/RYKqrXfoXrmyUPjcAM2MvKPc?=
 =?us-ascii?Q?MoiYX8F961Wj9t7z2EQEEko7GhzPfJI1Gl6aRGr83SbOrRAqNVEv6I43t76W?=
 =?us-ascii?Q?UvweCubHtytocGsF7TeuGb5O3oDt+9N5ermYJ/++SZgHitwSQlR7VPosUMnl?=
 =?us-ascii?Q?7JK1roa5u6Nv7uWabu3P85UgjT3OSRkifFef1krLbwyu4YCxFYwt76Tqc7E/?=
 =?us-ascii?Q?IYLM0B6IsfffrcZ8C9H1D+D3MnqSkb27blgRW88toP9quC3AreMo2+ytO5f4?=
 =?us-ascii?Q?qIZLejt+fGEFM09DXMRQTYs/pEqljsVfMkU6aNceHeU19tCZ9Uh+J8WmWez4?=
 =?us-ascii?Q?umtof67+kNTCAESBD0eo3LxQinykVxDjOwop9q24mBu0/+6yXAuNLw6puM3x?=
 =?us-ascii?Q?JA3jdrKmTvP+svxQyeIbdDEmmukya1UVI2bX7RDSRggUBg+2yPwp3Iv5oz1x?=
 =?us-ascii?Q?CMUfcW7kBB8XR/oU8M9S+BKc1YApTLvz0NNY/pB/6Y5M/AzAyx3plAhuWi5a?=
 =?us-ascii?Q?SPRkPZBZK4DBpomtOx46wS2SmysvIaEr2foPgqgCDoGCmwQIcW2R3STfALHh?=
 =?us-ascii?Q?xQoZfHgDPSq/BCxKAGaJBOC53vH/DvpOu35nqAeRjP0j/2UO1x0+8sLrIFx9?=
 =?us-ascii?Q?fvTjH2xxhlyFOP+Q2UbmfiFVYrzefayeu6+u0muLmC1DODtiK8P9+lECA3Z5?=
 =?us-ascii?Q?cqjJbST1f8MOVm6Ji56JFje0E19Hp64dWMLv2Twmc8kfLyN97OJfn2FMLya9?=
 =?us-ascii?Q?xyYuXRS29cjAFw2rRB7CfqZDM+UZIqyslkEUtDHVoxyMo4PS93YvH3pxwwwM?=
 =?us-ascii?Q?yXjj2Ai2Zk5PG8o/Q7kPlTZhUN3X43zpLHMuX9oRRVlRJkmB6Zxlt3CvzA3J?=
 =?us-ascii?Q?BFx2aVCeXBrL6jp+qWOgnNw8KfXp5RTR7/haMPgVvfVxX5Htgg/jovr6q3kh?=
 =?us-ascii?Q?1w6WB9YLLsDjaVRHTSEppCcqlOM3FyMa3HrWQ3v4tW4C2xqn+mU8tU3JkV2o?=
 =?us-ascii?Q?R7lo1RZMW0Rgk9eOV/s+YljAkHpxpjtiH5BFE0Gr/Qi66QjPukjwus/RKRWF?=
 =?us-ascii?Q?ay26b9kkXcSvlGpTMi1G/HPxwWhZiBpMJWfTYWSoCGQ9hrl++Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7f/Htm7IaPkXUI0e3+Sh3Oi6ocFz/DwWNHRKtCCKhsb46OClpnGkpP5u7+Y?=
 =?us-ascii?Q?AXTIxlxyK0xJvEJWdgrScACv3e1a826B7Ezn9bHKUwWBeR43apZ66WBqNCVf?=
 =?us-ascii?Q?brM+F6SbYJYrtmgdMI8ph3e1BpGuU4QWvm/N1EmcO0dlTFhXo6fZR5DS7dXH?=
 =?us-ascii?Q?gSeMYABQN7u+HC5Q6IwmzrFkf3CZXSB5co6sy+Q+VXbV4Zv8/FIR5JQSLsHQ?=
 =?us-ascii?Q?KFyoxsTdmIhwPzGcmabRwR3CVVFOJggOgBACfnYvRR1A+eLsCpVS4FidrRvV?=
 =?us-ascii?Q?71VxgH4EACA5A65i+ANm8jV1i8VclslZWKEGVrD1Zt/U6cH04XCL4gk0mETF?=
 =?us-ascii?Q?zc8R67OYv8C/Gy4hF5qPZvX5jCN6VnrfPzadxRz3LLkdS2S6tjhboZRNJQih?=
 =?us-ascii?Q?4v5YCwZm8VyI6yt+CN2AQmpfDv/7KP8oS53wa/JVSYlAtLimJgF0qB5+YMGH?=
 =?us-ascii?Q?82wATRwb8jPaP155D1dGFadoto4fapa19AxMC8vEHvau72od6vVnJXLFFRw3?=
 =?us-ascii?Q?lmH/3o5KW3ek4uMGqVfGMJ7RsTS9EbVOuVa62gXyAdwIpRXfbpMQ7UPOewm4?=
 =?us-ascii?Q?YSFEGpN4bcVWuyu0iW8Yp/gET36EOtuG/w/5wGWnCmuxPjUymjYLjFzPlgUH?=
 =?us-ascii?Q?RPmnD6vD+PTEeboCeMKDu3W6GXLc+87w26KHqN2BV8xrV3I/ReJX2if5nNsX?=
 =?us-ascii?Q?pchjCRwBbpsbL0IjeK5MCg2Tir5qDanL3s0Plo0DTM4DFoc0DfzAHbKqpG87?=
 =?us-ascii?Q?DoOej7CYcRPFyKV5LZpwRYwM+YkoDjRe8n3HQcgzxHjmDz4wFUZMEcl7KO+J?=
 =?us-ascii?Q?vCbqFPugnadQXAxdwR719bh80ziij0G1WPDY+zGd2XOitASEX7ZlbkM+XM5K?=
 =?us-ascii?Q?rcVMD8zEc9oFPAJQBt/diER/CyB6/uEAGa4+R/4lOKWnO9W1A4KR3K45mLlY?=
 =?us-ascii?Q?0xmgJAtaogmqnpQi7m0vL9TYGuhioVf7JMs4YpP2cQA5Mbf52cJbMf1FLo+F?=
 =?us-ascii?Q?OCMEggDU41fuMVbrPUT4zXhQbTDFC3k/39iy3/8jA0gYFrMMkN3kk6WEAhra?=
 =?us-ascii?Q?MPu6sra7Qlhj9hSkLS0q9MXTnoOT/EUEp+CcefkzqI0xw7epubQA9fss/c2c?=
 =?us-ascii?Q?BfDiE5mNta32pAJH2uMUvmqZsREGi4aHrIM2+zhHkKkFzoo7B6r/AbWJW0Dc?=
 =?us-ascii?Q?6UF2adQ0zD5bSL493FXp2zS75Ax9H2/lF8lUmJuP5XTXWM2Bm0olM4Vs/Jex?=
 =?us-ascii?Q?/2SEu2UBGlVF3lmfbWK5ZQmAFPMJpt7GpZAhg6NlQm0l/xhOGnj/TTWxHoHq?=
 =?us-ascii?Q?HTQn2Vkg/Sd/CQUvA4NxBBZexcImNPoUzFyCBsashANRyTxuJNJQMc8na9tG?=
 =?us-ascii?Q?cMTDx4gOHVF4XeXA/l/Xqx45SQZ5QXtZcNxQyyQ586kpJ4emSfYUn9om8WyQ?=
 =?us-ascii?Q?MJwB0hnkiq/rbCQYjESf+Gmav3SzAHPkWox1genGlXgsKs25FCnZ+r3l/hi4?=
 =?us-ascii?Q?xt5ByV9f6znlHH5gsc+KxSeNCNqNFzUCkYhiX6kR/mwHfcssaZJHzURA/NdC?=
 =?us-ascii?Q?bn+RfgbU3zXdrMpMdsWmSFp/s/ngpm3YtSqZK3/Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42dda5f-55fd-4a0e-cc37-08dcc8e38736
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:04:33.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z17fTLejugunkdinGB4B06EyWhRNUcsIWubtbscC0Tkd2MCi4/zVoku682YaQo9mv8uTSDFL6u1w69ecIkks+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5370

Use dev_err_probe() to simplify the error path and unify a message
template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/pmdomain/bcm/bcm2835-power.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index d2f0233cb620..be07ab8a663c 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -643,18 +643,16 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 	power->rpivid_asb = pm->rpivid_asb;
 
 	id = readl(power->asb + ASB_AXI_BRDG_ID);
-	if (id != BCM2835_BRDG_ID /* "BRDG" */) {
-		dev_err(dev, "ASB register ID returned 0x%08x\n", id);
-		return -ENODEV;
-	}
+	if (id != BCM2835_BRDG_ID /* "BRDG" */)
+		return dev_err_probe(dev, -ENODEV,
+				     "ASB register ID returned 0x%08x\n", id);
 
 	if (power->rpivid_asb) {
 		id = readl(power->rpivid_asb + ASB_AXI_BRDG_ID);
-		if (id != BCM2835_BRDG_ID /* "BRDG" */) {
-			dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n",
-				     id);
-			return -ENODEV;
-		}
+		if (id != BCM2835_BRDG_ID /* "BRDG" */)
+			return dev_err_probe(dev, -ENODEV,
+					     "RPiVid ASB register ID returned 0x%08x\n",
+					     id);
 	}
 
 	power->pd_xlate.domains = devm_kcalloc(dev,
-- 
2.17.1


