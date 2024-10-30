Return-Path: <linux-pm+bounces-16775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C19B6EF0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B731C2174C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BE219C9B;
	Wed, 30 Oct 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEdi1XQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82294218954;
	Wed, 30 Oct 2024 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323858; cv=none; b=qGRTrsV/JWC+fBm6EdvAQ8/EFFFlUR0lxSamjoS2Hykx4YrN584K3MGYwjb1hp//zV/kK9d+38t8+82JfDypEcLDalu4oO6XknCIOiETsZ4yJ+JNUIyiPbMEHpkKf43TRhkOZXTPoWVFowStfpYke1eDJ1fDCwZ7yZb/S2nOSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323858; c=relaxed/simple;
	bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMrVv9LbAvPmJ+vhopLWkpY0oe0Oa9tOtNPozX4F6pmczOJR36n2TpVD/CEdraqjfxW2HKGZ0z0mPxDq5uLfB1oQHXM9LGp7mA1IoQXNOWopBFp5T+cBPjXJnmLRB8uCWeFqFA9k6K2xZV7mhBkuBqM0JiUoLRJoXSpGbeaCFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEdi1XQn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so33644866b.3;
        Wed, 30 Oct 2024 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323855; x=1730928655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=bEdi1XQndUNZjwjJ/vWF+ZynFRZx5PRtXV+hqM5FVB8jofjlw5eZXb4k1G/0a8aB/B
         WFfD47Y/a2GHSPeACjS9vZdUh5OMazTx4FVNiBEHcfvuC8KBQqD5GObtQeFqVS7ulkh/
         +3PqBsVYXlNledPEYXVqirSaZi+XuEJ+EsPAgnEeWjjGGAnhcjgHZqTRNeLZCwfpziwK
         QHy7PyIKpiw8dZNrr0F/HKmQ2q/LIvyKLm+PhLck8cc04pmJV6OnXDmLWOLUzBjuOj2B
         vrX3VliVpyETDPswdwvx2IL/B4FTz7YQ5RsTI2tCqDRYal3zUuaktdbwrBzpIS5Ih0Fw
         LkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323855; x=1730928655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=XhjGiY5nzxyfmn12AvGUtjcdAXa35MdzFCLXhYJwJKaVLuQgpuypZykN6ICJewNzd5
         q5hVDnKfwkHWQhamnOd1LcSptq2/MwLczA9afdTcTDqZPsRR7ZOwc13KAQOc9Q50BhNS
         ZPzDe9Mlx4ViGN3KQ3hSsO0iPLaPme1XrxcW/k5hWIkhgLk6b1Hz43Ecc7WKOmdEV+Ww
         aUjxceharHYOiNIRtaOHLbFaJ7G+HmCMcP2KosnAXoOF8hax/CUwl9vXKCP+q16m9ah1
         JiHBA8sm9SKwXjzR2InrSsk+OzkVfiihUK1aRxPKO+3YVa78dSyXW2onOuhVUozhJ9eK
         VB9A==
X-Forwarded-Encrypted: i=1; AJvYcCUc560c4fYfe9ichg2JQO2IkjHuQA+KNd8bTWOX7n1dH4p4w9If8doiC9GIfvzfQqRi4dhuT96HFVTCCLU=@vger.kernel.org, AJvYcCV8BZPoCE/Sygq3M9PqZ3MJSrTQcWD0/2mGQfzaakqVKHFg1DWYxFT/O/CBnn3xtgwQG2jzHTB9nQeH@vger.kernel.org, AJvYcCVt6/QNffJtkeVuNkSf6r8uSz01AjnCnVhSUc9D/AkcsvPEDIPL1IPAVyt91HFolH2JmIQJz+pPTlGFpA==@vger.kernel.org, AJvYcCXY5Fmmbb+VjYJzOTAxLoPRNzxqVojNk2iM4AF2Dkd3Xa6+adjuLnbQa6Q6PXoQ8me+qTM3ZmxxwOhDHgcv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5QOkHcIuziMSMqa09ribdLxqoQkrpQkjqhp+ZN2OQV3GwhaJ
	WpKuiTUOnbaIDVu4fkvj9Jksu+1op31q7meesxwaA6K1PKhOdlE5
X-Google-Smtp-Source: AGHT+IGa7s7Bc91D1CrLYShWirMId7zSbZN0ZXh9HYw8f6G+BtK6TGl752fbfnJyEUGZyOFKdH89dA==
X-Received: by 2002:a17:907:1c22:b0:a9a:7899:eb87 with SMTP id a640c23a62f3a-a9de5c90d54mr1708475666b.13.1730323854446;
        Wed, 30 Oct 2024 14:30:54 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:30:53 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 31 Oct 2024 00:30:39 +0300
Subject: [PATCH v8 4/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-starqltechn_integration_upstream-v8-4-2fa666c2330e@gmail.com>
References: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
 b=TjCQFUccNRWTMExX2aRMW7LfQq1My352HAXCJgk2cx210cFmz8ZwbhyO492CORIQOGdq4V3YS
 i/sL9DDfJF/A4MsFMsDXx78SqrV0E8d3lcJxvqNxfc5jNxPPKRxDRq6
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


