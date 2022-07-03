Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2756492B
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiGCSb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGCSbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE962D6
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so4436739wms.5
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytk6hZOc5k3XFHtzqogPt/m0wTJUPnrDdEaPU5N3m1I=;
        b=hlAaqbH6ItL1iLN4ikMGRagc4T4JnVFXvMOzDusKYjf/mf1kJ7erKSoSVP763gF9JQ
         fgBnKpoSMuTDgbtxYzO3qgqJyeHupWvNoWjim22brZDIzfJw9+S7pPJy5nAcufl8h/OA
         DyxIznZYtNs71l1kpyhFQehkSJ2Cm41aI6TZc57t4SiyV2Qx2Qx/DqqmXCWB6HruQ5Zx
         ikuc66nJfKk87Tpe1rSer+Y0Wireku1mAgTl/58XdJeYk0dmLiiqW9eynxm2mFnUi6OU
         dcOlfdqBpzrTUBH7ch2Wd+ShssewDANeJbDgSi6i0uHUsa+27d3U5uwpkp/2iRVDhvW1
         /thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytk6hZOc5k3XFHtzqogPt/m0wTJUPnrDdEaPU5N3m1I=;
        b=hU29vWoWXiNzZVhif1HDVHEbhwbb3ei7UZIbceA4NkYblcQjZcvnubk4VqC9C/3Nyg
         HA/RfxyBK2xpSw8GIX7xGpHOsoEe92E7Vb/vFQuKsaTwHRD+3PbrrHRxRIMJBVZ/4llN
         cD8eEBr1XQCE3Ly8D8iG89LiYMw20MdMELknz5jCAVoS5qPzpo1jhogHy0xqN69X2lU3
         7Eat4GTSmj3gi1CNwFCPZpGinZ7bwV+lLN6k6ed62S0goXWjfz1q89FxQL6T/rhR5JBC
         S073ILDQktf78Lydmcgvb3E1ogMp7ZWVrAkgwhhF//Csw1f5xjnMuFKpCb3YCcDWMed5
         v+zA==
X-Gm-Message-State: AJIora9Yn9+9Agvj54WhvfPIUZVpou/GRnWBU20SXM+bl9L1IB7FLykW
        qhmUKaCJU+zqo+K/YJWD+qgJMw==
X-Google-Smtp-Source: AGRyM1uL6+KaT79e11hlLOr5QXnKWuwMgKMFI1Hpw+ifJdlmHhg4BGK1vNNxZ3Sd+n2v98ew3iQwdw==
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id d3-20020a05600c3ac300b003a045b67efbmr28626507wms.183.1656873099008;
        Sun, 03 Jul 2022 11:31:39 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 08/12] thermal/core: Add thermal_trip in thermal_zone
Date:   Sun,  3 Jul 2022 20:30:55 +0200
Message-Id: <20220703183059.4133659-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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
index 3a57878a2a6c..3733e23b6359 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -179,6 +179,7 @@ struct thermal_zone_device {
 	struct thermal_zone_device_ops *ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
+	struct thermal_trip *trips;
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct ida ida;
-- 
2.25.1

