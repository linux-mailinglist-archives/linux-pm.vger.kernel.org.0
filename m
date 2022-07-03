Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0456492F
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiGCSb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiGCSbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA355A4
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l68so4194876wml.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/isKFt1lkIfXPaTIWoygw+joVoVDkhVdKtPDc/SYGmc=;
        b=5zlSSXg40gmUFuNbxcAEOwBNQkHZB4kmYiGD4Bd9gCcjsWxcnjO3tEstj4MwSgnTqv
         Lf0Wr47+H4IhPoDtc9D6rPevNlUvmkzlA7ZuJCA4R+sWmYco2hpNxf478cGYF1BCr4yv
         E65msi7Y+mc9EHr/yWKAbw+njy5paJ5HYL1u6ne77h+MCBmVWwMGiajto/ZI1JgjT4R8
         3XnP+Q5VZr8EbyqonSO1FhiDpcuT26NN4Is7P7aUegqGdvb28G+A55+Ljo7WlHP2sPEW
         2SM2oJxkE4+vC7CkwZcI2EbR/fe7A56tObiTU2CyPPimQIMQ/eZtSZg48bkFBnEKglAo
         2GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/isKFt1lkIfXPaTIWoygw+joVoVDkhVdKtPDc/SYGmc=;
        b=W1Mg/21uOC6j4p+I20e0qdD3qNI0sVxLBLHsPR6AY3TeqOKtqPEgWCgJJKVIfrJ4bG
         ydozUMhMWYq495PTf1H5Prp5dclrFbH8lwLM34qIFFt02PLuXKvCwKNdt0+UoI5dawCk
         uGDE+D7MZSfAn/TK4Fmm8itbZsDo21G1GNnxI8I86/wpzOTehwqJ97wCIhyU0OdcB4Ko
         3eznM4sf/UYBh3mWaVaj5ckjumfjboIapW5Ddbl9p1iSAds1ilU2hxd9tkn+/cmDY8o9
         ItIkh+rNkotS1KU2snOmkN9YJZ6CXPGPZRFuVtkEVhN84QY2OvlWIJ4O7aQHBjo1Q0xt
         sAEg==
X-Gm-Message-State: AJIora+HkB3dg4P0me8dxLFaMnjZruWMf+qVZrdAwCsLu4TVi1T+ZWWT
        LV3Q5LpO3YehnAeoo9guq/S0qQ==
X-Google-Smtp-Source: AGRyM1vAm8lGX92tqiwhEsCF2DAKJfnkdL+4nCSpCUOCudpy3LFHR9Lr32QoS33qS/w63bMxNktu8A==
X-Received: by 2002:a05:600c:3553:b0:3a0:519b:4b96 with SMTP id i19-20020a05600c355300b003a0519b4b96mr26662033wmq.61.1656873101083;
        Sun, 03 Jul 2022 11:31:41 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 10/12] thermal/of: Store the trips in the thermal zone
Date:   Sun,  3 Jul 2022 20:30:57 +0200
Message-Id: <20220703183059.4133659-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

As the thermal zone contains the trip point, we can store them
directly in the when registering the thermal zone. That will allow
another step forward to remove the duplicate thermal zone structure we
find in the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 16eb18c24430..16b6b90a2390 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1117,11 +1117,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
+							       mask, tz, ops, tzp, tz->passive_delay,
+							       tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
-- 
2.25.1

