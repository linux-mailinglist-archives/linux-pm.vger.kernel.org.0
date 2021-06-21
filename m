Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1673AF53A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUSnd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFUSnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:43:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA9C06175F;
        Mon, 21 Jun 2021 11:41:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u13so12508385lfk.2;
        Mon, 21 Jun 2021 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaHrTHwOZlGiJZp19fuqPfINJsoeOnFyeJ/MKkylnkI=;
        b=EfIszghJdm21cMreSbQ996P4YHET0dcRSj3dKOVqDInMzRelDwW2na///uju3wbFB4
         L3NnrpvKinrjb2pK/l/SuBtg5aQNPinZRpOY9mIda+IZS4aFdxtKAfUdA4cpmNIC/TTa
         XrkUgszFd9zc/OWujPxq6c2dFgnRxP3CZiN/oCvkkHOolOvUawfXW586wlfvnzk+78/O
         Y+M1pqaCt66DBNmESW4qkSmv4jnAYc7MZ3FlkeTx+In/x2uNXthFjDtOO5fDn+bM0nWq
         yGzcr1bMU6FylSmEVKPfBi6FoXGdzKlj4BG1n7EYZ2eDEMVTDOkM3MUlI0tWiE2Z7rcS
         NGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaHrTHwOZlGiJZp19fuqPfINJsoeOnFyeJ/MKkylnkI=;
        b=D7/jO2zagXoG1QOdBeDvBCOdIoFxqzJBtlqEpdIGjq14wYf3PjmgMQ7IhB/og46m4g
         cD/DGmpn56e0RL5qqWPvsM+hm8a4irM2VDaPtRaLUIFyMrX6MLL/B+EJRh/z35VLDmAF
         ckkMjW99cvUUo72SOsK6uFbj0yqKUT13TU0uHlLgrxAc3kBYUZzD+9mGuHEPMhqSBn/n
         2RZqlzg6Z7ry2PsgquumilKBeOwoM0agHdElzRw46D8f4UCCuelpBPcOxz1akA7y4pCT
         FgWyrg33+dDxIhhCp4+TwyuvR6h2xieFWxMi4iV71PG2qhL8dhUpdYPE5CUV0ZuUrdRK
         m5yQ==
X-Gm-Message-State: AOAM532ZbDYDC/k6tuTY8IMiMwjeJJka1krJ/q6zZnrWT7Y5XTr2+Esb
        fV3nDPB2xTfvb09yVPfk3gc=
X-Google-Smtp-Source: ABdhPJxwJmm4BeibPP0lzIuhx6wMYOcQrZkZUFKCj4OeTFs2ubahQPT6J+uDdEPtnXKz7H2EBRHwFQ==
X-Received: by 2002:a05:6512:92d:: with SMTP id f13mr15320408lft.186.1624300874353;
        Mon, 21 Jun 2021 11:41:14 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id y22sm1950843lfa.145.2021.06.21.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:41:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: Support set_trips() of thermal device ops
Date:   Mon, 21 Jun 2021 21:40:58 +0300
Message-Id: <20210621184058.4110-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621184058.4110-1-digetx@gmail.com>
References: <20210621184058.4110-1-digetx@gmail.com>
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

