Return-Path: <linux-pm+bounces-20099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7EBA05E57
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62E13A608B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EE1FF5E6;
	Wed,  8 Jan 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI/i1Pt+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC751FECD4;
	Wed,  8 Jan 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345663; cv=none; b=MWgYuoGHT87BjVpokO6wXpfCoIG+Kjw3kUHTkHl9iJgu2MkoyiCN06a7nctPHgk4RUxAdgfWn2ShOHCOFpokIfrNiLGMImEkYXG4uQUkdK3ysLpiTe3iEQXjKF4mwDcpwFsBltwX6L7dZvSLJEerku5nQoMAOEqgNVfcMYiVLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345663; c=relaxed/simple;
	bh=8tiL9gYxosgDGJy5CegOZ2k8C1ERDVZ0anDBBusV6lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPzGSL8ZOHBhTfk94K3rzYBToAs7ufGENu1fzMp7A+pLrWwbW9MZH+/n0JZoGUdsaor0ifuilPE5ij1JmXW3pzYMl895dD0RnD++BiuYu4pGq9AuGOshoQfHRt/eh6xMzLJJ4mmln1Sa05cvL1HWeTqHMzgn1GjkZFcd2IBwLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI/i1Pt+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeecbb7309so517595766b.0;
        Wed, 08 Jan 2025 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345656; x=1736950456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFNHeHsI4W8KDDXKoBZPMpG1EACtJr6dX29X+XrkhzM=;
        b=BI/i1Pt+XNrBWoeexQzKYBqEI3Km5jZIRh47lv2fVOFXqaGXMSOzDjm3kKlM4U1Wqj
         /u219Nb2qYFUd8dQNEbpPgQKnsSUTwFqzus5S8aeW/0MlQWUkxOrDX2KOyw0qza8QUHL
         3AlKgQyPEpfPi6Jr57UXyu77dcSzGN8hmaBJYLzvPeZE1XaBu1bqzUGJi1liA3OKRjwL
         aKowsLWrQTMZMeykxFLUP+ZpTX/gzpDakoyZjrOruC2c9OOYQ43UXp1Va+MhB1z0zQly
         5zt19vgTmVE4IGYz7BCoOetrI3dge4sLtmrrUdU9u7xDzsHhlqvK/qVJXoeUrzwI7ouH
         lfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345656; x=1736950456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFNHeHsI4W8KDDXKoBZPMpG1EACtJr6dX29X+XrkhzM=;
        b=lJdAcwOXWFRdclXuwYlLKG0zASHjqD2YVY+1EvkyaxYJO7UkUFtJAF/uaSFYMzCvQR
         hwynbNuZuTnC1ssDSqM2DZD06AI6pjSXA+OQzz9Z38czBFVSsn8HMACOmIfm6Nq2frU+
         Uj1sl16Z+lt2EAQD7fpKYflkajM0WxOOWois07Z/isPkkMr3qeZhVIg7212RU/FIAO+r
         IqfF4UU56SQGISj9h25VugYbJHE1kM0LGMw7CHRrl+57GX3+3mx+P08fPRWh/c46BuG8
         /Z5+tBRvn2L8GSkmeplDltUNQzdYZBQal1uflxolQOoKbe2dP+dsCnvEFmYRaICKJXly
         wFYg==
X-Forwarded-Encrypted: i=1; AJvYcCVjRjNHIjux8ogOGOCGwjkBy4aVM+uJyTeRuSbt9fMGlOCSAlfjE/mZT7eDd9PytNeph7DGPtOmn9I/@vger.kernel.org, AJvYcCWFTvRs4i99qKb/k/w6s7GQ2RDGQjOsP1UTbgfoU9CDAN+MIr/Q+WogLxUh1Pj2KkSMalBMggT03hkIX0zR@vger.kernel.org, AJvYcCWGKOFjV5a+ooGpgnUwwusqajUurF0OEjLayxhw0gg7m0IjG4ITjdcrXrAvrtM2PPnh8UZj3R03tt3wINw=@vger.kernel.org, AJvYcCXdIFMmoWIIHTnPg9eRlbdla9g+zjz0joAbDAl5fyl3/4vmoqnjiDJHTCmqoYEBcb9CxYnVDYmpnGEW/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzETHkf0N8/3pd16LEEs0pg/Ext0Rr/zyqngW1/nFenpApnBBP
	zLj+qB70/isWsNAzh7W967QZsEJMa8Aaqtrh/T+yTtxTaV60AYqR
