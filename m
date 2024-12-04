Return-Path: <linux-pm+bounces-18574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD99E4568
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F85E2843AC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73E206F17;
	Wed,  4 Dec 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9K5eTht"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA5206F0A;
	Wed,  4 Dec 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343026; cv=none; b=rN8E/MpnqXGtoMAiawuW3oKryLh+x1eMvdUpD7jtF+KmtGiYA9WZl3okguR8cMbAYJMjrhnzs9zK2NygNOpIkFOKdp0aVAQ0XRMdgQmFbAODQLkvxJ4C1nMSX7pMCVy/9l7hbyqOkBZgC4U1y0RHKMrZDzPJ07gU0zikKT4CL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343026; c=relaxed/simple;
	bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpimcpHQ6JSll9LhG61AXJtX7TJOaiOJxhYn3vCNtFKiyIrRueHzYX1E9nIsgPRBrYnR0woeAu28zsaoMEKevkLxFa/zZ5/nhzUAxXR1KoBDuvCxqI3FQx3Qh+CiQsQzrlR2ogzJCzPcU1IUNuXnvEjQ8O9VcwSrHCa7ZQPcjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9K5eTht; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso1139431fa.1;
        Wed, 04 Dec 2024 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343022; x=1733947822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=a9K5eThtjbAvI6xAqE/JTQzLxVZf+IZiz7k+3xF6Tpe2Ta9tejT+5g3vQ1pTEuQvuY
         IsV2Ml2DkIzS7bnAspX001vYsPqN/bD3tYk3SGO9xYvTeoxyWlyelXlg36J/gYQS9eVI
         oRC4StKnv2WckRDynvuDgeUmTboC+hZNOX+fgU4cDIeU7c8IinfEQXf7GWvBQxCfGfdq
         NUJN+RHpX00jFjroK67BdaMXdo2Hb7UZxyrEszT+Leq8Mv0+XtuxbrokqjvSlhm/+wn9
         lMBL5j2o9/qc9hzXnOJ/KBjtcnwbhW9zWAL08jqG1Otd2f2sYpKGU7uWi7mcrBOiA5ep
         MTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343022; x=1733947822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=WIjkmXfqZB4xEQlKUkJjqjV0PA1smmMQoHAyiyX2DnXFq/ZU6LpLoRicev+Yo3p8ck
         ruJOCxvFRQjlSpiJC0/L9+Sj3E+vFX9ntFRVMcwBPriWeoc6OjK8lHkS3nlTckSZ2RSi
         wVmQt/nTaK0S0wpwKLgaLY5poYbXXfeC7Akae13BCmDuxhxvK5GEUwtTMD8wM/JFoG7R
         4idH17JB8TjdWf+xdLstNdzf0ABZ7dRJjk2zdZpl4BoR/cZf/q95m6YTzKryQsyddyv+
         uhIghHnTFPBdzJGpDkjYIhAITZFMNOkDOQBOmWdrkZ/Zp4mpx6hIrsluAEeoFZQI8aTh
         4POw==
X-Forwarded-Encrypted: i=1; AJvYcCUELogzGb2aDll8DqpEm46fdCFl16482T7c1iaiJFlXRC422wGdiKr33Mqt3dn5quNwIfOL+sNgIxppbg==@vger.kernel.org, AJvYcCV6WRLGgFS1j1I2VrosLfFx5tR82FIbKvvJLbp57JZhn3kRnb3DqqeXpEWbJtBVF/l9RocWcy33+VRt2pc=@vger.kernel.org, AJvYcCVKmYaSPmFFt4gE/yYWKh5Eg5jMCKw8qwp9mRynkWZk76pVLPT1Ik76V/Ndo+JDJEN7tm+jFhfKPAFr@vger.kernel.org, AJvYcCXejuHZb0PUXkdObozZUIQDeg/wrZjVpjbNk2Hny/+jrGN1ZHikkeAfn0UgvVCsfvhoyICA/LKYD4MwQsYn@vger.kernel.org
X-Gm-Message-State: AOJu0YxjzvbkcLJLJhVSjV1C0BRU05GPROicBMwemAKS5q2toDVWhEW+
	vbbPisueAgliTYdfP9JTS+Xs0oRMO0KfYxKy2icj4oLRDeTI2NejeJzznQ==
X-Gm-Gg: ASbGnct4S6j7hIMEIUHnvb6rElE+G6cFIVS5jK3OLyc5mDB/mY7zOnwoTa5q+9vApx/
	fIkuCOYGTBQ2Bx/YLulAegTBoiYvNpz5LIUzp4NSBs3dHCirWgm38rUYs3vxQClniZcd2HCGmTm
	6Q+hbj/IkvFchXZ5bRX9u0sC0Wv6P2rEiO3O40kXnyxVKvoTgD6xzMLlgyKRXCLdsUFHDVJbOak
	RG5E3oDYwkfo43OUj7qes68jfamId5iVB37f3zIulfE5cMK
X-Google-Smtp-Source: AGHT+IGZrUw0Uqskhy33YxpSUcn0Hl6UO10AFU7WIZmAgu0SXRY22m8TDbMFBKIzEqAloEFPpGCpqQ==
X-Received: by 2002:a05:651c:1991:b0:2ff:5d45:88a5 with SMTP id 38308e7fff4ca-30009bd52bbmr53499651fa.3.1733343021797;
        Wed, 04 Dec 2024 12:10:21 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:20 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 04 Dec 2024 23:09:56 +0300
Subject: [PATCH v10 6/8] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-starqltechn_integration_upstream-v10-6-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
 b=N4NVryC0bA7+sOEPM47/CNA73DZy2jl8rkCQ2gukmQ0dV8elhN3lgufKmhrcP3CXS9ho3phpW
 dDaUQzQWjHqDrG2Td5fejrVn1SUu9G4kjG/eD6aTmD9INT2Uaz+HIoJ
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


