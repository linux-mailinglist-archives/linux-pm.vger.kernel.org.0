Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E75EAA63
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiIZPVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiIZPTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525555D0CA
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso7050336wmk.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=JL73WR17Wo9QtiWEbhImaTC+IY7m0f8+Gxb/T/yG0u1LYZIlnRv6/Hux7V6Y5ZdDyd
         expWew6jX2nlPDAHqOwy550lJYkPZuVTrhdZbZYt51MVbjAo5P/q+5CeHmFEJ/qkbtUz
         muc4aGInDU6KV8AMk4zyjW8fwAgoKSNgj9rybamoQxK5T/TE7dtk4+4sBvw/mZDNfzvV
         NWUdE4wDfXls4nUxh1zeg7paA/InfLF4c5xje02HzoyaVKvZ2Z1cdIaDjfyinfAToFWG
         /DPFQ0GM3mjlkSZcCvCpgbFy5dAUL2Znxa8bjUPV56B2FAUT5kcf2HVQmpD8BE6CLz2y
         JlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=k6g/2afZcg6IcMS/NW5cEUiigH2sJleokdsC2GWsxS9/y4/AGDeoo5/xnMxibKGrEk
         MR4ZoJMWfnpysYBwEN074gTdF9zfKXeF1wPpuMNcWl3uZz7/r0qAHC9eFX/WkfdYxiMi
         mDNcBszV3lg4vpe+fVobG+n+HgLTjd4HrGtGYbfA0oUbOMchCW+3W92XLzMDjdQ1c+YA
         7nAimjpxBGeOvDWkyE6jdxg4czbNWrRdWP1tLOWLlXFBKI0JFTTyIKEoMkW8E/HObma4
         F2SKIC1R/OrgUl8VLvYYRnUWyDH7Oe0sq+U81SDqlb1IkSvUEDNWriD3lbAUkQ07enem
         yZMg==
X-Gm-Message-State: ACrzQf3noV4jiPAhLUNqmRXFQZU59QqPL+q+tknD2cj/WPTzCpnnfOhg
        oV/D9+6eGNieoAA1GZA3qBYuUQ==
X-Google-Smtp-Source: AMsMyM56pTcOgbo3gwYCH+yf6BtTYLM+gY5LVnEdvtHImGNDlx0rf0hyDBYaRCXNdkMcu6atF85ong==
X-Received: by 2002:a05:600c:1d2a:b0:3b4:6e31:92da with SMTP id l42-20020a05600c1d2a00b003b46e3192damr21415076wms.103.1664201204691;
        Mon, 26 Sep 2022 07:06:44 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 20/30] thermal/of: Remove of_thermal_get_crit_temp()
Date:   Mon, 26 Sep 2022 16:05:54 +0200
Message-Id: <20220926140604.4173723-21-daniel.lezcano@linaro.org>
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

