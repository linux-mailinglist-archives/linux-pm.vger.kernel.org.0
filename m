Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF503AE0A3
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFTVRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFTVRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 17:17:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2602CC061756;
        Sun, 20 Jun 2021 14:14:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k8so22103788lja.4;
        Sun, 20 Jun 2021 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaHrTHwOZlGiJZp19fuqPfINJsoeOnFyeJ/MKkylnkI=;
        b=iPkoimYP4z9sTNire4AhXY0aCkbJ5pbS8R+a6ry1JodIl3ds76CfjrflELzpEVLLId
         OzUgSIL5qtEhSttFWqkPNyOzXEg4xdlHV9so5ChOlllIPUePLsIQFAAq9h+TDFJtuMXH
         9QTgYZI7Y8KuET13pYAaAKqu411jNf5Ov0S8F2hiJdRg2pSpg6wFOvDDB3xHA+xYXuJa
         rDchnNoTvVd5pjDP7m1fWKEF/rKQxenTxgyLFxh+QbJ5+r2DTNeZGHWJ0JXqhgK+zFTL
         E9SEt5iKgyGEr/VVqqKidZQXSOTL2KsJA31eALaTj4quzzx8L/VkCPD6DGv7QRW12gvU
         kaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaHrTHwOZlGiJZp19fuqPfINJsoeOnFyeJ/MKkylnkI=;
        b=KAmElPBUUUsPDs1lu6TFjt9ZHnz1yn9/yvH7bBJXcSuKQkq0tDmd5/U5VCAsBBT8dm
         15zT5QmFHw+1hwCIqaG3AiZCRKCMhRhW7fhF2/gpzptUUAuRQ2wCLL3Yf7LaxwdixqSA
         oAvsO6BgKYldGGx8MQZM4UNWL6X6qfsrUc8/kRUYI2cUKR6rBi4K8T2UVUfhESUp824U
         Wp62MZfuAuSQrrIHzvE1jF4VvV3KtZo41v+nVJsFiA62mXFA2/24eyR0ocx83BbveM9S
         955HbS+ahkbtpdbEK4XGu/FdrQq33NPiAaGQeucGSRp/xphW97SZdnlxBbI3nhEN5zTM
         xXYg==
X-Gm-Message-State: AOAM530j7bJ7rnpHubPFvnXfkzfEQaqAzx90Xpz4At/+/wCTvcnjldqf
        j/LR6bqMw6vI2vOxQMaNxpw=
X-Google-Smtp-Source: ABdhPJw+HUMlOU61q30lHlP5RWjBED6i428QQkPQOH8N1NCWH8MrgB45qDJjRmDlZkaWaKEBTNieFA==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr19080605ljh.409.1624223688456;
        Sun, 20 Jun 2021 14:14:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id o142sm62875lfa.299.2021.06.20.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 14:14:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: Support set_trips() of thermal device ops
Date:   Mon, 21 Jun 2021 00:14:08 +0300
Message-Id: <20210620211408.3893-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210620211408.3893-1-digetx@gmail.com>
References: <20210620211408.3893-1-digetx@gmail.com>
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
 drivers/hwmon/hwmon.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index fd47ab4e6892..e74dc81e650d 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -153,8 +153,40 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
+static int hwmon_thermal_set_trips(void *data, int low, int high)
+{
+	struct hwmon_thermal_data *tdata = data;
+	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
+	const struct hwmon_chip_info *chip = hwdev->chip;
+	const struct hwmon_channel_info **info = chip->info;
+	unsigned int i;
+
+	if (!chip->ops->write)
+		return 0;
+
+	for (i = 1; info[i] && info[i]->type != hwmon_temp; i++)
+		continue;
+
+	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MIN) {
+		int err = chip->ops->write(tdata->dev, hwmon_temp,
+					   hwmon_temp_min, tdata->index, low);
+		if (err < 0 && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MAX) {
+		int err = chip->ops->write(tdata->dev, hwmon_temp,
+					   hwmon_temp_max, tdata->index, high);
+		if (err < 0 && err != -EOPNOTSUPP)
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

