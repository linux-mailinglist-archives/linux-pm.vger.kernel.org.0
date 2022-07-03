Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8F564927
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiGCSbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiGCSbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E322C38BE
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so4456375wml.2
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raVjxKqEErh+B2L67+xqA5bMSQyms2haK6UW0czdPBo=;
        b=x3xuFSbyzWpkII3FF3+X2kRzXrRCTeSq/nism1nI8JQx0uo+wtA3nTCC91UoBd33Cz
         oESvVBEalCTWXvJsvUsy8YIcNeO8V2QRoqHwN058K5JIfNRH8Ozk5+iXqDVb93KRcdB5
         ONmG/PNKOTOwuolb6R1CDOy5A2f1jSXGWMdI2w+UmZGA6fl0BOaIHiDGkyxzWIZmWc5r
         a9m/nPJfRphMYoQNn/Olo8Agt0KsNpHux/PtiBNV1EC+BC7Qv0LCavgELgZhnf3ZRQyQ
         UY9v4vns82XB/SIizXJ4NJIB9KBv3E5yIgU3vCGAejprMKThk1aeQL+/qQlCzPH9FhpA
         ozWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raVjxKqEErh+B2L67+xqA5bMSQyms2haK6UW0czdPBo=;
        b=4mkAFvtwbeLjrtS7RXp8ChQK43NqW4I2U0eggM+3KW4qN7qwM/Q7B3i+CmNSZ7rDXN
         rbl66WrbEoqyrzsdRBDM0n/98cS3hCiXI4NAhbl7hRj5dYFJDJ2ErvERs68hK4ThwvmS
         Amp6iJkMyNonPcFuf9JnIlIXV3I8hdWHyLb60/t6QQ1isObEe+TBOWnVvHLeJjtGlAH+
         evQD5WmHhVc0eL7Ysfi9/86rwrrNjL41qO7k563TZt5HMUeiTbUgu+jCNRwXufRd70nz
         zmgjMLRqnNjia6NWRMIsW+fGcK4Bv9Yh87zcu6JpQCCotLLpYLcW3tuWbdrpQdozYGtR
         cp2w==
X-Gm-Message-State: AJIora/FO50y9iTTknIF+BvqSXpdcr6bHEo4ysr1HiIVgDGqcGplUwJE
        +mN3S9cyeIfi3aWi+fMYyX1jhQ==
X-Google-Smtp-Source: AGRyM1tUz5gLMmIs7wbe3dm4z8qkP4CmQflxr31boSetvZ6qf5tAb2zcGYWDFJ2Gd1PNCfkyjdJItA==
X-Received: by 2002:a05:600c:3847:b0:3a1:db24:b7c9 with SMTP id s7-20020a05600c384700b003a1db24b7c9mr1786489wmr.24.1656873092493;
        Sun, 03 Jul 2022 11:31:32 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 06/12] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Sun,  3 Jul 2022 20:30:53 +0200
Message-Id: <20220703183059.4133659-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

The function 'thermal_set_delay_jiffies' is only used in
thermal_core.c but it is defined and implemented in a separate
file. Move the function to thermal_core.c and make it static.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c    | 7 +++++++
 drivers/thermal/thermal_core.h    | 1 -
 drivers/thermal/thermal_helpers.c | 7 -------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e22e7d939c54..a8b1628937c6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1159,6 +1159,13 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
+{
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 60844e2d59bb..c991bb290512 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index f4c1e87ef040..60bfda1a1db7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
-- 
2.25.1

