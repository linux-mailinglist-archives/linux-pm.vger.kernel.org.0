Return-Path: <linux-pm+bounces-19388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FE9F5431
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F20F173DE7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDFF1FA16B;
	Tue, 17 Dec 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg7Cf+b1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2E1FA144;
	Tue, 17 Dec 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456651; cv=none; b=duOWSZaDthPd5p4sjGTBflk/Mg/ULJ6tCAPFrzQJBjiwUlfzsBnenZ7TqSJWJa2KKadzwS+Q3sw0u3Co5WCS/3VbUJv+ofEVln/qf+v9qhcM7sLEJboSJWpW+cPmsGikwCSg6Ux5OZVoMV7AuAgmO/+802ad6QvLNAeldOl1Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456651; c=relaxed/simple;
	bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lel8Y2LoMEqfBPSKqLa5QJjAUClv8GYaC6JdnBwNyhmiK5+3QnRyjgE5058UBxv/20Qa7wjvlrrRzbb0cXdA+nEsOMac0R5OygahrRuo5BQ0ahYv6rcJQ+Zqp3RZe/1lJqn8znCcE6388LOZ+0VqsYf47BycghbhDTFPrmDiiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg7Cf+b1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aab9e281bc0so560833566b.3;
        Tue, 17 Dec 2024 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456648; x=1735061448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=gg7Cf+b1BHw2ZfMFNl3sFnJokzNJaRlOnBjBfsIqGLs0EOGdVgQl2YFj3EHNwg/tzN
         qnfliaHCw1sUrqJp7Y4KRC9576eTuLTMao7PUU+KW0aE8oUNDxj0HMzz2ybo7t0EYA3+
         Ba2B2BQE99Uc0JE5xK+jGTP2J0CljtO5uDedc32wv8fgcDS/XA3p4r4yf1edCRqo90t4
         vvOOSVGBmOJRSHgWyJA0CRE/v1o1LptxA9mlRumOK0lt3XJSaYM8kDlVbsxQ7qz8ArWA
         9s2N+FFIvdndtKRQiIGxOVF2A9gRJWIqFvyACAJewzYjAByjRSPQAnT9jzzlBCMCP5/7
         /6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456648; x=1735061448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=MJJ3ps/nMU7h8uKE0Z/mByTKcdB9+tDNW/rctXMN0sQ9o7/tYDvEXp7LHTFf6cQFHS
         zjfM0s6wMCHBFL1zf+Wwgcu7gRuLxCKvqQ89oDD/66lqpIXsTtJuHKHytKgaIfq7gmDw
         XfjBKgQjB0oJXK/fnKqHvyxXsNKkmubhZ2HxGYAGte5zqUKDfYK3p/Xnc9B5tl8WJRHr
         Y3Xk5JDb5BX1ulRK3l8xsERj0VP0qKIe2Ehb6aatoZbFG87BuvTZi7AWWsdnRX5zcif0
         rWsy5hueYw0qvyURtmhHgs8ykdf2hekEknLJXN0f5oCnW744EW7ucf8hUuAKRTebHic6
         9IcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTH3MW/kwFFg1cPuq0FLl3RkjGc5KTsDxnRnESNzjjFiJx03obwu5H7OsIb4izAJzerNHn3g+n4Sq@vger.kernel.org, AJvYcCUjJ5V13vn/QoErUNYBkiJ/5cXzIipkNkQIVtEg9OC8eSORh0pPXbdc9vCejMtSPWuyJf2Fg9mQTlS8ljuV@vger.kernel.org, AJvYcCVpMbuxnDQ+zWyYxO+9GQcajE4ahF97UBPixzbi3DBfUE7eyqsB9EYWQ3tPBCnGk9ikAG4QNdDoRqSBmQ==@vger.kernel.org, AJvYcCWLedmw2+mVSn+Kmh/V4kjOTmx3lY2oaKlNnh/AMA1dE67oWRqWMGTmocJOGPktLhpYcsbRPh8iys/eEMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCVklWK0d6014T62SKdue3abtHd88EhhLaVMJ9e0BX/4RBxiI
	1JYDOjlgT2lxL4kxURKanGa9Ob+uoOrtvsKDLCRmwBPSHJk62fxU
X-Gm-Gg: ASbGnctPFFMGmls/ywWD+jjPet41iv5U1FXEI/Hiyz8CFZV6H3jIHxrRQAL1YHVjWqq
	OWU1i8EPpmfq5EG1JMu3nyMfIlozmIwT/E82DNkouFwpxp+9P/3VxG2h6Fx7wg1oYh9DCt+s/SY
	IpnQLfOwqDVDrxjFyvJq9DiQU+uusBt9yPQTpCFpwy+VHcnUgsOuACka/ALybHF/MfzD3eD5f9z
	5i6FDi8CzgdkG5KRFs1aRw9OAcg4rXJCNcqyfffNQpW4PUfVWDfCeU=
X-Google-Smtp-Source: AGHT+IEgxmMS021zWALktfW0/WeeW1O/TeJwlg8Mpo4YHkquoQmwom2gF6hwY3fps47Aoe/az9TEuQ==
X-Received: by 2002:a17:907:3fa7:b0:aa6:8fed:7c15 with SMTP id a640c23a62f3a-aab77959344mr1926500066b.17.1734456647675;
        Tue, 17 Dec 2024 09:30:47 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:47 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:08 +0300
Subject: [PATCH v12 10/11] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-10-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
 b=XrbgvSFa95p6bwek9PAO8aQ9cnnXAf8gFi0nBFP6aMUwFpFgleAa8ummKKhdWZWJ4EgjKS7hx
 d+Y43PyJ2BbDhb2+DjGQdpAUnj/6/JVH3VDsg5yRNeZubwLbbsq267Q
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


