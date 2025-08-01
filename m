Return-Path: <linux-pm+bounces-31738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD84B17E08
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E8F581DD2
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3820B1E8;
	Fri,  1 Aug 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rp6ojTig"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC641F4188
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035745; cv=fail; b=sZbliUzmpHB+s0B7NhKpAOq5j6lOnV9lXxPYpX0JhT70Plufew7Cn1JN10YuJVwL2cfPatr4ptRi/QmrCnByHfLZZlXozb/pxuvG5IRjO60mN3pOoHEyboLkytvjc8W+pix/GGWHUUH+HVAm4ikwEbtUqHNJ8XovhKiL1sSZyWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035745; c=relaxed/simple;
	bh=/XsIzMWyWRuE1MhsHHCkbzNZKfU7UlcRrWIPLbYK5jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZHCgFba3PFj8+G8gvv4atKXG1v6GutOSlgSY26KpNl1yARg2tB+Y4UzjhXCG+2aNNz4Dc51hRa/g2qhk4PxsQEMQ7DNnNrELkDPOUN2+Fk5CrlxkYfyrEOVg0cyVwwwkggnLJcU1bqFnuCtF8QBIG2snfLG0eFmw6avxIEgUFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rp6ojTig; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pkx1E0oxX+fw+Vwwl6z/chksfhpS2eRfeN+at7yRszys7UvNCWr69bVntS72afZ74cwjzLOKtwFWWIY/ukvL//PmxtgDxdnXBh4oHAZNkBgG6mNj7Ex6Ap1KV2xTH1BSeF4MzpwxUt4OKGtOxNXOJLS43bR72zeMatsnSZW7NxAcToCGoNtDjby5Q3QsL85Fx89Ilf6hnZftinknj9uCIPOdAKSvX36sCknOd5tjtzfQbkZyLHdDqMzYWevGPMbb35sTLu1qHeiXzEHN03agorIUMXN7LhuXoRvjjJcwvdFmUIaQJzct59W5tpyzVTGzhIpTStulnSL7nt5dZCXIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SosxWkwCp8KFWVCZow+eMjn88AiqLG95ya4k5aKdR8Y=;
 b=Nw25gPvfDP3FPYdJOxcfYfTSsMmVqzwSbIcz2k8YYIAriG8nNKX/5fD4WGNYuPXv9J0m3vwjnlWp8Bs5/kcPQqFBYA23VnbNm6rVjQKZZswQ5zTKVvn1A5H6JDqb+sQENPXmRK2azNYY814GESdAf0XzHhFGRAnvUCXYrMMG3+pfZRIH6Inv7mf2Bh+rljC4XNCkH236Ds6iXyxZr//Rpy5QLMQPe5Zotwo7tx97IoqUgX9EWPS4XmAVv0EfQFA/kzwi0+SKs7SZJ5i2NsuRUstDeiAryaGkblbX/XF2mwBpCqxYHhS8w5Mh5oE7frGCi8bX75N7wFHN+KBrUs11OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SosxWkwCp8KFWVCZow+eMjn88AiqLG95ya4k5aKdR8Y=;
 b=Rp6ojTigWa0t4DlbNuOMYI7s872XTWnQUkuB/AhQhzIR9XhHSd/VVqpzbV1MUGTQQozQT3rmHPg/ztrrSz/wVCo3ObmI9yu3w6RmZO3zvFzuMZTuMpkz7YTXJRhkfqfKLpRG523LE9QUdnptXJ1kK3RjITFa3WbYJ6nDz/pQH0PmJjgfl8eDrirDkjgIYpx81eWOFVP9CEOS2HT7c4IUZLO3jwlLN0mVzyix9d+zPXV9gXCTeKkTM6XCLigjuy2YADY/s89BqhdYNuXklbFEg3Dcs5EwW12fY2NlEyb7dgCGVPfpGPw22kQqXXKS2OpWveqJ5ZphpXutDmsFw3D64w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 08:09:01 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 08:09:01 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: krzk@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH v2 3/4] thermal: qoriq: workaround the tmu temp jump on imx93
