Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699EB58732C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiHAVY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiHAVYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:24:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FD7459AD
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so14695353wrp.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=HE+3D6eB0kA7iBiBB9cguaAKKJWbt/NzklKHWudRWhfOPsqohlCNtUuHsNshZDp8EH
         41VdSkdsx9jpZdLgu40UpBUSexTuOXoWpcvg5cCW5ern8338U8cjfs6+UnJXSgF8+aJl
         rWBSI0O/tw95ykdXDeo9PO6bf87mdFCTGZ+Iz5ey5iHLyrZCKnx+NPChntEGBUWW5TG9
         KkHvpCihYs9rNK6P0BnwSlsYLbTrpYI9KWSIykh9y9CoejhpXyBlPOWK5oVxr8JEs7K7
         VkbpLYPzHhf5y/WHoWHp1NOgqk1rLRKXW77g1CsXcATMsE6uNjdn+iUWf43AlRKPnhqR
         cBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=oGJY7d+8zIMgMnFxzrs6J2btlSslOLztHuR9NMcUAM6FvKtOAW+koKEGBtITPXTKFf
         K+LajRGEsAtToY8Dc9g+soR1+Os1GXjBqj/hTEcMusloTd2g0Xzt+Br9Tdp8a6v7MLD0
         zSc+FfZlBRbNNb4lXTkO3xcFqIr6IrgwSegHG5j5H4T8ipLDUB6iWWFm9lAJibhRZFxM
         KXiebh9eGS5II8pla7CEvg7Ttx4FGqaWJ4RL1Z/BX62ofI01zGmbJIw2fL+hg9igGsCc
         lZWIjP2uEdMugqg014QQ2gkDiSlz+1qoUASEYtYXRRKnQLBAHLp7YjvwVHP/j1BG0Dpl
         nu0A==
X-Gm-Message-State: ACgBeo0FLFRgUD8H6Kv76Wo0wwLuQZn2sSHyI7ALeifxNaTA1qAYGszd
        Ky2OjkarwHleg20SjgC5bXUehHLXQ5x+vQ==
X-Google-Smtp-Source: AA6agR79HxSlxaXSf8RRLc2HeSzgheN/sgjST2VdKmNJWx3Y3hW7ebsqziyCqVmc/75Crr1eTqAMww==
X-Received: by 2002:a05:6000:12cd:b0:21e:c4e1:6e27 with SMTP id l13-20020a05600012cd00b0021ec4e16e27mr10854343wrx.366.1659389030844;
        Mon, 01 Aug 2022 14:23:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:50 -0700 (PDT)
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
Subject: [PATCH v4 19/32] thermal/drivers/qoriq: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:31 +0200
Message-Id: <20220801212244.1124867-20-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/qoriq_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..d111e218f362 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,9 +82,9 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qoriq_sensor *qsensor = p;
+	struct qoriq_sensor *qsensor = tz->devdata;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 	/*
@@ -122,7 +122,7 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -146,9 +146,9 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(dev, id,
-							   sensor,
-							   &tmu_tz_ops);
+		tzd = devm_thermal_of_zone_register(dev, id,
+						    sensor,
+						    &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
 		if (ret) {
 			if (ret == -ENODEV)
-- 
2.25.1

