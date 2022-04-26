Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086ED510BD8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355812AbiDZWTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355710AbiDZWSy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70D43AF8
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q20so139369wmq.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLbpL2O4THqkOA2T7fA77zNe+VikV0QIHwrfCO5ZH9g=;
        b=UvgDzFtdTJF5q0RKUzObK80v8Xw9nrNu0dt5i4EiXvIGlydd80EvbGmS+8wnoi7SJY
         ERqWS1iJk6vEWurRXTTv8oIzuCpedLmi4+7j3U3fBv0BJDijYEZZLTeBi3g0sHaMOSg4
         AW36EupfAAadusdJRtOBCN4WyNEOj845Ds1iT6oTmpRdppNtS+GkFAhKZfO9Ajm1sRfg
         g0yzZ/EqEFLieQ2FRHNHV/ndaSwLjM0m1izvqbSiuiC9E6zPDVgsWG93rahorVwuBEnU
         MUHtd1xmBrBCuq2lYo7ce8pbGV+4MzGG8RPETujs/IrXineLEPySOCKjSg1X7A4MGSHG
         jIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLbpL2O4THqkOA2T7fA77zNe+VikV0QIHwrfCO5ZH9g=;
        b=TG78w+J198YITUi8EQiICbUALn93UXI/A6/Fo8aOsHgfmpfAUM7Wtzlqra6WevEFwQ
         Z0zWhPIzVxwqNY/Gi7+/PaH6gk0+f2fPT+TRRr2QMlaegY56Wa+jVNTQyx6m2GOuOf/Y
         PaK5pdyK8lqBnWqQ6Bsr0Q6Srk0gH88QNZ+BkpBM9xbav00VNyvTKeYHL9ABoUWSMGvd
         rAVq5WHQ3aRmvHiQX1gQ5wHTyUSWxogbQSLC4Wk/kgRUX0oTVDDSuiZNJJZ1FwCV0O4A
         atJmLafkNVa+pzdaB4f1DEp9vLrxmIgLwGVh+oiA5D2m2838F4GvN/t/NaI34m718UG4
         pHnA==
X-Gm-Message-State: AOAM533Ssefnyj3Plohd2uIJvcmW3UvkAcCpkGhzCmKZ1V09uyPtdMOo
        4a8DNO8uHypbcrQW1/CZRkiXJs2hsUhPdp2eJLE=
X-Google-Smtp-Source: ABdhPJwe4w6Sy0t5oaUh/SdM7Ot753PzTjsTfs+amEp/ItQYZeZtuW1ERBNh0tVAlFfShbpOlDtNJw==
X-Received: by 2002:a7b:cc17:0:b0:38d:af7:3848 with SMTP id f23-20020a7bcc17000000b0038d0af73848mr23481127wmh.41.1651011342026;
        Tue, 26 Apr 2022 15:15:42 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] thermal/core: Move thermal_set_delay_jiffies to static
Date:   Wed, 27 Apr 2022 00:15:17 +0200
Message-Id: <20220426221523.3056696-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c    | 7 +++++++
 drivers/thermal/thermal_core.h    | 1 -
 drivers/thermal/thermal_helpers.c | 7 -------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a34c8cb31e91..e741c932236e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1158,6 +1158,13 @@ static void bind_tz(struct thermal_zone *tz)
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
  * thermal_zone_register() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 9ecd12e8ef9b..ea92a959ad59 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone *tz);
-void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 76b831d9e0e9..aa687dee4d64 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone *tz)
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

