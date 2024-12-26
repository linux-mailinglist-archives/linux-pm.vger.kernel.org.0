Return-Path: <linux-pm+bounces-19746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA089FC82B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 06:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B116516286D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95772155A30;
	Thu, 26 Dec 2024 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="BmasDV4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685701547D8
	for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189831; cv=none; b=BtMdeln2FCtukjKrzblgwgnAwqlbFE5SZw4yspTiFmsOyWoKvqPJ67Ve25zgN0UrKE7ia21iPfa6i0gvNf+2forWABlUnreQsqNXXm5KbFVtJW5teShEaNTqGFEy1tWlo8uUaw08XopUV8eqP+twAHp1tp+B1bTKB7ko8BE9WnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189831; c=relaxed/simple;
	bh=RZqs5oFavr1aQBPKR718lNy76BAOemcUm4NO7oZFSAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhYy8fGlG3dspvurPzgb3SJqbFXYcNbvHHEITYiB/g8XFFTGrq9GLgU+zQw9aI1MRUJa+OFfkVhvY+wGOPsfxSzR0J2aLFy5npetyCm/89uYV6icwFtcTfwkKD6yncxqj1gwKyTtC/69WIJShDsN5Pgfb+IsmfpWCFNYj33R8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=BmasDV4u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1735189824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xySs+0TTRuFXLCn4V7fbhC5s72qrpfEbcaWQ+SM00=;
	b=BmasDV4uFwZ9KBWb8oT96gUFbUQa/+xMUYwN2NxYvEay0sJPLKx6uW33hzbkjFOOA/+rjp
	rfdggialjVqyV4ZCk0Miq+D9wz1gRgdMZ2DKEXeo/DbzpZADgsQswbDQHDnSjQe72SJS5+
	ly/rYuG27C4Lgx1mxKefGrf26MbdK3JlUGjoheTT4hVwkOeFKjbdtKhIqDeDXMB+GJIvvB
	+MOmyaJSee1D4iAzVf0A1tImjoXT4QmiZF7ZJK0tu+K7aLSAvYl1Qz488Xwe025QnFSnPJ
	DLoUb/K7HB8Chk4DqbEOFqP6gIEyW/BnkOTm9F1JEaODr8qbYNg64pJOOos68w==
From: Val Packett <val@packett.cool>
To: 
Cc: Fabien Parent <parent.f@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Val Packett <val@packett.cool>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 4/9] mfd: mt6397: Add support for MT6392 pmic
Date: Thu, 26 Dec 2024 01:58:04 -0300
Message-ID: <20241226050205.30241-5-val@packett.cool>
In-Reply-To: <20241226050205.30241-1-val@packett.cool>
References: <20241226050205.30241-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fabien Parent <parent.f@gmail.com>

Update the MT6397 MFD driver to support the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
---
 drivers/mfd/mt6397-core.c            |  43 +++
 drivers/mfd/mt6397-irq.c             |   8 +
 include/linux/mfd/mt6392/core.h      |  42 +++
 include/linux/mfd/mt6392/registers.h | 487 +++++++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h      |   1 +
 5 files changed, 581 insertions(+)
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 0e5d59ae064a6..54d655668ad8c 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/mt6357/core.h>
 #include <linux/mfd/mt6358/core.h>
 #include <linux/mfd/mt6359/core.h>
+#include <linux/mfd/mt6392/core.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6323/registers.h>
 #include <linux/mfd/mt6328/registers.h>
@@ -25,6 +26,7 @@
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6359/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/registers.h>
 
 #define MT6323_RTC_BASE		0x8000
@@ -39,6 +41,9 @@
 #define MT6358_RTC_BASE		0x0588
 #define MT6358_RTC_SIZE		0x3c
 
+#define MT6392_RTC_BASE		0x8000
+#define MT6392_RTC_SIZE		0x3e
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e
 
@@ -65,6 +70,11 @@ static const struct resource mt6358_rtc_resources[] = {
 	DEFINE_RES_IRQ(MT6358_IRQ_RTC),
 };
 
+static const struct resource mt6392_rtc_resources[] = {
+	DEFINE_RES_MEM(MT6392_RTC_BASE, MT6392_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6392_IRQ_RTC),
+};
+
 static const struct resource mt6397_rtc_resources[] = {
 	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
@@ -108,6 +118,11 @@ static const struct resource mt6331_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6331_IRQ_STATUS_HOMEKEY, "homekey"),
 };
 
+static const struct resource mt6392_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6392_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6392_IRQ_FCHRKEY, "homekey"),
+};
+
 static const struct resource mt6397_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_HOMEKEY, "homekey"),
@@ -241,6 +256,23 @@ static const struct mfd_cell mt6359_devs[] = {
 	},
 };
 
