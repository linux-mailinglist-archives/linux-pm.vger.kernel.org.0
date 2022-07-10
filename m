Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964856D165
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGJVYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGJVYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:24:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9E11141
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r14so4781760wrg.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xk6A/pNWCl/Nzs7Qg1vyN7A/ewbkmH3NrwD0SYWTSzQ=;
        b=bY0fExwP3MURnYRBx4omWr6dHDeloNf3GtuXmB5SJTGKaGli9DPxOPVtnSXfYy/IZj
         euH+0zIKdnC7syngU7AO3tFLPLy4YJ7YE3aSQJW879SKowor/hPmNwimCZyTBGh5Fokw
         pN9r62L2aLDdSE5mQlVIK31j3WZHW3y+JADNgy7szDmqsrXMtZDNu9XGKvArcYSW2SHK
         ZHv1RnXiGJEiqlVDqMmrkZgXzjw4/kKAAaHxZEN+0umle7/d+QLJLXzJVYqYnmYmZfa0
         KetYEco7njc8yITUk7gDVNEXgnqAMDxUMyamEjaaT7qUP84VbJM1RZM3jkM/Ssdx3lA0
         VlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk6A/pNWCl/Nzs7Qg1vyN7A/ewbkmH3NrwD0SYWTSzQ=;
        b=GvCDNYCjSV4Rs0TCNGyRADhrzkbr3ZFL2ywbTYB7Q8okQiNJS2kqOHvAC/31Ut9u67
         BlTGvsWCoWj4BHau+pHjkL+mSkrim5aJONqtyVg6pFoqIWqe9PKh9LCM4YQrROxWpCnR
         4YPB6RPQpsDkUhOw59NCppxNNL7o+nAbkHOrXLQwy/QUryyjzt7xlicmf7bvVfDV4OjH
         6XlZIVJOxERipodhyXWkuVG00IywjA7E3aZPQluRBwsHI1gsBxRULszaEgPhl0oFirZa
         Fy/hFEeyYHcMInqPA9sMax6woWbMT8pQOiQzODw1bo+0PSdNzTLlkUqp1S/7ZWeEk+KK
         Txqw==
X-Gm-Message-State: AJIora+ValI8JMrgMp06BlvCDnUrpydKRXaphcLkVeELNSw1F34pbOeX
        vbHsjc4Im0W2VLf872sAOoS9tvOkOLRihw==
X-Google-Smtp-Source: AGRyM1vKS9doHkKgEmjxJC9SU75lHuuqhQ6vkhBSE+BJuwsds520dkzYONMvXdKg3SpePQIjpLJppQ==
X-Received: by 2002:a05:6000:1446:b0:21d:27ea:5a01 with SMTP id v6-20020a056000144600b0021d27ea5a01mr13953400wrx.314.1657488282307;
        Sun, 10 Jul 2022 14:24:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Talel Shenhar <talel@amazon.com>
Subject: [PATCH v1 06/33] thermal/drivers/mmio: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:56 +0200
Message-Id: <20220710212423.681301-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..fecf537bb470 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -20,11 +20,10 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 	return readb(mmio_base);
 }
 
-static int thermal_mmio_get_temperature(void *private, int *temp)
+static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor =
-		(struct thermal_mmio *)private;
+	struct thermal_mmio *sensor = tz->devdata;
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
@@ -34,7 +33,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static struct thermal_zone_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
@@ -68,10 +67,10 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							    0,
-							    sensor,
-							    &thermal_mmio_ops);
+	thermal_zone = devm_thermal_of_zone_register(&pdev->dev,
+						     0,
+						     sensor,
+						     &thermal_mmio_ops);
 	if (IS_ERR(thermal_zone)) {
 		dev_err(&pdev->dev,
 			"failed to register sensor (%ld)\n",
@@ -79,7 +78,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal_zone);
 	}
 
-	thermal_mmio_get_temperature(sensor, &temperature);
+	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
 		 "thermal mmio sensor %s registered, current temperature: %d\n",
 		 pdev->name, temperature);
-- 
2.25.1

