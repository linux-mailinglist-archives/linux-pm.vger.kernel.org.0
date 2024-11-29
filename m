Return-Path: <linux-pm+bounces-18231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF469DC243
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E6283D16
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2EC190468;
	Fri, 29 Nov 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9A8MSK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D42155345;
	Fri, 29 Nov 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876776; cv=none; b=KHlYtBjegfG18wxjv+fcXcDdeY32BisWaMKn9974a/V3KjEBn8g2ELxyoCjrEo8AnI6J4WJzvFsQ0aki15cB5VNVsAqcO5Io4kb/EM2PbL2L+qPmOS7+MqCONLjdiPmCqdMbzrQoYTK0wI3/Xo3Ulz4fN5RccQjZA4XJkRSiDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876776; c=relaxed/simple;
	bh=bs12UpHie5guRp0pfEJ+k8KVK0dCavtbYJ2mw5smP0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiJZ8S1taNeEh6nttn6AnSHU2id3AnHWGsrvng1JmH2iZbVJFVUbI/vtDz3FFrh8mpyagaHyAY9CZ4D7WIAzMX6noqnKDp/CSl0A2f2E/oeCuiDt7EC2sbq+wyYRpu39FgkwwQMF2DVCIvNBrz8gjXM6QhgN7FhOMwZUgtnVrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9A8MSK2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a10588f3so10614545e9.1;
        Fri, 29 Nov 2024 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732876773; x=1733481573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7iwpbK56Zj29FzaEZqSMI5kycSSpeuPNbmTILivgMU=;
        b=i9A8MSK27okpFBOjHUupmsc7oNW/y2MyEHE3Qa2pWcoqLvUTSpX0Lz7BfHPUbJuBcn
         2Ops1F74Si0FHwaMZyYqVL+QWMCXYmHYs61wkfzbTD1Niw7fgiaiB/1mnS1R6iNXqaHW
         DvuNHnATh4og2+l8DoRet9MBFxaom9QQ3UGjd3wwDpIoTgc1byvz52oIj3hHQjXyjGKn
         mWjRcsQTBzbSKWqcNrHGJfSkaZllo10L3sN2S6BIQvuu0U0gdElc1ei6OOegH3t8Rm8O
         ilyRSrVTRyX3QrniEX/kUb22cLyrtiVaxnnj9OyGUWO8dBeT6o/u9cWqPc68vt8H1grY
         m5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876773; x=1733481573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7iwpbK56Zj29FzaEZqSMI5kycSSpeuPNbmTILivgMU=;
        b=TbJhls6nD2ZlqIBerfFJnZUwDH8GN/Een5yVec6UZhUgyq98In2A1BL1d5dJiW7KH0
         4QkoaSLh265U/eNURg2NErR2vY2TZyBEg13Zne7/Wd8f1hy7JVYV3pdpaywUqamUav0G
         ZIukdOqR/KzuxZaToHnAA6Fl3JcLoouwQa4/T5MNl4v/jQlsbrNM6Ex+tRHW11pVDaSX
         uJy/VmobFdg64DXk/2ERI0KPQ4MePxoOtgzAGDpa7rbts4FauN/LVaTmVn9gO2S4x8wX
         2vjOWkxGvh9LkCeHjvsus7imBbsDlfdcDRGdKRmG4CokaJAaH/eyzPWlqIiicKndzVzh
         UdIw==
X-Forwarded-Encrypted: i=1; AJvYcCW2SYYmU3RrB3z4HGG4a2vPKlXHNYNdg8R1haB0ZSkTPnIq4Aw0aGBp5ERKsxviEd2GSwGaBJT8gABqi9iI@vger.kernel.org, AJvYcCX+uSfyhrJXkxChftwhNWVz/g5wvXbh12ky3IHCcS0mwPJiZb3Vf45eHAYOUVtVzZ3mRil3CSROlS5F@vger.kernel.org, AJvYcCX6lMrLtE/pWC/zXBDOj2V0ZYour9wy3S0Cr1TSgTjmHK5j5sn1Pg8az9MzkwXbySTrPPmxdvQZ+1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//BV8LMYax67SaFo0qm5IwQUiv54eKcIMztw5I+j0vZiTwfLC
	vF6fPhwxpRWnCy4vjaz2NTuG9jzGMFjDYbnSlsSvHhHs7bv7Vpk4
X-Gm-Gg: ASbGnct0u1Lhxb7BlFijOuN9+UMdnNir2G30CtwPDfPkQeSOazPFcqy3rEZ7ixmR/Zl
	bNFnbyeQyTf95YyFXFST6/9iDQkEeQVl+mi91WzIxOREqcEUKeAYXcwTlbqWI4WV6evWK/oyTRR
	eUgc06KkO1tuRWGhVzXtNvagCEvxSIHRskvqr+G3hE98G86oPHisIX8qzMNhqV8Q2HnpQAN0L9W
	rT3l13HmMtokmLhWbZ/7u65IDuh2JiTCAfmcoOvE9E0BajukYAYASoIrq+CsnHvxI5qacqYnfsX
	ouO4cqzO+B9hNFVnTaVJcc1KF6Cn5ldjDGkx3+AUA5nO7NU=
