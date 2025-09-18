Return-Path: <linux-pm+bounces-34948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE09B8361F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 09:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FD617EC57
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282F2EDD6B;
	Thu, 18 Sep 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gHEu0kWX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2D2ED167;
	Thu, 18 Sep 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181532; cv=none; b=NDx0B75O0awp7szbUe1l5fPXtjCXFg31gT77pheNzSn0i62OB9m5Oq4UCCxHGtdfRgztUlLaQe+i4G+IKz0CILH+x++CtMMPgpfj9MI7STlHSNEwxIhauTiFWmFMeJyjw3F7fLcImNK7jsQrDsl7g+oez9cKQkR84Uvh9g2WBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181532; c=relaxed/simple;
	bh=T8jSP/nM6p52WCx230tHmxgQZTrIyhdphnlgliU2MrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSn7BxS7XogrkOhRMz+JESFXRqckHXBcFgx2W/WQKwDXTbHPc4GOs5rdRpO5ZzkccTF/tVsmrLdG0J7+4aAdswy/YjKpOKpiP48jpHfsOeBR75AIPb4jptTn7izJXREPuzuci+mrEJtXvn4ELwOd2PSw/xPPtsSIj055/vHn7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gHEu0kWX; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H1DU/m8mr++CuW8Z72z0QsfexEFDp7sdws2HKxbjT+0=; b=gHEu0kWXLbidvxg5fulV4HM0Ry
	O0qJlOWRoUkFGYS/z7IJiLaAS4qE68lE8mfO2AgV064qzV5nEm3i/s7nBqwvjk6S+gYOZnwM/kram
	05bim/CnnJxqPrRPbhK3PlKjccZ+CoR+7SNJnuckgfvUpGYhPxNcvDECZk/mNALvY5u1ao/2MPt+1
	ca3n4bFHoq+ncI3NkIDr4cZVNeL7y/IRPUa3i2BQpKWMQcpl8+KjbAHq7aD5NVW9j8Fwsy+S6sDS2
	4SolrFT9ALfyEVtYY5tUh0PupVdubWvSN2bXNKThCnF8QkEPqN9bGEETjoZ7e2sRRxSc8ymadtr50
	KTGU66Xg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 18 Sep 2025 09:45:09 +0200
Subject: [PATCH v5 1/3] mfd: bd71828, bd71815 prepare for power-supply
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-bd71828-charger-v5-1-851164839c28@kemnade.info>
References: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
In-Reply-To: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=7379; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=dmgYEkH3Jz6Tq+5u+8yD7jG3DYrR4sIck3blNGqHI8g=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmnd0zmtTjG4ec7QSvau375yqcJ5nbPOuK72w6s+Sctf
 LD7ylqzjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACbiysvwP8tvVkfkhTML+/b/
 0g94bWb4lfnO9JDWZgWRnRtTRF4FmzAyfP1h+CE6/MjFhoZUp+8PZT9kLPv8pqmpqd/H1kneKcW
 YHQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rohm-bd71828.c       | 44 ++++++++++++++++++++++------
 include/linux/mfd/rohm-bd71828.h | 63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index a14b7aa69c3c6..84a64c3b9c9f5 100644
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
index ce786c96404a3..73a71ef691525 100644
--- a/include/linux/mfd/rohm-bd71828.h
+++ b/include/linux/mfd/rohm-bd71828.h
@@ -189,6 +189,69 @@ enum {
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
 
 /* LEDs */
 #define BD71828_REG_LED_CTRL		0x4A

-- 
2.47.3


