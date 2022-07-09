Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6E56CBB5
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGIWcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Jul 2022 18:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGIWcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jul 2022 18:32:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48850167C2
        for <linux-pm@vger.kernel.org>; Sat,  9 Jul 2022 15:32:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so2655994wrx.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Jul 2022 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=PY6cEgCpTPJZ0uoYtaE4XuqUYyoqmbizJ9qK2c3wkpZIvRg6A9mpUSauT/LRjdMNm5
         qQQI4nbw9kSoFzNS/URVomAffyQMaYa+bV31B15Z0qTbZgVtv5/wUMrw2dC4RzaOeKrM
         ow1oXAdCoEdsEs8TDfLoJJTloyquuUZh5KJuy+Jbu3G+VAeRqn5caKBr3Wt+sXP4i4Xc
         YH4OLWkR4Yo+p0DNPpYmqIf4Sip1DE6r1aWCCTIivcFTMu4Yrl0q3vQw7zx1ODE/q0Pa
         qMBLqQLTZEn7CG1UXVzr2O2ROvgLecBBsfynFS5piw82i5b/9eFiVtXhGl4yuUfCfMPM
         WDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKRi+GmwXFnPZbvdKLtGDHFP5gB36/7lKJQI47b4ftU=;
        b=ST4sBXntCgQcQZXmNWQCr9aVadKGdQ2I0VRw5gGtCxStW/FRmyl06xoLGy6QAS5vLr
         FeuQ2wJ1cDN4zP+JBfEUm14JLM2O2mh+xWMNOPpw+p9I65sAEHC6XvE3CRONDMcOXaZB
         QNZIX9X0gCXK3KUI5mKZR5prx1TLJodnnvMnEhFvpNO0ZfbnZANNF6nycoCQ3l2rC1Rm
         1XZe+9RSJ9W2DLGzGQRvW7Rb7uWdGa6tf6mZ33c3csWpv1EaMqHNXonNdI3MRMUYTojT
         FlyluWbCrztmiymtvoNaWSKi8DHHe4gq0FMFyrlNZuVHxo1hrP54CTJ7c1OcdqiNV9wL
         mRQw==
X-Gm-Message-State: AJIora/uDhKw3gJO+hnhnAFel6xRRHkIKluT93pJgcuXmZi4TfaRCUEK
        m5JBIqVjRGFSTybn13ltuyVDFg==
X-Google-Smtp-Source: AGRyM1sksXji7tuh/qAHEJvOQnNH8qh+QiAdaTbHXlTREYckhqvSrcPz10/b/IcVKYUGqJNitknnQg==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr9646809wrg.163.1657405964871;
        Sat, 09 Jul 2022 15:32:44 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 03/12] thermal/of: Remove the device node pointer for thermal_trip
Date:   Sun, 10 Jul 2022 00:32:20 +0200
Message-Id: <20220709223229.1619339-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
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
index 7d96494ef94d..19243c57b3f4 100644
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
 
@@ -1001,8 +997,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(trips);
 	of_node_put(gchild);
@@ -1028,8 +1022,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

