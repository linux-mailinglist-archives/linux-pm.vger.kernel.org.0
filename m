Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376FA5EC663
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiI0OeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiI0OdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F96BD6C
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v28so2473224wrd.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=Ydbg+MssqB7RwjHf2K40atoy7zuIeabeDDojGpytwXJqoQ/LgQ3OLBpeb2rbEfHXuS
         zuuiSDqNzZZTdDo7cMkTorWEYjsCjbKRe5EfB7Y7obuYZ+svwXA6KvncfmvW5zZP3AlG
         3E6q31jV7PZlkiszxEnPRzMMo6+uDeyx/r17kyho+3MBHVdeoR/5MrVSbEcROX/Mf5Sy
         pZ/7T0FZYmjYmY5AJA1+cL+lLJd/lGvySr6pe1S8fJkYdZZxw053EfR5iv1nxrBxsk8O
         OKUHT+I/7USadD47rfc7wdB6/GOtXvS5HkPjd92J9ECXMu8eHHUqA1PT/1U1wttn9inn
         VxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=aZqQgy5KUxmRjhaRvbBPT2okbgttjlgm7Owm8iVn1wb/tb4gwabZnpG5yl2aceNcbQ
         3yZ8x3uCfjsXxJuNHl9LH+OC8Kr6MmYlwiYlSjIh0DjMqqJqyQoLN6QsD3HN0KhACSG9
         w+RW0VyYHyYZElR25hvBiD1pWFzri/v1uFBev6R91VadfvORZxmtoxWce+0nPnXM4Kia
         zabYFf/HWKIE0U29QEAnWYo9JQ+6XrNo6IAvrzsoYRrmukSe5Mm6zURE4Wcz2dnTlzDr
         5IHgv5Ch87xn6TD06BFS1e+HTX4dQnUbdBqANr1lS3kA9++Xxtq0IT91vHcLBTGuipa1
         zZEw==
X-Gm-Message-State: ACrzQf0tqibHk5oFCSzBZ2kZHHyc2j+tPrUTdHUpJZQkpAF2df3JxWp0
        MaY2VJbxwdXDTkTfXlVnqlEFnaqmmkzzyg==
X-Google-Smtp-Source: AMsMyM59XWmRo/sjoJxixxbLj6+kpQz2W/z+ZHPgdk1CXw2aS+dL60R16v/fRRffufcUM49trOTgQA==
X-Received: by 2002:adf:e841:0:b0:22a:cb58:f8c1 with SMTP id d1-20020adfe841000000b0022acb58f8c1mr17425483wrn.173.1664289191249;
        Tue, 27 Sep 2022 07:33:11 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 14/29] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:24 +0200
Message-Id: <20220927143239.376737-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 52d63b3997fe..9444e5a22ca0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct thermal_trip trip;
 	int ret;
 	int i;
 
-	if (!trips)
-		return -EINVAL;
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			break;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	if (i == of_thermal_get_ntrips(tz))
-		return -EINVAL;
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		if (trip.type != THERMAL_TRIP_CRITICAL) 
+			continue;
 
-	ret = armada_select_channel(priv, sensor_id);
-	if (ret)
-		return ret;
+		ret = armada_select_channel(priv, sensor_id);
+		if (ret)
+			return ret;
+		
+		armada_set_overheat_thresholds(priv, trip.temperature,
+					       trip.hysteresis);
+		priv->overheat_sensor = tz;
+		priv->interrupt_source = sensor_id;
 
-	armada_set_overheat_thresholds(priv,
-				       trips[i].temperature,
-				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
+		armada_enable_overheat_interrupt(priv);
 
-	armada_enable_overheat_interrupt(priv);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

