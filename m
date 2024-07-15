Return-Path: <linux-pm+bounces-11108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81084931516
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37985283A5F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3A18EFFB;
	Mon, 15 Jul 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm6JxcGi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715D18EFDD;
	Mon, 15 Jul 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048126; cv=none; b=IALRMEYlKCqdCEymUlWEZeeyKj2wuJkZeAPXBg5R2+TlQdz7ELd/CiycQjlUVh1sQXzFGwM+/Fuj6RNXf6ZqCQF6eyQ+PUEbMxSTpOX2IeY6LC8SmPNL/eW3RCNLNmE88s9qLRBL8Z5D+3jnoU2Si/9paeJM0y0mnrO6chOMB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048126; c=relaxed/simple;
	bh=nORleTpwpWgNuuODzmLnTBwFLWHB5u9wp9/Xe63310I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zga3/JikXpJ45gKR+G27dJv4uAkdUkL6NWdAIeOjGDzWKrLi7nL2lzwgkTTwsl5nSqA3Ok2MACEZHT4lkUfGCMXNCBUwCpLBR52m99ZXcQY3Tn0SfYk1lXjXeSFrqSkhYkxXjn1K65kx/r6wuj61PyGwmjiXdl08NbyoksfPhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm6JxcGi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59a47d5c22aso4263859a12.1;
        Mon, 15 Jul 2024 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048123; x=1721652923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnYgYyIzLcEnadxIm9ww2cm2tQhdI4bTzCayN53bjXk=;
        b=mm6JxcGii2iMwVCscKvX89TQmiRk4u8xqBnbx8ecwDeku+VY1B1THJjI+pYKvEyMyf
         rOTsQCX2IeSoDkAUExSSjd8YCUsxkjnJchvMYV6YSBMtnnF06711ndXKr9H1coEXQGLK
         fSOHC7wJ2kRefhsY+ehWKT3fB+U/MVC6F64ATtLhGV8ZI/wYeynr9Rcb/MyaAiXsb0on
         TIE3aQZur2hb/orJqZToFqFlBiHrkv+Dub5aWtd9SLPvQZHrOoFp1krdusRlokiFzdv5
         A2gkpmxl65w0Vp4sL26/E/6PkH/8NDqc2BOh+pwfLPC6jHwFSExxQoicJTS/fJ769N7H
         c7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048123; x=1721652923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnYgYyIzLcEnadxIm9ww2cm2tQhdI4bTzCayN53bjXk=;
        b=fOC4HH6FaMWGafyJA++VvuuRxQfId8HRkXD9C9JIXbmCcOS/P9QB5ILHYECK4mBuyY
         Q2PFc2+zTrJ8ZCiatH+UnNp+UVUlA/hWx97+EqeSKyJBFTyWnRiK5LhXKwgMUyTCZlNL
         eCpmVv7R4bUug+PabaA0P/fzrCOpFLri9BVJPAg1GsRL9WZxAdRnzqtO2OFTvHZTZL8Q
         uYX/fvEvjFM43YtBXVpuDcF+Utb0YlWj5UhXsWJHiPq73/jvsqTTVfku8A0owsSBZa4+
         +CB41+vM2YA7n/3XEXCfFzFqPsj178mYxCBZcZHaTceBmtXPvVG8xISyNDFtM8ubgywW
         vGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7dPJ7TUbq1CV6THCBAYRHKl1aah+7KlxtdntD6yrOaLzbkh4meqxbhNQLQhfSc/rWq6ohLS8IfpDQEFyzQxu5j3oVypITpmzmxGnTv9ajbRIvdJ6vUWa11+14Y899fFdjnVZcxwVl7jivrQii5h+U6kCHCZkoQtZKKl3sLxW/c/ND7JKEpwTKPSCMd/IMjMrFRz5tudP5d/tBMm8mdObLXHvgruw=
X-Gm-Message-State: AOJu0YxH5f6TLpJtgQDkJAQNQBI8e5weQHy9c7huXVvswT5mtqGOcvnw
	FWx1pCxIyUF7h6jFYkAcParEBD4DX3MexovnjBGyiMrW4EsZQPJJDOwW11zI
