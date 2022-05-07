Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A191451E724
	for <lists+linux-pm@lfdr.de>; Sat,  7 May 2022 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385051AbiEGM7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 May 2022 08:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385081AbiEGM7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2022 08:59:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE034160B
        for <linux-pm@vger.kernel.org>; Sat,  7 May 2022 05:55:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q23so13441059wra.1
        for <linux-pm@vger.kernel.org>; Sat, 07 May 2022 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBV1Agc9Pdc/aJxtc/EdKC25XzazArIEAhwHD2saev8=;
        b=5wzzR1Gx29D7UCg5Rn8b33Gcil8GrzuziYJ6DqgyLdYuX9aVBZY52pdOH6UvzlwXGu
         7/3b09HtWXMapswWgkONWdoS5oj00CUkpILmOu2xnl9hlgYuHA/kuV73WJOjclR+Iajk
         TiqGzcHY6A3kbmXXA7/AhhEtx0lD0qTXbsxBgPLkz+HJFPLERWZ0GxYkfaSg4Q5ManfG
         XcXPuZjrKi+dmshUUGTIPOerQyO/C/RnmsXDbMGrd3iH3G6EsWaHdlYe8hI3LzYv9Lxu
         B5bujOc0gH+qpGGmAtccxruYjqSBC3CXgYfbR+2O35zWgV6zYmj0u3uUvhKKv4Lswxkf
         Jiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBV1Agc9Pdc/aJxtc/EdKC25XzazArIEAhwHD2saev8=;
        b=OnsduSFk1l+awKBrTTGOQxDzZapdcT7fvJ/Kh2rpDV+Z7jFN+62GhzBwE1TG26DCSq
         sZsi0/RRThJ3yO9kS2ha8EW4NDvMiC6lNl2DTh4gjylNyPTxKT6LeytTsng02ysXp0g0
         ORzLr1aGnY+2VCDBvJFhB07KNQWWZFMYC4gXtTXYQzAAhkT5yK1/3jbTUvzBQb1b/vTa
         sETtwcNgfk9kvu11J42DyvhTVX11fEgQ+x4LXh3jNTtmvAM120yeGjJBPYS77GEKaPko
         dbXikPkOnv7D+XvUIHrXJbYAfMvFGAN6wXi2cnc/OP7vzzbS+6LrB/Npbu/tiFqh631T
         CMMA==
X-Gm-Message-State: AOAM533QW64piPXos8Yke38O9ugIVuUjkXjmbn3aPkaP4IJgkvmUGaTe
        Cy7Xin9RNq7qVVc8b7zUOHJqqw==
X-Google-Smtp-Source: ABdhPJwZz0TjvaRxteDz5LlnI0c6giwXgkh1Y/IRty4TL5F1Mj+InwcqJUS2j5CSCd5M2fXGSBXN/w==
X-Received: by 2002:a05:6000:86:b0:20a:d7be:e09b with SMTP id m6-20020a056000008600b0020ad7bee09bmr6405140wrx.398.1651928119004;
        Sat, 07 May 2022 05:55:19 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 10/14] thermal/core: Add thermal_trip in thermal_zone
Date:   Sat,  7 May 2022 14:54:38 +0200
Message-Id: <20220507125443.2766939-11-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal trip points are properties of a thermal zone and the
different sub systems should be able to save them in the thermal zone
structure instead of having their own definition.

Give the opportunity to the drivers to create a thermal zone with
thermal trips which will be accessible directly from the thermal core
framework.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h | 10 ++++++++++
 include/linux/thermal.h        |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c991bb290512..84e341c1e0fc 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
+static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone *tz)
+{
+	return tz->trips;
+}
+
+static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
+{
+	return tz->ntrips;
+}
+
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e11c3d922c18..a11c00062ef1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -184,6 +184,7 @@ struct thermal_zone_device {
 	struct thermal_sensor sensor;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
+	struct thermal_trip *trips;
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct ida ida;
-- 
2.25.1

