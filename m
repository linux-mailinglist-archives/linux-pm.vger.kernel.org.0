Return-Path: <linux-pm+bounces-33474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEEB3CF4F
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A601B2446F
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E72E7622;
	Sat, 30 Aug 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV3aJNXT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1723D7EC;
	Sat, 30 Aug 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586730; cv=none; b=okPpfohwReSMmWcg98Hi9MWsUp0ZBA1mgYHxShPNfMspL4yEwyWFahsqrTvqN+jBCmmcycjUotOymNYex14WpaIzfIspvJ9seKcrGMf6i8LUJWWMqm1tXIcWN6d2eTQERzOJG8m5MbYEVIHxnsGfUFBVDFmIMh63x6J6XE0rorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586730; c=relaxed/simple;
	bh=0120lEeugAytlD1Sf6z5zpbQoaqanYsfApO8WtLj7II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/Der8SjK1ZzTd6IoNFhdrQB+8R6iUpjrV+O2Xv555YVIDY3YBEaOYflsIPK1RSmCaLnfXXlq6JXfJiVl1oGFCzFYT5CvZMM1NAkEpqQkiHAHZzh33ZOPB3AX4eFZTsQ5SjTCsphKbOKIcjMc6xVrbA++RSLSMenK924bJHSv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV3aJNXT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so497808666b.2;
        Sat, 30 Aug 2025 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586727; x=1757191527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoeCpwn38HYrZiarHGw2LTjSD/tdbcQi5PEDAghtbCs=;
        b=nV3aJNXTxDBOO3IExmUZuMpmGWidRiiJl91wT/sm51iFhKAy0nmMEr9Z0FUocITFQI
         AzJXTZC/oKYhWXpAYjlu3QhR3vevaM+Cr8nbdY0+Suk9MvuVcPtV31Y07ftkhQeuk++l
         4CHLAZDtLfp8rLUZhNL9I1wITuGX68sRDK/oekMRN9rfUa12ccBOVQHD3j8P8UiAzU/L
         nzGWugOq8khmogOFzTezvJWgcvUFsuNl9vX1Nqr8ZoOC6A99WEKuwujYwc7OhmsasxW7
         XztnLpznOrAWrEcwaQG8TphReSpQg5U8IaG6PF9lfm9gJRSkrJf8zn0Im+KyEpdZWd7n
         jaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586727; x=1757191527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoeCpwn38HYrZiarHGw2LTjSD/tdbcQi5PEDAghtbCs=;
        b=kCuJYFq/vwDMPYcu5oMYn61qndmF81A44TCsazqqvNEEwyFEMiDgxILfDta+sqRPSK
         P3R04brd/N+XpXmVODwOe8faVcRwQkYOM3nqJr23F1udrijDJrI1b3Qd/Osa5PcabwTI
         G2STnovukeLDQ3YFUdpAFfNGVtVh4pBpIKUEEA454lj7ko7hiJo8hEHrDtz7O30OxlDA
         7xaMYGzB5GLd5t3HQ+EjHQMDX0RzLi3UUm4t24HbDlWaEALTMma/zM7t6dhf120n954Z
         bmovMBRw1qJdBWAjFa9/0X4agAIDk2Ye2QvNP6Tn/m7d/y4cF88K+RrzCx5EyNXgH0YF
         PEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+shmRZAuR3sPL440GQrfeINWuKx3xYoinkNtoDIDdaFDo0DOQOQJK10bL6aAt3b0Rt5JsHzPS+nqz0Jc=@vger.kernel.org, AJvYcCXte1BqgVTaQBzxfi16ZXt3N+5ZYIz6+qbGsxs72GCOo+CukEGrm9V9Ixd1d5cFWNUIbszhhkSGDAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahecIKGAhlVBI1t2VC+/tY4FgnnzUFJUYBdGNduKcUnQtwAaL
	LgjH2vFRLJXpL23na6/3SoFJa9QLk46Fqct5VoHmq8Xi/UEeutYqYHc7
