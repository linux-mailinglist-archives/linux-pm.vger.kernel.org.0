Return-Path: <linux-pm+bounces-15283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53799322E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB921C229EB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527E1DB940;
	Mon,  7 Oct 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA2MVvO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41731DB922;
	Mon,  7 Oct 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316577; cv=none; b=UD0HyeaIR+yzwHVaRklXlFRTQYZsUK3aRDbAOx6LCREvkZ+L6L4D9ahdo8F4HsfvIbg7TudET9qn0DxXFb1nNoCzWtGf966cKvVfdkYimnTGGDljHZ88zDk6vxyfc7QXwmmS5kqdxL9GrHg7nPOwHU2EuAxk4wr3jxVzTuMQZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316577; c=relaxed/simple;
	bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byvqg9N6zLLsZDLvwwHKdjFnUREyYNZI/un86DDWh8sCoiBnWhBVc/GDdrAETDKJrSL+uOTQ0uwGzpvFibvwdYIEFms2pWfsnfB7OEN5kZ54bqqHCNhC/fOrukwQgwVhawnYXuEPgWkSIvsjSbahc9DPMORmXL8X+0+Z7B4SMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA2MVvO9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fac187eef2so54905501fa.3;
        Mon, 07 Oct 2024 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316574; x=1728921374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=TA2MVvO93q2TPQs4Vka0t2kEQ2M6qoymqylYqEeMvUkgYXdIOJryK8sbriEt7oIqb1
         x4F+A0guLN9nYG2AqGERGvy8GvLOF8WcL/xtwXEFaPwjmFuKH7RZtngab6lnWAkSnEd3
         vB1kl/nticx1FTGc8mv+Y8onok6LQureZT31CHE9lV0tST8prs6z3Kvv+ekMtypD3Xqn
         5xdFQmBwrPGzHfc0gvglT2VIiU3EYCXquPdxc6KZABs9lzF4yiyYNuaJPooKyV2oWyTM
         Hosfw8+v3OcERY69zG31jKDmcPRnvuWCHHOWclTdpGVydV4UqspraDC/5YPDFq9Q0lNp
         4pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316574; x=1728921374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV5gv50tNIl9j7OCpfl/gJrWPboaYw/v/JR/D33ZJrY=;
        b=vHpAXqOiShwGv/1+lhsaFhSYbD4OmSCzQkTEEt+gmVYxmO/WFXjdcdTXiUMXDP6yHX
         RoEUBs0jXcQ/dxqZURQDxsDKz/le46yllfjpajdIvtSqKUM5fxE6OBJ+c8kPKuyn2ScY
         9jVW8zakzjlJCN+CTjlLBtJQv6VR6aaevLtewJkTJpLpr/ZXHIquh4bWfGclVljE1PKp
         83esJgRJ2Dxl6GnnyWbHtGQtPG+NWGW6dn5KMyfTVls91PBLDeam52O2KvHp4vB5Y6s6
         YMxriS559d1DnD0tIX828FvwAOQnsp9mp5+jm1eoKGE0et01xNteXfbXoOcwW5T68TeG
         GYpg==
X-Forwarded-Encrypted: i=1; AJvYcCUbjkl52U7WJnclKL2SYLFOWQXIfKEMpdKMySHsAapYilYnpr79GtixDMn4VVOq+0bSyEhShSOrA+ME2ydP@vger.kernel.org, AJvYcCV0sdur9LWjUHX+0a0k/HI2HanXw+HxUtvA0iSeAwTDT1q27U614/QgEWiiBSOuE67KMK6JsY/aGCkR@vger.kernel.org, AJvYcCWhwMbzfIWhUoZEKKTAiEH8wu2ZcW/OYbIO7GowGe9KYVSeQbWVI79fOdyj/C7dpYMTfRs3cywkQn0Pyc8=@vger.kernel.org, AJvYcCXKa5K2ApheUDEFiiTyBDb8R1cV4x1NFmzCpLXhFWK/56Ov97bt3GFGkvXKglYO5sv5mvNUgXoiqTzhaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJ2Ay0UbTfPkzqDrFoJvIn9Ds4o5DLqMt6HqTFWjXEGDbFoHF
	fuuJkaF7MG6gqTP5PTXmkK6jdpVw9gk1V+OeMfpav5sYoPRxcZ+HekJD4A==
X-Google-Smtp-Source: AGHT+IHLfzMXyKVlFNmZxvkpomGyUhTFEv2tfKc+Nna8gbFwfPAZRcpXSd9Drhz8fPlhrOvXE3lKcA==
X-Received: by 2002:a2e:bc19:0:b0:2fa:d31a:1b77 with SMTP id 38308e7fff4ca-2faf3c2fe78mr48352651fa.9.1728316573409;
        Mon, 07 Oct 2024 08:56:13 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:12 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 07 Oct 2024 18:55:52 +0300
Subject: [PATCH v6 4/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-starqltechn_integration_upstream-v6-4-0d38b5090c57@gmail.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=XJYEk/mCiry62oVQMajkS7XejvIef8TuTfCRS3x2m5g=;
 b=VeEtnCFErQjLwR+yhjC2FRWR/8BlVGCKJf5WQEJZp00h7fRsMovqvR+g1kCc789QrnpJ5pW9X
 C9Sc85A6He+CPXcFQ4XuIdTv8+UTu+5AHQK674QUuORCpCVcLpMI52b
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


