Return-Path: <linux-pm+bounces-16327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A359AD50E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32DB1F23B72
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7301F9424;
	Wed, 23 Oct 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYp+ZxZW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEF1EF08A;
	Wed, 23 Oct 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712590; cv=none; b=N+b/bY6KnusCC57abeWqNbPWFYXv5/Y5iQBtQNknFKMle0RVqie/Lz9Yc9kLiLQiZ1qPP2N5kfNz7Vlatx+M4J6PKbb+PNIvXxQUkMSNlvFQuwSVDR60g7SWPZ/NgOzPHdvMx1W27OqsZuE4lPOl/5rs56aTEjVWrmsziz8hkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712590; c=relaxed/simple;
	bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLtLodP+nRfHifCg4xVJ950/nK8P9+5IWJqFbbf6gOQcM2644rJJK598qv41MZI6ulQGdeQZSzOCft1/CApWtgr9G38vo89ToFdC7v2QnGK7MSuo6p3yxxMO9RFrDhqkFKdB3e+4OBrseZ0RebqmSW4YRyshG5mnj2Z6snbS+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYp+ZxZW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so68098f8f.0;
        Wed, 23 Oct 2024 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712587; x=1730317387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=EYp+ZxZW51WNfkkzFmbdZiA8sW3FJ+c8SlAmkn1M/9IoULao1k0plOt8bxG8PfwJJS
         yZ0aI6orCpxkr49gmXq12177uZcRQM1u42cMIFAjIdfBG81cs5wKcYFmuyMSQ4gpWmmu
         6kEWJU3Bs6sorp/4ABPJFBmg/GijARc0mFpqaJXwAEXkWi51PzxLxy95ZM7QR24Enbsu
         ad/peG42ICcYUgMK6fz77ZgRnZYbXY3ynfoEE67wu1gNLziG26cx5zZR2R6fRZFEfgAM
         Jxz41KhRnZDC+YQQv/cxPnL+2MFCIIdEKY/Ge5mi9UcqAHGFiQGh2nQDUBueATAzO35m
         QdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712587; x=1730317387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=prIPvd83XaL/wEhhqZASdtNbd5r9/WJQV/iHZndNyNaVJ9HoWepDxQMT+j43imjPPx
         1IV8MHASGFHdGKEqg9VfSSdaTavxMIrhdbcJmHvgq0b0v/G3OicJkqhnmjtF/Anc4Bpw
         NpQC+Hh3dJmt6RKnQ6gJmNZHKYvInkfcwmDtlvyb9Eq88jINc6tW1vUlZUphrBXwKSpU
         FvF1Hg1KbeFL4xMUDyprpFF2N0XXyCiQ6eBYq+8vGhDUp0ti/ykjV0tvD6V1ecsYZfV7
         uNZiYKZvQNye2EBPPCuF8uhmu+4gOzWI7YDEDnPyRGgk8VuUh3FSsNwUHZcGe5UujLyw
         cUug==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7qTOZhrBe6A8Ge0Jh1AAuxneKKvHyoAuHD0iGZMosbHs/qksoViBX6FKAe/4L/ZPI7ou/6iTD4SN@vger.kernel.org, AJvYcCV4EOBH+ah2OhQmNx3rYgnWtSb7ErTsviVQY4AWxrmLyPOvHki7DZgOFJ9Hz9JZYHJQWlqvUhGOHcQhlbs=@vger.kernel.org, AJvYcCW3OpxApaOKXoEj8Mmy9BBcakZBjj4m23Cc3m2q3rXMhh6mivHI+MS1Nd3caAr2Fu9CB3MyE+KVf7/Xig==@vger.kernel.org, AJvYcCWLK5GVeB24N/2UgNDIVSe1UwUhw3ZJ743Y05ITTEM6KSBQm2oQL8f5xlIoRyWkAP05gKjeyQjTWNjGk5ij@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlSEi93UKpwzGHZFGGQY37ZmWGzXK0Nn3LW9YtISmtRw8mo1w
	UnaHpZDx7XpczonxhiXbEVvNMA5M5NjjpIje+Mkz/HxGPhNTXTliGF54wg==
X-Google-Smtp-Source: AGHT+IHcMtuS4g5CWkPpDf1hqUOkbCoyak0zOYnMv4yfD9i4Ub3KEq3JJsYtM2gEQF4GAntU1tqs+w==
X-Received: by 2002:adf:a301:0:b0:37d:377f:51e6 with SMTP id ffacd0b85a97d-37efcfaaef7mr2384296f8f.56.1729712586477;
        Wed, 23 Oct 2024 12:43:06 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4803940a12.72.2024.10.23.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:43:05 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 23 Oct 2024 22:42:52 +0300
Subject: [PATCH v7 4/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-starqltechn_integration_upstream-v7-4-9bfaa3f4a1a0@gmail.com>
References: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729712576; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
 b=vdGJbC8Tannx7jJx39NwjAa6Nyn5HZL4aYawuFkqGjkV51bDTh2ePn+bvQXT106unynTkr8Al
 X00IHXSDBgZAJz9CaRlw1MByIuMejnUEET/mlr1iu2x5N7G5v1HdbNe
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
index 6a852c76331b..b4515c4e5cf6 100644
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
index 4f7f736831ba..3e3532b27990 100644
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
2.39.2


