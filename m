Return-Path: <linux-pm+bounces-31527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61BB14658
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454835429E9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E0211460;
	Tue, 29 Jul 2025 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbDUIozV"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8A20FA9C;
	Tue, 29 Jul 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756683; cv=fail; b=iusKPkyBjkUJHJp2lY1qdXcrcTDC+QFvtOrVzjL2tt6pPkBtKS33ShtY+fyobWCoFAc0o/MXwvMEpmJg7jW7MsCVtbgc2eUqMO7pOtN9BMnlXGzPDZ4AXQ4Uj30gq1HvPGx8ya/A625ILol6/IR7/gm+L9PuUwJYWPrUwUw2cQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756683; c=relaxed/simple;
	bh=KDPawkELNozr7V282zcIjg6INhN3RC+U1C3NC+zaY+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGXPh1S3BD4KuprRPW3dhhHP5WWxQe2cOQ0MGXYOGX1BGSYHNsvnCVQKemLfLKT/CnVtSUcrgCxbsWitrbzs4k2Oi+DPO8Q4ksWpdLgUUZ1XUGJuN6fCF+TJwv1WVI4MCA5l9uTbOEAjN26zDI6b8g3d18rByByWc/6UGd8j+Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RbDUIozV; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSlqMpvpwQUKcGPE/YBqLoZjcHCzXOjq0QstOLXp1en14HM/nw+kTBd1M+XrjjibZLULBBcKdCJUJSqudKuy9+ueSNFu8O8kO+DAn8bZmuTexN84NZwb9H1dh3JY1dwAKZJIBorrjh/v//oiBLsHiIojA0mLgR3GrD3mcWDZ3m8zb/e2PE9AV3F9y41YJISS76JVa7TBvxMmzJNr7qNAL82/WIENiq28HYabuLrUAmC8m9DVMKtk61rEFB/XpZNwfU1+KYW2ByUz/u1YbuZWvmaz60fClmBIFYfcfyvvLP6LcWOiHRpyZTuX5/hLW4uPwjqBul7YK3XwM6qHHcgkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfuLN2gxFJzqBHsANtqYXTCxodX/NDJ1QXGd6+ghMc0=;
 b=UzOXc1yT8hIlg4eElST01V/AYsPgQEKlDKYbP8nyvY+ricltVzLqFMfTOrTBVssR1ZKBDKZS8f5+RvuQzfJ+f+bl+aAYqyhD8Cc32WUeDdn7VTV/MDjBl03+n5A2Tp4WaX8zzzSysgzdaqFIW2w3jEjXBirER6beyxHEChO8BOXXLwF2ZYcdgZ/YrZeYebFg+H+mQmAS9Gz029bevu6EMJ/zQ9NABb+Aid7VY/O3dDKpI92mLhgXybGi9N0Fk//o3hZyoYCZEoXpus72aBEjWDoEiksRLonlX4rNKEhfThq8vSscp6c2P0GE+SD+Ims1btFDZIcfnzu8Ta9YlneoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfuLN2gxFJzqBHsANtqYXTCxodX/NDJ1QXGd6+ghMc0=;
 b=RbDUIozVB2e6O2UPvZLK4RvUlwRX/QRnETz9/1CcaEq972fRw/pPKq/KnuWo2TvHAFWQbSmSlUdL30Lio5DsW+/C7nLymS1pIcXFFSVIGwXipleojv+FdNBypjnI6QVGBCS5oRkurMJtEnokh3K/bR1wo3jwNoMUp/a2WE0k6Kwy32HTWiab0dX6D5qyQRtNXZY26ARPy2IGSe2oou2plMlzxu4bDuNLiTc99wntXtQMy0fuzB1gsLoVtNn9wQ0SKG6EIhBs8+uUR7XKNCJi8IzUvcqTVQJ4yZ8AY+GgEvyUSDJHrJ+7nC6s5voZfGZzEb0IR/28GnqILTz5ihgYCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB10732.eurprd04.prod.outlook.com (2603:10a6:150:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 02:37:58 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 02:37:58 +0000
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
Subject: [PATCH 3/4] thermal: qoriq: workaround the tmu temp jump on imx93
Date: Tue, 29 Jul 2025 10:40:38 +0800
Message-Id: <20250729024039.1223771-3-ping.bai@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 690b6e59-5e6d-4371-5884-08ddce48ee2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fWKVP0n7EAv70Zl/2PGFYnyESrWxdhSxYES3Z/UWO/1tm4bEuS59Aq+R23L2?=
 =?us-ascii?Q?gaVIZTfLkX6jhq6tHwa4+AzqZ/d17CacUF6ncARnzuAu7Lpa4mraD6azorii?=
 =?us-ascii?Q?SSS25COPYW1LY8hkHrFjT/PAMtawLJJ+1TaVmcBkr2lJYPYT+HQViQrYovDR?=
 =?us-ascii?Q?FslH38Vdv70dn1IENkodcjlhRD7OZedEeA42kVp6OopfFNRxNi6XgzWvDDpZ?=
 =?us-ascii?Q?mc3q8HIcBkaduyF1WCLXmNqk7Sn1BPYtDK2aHnMVZJI7IV2OjfZ8hcx5iyfy?=
 =?us-ascii?Q?0th4mSnlnmqxbodk0/HonrHuc4tKVdasFSHHlLOfk0rY4fSv5VVUSzIkk0Cd?=
 =?us-ascii?Q?IemBolb3mY8YT7FoFlYz7sh2aBdzLvZk7yCB0DW2iDTN70k6gQ4ArXhGqk2h?=
 =?us-ascii?Q?gJ+iuWAbhPrVdGRWQ1uBfLqirjDruEL6JjKH4Hl5m6ov79psu0CNXgex08jE?=
 =?us-ascii?Q?Xp0ASAXy9ERTQFVkrqZ6gy2+6YfH7FSMyPaj+cB0M0wVZNulrzD7WKSxpRXe?=
 =?us-ascii?Q?I14cAPJICqBxNYlYLlra115zrPndFlymvmELhK+qATgXMyxJ5fRJI8NYOHfh?=
 =?us-ascii?Q?58FNGjscYg9FcyuOLV23TpUrLDIj7dMOZRQRZp3dO89DF0rPvO4tmtJ4xH7o?=
 =?us-ascii?Q?RUDXw9LFNqDZ7dR0FRi8s0oNAvN6WjFKaBpTcmDKeD3jUEdzAlk3ru1gUTd0?=
 =?us-ascii?Q?XJGUx+iKiWCW/yC1Ca9m93tSriYuUlA82Om+SgSJ6ay+Hs0ip4jNAitYAKgc?=
 =?us-ascii?Q?o89SMus0ZPyvAwc+uot/Dfw3E2cEZTtlUKyUoK83Am+MAzYa859t28ulzUIu?=
 =?us-ascii?Q?hi9SYLuZvAqTF3mak0Xl2rnjflslw5cDi4gsECOjRikrMRCMYc6x8l7949kL?=
 =?us-ascii?Q?1GKXB96/0f0TsFfo5ObexP37ttgo3dMgpa1lkI/kNFc64xgoDLWOanYAXMbK?=
 =?us-ascii?Q?ose43Ev8R2V91ryeJwcqxd47ohjPdyqt/KspDt8PWjYfJZI7ZLaseHyCcM9D?=
 =?us-ascii?Q?KD8SM7m4HeD23138ehLIctoTsjNhvPowyGmDdABMwpa1NSsQFWzYWxJmVETi?=
 =?us-ascii?Q?wD7KH2Ju/+XF5ZEp5UWGHpzfRYsyjOh81awb5ThYM0L5Ht2kW6y4nkWtRTFP?=
 =?us-ascii?Q?kdUjzYDNSqzYg+4U4+QXqcrmoRbxLs0Zti9hCuNdp5DCa8t8mf75wfKDfcsq?=
 =?us-ascii?Q?yiPz9Iipx8GIHxKCMGaUg+3qmvOaU3UU3NY4WbOfhI9cRxa9uwrTQDrOwJBY?=
 =?us-ascii?Q?HvzYkSr5uWY8AgAxne1XokMLdX8WDwOYzxrX5lDUIMp5ZaOGb+FKV+DHTmJu?=
 =?us-ascii?Q?zmIN/xoYOjChoeNXNB+3VxJvv4yQo+cKEtTj7RVnvyBH2gEnB0dWhGp/+XCj?=
 =?us-ascii?Q?0HFnijGY4LNdAi2EkQhhBgtw1R9ZM2OOSftNQ8DmAAS/fnyF3ggbIGSf99T5?=
 =?us-ascii?Q?0nqwfyRjjS+af6kwqk7pB7m+sheKJj2mQ470OSRsKHBqJ4j9RyFdtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w+/sBOv6SOIIizaPV9kfIT+bpj3o5dVEp4pKjb5FBrRw75VIKvUyfnalv22Y?=
 =?us-ascii?Q?mngZwzf01jfXWKtMcAPdxSs8C2J+CUDi3MVCxlP4x+fstiqgjGozsydKzMqe?=
 =?us-ascii?Q?RAUxtihNY1CT+5vMpvCf+ky0OwkklH3yBIhD0UbrmpTMoDrk+IyYrtYoqURW?=
 =?us-ascii?Q?0fokvjP0WITG1PkxekA7JIR1RqPv7gb0vPVTI7azwa0M+ERtmR+BsLDFIyfQ?=
 =?us-ascii?Q?fx4mwyLwVSQ8kB95NPy8AF/zAoi4Vfxq57l8Xn24HhzOeRiY/nRvAR8aP+2A?=
 =?us-ascii?Q?V/kp4GZqiVOt1KX1HOp4vo1lr+iFi3xkL70STlhE0K2aREs0LwcpCCbPJKbu?=
 =?us-ascii?Q?M/o0rzx0gp7ytx8SAvt//SRY4kzTCxoEjFR++IMexQeNemSkIxg7wlLKy5+x?=
 =?us-ascii?Q?G6+8ZGxLfvFwD/c/rPEojWyJM8UqLySg3VtyEVVShJ8fzGjEijNZw9WK4TWE?=
 =?us-ascii?Q?kaOfpXBM/Nf0nb/arp9y9t+TR2PZ/KMNruOfg3mESp7gmRL+Mi9SSUPuEbQ9?=
 =?us-ascii?Q?Ah/imCHvlPHg8Geb3nS+gGIFb8UdQiRZXl1p4GxyFJZeibEoyRxTn995srE7?=
 =?us-ascii?Q?qryiZM6hhqK+LkDFs5x7Fye0i7AA4WnhkMOOqd/Idbb5ZZEHMlQqRCRrsZ/l?=
 =?us-ascii?Q?X4iqu89zwFYZORLUBFeW/uTQhvnsm+Dzo1TU9S3/MhFQN80mh/TKkjHGbVCU?=
 =?us-ascii?Q?Fxvby7aJXEnyazEm5eeUWIWttUGtf7+wKF1RDMLxkxiU7xz3sBuo4hByHCv6?=
 =?us-ascii?Q?xEsN/r5VSaGAaR0OJ9ttpYRbmBeSJbYPzTxAYwScix9VHxbkp/0Kbog7iFy7?=
 =?us-ascii?Q?ChvbwqI0kURGoRgfXl609DA7Y7rCaoPbJy3uBCe5bslGaJz77EbC1wU6pO6v?=
 =?us-ascii?Q?djELf+dx4ZFlISPbXGxA+gxMhZ/gCh3niccZieRno39bsIYKCAsHpVWl1CX0?=
 =?us-ascii?Q?aeCLxHX8ZFzOF1AHa05I8dJrSyQVCsBQGsBK/6ug/QQGQjgCpbVKjxVqVD9Y?=
 =?us-ascii?Q?qccrVNgw6Cg2dKaD3NBPB8Fv+hO1etrr7Liq/94JlNIwolV9O8B8KoJINWJQ?=
 =?us-ascii?Q?PXpU2O6U8ssYX+cTil8R/LxCeoajmJb68s1Q8TpCZ7PV2cEyN4GyXBFJjFJh?=
 =?us-ascii?Q?n+z7QTSWaWXnGqTYQGBhsDvhMD0Bsytal8HoudAz38ifVvlRlAcfzFdVvwKe?=
 =?us-ascii?Q?313Qhh3JiSs8uU6ib3G8kmzA01IQNoYlHLnYzdpzvsoQEDspP15zFQwEYLyJ?=
 =?us-ascii?Q?bO3ZDxTaK0zaT77T61myMA3wb9MkowABAyk0Dk140eVNxCUDaXKivYIyCkSo?=
 =?us-ascii?Q?noTmlrVQDoIlhniS+aB4kgMNkt4eAgX6OIxRTyq/YLiSmw9QOBXIIxz7dbSU?=
 =?us-ascii?Q?rJdNs2GIbpSjAlIGit9LMo9AKdvWjvqB96Ziy2z0TB4ifYJjYcZcagbrdGwv?=
 =?us-ascii?Q?6k1tsyuq0PFUyih+ExqPFbsycgovoYfy2BkaTGcxOwGEvTu8XbpNCc6BjUut?=
 =?us-ascii?Q?1cdmdTBeV6un3ZrW6uov9WMZisrKmKCzjuh2K1ZNAYzWy2yI2C0wrSOJFti3?=
 =?us-ascii?Q?85xzU4kcxUastma6gFoiJIJErz+K6Y6K4s6myCnq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690b6e59-5e6d-4371-5884-08ddce48ee2d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 02:37:58.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezmQyrX5mauE2eZQqsdQ0AlXTqro3no3++n7HCaLxjWs/uP5Pdb2zZd2Yt/1WAs/0ldpK0LkMz0CPUlX2+Dl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10732

On i.MX93, the temp read from tmu may jump wrongly(ERR052243),
and invalid temp will be read out. To workaround such issue, we
need to use the raising/falling edge threshold to filter out
the wrong temp. When reading the temp, need to check the TIDR
register to make sure no jump happens.

Please refer to NXP errata ERR052243 for more details.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index fc1bf102350d..9405a8359ab2 100644
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


