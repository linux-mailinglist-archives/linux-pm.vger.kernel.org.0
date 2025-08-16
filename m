Return-Path: <linux-pm+bounces-32469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1BB29033
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 21:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BDB167D09
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421820F079;
	Sat, 16 Aug 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="39GTj9CT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA793176F5;
	Sat, 16 Aug 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755371990; cv=none; b=md/QsNaVl+TiDV5/t5QL1bw46mHMFg3lQ2c4OdqlALojNflsBPeInEpTNuvrcjlCExM4WDIPPXDdadTMtdHYS30Fj8+XqwsVs8uKRd1BfZ0Flxr/l9sgipswe9zf/DKhKHCCjGhB2ifake8a4m1WubLHTN9NPsDF7lxQKa1VjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755371990; c=relaxed/simple;
	bh=S1aVej07uUM/0r7/saLaIfilRnkSKHHXX9GZewXluvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBGQ4s4t1zci0TzxwHWBJSTHQ1iayWd3YnpRR1ey+hRiebDtHMUriHWZDzCA7hLz6N05OT/KfZmAuhHJ5KewpMmHv0k8JmqEGscvRYrE6QgFgnQmr7TsgZmpMl/D0crUyKIFoe7MYXsNjeSoN3Xkr1XH5OA31a8ixpBySZfhtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=39GTj9CT; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kT7xRL+WVl9Po1BEi+z1clH1GX3ZRUp+ZCh/+O9qrs4=; b=39GTj9CTIHS51OUHLvef14QOT7
	6pD8zehOaVZu9GuVdEmqe/FDS4mt5ZuaoIp57/1lw3JWOgu+hcAC5y7d1+tgfJTDAjN25poFq6CWj
	WT+F+5taOXwnvbU7W8eIVlwmtf9QMmEAB1wZLMvarVL/IlDDe77REeemJVuDhLN0ojmMRxmT9gKdt
	re3CqxyI2P5X5XCEaMl0Uf+OGhu5rFwXGW3qVft3G8qtmk5+jQIUIEXFvrC0Lo/yGjhZG0+ClalHV
	zQKJl5muHtspTyPyStvHgDtf94SSO0bVujS5WIq6LRJmnwHzgQlNCQNVAXyPNe4uspm6nD8aGOWDS
	PFpB4RAQ==;
From: "Andreas Kemnade,,," <andreas@kemnade.info>
Date: Sat, 16 Aug 2025 21:19:14 +0200
Subject: [PATCH 1/2] mfd: bd71828, bd71815 prepare for power-supply support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-bd71828-charger-v1-1-71b11bde5c73@kemnade.info>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
In-Reply-To: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8132; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=0mMgISKSF3prfMglM+iviPvB35GuNh3+ZXTAneuc90k=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkLbp7pFXT+HLRu495Q8VaOdW6LFwrsS/3quvJMmOShQ
 z8ezfzr2FHKwiDGwSArpsjyy1rB7ZPKs9zgqRH2MHNYmUCGMHBxCsBEtkUzMpy1ZY2rT+0PT9B+
 8e9Txro1TZ7uQiHTKoTCE+T0V93bEsfwzzB8fdLyX3PUDn2+XGPjHHJBesGNwtayP9tO8sZy2U8
 R4gAA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Matti Vaittinen <mazziesaccount@gmail.com>

Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rohm-bd71828.c       | 44 +++++++++++++++++++++------
 include/linux/mfd/rohm-bd71828.h | 65 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |  2 ++
 3 files changed, 102 insertions(+), 9 deletions(-)

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
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 579e8dcfcca41d2680283819684a1014617d0d4b..5e9d0da380ec0fc3245bee998c791a162a34e3fa 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -13,9 +13,11 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD9574,
 	ROHM_CHIP_TYPE_BD9576,
 	ROHM_CHIP_TYPE_BD71815,
+	ROHM_CHIP_TYPE_BD71827,
 	ROHM_CHIP_TYPE_BD71828,
 	ROHM_CHIP_TYPE_BD71837,
 	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD71878,
 	ROHM_CHIP_TYPE_BD96801,
 	ROHM_CHIP_TYPE_BD96802,
 	ROHM_CHIP_TYPE_BD96805,

-- 
2.39.5


