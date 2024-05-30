Return-Path: <linux-pm+bounces-8427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C68D4D28
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7BF1C22BB6
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A717D89E;
	Thu, 30 May 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LrzWycIR"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2083.outbound.protection.outlook.com [40.92.52.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8EE3D68;
	Thu, 30 May 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076958; cv=fail; b=IXsafQk3dE1NZU0sgqFnKAyVYbW21dIyLltMHnpFc3mGlCs3e7XZVF+Am2TqnZYh67JJgF2HMYxVm60LYqbNQ1Tvh9AzahW5oPCXkpdeHIO5WXNIQIAIAKEhCS8AmTUAa9tC37MMuG3ug/KElmhUyxQ13w7ojHvPULEuJkZc5c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076958; c=relaxed/simple;
	bh=b9B4LfezwPKmcYPNIhhX2tHFP8/MI3gjJOWQrJG+2/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeizA8LEFvs9O+alokXEF7m3Qq6pwjjny8rCK9Qxn9RoPk1qW6CtNvhC7PqUt+pHCtPxiPhH2n3f/Rf/LaEcjohHh2pxT6l24b5KV9oj5zkgMl8CBKxaehrUs/+duhxXiBi4D6rKiXydPxZTIOw5oPeK69q6zSE22cUxP+aUwvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LrzWycIR; arc=fail smtp.client-ip=40.92.52.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpLR6XCGgVCZs9kwMw8WVQtoG9TGQuhoBJ1ji8xLYm+o+0WnTctDh0/F0RT6WoPiyGaCjnxXHef/j72XFGGqgQol4MLJHWIQGV8lVa8u6GvCq3XY68SZ116gBbe435UAxTmnbdu64eyKm8seLCSQ3NQkFv1aqbWfwfZoqS+yfiPAffmzRY3oiHwLjvcpE61rMFhMY06HJDVxgiJXEKc0U7uhOVfUNZNBx6FwG26IHC/hbLkm6drbq+K5+/bBoP9Wp7TxLRTulVvniwobYr7ZfSAK9PhwbYpeVKwKGuvLF94PDkRDvJJULC2pdbRmzGa+2YbC1XgGRN0m1bx/I6fL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYss9djwK6bL7UY2NUukNDwb58o4m5NbqYrXWUGZlgE=;
 b=IAS5mYsoZS2H4KsK+thkSzQVG2V0NxMiOBBSF27zj74vI1r9d+PCOAfJvszLsCP/NPZBsq408AhFF7gix2ZuRysXup2rB+gzBxQjAOBIFPY+3rgl514/CkjmutFu5j9u6uJtC72Ya7oIHflz1EfSbIa55cjYe+PiHXvA/xqNurVQn0W998awEaXJPTaEJNj2cVYw2iIzpl+2L6+fvY8hPVZGwwqaapMYc1hsBITmEImtbRXl+Plzo4KPcUczYsFvwMEGjh0y7mpFgUtJAPeGv/JaM45WJtBW4XuQDxe0MFQWSqyNtnzu296zFwJ/owDUMxDXwJJEcGbAENRO2DORKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYss9djwK6bL7UY2NUukNDwb58o4m5NbqYrXWUGZlgE=;
 b=LrzWycIRUDpiVhOFPrUAcGW/jCMgljoHsAP+gM8f5X7erI0v5f7q9BVrz+wLzf4SlMC1C0RJkoNRXAtWH73yBCnoXoU8WXB1Kdsf17KFrYJYgPcYrmfU6z2laLOOWVw/qxUtCSBj/31pj1UOa4ulLGj7idqUuPtJfRVAuswCNZS83HchJ09sjg7Q9aO9UJO++EIDtYaLUaDHCBSOAupZMLk5Xfz0BK4SRYzCgwA7wX9iajubdPcP/5lQJAUG3C3F2ezkYhkFZ7U62YHsMFYzjqaia+/VUX6D889zwfrrT2Fgrs187azZmwh5N2RSBz5Ln+YecZUgMZTFeo/lO1vRiA==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYSPR01MB5657.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 13:49:12 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 13:49:12 +0000
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
Subject: [PATCH 3/3] thermal: cv180x: Add cv180x thermal driver support
Date: Thu, 30 May 2024 13:48:27 +0000
Message-ID:
 <SEYPR01MB4221BEBBF659F8495BF0E831D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YWUfnzWzre1af1lXCVRyc6z7vzbmpc0k]
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To SEYPR01MB4221.apcprd01.prod.exchangelabs.com (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240530134827.53431-3-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYSPR01MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd4b755-f484-42bc-9550-08dc80af4973
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	ArsMR5ClokS1aixcRWy78DLyFJMDpg9/xenEoQiQsx+2W+Xjpusvc+ZOKKaJKRF217YryRuZJuNfzYa8cK9hmt+J6QmJvGtfnVrtrsvTpIcvNLXJx3NlPxC1gTjrSLLqdz8kfweY98UUoqpt02vhdq8zSBzxk8RrTXpYS27a+iuftivfBsE+0us5RsVKMr9iC9eLtFSQrrdNpyGJEh6IBvvuL9uFrTfhO7MdboNkNAjJCk2M1N1pXdN9SKaMzXKfC+XrAcHG9J+A/Z9IgMfz/ev9Nkg0nG331p0KyQI8Y3MvwtXl6BWvGf8rpuIOeuzpm5/2675v5TXQw7iRrl5pQwXPlpFIB/86G7oM9/QzzYhcyjhiX5WGdHVZ4YFdVw/OWYGSkK2T9VMY3ln6eiXiBhYMVE3pcNXLOl0KEE3o5hnhba7jPjNsGMiMpmZ1tFvNIC3gOqFL3514MUdeLwk/nZe1jnR6RFNWqj4zOt38hRIBkoK+OhMY5TNL+XRbYinkLtpGjGzIWlSmS23mA2lD2sblTjSqvpASN5wtcUy3gydn9DeOGCrCorQ/+fnTqIBAmtvqZosPF1l5hZU1cpvxybWKI6EoEnBfCwkLRu1n+9nK9PkrAt5JBXs6RlbgU4rV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZKiKaGZdKumqZ/zeYVEyhQO3n7wYsOeWVE/3FkCoPp/uPcmyVAHwfsZZZxf?=
 =?us-ascii?Q?mYS2i6HlijUJJLRaL0+bYmoL2q9zkkK7LAhovId15946hsPekrObMjDVoBK3?=
 =?us-ascii?Q?5pMIMtKoMMTft7koK/3tNOAXfP/J+wAjK6wdiZsAVbKGI3b8BTMMY0pKeEmJ?=
 =?us-ascii?Q?29Ww/Y4OyIFOmNRVzCZ6KPLkpEXVnoYa0V0G3zC8GQz6ndRbezXwRgaEstEz?=
 =?us-ascii?Q?+caKil2eAI5pbgAC00bk9JFa7rz+19+wJrMJaV3tUXllKMaKNVmlvdH38LkK?=
 =?us-ascii?Q?SeeCzvAZa/SxAgwPjcOmzIABOntLFNbv2xfPZwGlhDunZ5TO9KVb9ZpCN2Z8?=
 =?us-ascii?Q?gvfYYyQCAh0R/pJhiIkZV1sEVmIG/JXuE5iFbsW1mpef05RmrgvzBB/taG79?=
 =?us-ascii?Q?F5yO6bTPt2boyJx2e347njSPe1aeOXaohquhpFqHjfDtsWTs1UAuXpYaaPOJ?=
 =?us-ascii?Q?BIrzCH5rqbDA0xjvh2pMQOFKPlu9edDkV0CCCEiaZSkwTTDaWDTtrYPmH2uK?=
 =?us-ascii?Q?QqXmdknYQCL4VUMZUK644Qi7fqsDSEmbpIlc844TR8VUj59nXm8LkRZXiTsd?=
 =?us-ascii?Q?tUBC0NpFiMCl7B/DbxmxdjExaQpeGPtyl3tr9LZrjC5Cv3Pc/1RIiqcxG4LS?=
 =?us-ascii?Q?HSdXZbt8dJ2gb3l2jOHV5yVxUDdsQEZj/XfxkfSKMhME7ie/PwRFAxVZ/lhz?=
 =?us-ascii?Q?taH78lc592/TUZA3mpCLSIBsYtFAzG3Y1/j6AlZrdxt7dNeWF4jEcLG+QU5R?=
 =?us-ascii?Q?MReAzgrHulAXE+5SDwnYaqdl5abhUCMJMpml1QU4eHciEE9nv/6W3xJZ5mFh?=
 =?us-ascii?Q?sMUICB2clKf5trxRDvCRlAb67PDcR2mFxt4oUCStLk32LThZcvcoN5dyDXKE?=
 =?us-ascii?Q?9rUtRJRWZIg9xDtZomyYefbv6en+tofLiWb/x4Ep9u1dKG04wQ97eLE/T+Az?=
 =?us-ascii?Q?klJ6rez7RDyfart1vNqKq5sXYM70edNUl3xA5FLgXsy/Tvb0I17lvhkKwnkQ?=
 =?us-ascii?Q?X5joXPHGTjcPerLazoaO7LUknLrN0IvLdY7fC5R3bQM8cQ67w/6ToWJffqVj?=
 =?us-ascii?Q?IJkT96nkPr2S/T/AhvF0TQ4oKfQFI3NRLN0YK4M/v+G0oWsjAEH1itA0FS3K?=
 =?us-ascii?Q?f7WcAFm20i5UmdXJz3dipdMr2m4bds6ML8yMnpd3PntfsLL1SHUFPvFGy8In?=
 =?us-ascii?Q?H6gEGeAsjV1iLQO0ixpk4FjjlO24HoR+2S/f0lWZssYXehTsiRWDwhmkUa8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd4b755-f484-42bc-9550-08dc80af4973
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:49:12.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5657

Add support for cv180x SoCs integrated thermal sensors.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/cv180x_thermal.c | 210 +++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
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
index 000000000000..618e031b4515
--- /dev/null
+++ b/drivers/thermal/cv180x_thermal.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 CVITEK Inc.
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/thermal.h>
+
+#define TEMPSEN_VERSION					0x0
+#define TEMPSEN_CTRL					0x4
+#define TEMPSEN_CTRL_EN					BIT(0)
+#define TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
+#define TEMPSEN_CTRL_SEL_OFFSET				4
+#define TEMPSEN_STATUS					0x8
+#define TEMPSEN_SET					0xc
+#define TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
+#define TEMPSEN_SET_CHOPSEL_OFFSET			4
+#define TEMPSEN_SET_CHOPSEL_128T			0
+#define TEMPSEN_SET_CHOPSEL_256T			1
+#define TEMPSEN_SET_CHOPSEL_512T			2
+#define TEMPSEN_SET_CHOPSEL_1024T			3
+#define TEMPSEN_SET_ACCSEL_MASK				GENMASK(7, 6)
+#define TEMPSEN_SET_ACCSEL_OFFSET			6
+#define TEMPSEN_SET_ACCSEL_512T				0
+#define TEMPSEN_SET_ACCSEL_1024T			1
+#define TEMPSEN_SET_ACCSEL_2048T			2
+#define TEMPSEN_SET_ACCSEL_4096T			3
+#define TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
+#define TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
+#define TEMPSEN_INTR_EN					0x10
+#define TEMPSEN_INTR_CLR				0x14
+#define TEMPSEN_INTR_STA				0x18
+#define TEMPSEN_INTR_RAW				0x1c
+#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
+#define TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
+#define TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
+#define TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
+#define TEMPSEN_AUTO_PERIOD				0x64
+#define TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
+#define TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
+
+struct cv180x_thermal_zone {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk_tempsen;
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
+	regval |= TEMPSEN_SET_ACCSEL_2048T  << TEMPSEN_SET_ACCSEL_OFFSET;
+	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
+	writel(regval, base + TEMPSEN_SET);
+
+	regval = readl(base + TEMPSEN_AUTO_PERIOD);
+	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
+	regval |= 0x100000 << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
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
+static int calc_temp(uint32_t result)
+{
+	return ((result * 1000) * 716 / 2048 - 273000);
+}
+
+static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
+{
+	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
+	void __iomem *base = ctz->base;
+	u32 result;
+
+	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
+	*temperature = calc_temp(result);
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops cv180x_thermal_ops = {
+	.get_temp = cv180x_get_temp,
+};
+
+static const struct of_device_id cv180x_thermal_of_match[] = {
+	{
+		.compatible = "sophgo,cv180x-thermal",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
+
+static int cv180x_thermal_probe(struct platform_device *pdev)
+{
+	struct cv180x_thermal_zone *ctz;
+	struct thermal_zone_device *tz;
+	struct resource *res;
+
+	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
+	if (!ctz)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctz->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctz->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
+				     "failed to map tempsen registers\n");
+
+	ctz->clk_tempsen = devm_clk_get(&pdev->dev, "clk_tempsen");
+	if (IS_ERR(ctz->clk_tempsen))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
+				     "failed to get clk_tempsen\n");
+
+	clk_prepare_enable(ctz->clk_tempsen);
+
+	ctz->dev = &pdev->dev;
+
+	cv180x_thermal_init(ctz);
+
+	platform_set_drvdata(pdev, ctz);
+
+	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
+					   &cv180x_thermal_ops);
+	if (IS_ERR(tz))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
+				     "failed to register thermal zone\n");
+
+	return 0;
+}
+
+static int cv180x_thermal_remove(struct platform_device *pdev)
+{
+	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
+
+	cv180x_thermal_deinit(ctz);
+	clk_disable_unprepare(ctz->clk_tempsen);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cv180x_thermal_suspend(struct device *dev)
+{
+	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	cv180x_thermal_deinit(ctz);
+	clk_disable_unprepare(ctz->clk_tempsen);
+
+	return 0;
+}
+
+static int cv180x_thermal_resume(struct device *dev)
+{
+	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	clk_prepare_enable(ctz->clk_tempsen);
+	cv180x_thermal_init(ctz);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
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
+MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.1


