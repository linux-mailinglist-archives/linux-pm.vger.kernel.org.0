Return-Path: <linux-pm+bounces-20626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9180A14FF6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E5A18816E7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F920125C;
	Fri, 17 Jan 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb+Mcdn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DA201026;
	Fri, 17 Jan 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118908; cv=none; b=RMOUVBoZp6xbRA8hhJzMXGXuQ1HQeXtpe93K4ARTE6QzFmdayO/C1BoZZiYj+idXifsBNs0wLXBix9QQgz4/2RKcJkA+KbFNql+We/oOHazFcI/jdHp0ZhleXeVZ4F/myEfmC5w/0lL6e26mRR1rRLU6LVkzXPcW4VOfNilOzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118908; c=relaxed/simple;
	bh=ISDDYs49rWXOUlJxJE1Z00bffGid5L5PmU5XQ7cyvXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MeXvUyYeF7KNN18ZC9pc4V7LfPCAAcSadmJ8FdKaEq6BXKA1DtIKLuVoMKe1Zg0mYN81mO6qbDbBygMxtwViSJKJArS8R9fT7tcKok8lmSdn3sGZHI3U4ZhCAMHhzBACCoCbPSKFLvlYNZWmMwAOdy5yEQ07ECe6WoIp1WOX4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb+Mcdn9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa66c1345caso119035266b.3;
        Fri, 17 Jan 2025 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118905; x=1737723705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CCIFdmzB6o4lArRy/ux3cMMGIy1P+Jk6WtvkNN403k=;
        b=eb+Mcdn9Z5A0lx6B1XWC9INkK6lwwqajUXhLWQwuCleN5VOs27wNSY39UXRIGS0f7H
         GIjyWEdILyhe+FKzR0m/Jv4oEzrr88/b9SQ+1RkAKRqh1o2V2oQRI/OWgAQHnKP+l7c7
         4yNHVXVA751OFdqnc7bAQsMaxeHcvPvTxHx9YQ7eVsrx+GXuX+lm19c80vx1H6wT8Oxo
         M/t5rFQhKlDPrtKx9QWBoZHRIyf22fEzjTs5YgLJbZBjwBAnhwFmznZ3pscuai+ts9ER
         y5IBpPvnUujiyaiPWPjEbWQZNPO1UJuNTyf8VFRNSIpCB3mYnCEgQzy9PZoA49XZ/i61
         WFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118905; x=1737723705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CCIFdmzB6o4lArRy/ux3cMMGIy1P+Jk6WtvkNN403k=;
        b=auPxQIABwoRl0Z7uVk/BnWTYbSw/6MzlbCgd2w9Y1xmD/REplMDrvzIW3JReEjQbXr
         vacbdzCGJY31Ri2H7+G9/p4D7yt8QPutyv++ezcOM/f8Pxq73qOj8wWzKyA6GOcSp/fw
         tSHu6Keo2PzWmb+plHGfR4/ZnW1qF3hAtB4iddi0s/KvwG3RqhVhF4D8fMpp0k/IeRIL
         vi1DlGgdz4RZlgEG0XKtespzheRQopGU6Aunp7UvMrU7t9FAaPMjkA5TCnT23a7tVijG
         OKh5U0gl093uXU/zeDI3wRISgmiIEAijztpfibFRsBRTmzYFNEWvXyS1jxX+o9Jgu2ej
         u2jg==
X-Forwarded-Encrypted: i=1; AJvYcCURulMbeHUI1sWlFX1uTXki3iwOdSSlP961f4JvgAAVbQwV9YE7CZ3eXj4UMZn8nvB6gRkeIh3QcCJOBQ==@vger.kernel.org, AJvYcCVUsXYFR6UyxbdvSybtaLzjOU+vCT6eHmFA5QkTUh/+OTG5bJjPJSqXIIa1FCPcLCLs8TYBa1g5S+yCrHo=@vger.kernel.org, AJvYcCW6ccErmCm50rDq44eiVPJLduwPLV3B8/NOVH7ScuRCW3p7OAH8WPQ/TpCYdeFp6hSNRfUTwRUviZ9WqLPV@vger.kernel.org, AJvYcCXuvNXQeOe/XZxdBZ5wsnv6AwyrwRlTOlJ5C4d2m99m91xHaumUUfV0pKbf5PsCD4dBEnArm8HSh3C2@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+G7Z9/8b7iUfeQNZY6BZGJkX+GSf1qLKwKNc59YYQsHVOH2X
	aOx08dstn51TJuuS3W920e2sCTvn+s9+dqZBzczT2zsOjykyEZ9V
X-Gm-Gg: ASbGnctGG+XrKzPPLe0QvDrOjxH7BjuRtTjUIl4QDBqwwyQJH/F3b4twnDf7U+jDexs
	WB7WWeJRyTLaqgp/x/z+hBir51M4X20CRAnN+r+VIkprjQaw2ZjtMw7NNc1K8bmMeEy4lAUVpK9
	bOlfM2TapJ0qU9IrqsFqimbvv97UswDZ38B8Nn35sNC0i8yDphNy1jMaTkV7ZCL0w7FVBnoz3qh
	FwVbVs30xkxnBIGx1j4XNdUlwqXadx0+nn4mEo7MjiUU75X9Y8jWAF/1vz+RMkW7DiiZbglfPX3
	i6Efd52SPM3tQTTJHeAHyUovZA==
X-Google-Smtp-Source: AGHT+IHubOJwB/qhAdXnifeCN8Q+B17N41NtddTLrcYB8s/S+VJXZFWYkfYxLfsiu5uMvlp/pBV2eA==
X-Received: by 2002:a17:906:6a25:b0:aaf:afb3:ad63 with SMTP id a640c23a62f3a-ab38b44e0e2mr242986766b.43.1737118902723;
        Fri, 17 Jan 2025 05:01:42 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:42 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 16:01:33 +0300
Subject: [PATCH v16 6/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-starqltechn_integration_upstream-v16-6-11afa877276c@gmail.com>
References: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
In-Reply-To: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118892; l=3819;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ISDDYs49rWXOUlJxJE1Z00bffGid5L5PmU5XQ7cyvXY=;
 b=SMjIIn9wu2YxDkfcN6PB1Q1BJKx64910ZOlTZ0yD304qgyDtBaDaMeski5x+bl88YSGYLYHeK
 VDTN0QNMmHNDtTd84cMYW85mcJBjvY7gWlYeKsiLkP0i9eBN1X3Ar5y
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for haptic controller on MAX77705 Multifunction
device.

This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
User can control the haptic device via force feedback framework.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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


