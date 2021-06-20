Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA43ADF4F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFTQPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhFTQO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 12:14:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FDC061574;
        Sun, 20 Jun 2021 09:12:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m21so25862759lfg.13;
        Sun, 20 Jun 2021 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpvnw+R16ZZxCZrBWAgLq/iykxbIjW5UolBixupkKsw=;
        b=IIhZti5BTRvUMzuB39REKFUlqbBxLT7xVWnEheIEBDPLLQHbqa+eRrpP+HoG4k52uq
         4zjSW3GQ0aSFEULXF4EmJbpVIwTVEk6qogtDl9b+bVh0qtWgSqF8Wy2hfFYy4dsl3fGu
         EJ75vzQuWKLiNjkXpAQ7LVjQvFWpYdNEXWXOLUr8jBcAOMrAkYHwSAwSUDGim9sXHQJ4
         Dz8l8jm1OugWyca/3e6G+fngT5OBoj+p6AaaDYjbd+vocuhsgHuuc8Ei3x3lMMrmzcTX
         t7iewb34GLDbFwf8Zn2kXdcdET8PaUre2JvH3GTCz/xmq2UHQUMEIqsxVjFDyVbLU5s0
         GuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpvnw+R16ZZxCZrBWAgLq/iykxbIjW5UolBixupkKsw=;
        b=pBNZmZRcFItB7SnXPq+HZN31acgJmqaz4U9Ynmn9vyu2RsCrosvSwXicMJlHXg9TRp
         RPdhX7jeumjDvQJYklfmj9t8EnOfdjLusDSkdVXFmbTnLacyWzdguKmNTaRdTZy/SPkG
         SZhjk6avZNvL8TYmJ71xidvQSH2PsrbcrVXIpBnEUOSuPjvbNTchojDBTmbL3W1iLqr0
         2jv7GQZV+YmzrbqjNbUTik341RATqBwlrQhQpguzHF9LridiMatkk8+1R3Vniqy8Aah1
         8LAo4tRRSHdDxTwQ5U6FWFdYcjw0YQDQ5ttX8V2TfDxBnIQI01zRdrIQ7SQIfl/RZ1y3
         vDgQ==
X-Gm-Message-State: AOAM533cjgIy653B86mWw2QY6TMcQwt6q9uJ3wTUXLCsHDmH9VTWcw8h
        bH7HddvDbPUZQE+A7cX44vs=
X-Google-Smtp-Source: ABdhPJzEzP1VOqEhJI1FBenkB57AGH3rl3HzHOXGjAe1S391ie/GXjXKTfLr86iw1/5IBu/2yIsaWQ==
X-Received: by 2002:ac2:4a61:: with SMTP id q1mr10994711lfp.572.1624205563748;
        Sun, 20 Jun 2021 09:12:43 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id a21sm1849419ljj.21.2021.06.20.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 09:12:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/2] hwmon: Support set_trips() of thermal device ops
Date:   Sun, 20 Jun 2021 19:12:22 +0300
Message-Id: <20210620161223.16844-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210620161223.16844-1-digetx@gmail.com>
References: <20210620161223.16844-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/hwmon.c | 12 ++++++++++++
 include/linux/hwmon.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index fd47ab4e6892..4bd39ed86877 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -153,8 +153,20 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
+static int hwmon_thermal_set_trips(void *data, int low, int high)
+{
+	struct hwmon_thermal_data *tdata = data;
+	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
+
+	if (!hwdev->chip->ops->set_trips)
+		return 0;
+
+	return hwdev->chip->ops->set_trips(tdata->dev, tdata->index, low, high);
+}
+
 static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
 	.get_temp = hwmon_thermal_get_temp,
+	.set_trips = hwmon_thermal_set_trips,
 };
 
 static void hwmon_thermal_remove_sensor(void *data)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 1e8d6ea8992e..7e5afcbf713d 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -390,6 +390,14 @@ enum hwmon_intrusion_attributes {
  *			Channel number
  *		@val:	Value to write
  *		The function returns 0 on success or a negative error number.
+ * @set_trips:	Callback to set temperature trips. Optional.
+ *		Parameters are:
+ *		@dev:	Pointer to hardware monitoring device
+ *		@channel:
+ *			Channel number
+ *		@low:	Low temperature trip
+ *		@high:	High temperature trip
+ *		The function returns 0 on success or a negative error number.
  */
 struct hwmon_ops {
 	umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
@@ -400,6 +408,7 @@ struct hwmon_ops {
 		    u32 attr, int channel, const char **str);
 	int (*write)(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long val);
+	int (*set_trips)(struct device *dev, int channel, int low, int high);
 };
 
 /**
-- 
2.30.2

