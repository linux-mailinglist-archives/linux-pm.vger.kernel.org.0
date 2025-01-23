Return-Path: <linux-pm+bounces-20883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60187A1A698
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B5D7A2CAB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00632144D2;
	Thu, 23 Jan 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYXgUjLn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F0213E7D;
	Thu, 23 Jan 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644694; cv=none; b=gArJdZk1vPhxPhBbB7V/Q5D8yEacHUKNzl6knJkBh298v5RybrQlP/RAzYVE67b+XhOy1ioyHpg8HzF9HUZWLTWgxKpARWubj3T97wscgp98zG5tTS36GOBzhhRukr2g70WjY1x0G0K6QLKGzAIKpYb0JSjU5BRGbz9M3Wckp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644694; c=relaxed/simple;
	bh=FkO0u5NRw8skWCQr4T5BfI6PJ2TqNKjKFk1y7HTosso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kiCDH9D8pJPBeUrYtpATgB80RrwKMFNVUSTAfsr5Hg/HaygsXw+axJmZdPDWo7U8jm1YWHfWt8cIQ1OVqLxxXZAh3KGzZ33xizgertsyqwBdNXcREnyg4BcUoneUkPd6Ck4zDiyt94jibHWn3cUzSjfLeR4RFgPFbcEO9FeXohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYXgUjLn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab633d9582aso188069666b.1;
        Thu, 23 Jan 2025 07:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644691; x=1738249491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3amNPCicABlRcHRutedrKyGZsu8cj4jN1Va70I6957s=;
        b=FYXgUjLnSu5/WVjxe0fcYOlJH/u8X+ulljU7Jat0cT0SgYcUS+P5ekyc6CKwGyFkaf
         DD7NsNSRJ8+MPSgG6wDbKVvUciDFz+Ykz1Y6VtGDGA8ttJAtK0CFl2XjBfw9H6rpI+h6
         tZtCV9+HSsmkcDo10D/2He4i9LjaXn23vPdHQsm1O0m7CyeklgT3mRtfZXL32cJwvJjo
         x3Jt9aXfuWC4J4F8chDpzZU6AG/5XCxMr6KZ/9ZxCJGtlJA8SROhcr39rq473z59/CHq
         X7r2sj9IodmkQGLuxAYtuCdSTs/eLiZ+wKaspk158jSCKE/EFFcxAGC8K3jv2LqkByyp
         56aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644691; x=1738249491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3amNPCicABlRcHRutedrKyGZsu8cj4jN1Va70I6957s=;
        b=BRSiqdjAlOtRoRvkl6NLQpmgxbfn3MEPhd4IKG1/6DzTZbic6ZMI1XS9QZtOkG2jGT
         Zo5tTFAOa5N+ZygVBEHobB3rhUPbmJ8Dvrt5V1X3eLCOuLuwwFfuchwy9NvNwpz1Mzho
         Gptqdf10A7jZ52sGncjz2viCmkyWwhBjLMtBJzoDMK/3X2cW5YJ2A6l6WOLlgDzkPi4q
         OA38XK0dKEC+TTtM6XlF0wgrckhAvSyg16o+oXKXeD5z7Eb3rEEgUEfTPute/FcNR6KZ
         Vd0Adm5E9eITto9+8jlSj3g9o8Ti7bEvW0GhcCqaSISxLtceHR5D8LmnVjZGois/wyoG
         DtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5i7eJGeq0Ms03IjYvcHm7Sbuuo2vhu975ebduvMDI/INzfkNSL/v6v1FNncDANgt7/jqI3zDUJXvz@vger.kernel.org, AJvYcCUI0alLKXY74Ywuw93sJeg28JdTnJMqTtZCk0xwIUY53CPSscwtjGyEkiNyLvJODZaAB2bOlPvP+5UW/NR2@vger.kernel.org, AJvYcCWNndsaCQW8SmeCyFEpszCcP8Atj4rQOqFeV0A2iH3rQnhBoaEtEPGscykqOWrqPoYvZdzPAw7WJ3bh3kk=@vger.kernel.org, AJvYcCWZ/zGmBPPZ9TqrM6HJOPkOC44n4MmgDQWiTmUjq826VeacCILwKLA2qf+Vd1LCEIf9CcwZZjBWd1VIxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6CrkcpoC2oOhlLG/HiJZqn3uQEaw1lQcHbXQV+aYZHzNqJ0a
	fFoX+Y6trde2wxe1Lqk7mdAlAPwcNKLEc46JYLWtmc6Yva4Xar09qdVWMQ==
