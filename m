Return-Path: <linux-pm+bounces-17786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C6F9D2D99
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B2C1F26779
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0051D54C1;
	Tue, 19 Nov 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="kiFJMUjs"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210F1D3586;
	Tue, 19 Nov 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039738; cv=none; b=VZk1gSwlBN3IjuKYTaLGzQ4dFH+WVwCMMH6/Le5yYlB9/zA8t14j0VcG/yhmxpMOy/iAGA7nlgf+riPRZXsEfbqpfVimYoUWS8rjCcB/RcT7Vve4piV/xhwkmykGIbBu0ESbHkfWblqn2Zz3JMEOmaXVeS9z9V7jERrz4/vJoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039738; c=relaxed/simple;
	bh=FRxou4ogBasR2CbqYSAi7TTdRHL6MFzbg3a6NsqD/kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P97sZ6qBoTmeRZAun1VjIheI0TXwH1yp5giYe0kPIfDBMD2EXZox9i7HetjZGe4fz/kkWa7ebIHugTdTB4pDy3zRsZuUTO6eBANDJqNh3U3NUtd99d3vMT4sfQCFm2lVL43TDn++1qVSd88ablxwD46p+X+5BRi93lexW6AwGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=kiFJMUjs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0E3EEA09FA;
	Tue, 19 Nov 2024 19:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=sDyqACO40CQYV6Wt5JDK
	GnAAVIir2WsWp+4/gPHIazg=; b=kiFJMUjs6FHicofeKn5EA32DoZcOUTW4XQ1T
	ga6uEw3H9t3dy4LhD/98tJ6gxxCxxLDzwW0srqscK2pFNyohu27hXrIwnMH22g3i
	nnnfRSbkZIdWZTPZo5+L+Jp0qyCHQJR4M8sdJEv5V0PKm24jDd2IOKmSH2q8TWF6
	UuVSGtkoM/v2L7xVT35tcUiOg9rHYzQdKr80edLVFor0RHLfMwfCKhXt+uWI/ji1
	L+rMetLI/bPwYqJhkGDUNOdQ+8+XybM5vxYRzMiALbS+KxUEYPKaPKQfAVDunuUT
	bvdQbqVaqnTETAio7/y9UShbuyuFPnErs2hWArXADgfSDCj3JhNdCMhuBpQBREoo
	tNe2wuc7SsD01JU67y+616Af+KbqnfVanT+OLGd1HDstteWAHQpLtOCHQd2+CT8f
	p8RBfcIIX+tXr3sNdDZ/meyqaMUIbjrZJLmk7xQ4bPqmjosQCFobI7wFYtWTGdir
	gze9133jdK70QBzN3l5RWGmPKeIAJ8wdfsBRYetdWQVq0iDN66IwBnZlRvuUHExl
	YsHsTWMNGP3SwqbM2fAw4E4oLq2Yg8g2O/BdERenHTYar//dxm3zwOqczb1jKZoj
	GxNPdRCv+uGZUKdeA9xMfAqg+XJYADAKw2VxazdVgip6zV2LMZwyyRmG3kSUoZe4
	IZI/YMs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v5 8/8] power: ip5xxx_power: Add support for IP5306
Date: Tue, 19 Nov 2024 19:07:40 +0100
Message-ID: <20241119180741.2237692-8-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732039726;VERSION=7980;MC=583164542;ID=46213;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560766B

Add ip5xxx_regfield_config for IP5306

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 46b84fb696d7..46f8eb7100c1 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -729,6 +729,49 @@ static struct ip5xxx_regfield_config ip51xx_fields = {
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
@@ -824,6 +867,7 @@ static const struct of_device_id ip5xxx_power_of_match[] = {
 	{ .compatible = "injoinic,ip5109", .data = &ip51xx_fields },
 	{ .compatible = "injoinic,ip5207", .data = &ip51xx_fields },
 	{ .compatible = "injoinic,ip5209", .data = &ip51xx_fields },
+	{ .compatible = "injoinic,ip5306", .data = &ip5306_fields },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
-- 
2.34.1