Date: Fri,  1 Aug 2025 16:11:18 +0800
Message-Id: <20250801081119.1999298-3-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801081119.1999298-1-ping.bai@nxp.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0b9c46-b2f0-4402-e4d5-08ddd0d2ac54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqtRZJjqsjknGjId9eYyat0yoKzgyYz0I4ya6fJWmaUhdFzJ0uepsHKL2rh9?=
 =?us-ascii?Q?wBGEcmwJIble/tYReNXQD90bwezLPQFuCrwO9Uc1UIHA4in9RVYEhmO1g1+u?=
 =?us-ascii?Q?WA6PfRthMd6IY3F/kroPbGhZ2ZAFdZfPbUA0Vr1W43LPNon2kZ2yJaO/izM7?=
 =?us-ascii?Q?Xx3bNNE2QgOy5/VXtvQAlFQk/GU9rsetfhaTEFFEyZnOgBbTllBjSrIAnMMG?=
 =?us-ascii?Q?Ycx0iJ5/D4Obp78MviooxOy+6aoKfWK+AZ4iV+ioxWxOhxTTPC8euWAz6/nL?=
 =?us-ascii?Q?9RTDOdMIyEZc6WqiSmmlMYrwb+RyVV/z4b8Dcj701JujQBiYSS/y/ngvbL5m?=
 =?us-ascii?Q?eYbIqMsuJpM1Xf2YN9faC0t7zkL33zy1gorEZWwe9EtwLretU+ngkfS9D2Oe?=
 =?us-ascii?Q?gg8Kdh4lgCX8UeWqW2Uf8slRsHSqS9MeNYiY5U+yoPG20MOZ/MTJSTUk549A?=
 =?us-ascii?Q?GRNlC78MZrrFnW8QqD7YPHxDOku7UnLq0noQJ1eh0It3FPVtEZ3rA7SXVPzN?=
 =?us-ascii?Q?uWqi58VK5HomkolviODsuXNs3p0gK+UabSS30txH2XRsObj9lI63N9RrLco+?=
 =?us-ascii?Q?g7N9QSqWYWVtioC8CNExPtNpYIRQaus5jS5Olo/QnHdflEcvR/60CieF3B2H?=
 =?us-ascii?Q?b3B12QFHWfcWGUR3arS2P5chr9onwtCTXlA9+yqUYH9UeqTgjYTv8yAyOmQv?=
 =?us-ascii?Q?Oelt9Jq1F9eO84qaW3GeQj9q/SahmaUGMiYw94MUJMUk/5+TzRMDwvsYCgha?=
 =?us-ascii?Q?Lz3aVP7VUPEilx8tbF8kg3KrX56N5B82EIeSDjY4Z5oMF0FF7HluG1rFXdur?=
 =?us-ascii?Q?ygbR5oaaTzfHVwcprl0ikLm/Us2k1gcdLfdHwH6byvAhvaX1C0R7e32jsaL7?=
 =?us-ascii?Q?dMqafKPCE9dqdQCLWR5qDWgZqPCELe89yJacbsxT3tmn51C2yuFLQoL7NElw?=
 =?us-ascii?Q?3au5INByxZA0HgtU/EuKb+gq4xBBpKi+3XRwQ0Jj3JfAOPrNQHEgBlmMg4AM?=
 =?us-ascii?Q?HwG/l2zv7XnbM2WgC9+3i1SpLK5r+PAkuT97yO/gBbIXHAJ8Tcfple4hs/C0?=
 =?us-ascii?Q?AFKxEwO5QU91QDX7GON4lYvz9NAOnwcl7g5z+3BXmR9JgUDSYOqEgpR1Kkpi?=
 =?us-ascii?Q?FofBPUcdqdX/hR0NFJDrwh3BRTxkNSR6xjkaZ0YOu8PTPsXw5wlQ30ElVzDJ?=
 =?us-ascii?Q?hbKYtVtedHXgiNHu4pgLY5wsU1UlSlOeicl7VvAepFHDyXPrCpaG/XBf4FjT?=
 =?us-ascii?Q?1CvHLowpp92XJyU8p6YrrYOSkjcWFo1I3Ce7nzlPiMjobjyauspk76Feh1h5?=
 =?us-ascii?Q?WUmivZ+orCZ0xdW2d9jG86Fs9HOkPS2uOIIribyxEZZ/fV3vSjwUNWx3cBOL?=
 =?us-ascii?Q?qpe1fsahTA1y4NM9B4/rYA1+FLmE2WIQrcnPpMNc+af6bOpvdDmiu7XbAGps?=
 =?us-ascii?Q?MIaMDHHEhv3HhDyOKB1mlIjJs3uAjA4xoMc/TxiRXE0LJq8iKvXDtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qvg26jDTTWtWgyGswrkPKfUAgV5cGIrmWD1pLA5mroXXTS862VGyasa0KgY+?=
 =?us-ascii?Q?tox17jI5kKmru0OWHgtLPFxRtVrImnalKgyMQsZM3x3EvMWJYw6p2xMwrw6/?=
 =?us-ascii?Q?n8/2ntq1li3+77RlWryEKgUHH1Nh9WwFhbldce9vsVAYma+1vIu/PKcPpUTf?=
 =?us-ascii?Q?rY64pu+wkT3T3dPGyLJI8+kwZA3H4ksnHOALlat+DeKpqrkDyuLdbEHSICZF?=
 =?us-ascii?Q?aXbUceAD7GuVgUYtt1NGkuoatLxJqURSqvKk+S0wB1ksX6uGkn4Ce6PtN+wl?=
 =?us-ascii?Q?Kg728KQ6R7qtrc9XToPw1K96POS2z8cXwGpSrasW7r/uRmN5hUUwws62ybTH?=
 =?us-ascii?Q?hWl53EgZEmLjno71coZS1VpgeYuLl8bVqSDB/CQJoq+98kIeAp0ObnCVKiGP?=
 =?us-ascii?Q?bjoPzJciFq7ZKTICdaE6VcuBo8Uv0KHZPz0Bc+4e+Lk+zgblK44RNIDd4kYn?=
 =?us-ascii?Q?Oj5oYS3YLPtSf6/8S2lAqWcGp1Y2s63+VkGgys5gsNw5XtoPWHi323IfmxUn?=
 =?us-ascii?Q?bjvsd145dzkBen8v9qHUW8dbxgBssSqdkYhnupmdrQ8nYC0kcS42IER9mD9m?=
 =?us-ascii?Q?l25wfQ0/A94+vZ1iUs5fqQTEtBuBEXmYJds8XGME7gZlFubnCiiR9LXXcKky?=
 =?us-ascii?Q?M67kMt95gj/hhgB4BOdeblTQOBRjT/mA546HYa+pI3crryZQCyWeNJ9MZbIC?=
 =?us-ascii?Q?n4YEV5IuzOZKMIrlMQtOYiPQia8xs8ofD5hLoweJfmRIGeSbGQZ5E8biPHCJ?=
 =?us-ascii?Q?x4rpepOGsjGd54DdJSBzFtORI4c+Oqzw+XnPgbrGL3xzw6mcjyeJqUlemQr5?=
 =?us-ascii?Q?Lz7v+9mqrSJhcf2IYAGWoPBUdJSwXFJYDeVeRmHFngYWu9khi9MEkwkqosWW?=
 =?us-ascii?Q?NraZuzrRU6qxm8XUGDsNoZ+sns2PWIcYVqpRz7hySWsJ2R09v+HWOccD7N9S?=
 =?us-ascii?Q?KmaYNEMCjKj9I8EjmrIoYg4j7XeIgCKYkziLhurXqUfJZ8NvfloNLAb3If0j?=
 =?us-ascii?Q?pLDi66tNy2OnxICttW6QRVN3mHXmMdqGto0Q+MB2mlyWYV+qB/5SMJZ8JaMJ?=
 =?us-ascii?Q?Fo61dCqKOaLJqjE7skVx1ngMjfgvyq8GeN+NGhcxP1GranuMsuKSmkuqu34t?=
 =?us-ascii?Q?ErM7FuVi9VdRgjQTW85aF50Y+bqQeEgB+Q8p17B7Mzh+z1qr63/OagW+xNYg?=
 =?us-ascii?Q?/OP6MYR3NjuRf3qSsNrLdy3iNj7D70E10P7vp9UBXk0st4hvv4KjUdecXqBz?=
 =?us-ascii?Q?449IuL5xpcyXX1SIM3nmsLuxXwtx1eU8j1Dyi9QfWiwWdHxWw4kf8EIcFCTv?=
 =?us-ascii?Q?7eCUDdD0f7lyM5jitugNqoxrJCh+9+87zUnpKLU7sfFx3CA6sbnBVcUB4ix4?=
 =?us-ascii?Q?FSbgPcJtgGCF9iLo+bgNQEal+WU0XDQZnaHZJAmPQZabkF5ExGk7caPE58wr?=
 =?us-ascii?Q?AligiKUJqtCP6819g2HirA21beEckcnSmTmixnEXYtvv1Q+xHyHS0d3Lun6P?=
 =?us-ascii?Q?FRcAJ5X3q1Lf84UCJWoqnimju+zj2lZcPjKV82AVl59/BvHYz5WAuURX/V5V?=
 =?us-ascii?Q?c1Gk4P8Na/be6cXes8iK0iKvjwxtGQqhOZFxsEgx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0b9c46-b2f0-4402-e4d5-08ddd0d2ac54
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:09:01.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xJ8vdRKgltaOcAwQx58FhHxQl9nbpWw/sYpqWYUR4sGJn2ZwqzQxvUX8G71pWUt2BJY0T1nHyX5rLWlG8J/8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484

