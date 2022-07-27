Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F29583463
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiG0VD3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiG0VDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:03:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6756BA2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so105673wmj.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=4sLRSJ5YjVaF+p4XPUij0xfTtldIkLup8iWugu7Ph0U/Dd0PpdQR2TC3D2U7DFoCfa
         0fKkLsC99/N9MIdSyaO7M0aHwuBtUebBOQw63iVNR5p6szFmCw1gruArlRO7+JJVGg7j
         rH9F/aHJUfswzBDidRYJQBKkP7SLbaFKr4B5CcUV/bUNqQVoSUnOYFSW6r0zbMmh880R
         222/grZZnPNEHYz9bg55UrGffORniMp3cbYWR3yD7dvZbZqPMAJ0tQZ890VsGoDDUbN5
         qSB7xmKlyQGkvD+J4mInC/yir5bX1b/UCYFVFdxq4EDTHAcG156hZOZAt7szPEcJSTTs
         sNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=hwu8hJMjRuI4i/UvGsc8qNlCzoXZfDreZBHUSlsUAcOaebnAvZBbP3LGQtD3aSBoGa
         w5VONr+8lNS66ZkcxGAMTakxRu6kPFGtntbbwSioZLjo+BbQqXoELhK75i8Pr7Nfc78o
         capAFugiu9rfO0VO27T744Q9+pfaUUqG09pDnQXal3VSxgp2naF/Ysyc0K84KJCNI2IF
         TVY3kz0E4g7uLVRUXIpVgVzwpznadIAPOb04zLVxFL2tzHmzlcDWh+K5E1nYJQHydc3x
         +qCcMFbRyPkDeDvneSNJIn+NOVrgY0mDVppo1XKYfqbP4Vpt8KX/Y9+jJ5MmjgYUnAMj
         8kQA==
X-Gm-Message-State: AJIora+68Cw9rVUgJTfzBy0U2NsXgB4ay5TS95n2wIQkycjdRS8sr3gc
        9E57O1yLHWpgjrNqXgIsVs28zA==
X-Google-Smtp-Source: AGRyM1sh1ZOKZO50YbiUrVmFjjiUAbjLQVMBZWzF/xSArhlUB1f8hV5eXqPmhuN1SjcC/PCs/d7MEQ==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr4240318wms.137.1658955794901;
        Wed, 27 Jul 2022 14:03:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:14 -0700 (PDT)
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
Subject: [PATCH v3 05/32] thermal/drivers/generic-adc: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:26 +0200
Message-Id: <20220727210253.3794069-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal-generic-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..323e273e3298 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -52,9 +52,9 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(void *data, int *temp)
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct gadc_thermal_info *gti = data;
+	struct gadc_thermal_info *gti = tz->devdata;
 	int val;
 	int ret;
 
@@ -68,7 +68,7 @@ static int gadc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops gadc_thermal_ops = {
+static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
@@ -143,8 +143,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gti);
 
-	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
-							   &gadc_thermal_ops);
+	gti->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0, gti,
+						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
 		if (ret != -EPROBE_DEFER)
-- 
2.25.1

