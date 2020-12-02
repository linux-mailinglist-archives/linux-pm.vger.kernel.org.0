Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780272CBC78
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 13:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgLBMIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 07:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgLBMIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 07:08:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE480C061A48
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 04:07:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so3637825wrn.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 04:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJ0R6+v3eDzrBmGIX3GXY/fGfGw8OCjkiLlbM8B6B9o=;
        b=vfptUf5IkKYkxbzItlOYECG9qv59hYSXmZBoOJ1La3FcAa+KmxnKb0RRyMxspcne3P
         6LtxeQPXbBqX+5s3Fm/YX/MGoyEeCjd+O7PJGRAsvgYrnM+gWB+PzZ5wN7kMEJ/Rhvod
         2SEY/egivugsKPlbzLmhFPq4fp4a1TGbLJZt9E7WkOjVj82EWZcNLnV2FtYmVRX2vXK2
         ybE+H/yE2+pyfnhoWld1fzl1B+JAgG3BnCgvnyj81iLuvanxO088MyTg8lfh3SGWgNdq
         Knca8rrlRIMNTBxmUUs9wwy9XCZ2Anwl+crFlPbZwhFqhc52uJY0QGR0ZeawyJnq2aaV
         AhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJ0R6+v3eDzrBmGIX3GXY/fGfGw8OCjkiLlbM8B6B9o=;
        b=iP7BoVKLkpI/k6Bt5o2719bcE8ozR1kzj2hPvUOsyxSXVZ2zA7YJQwFWeBX9LoapFe
         BOn2gGt4t8h31NxxHv1d5EgvNo25pwmpLw6fD+EQu28t6Q9LWGt8ZFgWwm19/yeubt0Z
         4WtF9JzKBe5ARxAzdMJXwRBvCFh7vYMj2cB9aRN6BQrQbdHIpgClBKBdPh0inE4IoPPn
         DVWUGMomia/XV7zbYoMa4PbcZcduBg1ft9kKCLeVNQn9e1FhmJJsJFVFfKAVgz5RBjYe
         DwhvGQ92u8q+8Zr0ouONhEHR7tnhmZsquKT47YpJ6DrV+LFUghFxT9ZkCc2HM2/Aub9D
         BpjQ==
X-Gm-Message-State: AOAM530wXuaVHY12gxE2MFe99TKKet7tglo0kyr+IYiLI6hjinRoU201
        35hpkXnYyEK1fiZTCK6zTV3zCA==
X-Google-Smtp-Source: ABdhPJyVV9LngqpFKQFLuB1i33MBGVebiM9WuqJV0kr00aFtWoz1g78HEIrjzt/861ILbYDFIBdj1A==
X-Received: by 2002:adf:e481:: with SMTP id i1mr2969550wrm.282.1606910839458;
        Wed, 02 Dec 2020 04:07:19 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id c1sm1755132wml.8.2020.12.02.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/4] thermal/core: Use precomputed jiffies for the polling
Date:   Wed,  2 Dec 2020 13:06:56 +0100
Message-Id: <20201202120657.1969-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202120657.1969-1-daniel.lezcano@linaro.org>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The delays are also stored in jiffies based unit. Use them instead of
the ms.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3111ca2c87a1..237480429ba9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -291,14 +291,9 @@ static int __init thermal_register_governors(void)
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
-	if (delay > 1000)
+	if (delay)
 		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 round_jiffies(msecs_to_jiffies(delay)));
-	else if (delay)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 msecs_to_jiffies(delay));
+				 &tz->poll_queue, delay);
 	else
 		cancel_delayed_work(&tz->poll_queue);
 }
@@ -317,9 +312,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_lock(&tz->lock);
 
 	if (!stop && tz->passive)
-		thermal_zone_device_set_polling(tz, tz->passive_delay_ms);
+		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (!stop && tz->polling_delay_ms)
-		thermal_zone_device_set_polling(tz, tz->polling_delay_ms);
+		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
 
-- 
2.17.1

