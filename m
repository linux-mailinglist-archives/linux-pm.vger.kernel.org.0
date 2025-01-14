Return-Path: <linux-pm+bounces-20445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD9A11220
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF97188AFA6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1420B80A;
	Tue, 14 Jan 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgf9Vwaw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4472208974
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886980; cv=none; b=YnrDX7vb1IqjRO6lNV0E36xmObTjkvOhxFPlEiuDzhyY+onD/G8egPEmSqo7pECUx1seUm5SCdozIevgQ16/DH+8byx0Le8hVNiat23l2KK8Z5pVxTz2G/GoiqsuZA0GbuGgQJCyeqgMfHMnfDxzGcZKCA30ALfo8LjiMzVrcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886980; c=relaxed/simple;
	bh=gS2tWpA0GbEwM/UrYpG6nfxlsBb4yRzG9ZzVj5HoQ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfEprWavhM9Dsej4tzVZfBcllOAknO4zh7i5s2cSqfnQYUQtpMb96SF/H1gmHWeHYpPUNmydxlxKULAYjoE1lr+v0xWKz9g51YcJXrozC9Auk5Qii0ZSKWk0TU2Jl8Uexo3bGZpHorzqmYWfyEoviIIL6cIQSPMAtoZ9rsCbFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tgf9Vwaw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43616bf3358so7514315e9.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736886977; x=1737491777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqhlC6RQ0+FQLPBPdYr6MxzFHvj3QH9yoD42eRdXTpE=;
        b=Tgf9VwawuMcILGWUsD8A4Tb52+9ntk7X4Hz8AqWWYBDRFBIyp+YeJeE7IE2E2sNGm3
         OeN1YA9ilvf2kC3doWCcUQFfhqmxsv7F2FGJM8SFv/xap8N5MQ0KeHQ+7yeMcWDTTtIa
         cZiCEA7wy/vgFzrp40Zi1R7vtAfZNoq+rVtDnQ2iSFO4RHMXkkIwytICVMmQ/bh1rLKx
         EsL3MRA79T3OyIvuuWfctFOlQv5CLH/HVpX07vJ27zUUnjYfD8ThOF5Go2mHiESTgKNV
         lGCjGPHLfkH/eIyn3EgPTPA5HKwOuSPg50s3VAVENTKUdaxbcgEpyjxNatKqP+ootTTN
         FoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736886977; x=1737491777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqhlC6RQ0+FQLPBPdYr6MxzFHvj3QH9yoD42eRdXTpE=;
        b=KwnC8dzT24N8X6ZDZGOLKqqHBx46uFY99tpQQrnsvpmXwn8AXDarAeGcyNEAv35uvJ
         tpkzy0ygzrh9ZEwm9OaXfjGjDpQAj4tNnPLUYpfduAOg2CVJQblJVe2QZlAJ1HoQFgVO
         O7DHWjXm6xKI1zV0sLHcfUf+Wlx4TOJZ2f2cslwozzO31PSkXumI+jHzqkZH59nUshgW
         DFqzmZAN6fTUYkX1lNfrloDMgcU/3kwuFuyY+XLp0oDMt5apa82/55KF7s9rQ/sZsjfB
         y2ClthDG5VW+6PxqbAJ5jaQtpQEEw6vqEZA7FH/wxe7d4Gv0zs4TOqx8iGcUUaXJuakx
         fP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCvSD3H2pi6xXQJUkWgBBgaSuZWmCazlsItRM5Qc+RYgvV2sL3BwK4MHCOViLzEeci3pohMhk/iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtfH3gRdGT1ACKRE/QCY8S//BRVmaP+vYuYuL08SR3J5ylqGT
	s7QHL1SwPZhLagiH4/ETtgg7M3wroqLABPKq8b7irFyWXod0RuuWzQSlE/MxNSVKjgOuTvuVyEF
	3
X-Gm-Gg: ASbGncs7HVULePOs3fTJTAzk5aGc1iMajgk8VlnsiNumNSWDDZ7QL3I9gcCZSpl7NzE
	RX6IDOgFEQsliFHS0W12VOPIFVdoUFeIy1QP1OtNsNqRwG+6+XvXfOFQhxFwEuHXqOLri15d0aT
	McnNbdyj4rI7sKgW6Af9zxZCQBGhao3ox7fEthersFVerpzzvqe2mJ9YPFj3xdl5GsfwcMwQrGN
	I3gmemqVTgpQKePrIq9z7bumhS1JTPmd1bwkgw6VxOQMWSZh6EgA1CdqrHvmAJc+CVoCo8=
