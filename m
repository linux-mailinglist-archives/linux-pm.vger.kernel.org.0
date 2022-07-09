Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4978D56CBB9
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGIWc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Jul 2022 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGIWcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jul 2022 18:32:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB018342
        for <linux-pm@vger.kernel.org>; Sat,  9 Jul 2022 15:32:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so2570313wrd.13
        for <linux-pm@vger.kernel.org>; Sat, 09 Jul 2022 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=5+nVIY1h5cCqeMSuGbhtRjv4VG+ayIC1YDkoQWXD9lNlwIb2hlr/n7ia48iLg8uA0X
         wD7QPzSr3zNdbS6lcE6k7JrcxMfElaPBp5T7W//s2zy2BJW3IKqlXPWsOFej0hvgKL1I
         ZO1g62euWmVM6eb2bXSWs2myWiNNqpFKJkWOx68OHkN8YV5OiW2zjEJHJqlSsdPiCEw7
         7pYnICXBy6iz1duDmg+3tRtpfGfvinHhCuyG5QF3kR73VMnhcTNjrxyXny0gdya95JIU
         PRhgAXmKhV8s+w/Y5ymdRhsULjkHh1ZGTd8ErfOYC8FNn/rzveDkypp/Ghww2c+wUuUL
         ye/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Cg8NIEv3M0ZsrQ6LuqyJLiJb25T+jZLIiP7PzCJ4Cg=;
        b=JcC7xgWTUncA1fNU2jU/PL6G52gQ5teqyNxpCAO1qz+Jr4Hg623LvzArCVtEMyqttQ
         lQ9yzDIPKTfankU6M/r5QKl0HwJ8TXha49A6hGomTHC//mJ+w90OcXOP9GIS92JZlLFR
         tv7Uawuw0zXZCvdhJJESDydb2XbfFuiB3VemWq+PWOSwTcpkGUoIgTKMXkO+KLu7ow7m
         mASgXrzaWt9OTOSKH5kHoiyYTrzb7v+caJGqoM23KuBwsZ0svq+2VMFmpCNGt8gP8rd4
         OKya16LNos/34zlpEvAeOcicT13q6iILGhrFRSvfsoZr0nKQZpSahdjZTvmlf/ixNzkR
         7NOQ==
X-Gm-Message-State: AJIora9ZBgoUCUELJqgP3fD/PcIWplOHSGwNhkcTDOw3/z90yvzdKkxa
        /rmbmYgAAsvfbRPpUW/9mtteRw==
X-Google-Smtp-Source: AGRyM1traD5Jboz0hFEubYpwKHbok+/hNmqOaGd+HXEHcCQnMDbLvWMBSsczFLNNKxrkoDjMLg0CxA==
X-Received: by 2002:adf:f646:0:b0:21d:7000:95b1 with SMTP id x6-20020adff646000000b0021d700095b1mr10207787wrp.486.1657405965975;
        Sat, 09 Jul 2022 15:32:45 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 04/12] thermal/of: Move thermal_trip structure to thermal.h
Date:   Sun, 10 Jul 2022 00:32:21 +0200
Message-Id: <20220709223229.1619339-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The structure thermal_trip is now generic and will be usable by the
different sensor drivers in place of their own structure.

Move its definition to thermal.h to make it accessible.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h | 12 ------------
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ff10cdda056c..60844e2d59bb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -68,18 +68,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- */
-struct thermal_trip {
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-};
-
 int get_tz_trend(struct thermal_zone_device *tz, int trip);
 
 struct thermal_instance *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 365733b428d8..6289b0bb1c97 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -80,6 +80,18 @@ struct thermal_zone_device_ops {
 	void (*critical)(struct thermal_zone_device *);
 };
 
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ */
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
+
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
-- 
2.25.1

