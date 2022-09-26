Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D219A5EAA5A
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiIZPVE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiIZPTV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0F639E
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so5018747wml.5
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=z5G8IkXBIKXhd7qT+UB7xxqOj6f3Eq8ax/RzqIl0XorZS+Xr/fqHotZJoYnnDaLgYx
         RU+AboprBDINIgSrCT17V2VQkFIcIl1hD9e+vSnbHnoV4QqqR++JiOL6d9NPipzK5/TI
         dX+38uP4uEZLIq+g1Xuomd5NqZ7tgSU8w0Lod1GFR/FbDnwRARfTg2BZ8DzmoiYLndqt
         SFrjMRemT9KbH8hl8wieeTrr/D1/TQ05iMXt9YvSIhkzgcIjA2wkzutajp8ld2X+E/Mu
         mLyMagte7bGjcjht40IFMoY9KDdNRe1SR2II8S3lY7R5RHdIWdU0MGNpEITtZTihHq8m
         ILMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=FWHWKRoRH9d5OC2gYL8V8IwuLvOgKVmYuUuXm1YZ0LAASMbG/SN7UtJgLc6uES8XZI
         e9uhhZw0AkBBTwkGyGJl8yi7dOFwimEjzxEQNd1dq4QftSgacz1OkupcmtekrO9LNBLv
         5DcNtHcfVe0bmNrF6qFa8su4QoioUoTU9Gxh5yjmAPui7COBtZl3wTcXaVRFcu91ZRk+
         uWktGtsYVTHiprhit8vKR84Df1zkgNoaY3Lck/88P1mZOmiGAm1m8zSQrtvWZZ1Sb4J7
         wuh6laz7dwAq0Pq3knRHSfZhbjt7RkxvnP2XNRF5uMOYB4r1vu0jz8OPqeOlShBd51RB
         bZQw==
X-Gm-Message-State: ACrzQf1a85Lx+6RuPQ1fFE2DXnaCA9E/Xaf4I/KBY7E6S/uYqrkJR1no
        XgG++5+4ctoPMSRuRKzHdj6//w==
X-Google-Smtp-Source: AMsMyM513Uavgx2NJuLiJ2uLHUthzvwVsVfjgpzOEqdTKG+7IuRHAT8POOi+Ek0OBjiSxJDR9lp2cg==
X-Received: by 2002:a05:600c:3b1f:b0:3b4:b1fc:4797 with SMTP id m31-20020a05600c3b1f00b003b4b1fc4797mr22404966wms.129.1664201202274;
        Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 18/30] thermal/of: Remove of_thermal_is_trip_valid()
Date:   Mon, 26 Sep 2022 16:05:52 +0200
Message-Id: <20220926140604.4173723-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no benefit with the of_thermal_is_trip_valid() function as it
does the check the thermal_zone_get_trip() is already doing for the
sake of getting the trip point.

As all the calls have been replaced by thermal_zone_get_trip(), there
is no more users of of_thermal_is_trip_valid().

Remove the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 10 ----------
 drivers/thermal/thermal_of.c   | 19 -------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index b00fc1913734..e9b3af6c2084 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -138,16 +138,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #endif /* CONFIG_THERMAL_STATISTICS */
 
 /* device tree support */
-#ifdef CONFIG_THERMAL_OF
-bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-#else
-static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
-					    int trip)
-{
-	return false;
-}
-#endif
-
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
 
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 89afa59c4915..4e54d62720dc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,25 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_is_trip_valid - function to check if trip point is valid
- *
- * @tz:	pointer to a thermal zone
- * @trip:	trip point to evaluate
- *
- * This function is responsible for checking if passed trip point is valid
- *
- * Return: true if trip point is valid, false otherwise
- */
-bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

