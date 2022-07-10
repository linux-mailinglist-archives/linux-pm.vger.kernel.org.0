Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F056D183
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGJV0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGJVZs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C5165B8
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q9so4752741wrd.8
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VqD6Kev6VpOnlemDKOOgsLknXMbXjfC/c5SvSd/sfA=;
        b=3tN7jm+EAe27LAGDzDjITeX7X69ZTvKB7Pg2lBkNSRSxJpzDCk5NWODvshf2VgMO3P
         3jYYCGHZNpdllYmBB0KZHDNPSj8v9uUFnQBK//R1QgcuYz0OTvtzRa3owN1WnOrvzUjC
         5cTqpuptbLDB1tkB7cWPDiEmGBnvZAj+hRoDK03cTl6PPL9daSTzm1vw79TNALglN6l/
         4QULZnavS3EHGEZRHFJXYgiwo1a81rmEOqeqOKu8PHGypecspPsG6tKZdS5COhZnsnpo
         u2nAKw4E+cChsBlS91UMCepzS4w3TQIN0yWIkSfcx7UgsNHv9f631Mi592V4H/pxm+ex
         4Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VqD6Kev6VpOnlemDKOOgsLknXMbXjfC/c5SvSd/sfA=;
        b=GlEopvfzvFvjfQcFgoV+1bB5CHfDM2979ozu/eZ+E31JDP093RENDSm6lgkBVtZODL
         Frm+NrQUHvRnI3biJdztYcEvvovcpEjCEo5fmyXZpMgobEdrB5t1nV7fx9c8HVCpdxIS
         j56p5up28C0/2U4DW3I4MEa31yzJD268rdOb+wF88l2njLG7ngvnuDWQoNlvLJRpDqJy
         2WGlmkxWy0e5y1X8BbOl2xIrUsLJuLoc1pGOuatU7jWMAvDjBHusZRj7RLSrE8QP85UU
         jZ/l8xFETRwDSQF849T6I+lVUpO/Hyg6aXj2qdUji39Ef1h4r5oB98nmtObIOn0V43h8
         dgxQ==
X-Gm-Message-State: AJIora9mLboTIgnZBoABjqP3ue4Fbqv/v4s6pFSxiv/ycv76U6KzBAxs
        DhSowzy3+rAGfLg7dWPjDTMjtA==
X-Google-Smtp-Source: AGRyM1sSzyB7CSYFxqqnGpSGjUZBq9fLCMzcB7U7MimlSfil5Ogoz1VbACTlDbQfsuw8bJXO2djvfw==
X-Received: by 2002:a05:6000:15c3:b0:21d:9f5a:df83 with SMTP id y3-20020a05600015c300b0021d9f5adf83mr4931743wry.360.1657488302963;
        Sun, 10 Jul 2022 14:25:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v1 14/33] thermal/drivers/armada: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:04 +0200
Message-Id: <20220710212423.681301-15-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/armada_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..72346cf1335a 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -420,9 +420,9 @@ static struct thermal_zone_device_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
-static int armada_get_temp(void *_sensor, int *temp)
+static int armada_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct armada_thermal_sensor *sensor = _sensor;
+	struct armada_thermal_sensor *sensor = tz->devdata;
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
@@ -450,7 +450,7 @@ static int armada_get_temp(void *_sensor, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops of_ops = {
+static struct thermal_zone_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
@@ -928,9 +928,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Register the sensor */
 		sensor->priv = priv;
 		sensor->id = sensor_id;
-		tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  sensor->id, sensor,
-							  &of_ops);
+		tz = devm_thermal_of_zone_register(&pdev->dev,
+						   sensor->id, sensor,
+						   &of_ops);
 		if (IS_ERR(tz)) {
 			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
 				 sensor_id);
-- 
2.25.1

