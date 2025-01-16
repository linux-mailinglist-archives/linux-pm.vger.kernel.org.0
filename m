Return-Path: <linux-pm+bounces-20570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20318A13F6E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFBA16A809
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B592309B2;
	Thu, 16 Jan 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dylZy6WB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F722F399;
	Thu, 16 Jan 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044783; cv=none; b=IpxykSxNrJugMaLLyra+vpbrvnKHljyR3ud3Pi/LbVi5tkEcWhpVnck5Wxd17hIf3geUdYiLMLV0f4orApVfT/srqXX7IJyT2H4eeCiekWu9Dd10f0KYMLShi5fhrr9bVpV+uJjOEjdSfELQjtuP+UCzGaypTrzzkCq8n3/ViI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044783; c=relaxed/simple;
	bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blp/W/kIdlYCRsgHSlwT39PCiUcZHDNitnFO7ILT6HCS+I0Bhn5k3iFRA5oVNHyekxRlOTtrtx2QeL10Jxzw7isgv5xkY7HKrxGV4Nn7c49e1CTY+w9We5skdyNx61v1GvTCHjQ2g+QFmOKjRzLeYAWHhH0BHgNVUngc7hCoRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dylZy6WB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so195200366b.2;
        Thu, 16 Jan 2025 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044780; x=1737649580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=dylZy6WBn8CAU0dQIBKJ54LsUMyojkaV6tErijC8cUKtDmwhC0JutAocwDJN1pExrb
         y7ZsI8cvF4AqNWXppLPgp4yN7RKEsxD59R3ogXruCrMqf9lQNU7tYj6aGe2BtnJmIv42
         qslhkAR8n8eRXJa6GuIZc8P6/ppX41Al0hV6g1OEVytFZBo/tj4/bd377xb9jqaGxOgW
         U5Y/u0aV9hxvgDmiJmTKfDO16+j1wkyMmYw1AvSWC7DvRwNbWWRbiCL2BLrI0OFDaQvg
         STEg34Is/ZPcPD7NIyKJypubY8fQ51tLBskItp/x2y2KN6IqlYpgwJ+gpTRwc5w3U7B9
         Z3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044780; x=1737649580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hehp6Fk0LGkDDofz88Jg2c9t6Nm0JquDsf7Y75Rrc0=;
        b=uleECXHU5he17ufnwSh83xeQ45907rITnDXvqXcouhB32J9C1SWCy3eAtScbQQ4SO+
         YdUzCqG7EL/wZVWh17WGpJujSs3rGz35Vhqt87FxKTB/owjF3samEKqllRgxZm1PWDPI
         brBYIjHsqM6JEkmenZ/Kov09Q0gFKNQ8D6Hc48iw4P7Qgc7vsgdQvbHKNDEfL4Lpx8V+
         5qzyUSYIHxB1NDztz+GwjWvrKhYXQqFfYQYTqsIMHTBSW15wVvJK0B1DjWrpb4XrsmCl
         zZEsnUEHad/B/IQO5Quo6WLcEryzK6mFKCPCzv/Slsxj4U9PJ63Yjh9hmTAMlHPsPY39
         8pnA==
X-Forwarded-Encrypted: i=1; AJvYcCUmuRuExrgLNZf4jlox6X67yqc3AGtLz8sk3Pwm/NxKUMPHo4YvXIAfJXIW/GKItgBv3NCQYwvf/Zrx@vger.kernel.org, AJvYcCV0QO5aA5ybmP9aURp0EL3B0Pybzl/1zCWOS/hP2J02mviEeWsd6z7L/CAOdT8BnRhLo6khsJmXLk+oqg==@vger.kernel.org, AJvYcCXZ1OMUJO1ONJvVu+8cp/4yJJf3UZafYfaNAqkcCWbUXuEGuwOh9TV7Ecjt9wPO0q9ctcEUbG8H3A67pwQ3@vger.kernel.org, AJvYcCXeVkkiJvs3opt2OsLxhhAF7thgr8J2aLbOsXu/uIBX9o+4LFgckhCbo5wy8Y2LagFTr18dtN5PhKmbF08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgU0wEOG/AII6VlnF905LR7haC89GJ6+g++PJUQ9gIahiOVpS
	sC40/iShEM3gCvcpauFnkfYfhBU7bQg6GpcLJ8m49wLEkuMNT3gt
X-Gm-Gg: ASbGnctHAsslN5DZ8qJr9upLmIt7+Zv4Q1LKCvhS2YOdImnqI0oC8hRsoXwwsYSzmS3
	RvsaLCXe/FTSmndH7uZo8F+uSUSA/NBk52LQBENYrDT806k0V1qJCk2xXBpxl7uIAbxJix3WqYx
	gNBxjH9Jk8jSHyAkmwehWJ70VThSCNFisgN97bqEZLcjZbsbdt010fW5n2WvMxY2GB7AWeWDtAt
	ckYJ3wcLrzK1kX0GKMJSqgMKxpDR6bxEPGAv7vf+/rMo5lGQxfWlUeFZaW9i/vqh4HwmCPF4Qef
	4ZwVyWefh6hpVQBqKySfLytCMQ==
X-Google-Smtp-Source: AGHT+IHX9HFSh+6XnphTeILDApMJ6cZ0qVBqUnZ+vLW+/SjgdkEcNx5UWMMJe6SUiDS0kzpn4/1yKg==
X-Received: by 2002:a17:907:d24:b0:aa6:7ab9:e24d with SMTP id a640c23a62f3a-ab2abc94efemr3115757166b.57.1737044780177;
        Thu, 16 Jan 2025 08:26:20 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:19 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 19:26:08 +0300
Subject: [PATCH v15 6/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-starqltechn_integration_upstream-v15-6-cf229de9f758@gmail.com>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=4280;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Rfuhafs6uHguUFNmDxE8iSnOx6rCyPiSTsSr6WCgv7Y=;
 b=+TQZXJTxEORt+/Mp8eIOSP/Cgqm3M3Ufyyib2tfnlnOa08fBLi8bJrWyTPTKPslqvEkQDaDCD
 i7cArd+6whxBwkFWx2TDUi4qlOdQCXIwdbXCfiKbav9iM1dTeurL8im
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


