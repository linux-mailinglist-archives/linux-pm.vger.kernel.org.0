Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB45AF16E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiIFRAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiIFRAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24895D114
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d5so7189486wms.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=VonoxkcxIL2unigQaZGkuIci+dOBagh1r3V28iduu70oMma3G18boGx+QtwykPWQtk
         hbbdVfFoeX5JumIQxIalywTLJoFC3QH/9bfZ9ibIlsVXDGMlxL3f9KbtYOT8PCFcLMHm
         xoziLjJdzpVGmd6ud3cYyCcj/SXI9guiSU6PdNUk3JIT8S7O8lES4usvY++yD5EqF/kc
         YZMK+CnL9rUyLOGYYI2uXSF+yarh143ol3U+jqJWULGcWlDJuaVgDEfMpEi0tSu7NAeO
         YvyijtUitgtU9Tkn2EMCxurP2MvgPKJmxqOC2QHxrZ0sRMuuOtI2vQOZb3zOX90I00zO
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=HECnBVu75b+JmOlqHOHg5d5EmvZDDABz0K6sLWgeS+SReDoWhnbzOj/MxONXrb/tzI
         IbvoYbgAGXT4/E2VMb5Zo4JpuwWqbWAjSStCfPlaOVhUf+elcWKpgoWdvj9zgSxvVWGN
         ocsEmVUEMdqCuWCIY8HoYJl13JJwPo8/F3/kZKd2UFhyEy3vUGSkn3r4gC0BtcdAdZVJ
         SBMO5x7z2A+x8Td1qCBrjRoeutWiRkrTcWA+ZcmXcHSSfs1DBloNAQqH/WMFVMg+0SPz
         7GdFCHyQsTGmM0Sc2WFfC7+dlFxmPWUvPpQ9sWpmkgyIzNnucaaBsnJocck86cFke+3R
         ZXeA==
X-Gm-Message-State: ACgBeo00WlbBLoQIlY2dzISHuZtgJzR/VlMkIwAz5w9+iEAT9J02HZAi
        iLS+cD3PE22JspvGdsGnNtHAAA==
X-Google-Smtp-Source: AA6agR7wKi7L4yH40a5HX1OTjeK0srJpIUh1sQ+Wyk/tiNO/QgoEMma0Y4ta99lDwAR3CUoSwKGIMQ==
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id i22-20020a05600c355600b003a6220e6242mr13849422wmq.145.1662482864680;
        Tue, 06 Sep 2022 09:47:44 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 06/30] thermal/of: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:46:56 +0200
Message-Id: <20220906164720.330701-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

The thermal OF code uses the thermal_zone_device_register_with_trips()
function. It builds the trips array and pass it to the register
function. That means the get_trip_* ops are duplicated with what does
already the core code.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..5cce83639085 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -71,39 +71,6 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
-static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
-				    enum thermal_trip_type *type)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*type = tz->trips[trip].type;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int *temp)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*temp = tz->trips[trip].temperature;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int *hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*hyst = tz->trips[trip].hysteresis;
-
-	return 0;
-}
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
@@ -626,9 +593,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
-	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
-	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
 	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
-- 
2.34.1

