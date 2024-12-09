Return-Path: <linux-pm+bounces-18820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C809F9E9256
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22D9164E92
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE292236EB;
	Mon,  9 Dec 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APdchls+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713E21B8FC;
	Mon,  9 Dec 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743774; cv=none; b=ltwseSTj87zzF2Gswz1RxtwaSpyw25k2AweC2xr1XEMMVBT/NSPwgHWNC6p9A6dNrWLLxA4H1yGfmDAD5yoxSuIgxi1L5iQ5nq/ZSltNSP17zPsug38tk3nLk5M2gA4Bxlwst24v5VpxuLATF0WS/dvap1slbiOXuvmZbw079r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743774; c=relaxed/simple;
	bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYYZ2UuThoRlUiF8Vqu3O4BPt5uuSlmrnPlptyxXb4Zd88wMI6xhtQ8xvKDtJE8B4aSrrGjlQ4+xEgYwzjRXyEvt7NZ979J25CDm5fs3XRfLbzBZvjwZnVYPXPm7EyJMVMAp4J3ONZfQPWJDYkJYdPT1ADyR4HlnWieSLm1jQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APdchls+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso133627a12.0;
        Mon, 09 Dec 2024 03:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743770; x=1734348570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=APdchls+gagYyeSnUs/XYWhfow7kPaA49Ry3McFdl11q4qrhgXNXXWcFpK1qwOW984
         XEI+gzyZKp3ip61Cnf55urQJhD++7nCj3UkH9piu8ty2fgwgwsXo2tckD3K2bQxY1ab4
         qmVOyEdozvpTWddmexi45T4aUrgW3qb/YtmNdDdrKicSvEmW+XMm0+/kWCjGbmU59zCu
         JdUCLx5+tfnx8nCMekYCwgv7Ug4+IfZdXsCTC67sMHOX18rpzX83Yb13Iu3DlsTO23E6
         +XX/1PFg0J8jaeV6E/epadv4SWxuQlKZYYpytHaAb6QK3Zw1E3dOF+ioIVMCbN6aeBFc
         GaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743770; x=1734348570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=pudYB8wPYX+TDKXWBMV8pmMtba79826SfMhXr3lYFacySETvEGpBnsDpX45MeeTi/x
         +LCap2ROl7A4ZmS0/EqSJVdae61nqfeXguD/JhEcwdo7RtbaH/q+9r0HBUmy3gLeV0Zr
         HFPCHkWNnmYlFfJ0m6Of59iq0Vw1UHd9eOC/WipFITCzbWYWtfdDgMgsyDo149gVwlyg
         DNhciH8B8e+eiP0aWHOHqCgkHWozxhR8s5tXBq5kC4MAzqtZq79EAnbKhdBsHMbgOFFB
         4jz/EAYPZBvZnNEguf16mat9xWyvY6yPFsK8sQ6zB9UWb/6oD/WC6t4/reNlFydqK/zy
         eGBg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJkjBR8bDP+x26w/DZWofs5gfH4Ogog5OLk67jz7pXD4koGXTISN//tXxeDgjAwdfpdfzhkiyrx51OQ==@vger.kernel.org, AJvYcCVzfSszxxkh3gbsL6yhpL3/ZsECz4WFWdFNYBN4+ZMLtLoArXc1vfZlgavUiWYAI7OGFMwim6okJmL1sHiZ@vger.kernel.org, AJvYcCWjUIJiTqtINu/dCoOzc+JCj0dTZgXA3yxJMSygJRCCM318B7EE8CUaiGvhydWqs/tQUKvOkhDk+JEXn5k=@vger.kernel.org, AJvYcCX8QxesXwU6IlhylQZIn/iUQIedYJCqWs3u6XpyfFkg0oQEnxHyLo/6fi9DV1Ans0eHNJOZ/jpZMuQD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy772j3bxvIodpYwQGa+vZ1oQRoAiTGr6ZvcTU7sKEGUrZ9hhtW
	7QIJ4to0ad5FpcSzyfg6KBOCnbXHrGyL8X+mklwgv0uQud6wLNdw
X-Gm-Gg: ASbGncuGZUGr97VOfkWW6/WrR3wp/ZVYWAbBskV6hgBTsLvQa+s6LH8G5EZLTBQjltx
	HJe8D4dZxoQipooHX2d8Wwhftej+c6phtld4Lvc1KKLoh8prxkwTvuFW0EEAK0giI8BFTGVybP5
	FATia4CH8/80UTQLkXx10mNWWjmUyM3Als24cBAOhPgrK8HhOsi6CXrlXNLJDg3JOYHqnX848/j
	e2Gkea8a3dU3CRc8k7AM43Nt+2+SGBai3uJ5DTO5zDyKpVm
X-Google-Smtp-Source: AGHT+IHilM1vWrJDSZEVZLg37j5igTbmYXqZzyGoTPcUgpaMbLrQIafk2jwdY5E/jvXSNjc7fmDR3w==
X-Received: by 2002:a05:6402:280f:b0:5d0:9d7b:2064 with SMTP id 4fb4d7f45d1cf-5d3bd6475ccmr14523920a12.1.1733743770297;
        Mon, 09 Dec 2024 03:29:30 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:29 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:31 +0300
Subject: [PATCH v11 7/9] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-7-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
 b=6rrS3vg5ZZqnA4h2oic5mSlisnQfHhwsugorLgdOQ0BV6e4GK8r/6gNgJwFLx/yoeaZqq39o0
 MP0E3xJEmV7AmF95isMvD3aEbNArqTVt0l65xMKi+L8I2eXa3DKZ+7L
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


