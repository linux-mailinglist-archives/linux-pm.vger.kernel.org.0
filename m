Return-Path: <linux-pm+bounces-8415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77708D47B6
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F991C20B07
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0717E460;
	Thu, 30 May 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOVRgl1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533C17D375;
	Thu, 30 May 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059400; cv=none; b=RYYLHSu4Ss/aF23cOW87iP5fP/svQ7JlRLhh3oL3WU4L9nJvMmAMywEWb7WkhInWREumtoJnimVC/M2rqAUUxSVBV+2zMdPaup5DhoAHjOu5NoVPolNs5vJP9LwKHEE8oRm7NgKodT0k3tcESwjKletj9uxb7TKL0y6167lk+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059400; c=relaxed/simple;
	bh=ASIwzdEZQZXRm8Gyc8ivplNNZTHwY1NZ3AUZqjW/FCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTVgWy3HR6muIgITT4E2fTCumWeK/D73vEjxIvHP145cAQTZYdEkWN+cr7FFzXqejz+YJzltQWt3RFXgfd3m8QgppDwNltuSijr5sHLPSmUG7hxgYTGIx9ejOz0slHLMhmXByrWgbl4p7xTGFm6mnrB/Fy+8/thUONPtLuVlWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOVRgl1o; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6267778b3aso33079766b.3;
        Thu, 30 May 2024 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059397; x=1717664197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y515HyBE05tinjYLW0X+UrEG/VkT72f1VOdrq3/W9HM=;
        b=mOVRgl1olq2CDAl4zvIKpGg+63kOXWkrTFaDOx00QQpT4Y6oj85dXdu/MhXVWh/Wra
         kt0IXAuA8GgDawuMTXZ2rtQRy5DFwlNlVpwlwH7NyVJ/VLdVs/nzCNrZfk8FOuRoYJln
         AaEpWPoDWqlIWkwA1cJLvluznoSddr/yn9fBUTpi2h2yl7LENGPJ8n8aFzbzZzOSLsox
         nVliYdDmO+EPLapQ8EcxVBe80bmhPE+xP1qMUZe51Khk7H//IDXl9PdEW8M2ZYWH4ksv
         cw3H1LMeepVOwvyeJplSC2BXLUbVAQKCfYRMdhpRJA5MV/77pGDNiWSEPsu2ngFtKmsU
         rjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059397; x=1717664197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y515HyBE05tinjYLW0X+UrEG/VkT72f1VOdrq3/W9HM=;
        b=dg4pAlH/cjZC1UH+xHySiyOpV34C01CqkcVHJ86yTKvgFFJd4ZQ946OC2Fy9QY3bBH
         4QEEdmf5OxiP8Ura73RCnO8CY4OGjU9sp7soHaq2BkhZcQyqYMLruzjSNTIxO0TDB/l6
         sqYIft02o2KUp0OtFAY6n2NLd98d3dLeI++otyzUtfVW6gIProReYHVtWZmNcbasvzkR
         61tNQmyHKegluckHry2lWZb6yDsaITFLPN8I+1umPzjWxmajX28BXV0qc1KiY06YiNTx
         G05cp0B0+7tWCdpewH8Q6LOZtxGDPMwSyvCdUwFA2BUp4aqBLzxHkHIAISleiQCMfcKB
         uu4g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Oxfi3SGyL0cuRJ4AM+y9QvU9lyxjXeP7xxHxUCJ+21LSnP0FjwAsIB7XaeNvcPW4GWRaSfBgoJCZjZWXGP7a/H+NYc7WGOo2ftBxnkErr9eg2DXm7jOvmv8eM8RqOPBc9IPBglPOHTqSpXA9ayoTFx95iAFDTAfe+hh7v3TkyDIr5WOvBRopa8NJMKm2MESXMaUOy2/nMmcxIIqtdrgOHI9AAzw=
X-Gm-Message-State: AOJu0YzurNM/GQGi03YNXOlTMv4dGWPRASd3Uv4S9to/zlDUOYSB2bkK
	+65OmIkEzJo7o2KiGcfJXnzL5k2Kdy0hEoFdICKxcIOFnnf+ykVx