X-Gm-Gg: ASbGnctSZmEsQQEHckky2s1MujNhLh7k3CQlY4bwCMBtggUcOmrWMgwfkGGlvXToVDM
	QPlXkr1VDWEzxJEtEOMHyuw1BPlDYy2+u8Ak/x6u2PWb/rTPCMNHuau81Yg5HUzvspJuZ2qbZPQ
	QEYmyVrZ2Zq7K+EJMsuptDmeAvW3s67VYdNbVQH1p9Nu2wx4YYloUrxtavUtzO1HMgKKeK8nMpB
	xs60leqVsHfaNxXg3L8NUEtURQYkueaszZfGBW9iC7HNbAiu0L4Im8Xhlr6zqkBvlRm3dCh5FyB
	ckbUGpx74htrOly2zgmp70ndxE0OF2bWXP273BOBMYXP1fnZN+4t3PaqRz+wNq2gkzlIL5r2WIR
	tWmpJOveyrl6tUwK55ATE
X-Google-Smtp-Source: AGHT+IFDdtq+pSRBhZAaCtPUsSHZo4r5PSPgVa/c3+f+wNq1/Y2oLGB6EVTEvsdyuxRDoKyIC/AGtQ==
X-Received: by 2002:a17:907:3f12:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b01d8a708d7mr312101866b.17.1756586726724;
        Sat, 30 Aug 2025 13:45:26 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:26 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:16 +0300
Subject: [PATCH 3/9] power: supply: max77705_charger: use regfields for
 config registers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-3-e976db3fd432@gmail.com>
References: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
In-Reply-To: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=16365;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=0120lEeugAytlD1Sf6z5zpbQoaqanYsfApO8WtLj7II=;
 b=wYOw55GMviMDE6ZEU6jCCh8Ht2aKOf8pnhqkPtHeVTxkNZjcsfG9nUUb6EoZIdXJffEuGANs6
 d5GD90ieSRPC2OkTKIgjEgnn4w1HeKTVMtiXi8pUSd6M+xXEt8n9vHF
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Using regfields allows to cleanup masks and register offset definition,
allowing to access register info by it's functional name.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 105 ++++++++++++--------------------
 include/linux/power/max77705_charger.h  |  99 ++++++++++++++++--------------
 2 files changed, 92 insertions(+), 112 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 7855f890e0a9..29bb763e56be 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -74,8 +74,7 @@ static int max77705_charger_enable(struct max77705_charger_data *chg)
 {
 	int rv;
 
-	rv = regmap_update_bits(chg->regmap, MAX77705_CHG_REG_CNFG_09,
-				MAX77705_CHG_EN_MASK, MAX77705_CHG_EN_MASK);
+	rv = regmap_field_write(chg->rfield[MAX77705_CHG_EN], 1);
 	if (rv)
 		dev_err(chg->dev, "unable to enable the charger: %d\n", rv);
 
@@ -87,10 +86,7 @@ static void max77705_charger_disable(void *data)
 	struct max77705_charger_data *chg = data;
 	int rv;
 
-	rv = regmap_update_bits(chg->regmap,
-				MAX77705_CHG_REG_CNFG_09,
-				MAX77705_CHG_EN_MASK,
-				MAX77705_CHG_DISABLE);
+	rv = regmap_field_write(chg->rfield[MAX77705_CHG_EN], MAX77705_CHG_DISABLE);
 	if (rv)
 		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
 }
