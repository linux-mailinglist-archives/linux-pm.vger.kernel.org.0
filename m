Return-Path: <linux-pm+bounces-10328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBF923A22
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B71F22AA0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29C15696F;
	Tue,  2 Jul 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kywGnrII"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2033.outbound.protection.outlook.com [40.92.107.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146C153BEF;
	Tue,  2 Jul 2024 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912687; cv=fail; b=JH3r3qbLRmVxtDFhTVJJ48UjhDKOaZCWKRG2vpaziZRujcjlh6I/6nhFLLTxt81IwpqafEZ5RxT/PrYTKidFYtAPi4hihED1N4adLcGDwhZHRhMomuE+0raXdsjT7HZkQ2mwZP8SZqmJzBNbxsUB3Nvja4N/MuwEcJ1AaMLSRxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912687; c=relaxed/simple;
	bh=crDYPHqOt9VvDOCIimNtcXMFl2gkWP6h83lH7nZpRlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mLbCVmn70/rXs1MGT3RwqudCEAddMaGqL18guzSgnMyYOYDw2NIqOJFKKVUGB0/AmDwL7ECH/+z7VqMBJVHtM+wFf3eLQ4Jvd2rng6YUxqOPAbYw+kmjzQKtQTQ1qvgSFwuqoN9XNockm6GQjLgeU1Uz2PHqMY5JbJOmwk+HnLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kywGnrII; arc=fail smtp.client-ip=40.92.107.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GduqTYYB/Zphrg6QpLJMkpqs+ADmxQbYZcfjoSUbYaL3W3TE1w6Qq1PIpXw42yf+VQVR1Tsh0JFrjQjYuCnImbGRcjtoqPVdcC+X0AK2eS8YgCJ0XGIYhKRqG9zBhvcev7yuW/oQytsoR9pajh8YNGCvsufDBbeBZSEqS7vhSwpo70U0kFre1x9wr9ASUKZO4SweUaq4wZayRbh1kb1gIdsXwUjfP6qCqgYoXTMhw+LHrf5VbBos5yvpocCDDpMoSvrlkAltOYGlyZH5W8wcWz74umcgFS+gKG6+QcldDMRfWsGa9oxremUBz6qwrBEeRq8P+K7q1VpTYTyvuts5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWkjts3euO1adwDwswDUEmPsz6XttpNjDNi4wYXiVcM=;
 b=XjjCE2f+ZAOQrGWpDJNXcWN87iEZy9i16J737lmbtKuweS/CbCyLch0RcrDJZzCVOTBV6zLo9fvNS2oRtj3BtcbEsLRC1Zgd1RyBqEJg7OMrA5MZqv2G63ZArZoTsEoMR+Bcp4ruCqFuvUoxXJhhECToG9fiIShUIqGggciwhxNVEJm5trkKHD3K9rmb2rLWEJyCbN18MzBVjgzQonkclte6dYTpZTee9lOqh5DW/aO9amTMgRk5F8S2vVN91X8c6yqCcA1+WsMgdnq6g6EK0IckSa1Yuvy8klRVeWP1S3yj+Ookdwxwo9LWYL5NDQabGseut75eYNzL3fM7t8ZpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWkjts3euO1adwDwswDUEmPsz6XttpNjDNi4wYXiVcM=;
 b=kywGnrIIDY+FIbqeigrpJ6hh6fSug0LuNAVdu8dT7adwLtefluPfmTHujFSgihEC3zRijM3HYO47SakNnvxM/KZLZoPfx+4pco/cm3AjGl9+8K1iVJv+OIGd8kPsb0qd26JpJsag02OtK75tfOiwGW1EVtlF4rSnCO2Wny46KA42kyNuBKr4vUIiIyxIQnsCnNqo6IKsTigxk+cNPRB0CaEwgx8j9mfswjUkHP9s8O2fsuBXIfwcXy5glj3R9IztSXsJRAaUpaPeCffN7zXRF5OKNy0x+n2CZvwQ5gzfUwhgnsDHo7EKn2QWDcYMDZCKCao2y0CbhnXP36Ix0MeCfQ==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4613.apcprd01.prod.exchangelabs.com
 (2603:1096:101:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 09:31:19 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:31:19 +0000
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
Subject: [PATCH v3 3/3] thermal: cv180x: Add cv180x thermal driver support
Date: Tue,  2 Jul 2024 09:30:26 +0000
Message-ID:
 <SEYPR01MB4221A66C30DCD324F946C33CD7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HlG6xpx/xUv4htAWsxl7H/bl9bDttrt8]
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240702093025.449-4-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cbac35-d5eb-4025-b55d-08dc9a79ba8d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	2jR9HyufcRHY23B640ZsaQJsHAfHIX7IlWHl12cGspV37x/zs/EC02zUc6TwV7Hl/9aLCH5n3afYDlothAHoqYm0S+ETvwxLaWC7NtjSsBdYkWzC9FhRn6vTcYgbd4IkfBBGy895fY2BlImhs1x83rkacbZusVh682H/9pCchbKkT6K7BrDUvl8B3JU1mI57FQUOd1b4QaDnPU/KKrJCPpzeU2yLzXeCxByp4QHTsZTmcx776jrT1lw616qW5pqnLLdlhA6kZKDLlPJZKi8iwNIN3CeNzXcFlWu8sjq/Nw4LyOomChWiVliU7dMeeK18L/zG0pyGITXGEo3z47YjSfbgkTkbvkcoM4htgkSESCa0mVmlJMDqPwuhEWFKVdqjCLK/MTKrF6/7lW5Rm5bvwr1oc2m6UxK8d/cWc7HlKZpE9Uu3HIp8g6RJyJD8WzzdDgqmtD715eGjPaVmBZFNLOo00JXpIX0yJgqiaoFpZ98zhk+frojc+xfvbiKgaLQFEle/T63NlVrXvYgO8S4jS+663Ol3anlN6XMiITdRnnZ2pbt4E+D33tb70nzhYMoR2rvZ6Cmo+89sOHRoH77rGvLV9cxCVbVAOVRsJDUHvCgV5QM1zdA6JhiisaSzgqlQKs8jQkzd+psU1c50tvCdbQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5YAShtwPTcO4lrmJZbdm//G84ujForuRqWgAdss/v6V4Wxp6V210NMVOKD+Z?=
 =?us-ascii?Q?3GvUMnBbHguMgaN/iMwAfi3UaF8sHQvlBCIE3fZpAlq146blfY/aPxWf4WDV?=
 =?us-ascii?Q?O/gDBfiZ/NzrBHqv6Dtmji6O/uwNBNSGcAHtgkIvo9KRan0UCM36i+vYxQQE?=
 =?us-ascii?Q?qOL4RXWIbCEL4jYR6AYttCYLYzJ9Co93mKbU7iDm6R6YWj+IpokNRtZjDdNm?=
 =?us-ascii?Q?swBm3R4atCwOfHXFg5e7JxjQSg/kCPJvnadNc46VX5r4v3Bv1FfQxjYizD8d?=
 =?us-ascii?Q?IeRIriVB32hhw5L67ogRo5MFomOFV5gqFsaTtU9Kvfza4AFfB381K3fwxmqo?=
 =?us-ascii?Q?Po3yJqEvQgRS+BuigHv8AyW/ZNTXcP3cR5PPMyJ69MTJS6OvxHldcy60ucND?=
 =?us-ascii?Q?FvHlMKL8cUM2vDjCCwp6yc7BJLY3r71j8W20ynWsd61Zb1jQ8AsY8QCJ4FIf?=
 =?us-ascii?Q?wxmVH3g+5mx9g3lO68AC7sPqi6qzIeKZXHW20yh0R5U+klVDP+VCamkbqqUo?=
 =?us-ascii?Q?kx6Q5uXmDjP6nLqVkpUv5PlAC83j0IHcW6vF2rzgn97AomLQjTM0OpWgaj3J?=
 =?us-ascii?Q?/aohjycuGk+n9pyAHl0swVLU9H9qKaYiABIiMGNrcXvUThgbzWmx1dm0ni2s?=
 =?us-ascii?Q?K1PDeOq+AGTNKg9pRxHupEP9rQZ80lE+m9YVnlW+DxlH7wcFnVnGhP/aLi8P?=
 =?us-ascii?Q?CFOxRPn0AKA8TmPPanYelRRrwjiOYGAjfM2egArME7dxzqVRurMH5suH4T6P?=
 =?us-ascii?Q?hCLFPpP1wWm3dW3gx5flUI8ZCTPI2grYAktAxrlBBvJyuUvagpm7DtccAYfn?=
 =?us-ascii?Q?eVcsYsx6at7eA9tO9m/8th8s7VxqCBJqQIbL3PY0Vjwi73fuzirZCkmZbNyh?=
 =?us-ascii?Q?VWNzwyu//2KGNujCwLvTzU6GClmbEbmj8YcCQsEX27JjMXlCoiOvfs9+EQ3z?=
 =?us-ascii?Q?TkPF8UT9jx2A12eSXxBAab7exLBH2SdhmQZp1Dy7YOCA3EqUd94J1mnh8VNZ?=
 =?us-ascii?Q?3sY7AQwyb/dTSpcJF5W24zHQJMat0eBKIRl4b8kNNcCm0XPiFc3H3BoOClWw?=
 =?us-ascii?Q?BY9CpFMFag29yI9V08FVO4AuciyJ4ichdsceWnteEEQIGfhpNRvR+xfBftIb?=
 =?us-ascii?Q?FwfZB+HAmJmy1H3UXSKgUuHhN70taQa/UfCnNjFmwu822n3oDKq/Ju8zp9ks?=
 =?us-ascii?Q?AJhkQq4Mq7UbS1qulF2FmctLfd/q1hW1ceeHWjusmNDGexIq8HRAbxhPY8k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cbac35-d5eb-4025-b55d-08dc9a79ba8d
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:31:19.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4613

