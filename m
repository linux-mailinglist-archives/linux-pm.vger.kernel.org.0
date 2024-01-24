Return-Path: <linux-pm+bounces-2631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36603839E69
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 02:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7691C232EA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46115A8;
	Wed, 24 Jan 2024 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ICANL9ix"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB531396;
	Wed, 24 Jan 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061066; cv=fail; b=Ol0IdYULLSijNuBCV8PZ5+5NEJPoqQLm+WRxhEImgM3vWAHcKnARqZ41T4lRqy0qWSvdB2j/86LBCs6I7ILqNoNVyeNczmBdX6It4jlmACGxOLdGvt3WxYpEXLO9drQRXRAcvZOAcQOV2E7hbdjwAbGfWVzLjT1ipXsGpd//CqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061066; c=relaxed/simple;
	bh=vVbRCbaKVDTe2a6Xp5NVKoZ934RPgsPFVGqJ2bfX0Bs=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:Date:MIME-Version; b=LqkydUekm8auI8KITxpbMisf3GypEeW5vf2VyDNKIxIheCryS10VJxyA4f1ZqZgjIGtmyZQ7GlWDAt+rmgVLuTKuOBGtRsPS2oNvY6TxtVi1Q/PiGPKPaSW72mgGk5RSvojteUE8DeF4T5jUPkbvAw5tOSFaaSzpV8r1gvO+fnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ICANL9ix; arc=fail smtp.client-ip=40.107.114.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRJp2zTD4LfHoqMmqbdOwefX7TzVhLkzn3Ec/u8sfZSPqn9cHRdDT2RgJumIQPtCiNpkKZI0rVNNH50cG220rvalAQH/Y/fW0krDLlIGQz5h/aFHUaDVkECN4ldmCRsnbEnQztOZMqXD0QWc651G/R99Q0F+QPxC8WJXe9NjH1w8rJZSLoimDidcN83Yv+J0R6GfXlgKEAN84SenkyTj8plgsWofOFVFHDO5P19x29Cn2vaHT1J1s1b1mSWSnqE6LchA85Tf6+kWRgbp2RDhpTeschG8n5PS4D9jGLgPmL1YvUFvXlsGHT/32B5DQQ8J+5zDOBnYhXDc4KAd+CKEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyil5/G1dN/+j+T5nNYUItmrfhde0hQn8N7Wj9I0mG8=;
 b=AswavklwGLtj/fEfm1IqlynZhcOyJoQQk+JKMQ6anInEjaCV+0wQulSW+i9FwJDI8iOyQTD44nwP9OIKa2GGqie8pvOyUobZ8gdFW0jIcmu562kQA195g+ZorljOCzTOhUuezqhgZxymIGk8fjmXbOuGuz8hYgr1UOyVDbrw6MhhN13t6WPaOWtWSfqR29Oq0rpjzTEzv+5JEK4t6rX0tH0715WPyXLInpGH4oxQai0Vq92esMSHifmhOlUSVdMIMBPehVNxNxBO0gAriyUZIv/EW1pJCOELqijb2w2he0KtT1DDz1un1i1ve/LJLGHrsqec+q3hRogWaw0sRTYl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyil5/G1dN/+j+T5nNYUItmrfhde0hQn8N7Wj9I0mG8=;
 b=ICANL9ix08pt7LJyuN9KkePCyPJdgPdurtqUhNobdWth4sKSiDEO5IUmHznm06sRotSIkeWJMw8ne1OiF+F3jkCYv+Q3rkd4p2rIQCX8zgqr6Ud/Jy+Dia63Fye2VvrXA5YJEBY6gM5MKtLjbNaZZ62ynLzNwt2e6hFZMjtO970=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSYPR01MB5397.jpnprd01.prod.outlook.com
 (2603:1096:604:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 01:51:00 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4%2]) with mapi id 15.20.7228.020; Wed, 24 Jan 2024
 01:51:00 +0000