On i.MX93, the temp read from tmu may jump wrongly(ERR052243), and invalid
temp will be read out. To workaround such issue, we need to use the
raising/falling edge threshold to filter out the wrong temp. When reading
the temp, need to check the TIDR register to make sure no jump happens.

Please refer to NXP errata ERR052243 for more details.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index fd4d162fc188..664cd5f7d8af 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -46,6 +46,13 @@
 #define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
 
+#define REGS_TIDR	0x24
+#define TMRTRCTR	0x70
+#define TMRTRCTR_EN	BIT(31)
+#define TMRTRCTR_TEMP(x)	((x) & 0xFF)
+#define TMFTRCTR	0x74
+#define TMFTRCTR_EN	BIT(31)
+#define TMFTRCTR_TEMP(x)	((x) & 0xFF)
 
 #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
 #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
@@ -93,7 +100,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
-	u32 val;
+	u32 val, tidr;
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
@@ -118,6 +125,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!(val & TMR_ME))
 		return -EAGAIN;
 
+	/* ERR052243: If there raising or falling edge happens, try later */
+	if (qdata->ver == TMU_VER93) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & GENMASK(25, 24)) {
+			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
+			return -EAGAIN;
+		}
+	}
+
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
 				     val,
@@ -126,6 +142,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
+	/*ERR052243: If there raising or falling edge happens, try later */
+	if (qdata->ver == TMU_VER93) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & GENMASK(25, 24)) {
+			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
+			return -EAGAIN;
+		}
+	}
+
 	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
 	} else {
@@ -232,12 +257,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
 	/* Set update_interval */
-
 	if (data->ver == TMU_VER1) {
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else if (data->ver == TMU_VER93) {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
+		/* ERR052243: Set the raising & falling edge monitor */
+		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN | TMRTRCTR_TEMP(0x7));
+		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN | TMFTRCTR_TEMP(0x7));
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
-- 
2.34.1


