Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7C5EC659
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiI0OeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiI0OdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481D1B86BE
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5561637wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=z2GK5g1LQ8HFiYE2/XYnsjUU58bx/joUvHgDeel7/mKn2Q1H6V75OxVgAC40HNSxa7
         0Hnxnz9oOO6AEAL8f6OnoCxsJ+3bXcpqCJQEsxpnVXmMZE+Cdh/s4D28rz1fLHll9qjT
         fS9LJsN786EZvAU7wXUxoExOVnXibA9KTS9eAFQ2IQQgCVICVwCMfOTaADolaYnzxc6L
         yCQT1Wf/N1w78dEHd3I+9cmvjp0BOpSOiEkw/zwz2c52DrpAQFI1030sR6RDm2ImfDzs
         vT8dbhKqMiOL0NYWrMVEkcEEoyf07oXB+4u7HM2TfYaIguac0hqIGyyIAYOjbrq2X7Ue
         vydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=sKZ49QPdttoYe2oFFIY5PvMx0yIRGCadWKHbctFaUpeWlrUCJ5d+jpCmy4TuzJ3Fh0
         DrGIfmhkbKmpd3B4A2G5RB5uhI63gjUBNYVt8flmLEPcovp4kA55tFjxihxxxiwheL0U
         HJdshoKJHZCNfyVs2/GKZJJqlVTVfFs13zOhZDcbA0phLjwBV9SzszJLdAXry4a7E8Po
         Ceg6tokIAWkiwqdMzfQ8jUcFm/KvKS8naWY3kmX/lCZX8XdDbDmyNWv3OP3mlZiSwI/l
         5LAVbRQBJmOF37bLV/sBk0SHVbADcxnNkfVaP+USMLFv/lrNu1uCvZvpEx3Ms0px4yf4
         6jBw==
X-Gm-Message-State: ACrzQf0eRV2TAQ9ucrvzlZQ5IziFl7BECHynoyjQka/TYlEBE4tb3K9S
        /Eg02Qz/kFGFlXFLrevGAz95WQ==
X-Google-Smtp-Source: AMsMyM7PO7EZOjQKv0UyErlLA419FXm/ARdePkedOYLl3ii9SbqSknBZLWPV0xxhF5Srw+6AM7y0iw==
X-Received: by 2002:a05:600c:3cd:b0:3b4:8372:294c with SMTP id z13-20020a05600c03cd00b003b48372294cmr2980799wmd.191.1664289197304;
        Tue, 27 Sep 2022 07:33:17 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 19/29] thermal/of: Remove of_thermal_get_crit_temp()
Date:   Tue, 27 Sep 2022 16:32:29 +0200
Message-Id: <20220927143239.376737-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic version of of_thermal_get_crit_temp() can be used. Let's
remove this ops which is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 494e9c319541..bd872183e521 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,20 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
-				    int *temp)
-{
-	int i;
-
-	for (i = 0; i < tz->num_trips; i++)
-		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = tz->trips[i].temperature;
-			return 0;
-		}
-
-	return -EINVAL;
-}
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -529,7 +515,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-- 
2.34.1

