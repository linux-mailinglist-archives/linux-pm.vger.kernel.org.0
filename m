Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB20199C4D
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgCaQ5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 12:57:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45264 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbgCaQ5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 12:57:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so26904564wrw.12
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cz8xjE9Meo7Y9lv5v8WZEBAwtkX0wnP43U65mZU6QGQ=;
        b=OJM0mi4I6J/aMEdCBdjcIDizEzs+VnS3yRZWeGD3RtLISVRjA1bzbiw8Mn+0nUTWOi
         P1ivQY+Ans0f9uRjG2yybRu1wiuZi02uCKNFt+iSjcZEHoaT6wkeKgVUmFQDqkh0qx+u
         9/gSDwf+dbzJHUjKpm8FBlm2S3qn3hfmTMox9qYBVwEp/pHAo4Kb3iWi1DErHd0PUUXx
         C7lCUZ56BTIJjU2lbV1GuqomutLeN7AGBbvULYbGVbpD5vhfbGCTUsbLrq5rEYaJvbmP
         93cVCGOf0+Yz20qqCcnlVdLqWGOdsGDzmKoKH47z1Z7PjWdWEO1TIfDSYR05ckXzfiZ6
         COUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cz8xjE9Meo7Y9lv5v8WZEBAwtkX0wnP43U65mZU6QGQ=;
        b=ks10BEzlVgknkKFaDKaXdwRCIvlE4add9t/akUC0ASVcVm76FCN9NXEPOtMOelny86
         oVXimWrei08u/bwqBRZjHMJyGWbDbe7N+ZdEWMByHMESiJTTsR3SZYHYzcRicUe7CidN
         ju1eZ3QtREcUzS+zcVRY1F1UpfbpdlQwUdL7I+pFYjrMCU3klcJQj+PvlR7ZW2OENojs
         69KtLpJ+Ta7gpvpwqtDtlvZUh0bRfJrrAEwQPgvS+D1Phz85cJLisWKR/VDAZmaUOp2k
         ao8xPh6ahXoMZO7Enx/LkaWQF2EqWOLKtIZVcR821Ekgg3q2eAR3kaNsRoqWdPo5hXu3
         +l3g==
X-Gm-Message-State: ANhLgQ3jCe3VRJiACswBAJSIjjnb7x8UGtCh4fmzDLcp7ENVmJvYxyT+
        ivkvv6F8Uwwy6m2ODAe09RMyKw==
X-Google-Smtp-Source: ADFU+vvXiktfnwinTBCN1IXFntzXTv3dPIXsn1xyesH3/byDXAmun4de70WWyrEu9DquRBiG6T4Xcg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr22794927wrv.363.1585673821341;
        Tue, 31 Mar 2020 09:57:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:497e:e6a9:b3eb:fcac])
        by smtp.gmail.com with ESMTPSA id d7sm12925648wrr.77.2020.03.31.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:57:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: core: Remove pointless debug traces
Date:   Tue, 31 Mar 2020 18:54:49 +0200
Message-Id: <20200331165449.30355-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331165449.30355-1-daniel.lezcano@linaro.org>
References: <20200331165449.30355-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The last temperature and the current temperature are show via a
dev_debug. The line before, those temperature are also traced.

It is pointless to duplicate the traces for the temperatures,
remove the dev_dbg traces.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..c06550930979 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -447,12 +447,6 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
-	if (tz->last_temperature == THERMAL_TEMP_INVALID)
-		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
-			tz->temperature);
-	else
-		dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
-			tz->last_temperature, tz->temperature);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
-- 
2.17.1