Add support for cv180x SoCs integrated thermal sensors.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/cv180x_thermal.c | 281 +++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
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
index 000000000000..ab8f0ba8113d
--- /dev/null
+++ b/drivers/thermal/cv180x_thermal.c
@@ -0,0 +1,281 @@
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
+	u32 chop_period;
+	u32 accum_period;
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
+	regval |= ctz->chop_period << TEMPSEN_SET_CHOPSEL_OFFSET;
+	regval |= ctz->accum_period << TEMPSEN_SET_ACCSEL_OFFSET;
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
+	u32 divider = (u32)(512 * int_pow(2, ctz->accum_period));
+
+	return (result * 1000) * 716 / divider - 273000;
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
+	if (of_property_read_u32(np, "accumulation-period", &tmp)) {
+		ctz->accum_period = TEMPSEN_SET_ACCSEL_2048T;
+	} else {
+		switch (tmp) {
+		case 512:
+			ctz->accum_period = TEMPSEN_SET_ACCSEL_512T;
+			break;
+		case 1024:
+			ctz->accum_period = TEMPSEN_SET_ACCSEL_1024T;
+			break;
+		case 2048:
+			ctz->accum_period = TEMPSEN_SET_ACCSEL_2048T;
+			break;
+		case 4096:
+			ctz->accum_period = TEMPSEN_SET_ACCSEL_4096T;
+			break;
+		default:
+			dev_err(ctz->dev, "invalid accumulation period %d\n",
+				tmp);
+			return -EINVAL;
+		}
+	}
+
+	if (of_property_read_u32(np, "chop-period", &tmp)) {
+		ctz->chop_period = TEMPSEN_SET_CHOPSEL_1024T;
+	} else {
+		switch (tmp) {
+		case 128:
+			ctz->chop_period = TEMPSEN_SET_CHOPSEL_128T;
+			break;
+		case 256:
+			ctz->chop_period = TEMPSEN_SET_CHOPSEL_256T;
+			break;
+		case 512:
+			ctz->chop_period = TEMPSEN_SET_CHOPSEL_512T;
+			break;
+		case 1024:
+			ctz->chop_period = TEMPSEN_SET_CHOPSEL_1024T;
+			break;
+		default:
+			dev_err(ctz->dev, "invalid chop period %d\n", tmp);
+			return -EINVAL;
+		}
+	}
+
+	if (of_property_read_u32(np, "sample-cycle-us", &ctz->sample_cycle))
+		ctz->sample_cycle = 1000000;
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


