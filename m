Return-Path: <linux-pm+bounces-12325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EB9543E5
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87416282F51
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A24142E80;
	Fri, 16 Aug 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1qMfOK+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47F140360;
	Fri, 16 Aug 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796367; cv=none; b=cOTrgGJq9CS7K4gSl4lY/cFkJ8YxqKrn3kwT/2comcsb76Zedc8pDGdAZ0N+zmkrViDDpyspBVFvYbvrKzirbo+3lh1VhXbgC26GvUitxvWggWQDbDnuPbnJWdnpgvluIMYXy2MJwIgWFQWlSUCmafoikxVYnew1E9Iw2wHZ3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796367; c=relaxed/simple;
	bh=6pUEa/z1LpG4I1N0jklLMxkabmUriMb9vquyocxTwTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaB7fPJRkUGMc8dyP+/WqXxn53UuroOXa3ob2OckeTNounaxm6juLJp3vpaoi3+JY9DOPQb/lAoOfIyUDZ90mCWK96Kv+0ZXOxwKuUUUUG3I4aSh1DU0whIY1rPb2lgNAKBDJvKowamDLKc3eEdhKuTvaaM6k4QbUyIGUYvAEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1qMfOK+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42816ca782dso12730945e9.2;
        Fri, 16 Aug 2024 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796364; x=1724401164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0VjY7601kLqnVRjaSR87BnlCssrimW4yWJjrae9bpg=;
        b=O1qMfOK+/NOUGeOVlnuX2IM47m3G/05JViQwElXeLCkp4gnYyTcc5Ed7VmCfxaoqvC
         mrHHOTYa6wI844RBkNeZKE/SMyqvjimVhx6GPECPm85KQMo3jUk5E0dYF08HXfvaxFo0
         DZH7rEFTYZBPqoSnL7n0+VSd9EhpcqWJzHYdkvGTwfWCNM/vaxtgS9c99GGlItC9rh+p
         rmkJ5WgpCLBZYWeXRVMR3rECHAfpvhEtDuzaVus1W5Ma8Nx/kXWlXRcSNz3cWTam48zI
         vfBJ76prVa/NVafyoqqNCL4xUufCr4zkPi/XgY9slNwABBJ+AMclAy4BqEOE970Mwm2Q
         njUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796364; x=1724401164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0VjY7601kLqnVRjaSR87BnlCssrimW4yWJjrae9bpg=;
        b=FyyiOM2qq2sTn39Zjr+huWcz5h2qo5+cCp819qIFVLTe8kwh/z0N8zQU2mJ9qkpprl
         hrZCyMQ+5FHbLmpRYyTl/VJViD6B71DzPv3qo+m98LvRovqjslJ0nbS4esx+6IlY/g7k
         1nJ+/yqbEfgHNUAJIUFS8mtmf4/4x61LH9f7wT40yj3rXtbkd4Vf5lo2x5cfKBLuTd9Y
         lPbrF1Eu0Q6QHqLWu9hiX3knNXnh0/1pdAUgPceu746p9JnSLKY21xxASHEtHoMvAhw2
         pvhrbc4kXsTKfigv1jQRdqyFnIRfea3XaXJGSq+gAcFtqyo99z2SXJQ/tTBCcRY6GccX
         mZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbUy4u797k4PRAc4QeTT+w337o+LwX2Mkef7Ca0qaKUS391b0mH+32Ym4T5CYwDT7Ih5Fpm0HJnM3It+NN/qnmViBi25E71EZ00bmFd0yjL2CF0sBbZrfMyXbSyO8p43cYXeLPsLplsx1p+h/oKO4UC5/rpR5GcR2FE/4rc8qw9LGU/ILLUCT43g7B5JFg6cJ3yoYOirzGSu7UzK0ERVY4Qbp+oik=
X-Gm-Message-State: AOJu0YxFLbo2BajmJoGmiOBcdVoAaUDGL/HpZRVFHh3o5RNRXMm695kT
	dNUFKfet3U32StRSK0fGGjz+TxhAMgqIKfLKdylUI+YvqKXAttRk
X-Google-Smtp-Source: AGHT+IEiFFDQqMF8QgPyT0z9ZHgrr2uIL5HHhcaOJ5FP3rUqg97S4HoRfBM4xlWnm5CoJ0V8/bA7AQ==
X-Received: by 2002:a05:600c:3547:b0:426:647b:1bfa with SMTP id 5b1f17b1804b1-429ed780642mr12963605e9.8.1723796363711;
        Fri, 16 Aug 2024 01:19:23 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:23 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:11 +0200
