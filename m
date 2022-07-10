Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239AE56D180
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiGJV0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiGJVZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389E165B4
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so1192881wmc.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDpLMifMj8xD25r4WkNfIKy72vVUOFHmRwDlvbLrKrs=;
        b=u5uV8L0CMYjZ3UtssL772lhFuB9HX5aWqtsXxGQc2rgGuqmKez0AwC+7jF26V6usaq
         kaXCQWAI9cMaimIXKKeZO2JP3bqaOMg8Ip0psbVMPamwv/Wicw2umoWRcM0qUQ8zD0O5
         nNeC65Bf2xgedE35kO705wdh7C3apIrAHFsZL2CftoQt1m0zrkmp2llLnHJiRs2jnbrG
         bYWgGc5VHPLk4nOzpnEDeafE8GJdtgqSIclj4dtRwP/ULsfUPfqlM8Phvd2C3ZXSdWsz
         Gr00uwO7961qsnpSAZ+dlcXkEGnQEe9YEXrv04odFxZpI97Hbv+TZfXCwoqFMXB8ZxYs
         44WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDpLMifMj8xD25r4WkNfIKy72vVUOFHmRwDlvbLrKrs=;
        b=rseO5akerb5U+8XUf3AjoAx45wkCsGPhH/40pmdqjCPECs/25Ar6Z9qQaM/hVPjt0z
         1hD0zNpjxEhxVrJ5dE2wyESImZ+xuMYmmueKJfGGu6Ablo6opEWTBa8X2dVvcCNhN8ic
         bixmDOYZHFLgNmIOnzYwLkL0ZyN+13xGF+nTFlYB9g4vVJu4QGyz5ncLWfwkYdhftrIr
         8e4fvJpUf4EA4hgR8avleoP5IamHW0Ke5o3+H2arjv52eGVNQ3csO35dgA+GvhyZh5iN
         fPAmI+Ybb5BHAVij6cxUbtHe5Z8qxOs/b1iqWvkSbLqvx4O+dFpj5wNZNauzodqdUXfM
         jUCg==
X-Gm-Message-State: AJIora/Vb79GVtwMG6mWUZ4aXX143c9UuyeXZ7nMJsLezRa8+wsT9xGZ
        ymSBn+ZLlfcp8z1v6qkEDUIycw==
X-Google-Smtp-Source: AGRyM1tb9dJ2C2FATBCjs5fyOV7YnyJ32Mmp+pPKK4xv6L6sx3r48q2s7ovpZXLuMvaIcd3yG41Sxg==
X-Received: by 2002:a05:600c:22da:b0:3a0:4e7b:4237 with SMTP id 26-20020a05600c22da00b003a04e7b4237mr11879597wmg.101.1657488301801;
        Sun, 10 Jul 2022 14:25:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS)
Subject: [PATCH v1 13/33] thermal/drivers/amlogic: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:03 +0200
Message-Id: <20220710212423.681301-14-daniel.lezcano@linexp.org>
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
 drivers/thermal/amlogic_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index e61b91d14ad1..53eb7612884f 100644
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
+static struct thermal_zone_device_ops amlogic_thermal_ops = {
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

