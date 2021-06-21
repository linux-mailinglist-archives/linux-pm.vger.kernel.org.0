Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5B3AF777
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhFUVff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 17:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhFUVfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 17:35:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3804C061574;
        Mon, 21 Jun 2021 14:33:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k8so4183052ljk.7;
        Mon, 21 Jun 2021 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwLiDvKh+SYknHvIUl9sZJTxK3M1sxYb6xuIBop9DcM=;
        b=CGENMLH4FOKUotexatotqZrpSnrbqA4qPnOp5TuH0n6mWIHe64R1nJKEF5w6TJMnYV
         boWZlAOumdzJOeNlpjwWA+gW9s2xjU1TdQVWXvfkjlrhxXuuT6D3M7lgK5WW9D4KZcCo
         BtvhljYxplt9UAjTjXD/80UvQzyRsvBd7Pzn/nK1KXl9zS8KY/BiwypeWYmgcyurJMOd
         iIQuJGttsmtHaNt/CeSePAVAbOkSgD1A9OS/Y4BZG9XhzmJiheG1PD8F/aoH4Kz91Aca
         nseH7Rw7WL6tyKdxQO9xCqSZiw6iYycSCTv7G+J18/eDHBUNqUaXQ8hYp8WIM879zxlf
         ygvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwLiDvKh+SYknHvIUl9sZJTxK3M1sxYb6xuIBop9DcM=;
        b=G0yIra/1DIgK4/Bil2Al+4LXdJrAGPVOaIYEkhaxrScGdc84IU5t5ThW7GgPxCpDAL
         y8H8qvL2vumwNvKhviTXNrab8Iep/Ss39meLToFw4/AJoWEveV2i7sup0HSs/ZV15dPG
         kEQwaA3jJjSUG3He8Eu191YXmZlQZ2trCli7rzJeDsEhpzUkjDmUagJpec7On7pEWCpW
         w2ASJzVgGfiFv2F1Jvx79fW4T2WpSBbzXs+91WpaGdQI2ZD8Z0iS68fcKoDq/eWgY7xR
         xUpuQY4ISrEQWufVFvS3CweXsiu7PQULR7yIcGTHQJZAJJfqxfj/1xa531YQhKR7Fq9P
         xlSA==
X-Gm-Message-State: AOAM53274EKOn99hL/gn9g9zaO5N0K2jLlRpjq0NdwqgQszlsmDSaI1H
        9urkwAK++pwO7xJMGfpThBM=
X-Google-Smtp-Source: ABdhPJzYpGk8aMYTdwETyUthyvjaqalAG3POwWNtEPPFWfh3BtaoZ68RIC1fNdTnARTZwtFEAqKQvQ==
X-Received: by 2002:a2e:9009:: with SMTP id h9mr206916ljg.213.1624311195066;
        Mon, 21 Jun 2021 14:33:15 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id u10sm1074722lfg.240.2021.06.21.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:33:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 2/2] hwmon: Support set_trips() of thermal device ops
Date:   Tue, 22 Jun 2021 00:31:53 +0300
Message-Id: <20210621213153.28247-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621213153.28247-1-digetx@gmail.com>
References: <20210621213153.28247-1-digetx@gmail.com>
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
 drivers/hwmon/hwmon.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index fd47ab4e6892..9cb9d814cb88 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -153,8 +153,41 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
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
+	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MIN) {
+		err = chip->ops->write(tdata->dev, hwmon_temp,
+				       hwmon_temp_min, tdata->index, low);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
+
+	if (info[i] && info[i]->config[tdata->index] & HWMON_T_MAX) {
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

