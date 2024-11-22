Return-Path: <linux-pm+bounces-17939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694D9D58AA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 04:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DA91F236A9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 03:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2781632C6;
	Fri, 22 Nov 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ldm3BVuK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBA15B149
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247259; cv=none; b=qjk4A3BBELZGO/gCx6LFUyYexCsJQNnqVx1u0RPg0x/0L3+61s4I3imkqaEqA+OD6FT8j9wl5bch5NLg2yCJI/aqpUs1NDn1b7p/c+/ShRkRbKVFND9X1gMUGMURa/8pn7TaZCxeSHYnXwmG7TVPp355N3k9Z7C96HpyKkLnksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247259; c=relaxed/simple;
	bh=0NAcyLrHHDhRn82WN0izrFPbVZrkw97X7FSs9cPtqXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8hqfPOdTBmIwwPOa7aHXxHFg8eFqFTF+lP4iKLUtpZE+IxOoJTTF6hwO9FVQ0q+g3uqAkWuuq2u/FwxR9VtcKLG5m3jXUKvFi9R7d/H9kt0+uRkYjyIHQlVDPd6ZPhU3h6Nepw1cZOuVhebVaeFoQctowvW/R1L4+z26lEVlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ldm3BVuK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e786167712so1108889b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732247257; x=1732852057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5LY5RXpPtd9Rkf3ibKsfLHvQo7hHTlxcwyEUNtbdks=;
        b=ldm3BVuKcKz0tbeR1U7DEVCZrbFmFBHgKAmqtzW+UCdmnBol8RdEwkh/8NV4nDEEQM
         ZqUpOFo8IvzsH5McV57SOr6QKc/7wwNGRK1U9MwwPzEuN9eZSFj83i92mPXxyuaUJKcE
         kmtkvUATTjqZptD6gAuiYEKcb1YL76nTeRfcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732247257; x=1732852057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5LY5RXpPtd9Rkf3ibKsfLHvQo7hHTlxcwyEUNtbdks=;
        b=OGHeeMSr4BO1zdXMR2U7qHNHfda1XJCAtsTBBi5BKTQ6MFT+GeByYuzf5HLuBfikQ3
         GYz5mRW8w2EIWC/7IuR7aKv53zOhvbJom9XjXiVcM+0ew6eFHFaF2oJQTkTM2As2Zh59
         fmJPoVrZtncXpwIytliOh8WRokLdWFVqoqPyAKkJNCOw8ls5O68H538nQE5FdADFJfYR
         JlkIdnkeBeR8JDLezOAcZhVw+WWnyVU1crSVyw3X7spv0i3Ee8mn6zPEuGNdV2XZGQ2a
         FNelx3hTKV2b7HHIfq3hRv4uyofjWLW1D0B0BQVtxtf+dGB55kVxgy7FWrp/GNYJEWho
         snLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT3CwOh5AphviN8qR7kmkb76GNqK9d4YaSi8vOKdZu/Xvzc2m4x3yHHyCAqkRGZR0YMea73PcIqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4w+PbJFbuaHa5j48Aql90wXTXz2/LxYKjM/1BkAYsYl01xbGb
	5ZMaX3ODn6QpU/4+VWzBsESKizVLI0a6AyUA34oO6vGs1f/MA4mQiVZ5t5R3Kw==
X-Gm-Gg: ASbGncvG+mtUAaeNRSDDmpY6e7hjndjoMgLzy+sh0u2fv/8LT4n/YO/4u1rFT6+9Jfm
	csN9WhNWYbgzgTPIzGgSXubBE0dY2a9+R95w3SzY4uqJr4VpHYQG4sMyPZ4iVaIAiY+AhOtbWPf
	z2et4gLVwtn9Vx0Dzrxhjnf2E6LBUx+xAmh49hWe58Glq0OWGfzzB8qAfU4erfyqo4GAkNn7oxH
	XIDzmrgYYxqX3jab1sJu42oTDkzZUGB8K2A0fWUgjqwwj6v7H9CNXR/qV9Jsbps0XyLXa0=
X-Google-Smtp-Source: AGHT+IHryHek2XRVYS94YH2r4x03SqrwmBMFwfNHTimqb3KpUJr+MKVD5jT0i5y4nF7OMpy8M9x55A==
X-Received: by 2002:a05:6808:2205:b0:3e7:60b1:1f49 with SMTP id 5614622812f47-3e9157a1595mr1527992b6e.4.1732247256800;
        Thu, 21 Nov 2024 19:47:36 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:533e:26bf:b63:973a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de554b11sm550174b3a.133.2024.11.21.19.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:47:36 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Fri, 22 Nov 2024 11:47:21 +0800
Subject: [PATCH 1/2] power: supply: cros_usbpd-charger: extend as a thermal
 of cooling device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-extend_power_limit-v1-1-a3ecd87afa76@chromium.org>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
In-Reply-To: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732247251; l=5457;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=0NAcyLrHHDhRn82WN0izrFPbVZrkw97X7FSs9cPtqXA=;
 b=5RorBRojsc5DW6lyjii3KCfqlhvUkvwWPGbGmaVKEbwGjzsUje+27mQCbi8dCQMkBIUiTJa7T
 qCyOSvMN0GDAcumVzpM//xx+QPNcqSTpAAZ42bBWRr5S0yxWN39oTIi
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

