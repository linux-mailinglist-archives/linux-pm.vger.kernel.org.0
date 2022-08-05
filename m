Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9529B58AD14
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiHEPis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiHEPir (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 11:38:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13D237F4
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 08:38:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so3739710wrp.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=aBvzMW7h3alEgW99ErQv4+ny+IZdZS0VnELxUm//1vE=;
        b=bJploTn1ZE5XHYS0BVPysP7rl5RlcHPt9cxUX1IVE6+RhYPxMWgrfU5DpKNg/cqYTz
         84njdSjxidKNs4jPiLtI8tJ2SLTx/N43CjhvJCshuTVqF2R3rsO2q8yUzklN33kq/0jP
         sXPng9EMCrg7FIRTD0yjlie9OSPyIhN1jNpTIfC8dllrvJIBoWiADfVbhGV+dWlg4FQT
         rMiU4hnxyenVGwzGqoZdfYUtnhBfXeE4Sc8ohFCncwcBnzEHkXvbhgeWQS2vZClG43eL
         nIPAe+aLeX5Fkvf9CeIxFdKyNx325MDaT4g2h6J7X8Scxfe/+PlkwJ46fc9EXAV2oC2l
         N3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=aBvzMW7h3alEgW99ErQv4+ny+IZdZS0VnELxUm//1vE=;
        b=yQAiG6uVbnb0s4eStERLIuDZ5YX9ukvkwVD02KWSov8MwnZ1zQkoikuqaC2RBpr850
         tGQxcnvcCQs1GrcyPmA9UpYDMDZdvatH3JHMnorfo8mUF9PPIoDpz2BIfN2KnZ+Ed/Zc
         BosKRb1FvMuTxcg385HaeEhIRGcQLLm0qGHePRmIyERFkuIbpj340Df6I6w6Q2ij9XKv
         sKjr7sT9EnIVy2gsZVPEQyFOju0z4BTcX5+249PdYw7sUa8SSA8l+Xl8tw9endcDFisU
         8sWiWss/RKfBYn6nn0eDs1ddoRQfM/B4bv6ZbwQsfBDgYptoOYP7t1oTS9XTiNoT/8iY
         SIeQ==
X-Gm-Message-State: ACgBeo3FVQIH2pR3NvobV0e5e/TSU+qDcghzzm3HKx/4rM/Lvv9FsbZC
        ae0FsDDsp8GXSTyI9s4SAzweGw==
X-Google-Smtp-Source: AA6agR4x5cXN7HuFjwyEH0hOFnaSWF2uTDVVYX3KO+S0TO9GQiiR8aa2fLy45UwY+57NlElSOh7xUQ==
X-Received: by 2002:adf:e282:0:b0:21e:5546:5a26 with SMTP id v2-20020adfe282000000b0021e55465a26mr4901672wri.77.1659713924862;
        Fri, 05 Aug 2022 08:38:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm1721025wrq.58.2022.08.05.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:38:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/5] thermal/core: Rearm the monitoring only one time
Date:   Fri,  5 Aug 2022 17:38:30 +0200
Message-Id: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The current code calls monitor_thermal_zone() inside the
handle_thermal_trip() function. But this one is called in a loop for
each trip point which means the monitoring is rearmed several times
for nothing (assuming there could be several passive and active trip
points).

Move the monitor_thermal_zone() function out of the
handle_thermal_trip() function and after the thermal trip loop, so the
timer will be disabled or rearmed one time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b4c68410c158..4e1a83987b99 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -383,11 +383,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_critical_trips(tz, trip, trip_temp, type);
 	else
 		handle_non_critical_trips(tz, trip);
-	/*
-	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
-	 */
-	monitor_thermal_zone(tz);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
@@ -503,6 +498,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	for (count = 0; count < tz->num_trips; count++)
 		handle_thermal_trip(tz, count);
+
+	monitor_thermal_zone(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-- 
2.25.1

