Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40458A388
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiHDWxy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiHDWxI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:53:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3327391F
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b6so595792wmq.5
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=OCD0y3QgfAQloSgUF+zgv7CA7DEWyXGFNLika9s+rO/f5K5SEp2+xcNUfT+hikmJ0L
         7B4oEOoZe5kERppsB3aHyT2fi0ZQ9sCR9V2CgML5jAGXOhkTQeJxT3g8NuKtAGrxbuRo
         wNHiGGyEimXMiDuCs/IRSFxwqtFD6GoF1CF0J5zpGwwJxoiihbeJKN18owk4DXpb3tDO
         wcHgOat2GagF0ZezvxMGV4gHfMr9y9NBDi/fKjRUN/NzwEJZcG1TSPzEE7TyQ899tD5/
         UgmVYOftMlK8jKb7rs5/LDpsvLUv21bl/75BuDlDuEvuRSSXcyGWNJHbXNfEcyZvKo2J
         0scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BqOsgjVEw9Tt6uQERI+yLCfRaS3oyJEXM6rueaWDbTA=;
        b=QT2InbnXnCKu17Y8Z8Ymfb5k+UOTBElaV5PNAVVdXfpsZgmI0rWzweE0aukAq9ev+4
         wB3iX6ETEjimw8Eyh8SdxV6Z6kRVdrBUsFvOT02rD9vIPqooJUIAdNo+Q8RSsa9ZIxeg
         HBjVTWgE3azKi6akCAlZ5n6EzZjlWh7KuKnlNo6rOUjuGrH6O2jo6VnMmEe5dOjjnqA3
         5KkFXvbmvIe2PbDBMGcSkYnX7VDYFhneuPRfbXeuiPXRCsWf549zKTAr1bNqBnDY+A51
         HspQD4BeNs/J3qJFdQlwKJoRbb6rBwPjCK6QlTziFpKT+B6rt+A+B+QzlCG8AEL++Vpr
         G+eQ==
X-Gm-Message-State: ACgBeo3p96xmCOCrWDcD+fA3GYPbYcfqXcVMSdDE43nk/RzF9WcBV6W8
        hx59X8w7LJe88NjHecMLIFDgyQ==
X-Google-Smtp-Source: AA6agR4Q/pp5eAxAatZvxQ81jOJXnhc9G7oQn37iUavXl9RM8lOiCKFSkD0sbxFc0a8hBci25BgozA==
X-Received: by 2002:a05:600c:3b15:b0:3a5:49e:81a6 with SMTP id m21-20020a05600c3b1500b003a5049e81a6mr4331582wms.49.1659653553087;
        Thu, 04 Aug 2022 15:52:33 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 15/33] thermal/drivers/db8500: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:31 +0200
Message-Id: <20220804224349.1926752-16-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/db8500_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 121cf853e545..cb10e280681f 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -58,9 +58,9 @@ struct db8500_thermal_zone {
 };
 
 /* Callback to get current temperature */
-static int db8500_thermal_get_temp(void *data, int *temp)
+static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = data;
+	struct db8500_thermal_zone *th = tz->devdata;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
@@ -72,7 +72,7 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thdev_ops = {
+static const struct thermal_zone_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
 };
 
@@ -182,7 +182,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* register of thermal sensor and get info from DT */
-	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
 	if (IS_ERR(th->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(th->tz);
-- 
2.25.1

