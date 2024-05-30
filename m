Return-Path: <linux-pm+bounces-8414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1168D47B1
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A32284BB3
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961A17D37F;
	Thu, 30 May 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ/8/Fzl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C417D34C;
	Thu, 30 May 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059398; cv=none; b=IFXyxAX06CTFHvVrmidv54JzKI+5/mv7/y57KU8mFT308RZTHOiHv7+BWDgGjPnrb5Fm1Vxggbm2fTxMxaobdrRCcqbYq6uXgyp6L2d77T6P45+eTeporId1mkuM5JR0nofxcV9rzXsPr2tSyjRmxzmOlnz248gB13MPZw8TZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059398; c=relaxed/simple;
	bh=Z6Uakaaf2pR7w6gR2fxAZJMtvGZtTD0SN8W+EmCqsME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJx9CiFeJ2cqlvvnFWYXGoK0UvxbISugR0z/8rSia4rmqHIy8yGmNrx69LlyP7AKd+l+wB2e6pvYZOebQV5wmIWBo5KCWIrQSX5l6ybTCz1Qv8AJwoQmumgtN42a2PblXtl/RUt1z+2V/WlhfBIMZMzzwXXXa/TRX9z46ml1A9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ/8/Fzl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a63359aaacaso53635266b.1;
        Thu, 30 May 2024 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059395; x=1717664195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn2E3HXmiCEzf6NwKWLZ6I/Ayq5D3tGA7P5z5wrdz+Q=;
        b=UZ/8/Fzl3E1qptSWeuSLcqabrFXvmOXnd+sSo2v8PRUrx8WuYNX/V2BhckQGMjLvkR
         DTCGF9pe+j7ODZjOZCmzDZqu5nCN3kPHNYwDz5yBWfuphBZh6joiYZ8Tl5RWgSCsbAvr
         fn6OthDUl/nRapQDqxSieSGPi/m8YuFWmXjkGTclvrkwQAFpX39vuUxJg7nm2gn9csdN
         CyrOV/fKfawYvL55IduEUSnFpKu+X5GJcsmc56OeXlObUaqqJu+Q6iS3tNRa0rNZJ7vu
         ZQWgxFSLOkhZn362r9Goquj4wyOtMcsO8p1AewTkywDNWjSlKoyxJzVDiID78H7H51rk
         hCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059395; x=1717664195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn2E3HXmiCEzf6NwKWLZ6I/Ayq5D3tGA7P5z5wrdz+Q=;
        b=TuWCtJd6YOKCguHY4pUpdKOO7QYNNtiw8mE4hAYnJMiP1LS87hHhg/BgJQCp3WNBhr
         rUHcgTf+q3RdjzKgIsQFXNZp/SiIGAWoD8H9Vnk12B2qr/CZjDLsRVa+foSdq/X60/id
         qXYiDvNNHuus+4wn9Iw7der90Hlj6m7cmipyZbt7YLVzS5k4Ni52N7qPLgsTID0W4HAw
         mKyOpB2CW+X3PmQmd8lsZ6jeswmnf7GWlnIC5PLEGdFPolJr3x0z6bVfWAbHNgwJ0nuk
         4kSYH5DGbtbV6PC/6mk1mUuCOxFjhP/PzQk8Bxzcjt0cPHDakWFYtEB5gDGu8zj4VMKf
         9Quw==
X-Forwarded-Encrypted: i=1; AJvYcCWuQ/XDXNFWQtO+422UTurbc5jgmOTvyN6GIVX8/jfthWXIp/HNqQCDk4y2XjwZTPJPwaE23xsLF9yUDbvja6UfjJKxtwQh74rIXAwOFA0E2YwyqmmG3QQOHqLQdgTR0WX1uwp8LWdDD+OazTg8275Vi3emlLHRCcfDfI3U1J8LoYhfXYgR3+8iX44ZxZ3D/QVmqc95Po2/0STyEUCWt9rU247+aR8=
X-Gm-Message-State: AOJu0YybU5d6Yd4YfD12kf7/Un5KxEN3bLkIkwgR21dh6hwIWb/W/y73
	ZhgyYqwAPfbSkwYlEZyPMJ0Caw9h5Wfz2KKTNIYChmS+z4GIGZAl
X-Google-Smtp-Source: AGHT+IE31vwYfcuJPIGE6LexzX5w+MozSbSYVt+e/+/Z7o3jKatrX2YtbIX2R41eGLdKadHEID+EMg==
X-Received: by 2002:a17:906:d92:b0:a59:a64c:9a26 with SMTP id a640c23a62f3a-a65e8e507d8mr84553066b.23.1717059395263;
        Thu, 30 May 2024 01:56:35 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:34 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:57 +0200
Subject: [PATCH RFC 07/11] power: supply: max77693: Add USB extcon
 detection for enabling charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-7-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=6243;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Z6Uakaaf2pR7w6gR2fxAZJMtvGZtTD0SN8W+EmCqsME=;
 b=/otuVyG+MYAQnvYq6pnSJfAJ2q8SAm6E1XDwZh46SvFbfocSd7ZsDnbIlnKCkSUoFJXIwbMsP
 SZVtRrM6cbfBl2IPwVU770VsZIghjYMdO6Rl3TxBTSXkrPox15roc9Y
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

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
index d59b1524b0a4..c2e8ae367381 100644
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
@@ -711,16 +720,109 @@ static int max77693_reg_init(struct max77693_charger *chg)
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
@@ -787,6 +889,26 @@ static int max77693_charger_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = chg;
 
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
@@ -822,6 +944,9 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
+	devm_extcon_unregister_notifier_all(&pdev->dev, chg->cable.edev,
+					    &chg->cable.nb);
+
 	return ret;
 }
 

-- 
2.45.1


