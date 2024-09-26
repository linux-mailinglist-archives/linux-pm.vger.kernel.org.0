Return-Path: <linux-pm+bounces-14817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1F98714C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24991C23299
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58291AED43;
	Thu, 26 Sep 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL++dYzT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB01AD3E3;
	Thu, 26 Sep 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346063; cv=none; b=RqhkOtsdMNpXM/vfMz+GGbUn6G2fNSgoNWtKmzAuS/mSSmijclfBmWRSZhpl+/4PECHgItCYFQFO0RNiylcyTKvsyDTZecBy1q9JJZjscn6RXGGLFEWp/AZROPXks1s7t/0fJl8uXnMutd33X3f4GmQ/tEdetCsaHmzjwRv/MO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346063; c=relaxed/simple;
	bh=JLT3fRS+yl6/Mb+tf79ZnYVcgNkISumMGZ+lQQFDBZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvTAamRjkvz+b/LfzUcoXVtWEQ85UBLuf0CdFQl/Sd+oSKb9riW1f3f/Q+nrkzmCukvkoAlodXEk4tOHH8chIVqOfTe7fp+IRd3B2ma4KDSC0DbFh46jdcmX5nQ8VY8yiXO97AjB3ZZL8ej93XvlAjyZVgRKzEk8xaNKo6Xr9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL++dYzT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536584f6c84so1066274e87.0;
        Thu, 26 Sep 2024 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346060; x=1727950860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGV3WmFsQ+1pAhEILcS0ZUWipFofO4AxkBOKtNoxFJE=;
        b=CL++dYzTNo/LnW50RKp3Rzg5/b7apbB0mWRwA+cCwi4BXWJWGA+R5onVEptCDUayP9
         jQ3Gjz7x+w0tLK7KzYZL8Cl915cbdz5dZMYN5iR0pQGHSwOWJMy91mUydy6Z47a+cHMT
         Dl4mQwuU9UdIsrj5B88BAD12+wHvy/m8HTFMN0pNxMhqGw869WRNxPd2AYfuUtfgjwbj
         I5dwt+rrB5QiStQ5V2OaYVWchmYsuLafOqK4f7Pr7r+3IbZgJHy8Wa5dUA7/qEUQMZFz
         NnwJH5vAUeLRlhyH7BVjEeZU6fZK8Jj4n/58ROJG7O571sNLrj6LYFhbJwb6xQCoAweT
         A1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346060; x=1727950860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGV3WmFsQ+1pAhEILcS0ZUWipFofO4AxkBOKtNoxFJE=;
        b=M//lFnkvMjKQk3EjDvS4f+G8o0wydnBtlTiS7nQKnWJFDg80d6bOqc9+jNJkTjGOrR
         ryjAvEr6xFhMf1yRtWlg6CGTvMb4cQGBSfpXPNg2QisJkFBtmWCH84L8MSHqx7uDixo0
         dvvRXkoHF1S5IQxj4xVRS21lIwogOyxkktH9S+SHNL2n4htIiD2Dz7PEgkp4a1bnqD/B
         uwcnIVdXc/fLMkI8lLUegVcF+qin7vnhl/ztCwYC+Und9RtWq3umySjrMbLqmPx691R4
         OF2hSbCsTVr5XHR8mO9wp0Qp4L+mkmB1zwYrm2hntIGUfOl0HoR1ZrO+xnnyJY09kG6V
         an1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv77thuFoJL/TIJxj0de/wyudQnz4zqnzySJ8I0fky/MJOvEJppWwDEcwcORzZtcjV/mWF39cdhXfbag==@vger.kernel.org, AJvYcCVRr/k6KXDU3IcVCA44ee+xB27wMaL+i4+er6dArURQMGIbYAndd2/W+UIoZpUtAI9hqEK9T14N5B3t6bI=@vger.kernel.org, AJvYcCVrYZMY9rmEjGBddzGqYA8tpv1WPhNQwNVt2lf42esds2pfJw1pn7SzTK8qgykMQoSn+qfJROteGgSo@vger.kernel.org, AJvYcCW62UuDuQ3y/J2FCr3KWqg9KcNS2/rph3FoW6c7Ngmu2dVqlTcNgRCk8Kpt2ZDRFuEfuz+MzhCUmFQTKZUp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+v3c3kfxLEN7cDls+PzxpeobGpbFpJa7fsL264Nptr3iA9hj
	pPbQId3CE41GByGhStbF+ZFIx5e8e5FgmJmUfhHl/5p9xbFN2YrU
X-Google-Smtp-Source: AGHT+IGUK6vZAJ++SUbmFGRptqkZIW9Ifvw5nZrFnUuGWC2xWTh37TlzTVTJiCgFnetJ0OjEsCkz9w==
X-Received: by 2002:a05:6512:2310:b0:52e:9b4f:dd8c with SMTP id 2adb3069b0e04-53877537650mr3638945e87.35.1727346059505;
        Thu, 26 Sep 2024 03:20:59 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:20:59 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:20:21 +0300
Subject: [PATCH v5 4/7] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-4-e0033f141d17@gmail.com>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=4227;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=JLT3fRS+yl6/Mb+tf79ZnYVcgNkISumMGZ+lQQFDBZo=;
 b=eyhotNhJjShydlq/boHbobSgpvDEaXyMUCGayFGopjNkVFTTUItWfAQNn8qcRjca/d8VTpUF4
 oQVsU0AeULEBdB4rCd5VcigfpwPxZUvUXA+TbfFtO2Rxf94Y8MZKJ5e
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for haptic controller on MAX77705 Multifunction
device.

This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
User can control the haptic device via force feedback framework.

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


