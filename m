Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5282D1930
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgLGTKR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 14:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgLGTKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 14:10:17 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3213FC061285
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 11:09:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so232443wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhPEvjVqwexH1Hle2+ctCV7xDbrLGK3UanoHRddvROg=;
        b=WukHso3EQRBNv8iqcv+rXMyFp5xa0jSexX3IuFw/1s62AkBakuROjwGPEUQgkpI2Dd
         P8cyn4AzlwV3MkKqiqtwpW92EhNR8SQiVfDV1bS2NTcK+SZu6l1oLWIkN4WeKZu3xwmA
         6miHNlV2QMlyz1OP1r4YiEBsM7+DL9QW0ujTPYOb2evMteLVdt6+LTwyuZUr94P70UsZ
         fs4Va3s3va5PRXRLxyEhy/ciK0jstMh+nFRyzJ3iG2ZkUUzlqyFtGWRO5QP/s2uhSL4m
         myMfGJNWq2RN2LCrEaaW/BrSuQ4buOKC72HFSCx8MHSqdQE0RVL6kencjxXH37QF0JI7
         nAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhPEvjVqwexH1Hle2+ctCV7xDbrLGK3UanoHRddvROg=;
        b=I8UDVzqv2hOb+f0DARtpgCNicow9N9yNE6lvDmrHfkIpG06htyfd3jGLrcYX+KxCcp
         yC2Wqi6/IYm63PIiNk1VVRzZ+GxmZCX61PUuZa9PrG/8cs/fRkdzl8Mzq13ajDrG3u6R
         5ENcCzBBltoOne5c4/MzRKL3MKnhjYoIMiXe7dJb8m99g5/kSrad+bbUmZIWqzG/hxQM
         /jdTMIQ0jmE2ljI8wOIBs5UsUwn5k/mJwRhBCwqW/1qBRK3mO21whNOAV60xD+uZn55M
         KUgcMj7MPdkj9R7J3T1kg5lMNkQh9IZ1CNeHN9vVYKwx7r2qgnBF6kDTn4KRkQDOYGUs
         FlxA==
X-Gm-Message-State: AOAM531TvdsLhn1u/4UsfgGnLw4heUHodqWiTGV4XmSeZrnqAxagH6lV
        ufyoq5QaQYqsISlTe/8greNmPw==
X-Google-Smtp-Source: ABdhPJyfxlGAPdqiFPDwEUccMpP0WTwaWEQ1Wo7185UsZAXNrYmF4pbmpTs18AQ1aoq6wF47gyFnLA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr319881wmf.58.1607368157831;
        Mon, 07 Dec 2020 11:09:17 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id v1sm16335827wrr.48.2020.12.07.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:09:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] thermal/core: Use precomputed jiffies for the polling
Date:   Mon,  7 Dec 2020 20:09:01 +0100
Message-Id: <20201207190902.30464-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
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
index 08c6e4e36896..16ef5d652d85 100644
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

