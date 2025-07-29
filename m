Return-Path: <linux-pm+bounces-31526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86AEB14656
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FF51896747
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 02:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2E214228;
	Tue, 29 Jul 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="anlSsXuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DE212FAA;
	Tue, 29 Jul 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756678; cv=fail; b=pi3OJZCbrsAWPI6GP6qb8PejUjBKn7WIXYFAOmEWkr9iQHJiWm2ke2CHiV+DFJSV9XGr16Or/zI1tC4Bw+ZwnCHAHfZdNVqHyyGbqHtUBMY3M5EXfW+iZ62UUOTqZTxnX3RBTUDBi+5W2PYOVplCdXUesrGzH1ftz0DW9b6TEjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756678; c=relaxed/simple;
	bh=LBSTeesFJCyq8IlIrQvcnspHbWo5ioztkvd0bR7C2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nE5AhTYDfN9P71CdRMRWE5cYIa3U7R1H+udbLznB7d0yXRiv+hg39j0A8taY8FClcHLkBpCY5bqRxKiE2p5OcR4mgHs/IbW9X/oBkoBuLLpJl6+x0ZD9S344uVKQXoBHWVVT34qpuhSAtG+Yp4mFZm4kOGv2WJTX7kgL2G1o8S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=anlSsXuM; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpQfeN9JPhUilUCnNHIhhAvhm+lnG5GMxw6mPEndW7Pj3ICCQYvZtjKd0Ya7Zb/2A/sJHYrxR6BP089hhFdTDwhGp69WsnyJIwF0TOnAQuKaSt0ValNCY8amPUpszHWuBUePD8mT4qHLBF0sycQ1AAeG5hRUuirouaICttJPJtGr9iSKBW9hQecCHUlF8JWVpp3PzadbuT6OAZN4WUqBAnLS30uSGUzv1tZx4NFPp1b9UU7RWoaaRsIaIW+WRKZLDnewxkWHgcsWuEPUeGRRJXVVHsAfpXRIlAoXsrVLSr9kfZz8otLAuPN2CnlEOkvn2wIVu+3TbsF/xQXxN5DEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnfuPZCEfQ50t0G5A8VewS60N9gbCm4rEai1qeWghU0=;
 b=K9OVz7Z5Hf/XLwtKK1EAnxCJ2tEN85DTr8lc758PEcYkY5NST3uTzGA+n4lj9LBYxVczhY452KVIGkb/MK/YKneqgDwgjGHkxpbfJj+nUR8QEenk7U+uXGG0uYfIocmBO+PcBCnTLIFityjqPZMHQwZKnl7Qpa+LpN4O9Z60b/XH8py1TZRvBjsjwn2B2HEMbrYFHwH9y7a1kr4JLxlDrxKVr25sdtj4h49sccIl/Xki0qtJV3kye7vZCeY4EFqwGlGCyNJS+BntDsozXZVxsuHMtKlCppGrSNPnzD8X877++m6Nh8+uYwWN1Gwex03tDuuUgX3ToCTm6zcr8ihh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnfuPZCEfQ50t0G5A8VewS60N9gbCm4rEai1qeWghU0=;
 b=anlSsXuMWtIdzR5CW65Tb2No9Aa360oeYZKb3DDcaacp6/DkThz/UTrAnj8TpigSwRmte64JBdyqwZSd6BFgpRFUBhMFasy5avzJdnNy7vV9UKwmAy5HfowNogKuUAKBjiqerd6wNv6j//4AFXWly6OD+yZhR9ZKeJlvxyHQkLqK7MGD1bGWIYCOwgBtsF4YJb8dUNwpREg/6eR2FGnWEavX9D0mRWkX736F5TZfCfIjREPRb5tP9zLIoYt6vuAMDqM0nSEHo8Gh99NrTPKazAM6ImadiTx5rPxXKqbk7udxNhIEc0L6/Euq/uixAVp1VfxQrc913jArYX3XBA6gpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB10732.eurprd04.prod.outlook.com (2603:10a6:150:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 02:37:53 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 02:37:53 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
