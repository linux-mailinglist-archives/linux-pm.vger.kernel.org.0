Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84645BFB6F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIUJol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiIUJnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC693915E9
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z6so8963304wrq.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=NspiL8xBWtxFZk4xO58c4h8PCilOME2upvEL2MDhBVpLETfcOqoi+Tb4f2jIc0frbg
         6CvUC/Djm2URTXlqK22pC3SOrZai+bKjOcd1ZKAz5Y6p1Na5C7EQ+EdY3vdBvKHD6Yup
         A5O582+buH0igDPx/lC5xvqBL+Qf7GMkMd7iUNFuNR/Yq8GgV14nj5g/9sYElgaqTGVn
         SPDw0+8m7mJTBgL9O7GbHk1xUZPhjL98pO8sZCYTFS5RTHIeowE+qqB0mtZvHiPTqxUy
         im2qFrc8GqmhvDdFlUmhly6UlrAsUJXot3g/Esm+Xb9oaDuzeJhX9bOpzUyQu6MDWIUM
         UIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=UYgw27gg1E/vU+JEGh5APfP/nqYU0WSUt8Q8ajRCYKox1EYCEVsAeknD/wTkRBRXDi
         2zq7ZY400MRKrD9tK92RZXG0Xkfgyb+LwGsshU8qZLz1uI3diwWzjIYXKaSTN3tterl1
         j7IREPd5BI/QJiPwIKV7ULHRu53DcJ0rMtxt9XBhJbjM4wExVQLI5c/jmnLjMtlzlkNi
         ZUscIkV3oazQJAXbnVlbOGqfO7xL0bQuYIXAWXmJF35zrfC6+wwho2YOc2cayl90vHGc
         qmJzNxXBVQ7mZg97fQ48ta6/vtg877bTpQQ281W169g3qDVOmIxylRqN3Y7w90PWBEWH
         QeTg==
X-Gm-Message-State: ACrzQf1J503dBHcKOOiSUNl0N3pBMsRCXYnDBOEYJr2in+539dwwqROi
        YyqqfNdPPJ31NGG4nU4NycHlIg==
X-Google-Smtp-Source: AMsMyM7Sf3DMIyE4rAZmaGC6IdbRUGqfxWS1HPCPY/JWVS7LneJM6e089hZIfjClcagq4gtM9moekg==
X-Received: by 2002:a5d:64e5:0:b0:22a:3cae:93bf with SMTP id g5-20020a5d64e5000000b0022a3cae93bfmr16811393wri.323.1663753429413;
        Wed, 21 Sep 2022 02:43:49 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 19/30] thermal/of: Remove of_thermal_set_trip_hyst()
Date:   Wed, 21 Sep 2022 11:42:32 +0200
Message-Id: <20220921094244.606948-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal core is providing the generic thermal_zone_set_trip()
function which does exactly what the OF ops function is doing.

It is pointless to define our own version, just remove the ops and the
thermal_zone_set_trip() will take care of it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4e54d62720dc..494e9c319541 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,18 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].hysteresis = hyst;
-
-	return 0;
-}
-
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
@@ -541,7 +529,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
-- 
2.34.1

