Return-Path: <linux-pm+bounces-18329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E549DFDAE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00151162AB4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C531FDE0B;
	Mon,  2 Dec 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa8RtJbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6A1FBE9B;
	Mon,  2 Dec 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132897; cv=none; b=fk93bSznJFMUDCXmcgkhPxdV+sFlQPbR8IpPvj5s+fOJI3FzZIb2DHW/TyKiZ5g+e+6rSlL88HKIuXsOv71GrJB3affh4K+9kM/sLGTGvnkXxksRYGsn99yYUDwCkkUSolTAB/SlWe8NsHKIoyUb1aUgz15z072FBMN0yZ2kKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132897; c=relaxed/simple;
	bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNU2LaZD8GwCr3KUyd5IF1esYgdUAGeypVSiMlsH1pGA0u4vsL1zB4KwznWrBXCXDPUbaKP0vvj1nEgY2MwVXCVPNhhFD3L3K269oZP1Xkj1ry8sWBiNX6kbmyhiMdOi4I2woQgcY3VhUWTOtBehtt8PZJIQZQCcXSp0ZfV3K/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa8RtJbc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df63230d0so4749567e87.3;
        Mon, 02 Dec 2024 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132894; x=1733737694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=Wa8RtJbcqLlAmmo7GtU4csuU9J5kNUdtdJ6b3NGBo+jvrGNMvBzKSGou/9vS9BfCsJ
         T7hPqioLyipq8ZxnwxJcM1+o+X4m2yOvVCC/VqKqzzMbxX+yMlbD4OoaUe3bNN+vBwZT
         VGXlHkWhrDAWGEL0mFGAyv2hxV08zVGulY3oULHWCOSYceYfxz1k4/VYOkwc7aCP5b4f
         wT1vo0MKJXwUT0aj7ghb6W9Yy/okhQPBOjjo0k2PTjrLvkzWhbgDDw38AmOTEXt5Ir4a
         HaFzM+gOwB+I1DFx3sOeU70v6a2Mc9axguvXGj73aqBGAJA1Ju7ftxG4QshYePsD2VFS
         EPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132894; x=1733737694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=puLHuf+32twbJO8YOQS9+xSLkq9fpcupKO6/nrrBlpa6D0m3Tkp/IKBqzu+PrlRBlb
         A/I2rRAr3afnZH6Oq1NrGz3OMZgplHyY3Ayv8R4fmv3dbwoKrkTOgiAz7vEAEAE46QlA
         vpPFMAlAzGjt6BOMhLMnDFHG2qe6ngb+pRoy4y7nmcaMgbgUxAhm0hjD2Ze7e5LjC4Uh
         VaADEPas3m9h6gmqZRgK9ynz6ONVeawNX+KehUd32O4bl8EvEftfjAWsbXrj3/lfd/oT
         5rik1XgTPSdUzu/Wu29h5sY4q7RByD5JswSpPsc1hzfBxGjCmU7R+v4v5G4FjLLebkk5
         4R6w==
X-Forwarded-Encrypted: i=1; AJvYcCUvN+/wH1OjnNxcsGPM4khx0f5vvUG4fRZDGzjJnBhKP/g17zl0Y0GcAVcMjJgJtxtDhg13Tlc+T018@vger.kernel.org, AJvYcCUyE3YA37kuXEU5qU1WPLtPm+MX0tRUkcFKs7G6io8OX5xmHJoV5qahtOkbiRjEcOgstQ8FYhvdNWCslMWq@vger.kernel.org, AJvYcCWikQRZYGBNpzCrwcvbVbjSssKHDu4DL791Y3MiPg2RW73vO58mx++N8BBB14LbOcSEczCzfEnTAvQgRrk=@vger.kernel.org, AJvYcCWxWQV6wr9ZIgtbDJzlEGeD+ascqAxQWehaAgWorbdSZNd5HjYffIzvZYMchHyyGR18rFACDO4yJTEfaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTeCYmr2+slTeOio4x9taGcoW3N/fcUFswYcCpxC2PdXYnPaU
	NUKNH0atkAuFvU8MIqUryWTPPZuk8YAAEqDAZxUHgxCWocVYNA2f
X-Gm-Gg: ASbGncuNCUTsS1jm40dlWYW9cjuse4v62o9N5XDW9LOE/2lVB+IhmHtIox+9cTURoO5
	GzO0O7hvD+TJpUOiFAGU9Q73DHb4aM+pJyQoYEno43gHx1cUQjF7EhJ6WbXjomYI/ef+UN3DEYR
	cF/z5cjCdYRiL2fB9MK4lm9TdVXFvD/8KMHToBjzRz+maWrqVoOLKj2T95qPNCl0UTRusHl8cW/
	1s91I0lkqY+Z9Rimvf4iofyEbmztLeYC8JIYr6dyhbZFyfu
X-Google-Smtp-Source: AGHT+IFy8nKAQ/+EZGxu8B3T/ru6KKXg8q4mm69HrTLXSsWCE/wGfNtxj/ujG6Lv0PSykozra5Q99Q==
X-Received: by 2002:a05:6512:3f1f:b0:53d:dc02:794f with SMTP id 2adb3069b0e04-53df00c6085mr11967885e87.2.1733132893443;
        Mon, 02 Dec 2024 01:48:13 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:13 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:48:00 +0300
Subject: [PATCH v9 7/9] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-7-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
 b=c9Uc8al4EyOOH5r5xins8idhHLAwnltQUeKqsgz6o8D/IqBs8bozF8+96zhQEJR8vKvPfQPlh
 00feA+j3VdZBTzK73kRkgo/kHiHsP3bowtsPOJuh9uKxDBTkYYfAGJW
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
2.39.5


