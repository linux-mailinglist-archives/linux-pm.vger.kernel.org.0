Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0A3ADF54
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFTQPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFTQO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 12:14:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25BC06175F;
        Sun, 20 Jun 2021 09:12:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f30so25947738lfj.1;
        Sun, 20 Jun 2021 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKgHGyGZjSOsl6hRAHGiJYUzYl3Maz/O7xoBkKHr68o=;
        b=PAK99+N6GBixYYqpNJ5I8Y0S2c6J0K9dq+Jt9AcBii34eUqJl7x8HUtjd75ASyPdmF
         9dz+8eVHpywrNPVuSDeiBbTE8E+2w0iJQ+XHuC/+z3/sYU/f5zE53ZkvaWTnp915tGhb
         384aERDsux4nZv40f5J1QFqqzqwPdAQrWnEf+pLB5uTXEMvTHqb9i7mi5p7R43y6PpOk
         2d3ErDhMHoG4Q6cPAH/iQ6CxnhbXj0powGq7l+Y7E/K8MROZr0NJQp9UfiMIHQ1ZlcZ2
         18IcUm6ZprXwV9YotxDFTf1qSTtmSmMTS9Tb+Ak0xYTJleV2L5Q3aKOgSVZsDEadEwQU
         +HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKgHGyGZjSOsl6hRAHGiJYUzYl3Maz/O7xoBkKHr68o=;
        b=AMoqKmNDdsApADIBuhG5unyIHjZ5wtkgWXtDn90M3JADz+VfoUOrS14DW01YsoBGPk
         veL1DyNJ9Ek7TSwuxWrF+LDcu+gS62znBpvsB0WIEUNUMR05p4J3VsvNimt//+f7MaER
         AyLVk7rcmb7t8QJUX+iEJvcoXpD2NFMDrCaOtpIJiBvWx9iN1xm2h7izZ7DKqIcKkOjZ
         62TTm9A98e0p9l/7wLa2G1em3CDSrrspc1wJCh8bQ/GmaIvZ2OTIoGiGBFutHWrxDaVh
         AE+RNpCf9sq3DHqgH4PoKtM2S+5d6phiiMCfSNK1EU/TXWurPap1d3OLkwyG9kw1y9L6
         BLUg==
X-Gm-Message-State: AOAM531r4eanXvo1UzQM5ztSdiotunuerncJSSdKjH1wprlEdiZ87aHg
        5n2EkyrZAv2dVg8ypuvF4DY=
X-Google-Smtp-Source: ABdhPJwvCxm1B7ZGRNGv9X+CiRw0EZQHG0KV4/Z1R8TsYORGP8ZhhAix8+qzdbAG92aIzbMy9hLxyw==
X-Received: by 2002:ac2:5c0b:: with SMTP id r11mr11600691lfp.655.1624205564662;
        Sun, 20 Jun 2021 09:12:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id a21sm1849419ljj.21.2021.06.20.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 09:12:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: (lm90) Implement set_trips() callback
Date:   Sun, 20 Jun 2021 19:12:23 +0300
Message-Id: <20210620161223.16844-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210620161223.16844-1-digetx@gmail.com>
References: <20210620161223.16844-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement set_trips() callback in order to operatively notify thermal
core about temperature changes. Thermal core will take control over the
LM90 temperature limits only if LM90 is attached to thermal zone in a
device-tree and sensor interrupt is provided, otherwise old behaviour
is unchanged.

Currently only NVIDIA Tegra boards are specifying interrupt for LM90
sensors and only couple of boards use sensor for passive cooling of CPU,
otherwise sensor isn't actively used. Hence this change doesn't bring
any visible effects to userspace, it merely improves thermal device
capabilities of the LM90 driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/lm90.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b53f17511b05..7180af611dfb 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1406,6 +1406,35 @@ static int lm90_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+static int lm90_set_trips(struct device *dev, int channel, int low, int high)
+{
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int err;
+
+	/*
+	 * It makes sense to set temperature trips only if interrupt is
+	 * provided since the whole point of temperature trips is to get
+	 * a quick notification about temperature changes.
+	 */
+	if (!client->irq)
+		return 0;
+
+	/* prevent integer overflow of temperature calculations */
+	low  = max(low, -255000);
+	high = min(high, 255000);
+
+	err = lm90_temp_write(dev, hwmon_temp_min, channel, low);
+	if (err < 0)
+		return err;
+
+	err = lm90_temp_write(dev, hwmon_temp_max, channel, high);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static umode_t lm90_is_visible(const void *data, enum hwmon_sensor_types type,
 			       u32 attr, int channel)
 {
@@ -1804,6 +1833,7 @@ static const struct hwmon_ops lm90_ops = {
 	.is_visible = lm90_is_visible,
 	.read = lm90_read,
 	.write = lm90_write,
+	.set_trips = lm90_set_trips,
 };
 
 static int lm90_probe(struct i2c_client *client)
-- 
2.30.2