Message-ID: <87sf2no5xo.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] pmdomain: renesas: sort each SoC on Kconfig
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 24 Jan 2024 01:51:00 +0000
X-ClientProxiedBy: TY2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:404:e2::34) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSYPR01MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cca725-8713-4baa-dd43-08dc1c7eea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b4CsXnip7D1lmUztwd0oneRINalJBNi6nYq/0hQZ76PIWqHMMAKkhmTPGWRqB1WFXeRhJurngrI+dDs+GQ+7M/sIs1O3SwUS8xow+4rGcIFpfBfMAVO9HOCGrGmJFNYIyC5ECIqegggwwvZ+cF81HAOQEZ2wwY14/RObVknGBscxs+VazdZ8X1S3oTg9z/Vl5I0qnt8xaKZO5B8MVkFWVuE1QfCTJbRU74z2wyHsHIUPiuIG9rQ2gN9PCLUPCX7VRqVJM5Oi2phSjeq7d0vWkbhUwt++FiRfHuc75aQcgtEzLTdeAAK/Ztw6Mj5UfT9DLQ/hRlbUfVd6fmLSTgRQKuarts+ErHQm/kLDOUO7vBSEci78AbeahwuLHmsC23GSctEzNsH1yeog/wZF9AdlXInloPZxRRH7axg9b60qbcSv2PImR0HFLmIAlD9Uy5oHiHRiR9lAGHuQk93/MqVYLc+srjgrbZ7s3zcoh473Ot3z7xVHhyFCEWs0aBY/ops/pg9RN6QyqyAMA0M+m1aiObZf7njogrGnfJAW9qUrWHKwB/3fL1IefafcrBAtUcQK9KDN+a0f9eAOMeF58ovCstRMbUuvTNy1L05d/vUEaHTQy40NumqJy2FICE5Tms3c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(110136005)(2906002)(5660300002)(316002)(66476007)(66556008)(8676002)(8936002)(4326008)(38350700005)(6486002)(38100700002)(86362001)(26005)(36756003)(478600001)(52116002)(83380400001)(41300700001)(6512007)(2616005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3EV0xyIPqG61zPVi/89RzC5YGFGr4STqgIMFCh/p/yq05SaeNDiTBc0bWLX?=
 =?us-ascii?Q?baT2kWnwpAx0z+CWdMLIqnjMWRX22vAUhNvvEWRKALQIYQXn4uBdCNgrk2WW?=
 =?us-ascii?Q?4LE2+l7tIjeO/6rvJq7TKQcQS6eKKjhpiM2D8n82gwUdtX411AJ73KUMCtIr?=
 =?us-ascii?Q?DmUbnp1kk4vjcteriAc4yZeCmT15LCu8NPL2C47bGAuiQtkclEHnC9oZx55u?=
 =?us-ascii?Q?yLvB+rd1+GQYIH2yChk8WznFgWgijMrdoUqhlY289+HqSabgzYZYYnyqFGh3?=
 =?us-ascii?Q?64rNYfCqqdozuin+H2My3QLYGbEpMFJbs4h3DUfXSLz7T0w7ANiOmiaDV8sl?=
 =?us-ascii?Q?gScVKTS5ChxLYQeCgLrEutQEAjR2fiZN3EXjLlsZkr0CWZOinfxg1AYh6HUD?=
 =?us-ascii?Q?JXYvClnsZRQWtEjw3vR6rN1FpJ3fXzhptJDaS8bFbQz12wfTN1Zx1dhgGfnW?=
 =?us-ascii?Q?2vRrUBs0VG6VAdSbvJE88zKqOZRGWU6blmR54xyF4yZ56H+Gsz+lHSevMVoY?=
 =?us-ascii?Q?h2tiwRTxnV3x5/iHflhacv70XVDMOYNySkzNOtG+mwJLTSJ9keQO46CwwFiW?=
 =?us-ascii?Q?MaNawKmj9TH2F4/SBv/+2N+/L1ibahJoR+1VAKvbzD7BWM8lICZKjp595r3b?=
 =?us-ascii?Q?28Vi3IzNJS9NNfBUqy9EaBbFA/kKg8J5FCpg65iv0cW7stW37wB4a5vtg629?=
 =?us-ascii?Q?yAhQC9/7k52U+OFapiSpuC2P8IEsXtiJ5ZK4BRmO19bh1fVaOmM3VeQcZZox?=
 =?us-ascii?Q?dW0Nu7Mw81h5aaYm2RZXeJ8QNmNYSeyTiJUe+QJKSh2a5XqbJBr66WXa9cuO?=
 =?us-ascii?Q?Iy3DzEjgevCEjZF3EAClMmhOh4+KjJMSioGilAgD7bFClylg7aKUFdiGu1G8?=
 =?us-ascii?Q?qNGmD8aBpiChtT49SSTBgOnFTGhzwdRFvRviANC6PJPrgi3ysJ7akquLqEUc?=
 =?us-ascii?Q?ZM9f6W4WKqmr46UFwGJbnuxctc7AnqSLVitunhcNiPYiia1M5Dn4AkKbjNC7?=
 =?us-ascii?Q?sqkB13M/pKF2v1xGV0Br2sBauBWOKDKfw86PhA9b+hPYPmIy6Cziw19m5se2?=
 =?us-ascii?Q?EPgmSfEb4m6VM0N6HE8DtEAOB9W4mJJg1s3R1cCQ/sFybYN0YmM3aZFoCZp9?=
 =?us-ascii?Q?kh0Z9Vfn5LStJ1+678fL22E9fM2fvHRvhJ2aHf63bpvJXHLYx6KjQZfNdnWH?=
 =?us-ascii?Q?t5/4FinEmQ5yBSNLdHeZkW5x3GX6dF4riENDnXItmI0veSW5uhTas04p7NaL?=
 =?us-ascii?Q?VVUJmZfPEF+MInsmD3SqiZHM8jKKQh+ErHgS9kTG6/W6NHZtgTHxsWpz2Xj2?=
 =?us-ascii?Q?xu0QQ2zYmMeKjJtGTVA8aG/ZfK/JhMlu2yGavew6xRDn6VMq6Th0j4m7fJox?=
 =?us-ascii?Q?UKzEYgExR9FJoSTQEclv8nqg6eTXQurvIjfnIDrM7IMxsdsOjhndSPP04+r+?=
 =?us-ascii?Q?srLLoXQQb5hQMxLofl76OJUXpFVdYgJnvA/ZADe8GawRqxzUxoWQAgl3Vo7B?=
 =?us-ascii?Q?Vy4YIbqw9NeMaQjjvBx4u7COhFXtUbIVsdlSYohz22ClU8HCHtOHsd+fDbQZ?=
 =?us-ascii?Q?lpo+GQmqTFHC7PHCvk+lZyy5XMMm5HkM0lAoqjE00Ht6ovoM6gD5J6mzErcY?=
 =?us-ascii?Q?fzIZslaOyfxaeXBdG5hXaQE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cca725-8713-4baa-dd43-08dc1c7eea3f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 01:51:00.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXmTI+40xCGtzf5ELDqkv5XRwET90+UyIYWb93id8PrGPRN30tqYQb+KIFr8bD+gpITO+JHgrOuTehQ/prtosBOJ6th3x9aIO5ySYxL3ySxohF1xT3MWUTr/q/6kpv3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5397

Renesas has many SoCs and it has generation/series/model number,
but these are listed randomly in Kconfig. This patch tidyup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pmdomain/renesas/Kconfig | 88 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index 80bf2cf8b60e..2a27d83c8063 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -4,39 +4,34 @@ if SOC_RENESAS
 config SYSC_RCAR
 	bool "System Controller support for R-Car" if COMPILE_TEST
 
-config SYSC_RCAR_GEN4
-	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
-
-config SYSC_R8A77995
-	bool "System Controller support for R-Car D3" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7794
-	bool "System Controller support for R-Car E2" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A77990
-	bool "System Controller support for R-Car E3" if COMPILE_TEST
-	select SYSC_RCAR
+config SYSC_RMOBILE
+	bool "System Controller support for R-Mobile" if COMPILE_TEST
 
+# R-Car Gen1
 config SYSC_R8A7779
 	bool "System Controller support for R-Car H1" if COMPILE_TEST
 	select SYSC_RCAR
 
+# R-Car Gen2
 config SYSC_R8A7790
 	bool "System Controller support for R-Car H2" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7795
-	bool "System Controller support for R-Car H3" if COMPILE_TEST
-	select SYSC_RCAR
-
 config SYSC_R8A7791
 	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77965
-	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+config SYSC_R8A7792
+	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7794
+	bool "System Controller support for R-Car E2" if COMPILE_TEST
+	select SYSC_RCAR
+
+# R-Car Gen3
+config SYSC_R8A7795
+	bool "System Controller support for R-Car H3" if COMPILE_TEST
 	select SYSC_RCAR
 
 config SYSC_R8A77960
@@ -47,41 +42,43 @@ config SYSC_R8A77961
 	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A779F0
-	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
+config SYSC_R8A77965
+	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+	select SYSC_RCAR
 
-config SYSC_R8A7792
-	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+config SYSC_R8A77970
+	bool "System Controller support for R-Car V3M" if COMPILE_TEST
 	select SYSC_RCAR
 
 config SYSC_R8A77980
 	bool "System Controller support for R-Car V3H" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77970
-	bool "System Controller support for R-Car V3M" if COMPILE_TEST
+config SYSC_R8A77990
+	bool "System Controller support for R-Car E3" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A77995
+	bool "System Controller support for R-Car D3" if COMPILE_TEST
 	select SYSC_RCAR
 
 config SYSC_R8A779A0
 	bool "System Controller support for R-Car V3U" if COMPILE_TEST
 	select SYSC_RCAR_GEN4
 
+# R-Car Gen4
+config SYSC_RCAR_GEN4
+	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
+
+config SYSC_R8A779F0
+	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
 config SYSC_R8A779G0
 	bool "System Controller support for R-Car V4H" if COMPILE_TEST
 	select SYSC_RCAR_GEN4
 
-config SYSC_RMOBILE
-	bool "System Controller support for R-Mobile" if COMPILE_TEST
-
-config SYSC_R8A77470
-	bool "System Controller support for RZ/G1C" if COMPILE_TEST
-	select SYSC_RCAR
-
-config SYSC_R8A7745
-	bool "System Controller support for RZ/G1E" if COMPILE_TEST
-	select SYSC_RCAR
-
+# RZ/G
 config SYSC_R8A7742
 	bool "System Controller support for RZ/G1H" if COMPILE_TEST
 	select SYSC_RCAR
@@ -90,12 +87,12 @@ config SYSC_R8A7743
 	bool "System Controller support for RZ/G1M" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774C0
-	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+config SYSC_R8A7745
+	bool "System Controller support for RZ/G1E" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774E1
-	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+config SYSC_R8A77470
+	bool "System Controller support for RZ/G1C" if COMPILE_TEST
 	select SYSC_RCAR
 
 config SYSC_R8A774A1
@@ -106,4 +103,11 @@ config SYSC_R8A774B1
 	bool "System Controller support for RZ/G2N" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A774C0
+	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A774E1
+	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+	select SYSC_RCAR
 endif
-- 
2.25.1


