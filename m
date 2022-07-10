Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACA56D189
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGJV0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGJV0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:26:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264DE15A23
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so4007813wme.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFnV1hN/hxenyqnLB9iV9vmpJBpk4CMcqpbDLISp6AM=;
        b=SIiSiKuj20N+LfM/LDx1cVFlKYuGU5icx9eU44sY1bXS5J7U2YYnMYGItGn92wSu8r
         KJUSUdzSldUu632V4skHYDOUKhsIBU3NL5+zmVZY5WTda0yfdYRGn3C7YhBK4Ag7Ej9D
         rbeUxPddsiLuGI7ZUNh3aToKUk9qEhTPM63n8VNenQyvsAT5fNx+zq2Vvb+yXDSrclz+
         QJPdzh8txzc3APbCs3RPBqCbWXdxUNz2bCbhnwou4PVXKJw86bPJVVNsldAA0CpP1Zh4
         6qb2A5NYoJ/IhyRA/MK1ZTeMmZg24XWJkG4RK1gHwpX2we0z8XwIERw3/QmLlRFSomJJ
         foQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFnV1hN/hxenyqnLB9iV9vmpJBpk4CMcqpbDLISp6AM=;
        b=zxXwK3xtTxHslsHaQTYjKVXVUgaVxtb+Lmtm571bjbmXQzapYdNZ+tCFP8wNIDH2nL
         5UDncDZRPKqClA5IDWXObgaZIyJODeFns+4PqGjz1Vd5B1MGwBPsd4dfc1P35YIXeBUI
         4Ht2JyNclfE5Vcvu5hoc1Vf+nDSvmZlVsyT7CccrTyIojqMtN7g4Ke+4TOoscesVIabN
         JWYiqdZ9UpjS5QftaQNZJk2Y61isb9jMfGPYr6Tl/PtIN/kmG4hHbBw+38AWl2/Tu1ma
         FsJwm/VpOJ1N68athu5ALcrUcc5+Twi6jw1t9UTDa/3aIcZKp5+RQ+o8UADgZUpYInK4
         ftJg==
X-Gm-Message-State: AJIora/AMBBjvn5Os7FzUlV+OGDdtlf2l1sv5ZR+/GbiLR7gUxZ2v02G
        uTBV+hWYoj46Nb1wDPU8LNa/lw==
X-Google-Smtp-Source: AGRyM1vbyaog5HoWRYB5ZVHu4ZIFJ6ipKb65WjWuHXRP7KDZfyZOtC2vPKGiHaXAWRplE3JxYqw63g==
X-Received: by 2002:a7b:c458:0:b0:3a2:e8c9:afa7 with SMTP id l24-20020a7bc458000000b003a2e8c9afa7mr413726wmi.63.1657488311106;
        Sun, 10 Jul 2022 14:25:11 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 21/33] thermal/drivers/banggap: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:11 +0200
Message-Id: <20220710212423.681301-22-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/thermal/k3_bandgap.c       | 12 ++++++------
 drivers/thermal/k3_j72xx_bandgap.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 5d0b3ffc6f46..4c2af1469085 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -139,9 +139,9 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 	return 0;
 }
 
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -151,7 +151,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -213,9 +213,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->base + data[id].ctrl_offset);
 
 		data[id].tzd =
-		devm_thermal_zone_of_sensor_register(dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		devm_thermal_of_zone_register(dev, id,
+					      &data[id],
+					      &k3_of_thermal_ops);
 		if (IS_ERR(data[id].tzd)) {
 			dev_err(dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(data[id].tzd);
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e323158952..4ffe9dde0732 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -249,9 +249,9 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 }
 
 /* Get temperature callback function for thermal zone */
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -261,7 +261,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -476,10 +476,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
 
 		bgp->ts_data[id] = &data[id];
-		ti_thermal =
-		devm_thermal_zone_of_sensor_register(bgp->dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
+							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-- 
2.25.1

