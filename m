Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FA564924
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiGCSbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiGCSbb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F83893
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso4436285wmq.4
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMdWj+8IX41ropCzCvRKN6v1pic3BDCL4i5ocfz1lDQ=;
        b=auMA2wBPakeBvAHe93TzS3VT6myP+ZZKn8tvCarChohy1lKOzaNh+dFaw9G9VOLluf
         Y/Q1UI8ooK8fWfkdC5D+jvMxmI1xcDYv24xQ4oiLRwXYnmJFpDXWvN/3ftfLagm5lhJV
         1rfTNuNZNmNE9se7QFr/ivrwEz9+XrVRPDmrhfD7WSlU+oXM3JnA03MrNK9mbQqfStDT
         AtXAwh7BgXK2ypeWTSNp7KEBZV8DUlT1o8jtqbvplA7Wt8hk12P1AoYtza68hvcLWJ2j
         vB7DqGnAr2IaDfygH1QZw3SUV9UQ/HBvjFUtE4fiiPhi3tyvoXykYeBAffgSmqQjpWXY
         YxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMdWj+8IX41ropCzCvRKN6v1pic3BDCL4i5ocfz1lDQ=;
        b=Xya7BBV1PzsZqi6wASzZ1CyuJJam6juPP/NkNJ7v4OIDQT+l8gQwGbeW1HRtCDlZhz
         QOKuZEGLv2kC5MfzodUYGOS2rt/8/p//QKI+YA43cFx7fhIJwIfFNUEzHNA/uI904nTY
         M/4B9zcV7QTeZ4W45IdukDABs9NZFuCUmAi+n9DecvBkniXAW3RvktnK7jGyIGp6OANe
         GAOE1u5gr/39Oft1pZis1ua7IptuzMuTIuH4SAGsF3sNWaY6mMWoO/nI4rhW2hsFwT43
         Zaj0WtdURGx8m9/buGw6mgQdpwvxhY/ImiGObG0uU7TXjC85seSbgpmDWuxj7shvJKYT
         VgHQ==
X-Gm-Message-State: AJIora9asWiR8ikdkdzUlHxMU9hMH3Vh1uNMkTb+KmFc4zf+fRUv7d+1
        vDcaoxFGq2Uhq/IsSjJPIDVOuQ==
X-Google-Smtp-Source: AGRyM1sTfvIvVlyecJ5qq2G1Twupk2XWDNGZjmSewsOGJOQCu6HcnIbiWfakmM/a3FkCZpwj+pKAbA==
X-Received: by 2002:a05:600c:1c0d:b0:3a0:503a:9c9c with SMTP id j13-20020a05600c1c0d00b003a0503a9c9cmr27120260wms.2.1656873089358;
        Sun, 03 Jul 2022 11:31:29 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 03/12] thermal/of: Remove the device node pointer for thermal_trip
Date:   Sun,  3 Jul 2022 20:30:50 +0200
Message-Id: <20220703183059.4133659-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The device node pointer is no longer needed in the thermal trip
structure, remove it.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 2 --
 drivers/thermal/thermal_of.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..ff10cdda056c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -70,13 +70,11 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /**
  * struct thermal_trip - representation of a point in temperature domain
- * @np: pointer to struct device_node that this trip point was created from
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
  */
 struct thermal_trip {
-	struct device_node *np;
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 04c910ca8623..16eb18c24430 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -867,10 +867,6 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
-	/* Required for cooling map matching */
-	trip->np = np;
-	of_node_get(np);
-
 	return 0;
 }
 
@@ -1000,8 +996,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(gchild);
 free_tz:
@@ -1026,8 +1020,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

