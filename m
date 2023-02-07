Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766FF68DE88
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBGRLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBGRLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 12:11:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42C3BDB8
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 09:11:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id c13so2595056ejz.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7RVUm6qi5zdXXG0mz0c47Sldb1nd0ZjmrRR9n+6EfE=;
        b=SH1EHUvb9iAWRzUXcGYHoM8W6Cve5L5GbWsqPh2vaSQcUWUzu2plrTM+/km77VaTqN
         Leg42vbuwaMHZF/Lha4jzV9HcNGsF4lG1col56YhU7JPEOerERbIL2dCZzgVKhuFZNn4
         /C/EZVghVpD4CHmMsezl5wZ/se3n26vOC/BcU5f8B4nCOJfaQorNjdWacZQG7NVyFghe
         UyZdRPbSSCZfRX1iwSZ6mIgTA/UUPnbdo+jnvV+zLx5Nc8Y5uoU7ZsQnI3WMq3L6+o/p
         TILazUBi5Q3V4+3pkTpPbfCeguGXCklKLGPiOWgp6G5u1GkIyFg/gmncpgDOy5BMfuFK
         cAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7RVUm6qi5zdXXG0mz0c47Sldb1nd0ZjmrRR9n+6EfE=;
        b=utJw6AFihKN8tVOsqa/Z6ako9jm+M06XKALbbjauvrBlalZHNeasckG6AZ7OrKlGuU
         bR3lEca1pKiQqjdxngmjSRnoI4yZ7zY9siX77AZKYztmgh47vtAM2FoETczwkvT8zDVx
         l6naRE0iN2tghIwMpza+yJAhQ9ZcoxYZjqRFWEyUWfQ2aNW3J0Pwg5BIPJIoXLyFl/9v
         YB5HoGW8xC1Kv12BBj0c9STx6zRmaW+cY3D/fYxiLwRLaeWAXB4mWB2SiQMKiPV2cMVL
         5H4Bz7Aj9xUbSkzgQGzrXpLQRBr9ufudsUTeSbkb2HjcobA1ljLZJhgTzF8e/kwJrJGL
         kroQ==
X-Gm-Message-State: AO0yUKUWxptdZfnrT7LevhBDIC6eeEuCnoxc48l5NcttM43WeacSmEp+
        7lyXO2OQDNM8x7oVpYfIJSS7Jw==
X-Google-Smtp-Source: AK7set81S60Kv9YD5SU6s9hgHDhA/kYDvmraf6qlT8K3h3Gf7QOSJOUWhyAGwAkLXUVl9aKBF6Dyxg==
X-Received: by 2002:a17:906:198f:b0:894:acbe:7a97 with SMTP id g15-20020a170906198f00b00894acbe7a97mr4183548ejd.13.1675789871524;
        Tue, 07 Feb 2023 09:11:11 -0800 (PST)
Received: from sleipner.berto.se (p4fca2792.dip0.t-ipconnect.de. [79.202.39.146])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1709062bd700b007a4e02e32ffsm7132298ejg.60.2023.02.07.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:11:11 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/2] drivers/thermal/rcar_gen3_thermal: Create device local ops struct
Date:   Tue,  7 Feb 2023 18:10:10 +0100
Message-Id: <20230207171011.1596127-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/thermal/rcar_gen3_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4c1c6f89aa2f..bfa2ff20b945 100644
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