@@ -134,10 +130,10 @@ static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 static int max77705_get_charge_type(struct max77705_charger_data *chg, int *val)
 {
 	struct regmap *regmap = chg->regmap;
-	unsigned int reg_data;
+	unsigned int reg_data, chg_en;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
+	regmap_field_read(chg->rfield[MAX77705_CHG_EN], &chg_en);
+	if (!chg_en) {
 		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		return 0;
 	}
@@ -162,10 +158,10 @@ static int max77705_get_charge_type(struct max77705_charger_data *chg, int *val)
 static int max77705_get_status(struct max77705_charger_data *chg, int *val)
 {
 	struct regmap *regmap = chg->regmap;
-	unsigned int reg_data;
+	unsigned int reg_data, chg_en;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
+	regmap_field_read(chg->rfield[MAX77705_CHG_EN], &chg_en);
+	if (!chg_en) {
 		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		return 0;
 	}
@@ -295,16 +291,11 @@ static int max77705_get_input_current(struct max77705_charger_data *chg,
 {
 	unsigned int reg_data;
 	int get_current = 0;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-
-	reg_data &= MAX77705_CHG_CHGIN_LIM_MASK;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &reg_data);
 
 	if (reg_data <= 3)
 		get_current = MAX77705_CURRENT_CHGIN_MIN;
-	else if (reg_data >= MAX77705_CHG_CHGIN_LIM_MASK)
-		get_current = MAX77705_CURRENT_CHGIN_MAX;
 	else
 		get_current = (reg_data + 1) * MAX77705_CURRENT_CHGIN_STEP;
 
@@ -317,10 +308,8 @@ static int max77705_get_charge_current(struct max77705_charger_data *chg,
 					int *val)
 {
 	unsigned int reg_data;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_02, &reg_data);
-	reg_data &= MAX77705_CHG_CC;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CC_LIM], &reg_data);
 
 	*val = reg_data <= 0x2 ? MAX77705_CURRENT_CHGIN_MIN : reg_data * MAX77705_CURRENT_CHG_STEP;
 
@@ -332,7 +321,6 @@ static int max77705_set_float_voltage(struct max77705_charger_data *chg,
 {
 	int float_voltage_mv;
 	unsigned int reg_data = 0;
-	struct regmap *regmap = chg->regmap;
 
 	float_voltage_mv = float_voltage / 1000;
 	reg_data = float_voltage_mv <= 4000 ? 0x0 :
@@ -340,9 +328,7 @@ static int max77705_set_float_voltage(struct max77705_charger_data *chg,
 		(float_voltage_mv <= 4200) ? (float_voltage_mv - 4000) / 50 :
 		(((float_voltage_mv - 4200) / 10) + 0x04);
 
-	return regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_04,
-				MAX77705_CHG_CV_PRM_MASK,
-				(reg_data << MAX77705_CHG_CV_PRM_SHIFT));
+	return regmap_field_write(chg->rfield[MAX77705_CHG_CV_PRM], reg_data);
 }
 
 static int max77705_get_float_voltage(struct max77705_charger_data *chg,
@@ -350,10 +336,8 @@ static int max77705_get_float_voltage(struct max77705_charger_data *chg,
 {
 	unsigned int reg_data = 0;
 	int voltage_mv;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_04, &reg_data);
-	reg_data &= MAX77705_CHG_PRM_MASK;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CV_PRM], &reg_data);
 	voltage_mv = reg_data <= 0x04 ? reg_data * 50 + 4000 :
 					(reg_data - 4) * 10 + 4200;
 	*val = voltage_mv * 1000;
@@ -418,7 +402,6 @@ static void max77705_chgin_isr_work(struct work_struct *work)
 
 static void max77705_charger_initialize(struct max77705_charger_data *chg)
 {
-	u8 reg_data;
 	struct power_supply_battery_info *info;
 	struct regmap *regmap = chg->regmap;
 
@@ -429,45 +412,31 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 
 	/* unlock charger setting protect */
 	/* slowest LX slope */
-	reg_data = MAX77705_CHGPROT_MASK | MAX77705_SLOWEST_LX_SLOPE;
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_06, reg_data,
-						reg_data);
+	regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_MASK);
+	regmap_field_write(chg->rfield[MAX77705_LX_SLOPE], MAX77705_SLOWEST_LX_SLOPE);
 
 	/* fast charge timer disable */
 	/* restart threshold disable */
 	/* pre-qual charge disable */
-	reg_data = (MAX77705_FCHGTIME_DISABLE << MAX77705_FCHGTIME_SHIFT) |
-			(MAX77705_CHG_RSTRT_DISABLE << MAX77705_CHG_RSTRT_SHIFT) |
-			(MAX77705_CHG_PQEN_DISABLE << MAX77705_PQEN_SHIFT);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_01,
-						(MAX77705_FCHGTIME_MASK |
-						MAX77705_CHG_RSTRT_MASK |
-						MAX77705_PQEN_MASK),
-						reg_data);
-
-	/* OTG off(UNO on), boost off */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
-				MAX77705_OTG_CTRL, 0);
+	regmap_field_write(chg->rfield[MAX77705_FCHGTIME], MAX77705_FCHGTIME_DISABLE);
+	regmap_field_write(chg->rfield[MAX77705_CHG_RSTRT], MAX77705_CHG_RSTRT_DISABLE);
+	regmap_field_write(chg->rfield[MAX77705_CHG_PQEN], MAX77705_CHG_PQEN_DISABLE);
+
+	regmap_field_write(chg->rfield[MAX77705_MODE],
+			MAX77705_CHG_MASK | MAX77705_BUCK_MASK);
 
 	/* charge current 450mA(default) */
 	/* otg current limit 900mA */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_02,