cros_usbpd-charger is the driver that takes care the system input power
from the pd charger. This driver also exposes the functionality to limit
input current.

We can extend this driver to make it as a passive thermal cooling
device by limiting the input current. As such, this commit implements
the required cooling methods and OF style registration.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 98 +++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 47d3f58aa15c..a0451630cdd7 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -13,6 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#ifdef CONFIG_THERMAL_OF
+#include <linux/thermal.h>
+#endif /* CONFIG_THERMAL_OF */
 
 #define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
 #define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
@@ -22,6 +25,7 @@
 					 sizeof(CHARGER_DEDICATED_DIR_NAME))
 #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
 #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
+#define CHARGER_COOLING_INTERVALS		10
 
 #define DRV_NAME "cros-usbpd-charger"
 
@@ -76,6 +80,8 @@ static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
 /* Input voltage/current limit in mV/mA. Default to none. */
 static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
 static u16 input_current_limit = EC_POWER_LIMIT_NONE;
+/* Cooling level interns of current limit */
+static u16 input_current_cooling_level;
 
 static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
 {
@@ -459,13 +465,20 @@ static int cros_usbpd_charger_set_prop(struct power_supply *psy,
 			break;
 
 		input_current_limit = intval;
-		if (input_current_limit == EC_POWER_LIMIT_NONE)
+		if (input_current_limit == EC_POWER_LIMIT_NONE) {
 			dev_info(dev,
 			  "External Current Limit cleared for all ports\n");
-		else
-			dev_info(dev,
-			  "External Current Limit set to %dmA for all ports\n",
-			  input_current_limit);
+			input_current_cooling_level = 0;
+		} else {
+			dev_info(
+				dev,
+				"External Current Limit set to %dmA for all ports\n",
+				input_current_limit);
+			input_current_cooling_level =
+				input_current_limit *
+				CHARGER_COOLING_INTERVALS /
+				port->psy_current_max;
+		}
 		break;
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 		ret = cros_usbpd_charger_set_ext_power_limit(charger,
@@ -525,6 +538,66 @@ static void cros_usbpd_charger_unregister_notifier(void *data)
 	cros_usbpd_unregister_notify(&charger->notifier);
 }
 
+#ifdef CONFIG_THERMAL_OF
+static int
+cros_usbpd_charger_get_max_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long *cooling_level)
+{
+	*cooling_level = CHARGER_COOLING_INTERVALS;
+	return 0;
+}
+
+static int
+cros_usbpd_charger_get_cur_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long *cooling_level)
+{
+	*cooling_level = input_current_cooling_level;
+	return 0;
+}
+
+static int
+cros_usbpd_charger_set_cur_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long cooling_level)
+{
+	struct charger_data *charger = cdev->devdata;
+	struct port_data *port;
+	int current_limit;
+	int idx = -1;
+	int ret;
+
+	for (int i = 0; i < charger->num_registered_psy; i++) {
+		port = charger->ports[i];
+		if (port->psy_status == POWER_SUPPLY_STATUS_CHARGING) {
+			idx = i;
+			break;
+		}
+	}
+
+	if (idx == -1)
+		return -EINVAL;
+
+	current_limit =
+		port->psy_current_max - (cooling_level * port->psy_current_max /
+					 CHARGER_COOLING_INTERVALS);
+	ret = cros_usbpd_charger_set_ext_power_limit(charger, current_limit,
+						     input_voltage_limit);
+	if (ret < 0)
+		return ret;
+
+	input_current_limit = (current_limit == port->psy_current_max) ?
+				      EC_POWER_LIMIT_NONE :
+				      current_limit;
+	input_current_cooling_level = cooling_level;
+	return 0;
+}
+
+static struct thermal_cooling_device_ops cros_usbpd_charger_cooling_ops = {
+	.get_max_state = cros_usbpd_charger_get_max_cooling_state,
+	.get_cur_state = cros_usbpd_charger_get_cur_cooling_state,
+	.set_cur_state = cros_usbpd_charger_set_cur_cooling_state,
+};
+#endif /* CONFIG_THERMAL_OF */
+
 static int cros_usbpd_charger_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
@@ -534,6 +607,9 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 	struct charger_data *charger;
 	struct power_supply *psy;
 	struct port_data *port;
+#ifdef CONFIG_THERMAL_OF
+	struct thermal_cooling_device *cdev;
+#endif /* CONFIG_THERMAL_OF */
 	int ret = -EINVAL;
 	int i;
 
@@ -674,6 +750,18 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 			goto fail;
 	}
 
+#ifdef CONFIG_THERMAL_OF
+	cdev = devm_thermal_of_cooling_device_register(
+		dev, ec_device->dev->of_node, DRV_NAME, charger,
+		&cros_usbpd_charger_cooling_ops);
+	if (IS_ERR(cdev)) {
+		dev_err(dev,
+			"Failing register thermal cooling device (err:%pe)\n",
+			cdev);
+		goto fail;
+	}
+#endif /* CONFIG_THERMAL_OF */
+
 	return 0;
 
 fail:

-- 
2.47.0.371.ga323438b13-goog


