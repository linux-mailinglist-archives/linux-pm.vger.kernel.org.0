Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43264510BC9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355731AbiDZWTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355695AbiDZWSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB872A71F
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso119512wml.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKFq37+jBQUG7PdwWKpR4OxPd8aMc8UBMumPMt9R4Pk=;
        b=L2LdCALCPibioN3tG8c+IZzrOHR9G6AphfS81JFXtvhiUGV2wu6STMvbWKcz8TRvwC
         RS6HiyNPs0xjneXwyVjxrAqJzNQ74xUpONnanQr4injGFw64JRZaxOpIro4/gd7bKkpG
         k2TMYNFN0y+h+DHIPVcO1CKq807r+LRWNQsjXTlIlDnYntCWt0vw9PYpxbvFoBO/EDc5
         g8B5ZN2v/neBEXChfNP0ZJTnvSG8NfRoJxN3JMV8GeTQwv2YoiRj9T8KAzc5EjlBW6HU
         OJTpDqxVcOctHcIWPGgUXWl85lSXxlv3R4ixDD21N/UiB9FaLqtjxETts+ZDVxuMekdK
         TkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKFq37+jBQUG7PdwWKpR4OxPd8aMc8UBMumPMt9R4Pk=;
        b=zl5VjBZpHSmWLyKfZa0rH/UuLe0C43knIcLUsvoBC4Tb+rAvEJdlcDUlsgA/nqVuEU
         XILXMkP0cepUy+pddDvhmPqIuZtyrACRtoKsEKH5xGnT/LDBIjeKaEPmJGT7NBt7Scxt
         jtxxEnN581RIiRfjnnmJRf0/t9XonFDCbjERgfQIW+eOTKuSv15lOMbYb5ajo1UvyRhq
         JSJQdQeA9fC/Wkt+H8DnfagOsu7TMrUSa0DyuXNORuBvG78ElL8JDhIAcEaoWAq+RIDw
         XifVTulPVObhHBxXa2IA2AFoh1AGvN9X1ISRBaR+8epBwukggTF1w3ZfQNQjXwB+Rszk
         59Bg==
X-Gm-Message-State: AOAM532dalNHzWMFqSp5TA3lvMzP5TEQu2JBy7BkMarEyHe2c9/sVqsY
        kfX3PeYxnwoKUScaKO9vHCrmmw==
X-Google-Smtp-Source: ABdhPJw4utDAbFShQjiI0UToflMA3TlA+dZvbWlListpLtD9mJ0uWVFSw0e1AYcn5IG7o45tCJxZhQ==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr23090492wme.94.1651011339865;
        Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] thermal/of: Remove the device node pointer for thermal_trip
Date:   Wed, 27 Apr 2022 00:15:14 +0200
Message-Id: <20220426221523.3056696-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index a1e4e000f461..aca491086561 100644
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
index 84c37493e27f..25ec70c8b7ed 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -855,10 +855,6 @@ static int thermal_of_populate_trip(struct device_node *np,
 		return ret;
 	}
 
-	/* Required for cooling map matching */
-	trip->np = np;
-	of_node_get(np);
-
 	return 0;
 }
 
@@ -988,8 +984,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	kfree(tz->tbps);
 free_trips:
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	of_node_put(gchild);
 free_tz:
@@ -1014,8 +1008,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	}
 
 	kfree(tz->tbps);
-	for (i = 0; i < tz->ntrips; i++)
-		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
 	kfree(tz);
 }
-- 
2.25.1

