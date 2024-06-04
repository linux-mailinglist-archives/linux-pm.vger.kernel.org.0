Return-Path: <linux-pm+bounces-8576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2A8FB309
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFA1F21AB5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6114884C;
	Tue,  4 Jun 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iwxAJPpg"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2052.outbound.protection.outlook.com [40.92.107.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D614882F;
	Tue,  4 Jun 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505712; cv=fail; b=UD1oQJBFPdOq0o8e0BxWlwBXBuZSoFLoosj05n5zXV6HCjoBvjktJnolKMJPmMnuK62+6tDBF3MKCGdNJoDbNr3sp8erKKNO/OXFw4OKkhGgUisESw13GkPQXB4gge6XDv/2K5mA6fX78kANMePs61lh8bbai/AFixDkuvhq92I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505712; c=relaxed/simple;
	bh=fmMgQZ/hDO5Zd1bxI8KNLB2IHdOKB0mL6ykts5hE3wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbccTQ58+iP5l/dD/jTaIdsVhtzhXWLXUjL4xtnjcqBCO0VE4Cjnlt/IJ7kZPm0sWlMvdgmUlyVWgVQCvrPkfyt2UKpmjNJayd3anVRUaGzDz624c4HdxZXl+xke4ZxU3Zq+3h1GosSXVgYgAvO6VdXYW9R/Z00R8sMIVmQ3VeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iwxAJPpg; arc=fail smtp.client-ip=40.92.107.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg1xs4ZlNJpSGnu0wWUZunPT2whfmoeOvzKAvJ5fOb0C13qrhfzPP9YalekInzaXHrxb8CrGqwdHCSEYyai/AURqiTebo6FPF1+93JiYbkrMQSEXHm8OeCDHbVURGkGPb3ihz5/Va4/rmFtDz8Leo5ACv/PlcFpGuAsKUZswNqYVWWwsuti0xMGBSt+MR7JBjSrtx0YoKfvtbVQwmmHVF3uChYWk07nSeGCi8F61+wHj/aFAwvkRgXByN9aOJnTyHk/cGMnXlomr5ozXdjrbmFD7GrDTBOLx34qILuEqsSZfHVJvBiWuRiHeNKtDiHpg3CxuQlrgaRvF4BVkEinXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx0aenlAt3/RXr+6nJ9iLWCJYs6e0mTxA+MAS0BA+PA=;
 b=lzFViOQkj0PxKvk/+ip77Dg43bNKi1yMf8XX1cZL3KW92HILoDFiyFr4e6xq+i9WxMpIoC28UeY4Oce99GAHBEV6KnsqAyYcwno4cOxv3yk1E6fkXfditsuSM58Ghngj26cEdbXT4GVhz9vkhpaMTUwgEICWsM2f7g+c0941fbPxiK+uaORuLijUsujOfLmrIj2VQCt03NjWnpREdNUMGTc0vJ1o2l+eQpfACmx72c2+kdrjoW4tm/yOvKnboiXVe0xpWfPbxTJa4K5S2rlPRLux7m3ZMwVO5GOFWP4/KSTvc0cZGJvm9pN3LqQkphQXjBpdTc+2SebIREGYHv+VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx0aenlAt3/RXr+6nJ9iLWCJYs6e0mTxA+MAS0BA+PA=;
 b=iwxAJPpgNKaIbzdAlpcUvdQkGt593M/D5EklYoZSkb7tVda70dbaTVe01PWFv6ix1i7Y8Q4z1dKoJ64eREn17glqCtdut394jU4nm1vowtxIhxamRXs81Z/c7ufD8RjjMjcOm6poiCu8gyEjSnwEq3UMpTQCnOCyJaWvkuoYVKOrQTeLMBSdq/98j5vGKxvxzpztL9K4L/ljCyoBADrEuaeHlcxOrzVyCkkS/hcb6/pik3Gn8WpyVmM6Vd6drgOuTTRvN1kEQAO6tDhh7wU0q8pHWQ/PmUR9078J2UfxhUpFeerEpzA+C6ffAFan6P7FgJcx2OjXf1ydQjSniecD/Q==
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8) by SG2PR01MB4386.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 12:55:03 +0000
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c]) by SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 12:55:03 +0000
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
Subject: [PATCH v2 3/3] thermal: cv180x: Add cv180x thermal driver support
Date: Tue,  4 Jun 2024 12:54:21 +0000
Message-ID:
 <SG2PR01MB42187EC277384F84A3126F0DD7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jYzV8WUlZZem+HhUVIccfPJ2rrcKCb+D]
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8)
X-Microsoft-Original-Message-ID: <20240604125420.22638-4-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB4218:EE_|SG2PR01MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec3ca15-df09-4b39-11af-08dc84958d1f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	58g5iBJwMgmXkrklc+q6j3fX8RsEVieO7cie01SKPu6Cdpm6KEOfE7g3A7mre+robF2qBo9Kn0vDurduvipbfUd09x6kah/N6JdqQJuGltmhse+DpWqpmR5dNU6NZC0siRMew5WQBPDhQKTe43Y4hAaeim/oMF6c4+HtYlUT3cLBRGOZUl+/7SRsayeFXJp6T5Sklw/CrOK8BC+EIGW9kzbbeAFqYAZxdR1kPTYKRRCcIPyUJvTd2gxaC7eOMYqXR/JnZgYP9kGHZha03Ml/Hhfk+kGQ39qfMNjtNMKPJSAWKNVzdzd0BGnYAyRBuhf833TqBwVY/iDtLOYyRc5Ok8YyIl8fxUurXjGuE02zOXJGitV3s+oAxUGkvjKHsTxF6lO8bdwuZYPgsRgGJIVEDqYz4FDh5jFDRgX7uvN/giiauFB+B80NZZLkrDKoAMQYBBBKj8P7W3xOnjM3inYXqe95SuBX/saIaa1eOqZ4yIqpvD5/2dlUD7DF1l2rdk8v8yG7dQYpyFntEPqL3VptxrTtcPJQ0FzPv8Bnvf3TfP7rZ7qbKxymcs/BlDmnOyPSdvWH9EGq5HHvZmgBV2xEnkJYgC7vCtABkcVrZVwWI9xmdfHv4hHscXoLJxFRgEsi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frDY9DXy5+9hP6k+9MXT8MJtaXkivddU4i2ii69vjnLFU6/jksDSeD78r6Gd?=
 =?us-ascii?Q?anomkX7dXsuQDGW/pxAvfYGvraXO3jHCD+s0I2B0hgXzYefBCJ+m1/jmnbZB?=
 =?us-ascii?Q?i9voVyzd1hU4rxKrsp2PYAn20MsdcrHsE1sOqZcYWB0tx8rKfnRzJEdzWUqr?=
 =?us-ascii?Q?SrE1rfdo2oxPP+DyAMEftq+LT/Z+URhf1vlWz0sVKwX+fgYYAPCxyp02T05h?=
 =?us-ascii?Q?t668sq1vzcTjggrErxQaw0xS03ie3gxtuJeAk5VpLMyg3T0HGZWp4l2NnKMh?=
 =?us-ascii?Q?vUYPxqQuKKycry8AUhDu9M9OA2fMa8scPAXbxjITVnKon6+fEl8yuiquK55v?=
 =?us-ascii?Q?0V6pOwn7EeCM0WjOhS2Xrb6VXurGf5LulnoFc3RC/e3617jE77l9aqEUWWvI?=
 =?us-ascii?Q?c+vo4dhrXQxcczrRjdCaWGXqohQX0wwU3O9rgyhVNJr6VcbJ+K9DHTBZ0hlm?=
 =?us-ascii?Q?lIzOxBEoyJQGjIs4Zj1O5U/ojDuj7HJHySQzREHW2t9N6/PNFPUv06VtHGau?=
 =?us-ascii?Q?z9jBVLsDCLvrWFgtW6CVzoo3jCQOFCp2kZX4jqe8vxifVfJwpEVLSdFKYpF0?=
 =?us-ascii?Q?lsIWIOK+pdjvcykwdIh6ZvEIQi4uZcb+9cKH85ZDfBssdiJmGtclk9uTVIf+?=
 =?us-ascii?Q?xs2Mbg6Ub6LE/Ib7Sg55+UwpMh94XiKS6arIETqnPSxZ1e1Rzp5NU7hdZpVn?=
 =?us-ascii?Q?u24kC0hqgYES6wlVp20/Dt59D2+s4BD13O7rUEmKJToFmoj7iCNlzubmZb/K?=
 =?us-ascii?Q?np4U+czyN3wmcC76/KkOCLPkNt+6bhg99nNpif5Orj/XlC5F6wPM9ODMF2L+?=
 =?us-ascii?Q?BQMpmxdtHOjhcQvZdZCVB045hx6+WnWjNybWos6UjFVztDKbMWzjPNJAmUxC?=
 =?us-ascii?Q?PHmfcDFIRrJk+Ft16vm8AdRuAVu/SMNSGwFf8iU6P/c3w+RP97EBSF1zv9by?=
 =?us-ascii?Q?yM/LnqJcDiHh7GAYWoyi6OY6K4oxf2t9n+MWMNl1TxBcolevi/rpSivzJRi/?=
 =?us-ascii?Q?O3bCezyUF7EfRDw8w6h0j+A80ypYAXtE5gcjtrfVCBYfmF6Pc4yX+0wKidrI?=
 =?us-ascii?Q?yULghcFagfQfk1lIpd2wiskFHLcdYTersdktnBJQejKfAo8QbLjVxzJXBjXN?=
 =?us-ascii?Q?dlVQr70/TWIZW/T8+omI9lRckXHHVV10aOfTR2iGo8vNiKqOhFg5FLZP22ny?=
 =?us-ascii?Q?/QwID4t4mKOEL2GFYdyldmE0Y42+UFGBQKbIymmpQw20oP6aLKavqYZ38p0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec3ca15-df09-4b39-11af-08dc84958d1f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB4218.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:55:03.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4386