X-Gm-Gg: ASbGncscETTJQFaCalu1oPbJ4+1g+N+vARWoIZvJU+XKOwbuX0kjU68On1lykXw2SFz
	4IoOiQAtOwkVAJaFj+BUJcwP6HUs/9ru93TfyrKwnwn2isf2ipXzu87LpuQ83OZlWGyiME2WY1x
	VyOVvXRYynEOZrrKNyyVJdhONmc+PpAeaFNu3sq2GyghNf1xk2DujTK5k2oRiVCoEBiuly/Lp35
	ry1KZ6YBQOrzpJc61n3PsZOMLl39uKZYsjd5yVRD+zFMSXsYFLcI+Pq0bZsvbqYKJKZrQz5uIg9
	0FNwFHup/UZsv4nZZaTAg0HgAQ==
X-Google-Smtp-Source: AGHT+IEzSX1lQhwRH/FMUCi09g2t0wBsvJ4BxxnOugLWzrylG5cuApHzYRjaAJ6x5y3ET+pU/5eB5w==
X-Received: by 2002:a17:907:1c22:b0:aa6:80fa:f692 with SMTP id a640c23a62f3a-ab2abcb0a84mr263044666b.49.1736345655988;
        Wed, 08 Jan 2025 06:14:15 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:15 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:53 +0300
Subject: [PATCH v14 09/10] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-9-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8tiL9gYxosgDGJy5CegOZ2k8C1ERDVZ0anDBBusV6lo=;
 b=7/GEzX57OzrPukTfTeIpYZV028IETUWDB+wwFFVGbTYiCyijhx67orgEIpdYKZfNi5SU6D45s
 sRGIB2rdgwsCvvVke0gScl94IID7+IP+HD//9iSq+lTzTW9Tt6AuU12
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for haptic controller on MAX77705 Multifunction
device.

This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
User can control the haptic device via force feedback framework.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- add max77705 haptic support to max77693 driver
- delete max77705-haptic
---
 drivers/input/misc/Kconfig           |  4 ++--
 drivers/input/misc/Makefile          |  1 +
 drivers/input/misc/max77693-haptic.c | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 13d135257e06..b9db5abcde08 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -241,11 +241,11 @@ config INPUT_MAX77650_ONKEY
 
 config INPUT_MAX77693_HAPTIC
 	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
-	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
+	depends on (MFD_MAX77693 || MFD_MAX77705 || MFD_MAX77843) && PWM
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables support for the haptic controller on
-	  MAXIM MAX77693 and MAX77843 chips.
+	  MAXIM MAX77693, MAX77705 and MAX77843 chips.
 
 	  To compile this driver as module, choose M here: the
 	  module will be called max77693-haptic.
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6d91804d0a6f..e70164dd73c2 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
 obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
+obj-$(CONFIG_INPUT_MAX77705_HAPTIC)	+= max77705-haptic.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
 obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 0e646f1b257b..c3b9d33608d7 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77705-private.h>
 #include <linux/mfd/max77843-private.h>
 
 #define MAX_MAGNITUDE_SHIFT	16
@@ -115,6 +116,13 @@ static int max77693_haptic_configure(struct max77693_haptic *haptic,
 			MAX77693_HAPTIC_PWM_DIVISOR_128);
 		config_reg = MAX77693_HAPTIC_REG_CONFIG2;
 		break;
+	case TYPE_MAX77705:
+		value = ((haptic->type << MAX77693_CONFIG2_MODE) |
+			(enable << MAX77693_CONFIG2_MEN) |
+			(haptic->mode << MAX77693_CONFIG2_HTYP) |
+			MAX77693_HAPTIC_PWM_DIVISOR_128);
+		config_reg = MAX77705_PMIC_REG_MCONFIG;
+		break;
 	case TYPE_MAX77843:
 		value = (haptic->type << MCONFIG_MODE_SHIFT) |
 			(enable << MCONFIG_MEN_SHIFT) |
@@ -312,6 +320,9 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	case TYPE_MAX77693:
 		haptic->regmap_haptic = max77693->regmap_haptic;
 		break;
+	case TYPE_MAX77705:
+		haptic->regmap_haptic = max77693->regmap;
+		break;
 	case TYPE_MAX77843:
 		haptic->regmap_haptic = max77693->regmap;
 		break;
@@ -407,6 +418,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 
 static const struct platform_device_id max77693_haptic_id[] = {
 	{ "max77693-haptic", },
+	{ "max77705-haptic", },
 	{ "max77843-haptic", },
 	{},
 };
@@ -414,6 +426,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
 
 static const struct of_device_id of_max77693_haptic_dt_match[] = {
 	{ .compatible = "maxim,max77693-haptic", },
+	{ .compatible = "maxim,max77705-haptic", },
 	{ .compatible = "maxim,max77843-haptic", },
 	{ /* sentinel */ },
 };
@@ -432,5 +445,5 @@ module_platform_driver(max77693_haptic_driver);
 
 MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
-MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
+MODULE_DESCRIPTION("MAXIM 77693/77705/77843 Haptic driver");
 MODULE_LICENSE("GPL");

-- 
2.39.5


