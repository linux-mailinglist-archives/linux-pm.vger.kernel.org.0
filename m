Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490C319C403
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbgDBO2F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36808 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDBO2F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so4471013wrs.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=L6/ijDa/Jd9lpmxJXYPH3CFr+MtNwUzGkblaHQTuEUE=;
        b=Cxn+mi5l8LNcQ9ooeTVNyp7YknSO5b0dzRvVoadai2f9VqETOlr7uW+s2jR5paIkPV
         9FuWrxFWvscGJ0X8P1sDj7EeEOsKRVjYsEXZcCDsVs26wsti5C56AAdP8QWFz6wXeaHF
         NTGZzWjxHI8/HKg3RyfaeNaXP8pVJYkQAZamfx953+Gwt7Huv7wc+GXGjUWL73KdYblM
         cA2Eb5ZO6bdNzqEtRwF6IAJHnjcmBUZRmFK+FDf2gO0lMF5hi8lKxCQijDbjRVwTSM7e
         qF12rf/yC5hAd5qU1IS5AiCQmgyzVTuMmY9apGgF/1cauc3E5aEndR8dpiFNf1O2XBd8
         cqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L6/ijDa/Jd9lpmxJXYPH3CFr+MtNwUzGkblaHQTuEUE=;
        b=SQfsQdvD/z3xn8KRt5XkgHRiL0VgYLMj8GYFoN213B7IlJVu2PwwpP1p6b20t0VQVZ
         CPyuZ0fca5CiEFWBz2ENALSOQrbVXfKNBmO0qRIajeX0nq2BRCWbRcbuQ9cu8iR5t/1p
         I9/5kygHJmhTVr+lIDxVHAD85/Vc5h5JpcHD3zMD83O3kwovz/Ps3UDPvRet/o4vtO32
         eW6hX28nWwgKJuMnEhqyw8tLVcDspqTBwBC0h/Z/T6RNyUO5FZkdUMLBrdGT37z7mRNH
         ENBlyyrfkdA2DixoDJOgkpsnfxUewnS+h57BGeVA3wzsc3Y93ZxhAQcDi83DYy1eBnkf
         Jf/w==
X-Gm-Message-State: AGi0PuZwR8Kb9QIcxngf2JUYYLw1eoysDioQnDgqCdKEQY1mH7YixtXK
        lHUI4aqLe2dsiXpQ+rw0YibXyw==
X-Google-Smtp-Source: APiQypIUdnQDDdOEoeXFn6SQz3wAN0BAYyPNar/ytXY1aSsVIPaUfDXx8RyvFPho8qNwZDC8esAm6Q==
X-Received: by 2002:a5d:53ce:: with SMTP id a14mr3711084wrw.129.1585837681758;
        Thu, 02 Apr 2020 07:28:01 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/9] thermal: Move default governor config option to the internal header
Date:   Thu,  2 Apr 2020 16:27:39 +0200
Message-Id: <20200402142747.8307-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The default governor set at compilation time is a thermal internal
business, no need to export to the global thermal header.

Move the config options to the internal header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 11 +++++++++++
 include/linux/thermal.h        | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 37cd4e2bead2..828305508556 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -12,6 +12,17 @@
 #include <linux/device.h>
 #include <linux/thermal.h>
 
+/* Default Thermal Governor */
+#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
+#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
+#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
+#define DEFAULT_THERMAL_GOVERNOR       "user_space"
+#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
+#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
+#endif
+
 /* Initial state of a cooling device during binding */
 #define THERMAL_NO_TARGET -1UL
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 448841ab0dca..71cff87dcb46 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,17 +32,6 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-/* Default Thermal Governor */
-#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
-#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
-#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
-#define DEFAULT_THERMAL_GOVERNOR       "user_space"
-#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
-#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
-#endif
-
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
-- 
2.17.1