-				MAX77705_OTG_ILIM_MASK,
-				MAX77705_OTG_ILIM_900 << MAX77705_OTG_ILIM_SHIFT);
+	regmap_field_write(chg->rfield[MAX77705_OTG_ILIM], MAX77705_OTG_ILIM_900);
 
 	/* BAT to SYS OCP 4.80A */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_05,
-				MAX77705_REG_B2SOVRC_MASK,
-				MAX77705_B2SOVRC_4_8A << MAX77705_REG_B2SOVRC_SHIFT);
+	regmap_field_write(chg->rfield[MAX77705_REG_B2SOVRC], MAX77705_B2SOVRC_4_8A);
+
 	/* top off current 150mA */
 	/* top off timer 30min */
-	reg_data = (MAX77705_TO_ITH_150MA << MAX77705_TO_ITH_SHIFT) |
-			(MAX77705_TO_TIME_30M << MAX77705_TO_TIME_SHIFT) |
-			(MAX77705_SYS_TRACK_DISABLE << MAX77705_SYS_TRACK_DIS_SHIFT);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_03,
-			   (MAX77705_TO_ITH_MASK |
-			   MAX77705_TO_TIME_MASK |
-			   MAX77705_SYS_TRACK_DIS_MASK), reg_data);
+	regmap_field_write(chg->rfield[MAX77705_TO], MAX77705_TO_ITH_150MA);
+	regmap_field_write(chg->rfield[MAX77705_TO_TIME], MAX77705_TO_TIME_30M);
+	regmap_field_write(chg->rfield[MAX77705_SYS_TRACK], MAX77705_SYS_TRACK_DISABLE);
 
 	/* cv voltage 4.2V or 4.35V */
 	/* MINVSYS 3.6V(default) */
@@ -478,25 +447,21 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 		max77705_set_float_voltage(chg, info->voltage_max_design_uv);
 	}
 
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
-				MAX77705_VCHGIN_REG_MASK, MAX77705_VCHGIN_4_5);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
-				MAX77705_WCIN_REG_MASK, MAX77705_WCIN_4_5);
+	regmap_field_write(chg->rfield[MAX77705_VCHGIN], MAX77705_VCHGIN_4_5);
+	regmap_field_write(chg->rfield[MAX77705_WCIN], MAX77705_WCIN_4_5);
 
 	/* Watchdog timer */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
 	/* VBYPSET=5.0V */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
+	regmap_field_write(chg->rfield[MAX77705_VBYPSET], 0);
 
 	/* Switching Frequency : 1.5MHz */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_08, MAX77705_REG_FSW_MASK,
