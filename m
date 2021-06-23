Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D576C3B12AB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFWEZJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFWEZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:25:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F7C06175F;
        Tue, 22 Jun 2021 21:22:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so1892937lfq.0;
        Tue, 22 Jun 2021 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJ1Yrh3P0J3boFKwBb0RVLJAPP2FR7myilZdK+WC06w=;
        b=RsuP/c+LK3gRUticzJF5jDp1VQlDgtgmvkOsnTR/SJI8v1GDX2FsnE0tuMt41KGO4c
         xYgLUsrzYHG76+F6jQE/s0UHpnJyoptn8QWgquvvginUoJ9dA4x7nKh5hisMu1p3XkFX
         kW3viZE8tahDdzcIkns/H6mOZ8X/i7VjYKjQPAt9Y7qpuMBsj73dpRB3A9XPAYsoJTUF
         HFcwKH08b/mztGMJit/4WgR6Km6Mc2J8rI4R2EhtL+1nxFCGnG+Yx6iOHanN2n8heRhA
         9NOeLU+sN4MOfRyVf1eIaGrqLkY/vxwRFuroy9mG7/ANwur9JS2WpDXEqZLiJEN6PyXc
         mgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJ1Yrh3P0J3boFKwBb0RVLJAPP2FR7myilZdK+WC06w=;
        b=ldbtwO5AyHdLjZsTQObwgRXDsHmiylW5pWGBVYYlcL1KxQi8cOOyutDYy3sdR12ErJ
         uVmNTzoqxaro+oQJMMsjS9PzhfbjT6ll9waQm8zY2JnH345ViTUm6P+OFyF5UQ3lHRjm
         ZxoBoVw8AipMzEidDFkuolAGjbe2v6Zn7tWmiLPBZ/9rty0QgL3j9Xz7PEet/M5VLUGY
         NbTVkPxLgp3hl9Ra9HfsHGNMwXHY1Hyu44ArWs/ktc5IjU9PMx6Q0SH9IG/qCIkJDyi7
         r0gb8niQ5VdO8Ux+XPJGm2srErSUbs/8bOntSEqZp3e4yDgx/3ohyT/MQgebtPumBCLo
         CZDg==
X-Gm-Message-State: AOAM532saXtQvRmX6BKCfLhm92JQ/9borI5XLooRSde/RRclBuFA2MjY
        0F8d+AnFmXrRSchaAkqsYVY=
X-Google-Smtp-Source: ABdhPJwj3V4eoGBqFp7xzMGSLGtvGixqfhhA9TZaHqXaN/mi2doqQfx8BeLiYKpkeej2wtSQpiyjRA==
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr5474058lfe.116.1624422168612;
        Tue, 22 Jun 2021 21:22:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id c9sm174027ljb.22.2021.06.22.21.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:22:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 2/2] hwmon: Support set_trips() of thermal device ops
Date:   Wed, 23 Jun 2021 07:22:31 +0300
Message-Id: <20210623042231.16008-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623042231.16008-1-digetx@gmail.com>
References: <20210623042231.16008-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support set_trips() callback of thermal device ops. This allows HWMON
device to operatively notify thermal core about temperature changes, which
is very handy to have in a case where HWMON sensor is used by CPU thermal
zone that performs passive cooling and emergency shutdown on overheat.
Thermal core will be able to react faster to temperature changes.

The set_trips() callback is entirely optional. If HWMON sensor doesn't
support setting thermal trips, then the callback is a NO-OP. The dummy
callback has no effect on the thermal core. The temperature trips are
either complement the temperature polling mechanism of thermal core or
replace the polling if sensor can set the trips and polling is disabled
by a particular device in a device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/hwmon.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index fd47ab4e6892..8d3b1dae31df 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -153,8 +153,44 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
+static int hwmon_thermal_set_trips(void *data, int low, int high)
+{
+	struct hwmon_thermal_data *tdata = data;
+	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
+	const struct hwmon_chip_info *chip = hwdev->chip;
+	const struct hwmon_channel_info **info = chip->info;
+	unsigned int i;
+	int err;
+
+	if (!chip->ops->write)
+		return 0;
+
+	for (i = 0; info[i] && info[i]->type != hwmon_temp; i++)
+		continue;
+
+	if (!info[i])
+		return 0;
+
+	if (info[i]->config[tdata->index] & HWMON_T_MIN) {
+		err = chip->ops->write(tdata->dev, hwmon_temp,
+				       hwmon_temp_min, tdata->index, low);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	if (info[i]->config[tdata->index] & HWMON_T_MAX) {
+		err = chip->ops->write(tdata->dev, hwmon_temp,
+				       hwmon_temp_max, tdata->index, high);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
 	.get_temp = hwmon_thermal_get_temp,
+	.set_trips = hwmon_thermal_set_trips,
 };
 
 static void hwmon_thermal_remove_sensor(void *data)
-- 
2.30.2

