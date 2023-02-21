Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9D69E6FC
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 19:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjBUSIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjBUSIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 13:08:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBB303D8
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:07:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j3so1970808wms.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1kZW3/M8hlSrhTNIbSXakvC4ON0rMLSasQAq1vDfbY=;
        b=W14kchqFYP+9MoZWrMYBBI/Pe33uOzlP/bI03g4oRDwEHVp8pFHzsu3a9bpMgPrco5
         nCXO70dTQWToQGbR79D+X+4DK+0y97eBhpOHkUHR7J1gSlGc/AIoS/RXoqruZOuEXj81
         zOdZyXxnNKa4qyZLrCXFDJp8t8/8CY79/W6QPjeFhNXlXz+KfGAIyh2A7qiCvcB9p0Zz
         nJNs7l+h/L2BSGjRZYyNkZVgP3XwO3X3F2q/ocy7faJ72l2FBX2c9tWt7h5Tq/AxtgNd
         BQAJKHCI/kCeGzGXW6629DGui2oABbfDbvO36KHmvB1vtsEUHnpIIgdQpV82rNiglPW5
         1H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1kZW3/M8hlSrhTNIbSXakvC4ON0rMLSasQAq1vDfbY=;
        b=SnLGSyEygG8viH3HezpXUHOfW0c/TDbHkzFnrW95YmwxOaKAWzBi9vXbZxaqPxN7OG
         uzBBv9ZNyQMOeRQeXR2vrhil02/WHbEXscSzu+C/I3GFsp2wAMJrxvLaIzmkmjrwvkGU
         HqQjs6tUfW0j8uOiAz0sSo1KWHbnlID1wi6deyTI/KszSBxc3UWr1ATWLXoKD+8iHFwu
         kT8WRSdI7IuCXf8KmbmlUhs3Xgn2i8Qa+4HiJlETAvLH4VHjXqDaCREuYjXB/YqgiaDm
         BAMRBOIgqace82lX5cemk5Xp+NdLg/oyPWeixqO5x7Dw5y/xahTrdKb+9b3SQIfmW86n
         j5rA==
X-Gm-Message-State: AO0yUKWtPFTLZUVTQ9qUc3ZIzUrmHfXASWsvsBvScjWQIoLdnhw/PWqI
        DtcZuvipUSgetdmzwZJAjB5faA==
X-Google-Smtp-Source: AK7set9I7QAEBq3KVMS9IUSAWCfudZtuhtkP5HXBO7Fhk5i7l2n1Od8rPRrU3Yej5CI9SbV0Bs6DNQ==
X-Received: by 2002:a05:600c:2ed3:b0:3e2:1fa6:f418 with SMTP id q19-20020a05600c2ed300b003e21fa6f418mr3989284wmn.23.1677002864409;
        Tue, 21 Feb 2023 10:07:44 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:44 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v2 04/16] thermal/hwmon: Do not set no_hwmon before calling thermal_add_hwmon_sysfs()
Date:   Tue, 21 Feb 2023 19:06:58 +0100
Message-Id: <20230221180710.2781027-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal->tzp->no_hwmon parameter is only used when calling
thermal_zone_device_register().

Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
effect.

Remove the call and again prevent the drivers to access the thermal
internals.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 1 -
 drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
 drivers/thermal/rcar_gen3_thermal.c        | 1 -
 drivers/thermal/rcar_thermal.c             | 5 -----
 drivers/thermal/rockchip_thermal.c         | 1 -
 drivers/thermal/rzg2l_thermal.c            | 1 -
 6 files changed, 10 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index fcfcbbf044a4..c243a76a3471 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -98,7 +98,6 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 
 	priv->thermal = thermal;
 
-	thermal->tzp->no_hwmon = false;
 	return thermal_add_hwmon_sysfs(thermal);
 }
 
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 86aaf459de37..a217d832f24e 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -267,7 +267,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 * Thermal_zone doesn't enable hwmon as default,
 	 * enable it here
 	 */
-	tz->tzp->no_hwmon = false;
 	err = thermal_add_hwmon_sysfs(tz);
 	if (err)
 		goto err_tz;
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 2b7537ef141d..3df00c9d55ab 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -527,7 +527,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
 			goto error_unregister;
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e0440f63ae77..b8571f7090aa 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -509,11 +509,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		}
 
 		if (chip->use_of_thermal) {
-			/*
-			 * thermal_zone doesn't enable hwmon as default,
-			 * but, enable it here to keep compatible
-			 */
-			priv->zone->tzp->no_hwmon = false;
 			ret = thermal_add_hwmon_sysfs(priv->zone);
 			if (ret)
 				goto error_unregister;
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 71e533df563a..bb254bdff043 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1451,7 +1451,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
-		thermal->sensors[i].tzd->tzp->no_hwmon = false;
 		error = thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
 		if (error)
 			dev_warn(&pdev->dev,
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7631430ce8a9..b56981f85306 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -216,7 +216,6 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	}
 
 	priv->zone = zone;
-	priv->zone->tzp->no_hwmon = false;
 	ret = thermal_add_hwmon_sysfs(priv->zone);
 	if (ret)
 		goto err;
-- 
2.34.1