-				(MAX77705_CHG_FSW_1_5MHz << MAX77705_REG_FSW_SHIFT));
+	regmap_field_write(chg->rfield[MAX77705_REG_FSW], MAX77705_CHG_FSW_1_5MHz);
 
 	/* Auto skip mode */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12, MAX77705_REG_DISKIP_MASK,
-				(MAX77705_AUTO_SKIP << MAX77705_REG_DISKIP_SHIFT));
+	regmap_field_write(chg->rfield[MAX77705_REG_DISKIP], MAX77705_AUTO_SKIP);
 }
 
 static int max77705_charger_probe(struct i2c_client *i2c)
@@ -520,6 +485,14 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (IS_ERR(chg->regmap))
 		return PTR_ERR(chg->regmap);
 
+	for (int i = 0; i < MAX77705_N_REGMAP_FIELDS; i++) {
+		chg->rfield[i] = devm_regmap_field_alloc(dev, chg->regmap,
+							 max77705_reg_field[i]);
+		if (IS_ERR(chg->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(chg->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
 	ret = regmap_update_bits(chg->regmap,
 				MAX77705_CHG_REG_INT_MASK,
 				MAX77705_CHGIN_IM, 0);
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index fdec9af9c541..aec908ac5c01 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -9,6 +9,8 @@
 #ifndef __MAX77705_CHARGER_H
 #define __MAX77705_CHARGER_H __FILE__
 
+#include <linux/regmap.h>
+
 /* MAX77705_CHG_REG_CHG_INT */
 #define MAX77705_BYP_I		BIT(0)
 #define MAX77705_INP_LIMIT_I	BIT(1)
@@ -63,7 +65,6 @@
 #define MAX77705_BUCK_SHIFT	2
 #define MAX77705_BOOST_SHIFT	3
 #define MAX77705_WDTEN_SHIFT	4
-#define MAX77705_MODE_MASK	GENMASK(3, 0)
 #define MAX77705_CHG_MASK	BIT(MAX77705_CHG_SHIFT)
 #define MAX77705_UNO_MASK	BIT(MAX77705_UNO_SHIFT)
 #define MAX77705_OTG_MASK	BIT(MAX77705_OTG_SHIFT)
@@ -74,34 +75,19 @@
 #define MAX77705_OTG_CTRL	(MAX77705_OTG_MASK | MAX77705_BOOST_MASK)
 
 /* MAX77705_CHG_REG_CNFG_01 */
-#define MAX77705_FCHGTIME_SHIFT		0
-#define MAX77705_FCHGTIME_MASK		GENMASK(2, 0)
-#define MAX77705_CHG_RSTRT_SHIFT	4
-#define MAX77705_CHG_RSTRT_MASK		GENMASK(5, 4)
 #define MAX77705_FCHGTIME_DISABLE	0
 #define MAX77705_CHG_RSTRT_DISABLE	0x3
 
-#define MAX77705_PQEN_SHIFT		7
-#define MAX77705_PQEN_MASK		BIT(7)
 #define MAX77705_CHG_PQEN_DISABLE	0
 #define MAX77705_CHG_PQEN_ENABLE	1
 
 /* MAX77705_CHG_REG_CNFG_02 */
-#define MAX77705_OTG_ILIM_SHIFT		6
-#define MAX77705_OTG_ILIM_MASK		GENMASK(7, 6)
 #define MAX77705_OTG_ILIM_500		0
 #define MAX77705_OTG_ILIM_900		1
 #define MAX77705_OTG_ILIM_1200		2
 #define MAX77705_OTG_ILIM_1500		3
-#define MAX77705_CHG_CC			GENMASK(5, 0)
 
 /* MAX77705_CHG_REG_CNFG_03 */
-#define MAX77705_TO_ITH_SHIFT		0
-#define MAX77705_TO_ITH_MASK		GENMASK(2, 0)
-#define MAX77705_TO_TIME_SHIFT		3
-#define MAX77705_TO_TIME_MASK		GENMASK(5, 3)
-#define MAX77705_SYS_TRACK_DIS_SHIFT	7
-#define MAX77705_SYS_TRACK_DIS_MASK	BIT(7)
 #define MAX77705_TO_ITH_150MA		0
 #define MAX77705_TO_TIME_30M		3
 #define MAX77705_SYS_TRACK_ENABLE	0
@@ -110,15 +96,8 @@
 /* MAX77705_CHG_REG_CNFG_04 */
 #define MAX77705_CHG_MINVSYS_SHIFT	6
 #define MAX77705_CHG_MINVSYS_MASK	GENMASK(7, 6)
-#define MAX77705_CHG_PRM_SHIFT		0
-#define MAX77705_CHG_PRM_MASK		GENMASK(5, 0)
-
-#define MAX77705_CHG_CV_PRM_SHIFT	0
-#define MAX77705_CHG_CV_PRM_MASK	GENMASK(5, 0)
 
 /* MAX77705_CHG_REG_CNFG_05 */
-#define MAX77705_REG_B2SOVRC_SHIFT	0
-#define MAX77705_REG_B2SOVRC_MASK	GENMASK(3, 0)
 #define MAX77705_B2SOVRC_DISABLE	0
 #define MAX77705_B2SOVRC_4_5A		6
 #define MAX77705_B2SOVRC_4_8A		8
@@ -130,7 +109,7 @@
 #define MAX77705_WDTCLR			1
 #define MAX77705_CHGPROT_MASK		GENMASK(3, 2)
 #define MAX77705_CHGPROT_UNLOCKED	GENMASK(3, 2)
-#define MAX77705_SLOWEST_LX_SLOPE	GENMASK(6, 5)
+#define MAX77705_SLOWEST_LX_SLOPE	3
 
 /* MAX77705_CHG_REG_CNFG_07 */
 #define MAX77705_CHG_FMBST		4
@@ -140,36 +119,14 @@
 #define MAX77705_REG_FGSRC_MASK		BIT(MAX77705_REG_FGSRC_SHIFT)
 
 /* MAX77705_CHG_REG_CNFG_08 */
-#define MAX77705_REG_FSW_SHIFT		0
-#define MAX77705_REG_FSW_MASK		GENMASK(1, 0)
 #define MAX77705_CHG_FSW_3MHz		0
 #define MAX77705_CHG_FSW_2MHz		1
 #define MAX77705_CHG_FSW_1_5MHz		2
 
 /* MAX77705_CHG_REG_CNFG_09 */
-#define MAX77705_CHG_CHGIN_LIM_MASK		GENMASK(6, 0)
-#define MAX77705_CHG_EN_MASK			BIT(7)
 #define MAX77705_CHG_DISABLE			0
-#define MAX77705_CHARGER_CHG_CHARGING(_reg) \
-				(((_reg) & MAX77705_CHG_EN_MASK) > 1)
-
-
-/* MAX77705_CHG_REG_CNFG_10 */
-#define MAX77705_CHG_WCIN_LIM		GENMASK(5, 0)
-
-/* MAX77705_CHG_REG_CNFG_11 */
-#define MAX77705_VBYPSET_SHIFT		0
-#define MAX77705_VBYPSET_MASK		GENMASK(6, 0)
 
 /* MAX77705_CHG_REG_CNFG_12 */
-#define MAX77705_CHGINSEL_SHIFT		5
-#define MAX77705_CHGINSEL_MASK		BIT(MAX77705_CHGINSEL_SHIFT)
-#define MAX77705_WCINSEL_SHIFT		6
-#define MAX77705_WCINSEL_MASK		BIT(MAX77705_WCINSEL_SHIFT)
-#define MAX77705_VCHGIN_REG_MASK	GENMASK(4, 3)
-#define MAX77705_WCIN_REG_MASK		GENMASK(2, 1)
-#define MAX77705_REG_DISKIP_SHIFT	0
-#define MAX77705_REG_DISKIP_MASK	BIT(MAX77705_REG_DISKIP_SHIFT)
 /* REG=4.5V, UVLO=4.7V */
 #define MAX77705_VCHGIN_4_5		0
 /* REG=4.5V, UVLO=4.7V */
@@ -183,9 +140,59 @@
 #define MAX77705_CURRENT_CHGIN_MIN	100000
 #define MAX77705_CURRENT_CHGIN_MAX	3200000
 
+enum max77705_field_idx {
+	MAX77705_CHGPROT,
+	MAX77705_CHG_EN,
+	MAX77705_CHG_CC_LIM,
+	MAX77705_CHG_CHGIN_LIM,
+	MAX77705_CHG_CV_PRM,
+	MAX77705_CHG_PQEN,
+	MAX77705_CHG_RSTRT,
+	MAX77705_CHG_WCIN,
+	MAX77705_FCHGTIME,
+	MAX77705_LX_SLOPE,
+	MAX77705_MODE,
+	MAX77705_OTG_ILIM,
+	MAX77705_REG_B2SOVRC,
+	MAX77705_REG_DISKIP,
+	MAX77705_REG_FSW,
+	MAX77705_SYS_TRACK,
+	MAX77705_TO,
+	MAX77705_TO_TIME,
+	MAX77705_VBYPSET,
+	MAX77705_VCHGIN,
+	MAX77705_WCIN,
+	MAX77705_N_REGMAP_FIELDS,
+};
+
+static const struct reg_field max77705_reg_field[MAX77705_N_REGMAP_FIELDS] = {
+	[MAX77705_MODE]			= REG_FIELD(MAX77705_CHG_REG_CNFG_00,   0, 3),
+	[MAX77705_FCHGTIME]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   0, 2),
+	[MAX77705_CHG_RSTRT]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   4, 5),
+	[MAX77705_CHG_PQEN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   7, 7),
+	[MAX77705_CHG_CC_LIM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_02,   0, 5),
+	[MAX77705_OTG_ILIM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_02,   6, 7),
+	[MAX77705_TO]			= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   0, 2),
+	[MAX77705_TO_TIME]		= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   3, 5),
+	[MAX77705_SYS_TRACK]		= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   7, 7),
+	[MAX77705_CHG_CV_PRM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_04,   0, 5),
+	[MAX77705_REG_B2SOVRC]		= REG_FIELD(MAX77705_CHG_REG_CNFG_05,   0, 3),
+	[MAX77705_CHGPROT]		= REG_FIELD(MAX77705_CHG_REG_CNFG_06,   2, 3),
+	[MAX77705_LX_SLOPE]		= REG_FIELD(MAX77705_CHG_REG_CNFG_06,   5, 6),
+	[MAX77705_REG_FSW]		= REG_FIELD(MAX77705_CHG_REG_CNFG_08,   0, 1),
+	[MAX77705_CHG_CHGIN_LIM]	= REG_FIELD(MAX77705_CHG_REG_CNFG_09,   0, 6),
+	[MAX77705_CHG_EN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_09,   7, 7),
+	[MAX77705_CHG_WCIN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_10,   0, 5),
+	[MAX77705_VBYPSET]		= REG_FIELD(MAX77705_CHG_REG_CNFG_11,   0, 6),
+	[MAX77705_REG_DISKIP]		= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   0, 0),
+	[MAX77705_WCIN]			= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   1, 2),
+	[MAX77705_VCHGIN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   3, 4),
+};
+
 struct max77705_charger_data {
 	struct device			*dev;
 	struct regmap		*regmap;
+	struct regmap_field	*rfield[MAX77705_N_REGMAP_FIELDS];
 	struct power_supply_battery_info *bat_info;
 	struct workqueue_struct *wqueue;
 	struct work_struct	chgin_work;

-- 
2.39.5


