Return-Path: <linux-pm+bounces-19695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E659FAF3F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B8616810C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B01C3BF7;
	Mon, 23 Dec 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kor+upiB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1381C1F29;
	Mon, 23 Dec 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962417; cv=none; b=mzYGy6g3qwJBBGY33HdPs0KeddU7qrp9twgEDFUEJdnKGXkwyOYuk//6Z9eo9y1D9DSak5z4YUSPBNK4RqCS/OQdA8EcIEAIAITsYqugoFlRHtmnx44AWwXgrPpOX5nkPDoCucNeKr+vKu2f0qcq/LZGPl52hZfUi/G8rGIeDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962417; c=relaxed/simple;
	bh=8tiL9gYxosgDGJy5CegOZ2k8C1ERDVZ0anDBBusV6lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCSZcVmUNzK6k1SbsA4SaL0+VwvU8DIH0cCMgikWcnaTtgDS04CkBfkoNb3Y4+rgKFzrpLd4vY8DWcLj/cuKH80UeETij5Y3Qt+P9SaoSaJa7EHoeX96c5hm4LKm44Vg5CQUeEbNBXMTJ25+b64TnUR2wd6mL5BFACuIweZtbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kor+upiB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso5040408a12.0;
        Mon, 23 Dec 2024 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962413; x=1735567213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFNHeHsI4W8KDDXKoBZPMpG1EACtJr6dX29X+XrkhzM=;
        b=kor+upiBFjDTTH8aYLvxxHFjBCGiZBnQGLsoegs+wWIi8UG8o1oCow8IjrQnE8NPI+
         FWzOnTBWS8BaK8Ilo60mjU1VCr+yskSjESxnGLu43VrmlmrFqFYBKhkuL0k45nW3lWhg
         +oWML3aPsoNfOQwrTjElKfZTXPtGhZeNPzPRiktoqkxcv6am5bbOMWn69LCFKm6yp3f/
         VDwbXvgYDETKCOrH5aI2xtZU90Oo3zEziRpkQnlx5Dc75QX4iy5G+9mjZfIclHChIJTN
         C07ajB4tNGVWf8FSglCyIGj2gqqm+ofzV1T+T1sK0EviKowOrUehZB6qicFdbahjU8av
         +nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962413; x=1735567213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFNHeHsI4W8KDDXKoBZPMpG1EACtJr6dX29X+XrkhzM=;
        b=ApiYoCUE3MIUWrKI+doVUHmJzbWQOKEScAQ0x+DJXwbZzasVRPFgXdyvhuKvA6KX0g
         SQXfL89bk564EIpdPjVqSykM43wSjqHVr17iO/RCTynNvSo+nJ2WjYPs8vwoshpJhGS/
         1TGvcSkdi/jAgogsUl/NN7WgM4+9QXVfAH7Oc7ZJ05t0oIfgXTBWU6SttZtpi4kZhWOQ
         aFalaROguWThGMSl6DeuFG6t9GaoukPoRpT37Wklk9gpk91CdAxRicJpWEzqwr8hmrFK
         HzMmxw0rzi3lNsoUqETTpZvReZ6EpFWjIZmZvUKe1/elTMnfSEbLH7iidow7ch/zNkWb
         l91Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4KenF1O1yvVkNrgvONhuHxw8tN3O+ktYx3JIJs40i2M+qJLrcEcSfx0syX6difJdHwjGZgUGxAKKd@vger.kernel.org, AJvYcCV67yOiv3c5C9Z9FAsD8pTjhJGx3VhxyhfSMq3YdZRFaerRBAA2IwJHSx9X3LHDo/u/H4kFbxN7eXuZFt8=@vger.kernel.org, AJvYcCWO+Rvu2wUFdoxnre0vfXTf7D6Cb286dG0kOmswH+cIbX7OLyn8X5NMU0tieC2oZzViqfAa4R+O9ctD3g==@vger.kernel.org, AJvYcCXxmCevms1ADEbCOrRtiuja1Squ0s3TCawwFFfBGJ9v+Iik7c1CwV57f2MaWTtyk9HIbb1ZXRB/DqV5ROLg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UmyXfu+u0aSPBoulEpS3MiIHvzgWQefmMrZH54LyMVfciFgV
	WzQK/cx/sQDf52RuzZWCr3WanBZUoI91SnCtxKhEwO6QE36UImIVvGWFsA==
X-Gm-Gg: ASbGncsH/1QCvHewCw9O6pm5lTDJo/7i3R9RMk4nFoezf0OVEpWggK6gKeAaUdjUtX1
	leNtPE73eHc3KEEGpqX39yeKiSJ02CF602GcgJsTVrKtV7SM3CG4vI0TJHEOp1IH7MGmFKvkNXm
	+5eOtQcvdqxQc6lMHd3y9oYI+IdTryY0AD4/O4i5Ua22IDNppKvAzJ2Rgt/4tdeGP5uLI+mK8Lv
	NPVYDsmeuZ1vL3lKG5VHUhFCivby22gw8LdFlF7C2eJce5EIdYDoLKNkMtp5uuVd6S6NW5l/2fj
	6VUAU8x0zXZZRhERjRPFS1915w==
X-Google-Smtp-Source: AGHT+IEg61zEwDjPgzo8LK6a+eOlKVS1A0Ga4gpCDsVLKFS0Yws4ZyaLb+sCVfhID9KHdNSEFh55Bw==
X-Received: by 2002:a17:907:d88:b0:aa6:86d1:c3fe with SMTP id a640c23a62f3a-aac27130bf5mr1169690866b.4.1734962412990;
        Mon, 23 Dec 2024 06:00:12 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.06.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:00:12 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:46 +0300
Subject: [PATCH v13 09/10] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-9-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8tiL9gYxosgDGJy5CegOZ2k8C1ERDVZ0anDBBusV6lo=;
 b=K1UTD9G46syR4BLMtnY0dNcQUXDZpJcH7IuhPHxBxW+GlLEQZNFzliT+4P9cpkqQD/C2kNQAn
 buYXvdODMoxAjzcY2vTpwZixum2ffZMd/YDGfOa3ZM+PGNLtN+cfjug
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


