Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696256D16C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJVYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGJVYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:24:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0D1054E
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay25so2063565wmb.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQqkCzGs0TNscL3Fp51/xfhe1kt8vg2MHxpQZiBNFPs=;
        b=4aJZt2aQ31ms4fI64NW66+/kEAOAtdLX3E9HzQVb1yM90MfiW3C/yVvHPEqGA+VA8Y
         VDNjVVwCkNDR9PJ++2YyQyAR8kgPrlSiM7fW1fnHz61BdP2sEE3ZHuzaR9Ijh3sDmhyH
         XZWPNovQs/YInhp4N7AChczwTTawfe/MCmdWkGUhugxS3CJZlAgyRKqt0cwQq5YwUvtV
         dwduRJ5Uuz9SAbCr6M664XpWqnJnGA/Kl697gxXhfn5KF9cEe5iSOaR4BFHrX8No6SzS
         waB2UA8u5IdKO5Nsg+EdvVp2PRdB2yhW3d+otTRlS6yVebsAyCRij3BS0YAigualSreJ
         pXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQqkCzGs0TNscL3Fp51/xfhe1kt8vg2MHxpQZiBNFPs=;
        b=nPWF4QqNyYDIBS2bJKgH9A/KViO2Y6ylkwdIe7Ps8UdCySzWMBD9f2FxzMRSfBBdgj
         hXmpSTVyUIY9zIscFhNamPVT0WOfPHkTSDjQSH/yXnBUx/zY/PagRTfaYvZg1UY6bri0
         bQw5ZRRMr3RNje0EKDSnK9yEWNaWRPBu/IJCbRhein11Hzyr6g4bUnJjecoLznb0AqmX
         6mf+zb4IxtEE37dXfqNXLL04AxOT2dFFvBFMOyKkf9MwIYJNK68QNqzYe8gt5QCvwf86
         6abprE+183l2EzPNlBD0tyazCIWyEA/TYou6knHgKQobgY0Z8thKh+32NqWw4tLkASRK
         r1uQ==
X-Gm-Message-State: AJIora8NFxEllQLX0fZkDTDAt+9xwLySTdVeOq8K5cRWnV+GkGCBAXjr
        F39vs7OFX2raUmm5cK2r9x4O2w==
X-Google-Smtp-Source: AGRyM1vehfk2uVwMBSPqXeTnml3BqmcbapAlnZRFWFrq89E2gid0IDjS6WDq8q4pULjlwDqg4AtKiQ==
X-Received: by 2002:a1c:ed14:0:b0:3a2:b91b:dce4 with SMTP id l20-20020a1ced14000000b003a2b91bdce4mr12459265wmh.22.1657488280129;
        Sun, 10 Jul 2022 14:24:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v1 04/33] thermal/drivers/uniphier: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:54 +0200
Message-Id: <20220710212423.681301-5-daniel.lezcano@linexp.org>
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
 drivers/thermal/uniphier_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4cae5561a2a3..2405e72fb5f9 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -187,9 +187,9 @@ static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
 	usleep_range(1000, 2000);	/* The spec note says at least 1ms */
 }
 
-static int uniphier_tm_get_temp(void *data, int *out_temp)
+static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct uniphier_tm_dev *tdev = data;
+	struct uniphier_tm_dev *tdev = tz->devdata;
 	struct regmap *map = tdev->regmap;
 	int ret;
 	u32 temp;
@@ -204,7 +204,7 @@ static int uniphier_tm_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops uniphier_of_thermal_ops = {
+static struct thermal_zone_device_ops uniphier_of_thermal_ops = {
 	.get_temp = uniphier_tm_get_temp,
 };
 
@@ -289,8 +289,8 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tdev);
 
-	tdev->tz_dev = devm_thermal_zone_of_sensor_register(dev, 0, tdev,
-						&uniphier_of_thermal_ops);
+	tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
+						     &uniphier_of_thermal_ops);
 	if (IS_ERR(tdev->tz_dev)) {
 		dev_err(dev, "failed to register sensor device\n");
 		return PTR_ERR(tdev->tz_dev);
-- 
2.25.1