+static const struct mfd_cell mt6392_devs[] = {
+	{
+		.name = "mt6397-rtc",
+		.num_resources = ARRAY_SIZE(mt6392_rtc_resources),
+		.resources = mt6392_rtc_resources,
+		.of_compatible = "mediatek,mt6392-rtc",
+	}, {
+		.name = "mt6392-regulator",
+		.of_compatible = "mediatek,mt6392-regulator",
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6392_keys_resources),
+		.resources = mt6392_keys_resources,
+		.of_compatible = "mediatek,mt6392-keys"
+	},
+};
+
 static const struct mfd_cell mt6397_devs[] = {
 	{
 		.name = "mt6397-rtc",
@@ -323,6 +355,14 @@ static const struct chip_data mt6359_core = {
 	.irq_init = mt6358_irq_init,
 };
 
+static const struct chip_data mt6392_core = {
+	.cid_addr = MT6392_CID,
+	.cid_shift = 0,
+	.cells = mt6392_devs,
+	.cell_size = ARRAY_SIZE(mt6392_devs),
+	.irq_init = mt6397_irq_init,
+};
+
 static const struct chip_data mt6397_core = {
 	.cid_addr = MT6397_CID,
 	.cid_shift = 0,
@@ -404,6 +444,9 @@ static const struct of_device_id mt6397_of_match[] = {
 	}, {
 		.compatible = "mediatek,mt6359",
 		.data = &mt6359_core,
+	}, {
+		.compatible = "mediatek,mt6392",
+		.data = &mt6392_core,
 	}, {
 		.compatible = "mediatek,mt6397",
 		.data = &mt6397_core,
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 1310665200ede..25b16293e3937 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -15,6 +15,8 @@
 #include <linux/mfd/mt6328/registers.h>
 #include <linux/mfd/mt6331/core.h>
 #include <linux/mfd/mt6331/registers.h>
+#include <linux/mfd/mt6392/core.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 
@@ -203,6 +205,12 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 		chip->int_status[0] = MT6397_INT_STATUS0;
 		chip->int_status[1] = MT6397_INT_STATUS1;
 		break;
+	case MT6392_CHIP_ID:
+		chip->int_con[0] = MT6392_INT_CON0;
+		chip->int_con[1] = MT6392_INT_CON1;
+		chip->int_status[0] = MT6392_INT_STATUS0;
+		chip->int_status[1] = MT6392_INT_STATUS1;
+		break;
 
 	default:
 		dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);
diff --git a/include/linux/mfd/mt6392/core.h b/include/linux/mfd/mt6392/core.h
new file mode 100644
index 0000000000000..4780dab4da929
--- /dev/null
+++ b/include/linux/mfd/mt6392/core.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Chen Zhong <chen.zhong@mediatek.com>
+ */
+
+#ifndef __MFD_MT6392_CORE_H__
+#define __MFD_MT6392_CORE_H__
+
+enum mt6392_irq_numbers {
+	MT6392_IRQ_SPKL_AB = 0,
+	MT6392_IRQ_SPKL,
+	MT6392_IRQ_BAT_L,
+	MT6392_IRQ_BAT_H,
+	MT6392_IRQ_WATCHDOG,
+	MT6392_IRQ_PWRKEY,
+	MT6392_IRQ_THR_L,
+	MT6392_IRQ_THR_H,
+	MT6392_IRQ_VBATON_UNDET,
+	MT6392_IRQ_BVALID_DET,
+	MT6392_IRQ_CHRDET,
+	MT6392_IRQ_OV,
+	MT6392_IRQ_LDO = 16,
+	MT6392_IRQ_FCHRKEY,
+	MT6392_IRQ_RELEASE_PWRKEY,
+	MT6392_IRQ_RELEASE_FCHRKEY,
+	MT6392_IRQ_RTC,
+	MT6392_IRQ_VPROC,
+	MT6392_IRQ_VSYS,
+	MT6392_IRQ_VCORE,
+	MT6392_IRQ_TYPE_C_CC,
+	MT6392_IRQ_TYPEC_H_MAX,
+	MT6392_IRQ_TYPEC_H_MIN,
+	MT6392_IRQ_TYPEC_L_MAX,
+	MT6392_IRQ_TYPEC_L_MIN,
+	MT6392_IRQ_THR_MAX,
+	MT6392_IRQ_THR_MIN,
+	MT6392_IRQ_NAG_C_DLTV,
+	MT6392_IRQ_NR,
+};
+
+#endif /* __MFD_MT6392_CORE_H__ */
diff --git a/include/linux/mfd/mt6392/registers.h b/include/linux/mfd/mt6392/registers.h
new file mode 100644
index 0000000000000..4f3a6db830d1e
--- /dev/null
+++ b/include/linux/mfd/mt6392/registers.h
@@ -0,0 +1,487 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Chen Zhong <chen.zhong@mediatek.com>
+ */
+
+#ifndef __MFD_MT6392_REGISTERS_H__
+#define __MFD_MT6392_REGISTERS_H__
+
+/* PMIC Registers */
+#define MT6392_CHR_CON0                         0x0000
+#define MT6392_CHR_CON1                         0x0002
+#define MT6392_CHR_CON2                         0x0004
+#define MT6392_CHR_CON3                         0x0006
+#define MT6392_CHR_CON4                         0x0008
+#define MT6392_CHR_CON5                         0x000A
+#define MT6392_CHR_CON6                         0x000C
+#define MT6392_CHR_CON7                         0x000E
+#define MT6392_CHR_CON8                         0x0010
+#define MT6392_CHR_CON9                         0x0012
+#define MT6392_CHR_CON10                        0x0014
+#define MT6392_CHR_CON11                        0x0016
+#define MT6392_CHR_CON12                        0x0018
+#define MT6392_CHR_CON13                        0x001A
+#define MT6392_CHR_CON14                        0x001C
+#define MT6392_CHR_CON15                        0x001E
+#define MT6392_CHR_CON16                        0x0020
+#define MT6392_CHR_CON17                        0x0022
+#define MT6392_CHR_CON18                        0x0024
+#define MT6392_CHR_CON19                        0x0026
+#define MT6392_CHR_CON20                        0x0028
+#define MT6392_CHR_CON21                        0x002A
+#define MT6392_CHR_CON22                        0x002C
+#define MT6392_CHR_CON23                        0x002E
+#define MT6392_CHR_CON24                        0x0030
+#define MT6392_CHR_CON25                        0x0032
+#define MT6392_CHR_CON26                        0x0034
+#define MT6392_CHR_CON27                        0x0036
+#define MT6392_CHR_CON28                        0x0038
+#define MT6392_CHR_CON29                        0x003A
+#define MT6392_STRUP_CON0                       0x003C
+#define MT6392_STRUP_CON2                       0x003E
+#define MT6392_STRUP_CON3                       0x0040
+#define MT6392_STRUP_CON4                       0x0042
+#define MT6392_STRUP_CON5                       0x0044
+#define MT6392_STRUP_CON6                       0x0046
+#define MT6392_STRUP_CON7                       0x0048
+#define MT6392_STRUP_CON8                       0x004A
+#define MT6392_STRUP_CON9                       0x004C
+#define MT6392_STRUP_CON10                      0x004E
+#define MT6392_STRUP_CON11                      0x0050
+#define MT6392_SPK_CON0                         0x0052
+#define MT6392_SPK_CON1                         0x0054
+#define MT6392_SPK_CON2                         0x0056
+#define MT6392_SPK_CON6                         0x005E
+#define MT6392_SPK_CON7                         0x0060
+#define MT6392_SPK_CON8                         0x0062
+#define MT6392_SPK_CON9                         0x0064
+#define MT6392_SPK_CON10                        0x0066
+#define MT6392_SPK_CON11                        0x0068
+#define MT6392_SPK_CON12                        0x006A
+#define MT6392_STRUP_CON12                      0x006E
+#define MT6392_STRUP_CON13                      0x0070
+#define MT6392_STRUP_CON14                      0x0072
+#define MT6392_STRUP_CON15                      0x0074
+#define MT6392_STRUP_CON16                      0x0076
+#define MT6392_STRUP_CON17                      0x0078
+#define MT6392_STRUP_CON18                      0x007A
+#define MT6392_STRUP_CON19                      0x007C
+#define MT6392_STRUP_CON20                      0x007E
+#define MT6392_CID                              0x0100
+#define MT6392_TOP_CKPDN0                       0x0102
+#define MT6392_TOP_CKPDN0_SET                   0x0104
+#define MT6392_TOP_CKPDN0_CLR                   0x0106
+#define MT6392_TOP_CKPDN1                       0x0108
+#define MT6392_TOP_CKPDN1_SET                   0x010A
+#define MT6392_TOP_CKPDN1_CLR                   0x010C
+#define MT6392_TOP_CKPDN2                       0x010E
+#define MT6392_TOP_CKPDN2_SET                   0x0110
+#define MT6392_TOP_CKPDN2_CLR                   0x0112
+#define MT6392_TOP_RST_CON                      0x0114
+#define MT6392_TOP_RST_CON_SET                  0x0116
+#define MT6392_TOP_RST_CON_CLR                  0x0118
+#define MT6392_TOP_RST_MISC                     0x011A
+#define MT6392_TOP_RST_MISC_SET                 0x011C
+#define MT6392_TOP_RST_MISC_CLR                 0x011E
+#define MT6392_TOP_CKCON0                       0x0120
+#define MT6392_TOP_CKCON0_SET                   0x0122
+#define MT6392_TOP_CKCON0_CLR                   0x0124
+#define MT6392_TOP_CKCON1                       0x0126
+#define MT6392_TOP_CKCON1_SET                   0x0128
+#define MT6392_TOP_CKCON1_CLR                   0x012A
+#define MT6392_TOP_CKTST0                       0x012C
+#define MT6392_TOP_CKTST1                       0x012E
+#define MT6392_TOP_CKTST2                       0x0130
+#define MT6392_TEST_OUT                         0x0132
+#define MT6392_TEST_CON0                        0x0134
+#define MT6392_TEST_CON1                        0x0136
+#define MT6392_EN_STATUS0                       0x0138
+#define MT6392_EN_STATUS1                       0x013A
+#define MT6392_OCSTATUS0                        0x013C
+#define MT6392_OCSTATUS1                        0x013E
+#define MT6392_PGSTATUS                         0x0140
+#define MT6392_CHRSTATUS                        0x0142
+#define MT6392_TDSEL_CON                        0x0144
+#define MT6392_RDSEL_CON                        0x0146
+#define MT6392_SMT_CON0                         0x0148
+#define MT6392_SMT_CON1                         0x014A
+#define MT6392_DRV_CON0                         0x0152
+#define MT6392_DRV_CON1                         0x0154
+#define MT6392_INT_CON0                         0x0160
+#define MT6392_INT_CON0_SET                     0x0162
+#define MT6392_INT_CON0_CLR                     0x0164
+#define MT6392_INT_CON1                         0x0166
+#define MT6392_INT_CON1_SET                     0x0168
+#define MT6392_INT_CON1_CLR                     0x016A
+#define MT6392_INT_MISC_CON                     0x016C
+#define MT6392_INT_MISC_CON_SET                 0x016E
+#define MT6392_INT_MISC_CON_CLR                 0x0170
+#define MT6392_INT_STATUS0                      0x0172
+#define MT6392_INT_STATUS1                      0x0174
+#define MT6392_OC_GEAR_0                        0x0176
+#define MT6392_OC_GEAR_1                        0x0178
+#define MT6392_OC_GEAR_2                        0x017A
+#define MT6392_OC_CTL_VPROC                     0x017C
+#define MT6392_OC_CTL_VSYS                      0x017E
+#define MT6392_OC_CTL_VCORE                     0x0180
+#define MT6392_FQMTR_CON0                       0x0182
+#define MT6392_FQMTR_CON1                       0x0184
+#define MT6392_FQMTR_CON2                       0x0186
+#define MT6392_RG_SPI_CON                       0x0188
+#define MT6392_DEW_DIO_EN                       0x018A
+#define MT6392_DEW_READ_TEST                    0x018C
+#define MT6392_DEW_WRITE_TEST                   0x018E
+#define MT6392_DEW_CRC_SWRST                    0x0190
+#define MT6392_DEW_CRC_EN                       0x0192
+#define MT6392_DEW_CRC_VAL                      0x0194
+#define MT6392_DEW_DBG_MON_SEL                  0x0196
+#define MT6392_DEW_CIPHER_KEY_SEL               0x0198
+#define MT6392_DEW_CIPHER_IV_SEL                0x019A
+#define MT6392_DEW_CIPHER_EN                    0x019C
+#define MT6392_DEW_CIPHER_RDY                   0x019E
+#define MT6392_DEW_CIPHER_MODE                  0x01A0
+#define MT6392_DEW_CIPHER_SWRST                 0x01A2
+#define MT6392_DEW_RDDMY_NO                     0x01A4
+#define MT6392_DEW_RDATA_DLY_SEL                0x01A6
+#define MT6392_CLK_TRIM_CON0                    0x01A8
+#define MT6392_BUCK_CON0                        0x0200
+#define MT6392_BUCK_CON1                        0x0202
+#define MT6392_BUCK_CON2                        0x0204
+#define MT6392_BUCK_CON3                        0x0206
+#define MT6392_BUCK_CON4                        0x0208
+#define MT6392_BUCK_CON5                        0x020A
+#define MT6392_VPROC_CON0                       0x020C
+#define MT6392_VPROC_CON1                       0x020E
+#define MT6392_VPROC_CON2                       0x0210
+#define MT6392_VPROC_CON3                       0x0212
+#define MT6392_VPROC_CON4                       0x0214
+#define MT6392_VPROC_CON5                       0x0216
+#define MT6392_VPROC_CON7                       0x021A
+#define MT6392_VPROC_CON8                       0x021C
+#define MT6392_VPROC_CON9                       0x021E
+#define MT6392_VPROC_CON10                      0x0220
+#define MT6392_VPROC_CON11                      0x0222
+#define MT6392_VPROC_CON12                      0x0224
+#define MT6392_VPROC_CON13                      0x0226
+#define MT6392_VPROC_CON14                      0x0228
+#define MT6392_VPROC_CON15                      0x022A
+#define MT6392_VPROC_CON18                      0x0230
+#define MT6392_VSYS_CON0                        0x0232
+#define MT6392_VSYS_CON1                        0x0234
+#define MT6392_VSYS_CON2                        0x0236
+#define MT6392_VSYS_CON3                        0x0238
+#define MT6392_VSYS_CON4                        0x023A
+#define MT6392_VSYS_CON5                        0x023C
+#define MT6392_VSYS_CON7                        0x0240
+#define MT6392_VSYS_CON8                        0x0242
+#define MT6392_VSYS_CON9                        0x0244
+#define MT6392_VSYS_CON10                       0x0246
+#define MT6392_VSYS_CON11                       0x0248
+#define MT6392_VSYS_CON12                       0x024A
+#define MT6392_VSYS_CON13                       0x024C
+#define MT6392_VSYS_CON14                       0x024E
+#define MT6392_VSYS_CON15                       0x0250
+#define MT6392_VSYS_CON18                       0x0256
+#define MT6392_BUCK_OC_CON0                     0x0258
+#define MT6392_BUCK_OC_CON1                     0x025A
+#define MT6392_BUCK_OC_CON2                     0x025C
+#define MT6392_BUCK_OC_CON3                     0x025E
+#define MT6392_BUCK_OC_CON4                     0x0260
+#define MT6392_BUCK_OC_VPROC_CON0               0x0262
+#define MT6392_BUCK_OC_VCORE_CON0               0x0264
+#define MT6392_BUCK_OC_VSYS_CON0                0x0266
+#define MT6392_BUCK_ANA_MON_CON0                0x0268
+#define MT6392_BUCK_EFUSE_OC_CON0               0x026A
+#define MT6392_VCORE_CON0                       0x0300
+#define MT6392_VCORE_CON1                       0x0302
+#define MT6392_VCORE_CON2                       0x0304
+#define MT6392_VCORE_CON3                       0x0306
+#define MT6392_VCORE_CON4                       0x0308
+#define MT6392_VCORE_CON5                       0x030A
+#define MT6392_VCORE_CON7                       0x030E
+#define MT6392_VCORE_CON8                       0x0310
+#define MT6392_VCORE_CON9                       0x0312
+#define MT6392_VCORE_CON10                      0x0314
+#define MT6392_VCORE_CON11                      0x0316
+#define MT6392_VCORE_CON12                      0x0318
+#define MT6392_VCORE_CON13                      0x031A
+#define MT6392_VCORE_CON14                      0x031C
+#define MT6392_VCORE_CON15                      0x031E
+#define MT6392_VCORE_CON18                      0x0324
+#define MT6392_BUCK_K_CON0                      0x032A
+#define MT6392_BUCK_K_CON1                      0x032C
+#define MT6392_BUCK_K_CON2                      0x032E
+#define MT6392_ANALDO_CON0                      0x0400
+#define MT6392_ANALDO_CON1                      0x0402
+#define MT6392_ANALDO_CON2                      0x0404
+#define MT6392_ANALDO_CON3                      0x0406
+#define MT6392_ANALDO_CON4                      0x0408
+#define MT6392_ANALDO_CON6                      0x040C
+#define MT6392_ANALDO_CON7                      0x040E
+#define MT6392_ANALDO_CON8                      0x0410
+#define MT6392_ANALDO_CON10                     0x0412
+#define MT6392_ANALDO_CON15                     0x0414
+#define MT6392_ANALDO_CON16                     0x0416
+#define MT6392_ANALDO_CON17                     0x0418
+#define MT6392_ANALDO_CON21                     0x0420
+#define MT6392_ANALDO_CON22                     0x0422
+#define MT6392_ANALDO_CON23                     0x0424
+#define MT6392_ANALDO_CON24                     0x0426
+#define MT6392_ANALDO_CON25                     0x0428
+#define MT6392_ANALDO_CON26                     0x042A
+#define MT6392_ANALDO_CON27                     0x042C
+#define MT6392_ANALDO_CON28                     0x042E
+#define MT6392_ANALDO_CON29                     0x0430
+#define MT6392_DIGLDO_CON0                      0x0500
+#define MT6392_DIGLDO_CON2                      0x0502
+#define MT6392_DIGLDO_CON3                      0x0504
+#define MT6392_DIGLDO_CON5                      0x0506
+#define MT6392_DIGLDO_CON6                      0x0508
+#define MT6392_DIGLDO_CON7                      0x050A
+#define MT6392_DIGLDO_CON8                      0x050C
+#define MT6392_DIGLDO_CON10                     0x0510
+#define MT6392_DIGLDO_CON11                     0x0512
+#define MT6392_DIGLDO_CON12                     0x0514
+#define MT6392_DIGLDO_CON15                     0x051A
+#define MT6392_DIGLDO_CON20                     0x0524
+#define MT6392_DIGLDO_CON21                     0x0526
+#define MT6392_DIGLDO_CON23                     0x0528
+#define MT6392_DIGLDO_CON24                     0x052A
+#define MT6392_DIGLDO_CON26                     0x052C
+#define MT6392_DIGLDO_CON27                     0x052E
+#define MT6392_DIGLDO_CON28                     0x0530
+#define MT6392_DIGLDO_CON29                     0x0532
+#define MT6392_DIGLDO_CON30                     0x0534
+#define MT6392_DIGLDO_CON31                     0x0536
+#define MT6392_DIGLDO_CON32                     0x0538
+#define MT6392_DIGLDO_CON33                     0x053A
+#define MT6392_DIGLDO_CON36                     0x0540
+#define MT6392_DIGLDO_CON41                     0x0546
+#define MT6392_DIGLDO_CON44                     0x054C
+#define MT6392_DIGLDO_CON47                     0x0552
+#define MT6392_DIGLDO_CON48                     0x0554
+#define MT6392_DIGLDO_CON49                     0x0556
+#define MT6392_DIGLDO_CON50                     0x0558
+#define MT6392_DIGLDO_CON51                     0x055A
+#define MT6392_DIGLDO_CON52                     0x055C
+#define MT6392_DIGLDO_CON53                     0x055E
+#define MT6392_DIGLDO_CON54                     0x0560
+#define MT6392_DIGLDO_CON55                     0x0562
+#define MT6392_DIGLDO_CON56                     0x0564
+#define MT6392_DIGLDO_CON57                     0x0566
+#define MT6392_DIGLDO_CON58                     0x0568
+#define MT6392_DIGLDO_CON59                     0x056A
+#define MT6392_DIGLDO_CON60                     0x056C
+#define MT6392_DIGLDO_CON61                     0x056E
+#define MT6392_DIGLDO_CON62                     0x0570
+#define MT6392_DIGLDO_CON63                     0x0572
+#define MT6392_EFUSE_CON0                       0x0600
+#define MT6392_EFUSE_CON1                       0x0602
+#define MT6392_EFUSE_CON2                       0x0604
+#define MT6392_EFUSE_CON3                       0x0606
+#define MT6392_EFUSE_CON4                       0x0608
+#define MT6392_EFUSE_CON5                       0x060A
+#define MT6392_EFUSE_CON6                       0x060C
+#define MT6392_EFUSE_VAL_0_15                   0x060E
+#define MT6392_EFUSE_VAL_16_31                  0x0610
+#define MT6392_EFUSE_VAL_32_47                  0x0612
+#define MT6392_EFUSE_VAL_48_63                  0x0614
+#define MT6392_EFUSE_VAL_64_79                  0x0616
+#define MT6392_EFUSE_VAL_80_95                  0x0618
+#define MT6392_EFUSE_VAL_96_111                 0x061A
+#define MT6392_EFUSE_VAL_112_127                0x061C
+#define MT6392_EFUSE_VAL_128_143                0x061E
+#define MT6392_EFUSE_VAL_144_159                0x0620
+#define MT6392_EFUSE_VAL_160_175                0x0622
+#define MT6392_EFUSE_VAL_176_191                0x0624
+#define MT6392_EFUSE_VAL_192_207                0x0626
+#define MT6392_EFUSE_VAL_208_223                0x0628
+#define MT6392_EFUSE_VAL_224_239                0x062A
+#define MT6392_EFUSE_VAL_240_255                0x062C
+#define MT6392_EFUSE_VAL_256_271                0x062E
+#define MT6392_EFUSE_VAL_272_287                0x0630
+#define MT6392_EFUSE_VAL_288_303                0x0632
+#define MT6392_EFUSE_VAL_304_319                0x0634
+#define MT6392_EFUSE_VAL_320_335                0x0636
+#define MT6392_EFUSE_VAL_336_351                0x0638
+#define MT6392_EFUSE_VAL_352_367                0x063A
+#define MT6392_EFUSE_VAL_368_383                0x063C
+#define MT6392_EFUSE_VAL_384_399                0x063E
+#define MT6392_EFUSE_VAL_400_415                0x0640
+#define MT6392_EFUSE_VAL_416_431                0x0642
+#define MT6392_RTC_MIX_CON0                     0x0644
+#define MT6392_RTC_MIX_CON1                     0x0646
+#define MT6392_EFUSE_VAL_432_447                0x0648
+#define MT6392_EFUSE_VAL_448_463                0x064A
+#define MT6392_EFUSE_VAL_464_479                0x064C
+#define MT6392_EFUSE_VAL_480_495                0x064E
+#define MT6392_EFUSE_VAL_496_511                0x0650
+#define MT6392_EFUSE_DOUT_0_15                  0x0652
+#define MT6392_EFUSE_DOUT_16_31                 0x0654
+#define MT6392_EFUSE_DOUT_32_47                 0x0656
+#define MT6392_EFUSE_DOUT_48_63                 0x0658
+#define MT6392_EFUSE_DOUT_64_79                 0x065A
+#define MT6392_EFUSE_DOUT_80_95                 0x065C
+#define MT6392_EFUSE_DOUT_96_111                0x065E
+#define MT6392_EFUSE_DOUT_112_127               0x0660
+#define MT6392_EFUSE_DOUT_128_143               0x0662
+#define MT6392_EFUSE_DOUT_144_159               0x0664
+#define MT6392_EFUSE_DOUT_160_175               0x0666
+#define MT6392_EFUSE_DOUT_176_191               0x0668
+#define MT6392_EFUSE_DOUT_192_207               0x066A
+#define MT6392_EFUSE_DOUT_208_223               0x066C
+#define MT6392_EFUSE_DOUT_224_239               0x066E
+#define MT6392_EFUSE_DOUT_240_255               0x0670
+#define MT6392_EFUSE_DOUT_256_271               0x0672
+#define MT6392_EFUSE_DOUT_272_287               0x0674
+#define MT6392_EFUSE_DOUT_288_303               0x0676
+#define MT6392_EFUSE_DOUT_304_319               0x0678
+#define MT6392_EFUSE_DOUT_320_335               0x067A
+#define MT6392_EFUSE_DOUT_336_351               0x067C
+#define MT6392_EFUSE_DOUT_352_367               0x067E
+#define MT6392_EFUSE_DOUT_368_383               0x0680
+#define MT6392_EFUSE_DOUT_384_399               0x0682
+#define MT6392_EFUSE_DOUT_400_415               0x0684
+#define MT6392_EFUSE_DOUT_416_431               0x0686
+#define MT6392_EFUSE_DOUT_432_447               0x0688
+#define MT6392_EFUSE_DOUT_448_463               0x068A
+#define MT6392_EFUSE_DOUT_464_479               0x068C
+#define MT6392_EFUSE_DOUT_480_495               0x068E
+#define MT6392_EFUSE_DOUT_496_511               0x0690
+#define MT6392_EFUSE_CON7                       0x0692
+#define MT6392_EFUSE_CON8                       0x0694
+#define MT6392_EFUSE_CON9                       0x0696
+#define MT6392_AUXADC_ADC0                      0x0700
+#define MT6392_AUXADC_ADC1                      0x0702
+#define MT6392_AUXADC_ADC2                      0x0704
+#define MT6392_AUXADC_ADC3                      0x0706
+#define MT6392_AUXADC_ADC4                      0x0708
+#define MT6392_AUXADC_ADC5                      0x070A
+#define MT6392_AUXADC_ADC6                      0x070C
+#define MT6392_AUXADC_ADC7                      0x070E
+#define MT6392_AUXADC_ADC8                      0x0710
+#define MT6392_AUXADC_ADC9                      0x0712
+#define MT6392_AUXADC_ADC10                     0x0714
+#define MT6392_AUXADC_ADC11                     0x0716
+#define MT6392_AUXADC_ADC12                     0x0718
+#define MT6392_AUXADC_ADC13                     0x071A
+#define MT6392_AUXADC_ADC14                     0x071C
+#define MT6392_AUXADC_ADC15                     0x071E
+#define MT6392_AUXADC_ADC16                     0x0720
+#define MT6392_AUXADC_ADC17                     0x0722
+#define MT6392_AUXADC_ADC18                     0x0724
+#define MT6392_AUXADC_ADC19                     0x0726
+#define MT6392_AUXADC_ADC20                     0x0728
+#define MT6392_AUXADC_ADC21                     0x072A
+#define MT6392_AUXADC_ADC22                     0x072C
+#define MT6392_AUXADC_STA0                      0x072E
+#define MT6392_AUXADC_STA1                      0x0730
+#define MT6392_AUXADC_RQST0                     0x0732
+#define MT6392_AUXADC_RQST0_SET                 0x0734
+#define MT6392_AUXADC_RQST0_CLR                 0x0736
+#define MT6392_AUXADC_CON0                      0x0738
+#define MT6392_AUXADC_CON0_SET                  0x073A
+#define MT6392_AUXADC_CON0_CLR                  0x073C
+#define MT6392_AUXADC_CON1                      0x073E
+#define MT6392_AUXADC_CON2                      0x0740
+#define MT6392_AUXADC_CON3                      0x0742
+#define MT6392_AUXADC_CON4                      0x0744
+#define MT6392_AUXADC_CON5                      0x0746
+#define MT6392_AUXADC_CON6                      0x0748
+#define MT6392_AUXADC_CON7                      0x074A
+#define MT6392_AUXADC_CON8                      0x074C
+#define MT6392_AUXADC_CON9                      0x074E
+#define MT6392_AUXADC_CON10                     0x0750
+#define MT6392_AUXADC_CON11                     0x0752
+#define MT6392_AUXADC_CON12                     0x0754
+#define MT6392_AUXADC_CON13                     0x0756
+#define MT6392_AUXADC_CON14                     0x0758
+#define MT6392_AUXADC_CON15                     0x075A
+#define MT6392_AUXADC_CON16                     0x075C
+#define MT6392_AUXADC_AUTORPT0                  0x075E
+#define MT6392_AUXADC_LBAT0                     0x0760
+#define MT6392_AUXADC_LBAT1                     0x0762
+#define MT6392_AUXADC_LBAT2                     0x0764
+#define MT6392_AUXADC_LBAT3                     0x0766
+#define MT6392_AUXADC_LBAT4                     0x0768
+#define MT6392_AUXADC_LBAT5                     0x076A
+#define MT6392_AUXADC_LBAT6                     0x076C
+#define MT6392_AUXADC_THR0                      0x076E
+#define MT6392_AUXADC_THR1                      0x0770
+#define MT6392_AUXADC_THR2                      0x0772
+#define MT6392_AUXADC_THR3                      0x0774
+#define MT6392_AUXADC_THR4                      0x0776
+#define MT6392_AUXADC_THR5                      0x0778
+#define MT6392_AUXADC_THR6                      0x077A
+#define MT6392_AUXADC_EFUSE0                    0x077C
+#define MT6392_AUXADC_EFUSE1                    0x077E
+#define MT6392_AUXADC_EFUSE2                    0x0780
+#define MT6392_AUXADC_EFUSE3                    0x0782
+#define MT6392_AUXADC_EFUSE4                    0x0784
+#define MT6392_AUXADC_EFUSE5                    0x0786
+#define MT6392_AUXADC_NAG_0                     0x0788
+#define MT6392_AUXADC_NAG_1                     0x078A
+#define MT6392_AUXADC_NAG_2                     0x078C
+#define MT6392_AUXADC_NAG_3                     0x078E
+#define MT6392_AUXADC_NAG_4                     0x0790
+#define MT6392_AUXADC_NAG_5                     0x0792
+#define MT6392_AUXADC_NAG_6                     0x0794
+#define MT6392_AUXADC_NAG_7                     0x0796
+#define MT6392_AUXADC_NAG_8                     0x0798
+#define MT6392_AUXADC_TYPEC_H_1                 0x079A
+#define MT6392_AUXADC_TYPEC_H_2                 0x079C
+#define MT6392_AUXADC_TYPEC_H_3                 0x079E
+#define MT6392_AUXADC_TYPEC_H_4                 0x07A0
+#define MT6392_AUXADC_TYPEC_H_5                 0x07A2
+#define MT6392_AUXADC_TYPEC_H_6                 0x07A4
+#define MT6392_AUXADC_TYPEC_H_7                 0x07A6
+#define MT6392_AUXADC_TYPEC_L_1                 0x07A8
+#define MT6392_AUXADC_TYPEC_L_2                 0x07AA
+#define MT6392_AUXADC_TYPEC_L_3                 0x07AC
+#define MT6392_AUXADC_TYPEC_L_4                 0x07AE
+#define MT6392_AUXADC_TYPEC_L_5                 0x07B0
+#define MT6392_AUXADC_TYPEC_L_6                 0x07B2
+#define MT6392_AUXADC_TYPEC_L_7                 0x07B4
+#define MT6392_AUXADC_NAG_9                     0x07B6
+#define MT6392_TYPE_C_PHY_RG_0                  0x0800
+#define MT6392_TYPE_C_PHY_RG_CC_RESERVE_CSR     0x0802
+#define MT6392_TYPE_C_VCMP_CTRL                 0x0804
+#define MT6392_TYPE_C_CTRL                      0x0806
+#define MT6392_TYPE_C_CC_SW_CTRL                0x080a
+#define MT6392_TYPE_C_CC_VOL_PERIODIC_MEAS_VAL  0x080c
+#define MT6392_TYPE_C_CC_VOL_DEBOUNCE_CNT_VAL   0x080e
+#define MT6392_TYPE_C_DRP_SRC_CNT_VAL_0         0x0810
+#define MT6392_TYPE_C_DRP_SNK_CNT_VAL_0         0x0814
+#define MT6392_TYPE_C_DRP_TRY_CNT_VAL_0         0x0818
+#define MT6392_TYPE_C_CC_SRC_DEFAULT_DAC_VAL    0x0820
+#define MT6392_TYPE_C_CC_SRC_15_DAC_VAL         0x0822
+#define MT6392_TYPE_C_CC_SRC_30_DAC_VAL         0x0824
+#define MT6392_TYPE_C_CC_SNK_DAC_VAL_0          0x0828
+#define MT6392_TYPE_C_CC_SNK_DAC_VAL_1          0x082a
+#define MT6392_TYPE_C_INTR_EN_0                 0x0830
+#define MT6392_TYPE_C_INTR_EN_2                 0x0834
+#define MT6392_TYPE_C_INTR_0                    0x0838
+#define MT6392_TYPE_C_INTR_2                    0x083C
+#define MT6392_TYPE_C_CC_STATUS                 0x0840
+#define MT6392_TYPE_C_PWR_STATUS                0x0842
+#define MT6392_TYPE_C_PHY_RG_CC1_RESISTENCE_0   0x0844
+#define MT6392_TYPE_C_PHY_RG_CC1_RESISTENCE_1   0x0846
+#define MT6392_TYPE_C_PHY_RG_CC2_RESISTENCE_0   0x0848
+#define MT6392_TYPE_C_PHY_RG_CC2_RESISTENCE_1   0x084a
+#define MT6392_TYPE_C_CC_SW_FORCE_MODE_ENABLE_0 0x0860
+#define MT6392_TYPE_C_CC_SW_FORCE_MODE_VAL_0    0x0864
+#define MT6392_TYPE_C_CC_SW_FORCE_MODE_VAL_1    0x0866
+#define MT6392_TYPE_C_CC_SW_FORCE_MODE_ENABLE_1 0x0868
+#define MT6392_TYPE_C_CC_SW_FORCE_MODE_VAL_2    0x086c
+#define MT6392_TYPE_C_CC_DAC_CALI_CTRL          0x0870
+#define MT6392_TYPE_C_CC_DAC_CALI_RESULT        0x0872
+#define MT6392_TYPE_C_DEBUG_PORT_SELECT_0       0x0880
+#define MT6392_TYPE_C_DEBUG_PORT_SELECT_1       0x0882
+#define MT6392_TYPE_C_DEBUG_MODE_SELECT         0x0884
+#define MT6392_TYPE_C_DEBUG_OUT_READ_0          0x0888
+#define MT6392_TYPE_C_DEBUG_OUT_READ_1          0x088a
+#define MT6392_TYPE_C_SW_DEBUG_PORT_0           0x088c
+#define MT6392_TYPE_C_SW_DEBUG_PORT_1           0x088e
+
+#endif /* __MFD_MT6392_REGISTERS_H__ */
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index b774c3a4bb62e..d665d07770658 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -20,6 +20,7 @@ enum chip_id {
 	MT6359_CHIP_ID = 0x59,
 	MT6366_CHIP_ID = 0x66,
 	MT6391_CHIP_ID = 0x91,
+	MT6392_CHIP_ID = 0x92,
 	MT6397_CHIP_ID = 0x97,
 };
 
-- 
2.47.1