X-Gm-Gg: ASbGncuZN0mT0rKzw2h5GACrxuSinGby8sHh/xeIm13z1Hggij+5KgQBPUFp4GOsnmy
	766dMUaGXyXA8KHWVvEuWOT0Ij0QaYB48b/StxLJ5pX3Hp4MMYZnc7y0RiofjumaRp4TYSyXBYT
	pc/iH/miQKeVnNeGAyePsbG50qJEYVP2FUItNGYKBpX5+shhS2HiAaBs70xziO00+k3JOcnYfyy
	tQJRDqHpB0OdfLoVtH6wqMMrWAyghSnv31GV9askAON+D3tMW+EOv+7O7FmpXp6BoJqTYkBh2KY
	FfM=
X-Google-Smtp-Source: AGHT+IHIFheR9FrqA66BvAyPr0Au0lyB7nUwyokPoNI1KBQfe2gzspMzN0NJEzeP/esEFnpuRBTdOQ==
X-Received: by 2002:a17:906:c143:b0:aa6:7737:199c with SMTP id a640c23a62f3a-ab38b26f3cfmr2344221866b.15.1737644690866;
        Thu, 23 Jan 2025 07:04:50 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:50 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 23 Jan 2025 18:04:31 +0300
Subject: [PATCH v17 6/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-starqltechn_integration_upstream-v17-6-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644676; l=3978;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=FkO0u5NRw8skWCQr4T5BfI6PJ2TqNKjKFk1y7HTosso=;
 b=rmipCs4HIup8vKpJrUqVR/70vuK8og8qpsHcgmqMUgO+Tj5rfqdcgNJ2KWezAW5N+HDuzJQKA
 Kc19kx9v476BX5chR5fvh+jtIUGMsEdq5qk57NkfBL4WBsVSkk5Risx
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for haptic controller on MAX77705 Multifunction
device.

This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
User can control the haptic device via force feedback framework.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v17:
- add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Changes in v16:
- merge case statements in max77693_haptic_probe with TYPE_MAX77843
- add MAX77705 to config option summary
- remove useless statement from Kconfig

Changes in v4:
- add max77705 haptic support to max77693 driver
- delete max77705-haptic
---
 drivers/input/misc/Kconfig           |  6 +++---
 drivers/input/misc/max77693-haptic.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6a852c76331b..fe7d821ad02f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -240,12 +240,12 @@ config INPUT_MAX77650_ONKEY
 	  will be called max77650-onkey.
 
 config INPUT_MAX77693_HAPTIC
-	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
-	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
+	tristate "MAXIM MAX77693/MAX77705/MAX77843 haptic controller support"
+	depends on (MFD_MAX77693 || MFD_MAX77705 || MFD_MAX77843) && PWM
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables support for the haptic controller on
-	  MAXIM MAX77693 and MAX77843 chips.
+	  MAXIM MAX77693, MAX77705 and MAX77843 chips.
 
 	  To compile this driver as module, choose M here: the
 	  module will be called max77693-haptic.
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 0e646f1b257b..849c16218b2e 100644
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
@@ -312,6 +320,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	case TYPE_MAX77693:
 		haptic->regmap_haptic = max77693->regmap_haptic;
 		break;
+	case TYPE_MAX77705:
 	case TYPE_MAX77843:
 		haptic->regmap_haptic = max77693->regmap;
 		break;
@@ -407,6 +416,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 
 static const struct platform_device_id max77693_haptic_id[] = {
 	{ "max77693-haptic", },
+	{ "max77705-haptic", },
 	{ "max77843-haptic", },
 	{},
 };
@@ -414,6 +424,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
 
 static const struct of_device_id of_max77693_haptic_dt_match[] = {
 	{ .compatible = "maxim,max77693-haptic", },
+	{ .compatible = "maxim,max77705-haptic", },
 	{ .compatible = "maxim,max77843-haptic", },
 	{ /* sentinel */ },
 };
@@ -432,5 +443,5 @@ module_platform_driver(max77693_haptic_driver);
 
 MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
-MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
+MODULE_DESCRIPTION("MAXIM 77693/77705/77843 Haptic driver");
 MODULE_LICENSE("GPL");

-- 
2.39.5


