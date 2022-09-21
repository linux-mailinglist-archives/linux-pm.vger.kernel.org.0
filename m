Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B25BFB7A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIUJpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiIUJoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:44:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD293210
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:44:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so8891835wrx.8
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=v9HOYNemLB65v2s3X2Chh/1DsPPvYHZYg0+K/15aDgQ=;
        b=rHEU2V/5h7AUju8XBTiGugYh57qpJGzWG4/z/sjkKjsCe8H+5YNWYGeY0tjhKUXFIM
         d6VhnbR3sMKtq04xyakS6XUxNbS4hwVZ4ADa1Ro5qrEExkJ9CSaVmZaY2jkw+BiW9FtT
         HC3zcaLEeOhh25OY9xq66LqOLApy2085B+wjmlMD+WrZ+V5U1WcLeRz2YNrB2shhQRm3
         eTsvw1LLmkNR1jxdoQjKJawH4hjt0JUeUXXVeTV9dm2YE1hLVJtvWn39i38YjqI9wvto
         mRtq6M/HgvUngXsZHUiobXGbYwaTz8CFhpxOL34Mq1YT1QWLbG8I4v/JNh3zKAS88D2Z
         Uwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=v9HOYNemLB65v2s3X2Chh/1DsPPvYHZYg0+K/15aDgQ=;
        b=5s8OIeIBgVhhv2v6YEdw35sz4gS/bDfJPvyL82n/SlN7kyO8UfXNZJWfAcxKphkNKs
         j6olKMSO6GMQAivYmIi6GG+3wlc3W3lbHUhfmbJbgGnhheKfwEUnngF1eto7ZdO4jgDb
         r9JilmcYsHhN/iV4+J8uGN9iZdfbliMcfJVblj4/9a13KTBN7CSRrpMCjYVerLIKOI3J
         0uo9iWbWqb12dQkEJhFQytZjPKcaaK/0GFx0O6Rw2NCl/CicceVKvTSNBqUMY4QEWIYQ
         UPr64L2yRxBjZIQZOTzQOv8ndW7bI/2aTzJwtkZLr0QqLmbmr1GuYhvh6a2Cut6Iud0k
         oFig==
X-Gm-Message-State: ACrzQf1f3E2DPkM7xl6rl9Od/z4dNhnwEeZn+4OkXTmQiMHIF2h2upAD
        CzRc8sQ2J6uARk37Sex/GaBDlQ==
X-Google-Smtp-Source: AMsMyM4EbiNhabTwa86yTniIUhffp+MRd+tRP/UupO9SXRQXndeFlIhugsjyS8hcyVe7KKdCvNG/ZQ==
X-Received: by 2002:adf:ee89:0:b0:228:7bdf:47d with SMTP id b9-20020adfee89000000b002287bdf047dmr16160602wro.641.1663753439002;
        Wed, 21 Sep 2022 02:43:59 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v4 26/30] thermal/drivers/ti: Remove unused macros ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
Date:   Wed, 21 Sep 2022 11:42:39 +0200
Message-Id: <20220921094244.606948-27-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The macros:

ti_thermal_get_trip_value()
 ti_thermal_trip_is_valid()

are unused. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal.h b/drivers/thermal/ti-soc-thermal/ti-thermal.h
index c388ecf31834..4fd2c20182d7 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal.h
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal.h
@@ -38,21 +38,6 @@
 /* Update rates */
 #define FAST_TEMP_MONITORING_RATE				250
 
-/* helper macros */
-/**
- * ti_thermal_get_trip_value - returns trip temperature based on index
- * @i:	trip index
- */
-#define ti_thermal_get_trip_value(i)					\
-	(OMAP_TRIP_HOT + ((i) * OMAP_TRIP_STEP))
-
-/**
- * ti_thermal_is_valid_trip - check for trip index
- * @i:	trip index
- */
-#define ti_thermal_is_valid_trip(trip)				\
-	((trip) >= 0 && (trip) < OMAP_TRIP_NUMBER)
-
 #ifdef CONFIG_TI_THERMAL
 int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id, char *domain);
 int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id);
-- 
2.34.1

