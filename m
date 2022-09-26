Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9955EAA2C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiIZPTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiIZPS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:18:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36FD81B1B
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e18so4580437wmq.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=q6F58RMG/CMiHPhirXWdqVThjSJN+Lv/Gb+jJukat3JD1FDQCR+3yFve9EP8sKjVYX
         8hMLZJj3qLGAwYqJ5+zWAjuWa3byOkA2aFuM1EapleRzA9m83nkCI3uwUrCNkE4irycl
         EVlOMuB6qSHpsQMP23qyYJWRU0Ha+f+4tcMFxP+490t8e5La9Y7cuGWb+R7abVMIBfyU
         bqRJ9OGIUA6cqM60LXiPULsy0TgFee/tySD2WLiIpcLw2R+2IpI0nI3vPStEA2b71QDX
         OU2An5Hco6vHBNF0hXAaC3mXVW2W4sJniKUanlY6wHn+yx/dmR1ZyuTHuLF5t165hAjX
         IHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=Omft3xEdM+MU1RME891VVd76qG+jHqSdwlnH6KQTl+B2kxTbKDHcYvCOVZ0LCcGtp1
         se4DCLGRNC31qk37LcP68z7W540zD/C/+g1SgzHmuBGHPS3xLUYH7RYH4cD1l//N0UhC
         RynJq3DRjU7paj6NGeqq75brLFFXyrYMkoxhzFeXg85MdZGJAhAodV6mUj9Q1NHz+mtC
         ibhy8rM1IEg3d6uErqqnpibOUk3gOvQqJPX2w+e/rnnsipz72kf6JEulZ1xVqOCN1NzC
         gIs3IUgCiS5vaJbEsfTvffpNL7l058HGGyQw/zNnDXkqRhG0qqz0KGgJW+m2CmGrhRKW
         TWLg==
X-Gm-Message-State: ACrzQf2AgF4g7mWlSMyUk9O5tqqbEBmwi77BJqim/ULRv27iy1U9Hepp
        Y30MBRxCS0BdHim+hucTwa2fSA==
X-Google-Smtp-Source: AMsMyM66yuOfwKy0F2kk0nzaweyrEXkQCGNN4mwPp6Zo70vQ/WDq/CuTWExMV2Vt7Zr7ia8PlCXrCg==
X-Received: by 2002:a05:600c:24c:b0:3b4:fa20:6f6b with SMTP id 12-20020a05600c024c00b003b4fa206f6bmr15493108wmj.14.1664201184078;
        Mon, 26 Sep 2022 07:06:24 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 06/30] thermal/of: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:40 +0200
Message-Id: <20220926140604.4173723-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

