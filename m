Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639858ACD5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiHEO7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbiHEO6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:58:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301366D559
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 07:58:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so3615924wrp.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xu62us8oiOdT3v/LlUZk/RORJXcWO5pwy0aIR6nqRZs=;
        b=qCT1CIdQW4qV7SVap6ys4vIYTsas1nL0EQ8hpsVGQaDrm/2/KMHgYZlXRY7WbpJG9f
         jJ2pZzGAzKtFXlMGqmN6iIder6Hs1BaDvDNdyu9dNsnYG1zUN14Wg+tKmypYlxR7RjvP
         Sfbv14LmW5GuIhjomBvVtR+kmrG3ZWQo/zLr7anFj3Mi45iboyCpH0QXMlf47xE9phfd
         YyukS25vb6w1xCimn8QK0I1o7pD8Q5mJInCBdo87gE8RKwxKQkfI5h4q2Y9C7zPWZnmo
         axTLldq0q+HkqQz1CUBGX93TJ/wfGqmZRJRKb2eXAQd4yUFbQs+M32CFM6c7HtPjlOMV
         nZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xu62us8oiOdT3v/LlUZk/RORJXcWO5pwy0aIR6nqRZs=;
        b=PHvLXYEmfrfI94KAY+kv21cARvAyfFUau6GiOx+7ZMyxrzO20os0QagdMw/TKmNI6T
         bflRYJe7xXFNdYs3qdFufrXOChyLtxqtV6ne1CCNz72EFcu7cKeVMsLSfoTS+0ObOwZo
         8CA1xsDWcOxW20in/+bKko7CvG+RdwNXtDPIsq2XFpdsGbIhjK4hG/HyuFmHUEh0RO6V
         j6SutUoQvXGFn9aU9f7vpZ4ai/VLpNW0oWGbWPJLlg0qMPiTWxi3j5tY5iYzRJHYywGR
         gd2SEeylKs6UuS6s86fe81aBfVowUfqficvaG1difdMoq6BJ4K6TRK8NNfOCT9uyyg6V
         WWdg==
X-Gm-Message-State: ACgBeo2c6waqM2ItpyTQPIlUww7FGUc914FocGaiOD64JWmtkWyJfme+
        4nZtTvQp2iGSSv9MwYm8PIJEcg==
X-Google-Smtp-Source: AA6agR5FvzxVeAT7mC4XL5WYcb59YUms8FyOkiNDviZOZNAN6/OtYazBOPThW8h0QMqQiwwJROgNgQ==
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr4626556wrq.625.1659711495487;
        Fri, 05 Aug 2022 07:58:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v1 22/26] thermal/drivers/ti: Remove unused macros ti_thermal_get_trip_value() / ti_thermal_trip_is_valid()
Date:   Fri,  5 Aug 2022 16:57:25 +0200
Message-Id: <20220805145729.2491611-23-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The macros:

ti_thermal_get_trip_value()
 ti_thermal_trip_is_valid()

are unused. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal.h b/drivers/thermal/ti-soc-thermal/ti-thermal.h
index c388ecf31834..4fd2c20182d7 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal.h
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal.h
@@ -38,21 +38,6 @@
 /* Update rates */
 #define FAST_TEMP_MONITORING_RATE				250
 
-/* helper macros */
-/**
- * ti_thermal_get_trip_value - returns trip temperature based on index
- * @i:	trip index
- */
-#define ti_thermal_get_trip_value(i)					\
-	(OMAP_TRIP_HOT + ((i) * OMAP_TRIP_STEP))
-
-/**
- * ti_thermal_is_valid_trip - check for trip index
- * @i:	trip index
- */
-#define ti_thermal_is_valid_trip(trip)				\
-	((trip) >= 0 && (trip) < OMAP_TRIP_NUMBER)
-
 #ifdef CONFIG_TI_THERMAL
 int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id, char *domain);
 int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id);
-- 
2.25.1