Subject: [PATCH v4 05/10] power: supply: max77693: Add USB extcon detection
 for enabling charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-5-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6402;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=6pUEa/z1LpG4I1N0jklLMxkabmUriMb9vquyocxTwTg=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt+8h9TAdRRpp+MYN+z1MTgfK4MwdezAyecY
 L0tGGVUHyOJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfgAKCRCzu/ihE6BR
 aCwHD/4+5OtgAWYW5evgF17zGQOGWQ+0ZWdUpL6NXjN5ntkmEMjjRHP5Wzcs/hzVGeWRrXva2QK
 jW79NxVHo04f+/n/Gd4AzvlaBlIE7Xcx5YDwE0bW0DMoHyObESv8ixIorAQ4qwHFDcdsC4ocUBd
 Hcvj23ARvHQsmAQ+sIPAepKMKAJNIJc1kexeXL6+8e00ZiNO1b5JImBGDZURAPO2wwonioyaXqh
 sduh7t1jFmH9slClur5QuekezehIQjoj+MoLTc+7/lVgse3kCIHuT78+QKt/7hhEsgBo3jSvyg+
 B+uuxBl8FtJPoisizdv+hfaOVjiBvMUs+N6gi8qZHoWwdTfvFqb6biM4XPhUSmL+Q0pVzVyHRcL
 GEEjf32UviPLAXAyySMGb0BIy2A2ictFLux7bM6ogWpHUhW0facibLpp9+kFjAExYeEXDwHExfk
 ybQsr/QIiJoPuU9ytZM51hi78yt47P3k8z2K/Nem5rHOPJTmZCMP+5IRjrDx7ZCrP05yNe3bZs/
 6IOYbv2QwFlqlJ+bWYczrbgLxlKNNMXeRet33W7P9459LGN2dJy/cQxopqiO3n5ofNIW3vPTPvf
 LQwytwLGlcKblw3oDdY0xyLGQow7BqAKzc66fYrHtxdFv8wlCr8qs6jDHxZh83TSQo1Z059sQKT
 RftZqJJgdjrsKSQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

1. Add a function that allows for enabling/disabling charging.

2. Add a device tree property, "maxim,usb-connector", that can be used to
specify a USB connector to use to detect whether a charging cable has
been plugged in/out, and enable/disable charging accordingly.

The extcon listener/worker implementation is inspired by the rt5033_charger
driver.

Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Fix missing connector property causing probe deferrals

Changes in v3:
- Adapted to both limits being split up again
- Move charging/extcon work functions above reg_init
- Drop unnecessary extcon unregister from probe error path
- Change disconnect message

Changes in v2:
- Changed to adapt to both current limits being managed by one function
---
 drivers/power/supply/Kconfig            |   1 +
 drivers/power/supply/max77693_charger.c | 122 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

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
index 17975ec69a6a..d67857d2aa0b 100644
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
@@ -28,6 +30,13 @@ struct max77693_charger {
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
@@ -668,6 +677,77 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 			CHG_CNFG_12_VCHGINREG_MASK, data);
 }
 
+static int max77693_set_charging(struct max77693_charger *chg, bool enable)
+{
+	unsigned int data;
+
+	if (enable)
+		data = CHG_CNFG_00_CHG_MASK | CHG_CNFG_00_BUCK_MASK;
+	else
+		data = ~(CHG_CNFG_00_CHG_MASK | CHG_CNFG_00_BUCK_MASK);
+
+	return regmap_update_bits(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_00,
+			CHG_CNFG_00_CHG_MASK | CHG_CNFG_00_BUCK_MASK,
+			data);
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
+		dev_info(chg->dev, "not charging. connector type: %d\n",
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
 /*
  * Sets charger registers to proper and safe default values.
  */
@@ -734,12 +814,34 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
 	struct device_node *np = dev->of_node;
 	struct power_supply_battery_info *battery_info;
+	struct device_node *np_conn, *np_edev;
 
 	if (!np) {
 		dev_err(dev, "no charger OF node\n");
 		return -EINVAL;
 	}
 
+	np_conn = of_parse_phandle(np, "maxim,usb-connector", 0);
+	if (np_conn) {
+		np_edev = of_get_parent(np_conn);
+
+		chg->cable.edev = extcon_find_edev_by_node(np_edev);
+		if (IS_ERR(chg->cable.edev)) {
+			/*
+			 * In case of deferred extcon probe, defer our probe as well
+			 * until it appears.
+			 */
+			if (PTR_ERR(chg->cable.edev) == -EPROBE_DEFER)
+				return PTR_ERR(chg->cable.edev);
+			/*
+			 * Otherwise, ignore errors (the charger can run without a
+			 * connector provided).
+			 */
+			dev_warn(dev, "no extcon device found in device-tree (%ld)\n",
+				 PTR_ERR(chg->cable.edev));
+		}
+	}
+
 	if (of_property_read_u32(np, "maxim,constant-microvolt",
 			&chg->constant_volt))
 		chg->constant_volt = DEFAULT_CONSTANT_VOLT;
@@ -811,6 +913,26 @@ static int max77693_charger_probe(struct platform_device *pdev)
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

-- 
2.46.0