Date: Tue, 29 Jul 2025 10:40:37 +0800
Message-Id: <20250729024039.1223771-2-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250729024039.1223771-1-ping.bai@nxp.com>
References: <20250729024039.1223771-1-ping.bai@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe85c87-4fa6-4e93-bc5c-08ddce48eb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJdPRMhXqJ6hRVr4IzkVUoz1fH3gfJKFmEYGc259AHmTL2v39MBQ+kXytwrO?=
 =?us-ascii?Q?O4uAgoAKXR/P4kgYbbGHRf2POt/2rRth6kWdLKqQjaHtgoK5MapOcD7fAM0/?=
 =?us-ascii?Q?tZZyVMwcPd/8RE0nY4Dby29wneUsqQ3PiZ4pn1WcCjpCcym9t4uz5JeW/iUf?=
 =?us-ascii?Q?Wa3CoEOiamdDWMW3i16wxvA//Psp+W8W1W5RYzIQcxAYjMEsduDnKE0wOexN?=
 =?us-ascii?Q?GTXn+zxlaB8OZ0dBwKmzGKk4I3SNiqXid8TEx5ODg9WUutlIO99wlm4fhxox?=
 =?us-ascii?Q?naGQ9Gq1skFb8+43wg6eXHUd+7ZdJ8/HMFJboYd5MgZHBSN8Ei5iPBtSDPa5?=
 =?us-ascii?Q?Y1llBPyNW+jDW+K/usADMgdZeemK/PaEm3RRcFNMa5nWtksehf/RlweNit0P?=
 =?us-ascii?Q?l6bDMcek1WIzzLIiqIjugjM8AlrlPBcG9n9KlPK02q9/m0rHrosWPPohRJ7K?=
 =?us-ascii?Q?p0ZCuhWA9vsTIwie89jjA3dBNdbCo42Zuxk6SSUIefx5DKZwebbnehISpFRF?=
 =?us-ascii?Q?zihU3kxBJieLzk5+katxkaNzesxFiJmFD9B7LOlm1hdr1BbKRvimijQQvCUc?=
 =?us-ascii?Q?PbgtXnOQPx9Hj/7TnmKFR0OI6Wt5VPo52CHQkqCE/4DDLpFNDi19sJaULH0S?=
 =?us-ascii?Q?8ZlcJkASMHG0ZrZnrJi+TKTZrALYyr9gqJglh8iEQEMnWwqn03ephtSdVXWl?=
 =?us-ascii?Q?RgaQ8m7uZT+4S1sCAQ3ZLglujM1UrsG51rdpQUkhxIdkulLv1/seY6xbAhXx?=
 =?us-ascii?Q?Oauce6Iq5KW1jGXiAMK+a3zTaRdGSIPFk+zEqrkRGhsHi1NAZlnPYPQFP0xt?=
 =?us-ascii?Q?WdgxoTrnE2U+zteDkIdyFsSdm06FG3bklwFa2BMWq9I3v+a7wYEGCoJ5u0Rw?=
 =?us-ascii?Q?ui0AEmIF1Ssj6BFN/u19bGuoS5s1Mxp4EpMNwWdBFhLGoCmkq3xxqxFgW85I?=
 =?us-ascii?Q?K8y6iOYLpxtbMidc0Svzx3ZhS6ujwHl38I2tRTzvlWzJuHffZpcfgkX9GVs5?=
 =?us-ascii?Q?LAr9057Wt+g/4q2sIn34EUgaOlkOo9LtLIliioG26ttcL2A58W4ixeNNN1LR?=
 =?us-ascii?Q?i/fHSI5JUfJY8fkxHZgOs16wSoDfaUMECCJCkNmIor9Nfjt9XETwffhTHMF5?=
 =?us-ascii?Q?SF9ltTdai3KMgobomO0bZr2AISxekgm5FIdHkyTHEivdG4LgBSIP6mfuYTQs?=
 =?us-ascii?Q?24nQMwSH2yGPiLfnnqlr/QeigFswVz1iyGtOPwf8obZ8y9F+o0YpNK5FJah8?=
 =?us-ascii?Q?h3HeMn3T2rov7gMW4U9GhqthUrB1lVgJAf52zIgx0Qhx8xu4vU7xYMXjPTq6?=
 =?us-ascii?Q?wvqrvYmkxnwOCfyubAVYDAhCRK7I2e+9JMdHZJdJpStEGovkhL5b+Lt5rhIF?=
 =?us-ascii?Q?X8lEYiWKacPWJZpEskf9p8B62bzVnPI4w3mofyWR1p1mA7dA1aDnvUwUZ+zI?=
 =?us-ascii?Q?4rCiC7LN8nOAUUrqdzoxkkfRKZRIONr+aSQ4vBjYrRJaNOMO02J+sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE3nGBPeEX+qd8Q2thvr2J+nxT5PFhirutvzkTZqSRnGrTrDPzsFf+eeB1gh?=
 =?us-ascii?Q?UWC4hllKRy/y698jiT1gcbN1fffykCu/JPNxktc/ESs5B9tsfVZmKn/D/YUf?=
 =?us-ascii?Q?vLJim5yZ0PL/0r/G8m1qd1yfLsh8sjYImnwccQDAAmCIyrM+Ezpv3pO0aiAm?=
 =?us-ascii?Q?y04+9JtvH6+62sigefxUWtrzUI0XjkpL4sJT3Z4V1GhLu4TuVebSMas/MSAn?=
 =?us-ascii?Q?obhpR6PIgu0D/626fdWwrjEPerahMVpPqTWezbBh1Zkkq2xIdgJoRJFXg9sw?=
 =?us-ascii?Q?/+4+W4/A+K3+E0/cUMXNFA/zHvLKKytD+pcWzYEs4Mf2PNpugxP+hakYa3n8?=
 =?us-ascii?Q?wuc51VSzYT0mUWDosdXSDHkW2ciJZqOPOmFqTu5J5KnifbjLKzLFQbqNiol5?=
 =?us-ascii?Q?vkH7VKfzh9G1ic6NMbRtfDAtrZmSk+SgKyTMoTkCajU9nRkjl4k9OGij4Z0D?=
 =?us-ascii?Q?aLtz2mX3OJAkdZZaCTZQhWQ0g5ojj43yn+8sgkgaJsI2bkNP2cFBTvqQ2eAY?=
 =?us-ascii?Q?uVgQWJk1Q02mSjzIgqZpS4LtfFifZCRMaIboYv24y0Kdt0rxWL/oGkhh+0bc?=
 =?us-ascii?Q?XzurwdZMZbEnJS1OBFmj4p462S91NiFYDvAKxzlYDkD5tBmOi8KYjvKR7X9e?=
 =?us-ascii?Q?jWpjoFFS0reP12gTssAFv0goLklZiOuxkD2wGkKaihDoiG4vOpjkcoEVo9EO?=
 =?us-ascii?Q?+Zl4Hpu6ZXRj7demI/h+8orG+D61doepwW/lfY0Zmp/M4bpz6TzvDnc0amdc?=
 =?us-ascii?Q?3qPTDHBwyFnNhKrGJuDKq7HkoNdyDFKMUs5C+RTr/12qHzLNXBa1hNWq5fTS?=
 =?us-ascii?Q?AJ24UaG88poJd5UwKIQYbR/r15uLcVXjS5KHS1Jt2+cpU237dmsJtkl66u6I?=
 =?us-ascii?Q?20OO8xtuUJflVs6se6LmLxQp8w6YS8GR64F31dSNeZVXDag5krGcuYf1z/oe?=
 =?us-ascii?Q?tWzwV6bXBltnoYUtSQmgY6bm7uJMoAJWmaPJPHGLfRcGbmTsUmOxmqAI3cRt?=
 =?us-ascii?Q?5V72w1Thd6cBs3ToxqG5P87Dzie4JG1YTEJ0B2RXAUpOUOdeIaoOI37JGoGP?=
 =?us-ascii?Q?IaBoQSRhhAZqAouLMEZLsNjfaDJGxE2F3A5GN8uIbumU76WgPybzuieu2b9t?=
 =?us-ascii?Q?AuLYJoOZIiLOOdfZ5JR4YDXnODwCeX7P5uYYAKAhc045qYlywhIZWygLfVY5?=
 =?us-ascii?Q?tbA1fMs1KiXpBQs0oHTUyIeNU5g3JJ7rlB8l05qS+hXyvdKeBMVyiB+ACpJs?=
 =?us-ascii?Q?RefUfUzeBx1eddDV/yu1AL+q9p9wHNk4sz7HTUDeahOACOTFexq1I98pIhhy?=
 =?us-ascii?Q?qwHbz2RXjzykhTSQEOMb8ytDwKmKLBGpTwCg8kK7y0qGeFzMWYI3/piuiODz?=
 =?us-ascii?Q?MD7WWK+4C8XFS1CIujORkWEAPMvmpj/ELqSUoiIhEy5W6fwBxq5qhG5d+IEB?=
 =?us-ascii?Q?LnTZjlI40J8rcz9EvG2e31qXP2u92/E3rphA0hsvroTkUwYld3ZfX7S0s93p?=
 =?us-ascii?Q?hlhbgmGNAY/csbxcd4NV15lkqjZRwJnwobbpUYBdv02BkDSj63VsnrBqLKbq?=
 =?us-ascii?Q?FuS+J+avDf8y8vK3f0doDrxllO9VrF5+/LZBVS8E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe85c87-4fa6-4e93-bc5c-08ddce48eb4a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 02:37:53.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EYoJTzwzlLtnAlclHmJgGdKw4YpQDpu5eNcfUAfhqqAzDXSMhSzGCSoXy4BN67bQZXV35I5vV94W+6S8J2KUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10732

The TMU used on i.MX93 need some speccial handling and workaround to be
done even the revision info read from the ID register is the same as
Qoriq platform. Add i.MX93 compatible string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc6..fc1bf102350d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2022-2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,9 +25,11 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55010c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
+#define TMU_VER93		0x3
 
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
@@ -232,6 +235,9 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 
 	if (data->ver == TMU_VER1) {
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
+	} else if (data->ver == TMU_VER93) {
+		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
@@ -319,6 +325,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->ver = (ver >> 8) & 0xff;
 
+	if (of_find_compatible_node(NULL, NULL, "fsl,imx93-tmu"))
+		data->ver = TMU_VER93;
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -379,6 +388,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
 	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,imx93-tmu", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
-- 
2.34.1


