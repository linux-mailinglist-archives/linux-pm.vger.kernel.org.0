Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4EC5AF195
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiIFRB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiIFRAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DAAFEB
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:48:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t14so9067502wrx.8
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wKElCC452+uQH9oPG73me3V/zKr0MM7IvUS5jZU3ITo=;
        b=I0UanIPG6cavD3RAbIQDu3/9sgsbVr9VIqgemy5st9ic9vxiBP9bkzOCx7iFf+FE4x
         4/AosVO9pVb5R+zdmZbJXE0lXvjbWjMXOhf8Gmip81yCD/k1tkQoTrPhchA4ChmSilTS
         yKzGjOJzhtJhXnNE9F8xEK474N/iQqwQVMog+pRFwfTc4IHE813ArtxrRYdnKnyVYMB1
         xet1IbKiJ8Uhd7behB4tHXSb2xzHbHcJ3hO15UPlZUA5GQs4pl7uwHYnwpSfSdpqigQP
         DnIL7IQg/vpg/sb/OLumy4wDL7GujMduAAa3qri2TTj7ZqqDwEfYzQeIZXBupaRj0DDz
         /USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wKElCC452+uQH9oPG73me3V/zKr0MM7IvUS5jZU3ITo=;
        b=NTaWe492HhambTfTFiasD5MsLfCHgihPC+wXRt3R69Bi89E9c2n9YGcHg4jGjaizhz
         4tJtwBHFovytT1YNV0wO4X68zQ5aiEk+YzclR6r0J+5ngRUa6bODTILuUqzRShF+xfjm
         5s4BPbJiDgmid2M/Azp2LQJVGw/QC+rnVcWSLo0xatyAYdrwyuVo2uuPC+dYGJLIgRB+
         lTSAVlHcqlltZfzDMz22MpKNcKlBY0VSUHXLuYFs3ubNMm8P6AhYNXS99ZNGlYWylngx
         P7tjyNtZAczbPhY1rwX+NnMSisU6I2pJYHdY59veJjV4g9uChvrZlf7ora1t0WOY9Ng+
         K5Ug==
X-Gm-Message-State: ACgBeo2gv4pQNwNIWp89SLMX+8q1xqdbQ3NpWbOoCuraWkEDWpiAnZ3k
        YjnmojKgFb2pGzPfnU1scfAVKQ==
X-Google-Smtp-Source: AA6agR4UcazUuIL9MtGniarrvFOJph+eNwzOfx24809rri6jRiTGqofStNM60MlWuZ0P5gvZBHBGOw==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr27574446wrz.465.1662482878837;
        Tue, 06 Sep 2022 09:47:58 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 17/30] thermal/of: Remove of_thermal_get_ntrips()
Date:   Tue,  6 Sep 2022 18:47:07 +0200
Message-Id: <20220906164720.330701-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code uses the generic trip points to initialize the
thermal zone. Consequently thermal_zone_get_num_trips() can be used
and the of_thermal_get_ntrips() is no longer needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 99a5d5281037..0139bc1e4f87 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -137,13 +137,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return 0;
-}
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 2f533fc94917..89afa59c4915 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,22 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_get_ntrips - function to export number of available trip
- *			   points.
- * @tz: pointer to a thermal zone
- *
- * This function is a globally visible wrapper to get number of trip points
- * stored in the local struct __thermal_zone
- *
- * Return: number of available trip points, -ENODEV when data not available
- */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
-
 /**
  * of_thermal_is_trip_valid - function to check if trip point is valid
  *
-- 
2.34.1

