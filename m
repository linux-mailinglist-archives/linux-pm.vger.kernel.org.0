Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553795806AB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 23:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGYV3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiGYV23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 17:28:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7824975
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u5so17717366wrm.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=tjmiNYVqtsTChO02vhbkBNOAETx1giolsKbKa9UIaimnQiiS1T6pdHQp0b5G/IunYK
         xYlWtgk/sixvp/pvh3PSYS8QQDTV3rxGukQvo1qpLvjT6b/h2SXdvKOTlRIKn9RF/GQ8
         lIRDVIO5fM64Dlk9BI3eBeyCvtIE37+5ozjxGRB/54yGknNnvclr/jdlBVkugB2xfw5u
         qq0oRa2ucA2+e9wifU4KUR3apoWjg4BcuV/GF437Rs7imkr+Fhl69Sdx41NbAf3LdBlk
         bZkmCwyY3L5Tgay0v5/P0MB+3iyDYpx9SXhXIqD7xRpzWAm+tF9fEnMP9dtYGVNp0MC+
         iNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=XQuPzTccx+IBJQMUI38duLEE/XQpKdbwOOs4mdIhzVAeZtcIg2D9IAH1AQYn6YVg3n
         +GUjcvXz4JtFs8bylTlys4TV7+g5HnlEy/L3YjtQ2VdtJjQHgsSs/dGLR1E4q45rdgE6
         Q4lvf0n0YRJROvaPSCpeVyBFU2W5zgLhR9ma5e7qQ1ywsT7Fd0z2qXsXN2nVkn22ojdX
         9HvBCDvBPX+LPMJ7cLLFhgo+zaOS2D2weTVQvP8wBFnO9rOg6f0nTyW6GWP+cs4r7l/e
         0Jh3SOv4jsgOfuGVKBJtxP32bgd42dFDYLhFB/HiNy/isYoCo4p4xx6QEde0X1ybNabq
         Po8A==
X-Gm-Message-State: AJIora8T9G9NrxlDH6Jf/KJhLiJHA6p1029s0q4BkjDk5VgKqxp+BeN2
        Ys4slQODEg2UMzhrvIrUUMw3g7ymuCqMew==
X-Google-Smtp-Source: AGRyM1teSkYLdenuX2lRH71M/Hp1fJAVMWkEgZoTwY5yNri+eBJzdSNalR/lu2zwYWU5jGhKft4GGA==
X-Received: by 2002:adf:f747:0:b0:21e:8e2a:7cbc with SMTP id z7-20020adff747000000b0021e8e2a7cbcmr3190615wrp.342.1658784462157;
        Mon, 25 Jul 2022 14:27:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:41 -0700 (PDT)
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
Subject: [PATCH v2 19/32] thermal/drivers/qoriq: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:24 +0200
Message-Id: <20220725212637.2818207-20-daniel.lezcano@linexp.org>
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

