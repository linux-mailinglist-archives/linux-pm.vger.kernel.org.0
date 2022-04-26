Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73E510BCA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355695AbiDZWTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355714AbiDZWSy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F7A44757
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k2so14011wrd.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH0tuaCVxYZkZwsvsiS/Twq7F92ctIdlTQyOxZZNlXw=;
        b=pflkFKZnYcmXkLfj0oATpR+JBj3hv5X+H+5emrYjR9tVH5KWlAgJnYG3xtlVIgZACR
         2Cy5HCeBC84zhwKk/OMiX/QkJrQATh+pVJgoFeogamogPeRlZ6jkhg2TU0nQ/R/R1MUr
         iKSP/IqVaDNDvJ90tNaxNgQwO3OFeiAg82qElrIYq97ChFhcxvsda+NTdOL1AMRQt29L
         UZdeWAROgEJk/HC0wP10VqhUVqh/yd+QXglwv5PufJrd9Nk/PnMdLDwCWcymDQ0OdCdC
         PQJc8eBKx4SVGr0x72WuyLsIfch/lvEcxeuLi7EJtli8MUmF52qLCwGwiD6j+ch4HR6E
         SGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH0tuaCVxYZkZwsvsiS/Twq7F92ctIdlTQyOxZZNlXw=;
        b=UIORvaHDj8/q1beOTFvxBdkI1Td2xWabWRJSBIvknVbTcOpusvhKl79047oTCvu7Ul
         wB0dVrwsF/PFU4ogOAEEbZnc0Vl7dklqMzfaP7qyfsRQZvvwVCZxwueSayYXwNbUiT7E
         e7e7KahEF5OO0AumEcbx+Q3ZacOAeZJa8uvKaHfCz//4pNpF0wqlfP1zr/X434N9Q+zN
         4MLzCv3zyAdv1By2yHwl8xvU4owqup7cf03742VsfFicaOHy0yq400J5Z9Yw9dgkt9xH
         vaQFAKT4P2ElXsZYzuGeik/TFjR+y0FwtTroLIO5oumdRjBTZ9Y+4jNysoJka3kE8Cu+
         V+Gw==
X-Gm-Message-State: AOAM530proqIlivBM2hOmWj9rRKTJl3g5nGFhYUDZhw6u38SXMQXXeOO
        YHhgYnm0HHKkwwEa09yyiF1djw==
X-Google-Smtp-Source: ABdhPJwQX3rj31lXRnPvoC1o5R9T3O58u7/Y+EQPpr6Cuq04nmM8rc0/hXFslDJP86YVr3NJnmksBw==
X-Received: by 2002:adf:f244:0:b0:20a:c3ab:d009 with SMTP id b4-20020adff244000000b0020ac3abd009mr20068107wrp.10.1651011343373;
        Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] thermal/core: Add thermal_trip in thermal_zone
Date:   Wed, 27 Apr 2022 00:15:19 +0200
Message-Id: <20220426221523.3056696-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index ea92a959ad59..04f3d9f80db2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone *tz);
 
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
 int thermal_zone_create_device_groups(struct thermal_zone *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone *);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e58a2f053e1c..9c75afff517a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -184,6 +184,7 @@ struct thermal_zone {
 	struct thermal_sensor sensor;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
+	struct thermal_trip *trips;
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct ida ida;
-- 
2.25.1

