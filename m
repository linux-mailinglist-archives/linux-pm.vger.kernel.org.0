Return-Path: <linux-pm+bounces-17308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4F9C392F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B052820A8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B9170A03;
	Mon, 11 Nov 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ZlTzFEiM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016215F330;
	Mon, 11 Nov 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311283; cv=none; b=efJi/LldFVf0rp/cRFePTZqN9DcHlvAWV6ApXoTHvHKcYCP/DiWw7IfBTfwFqv37K/TaulWZU73u4DQGCt/lsPwSKlaqRaDGMlr4tdfLTQQXLL4/Snwjwpfv60hSUTbbnD2gLrmL+X6qSSuPRuD7ThLGl301Q7FyxXKrkrDmgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311283; c=relaxed/simple;
	bh=bLf0tpsER3DpJxb6HgrPCfaVeQxqDeqp2fPkip5+6JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnmWX8zEH2oHZR+7Aw9nxgmmhhAc4Hd4Bd7AgjwdSADXqDDA6pvNbKN3fuPLLurCugvtjcKh56Gu/4xbezQZUFE7eRy30cjuZyr0OoCeg1Bv3PVIZwr8KWq1s6sVKZBi1kpIQQY+5F2ZF3Q4j/rSA8J/CiJgadg4aKhzXyrCcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ZlTzFEiM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 43B95A07D9;
	Mon, 11 Nov 2024 08:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=OpE54i3OG//fb3hHcIkY
	0cXwBz7J9rOx1NhY0ezsVyg=; b=ZlTzFEiM1i+LJwdiL8WqbWvcEf8Nx9UBvuER
	Qr2Hyghj45qs0nFLzZoJ71BAhEiGDBgjBjPHie3QYOkKsht3hDZgXi+s7qqnYwjc
	gC/munzCVIEPr1yPal0zE5Yf07ACjb8lkfNw9nWcWuyCi8/f+YPX/3TOrZDUaIaV
	q+lYSz3wt3W85AcBOY8BWyveMkU3x4+antwFIi1QFCkOH3cmRbC9PzF8yL3yBotK
	4+5f7xWEb5ygPHar5tdy3O8XXAwJ/qBr4gmma2gho36AQUUmbvxBqNsBRrRvE/7I
	cnoszUElqVs3TJ/20HbNbTfhqLovmNwuWEekdkZe4YvuiJ/cCwFcYToJ/P3Xx6iB
	khpu4NLwg5uFhgFhOY/1lpb/1VXF7Bmc8ZXhHu8BU7s5djM9jr7uPNut5gvCRmX4
	HAChDrk+Nfg19E4R8aCAnuNtOw5ZABiAh+vL4aLbd8FiJEdKT7K7+D0k736iQMKC
	ww75tA9QPi001DGVw8f+pdnalQZx4umkKfhmecb2c9cvsvdf1HAqMKM0zsVL+AB4
	0Z+kK58/qtvRzaq7g7191CZLsCLEAvdAQhRjvlf+CJf9kprtXqi0HplrRbfXea5D
	MNWViFSa6SznFCT0+jbFaT/NwtVmHtx4KHxE+CrlOysUEEazM1gK6QwB0/atZ3pL
	3Rulb9o=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v4 7/7] power: ip5xxx_power: Add support for IP5306
Date: Mon, 11 Nov 2024 08:47:20 +0100
Message-ID: <20241111074720.1727163-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311270;VERSION=7980;MC=2118469096;ID=287561;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

Add ip5xxx_regfield_config for IP5306

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 02e2a0c95407..7dd016792640 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -714,6 +714,49 @@ static struct ip5xxx_regfield_config ip51xx_fields = {
 	.boost_undervolt_uv_per_bit = 100000,
 };
 
+static struct ip5xxx_regfield_config ip5306_fields = {
+	.charger_enable = REG_FIELD(0x00, 4, 4),
+	.charger_const_volt_sel = REG_FIELD(0x22, 0, 1),
+	.charger_const_curr_sel = REG_FIELD(0x24, 0, 4),
+	.charger_status = REG_FIELD_UNSUPPORTED, // other bits...
+	.charger_chg_end = REG_FIELD(0x71, 3, 3),
+	.charger_timeout = REG_FIELD_UNSUPPORTED,
+	.charger_vin_overvolt = REG_FIELD_UNSUPPORTED,
+	.boost_enable = REG_FIELD(0x00, 5, 5),
+	.boost_llshdn_enable = REG_FIELD_UNSUPPORTED,
+	.boost_llshdn_i_limit = REG_FIELD_UNSUPPORTED,
+	.boost_load_powerup_en = REG_FIELD(0x00, 2, 2),
+	.boost_vin_pullout_en = REG_FIELD(0x01, 2, 2),
+	.boost_undervolt_limit = REG_FIELD(0x21, 2, 4),
+	.boost_light_load_status = REG_FIELD(0x72, 2, 2),
+	.battery_ntc_dis = REG_FIELD_UNSUPPORTED,
+	.battery_type = REG_FIELD(0x22, 2, 3),
+	.battery_vset_en = REG_FIELD_UNSUPPORTED,
+	.battery_adc_volt_low = REG_FIELD_UNSUPPORTED,
+	.battery_adc_volt_high = REG_FIELD_UNSUPPORTED,
+	.battery_adc_curr_low = REG_FIELD_UNSUPPORTED,
+	.battery_adc_curr_high = REG_FIELD_UNSUPPORTED,
+	.battery_adc_ovolt_low = REG_FIELD_UNSUPPORTED,
+	.battery_adc_ovolt_high = REG_FIELD_UNSUPPORTED,
+	.btn_shdn_enable = REG_FIELD(0x00, 0, 0),
+	.btn_wled_mode = REG_FIELD(0x01, 6, 6),
+	.btn_shdn_mode = REG_FIELD(0x01, 7, 7),
+	.btn_long_press_time = REG_FIELD(0x02, 4, 4), // +1s
+	.btn_pressed = REG_FIELD_UNSUPPORTED,
+	// TODO double press
+	.btn_long_pressed = REG_FIELD(0x77, 1, 1),
+	.btn_short_pressed = REG_FIELD(0x77, 0, 0),
+	.wled_enable = REG_FIELD_UNSUPPORTED,
+	.wled_detect_en = REG_FIELD_UNSUPPORTED,
+	.wled_present = REG_FIELD_UNSUPPORTED,
+
+	.vbat_max = 4400000,
+	.boost_undervolt_setpoint = 4450000,
+	.boost_undervolt_uv_per_bit = 50000,
+	.const_curr_setpoint = 50000,
+	.chg_end_inverted = 1,
+};
+
 #define ip5xxx_setup_reg(_field, _reg) \
 			do { \
 				if (likely(cfg->_field.lsb <= cfg->_field.msb)) { \
@@ -808,6 +851,7 @@ static const struct of_device_id ip5xxx_power_of_match[] = {
 	{ .compatible = "injoinic,ip5109", .data = &ip51xx_fields },
 	{ .compatible = "injoinic,ip5207", .data = &ip51xx_fields },
 	{ .compatible = "injoinic,ip5209", .data = &ip51xx_fields },
+	{ .compatible = "injoinic,ip5306", .data = &ip5306_fields },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
-- 
2.34.1