X-Google-Smtp-Source: AGHT+IEyt6/37zigreQe/eBSyKTbMjngFktAPAGaKiuzzl4eqOkTPH3/6/JLn6fPOrQnCCih3MzkMw==
X-Received: by 2002:a05:6402:520d:b0:58e:e2a:1b4b with SMTP id 4fb4d7f45d1cf-594ba98f273mr13167907a12.7.1721048123056;
        Mon, 15 Jul 2024 05:55:23 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:22 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:08 +0200
Subject: [PATCH v2 6/9] power: supply: max77693: Add USB extcon detection
 for enabling charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-6-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6386;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=nORleTpwpWgNuuODzmLnTBwFLWHB5u9wp9/Xe63310I=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwp5hracQTmctVBYewvzeIa4lw99or+rKlKb
 F//suZwLd6JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aGxfD/9CZ7IEig+/B2weBvWrxK95bSBmd3P8A8A2fAp5O+1Nj3UdZa3Ntauaxbmoeg1QWzMmlpV
 n6dqLK/RysDFKkJBe/h/n6hdi9d6sRnzg5EdC8BYSLu4yXDWaSZKU+tAvvdzqlxtS7wKdQjo7OP
 6rl4miwQF4XD/rhK8Acm4g3lyQ+clRwxjg3f1TY3Ympgtq0/rlc5az+CcAMBFpIyaHIDvxp3jLs
 JNkG2VPqtXfYej6Lli63nUu1FofMMmrPTe8XX9TI25DWrtA7V96T0FmQUxiy0krr3iF6jeAT0u0
 VUb6S100hKINN85btRyeZZJEgAOu+H5hU5pNpCdXvyGs1nMneexRyKc5UTaZvYyH1SlmZKHGfzR
 6ApcBMmXSiyEmu2OJupq5+jGzqMpG6WQE62ocmJvNnVcIDsm+3xWqU3SPK6xICV37TQ2TguTIF+
 Y1Iqk2SUkX6KCPu6EkxjlnzKJ3x87mZb6BnFDNHHFAuqcfmtIvuMwNXRrFLX67j7t90jRTrbCmv
 VeLCJiGCqLDG+QVwfrKC1u0p1fWApT2g66P5UmTQsX+c/AnF1QQmxzkjouvsUSrwk4SpnIu9i5+
 8lglUXuHa8KaTrUrhBHf1BpZofqCu7+bCHqntqTB710rgoLw/S3er//gy6K7x5OkKPgZkcOL02p
 rXAwZxzDEOgWfrg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add a device tree property, "maxim,usb-connector", that can be used to
specify a USB connector to use to detect whether a charging cable has
been plugged in/out, and enable/disable charging accordingly.

To accommodate this, also add an internal pointer to the CHARGER regulator,
which is used to enable/disable charging and set the input current limit
(which will be done in subsequent commits).

The extcon listener/worker implementation is inspired by the rt5033_charger
driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Changed to adapt to both current limits being managed by one function
---
 drivers/power/supply/Kconfig            |   1 +
 drivers/power/supply/max77693_charger.c | 125 ++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..e4aeff9e7ad1 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -549,6 +549,7 @@ config CHARGER_MAX77650
 config CHARGER_MAX77693
 	tristate "Maxim MAX77693 battery charger driver"
 	depends on MFD_MAX77693
+	depends on EXTCON || !EXTCON
 	help
 	  Say Y to enable support for the Maxim MAX77693 battery charger.
 
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 0ddaa03669a2..2dc273dd96ee 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -5,6 +5,8 @@
 // Copyright (C) 2014 Samsung Electronics
 // Krzysztof Kozlowski <krzk@kernel.org>
 
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -30,6 +32,13 @@ struct max77693_charger {
 	u32 batttery_overcurrent;
 	u32 fast_charge_current;
 	u32 charge_input_threshold_volt;
+
+	/* USB cable notifications */
+	struct {
+		struct extcon_dev *edev;
+		struct notifier_block nb;
+		struct work_struct work;
+	} cable;
 };
 
 static int max77693_get_charger_state(struct regmap *regmap, int *val)
@@ -664,17 +673,110 @@ static int max77693_reg_init(struct max77693_charger *chg)
 			chg->charge_input_threshold_volt);
 }
 
