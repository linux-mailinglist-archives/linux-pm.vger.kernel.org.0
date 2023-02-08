Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DD68F7C3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjBHTEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBHTEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 14:04:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F46564B2
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 11:03:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk16so17784029wrb.11
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN3EiqJyvn4WjrvJBWvfv/N7NKVUHz807+CSDIxAiKk=;
        b=f2O7JSZ2YSDWC9F1IS7+KoE4SVzMqYi6vsR/Cnyuuw4I5w5fPw3ui2xKaNFJ0Tl6bR
         80+ohGjc4x5jE2Dq22obS8UXraZ1enZuerkdCkCmNJjLZm97I4gYkqKYjv9q5mGtOfRP
         WDhMLUIxxQXGw0JdEECT9hN2Z28RPGkfZcTGuE3cvjK44DuBHaInuWMTdOpkGlBoo54D
         3Y+hZmHi+oDrI2Uw54IfOQGLO/e11WbSwFgaNVrSYG01n3rju5dAEpB0/XorhCpu+Ed7
         IE0FQaQ/2/CiWBOkhTvetPP9MQAxVQSnogQqv3kj6TT1xjIfyCt0lcp+fZS7uDwEDTrZ
         n8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN3EiqJyvn4WjrvJBWvfv/N7NKVUHz807+CSDIxAiKk=;
        b=PSvV4suMs6E78eGDJAzVU6J3iQ4bHG7IeKhjMHncc3zggd6eaCYdkDb7yHhtdfSYzD
         PZMKhKr81sfE594qzJ6egUx4FptrafmYzb+afhz6GtNXqZ1Fy6/Bo0OfFTDfB+AtAR2V
         aUhGbP9ygZFuG9sdpWWj79ZQefpvHuBc0z68qhvKSPZg3CrGhKCiUCQZKiVGvicg0HNJ
         BvAUxgPS3ik471wg2SE8t2m4gihnvAHOqSxngBhwZ73qHH0e6PpgDdW1fwMxMJ8iqcGA
         uaIjuhggDs+R1zXhXxqERYWIK6YFziAjI06mWOBBhiVjqPgoHYS6TQjERd9FjugmJmwZ
         uKVA==
X-Gm-Message-State: AO0yUKVg6IaPnnvnW3BBCbj+xuDEUgxg5I5bSGJiGrABE32tmGKDg7KY
        75iP+C3BI9JeIa/eyTbUGHcOYg==
X-Google-Smtp-Source: AK7set/IdpWkLrIuf+jbWO1nK4GHLhkWBnm/ElDGKSGklL4AHetwl1nQ9JFsRsUJoyWRADPXwMeGCA==
X-Received: by 2002:adf:fac9:0:b0:2c4:645:da3f with SMTP id a9-20020adffac9000000b002c40645da3fmr1796644wrs.48.1675883026423;
        Wed, 08 Feb 2023 11:03:46 -0800 (PST)
Received: from sleipner.berto.se (p4fca2792.dip0.t-ipconnect.de. [79.202.39.146])
        by smtp.googlemail.com with ESMTPSA id c12-20020adffb4c000000b002b6bcc0b64dsm14201382wrs.4.2023.02.08.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:03:46 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/3] drivers/thermal/rcar_gen3_thermal: Create device local ops struct
Date:   Wed,  8 Feb 2023 20:03:32 +0100
Message-Id: <20230208190333.3159879-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208190333.3159879-1-niklas.soderlund+renesas@ragnatech.se>
References: <20230208190333.3159879-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The callback operations are modified on a driver global level. If one
device tree description do not define interrupts, the set_trips()
operation was disabled globally for all users of the driver.

Fix this by creating a device local copy of the operations structure and
modify the copy depending on what the device can do.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 5a715a58f18b..2dfce4f09631 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -87,6 +87,7 @@ struct rcar_gen3_thermal_tsc {
 
 struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
+	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
 	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
 	int ptat[3];
@@ -225,7 +226,7 @@ static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return 0;
 }
 
-static struct thermal_zone_device_ops rcar_gen3_tz_of_ops = {
+static const struct thermal_zone_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
 	.set_trips	= rcar_gen3_thermal_set_trips,
 };
@@ -466,6 +467,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->ops = rcar_gen3_tz_of_ops;
 	priv->thermal_init = rcar_gen3_thermal_init;
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
@@ -473,7 +475,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
-		rcar_gen3_tz_of_ops.set_trips = NULL;
+		priv->ops.set_trips = NULL;
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -508,8 +510,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		zone = devm_thermal_of_zone_register(dev, i, tsc,
-						     &rcar_gen3_tz_of_ops);
+		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret = PTR_ERR(zone);
-- 
2.39.1

