Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13458069C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiGYV23 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiGYV2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 17:28:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DCB24F22
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v13so9937770wru.12
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLbrdXUnmrQegHQ4ArILFVac507m4xUt/E4MiWL2p00=;
        b=5obZF+IG/xdPPKwvOIBUwn2Hf6xxT1MDTwIAwW4oZQErkW4sorJfIuG5NMjy/WfJe2
         8ysob65cSqtWIe+CFNTlIrL7qJPGGVYorc1O3o5eg5pIA2OiZOP/hSyf/uQ10QVWsbSM
         /xd3zRQ5+d1hMbKpKVfKLTkbiU5olsoFIJBPV4FSsxX+Ov9xLAmbgQ+8vQBhk/ERbIAE
         qxnDSZZ+kpTZ7lDd+g/BlAyYHMT6PWdU1n7kjvqD/TCoHhfqrzv5xBI51YoVem3W9ofI
         2cgL+YZVeGlk3Ra5VOtXvL4pGJFVDZjAIl16xBwN9vnJRNx4ojtv+4YRC5ZOMhDyDsTd
         PivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLbrdXUnmrQegHQ4ArILFVac507m4xUt/E4MiWL2p00=;
        b=yvqf65AaQWAMr39dgAu/+IiFf0ePmT7C8kcF3IxCjdvjrdE4augwDmWtJuomqA+6sR
         89mo0+o0fJUUbWRg8vWjMMHu8IjBc0le2+K+YPSW0BooJxKwAxhPu3hHs+LnUavgjeXN
         /0bQiNfIB87GOPAnhCmXDkrWOdHungk2qRKL63pjuLkFkcuOyCIEtRBXenWOs6V/qwnl
         jlzWxguzBZ20fle6/l6l1/EUDFv0spb8hxnwg8zz0E8hlVdwVjQ5l900+hKg1l0VFYjF
         OhU+CjSXZayk4ALjs5vfx6F2kamVKncZzzEvrvJoX3PwWHWZ/rvztOTjNZKXOk5irOqj
         6ZLw==
X-Gm-Message-State: AJIora9PUMzYo2PqZ7ZZru4n+pmVsGL5w0OTM0jhH2Lhbqynf8iHVKgl
        DypL8YT2q/LQn534WC+OsAUP0w==
X-Google-Smtp-Source: AGRyM1uqbR2UqwczcVNLDMmivmK8GC2b7p7ZjfknP1S0kTyDeKlT36aRIN75zYUuHNl1fngQZvICTw==
X-Received: by 2002:adf:979b:0:b0:21d:868a:7f2f with SMTP id s27-20020adf979b000000b0021d868a7f2fmr8703664wrb.409.1658784449396;
        Mon, 25 Jul 2022 14:27:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:29 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>,
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS)
Subject: [PATCH v2 13/32] thermal/drivers/amlogic: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:18 +0200
Message-Id: <20220725212637.2818207-14-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/amlogic_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index e61b91d14ad1..d30cb791e63c 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -179,12 +179,12 @@ static int amlogic_thermal_disable(struct amlogic_thermal *data)
 	return 0;
 }
 
-static int amlogic_thermal_get_temp(void *data, int *temp)
+static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	unsigned int tval;
-	struct amlogic_thermal *pdata = data;
+	struct amlogic_thermal *pdata = tz->devdata;
 
-	if (!data)
+	if (!pdata)
 		return -EINVAL;
 
 	regmap_read(pdata->regmap, TSENSOR_STAT0, &tval);
@@ -195,7 +195,7 @@ static int amlogic_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops amlogic_thermal_ops = {
+static const struct thermal_zone_device_ops amlogic_thermal_ops = {
 	.get_temp	= amlogic_thermal_get_temp,
 };
 
@@ -276,10 +276,10 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->sec_ao_map);
 	}
 
-	pdata->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  0,
-							  pdata,
-							  &amlogic_thermal_ops);
+	pdata->tzd = devm_thermal_of_zone_register(&pdev->dev,
+						   0,
+						   pdata,
+						   &amlogic_thermal_ops);
 	if (IS_ERR(pdata->tzd)) {
 		ret = PTR_ERR(pdata->tzd);
 		dev_err(dev, "Failed to register tsensor: %d\n", ret);
-- 
2.25.1

