Return-Path: <linux-pm+bounces-34296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB980B5053D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999CC188CCCD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882F362085;
	Tue,  9 Sep 2025 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awNKGOSs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103C35FC1F;
	Tue,  9 Sep 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442581; cv=none; b=l0YoNzJwR3JfPraI1862Y8kIcPq0m/zbrNSursRrEtYtabcBMuL8ManEMy9/V6I6TnlSzpgzE8ozjnEtWoLQ/24hKHIAqMNPJsjzmIPul3+29RGRohUCqDUFgs0/d/aenz528eAh+N7MXnyAwf8d1ENo3dZVUMXyx4TDSGJcrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442581; c=relaxed/simple;
	bh=voRlcLKfoLfnlVLyVO+ZDmBOdNNCSLvdkGqha5/sHqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcveT4kRyTYlXMKLJ5Voj3MjF94bND3weoKKBzRYYglUuzo9ZmBVgM5CsxRZTq1+dfmWE7CJD8alMfQkfgx+Fg9vGMI0cTMgSbga92KOsVmz3UOfHtEst8rtS6qtFDTl4DHDpkVoJAFeg421qg4w5vrB7UBU09X2WNplnmJqdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awNKGOSs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso6595826a12.1;
        Tue, 09 Sep 2025 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442578; x=1758047378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUBWcTiGE2fz4jspmliN1on/EZodfLpmty6A15u2Kyw=;
        b=awNKGOSsRe1FoIG2dkGB2i32w4cf9ekOtO4LvHxkbnKFzDXorFoTyno0+VXo0ufd8q
         DkcaCrWLGDEOArMf9p9PdrsXSdV20uLymVS/nXsmwH8wudw/9hFHNLvzbx4H5n71CbNN
         Y0ZDatn3toBOL8zwakJUJJctYyypCY7J5zfwJHTJnsPJCf/nJfooobaaLT1YTRsPUHbL
         eaRnOr//6A6zxA/fVAje4rdS1CDRn7CeOFPp3BQj+G+gKERlC6Lb/EmbQsFzw0C5wqBX
         Df1aEXtQops5E4IRaxgcvbvvLhHRkiXrkwDrEGEy/wWiAWGwMgs58onPu8bfvqO/nPal
         3Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442578; x=1758047378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUBWcTiGE2fz4jspmliN1on/EZodfLpmty6A15u2Kyw=;
        b=FMeUXfL/VigGyvfGChcDgBZH/gp3OqIUgY04I0DwymOpgCqgxxLTMTCS3M3HM/WeEL
         vq25ZM9Ytj//GrqxfAlCFYk7TowUUlTbdIsaqfqKUVxDhJSuDhtVKeK9LyQ/aROQYYJ2
         77kkzHqx9v7ta+ee/yQyXpzEVcoMedFofEfxSPzfbbB/H7FzJqGGMFyv/DXPg39SPOnk
         KnwNDnGwffgJCfSRLxh4rr5t/T3eyWrvkfn55d5gSdE2BufNmRXWD8ZLfFWPLs0SZNMu
         bs68K8pVftgp6UbUiqpOuPMENjXQfpv33dXT85wV064AfKsmQ4/QfxmfohzVCrgjNrkF
         tQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUT8T8LzmaTqupu3sqNTDdILGgELGynvIrTkh8kXqBFmpdLPugz+KEP0mqvT9tlzxWkrCkd2y/aKnMYZns=@vger.kernel.org, AJvYcCW9Wv6alpgyDY4ewvKrJe3vvaTv9Khr8WUEk8ERr9rUPQOfrdjxjGAP2v4xLkttHtf9NgwwUB8pjCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuOuJhrbsivJ/LjyNSwKuaGEd3/oteXRRikz1nSNLw9zr25PR
	c+tlf/Hd2ur270RUgG5wnN0cmqdLoez/39NkW2JCCt+oPPfkcp3RVrjA
X-Gm-Gg: ASbGncvHQB/fcl/tn35dDdtDXOnScoBGX3U/de+yyVcjVQruWa5ncM3rZRK9QzksNrk
	P2k71aPO5fuiOD7Nr1AYB9ZpDSRCyUsGBqaSRQQ+Lql8TnAvbwqMzQFcxPg1bp6/qAI51WGJVzW
	s+tEdMdG1DNwGiFJhnu76ZVmHDNEaHxzDn7T8P9kYxvX4cLPW+6dts28OGpjmv3QPtqFndKzB/3
	H+OTZS8VJ2CbV34TF7kBLH/wH9RUUC4zzL885MouWo+VvlAGn8lwT243cYAwrtSo0dvWA1BA1R+
	MY6pa4kLZMX2Qy2UBMJyrokqPsQ8oTi9pNSJlE+3wO5dibqk1i/Rdf0XtSxImflHialGlVZCcid
	OjCkYmmyUHE+pbcpsplrXxjRSCT4S3mw=
X-Google-Smtp-Source: AGHT+IGo/fVlDxx0iEjAiRxVdtiG0SnOp5LBdVELsWq+uS8dF6Zkyf3XgDEiU85/yBjMYrGxb4hsIw==
X-Received: by 2002:a17:906:4788:b0:b04:286a:2fb8 with SMTP id a640c23a62f3a-b04b1764361mr1194415866b.56.1757442577887;
        Tue, 09 Sep 2025 11:29:37 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:37 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:15 +0300
Subject: [PATCH v2 5/9] power: supply: max77705_charger: add writable
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-5-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=2821;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=voRlcLKfoLfnlVLyVO+ZDmBOdNNCSLvdkGqha5/sHqA=;
 b=KRZ7lLKiPymYMTT0VDoUzLme/2qaBON8OoAY12WwYPYekG2N/Cxb6I11J4m/QzntErQqfrAj3
 Wj0j8/WjaR5BsY6d3JKhsYC8SQurz22S/Gz/0RwW1uAdEZo53RQ1CYL
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add INPUT_CURRENT_LIMIT, CONSTANT_CHARGE_CURRENT properties as writeable
to be able to control input power consumption and charging speed.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 93d055458849..d6a3cd98c898 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -105,6 +105,17 @@ static int max77705_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+static int max77705_set_integer(struct max77705_charger_data *chg, enum max77705_field_idx fidx,
+				unsigned int clamp_min, unsigned int clamp_max,
+				unsigned int div, int val)
+{
+	unsigned int regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(chg->rfield[fidx], regval);
+}
+
 static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 {
 	unsigned int reg_data;
@@ -384,12 +395,55 @@ static int max77705_chg_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int max77705_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct max77705_charger_data *charger = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CC_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHG_STEP,
+					   val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CHGIN_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHGIN_STEP,
+					   val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+};
+
+static int max77705_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct power_supply_desc max77705_charger_psy_desc = {
 	.name = "max77705-charger",
 	.type		= POWER_SUPPLY_TYPE_USB,
 	.properties = max77705_charger_props,
+	.property_is_writeable	= max77705_property_is_writeable,
 	.num_properties = ARRAY_SIZE(max77705_charger_props),
 	.get_property = max77705_chg_get_property,
+	.set_property		= max77705_set_property,
 };
 
 static void max77705_chgin_isr_work(struct work_struct *work)

-- 
2.39.5


