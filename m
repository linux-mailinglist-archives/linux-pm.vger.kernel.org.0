Return-Path: <linux-pm+bounces-11140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5379F932322
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086B0283C93
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F521990C1;
	Tue, 16 Jul 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dM9XjJ+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2066.outbound.protection.outlook.com [40.92.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB21990A3;
	Tue, 16 Jul 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122989; cv=fail; b=WaWZniFZcxrpqfW8ztOr66zOYqxfi1AeFvPjI94Ukt/hNbUuXEV+NURbN7s6Bwf39M6ATTcKHzWJSDztnlyggr7XiLKfkbSbFgKWJTwxV1KRbAbWiumY3NFy7oyBPQBaYng2YlTTwDW1u3GocynCXODjuqV+sWwJiWrCnxntCEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122989; c=relaxed/simple;
	bh=AepRQ0MEmGa2fZPOKyXWsBGaHnX0zJq3H+I/1VHxgec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sN8APinIadsuWlWg2H5zi2x/CTqYdXeI7zofuh08a+GJYaA95Z5TCzTjbIYIo6w2kdQZauPR891rD3KY5NNhDXLohcu7600DL7ErXyvso28mSzsl9S3e2hAu6LVudRSjX6Gf1rTwTv7YJSvlsRWagKnXXGJ92vchIt03FaDXvO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dM9XjJ+K; arc=fail smtp.client-ip=40.92.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOswFl/IjCnmjH2pOa5hCl/p2TgKTJYp6PdXAKxAS4YOk8bEMfYZ2NavYM0wlpK9MZWdhbExMOroUxroqHbJce2vy5N9pc+AHihITy/YSZ6HpJznJ76AgOO01dTn69szqXUGy5wAYFYXBOZt5Qf3Y9kH5Bdd0bEEbbHYAP9zqcgP6xrGI/HZEXwXPd62niFwbh/UwXtA/ROBi8WlfjgI/61Z89aDt1dsDBnf9HiLcGX2T1TdysiwHNw0NSC6uqp5M4j9Lfn8vGLSkqxTj2+OGuOPfHXMuCMgkqjYoSUM+KjklZ3yCbTqim2LtWH8Z+NwL2GxTKepb9BoX8CezKOiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ef6FeKpd+W0xLDHpsy/nlPMTEKbeiNL67hnB653Z6k=;
 b=cnhCqSbqi5BOlR/5kpgaaBh5kUxzU1cCJiE7tQaWgauPuvFVAuOp00dKlMXF8IjJ3C6UTeL7pJ2V1hAte3xq0X1tb1L5J/pGaQfOiCLKD5xV2fs2MjJzZK8LJkNIotdrrbzMiokZdPv80h5E5mgVg4XYx6pCd3OBwYKEGk8RKus+Z4EeJcM+aSDk1nvoTgSg90ENnFy+qKg25dFK2vNo0lqXlrX6KOwg2vnJUWdLyCH6azyhj+XolhgD9REC5TZBP3pvpT+IsSe3d9A+E+j1Dqzitc6ACY+KeLOxKyim5CZq3D6Vf2Y4vGQomCiRGW25NoYfMpddLa0xikEV5PnBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ef6FeKpd+W0xLDHpsy/nlPMTEKbeiNL67hnB653Z6k=;
 b=dM9XjJ+KPnO5K55j6YnK/ZXj0qf8jBTskoNw/er66S7oSvrPRwEViIwG9SjxO/dyMSwMmovVm5ZsSWblIswZEY7Dlv91eigBCjru5lcNIGUTy8cxXhDPBlVXZ3u+zgWqA7dgEQmWkgVM+zqMYU8paA4fw9GOefMq/huRQa/kNNaZkIukjqhZckWoDaCXKI/VDbnXc9MU2sL//qyAT803xLE/g2u+rvlHEDCnMP+kzrpnAx8YBDekr8HnYRjl60sAl/ewCGJO+Uu7NlkTq28vzywggGjkHdcx6uVq7K3sxTqpeA15w7PpXFWgYKoZK5+hfqGfnteUa9bHm5VIPFo2sg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4895.apcprd01.prod.exchangelabs.com
 (2603:1096:400:281::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:43:03 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:43:03 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
Date: Tue, 16 Jul 2024 09:42:35 +0000
Message-ID:
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [dpfur8txUxkJLfBUTN3M8cdWVTStQeJQ]
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240716094235.51679-3-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 42def73b-3d69-4496-33a7-08dca57bb025
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	9itgIIYiy59aJbOVoXRnrXPv0V4mDlHbvptjNQcae4kbIKpth+Z3iwffbDGxxfaG0lnSmD9jmdNdDSvhIzTQuZcrD61+gfqahh7V1BFoIfp4ckc+CTRQ+Au/JA3CaywgwA9sfIpfqhzlKZizzb9BAd3DP0lyeKp435XcSP5aQa6E6HZxdUy2ZO9rmDO0TOXmykbH8Z0Zu5FZlAxaSKzv1TYBy78qkBwIOadeecqK/L+K1mAf/ALxC+k+5yAGjZC2lAgFZUb8qFVSVMVt1p6dZGM+gJpr82ZtrIlIIMJTslwP6mFOTUW1YG7uTNIiuXa+NZfM1x4GIbxV+xzjd2+plWyIv844W/ssjob+N0qcNQVXKBLYnTaIbs8aSb2eXT/y87mF5A8phQDaU5GYXbgFK5wqTX+U4hTJ/02NfyLjExth7eYjEwFUAluAdUL+0DoaV+rBaxcc2QSmO5S/61mSg32dQzkbzJAaNZpmuPQytV+gFSB9eXbYWLElVdMaUQeD5cN+6S/ROMuxfscSCycxm6Fe1jUZjLy30MzeCoRfzv5pnFYuh9WRlUV8KtL08iMq7jCeSzTvdOi001eL6BGZLtEXTahcKyGcLu2bx/v+DdcBBXcLcevsPCx9oF8jidYcEhqBtuhFwX2nMIjo+IRzjW+PWeYEkvTBVorARJNcMj7WG3YXc7tEpoGmit4vZHzW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPtougbd8cmesEED/93Q8a6H1MubHi6mDKkoixA9OJeoRYA5jwWuiZfIBQCY?=
 =?us-ascii?Q?6QNY/4Wj+rZPk0TYlCySYPy90xpCZWRXj5Q6eaxcqYNm/EO4C2qVYQdqQ6gP?=
 =?us-ascii?Q?p2QpGawj/adbwoY3RmE/jLuWsNfeokIcKgFfsdpfzdWNMvfczBp0hosAAGpD?=
 =?us-ascii?Q?78Af0R1uqTBYlxPsBlv71wAWtpNDULWn9ruPx+nZ0mcScno0RtiJDKSdd7ZY?=
 =?us-ascii?Q?CnUm2zONzwg20Pk9HxFN3k1gTxYs88bSOOajCJHqwOmqK5GrIMgnhNwPKWQj?=
 =?us-ascii?Q?eAyOxAl0WdqQUsSALQvVmvkzfCOciTQqZ/1/lLAdSa0FHpU7fpdQwDx2yjS1?=
 =?us-ascii?Q?4PSo/BbnOp2i2y3TU4+gLHwvs3iwu4XMmudOD5a4OYNoRbYSJ1fZ3LRGobKg?=
 =?us-ascii?Q?RqPzifzqwcWI3rkfssl4u8/DMkLSejjWmBbVIiQQ7gVjes6/Wz4DJHk9ZRsQ?=
 =?us-ascii?Q?QVgG8vQnDevwdhaSiGn/6n9pIugDD3Y6HoReNpKHFnv9r5C0mGSgPkOYSPlX?=
 =?us-ascii?Q?chgGF02GffsIcWciGdKOZGCOyE1Yq2GEkMZhlK78DvLhd74QI3GEZT7GtQQ7?=
 =?us-ascii?Q?Uhce2hk5bvJROoapds50HHZxri+Q9Lt0C193d3yB26cAVwnhFg8J6xtVFpYc?=
 =?us-ascii?Q?Wi1JycRkRdZt6aD0nofdfjlfgK+HLO6154x4SMib47lOmmVO5bDMK/31jpsu?=
 =?us-ascii?Q?iPlxM07gNdnzFcs/JSc7+Fz30qAZPzoqj8k8HeP3K4oxUj5GKv7K8PX1Qgbq?=
 =?us-ascii?Q?eSSnpFBBaVLv3WHr7HYeR+laqrH5hEwPJlnnxgSxZJ/d+xanYPIXJfDSiqSE?=
 =?us-ascii?Q?D+dcNNT45MAfl2BnQhUSiGFKv5mv7N1DK4rFGbeqo3Z2hkRk8tvkkgAZSRDo?=
 =?us-ascii?Q?WtyeJJ19dElDypDXX8XCKLqFnMdbWlO5EnP1egtBimHTViYCQP0NL0yXi6rC?=
 =?us-ascii?Q?YMcFZm6xlcvNCcK6fuH4JuHxLuXjWxR88RZVvBxtBm+ZYjkTvSmrnehkyZjv?=
 =?us-ascii?Q?CzS6rdJItg4TEj1iRkw96rsxZs7DB+wifjjkO/VP7yZIs2JckpWig15Ss7QL?=
 =?us-ascii?Q?AV3WKJomxf3WpQ/hLAlig9otm2rF3t06cQVuQO+VUPXvUNUNG3eI64Qo2CQd?=
 =?us-ascii?Q?9nmsA83BaZpboogAWADBJXXRcreAQH9I1EcZHFQp7A89lNSkrwkUyFvRlE8D?=
 =?us-ascii?Q?osXtWOkNbp6IfTFJMLTGRnsd/MjA9AgKyWqIbSFxsyjmNwbJ0dh1whZd/YE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42def73b-3d69-4496-33a7-08dca57bb025
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:43:03.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4895

Add support for cv180x SoCs integrated thermal sensors.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/thermal/cv180x_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 204ed89a3ec9..f53c973a361d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
 	  is higher than the high temperature threshold or lower than the low
 	  temperature threshold, the interrupt will occur.
 
+config CV180X_THERMAL
+	tristate "Temperature sensor driver for Sophgo CV180X"
+	help
+	  If you say yes here you get support for thermal sensor integrated in
+	  Sophgo CV180X SoCs.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 5cdf7d68687f..5b59bde8a579 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
+obj-$(CONFIG_CV180X_THERMAL)	+= cv180x_thermal.o
diff --git a/drivers/thermal/cv180x_thermal.c b/drivers/thermal/cv180x_thermal.c
new file mode 100644
index 000000000000..8b726c0ad848
--- /dev/null
+++ b/drivers/thermal/cv180x_thermal.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Sophgo Inc.
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define TEMPSEN_VERSION					0x0
+#define TEMPSEN_CTRL					0x4
+#define  TEMPSEN_CTRL_EN				BIT(0)
+#define  TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
+#define  TEMPSEN_CTRL_SEL_OFFSET			4
+#define TEMPSEN_STATUS					0x8
+#define TEMPSEN_SET					0xc
+#define  TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
+#define  TEMPSEN_SET_CHOPSEL_OFFSET			4
+#define  TEMPSEN_SET_CHOPSEL_128T			0
+#define  TEMPSEN_SET_CHOPSEL_256T			1
+#define  TEMPSEN_SET_CHOPSEL_512T			2
+#define  TEMPSEN_SET_CHOPSEL_1024T			3
+#define  TEMPSEN_SET_ACCSEL_MASK			GENMASK(7, 6)
+#define  TEMPSEN_SET_ACCSEL_OFFSET			6
+#define  TEMPSEN_SET_ACCSEL_512T			0
+#define  TEMPSEN_SET_ACCSEL_1024T			1
+#define  TEMPSEN_SET_ACCSEL_2048T			2
+#define  TEMPSEN_SET_ACCSEL_4096T			3
+#define  TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
+#define  TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
+#define TEMPSEN_INTR_EN					0x10
+#define TEMPSEN_INTR_CLR				0x14
+#define TEMPSEN_INTR_STA				0x18
+#define TEMPSEN_INTR_RAW				0x1c
+#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
+#define  TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
+#define  TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
+#define  TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
+#define TEMPSEN_AUTO_PERIOD				0x64
+#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
+#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
+
+struct cv180x_thermal_zone {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk_tempsen;
+	u32 sample_cycle;
+};
+
+static void cv180x_thermal_init(struct cv180x_thermal_zone *ctz)
+{
+	void __iomem *base = ctz->base;
+	u32 regval;
+
+	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
+	writel(TEMPSEN_RESULT_CLR_MAX_RESULT, base + TEMPSEN_RESULT(0));
+
+	regval = readl(base + TEMPSEN_SET);
+	regval &= ~TEMPSEN_SET_CHOPSEL_MASK;
+	regval &= ~TEMPSEN_SET_ACCSEL_MASK;
+	regval &= ~TEMPSEN_SET_CYC_CLKDIV_MASK;
+	regval |= TEMPSEN_SET_CHOPSEL_1024T << TEMPSEN_SET_CHOPSEL_OFFSET;
+	regval |= TEMPSEN_SET_ACCSEL_2048T << TEMPSEN_SET_ACCSEL_OFFSET;
+	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
+	writel(regval, base + TEMPSEN_SET);
+
+	regval = readl(base + TEMPSEN_AUTO_PERIOD);
+	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
+	regval |= ctz->sample_cycle << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
+	writel(regval, base + TEMPSEN_AUTO_PERIOD);
+
+	regval = readl(base + TEMPSEN_CTRL);
+	regval &= ~TEMPSEN_CTRL_SEL_MASK;
+	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
+	regval |= TEMPSEN_CTRL_EN;
+	writel(regval, base + TEMPSEN_CTRL);
+}
+
+static void cv180x_thermal_deinit(struct cv180x_thermal_zone *ct)
+{
+	void __iomem *base = ct->base;
+	u32 regval;
+
+	regval = readl(base + TEMPSEN_CTRL);
+	regval &= ~(TEMPSEN_CTRL_SEL_MASK | TEMPSEN_CTRL_EN);
+	writel(regval, base + TEMPSEN_CTRL);
+
+	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
+}
+
+/*
+ *	Raw register value to temperature (mC) formula:
+ *
+ *		       read_val * 1000 * 716
+ *	Temperature = ----------------------- - 273000
+ *				divider
+ *
+ *	where divider should be ticks number of accumulation period,
+ *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
+ */
+static int cv180x_calc_temp(struct cv180x_thermal_zone *ctz, u32 result)
+{
+	return (result * 1000) * 716 / 2048 - 273000;
+}
+
+static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
+{
+	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
+	void __iomem *base = ctz->base;
+	u32 result;
+
+	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
+	*temperature = cv180x_calc_temp(ctz, result);
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops cv180x_thermal_ops = {
+	.get_temp = cv180x_get_temp,
+};
+
+static const struct of_device_id cv180x_thermal_of_match[] = {
+	{ .compatible = "sophgo,cv1800-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
+
+static int
+cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
+{
+	struct device_node *np = ctz->dev->of_node;
+	u32 tmp;
+
+	if (of_property_read_u32(np, "sample-rate-hz", &tmp)) {
+		ctz->sample_cycle = 1000000;
+	} else {
+		/* sample cycle should be at least 524us */
+		if (tmp > 1000000 / 524) {
+			dev_err(ctz->dev, "invalid sample rate %d\n", tmp);
+			return -EINVAL;
+		}
+
+		ctz->sample_cycle = 1000000 / tmp;
+	}
+
+	return 0;
+}
+
+static int cv180x_thermal_probe(struct platform_device *pdev)
+{
+	struct cv180x_thermal_zone *ctz;
+	struct thermal_zone_device *tz;
+	struct resource *res;
+	int ret;
+
+	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
+	if (!ctz)
+		return -ENOMEM;
+
+	ctz->dev = &pdev->dev;
+
+	ret = cv180x_parse_dt(ctz);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to parse dt\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctz->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctz->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
+				     "failed to map tempsen registers\n");
+
+	ctz->clk_tempsen = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(ctz->clk_tempsen))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
+				     "failed to get clk_tempsen\n");
+
+	cv180x_thermal_init(ctz);
+
+	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
+					   &cv180x_thermal_ops);
+	if (IS_ERR(tz))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
+				     "failed to register thermal zone\n");
+
+	platform_set_drvdata(pdev, ctz);
+
+	return 0;
+}
+
+static int cv180x_thermal_remove(struct platform_device *pdev)
+{
+	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
+
+	cv180x_thermal_deinit(ctz);
+
+	return 0;
+}
+
+static int __maybe_unused cv180x_thermal_suspend(struct device *dev)
+{
+	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	cv180x_thermal_deinit(ctz);
+	clk_disable_unprepare(ctz->clk_tempsen);
+
+	return 0;
+}
+
+static int __maybe_unused cv180x_thermal_resume(struct device *dev)
+{
+	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	clk_prepare_enable(ctz->clk_tempsen);
+	cv180x_thermal_init(ctz);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cv180x_thermal_pm_ops,
+			 cv180x_thermal_suspend, cv180x_thermal_resume);
+
+static struct platform_driver cv180x_thermal_driver = {
+	.probe = cv180x_thermal_probe,
+	.remove = cv180x_thermal_remove,
+	.driver = {
+		.name = "cv180x-thermal",
+		.pm = &cv180x_thermal_pm_ops,
+		.of_match_table = cv180x_thermal_of_match,
+	},
+};
+
+module_platform_driver(cv180x_thermal_driver);
+
+MODULE_DESCRIPTION("Sophgo CV180x thermal driver");
+MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.2


