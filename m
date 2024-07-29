Return-Path: <linux-pm+bounces-11576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5593FCAF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92FC282145
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209B188CC0;
	Mon, 29 Jul 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyNNf0Ry"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDC187871;
	Mon, 29 Jul 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275280; cv=none; b=cyzeIf5Kjg2BojmMb5X1P3EhRgMzxnyVoYHRLmI1TOZVpxGPf3+msqGHwoy1B5lUTE6gaCARAcYHQhvvKEkyI4+5mLgnqcUaQBDI17OoyueBAEdIwJ+wYr2ycmWIeMw4+6+IHZ6ixL63CYlg+O2VeThfGP7KvGAVGvw42bKOjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275280; c=relaxed/simple;
	bh=hUFm5zgvxacpJc23mhT7FrKD3yHbBhmDgpcXdgKmXlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ietBbTGzY+hlMT4BRkTiW80qAg7uvTbZRg5/iTtvJSn6gAnUfCI/MPpCNqRbQPDr5FmwUl4zLqxuSPIuWN9LQr2uLYCReGAgLxoqH7vDjKZSR7sDtrPSefz0tnodA8a+uNCLNRSvpoMBKZo4cmoddWeav1RAMR6hQsMfmKgCVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyNNf0Ry; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368584f9e36so1524278f8f.2;
        Mon, 29 Jul 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275277; x=1722880077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HtdwOmpjBLvOS2fpbCrpGHSAyy+FDyT8B72kclys+E=;
        b=NyNNf0RyxPUCZwzdx+F0exyK6gvvdSchCigf358x5i08Tkb4dz3iySp4p10f565mUR
         Bg/mbgvTFytec3HmCVuWKpAf4hNHio2lH4J6LxJ1b7z0320Uvq1QWU+ZiC6+cyKxv0FE
         /VziVZvU/ZAhvDjzt6gXMqcpEcS//FUd/dCq6Ff64aIw8aznrtb5FJ+6TnsqzYEbNeYs
         cnHOcaqnbvMc7lb8ctPB9BDRSiFm6H6B75eDC2rcpIzBsvXt7DaYztJ66mwljtIWJI9p
         abq+wt2C0a5Db9h3sOXQJ2rn44DInYpvXwiSuldPnoZbbRThpIcASWtE+XeYkUALYlGl
         9RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275277; x=1722880077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HtdwOmpjBLvOS2fpbCrpGHSAyy+FDyT8B72kclys+E=;
        b=vGos0I/2y3WOk5THdvoJjOQWK64gZE1ypUrWvBoCAAghFVECtluiL+PRknzQRe8kIB
         67C41vzMMTWcJcj06nagb4ZCokXwDbcCztjl119Pjy1RgKq3GxIP/SJtsAAwZa/cVILU
         tRT8f1zbCZ1mIuljUtSHI7tzVHFMJ4kHqAS9ATP4dJv/mMRPWMPN1x01G+aiyJTziZah
         9rwzbiaE+VpBU7KzKqeeRVNYOpisOhIhLXJtuBcXBLZ7T2kAzP100EyE6bUOCk52T7ms
         j86wKh2h43RLJ7mkcU7/l8njCUqiH3HAzmFlbXSbklTISLfU0XOelAPNu4Xa3r0vDnTb
         Ingw==
X-Forwarded-Encrypted: i=1; AJvYcCVkV88d+CMYRvKOcl9KybPHeBmhjo3Y5JP7Gjo5LN/xXtr0nENMGgfL964sJz/AwkAgjmuF2dFZioq80fBXui02UQ+J6kFeZW1180cihD8+SizfWMD2hvx1zikeqNuwNXfdoGwnubcMZVENEii6JIbxRsB2UE7GVSeH9hoTMau0mI3Rfh5pjUsA9nYXSX8kHi+XTqDxCffXoXUXFq1B7JHTVSo+p5Y=
X-Gm-Message-State: AOJu0YzYeCARodTeQAZnNavkP1XiAAOwWQ1znRFMdmASUYIUkVRfP1W/
	i5LzaYsWMa236QC/ekpzAJQXtM3a17c/xdl+NtvNVtI2tlJzo/cGdDMHbg==
