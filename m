Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9711E56CF11
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGJMf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGJMfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 08:35:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7E1114C
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so3851549wrc.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=AG5Aeg1i4xpol5tYCRBHi0DuekQfrGEhQW5qbA7/mVmHGUBKGpw10dbzKth/aTBwqZ
         msjntrnvTHLVJG8wxG2J5mZtGLEtR3cDt1mX/9wbg0gUFyAmIg900ZofBBy1ye5CPNyi
         yKugL9uCLEoLBlWTdrTjMViwCS9UMP0WDnGwB9kRnqC/S3eOewzpZPEDJM22+Xf/wMlZ
         tsJ/6ZgCuDBbhC95h+r01ft1xlvtkAv81KegwANYiqRrhXwnF1fCOHoVEGHqrzNW4Vpt
         qHUhP1/BHpzMpNfLxdgVZNuiS1t9It8rIfsdlngua8vuHAa0wF3XNCYGJXuaD3rP+ahf
         4V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3yHMzkH3fXgNxlTdZV4uJD5eQrxfqVqNnQSzgsUY+c=;
        b=qR1Ix5CVQ7YMUgrcuLMVYuqU56TT0ihkPrgat1Xu2u2Uc4EelVjeYZFZ35wcgh9Lxn
         yW66oTKuD9CC+zU69455CRPXmsIAb64TPrl1M6dwlrwdAIFMkQEImxA9pCwOUaGmrkqZ
         ol309XFPeqMfwUAlyA3krejDUZ81tdVKDsA4KfQsRUvtXodc7/kcrYj202O05AmW6Mlq
         OUn5Ql4CbZe2lw8wivTqRyQm0V/gqGZYiKMEHy5AKyekW2TUG6dfJHRpPB+uqnVEKCox
         IVsAUI+WThSo4MuyNbtJcGpIQuQDjHDxve2tuSHaHmOelG40dm7qlQHl/H+sLHsxiH66
         mTsA==
X-Gm-Message-State: AJIora+/PW+Baim7VbOVP522mii/w1YrIqdVc+ZdtKuyMuUN4eE4vMnX
        Eh97/LvCFENzQp3SAjERMFNYkBbHJfO4lg==
X-Google-Smtp-Source: AGRyM1syzMQfXfRQaCMlytjrjGSsDLhKazLv0upf+0JBK63RmutM2pjSbNm1WJKaHPjJwMhfujb5tA==
X-Received: by 2002:a5d:428d:0:b0:21d:7ee2:8f9e with SMTP id k13-20020a5d428d000000b0021d7ee28f9emr11842880wrq.145.1657456522781;
        Sun, 10 Jul 2022 05:35:22 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 06/12] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Sun, 10 Jul 2022 14:35:05 +0200
Message-Id: <20220710123512.1714714-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function 'thermal_set_delay_jiffies' is only used in
thermal_core.c but it is defined and implemented in a separate
file. Move the function to thermal_core.c and make it static.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c    | 7 +++++++
 drivers/thermal/thermal_core.h    | 1 -
 drivers/thermal/thermal_helpers.c | 7 -------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e22e7d939c54..a8b1628937c6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1159,6 +1159,13 @@ static void bind_tz(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_list_lock);
 }
 
+static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
+{
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 60844e2d59bb..c991bb290512 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index f4c1e87ef040..60bfda1a1db7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
-- 
2.25.1

