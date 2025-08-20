Return-Path: <linux-pm+bounces-32741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19776B2E663
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77A3B49A8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748A2BE632;
	Wed, 20 Aug 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GynV4dDJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913029CB24;
	Wed, 20 Aug 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721316; cv=none; b=UcAHr98G1frMljLRJtLVUTVPgLfkQrOVzVzymubSLJ5su0HWo3b20Kr3e1qYC6n/tbUcLo6W9csea3AdmOGIboBIjJXVrhVLJXNVM2G4pWGMo/HNsoqOIc2p1lTJxyauD0HMM+jcYv7/RexjagntjewzzUctJK2X8j0+m1wdJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721316; c=relaxed/simple;
	bh=2Hr8LHAL96NqaKyAhZRmlXWs5MoPjloZMMNZXVzUsFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOcxhnByoXUFSLWHZrpmnLaxK0HxAh9siv9Pt7vedBrP/lL0Ze67HwDGAsLfQy81iiqFUEshKQgjITM/FzIWm4jzJ6KUsvNLsyIZxBD/z3mgRUXvlUC3l+5zfKN4Nii2bqzbHMP9mgmG19a+m9WVZxltYcQZ7zwk0ZTK7AGMKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GynV4dDJ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uUT06SzSpCdarCIJCU6DkRMy7hx81bd824y38SJh07M=; b=GynV4dDJ3CiF+e+xaBiRL1oNX+
	HyHkmYfcz14MlwzRKYnUFqNdKMUwQJ8ZldxENGgZc5p0LpsIesv8bwmK4/UAZaGbzPvNsgeUKa3XD
	L45RWn5+xQxdWYAEG71lsAyXS9FOVJpTlJMJzEdwWgePRL+DqZcBERPptYFqYhiNrgzu2i9iux28V
	MnKivE13xMMRLC27lGtfoTfXrw53bHTSzyOqTbidAOAewbGeE0QcN09BgFPFCsaultj0c0Pipg42W
	WHItqFRJABmQe3VQzeDmqRfrA1eYV9xQBk+8A0trhRU3AL/7Lwn3RKAKME5mnCRNJFQlYdXjhgC+9
	pzzSFMkA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 20 Aug 2025 22:21:40 +0200
Subject: [PATCH v2 1/2] mfd: bd71828, bd71815 prepare for power-supply
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-bd71828-charger-v2-1-32fc96027e92@kemnade.info>
References: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
In-Reply-To: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7493; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=yC5/Ut5rquUTk2tPRk8Kxkqh7fmpgl02vxV1Kk+OMxk=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBnL9GK05jD//HqirDpryXsbSzbdQzMEW2X7naunv+9/e
 1Wg8tG7jlIWBjEOBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACZSGMTI8KeY64bCpIeq7+fp
 TGtqt1KONVEMt3nGGHBrJ2+Bi83Wu4wMd3abXCjY23xtZt1To3iTTrXkpZUZnDUPGfzUDScImgm
 xAAA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Matti Vaittinen <mazziesaccount@gmail.com>

Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rohm-bd71828.c       | 44 +++++++++++++++++++++------
 include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index a14b7aa69c3c61d51f2aeeae9afdf222310d63e3..84a64c3b9c9f52e663855c89ed78ede9a7c21f55 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -45,8 +45,8 @@ static const struct resource bd71828_rtc_irqs[] = {
 
 static const struct resource bd71815_power_irqs[] = {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_RMV, "bd71815-dcin-rmv"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-clps-out"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-clps-in"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-dcin-clps-out"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_IN, "bd71815-dcin-clps-in"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_RES, "bd71815-dcin-ovp-res"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_OVP_DET, "bd71815-dcin-ovp-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_MON_RES, "bd71815-dcin-mon-res"),
@@ -56,7 +56,7 @@ static const struct resource bd71815_power_irqs[] = {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_RES, "bd71815-vsys-low-res"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_LOW_DET, "bd71815-vsys-low-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_DET, "bd71815-vsys-mon-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TEMP, "bd71815-chg-wdg-temp"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_WDG_TIME, "bd71815-chg-wdg"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CHG_RECHARGE_RES, "bd71815-rechg-res"),
@@ -87,10 +87,10 @@ static const struct resource bd71815_power_irqs[] = {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_2_DET, "bd71815-bat-oc2-det"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_RES, "bd71815-bat-oc3-res"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_BAT_OVER_CURR_3_DET, "bd71815-bat-oc3-det"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-bat-low-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-bat-low-det"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-bat-hi-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-bat-hi-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_RES, "bd71815-temp-bat-low-res"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_LOW_DET, "bd71815-temp-bat-low-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_RES, "bd71815-temp-bat-hi-res"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_TEMP_BAT_HI_DET, "bd71815-temp-bat-hi-det"),
 };
 
 static const struct mfd_cell bd71815_mfd_cells[] = {
@@ -109,7 +109,30 @@ static const struct mfd_cell bd71815_mfd_cells[] = {
 	},
 };
 
