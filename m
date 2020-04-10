Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1801A4BC5
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 00:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDJWNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 18:13:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40927 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgDJWNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 18:13:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so3870953wrt.7
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llenZ0suLw6do3znZz93SYo8GX9BjIHqcVpMde2jjyQ=;
        b=cwCobIiCE2a2mjAnkofCunPBk+7umwjxVTgVuitn1olEYefEHvZ249OUkRHdAk7pwz
         ZcZEI4e7xACErBW0VB0jSW7/OBQQ7T9K3RnPiKvod8K6MCUdr6ioCleJoWt+3cQJpBeT
         tvOgAE9871nhq6h/UZMh95s3zj9QIQUbJMQTOHiEF0ea3zORrNTnnAIJplXgihfgvF2u
         cCSo9rK6uNPxp8ee70mp+z+/xfG08RNaL9Uy+C4IK5vvm8sK0onQGf01RyVb0hXVt9M5
         Hfau4KzuDNebjzyEUoW2TBCTE9YSLzGncrleGn/Y9HreeXAuuQpQ79AD/QWnVoU6xM8C
         DQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=llenZ0suLw6do3znZz93SYo8GX9BjIHqcVpMde2jjyQ=;
        b=Z5qiY9KrtNzU2N7Pclszoremj+MjANILTMIngokKhKC2/G3jCnsmTydPPfQDIqJMaJ
         T+JHn0R0R3hlDVmd6pFMgNvHPhLRI/lSC9uioUU/hvYMzxRQWnbSis1fwy0O6QYvzKAN
         fo/haCusQHD3QpW2/TQ373dwWE2l5G4OMsSK+7ieaauCKDIk3hqlvyH4EtEU+dEDfk8C
         FjW+syUCxyxKkhdqBrBOjCjsSy2IH8W2+akVKwzvgbfGiqDsJi7zJamSwXPccT+R6CY+
         Dygnol6PJw5z5eSV1Gtq7cKdWjA7jZzBLfMqLHJpPlOkYH2+xS8bGZebt/0x7EnOhXOQ
         CxMA==
X-Gm-Message-State: AGi0PuY7BPWoYJ+DJHO59KttXCR5JkiaSRrd2yGJ9vvcGeBA61PUVJN6
        r2WeLgpelpCelZRP2xQME7TJLBVddHI=
X-Google-Smtp-Source: APiQypL56/ywMxjjn+QWFh16svA+TLTAIFUlP6upenDKZquE4BHfXKiHuGvX23Z7ZGxtydPxiOLMtQ==
X-Received: by 2002:adf:9cc8:: with SMTP id h8mr6405064wre.167.1586556784930;
        Fri, 10 Apr 2020 15:13:04 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:13:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 5/6] thermal: core: Move the call to thermal_cdev_udpate() to the power allocator
Date:   Sat, 11 Apr 2020 00:12:34 +0200
Message-Id: <20200410221236.6484-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the calls to the thermal_cdev_update() are in the governors except
one in the power_actor_set_power(). Move the update right after the
call to power_actor_set_power(), the function will be located in the
IPA governor.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/power_allocator.c | 2 ++
 drivers/thermal/thermal_core.c    | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index fd7c8de02250..339442925dfe 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -433,6 +433,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 		total_granted_power += granted_power[i];
 
+		thermal_cdev_update(instance->cdev);
+
 		i++;
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 052f77b0b0ef..a6b8c0240656 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -614,7 +614,6 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 		return ret;
 
 	instance->target = state;
-	thermal_cdev_update(cdev);
 
 	return 0;
 }
-- 
2.17.1

