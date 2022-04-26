Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9C510BC8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiDZWTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355703AbiDZWSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B774348D
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e24so7458348wrc.9
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9QTsSn8BJcd3SpcSpuaKT3v/a6Dir+cAw5shol2H5E=;
        b=pLtct9jejMJ/CC8VMI9sj/WQSS3RbAMis0JBNJL94r6objqP5i79eipaFxjstPOX3P
         m7/vEg9zExyAR+hnbCoh6hAG3dmgCx3gNQGK625nRs9lYtH2qUqeu4/XNGaK5d+5MQt5
         1pOn7sncDFA0K4mVh7LyRxjYmvnfTBbrlAq/7U/2zelkEH7p3daHvxMjZPa5dkayG0Ml
         /Vtd0nTvDXlZlBm+nQOqkmgK5Xa1z/VKLvlJa/wUwXX3jLMrRyf4y0S+jkG7QRlbU3Th
         quihzZklWtIONMrpUKXUZcCEVp0sierdB6PhvkjUlyROr+A3CYpW8n/mtUS5RAofykW8
         3Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9QTsSn8BJcd3SpcSpuaKT3v/a6Dir+cAw5shol2H5E=;
        b=RKtWIFduGyyq8QLzs7WM2veQtasRiOoSElu0E+re5hBNOgWtY8FZAHCr9cMAAeJdbg
         Q0ja9WMZQZiWq5veonqjXduwPpKRr9XX0YykWaRjne9gP36DVeD47bRBwpumaZ0JwI9N
         diK6laMIlF3NY1g/Xncx5teue5SNKDApZpyjJsun8f265tng294VP05OTFv4h4FIKPzy
         f61iVHeeYPNVSK3Xx3MYGa39sdeTT/ngmCOQq6kTltHN44/XT2eOeIk9yp69zfjGkJIZ
         7l3kxDI/RjrynrXrF9av42HoBezC4IQ0MCji340/VGdEtwuAz7qmDaAJb3g1Qxgli2Vi
         Vi4A==
X-Gm-Message-State: AOAM533JMv9FuWRFiPnBRwDKZYJLNyq5ejlA8V6hAh2IWRN355WTXt8i
        lwuijexVOR+jeU8Bb01Uv9cuMw==
X-Google-Smtp-Source: ABdhPJwIE3R5YdLu6zJsytdCwDdPBc119MAN3BCUzFC2VJ+68+d+4K3KERd1QZ2D7sC2TtOnpAo1eg==
X-Received: by 2002:a05:6000:18a1:b0:20a:dea1:2bf7 with SMTP id b1-20020a05600018a100b0020adea12bf7mr8126939wri.90.1651011340507;
        Tue, 26 Apr 2022 15:15:40 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] thermal/of: Move thermal_trip structure to thermal.h
Date:   Wed, 27 Apr 2022 00:15:15 +0200
Message-Id: <20220426221523.3056696-8-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 12 ------------
 include/linux/thermal.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index aca491086561..9ecd12e8ef9b 100644
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
 int get_tz_trend(struct thermal_zone *tz, int trip);
 
 struct thermal_instance *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b3e8244af510..c3bd01ac4cb0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -80,6 +80,18 @@ struct thermal_sensor_ops {
 	void (*critical)(struct thermal_zone *);
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
 struct thermal_sensor {
 	struct thermal_sensor_ops *ops;
 	struct device *dev;
-- 
2.25.1

