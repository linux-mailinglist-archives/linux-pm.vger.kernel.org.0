Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72456D167
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGJVZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGJVZH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4D15808
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay25so2063739wmb.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INk34QU48g4ONn4Ji/Nf4w3CB/6PWddAsr1wHbZyEGU=;
        b=hTG0EibU+AjAgaWN80FIO0I3IVp0EqRZiQeOLztiHW687LIvFERwOYArVxQx6yIdvH
         IBSLg7xFclb6BAPkFUmQmrep2j0NLrISGeM4OsRJCLKvaq6Gs153E2cK29CcexeLeeUK
         5ushi7w0iA1Wz+XBkDDD2tk78+muhAJzz3YK/0zagBbVLcFY4x52cNk+WmMzgDYJ0dsI
         A+ECYcPqFvCAol/MuZEl3tH+J/M+t1fgUZpZiik6+13Pqy9eGbO8YKgYp8TkaYOn0ePY
         QQ9+e01uR/hRePCfGNMcWreOR0b7SuG7DwG2O/CQSuzihmQkee8AjvkoLR5nY90riTbb
         e3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INk34QU48g4ONn4Ji/Nf4w3CB/6PWddAsr1wHbZyEGU=;
        b=otVsIEiQ4UOvsna/0H5TBwUc9Vsemf8e6ZsDkvWdxKbDIUKdxxmRXVK4SpV51EGWJR
         1ZqiLkxqfRGJtUykS0Eour+aY48gR8tl8myxLx6gtuqa7apSHAuwsI1PJQBAiGTE1kqT
         DnVMxGxJyYf3K7+gIafPyhXJwKOcFMscTq/6J8eZXRhebFr8DZZMZDjNJPmyz0AY9W53
         c/yCk5zEws9GIp3tytDM+gCcx85Mhr0gKMkA6HBDGkVbbiD83slDVzO06SrzEvDQkTyh
         rl2XlxrjaS5HaLqFEgsvxA6WC2cvu03LUwojw2rTSpeeN5LrSyTPZVVuIOoGtqKmOxDe
         VzLQ==
X-Gm-Message-State: AJIora+5cxTu/x8fHNYtkLESIhiYb8iX0StuOWO5opxqaBYtlYrZ40nq
        eMVYlrTwUBT3RQFpUYWVckOS/A==
X-Google-Smtp-Source: AGRyM1tutHCkZnBe34Cn17VJl2lwBf5jyvPNpL13mRwcRo7v9pt2JinnXDpYMMSfQW+6kiTCa9Rr2Q==
X-Received: by 2002:a05:600c:5023:b0:3a2:d6c1:4b52 with SMTP id n35-20020a05600c502300b003a2d6c14b52mr11901565wmr.13.1657488292613;
        Sun, 10 Jul 2022 14:24:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v1 09/33] thermal/drivers/sprd: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:59 +0200
Message-Id: <20220710212423.681301-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/sprd_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fff80fc18002..eb8e6bc0fc28 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -204,9 +204,9 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
 }
 
-static int sprd_thm_read_temp(void *devdata, int *temp)
+static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sprd_thermal_sensor *sen = devdata;
+	struct sprd_thermal_sensor *sen = tz->devdata;
 	u32 data;
 
 	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
@@ -217,7 +217,7 @@ static int sprd_thm_read_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sprd_thm_ops = {
+static struct thermal_zone_device_ops sprd_thm_ops = {
 	.get_temp = sprd_thm_read_temp,
 };
 
@@ -408,10 +408,10 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 		sprd_thm_sensor_init(thm, sen);
 
-		sen->tzd = devm_thermal_zone_of_sensor_register(sen->dev,
-								sen->id,
-								sen,
-								&sprd_thm_ops);
+		sen->tzd = devm_thermal_of_zone_register(sen->dev,
+							 sen->id,
+							 sen,
+							 &sprd_thm_ops);
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
@@ -523,8 +523,8 @@ static int sprd_thm_remove(struct platform_device *pdev)
 
 	for (i = 0; i < thm->nr_sensors; i++) {
 		sprd_thm_toggle_sensor(thm->sensor[i], false);
-		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
-						       thm->sensor[i]->tzd);
+		devm_thermal_of_zone_unregister(&pdev->dev,
+						thm->sensor[i]->tzd);
 	}
 
 	clk_disable_unprepare(thm->clk);
-- 
2.25.1

