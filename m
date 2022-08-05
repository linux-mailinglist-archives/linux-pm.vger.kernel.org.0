Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFDE58ACB6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiHEO6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiHEO6P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:58:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6B6613D
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 07:58:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so3615288wrp.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aycwGY1XeZJD6t9H42rSIYgonxrzkFIcAo5oQXruLvo=;
        b=DCQ6FW+r7GyZrcur0lGaCBxomP7xR6kNF9nOjbiht6mXImFEBpyttxaCGmFibXgzh/
         ud/MhekrLPs3ZKJ0SpJjnTH04v9VD5mLoZTkVGESQQDgdV73C0YNlPDSW8TirtBge1U9
         0pO+U1WNQuZgbl2UgdiTdiz3q7S80QtfkziVbyXDT0MnSgCzqFrqG5wgyEphBDfTcb00
         SeBLfpC3muC1UReCJUKleMCJUIxMoYL6OxXhTCM5MM2JbdPnIb4PxUodY2MiOx2BT/LF
         wGeIlIUpHdvSjtwew+SrkhgyVtN+s+3ed1zO34JFwF8EEFSRraj6R1lq8U6Q9VTqxYfb
         hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aycwGY1XeZJD6t9H42rSIYgonxrzkFIcAo5oQXruLvo=;
        b=dAYAGFHU9XRIuQTb6TosmLEJCh3k2h/epfieAx7HrY0IByLAs5hEti5DvpsetF6p7r
         aesOXY+q+yUbRPSTH/DKZixnYZtCdpHRhWcrAYw3pB5o0Jtj+OsclBRgDB2/5Xt9bAXa
         63u+PdOTAN+vQVcb7Zqkv42jLAD/71WF9BoA3wRV/oXyS0skqYyA74WL03aa4E8dn1sA
         uBZTnTaQIxTogK6jur9Z26p3osEyAqxIXf9lFHoiDBEB179IaUKOAEhhbWtUo5Eo39R5
         LP1tpH+7m6RnFQUDLX1aDwS7JuPKkdW/Hyoe0njfwicDi27VbMFTq4JCLX68j0ZTOx4L
         31PQ==
X-Gm-Message-State: ACgBeo387kVuKa2xi0fwhGLcWftw3GO4SjNtlZ52PF29OJY8SGLtUW+c
        k35pvph1ibeQsU7RPJSZQwssoA==
X-Google-Smtp-Source: AA6agR7f9jfzFOKnftW10ihdAFUM8taEwXkKUGedfykIp/JPzWyFzgPMzSLLC5J3wODXTI0kyt4BMQ==
X-Received: by 2002:a5d:64c1:0:b0:220:8590:3809 with SMTP id f1-20020a5d64c1000000b0022085903809mr4628440wri.97.1659711481688;
        Fri, 05 Aug 2022 07:58:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 12/26] thermal/drivers/OF: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:15 +0200
Message-Id: <20220805145729.2491611-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index c2bb5954b21e..8b68b6b94beb 100644
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
@@ -664,9 +631,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
-	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
-	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
 	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
-- 
2.25.1