X-Google-Smtp-Source: AGHT+IFMhRoEAtSbN0L+Bt9NTb3syOW3OEuQGe010Dhx0qHFCjXkdD60E5s2ytRq5B5M4Gl29FBoCQ==
X-Received: by 2002:a05:6000:402c:b0:386:3afb:19a with SMTP id ffacd0b85a97d-38a872ea989mr9171714f8f.4.1736886976759;
        Tue, 14 Jan 2025 12:36:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b7ff0sm15874440f8f.77.2025.01.14.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:36:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: supply: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 21:36:11 +0100
Message-ID: <20250114203611.1013324-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/88pm860x_battery.c | 4 ++--
 drivers/power/supply/charger-manager.c  | 3 ++-
 drivers/power/supply/cpcap-charger.c    | 3 ++-
 drivers/power/supply/da9030_battery.c   | 3 ++-
 drivers/power/supply/sbs-battery.c      | 5 +++--
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index b7938fbb24a5..edae1e843c51 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/power_supply.h>
+#include <linux/string_choices.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/delay.h>
 
@@ -503,8 +504,7 @@ static void pm860x_init_battery(struct pm860x_battery_info *info)
 	data = pm860x_reg_read(info->i2c, PM8607_POWER_UP_LOG);
 	bat_remove = data & BAT_WU_LOG;
 
-	dev_dbg(info->dev, "battery wake up? %s\n",
-		bat_remove != 0 ? "yes" : "no");
+	dev_dbg(info->dev, "battery wake up? %s\n", str_yes_no(bat_remove));
 
 	/* restore SOC from RTC domain register */
 	if (bat_remove == 0) {
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a69faef444c0..c49e0e4d02f7 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/power/charger-manager.h>
 #include <linux/regulator/consumer.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/of.h>
 #include <linux/thermal.h>
@@ -1088,7 +1089,7 @@ static ssize_t charger_state_show(struct device *dev,
 	if (!charger->externally_control)
 		state = regulator_is_enabled(charger->consumer);
 
-	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(state));
 }
 
 static ssize_t charger_externally_control_show(struct device *dev,
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 7781b45a67a7..6625d539d9ae 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
@@ -515,7 +516,7 @@ static void cpcap_charger_vbus_work(struct work_struct *work)
 out_err:
 	cpcap_charger_update_state(ddata, POWER_SUPPLY_STATUS_UNKNOWN);
 	dev_err(ddata->dev, "%s could not %s vbus: %i\n", __func__,
-		ddata->vbus_enabled ? "enable" : "disable", error);
+		str_enable_disable(ddata->vbus_enabled), error);
 }
 
 static int cpcap_charger_set_vbus(struct phy_companion *comparator,
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 34328f5d556e..ac2e319e9517 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/string_choices.h>
 #include <linux/mfd/da903x.h>
 
 #include <linux/debugfs.h>
@@ -138,7 +139,7 @@ static int bat_debug_show(struct seq_file *s, void *data)
 {
 	struct da9030_charger *charger = s->private;
 
-	seq_printf(s, "charger is %s\n", charger->is_on ? "on" : "off");
+	seq_printf(s, "charger is %s\n", str_on_off(charger->is_on));
 	if (charger->chdet) {
 		seq_printf(s, "iset = %dmA, vset = %dmV\n",
 			   charger->mA, charger->mV);
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a6c204c08232..6f3d0413b1c1 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -21,6 +21,7 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/string_choices.h>
 
 enum {
 	REG_MANUFACTURER_DATA,
@@ -320,8 +321,8 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 		client->flags &= ~I2C_CLIENT_PEC;
 	}
 
-	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
-		"enabled" : "disabled");
+	dev_dbg(&client->dev, "PEC: %s\n",
+		str_enabled_disabled(client->flags & I2C_CLIENT_PEC));
 
 	if (!chip->is_present && is_present && !chip->charger_broadcasts)
 		sbs_disable_charger_broadcasts(chip);
-- 
2.43.0