+static int max77693_set_charging(struct max77693_charger *chg, bool enable)
+{
+	int is_enabled;
+	int ret = 0;
+
+	is_enabled = regulator_is_enabled(chg->regu);
+	if (is_enabled < 0)
+		return is_enabled;
+
+	if (enable && !is_enabled)
+		ret = regulator_enable(chg->regu);
+	else if (!enable && is_enabled)
+		ret = regulator_disable(chg->regu);
+
+	return ret;
+}
+
+static void max77693_charger_extcon_work(struct work_struct *work)
+{
+	struct max77693_charger *chg = container_of(work, struct max77693_charger,
+						  cable.work);
+	struct extcon_dev *edev = chg->cable.edev;
+	int connector, state;
+	int ret;
+
+	for (connector = EXTCON_USB_HOST; connector <= EXTCON_CHG_USB_PD;
+	     connector++) {
+		state = extcon_get_state(edev, connector);
+		if (state == 1)
+			break;
+	}
+
+	switch (connector) {
+	case EXTCON_CHG_USB_SDP:
+	case EXTCON_CHG_USB_DCP:
+	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_ACA:
+	case EXTCON_CHG_USB_FAST:
+	case EXTCON_CHG_USB_SLOW:
+	case EXTCON_CHG_USB_PD:
+		ret = max77693_set_charging(chg, true);
+		if (ret) {
+			dev_err(chg->dev, "failed to enable charging\n");
+			break;
+		}
+		dev_info(chg->dev, "charging. connector type: %d\n",
+			 connector);
+		break;
+	default:
+		ret = max77693_set_charging(chg, false);
+		if (ret) {
+			dev_err(chg->dev, "failed to disable charging\n");
+			break;
+		}
+		dev_info(chg->dev, "charging. connector type: %d\n",
+			 connector);
+		break;
+	}
+
+	power_supply_changed(chg->charger);
+}
+
+static int max77693_charger_extcon_notifier(struct notifier_block *nb,
+					  unsigned long event, void *param)
+{
+	struct max77693_charger *chg = container_of(nb, struct max77693_charger,
+						    cable.nb);
+
+	schedule_work(&chg->cable.work);
+
+	return NOTIFY_OK;
+}
+
 #ifdef CONFIG_OF
 static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
 	struct power_supply_battery_info *battery_info;
 	struct device_node *np = dev->of_node;
+	struct device_node *np_conn, *np_edev;
 
 	if (!np) {
 		dev_err(dev, "no charger OF node\n");
 		return -EINVAL;
 	}
 
+	np_conn = of_parse_phandle(np, "maxim,usb-connector", 0);
+	np_edev = of_get_parent(np_conn);
+
+	chg->cable.edev = extcon_find_edev_by_node(np_edev);
+	if (IS_ERR(chg->cable.edev)) {
+		/*
+		 * In case of deferred extcon probe, defer our probe as well
+		 * until it appears.
+		 */
+		if (PTR_ERR(chg->cable.edev) == -EPROBE_DEFER)
+			return PTR_ERR(chg->cable.edev);
+		/*
+		 * Otherwise, ignore errors (the charger can run without a
+		 * connector provided).
+		 */
+		dev_warn(dev, "no extcon device found in device-tree (%ld)\n",
+			 PTR_ERR(chg->cable.edev));
+	}
+
 	if (of_property_read_u32(np, "maxim,constant-microvolt",
 			&chg->constant_volt))
 		chg->constant_volt = DEFAULT_CONSTANT_VOLT;
@@ -752,6 +854,26 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Set up extcon if the USB connector node was found */
+	if (!IS_ERR(chg->cable.edev)) {
+		ret = devm_work_autocancel(&pdev->dev, &chg->cable.work,
+					   max77693_charger_extcon_work);
+		if (ret) {
+			dev_err(&pdev->dev, "failed: initialize extcon work\n");
+			return ret;
+		}
+
+		chg->cable.nb.notifier_call = max77693_charger_extcon_notifier;
+
+		ret = devm_extcon_register_notifier_all(&pdev->dev,
+							chg->cable.edev,
+							&chg->cable.nb);
+		if (ret) {
+			dev_err(&pdev->dev, "failed: register extcon notifier\n");
+			return ret;
+		}
+	}
+
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: create fast charge timer sysfs entry\n");
@@ -778,6 +900,9 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
+	devm_extcon_unregister_notifier_all(&pdev->dev, chg->cable.edev,
+					    &chg->cable.nb);
+
 	return ret;
 }
 

-- 
2.45.2