X-Google-Smtp-Source: AGHT+IEOoR0GhaKcDjy0VMgU2i9ZuhLM0mYFVsj2XeXlc9nnyB4fJ48jkxmmdzBaeVAKSQ8zfT79vA==
X-Received: by 2002:a17:906:bcf1:b0:a62:1ac8:5752 with SMTP id a640c23a62f3a-a65e8e317e8mr84844066b.8.1717059396642;
        Thu, 30 May 2024 01:56:36 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:36 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:58 +0200
Subject: [PATCH RFC 08/11] power: supply: max77693: Add support for
 detecting and enabling OTG
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-8-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=3575;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=ASIwzdEZQZXRm8Gyc8ivplNNZTHwY1NZ3AUZqjW/FCw=;
 b=MXc4Bb2/SN4z7AvEEeeSSMbRT9iuCtg3ixSez6kz6cE5oO+N08S58aiJ0Lfic/PE6EWcO4BIc
 Q+aEXmRvbfFDSMFAdElLbXdf7WM0IdllawF8Jzg0BN+OKcPfhzte9rM
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Building upon the newly added extcon detection support, add detection
for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
bits as needed.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Downstream also sets "CHGIN output current limit in OTG mode" to 900mA
by writing (1 << 7) to the CHG_CNFG_02 register; while I would try to
add this here, I do not know which exact bits control the current limit
and how their value affects it (downstream has no docs other than what
I just mentioned), so it's impossible for me to know what the mask is.
---
 drivers/power/supply/max77693_charger.c | 70 +++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index c2e8ae367381..e548fd420e78 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -737,11 +737,41 @@ static int max77693_set_charging(struct max77693_charger *chg, bool enable)
 	return ret;
 }
 
+static int max77693_set_otg(struct max77693_charger *chg, bool enable)
+{
+	struct regmap *regmap = chg->max77693->regmap;
+	unsigned int data;
+	bool is_enabled;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_00, &data);
+	if (ret)
+		return ret;
+
+	is_enabled = !!(data & CHG_CNFG_00_OTG_MASK);
+
+	if (enable && !is_enabled) {
+		/* OTG on, boost on, DIS_MUIC_CTRL on */
+		data |= CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
+				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK;
+
+	} else if (!enable && is_enabled) {
+		/* OTG off, boost off, DIS_MUIC_CTRL off */
+		data &= ~(CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
+				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK);
+	}
+
+	return regmap_write(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_00,
+			data);
+}
+
 static void max77693_charger_extcon_work(struct work_struct *work)
 {
 	struct max77693_charger *chg = container_of(work, struct max77693_charger,
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
+	bool set_charging, set_otg;
 	int connector, state;
 	int ret;
 
@@ -760,25 +790,43 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 	case EXTCON_CHG_USB_FAST:
 	case EXTCON_CHG_USB_SLOW:
 	case EXTCON_CHG_USB_PD:
-		ret = max77693_set_charging(chg, true);
-		if (ret) {
-			dev_err(chg->dev, "failed to enable charging\n");
-			break;
-		}
+		set_charging = true;
+		set_otg = false;
+
 		dev_info(chg->dev, "charging. connector type: %d\n",
 			 connector);
 		break;
+	case EXTCON_USB_HOST:
+		set_charging = false;
+		set_otg = true;
+
+		dev_info(chg->dev, "USB host. connector type: %d\n",
+			 connector);
+		break;
 	default:
-		ret = max77693_set_charging(chg, false);
-		if (ret) {
-			dev_err(chg->dev, "failed to disable charging\n");
-			break;
-		}
-		dev_info(chg->dev, "charging. connector type: %d\n",
+		set_charging = false;
+		set_otg = false;
+
+		dev_info(chg->dev, "disconnected. connector type: %d\n",
 			 connector);
 		break;
 	}
 
+	/*
+	 * The functions below already check if the change is necessary,
+	 * so we don't need to do so here.
+	 */
+	ret = max77693_set_charging(chg, set_charging);
+	if (ret) {
+		dev_err(chg->dev, "failed to set charging (%d)\n", ret);
+		goto out;
+	}
+
+	ret = max77693_set_otg(chg, set_otg);
+	if (ret)
+		dev_err(chg->dev, "failed to set OTG (%d)\n", ret);
+
+out:
 	power_supply_changed(chg->charger);
 }
 

-- 
2.45.1