X-Google-Smtp-Source: AGHT+IEXPCegsb/usx+QhYeqYMMMnQDYD7PFJLzBQ4V90OraTh3ivSEvYAHegwPJXZctgby0WCXN1w==
X-Received: by 2002:adf:ed46:0:b0:368:3717:10b3 with SMTP id ffacd0b85a97d-36b5cecf2efmr5965729f8f.8.1722275276558;
        Mon, 29 Jul 2024 10:47:56 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:56 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:39 +0200
Subject: [PATCH v3 05/10] power: supply: max77693: Add USB extcon detection
 for enabling charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-5-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6240;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=hUFm5zgvxacpJc23mhT7FrKD3yHbBhmDgpcXdgKmXlQ=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W+94e4wiWpIzTsI3Ij6g5IB0Ibemjb17sUL
 behwtd5aLmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvgAKCRCzu/ihE6BR
 aBtJD/40NYyUkN0rn818ZUKsEVWXzmko7y+3JmjRKrqf1Gujma+xpC+c1aNdp3MSJtNCoG34BVi
 WdyFxG6L/pyXrC5+wKQLN+LojMJ8eef1XLZUgkc+u5Z2AEHuhbgm5vQKnM3TTf8U7nt3JmFJyw9
 pMWqY9k+am5Bh4wGZWqtwrDEfMPMHeqW91E5gQUK/WLtompl/fL1McSZNUnQdZlza+PpPgEkdFj
 k86tAxij2P70JVvhH71su3muxbe15Y+dep6QwTE8QMLc3qyr6CjwUtcBcfIsRHkM9I8cWCOZib9
 mFfjGZM/sBXHlwitm0IlsLpadSHpIYkifRyhfO5QuhAosbTOF99gnpzpDwDKVqCtTjDV+b9VT4L
 lMYsO5PjOJMT/6mWMuo6qj2PTrqKHtDjlDLs7Pkvb+sogKVbD4MD3Ym0Fnlm1L8hfUiiy1kuiZX
 SAftfW9ALzvrLibHdCaVFTCuHsN3AVBNU31PbvOyLJZKj69DjGKYZBs0O/cUHNxpEmLFjUCrfbj
 wujVGglzh6+h5O744JV313NkiPleJfFZf39a5NydySD6Jrl2TUBFdTyq/0VbzEh2CjfnTHHAdis
 lyi1yMQ6simdTL2ksElq2EavOsd8XsOm4XQOK3h8TfD+lrlM+gPFjLP6LiUkn99JhXz9Y9Rkpry
 0eeuBFFO+Nf5AEQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

1. Add a function that allows for enabling/disabling charging.

2. Add a device tree property, "maxim,usb-connector", that can be used to
specify a USB connector to use to detect whether a charging cable has
been plugged in/out, and enable/disable charging accordingly.

The extcon listener/worker implementation is inspired by the rt5033_charger
driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Adapted to both limits being split up again
- Move charging/extcon work functions above reg_init
- Drop unnecessary extcon unregister from probe error path
- Change disconnect message

Changes in v2:
- Changed to adapt to both current limits being managed by one function
---
 drivers/power/supply/Kconfig            |   1 +
 drivers/power/supply/max77693_charger.c | 120 ++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

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
index 17975ec69a6a..2e05467c682e 100644
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
@@ -734,12 +814,32 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
 	struct device_node *np = dev->of_node;
 	struct power_supply_battery_info *battery_info;
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
@@ -811,6 +911,26 @@ static int max77693_charger_probe(struct platform_device *pdev)
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
2.45.2