-static const struct mfd_cell bd71828_mfd_cells[] = {
+static const struct resource bd71828_power_irqs[] = {
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_CHG_TOPOFF_TO_DONE,
+			     "bd71828-chg-done"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_DET, "bd71828-pwr-dcin-in"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_DCIN_RMV, "bd71828-pwr-dcin-out"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_RES,
+			     "bd71828-vbat-normal"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_BAT_LOW_VOLT_DET, "bd71828-vbat-low"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_DET, "bd71828-btemp-hi"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_HI_RES, "bd71828-btemp-cool"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_DET, "bd71828-btemp-lo"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_BAT_LOW_RES,
+			     "bd71828-btemp-warm"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_DET,
+			     "bd71828-temp-hi"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_VF_RES,
+			     "bd71828-temp-norm"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_DET,
+			     "bd71828-temp-125-over"),
+	DEFINE_RES_IRQ_NAMED(BD71828_INT_TEMP_CHIP_OVER_125_RES,
+			     "bd71828-temp-125-under"),
+};
+
+static struct mfd_cell bd71828_mfd_cells[] = {
 	{ .name = "bd71828-pmic", },
 	{ .name = "bd71828-gpio", },
 	{ .name = "bd71828-led", .of_compatible = "rohm,bd71828-leds" },
@@ -118,8 +141,11 @@ static const struct mfd_cell bd71828_mfd_cells[] = {
 	 * BD70528 clock gate are the register address and mask.
 	 */
 	{ .name = "bd71828-clk", },
-	{ .name = "bd71827-power", },
 	{
+		.name = "bd71828-power",
+		.resources = bd71828_power_irqs,
+		.num_resources = ARRAY_SIZE(bd71828_power_irqs),
+	}, {
 		.name = "bd71828-rtc",
 		.resources = bd71828_rtc_irqs,
 		.num_resources = ARRAY_SIZE(bd71828_rtc_irqs),
diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
index ce786c96404a3dc9d5124ffbbd507df89ca0e5ba..a34991984caa8724e925f1c59de4bcfa543ae411 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -189,6 +189,71 @@ enum {
 /* Charger/Battey */
 #define BD71828_REG_CHG_STATE		0x65
 #define BD71828_REG_CHG_FULL		0xd2
+#define BD71828_REG_CHG_EN		0x6F
+#define BD71828_REG_DCIN_STAT		0x68
+#define BD71828_MASK_DCIN_DET		0x01
+#define BD71828_REG_VDCIN_U		0x9c
+#define BD71828_MASK_CHG_EN		0x01
+#define BD71828_CHG_MASK_DCIN_U		0x0f
+#define BD71828_REG_BAT_STAT		0x67
+#define BD71828_REG_BAT_TEMP		0x6c
+#define BD71828_MASK_BAT_TEMP		0x07
+#define BD71828_BAT_TEMP_OPEN		0x07
+#define BD71828_MASK_BAT_DET		0x20
+#define BD71828_MASK_BAT_DET_DONE	0x10
+#define BD71828_REG_CHG_STATE		0x65
+#define BD71828_REG_VBAT_U		0x8c
+#define BD71828_MASK_VBAT_U		0x0f
+#define BD71828_REG_VBAT_REX_AVG_U	0x92
+
+#define BD71828_REG_OCV_PWRON_U		0x8A
+
+#define BD71828_REG_VBAT_MIN_AVG_U	0x8e
+#define BD71828_REG_VBAT_MIN_AVG_L	0x8f
+
+#define BD71828_REG_CC_CNT3		0xb5
+#define BD71828_REG_CC_CNT2		0xb6
+#define BD71828_REG_CC_CNT1		0xb7
+#define BD71828_REG_CC_CNT0		0xb8
+#define BD71828_REG_CC_CURCD_AVG_U	0xb2
+#define BD71828_MASK_CC_CURCD_AVG_U	0x3f
+#define BD71828_MASK_CC_CUR_DIR		0x80
+#define BD71828_REG_VM_BTMP_U		0xa1
+#define BD71828_REG_VM_BTMP_L		0xa2
+#define BD71828_MASK_VM_BTMP_U		0x0f
+#define BD71828_REG_COULOMB_CTRL	0xc4
+#define BD71828_REG_COULOMB_CTRL2	0xd2
+#define BD71828_MASK_REX_CC_CLR		0x01
+#define BD71828_MASK_FULL_CC_CLR	0x10
+#define BD71828_REG_CC_CNT_FULL3	0xbd
+#define BD71828_REG_CC_CNT_CHG3		0xc1
+
+#define BD71828_REG_VBAT_INITIAL1_U	0x86
+#define BD71828_REG_VBAT_INITIAL1_L	0x87
+
+#define BD71828_REG_VBAT_INITIAL2_U	0x88
+#define BD71828_REG_VBAT_INITIAL2_L	0x89
+
+#define BD71828_REG_IBAT_U		0xb0
+#define BD71828_REG_IBAT_L		0xb1
+
+#define BD71828_REG_IBAT_AVG_U		0xb2
+#define BD71828_REG_IBAT_AVG_L		0xb3
+
+#define BD71828_REG_VSYS_AVG_U		0x96
+#define BD71828_REG_VSYS_AVG_L		0x97
+#define BD71828_REG_VSYS_MIN_AVG_U	0x98
+#define BD71828_REG_VSYS_MIN_AVG_L	0x99
+#define BD71828_REG_CHG_SET1		0x75
+#define BD71828_REG_ALM_VBAT_LIMIT_U	0xaa
+#define BD71828_REG_BATCAP_MON_LIMIT_U	0xcc
+#define BD71828_REG_CONF		0x64
+
+#define BD71828_REG_DCIN_CLPS		0x71
+
+#define BD71828_REG_MEAS_CLEAR		0xaf
+
+
 
 /* LEDs */
 #define BD71828_REG_LED_CTRL		0x4A

-- 
2.39.5


