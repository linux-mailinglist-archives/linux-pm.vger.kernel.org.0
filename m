Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9A2DC8AE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 23:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgLPWEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 17:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgLPWEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 17:04:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE8C0617A6
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so20887185wrm.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgs8r4lXT96VdPjv2ZhhWufDRA2IuacaLllCLFcigSg=;
        b=oz2cHKMuCn8EHihsUlyEe0vEqvX9ES021uVO0KXuO0CB9kq/cdxWmcIBPqTm8Bva6F
         s24w5WaAXXv2mNckrnstFZtffAV9hHgH1oMyAxW4GBDP0rfwWNycxN3l8TZBHMpRsN9d
         RO04oRMI0dfot6v0wNYbjSwsvRO7NSicVNMj/r9CevwHbgNR8KRsEhvZeqAyHUTe5Lqp
         Xt4RqVMtllwOgLYuAJQTVCVfxFqruXrcWeer5iLNOtQ0O2KSUYFeqmB2OItffGRhFLVV
         OUckMgaQJhJx6z0fny2OdlzoyiovpRB869e0whI1Nt6xugslbiE+y+V+7GeRXHCTxJ/l
         kfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgs8r4lXT96VdPjv2ZhhWufDRA2IuacaLllCLFcigSg=;
        b=sz5N/aIJ7KMX0BAe04+07qmJsPLoh/vcn6+chy4eQVzLjjQEENR40rkIXv+xBAHNtR
         wkT7AXLshB9YwQySdrO0SGXaND68N41ZkCCJvmrS0k0pJOHXsGJYKtfzwsg23y7XY2ub
         TQ3dGlt48tkIyMr5OGp6NlrBMgcIUXhkdFqIFh2RKTQ7VOK12M70McwL6ahyYuez2iDN
         zbpYZOnpKKVWIj4mEtno8rcyNQDpJ0QPmOetFp5Oit0SpboJyV5tDklKVw5e5/22dcuq
         PhUqSOHSGWrn8DIRriFSRyAa2EnVLeg8vepIDwSL38YohWI/m00V/fkBI7HiHVCAfwzT
         rAzQ==
X-Gm-Message-State: AOAM5334+z0HeROE+0mXYbCgE581GR0syg1gpHaYLM0W3o8EelFhFoe+
        eNXAfllqU60ceNx6PPKPIc6ntA==
X-Google-Smtp-Source: ABdhPJyEqaEZxCEpFfBEKGC8tbEo2NdTN8qeobh+xZRJX1AtFjnNR8ByGdUk8Zc5vhFApPZO81TVAw==
X-Received: by 2002:adf:ab4b:: with SMTP id r11mr23937497wrc.282.1608156236012;
        Wed, 16 Dec 2020 14:03:56 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.gmail.com with ESMTPSA id a17sm5277933wrs.20.2020.12.16.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:03:55 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 2/3] thermal/core: Use precomputed jiffies for the polling
Date:   Wed, 16 Dec 2020 23:03:36 +0100
Message-Id: <20201216220337.839878-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201216220337.839878-1-daniel.lezcano@linaro.org>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The delays are also stored in jiffies based unit. Use them instead of
the ms.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2c41d4a0923f..d96c515af3cb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -289,16 +289,11 @@ static int __init thermal_register_governors(void)
  * - Critical trip point will cause a system shutdown.
  */
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
-					    int delay)
+					    unsigned long delay)
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
-		thermal_zone_device_set_polling(tz, tz->passive_delay);
+		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (!stop && tz->polling_delay)
-		thermal_zone_device_set_polling(tz, tz->polling_delay);
+		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
 
-- 
2.25.1

