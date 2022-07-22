Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE757E7C1
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jul 2022 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiGVUAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jul 2022 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiGVUAl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 16:00:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE730804AA
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h8so7883288wrw.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=J7W7ZXzjIzo1kHosDe6601n92X1SuBIOO/UYObdbTNuN420iB+j3mJMgJZ65Lv23Qe
         KNhzqeEkE50nBeagKstycoMWpYZmROTCZX1mGr3GdvRaCOfdTwQ8HBQcgkMttf7eiXtR
         duA6/1+ub1PXmywd3S/QFh/yJ+kF3Lre6RwKK4n/ujan2I2lm51NIuRLVt1EtXU5EEtQ
         4gAGKBIMtrRe5Fo18QWHoyzPuOjfgqfFVGa4JA1vpF6WXK52r+CicyS6ykErrcqzdLEg
         8mzdL9y/1z3mbY0gEl8voDQfaD9i1V6FlXVYGgjJ1xR5OhK4csGEDbhmB7mbu7CtGzG+
         eYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=fRJ3JU0kWJxRG/VsnZvJ0E2CSJGa6L4lov+YumCbaiwztjP4DLJDTPG607FLo941j7
         ulzwnPrq9sihDNWnqzpfrp9sUP+pfjjSu45ggd3OhN4NsN2tufG4hXaD/e5s9sOf1eBx
         mlsWN3lI0sxTFeiJup+VtIBB/pktvk9M4b2pakCepme5nhZo8fv1/uoQVxrZb90SBWQX
         a8I5QC1TXrPh9xpxiTujRpYUGW32aKHftGGCSbsYoc4sdUFmFdJdVAu4JH3tc9Ip7A/c
         7znw1k+lLUMiAsp+4TENdIgZrHQmmFyPo2R0O0NWLc/uS6Lrd2nxHH5KNOqF8/FQTIqp
         LuUw==
X-Gm-Message-State: AJIora+id/+NqhqfapomM3yT4b1Vr9W1KmDa7eXCBG7x7TEEyLu5F9Iz
        KKCSNLjejP1Lwr3Ap0LdZAdeXg==
X-Google-Smtp-Source: AGRyM1s6kW/hpfAkwjRp5ft8p82osh4eWrW6jMIuSS+hLl8imvl+00wy3V1y8Ixj70bko8B/IT0P8w==
X-Received: by 2002:a05:6000:100d:b0:21e:69b3:1901 with SMTP id a13-20020a056000100d00b0021e69b31901mr939964wrx.622.1658520036337;
        Fri, 22 Jul 2022 13:00:36 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 06/10] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Fri, 22 Jul 2022 22:00:03 +0200
Message-Id: <20220722200007.1839356-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
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

The function 'thermal_set_delay_jiffies' is only used in
thermal_core.c but it is defined and implemented in a separate
file. Move the function to thermal_core.c and make it static.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
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

