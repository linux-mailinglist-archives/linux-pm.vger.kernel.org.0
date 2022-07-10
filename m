Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECAF56CF10
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiGJMfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGJMfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 08:35:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11411156
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so1607760wmf.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=cIeFBig7IbdxtGrb61XbNxVA+j6A2T94DM8apK+8AkboXuzK4lBJQ30jOJQDQVZhYA
         dFvBkspS+X1eTk37AGMH65QuEITTbvoKPpRlousVXsQ1AB8i+0jM1h4ZEnYCeO6A4KVy
         SN5UvB4ciPgJpL3ITaGMH7J+iiSFHZYhIjOwFRO2zCYO/K3SLVHPiOVC4glsoXPKo4Aa
         N8o8ozXpt14eaWWuNd6l6MM5pmDxrQg3YuPbD+gSYpe1FKSr+y0yams6lQJVhoey6wIX
         3F3ULBfZ+4ARYiIq9IL7sCkwpqcBu1fGFAvZZTVMBEkFtomO24r/I4WdQmrZC+VrHshU
         TG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+KDnyI1rYWiKYKY6BfUNrB+RXhqQv2REJcaYGxminc=;
        b=ci0b9xx8ylH/3HIBSpM0PIn+Mq/ltD9sPYpeyT6Xm6izEO3GXj77MdltsRWn/fsIu/
         PhPqV3FSPFX6UsLKSyssfQdkJDykyRJoQIO2fF5ZLrBb5Av1sRoMIJ4LBcaag79vIF5o
         zHHHdgIDk0/buJhfr4fnEP16fehc69LWRCmcQDVjTqOmgjlZtEslUeWtMbl6Scpqq75J
         xQwtabt4RPsz26PiSN5qai7g4QsrOxetDMwcjRA44w1kV0Pb2P9AKhPSWx2gSMjk4GIb
         o9m7FUKe4ZUDsBB8nTDBRWfIgiEXaAmgPI4YWMfg+SrSwiLVx1FaCdOQGiMlp0g/rrT1
         Kj2w==
X-Gm-Message-State: AJIora8TloYpDDwMvKmj+BjIZfvQMFsOBksNjt0irRg7jkjeZViTUM0E
        AZIJKqm6UUwZa0iUKFCAfHao7vBjYri7/w==
X-Google-Smtp-Source: AGRyM1sSHBD5IryGyIIB5s/pP/i+ITi3z5Ljl+3aEfpZ15MxZROK6TaAMG73DQcVAnTrTEz286IOdQ==
X-Received: by 2002:a05:600c:48a:b0:3a2:ce31:a150 with SMTP id d10-20020a05600c048a00b003a2ce31a150mr10100680wme.48.1657456521656;
        Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Sun, 10 Jul 2022 14:35:04 +0200
Message-Id: <20220710123512.1714714-6-daniel.lezcano@linexp.org>
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

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..f4c1e87ef040 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