X-Google-Smtp-Source: AGHT+IHA+D2Vkn0Qv3fFKnJyMXIfhTHM+HXBEKlk/Simtg+lr4RPXSG0xiy1rifSXm3eCIci8V5vOA==
X-Received: by 2002:a05:600c:3ba6:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-434a9dbba7dmr98910125e9.7.1732876772960;
        Fri, 29 Nov 2024 02:39:32 -0800 (PST)
Received: from stefan.beckhoff.com (dyndsl-089-166-153-066.ewe-ip-backbone.de. [89.166.153.66])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm81764585e9.9.2024.11.29.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 02:39:32 -0800 (PST)
From: Stefan Raufhake <raufhakestefan@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: s.raufhake@beckhoff.com,
	s.dirkwinkel@beckhoff.com,
	Stefan Raufhake <s.raufhake@beckhoff.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/1] power: supply: gpio-charger: Support to disable charger
Date: Fri, 29 Nov 2024 10:38:47 +0000
Message-Id: <20241129103848.39963-2-raufhakestefan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129103848.39963-1-raufhakestefan@gmail.com>
References: <20241129103848.39963-1-raufhakestefan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Raufhake <s.raufhake@beckhoff.de>

We want to disable the built-in UPS in our device
so that we can switch off the supply power of the
device with and without the support of the UPS.
This commit will allow us to disable the ups by
using the command echo 1 > /sys/class/power_supply/xxx/charge_type
(1 = POWER_SUPPLY_CHARGE_TYPE_NONE) and enable the
charger by setting it to 4 (POWER_SUPPLY_CHARGE_TYPE_STANDARD).

Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
---
 .../bindings/power/supply/gpio-charger.yaml   |  6 +++
 drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 89f8e2bcb2d7..b2658b0b20e4 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -44,6 +44,10 @@ properties:
     maxItems: 32
     description: GPIOs used for current limiting
 
+  charge-disable-gpios:
+    maxItems: 1
+    description: GPIO to disable the charger
+
   charge-current-limit-mapping:
     description: List of tuples with current in uA and a GPIO bitmap (in
       this order). The tuples must be provided in descending order of the
@@ -68,6 +72,8 @@ anyOf:
       - charge-status-gpios
   - required:
       - charge-current-limit-gpios
+  - required:
+      - charge-type-gpios
 
 dependencies:
   charge-current-limit-gpios: [ charge-current-limit-mapping ]
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 68212b39785b..24cabb2cb111 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -32,6 +32,7 @@ struct gpio_charger {
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
 	struct gpio_desc *charge_status;
+	struct gpio_desc *charge_type;
 
 	struct gpio_descs *current_limit_gpios;
 	struct gpio_mapping *current_limit_map;
@@ -82,6 +83,26 @@ static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
 	return 0;
 }
 
+static int gpio_charger_set_charge_type(struct gpio_desc *gpio_charger, int type)
+{
+	int chg_config = 0;
+
+	switch (type) {
+	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
+		chg_config = 0;
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_NONE:
+		chg_config = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gpiod_set_value_cansleep(gpio_charger, chg_config);
+
+	return 0;
+}
+
 static int gpio_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -100,6 +121,13 @@ static int gpio_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		val->intval = gpio_charger->charge_current_limit;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (gpiod_get_value_cansleep(gpio_charger->charge_type))
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -115,6 +143,9 @@ static int gpio_charger_set_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		return set_charge_current_limit(gpio_charger, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return gpio_charger_set_charge_type(gpio_charger->charge_type, val->intval);
+	break;
 	default:
 		return -EINVAL;
 	}
@@ -126,6 +157,7 @@ static int gpio_charger_property_is_writeable(struct power_supply *psy,
 					      enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 		return 1;
 	default:
@@ -246,6 +278,7 @@ static enum power_supply_property gpio_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
 };
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -256,6 +289,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct gpio_charger *gpio_charger;
 	struct power_supply_desc *charger_desc;
 	struct gpio_desc *charge_status;
+	struct gpio_desc *charge_type;
 	int charge_status_irq;
 	int ret;
 	int num_props = 0;
@@ -304,6 +338,15 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		num_props++;
 	}
 
+	charge_type = devm_gpiod_get_optional(dev, "charge-disable", GPIOD_OUT_LOW);
+	if (IS_ERR(charge_type))
+		return PTR_ERR(charge_type);
+	if (charge_type) {
+		gpio_charger->charge_type = charge_type;
+		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_CHARGE_TYPE;
+		num_props++;
+	}
+
 	charger_desc = &gpio_charger->charger_desc;
 	charger_desc->properties = gpio_charger_properties;
 	charger_desc->num_properties = num_props;
-- 
2.25.1