Add support for cv180x SoCs integrated thermal sensors.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/cv180x_thermal.c | 262 +++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
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
index 000000000000..89425e2b75a2
--- /dev/null
+++ b/drivers/thermal/cv180x_thermal.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Sophgo Inc.
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
+	{ .compatible = "sophgo,cv180x-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
+
+static int
+cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
+{
+	struct device_node *np = ctz->dev->of_node;
+
+	if (of_property_read_u32(np, "accumulation-period",
+				 &ctz->accum_period)) {
+		ctz->accum_period = TEMPSEN_SET_ACCSEL_2048T;
+	} else {
+		if (ctz->accum_period < TEMPSEN_SET_ACCSEL_512T ||
+		    ctz->accum_period > TEMPSEN_SET_ACCSEL_4096T) {
+			dev_err(ctz->dev, "invalid accumulation period %d\n",
+				ctz->accum_period);
+			return -EINVAL;
+		}
+	}
+
+	if (of_property_read_u32(np, "chop-period", &ctz->chop_period)) {
+		ctz->chop_period = TEMPSEN_SET_CHOPSEL_1024T;
+	} else {
+		if (ctz->chop_period < TEMPSEN_SET_CHOPSEL_128T ||
+		    ctz->chop_period > TEMPSEN_SET_CHOPSEL_1024T) {
+			dev_err(ctz->dev, "invalid chop period %d\n",
+				ctz->chop_period);
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
+	ctz->clk_tempsen = devm_clk_get(&pdev->dev, "clk_tempsen");
+	if (IS_ERR(ctz->clk_tempsen))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
+				     "failed to get clk_tempsen\n");
+
+	clk_prepare_enable(ctz->clk_tempsen);
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
+	clk_disable_unprepare(ctz->clk_tempsen);
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


