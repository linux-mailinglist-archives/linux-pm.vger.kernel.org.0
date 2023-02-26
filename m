Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258946A3508
	for <lists+linux-pm@lfdr.de>; Sun, 26 Feb 2023 23:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBZWz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 17:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBZWzn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 17:55:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8E15153
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso5504448wmi.4
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PLESKqLcdlyFOxotfZU1hq7qJ9ZRCDMy4R1xbT74Go=;
        b=t3fT9qy1TXS8sFM4s0T5OGMJRogHttzdL/RLTWctsvHEvGWqXkkAMlfD/YUZHGZXhc
         JXvQR38z3UoJqNZBcS5YQysMXqLw9O5Y1t1MLojSdbF79hffoFec+5bPoWwwki0Ae/N7
         Xs2UBiJRgLrRdbIF/FDD4nlluojuXIqvOxSL1b3ZJq4zduqp24dGXoYi/PR5IKlFa7OJ
         8YZNOWo5vPShfecsNZbyHWEJm1AZCEKcVxtlQPEWztJAPQv8fP35icaSvu4jVscOYLnB
         9pfjtd61wAHy1q1Zq2qlDdnitnRsruigHDR8VJnrHrL2cR1hY+ZrVPHpwi8gy9F4EVQZ
         h4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PLESKqLcdlyFOxotfZU1hq7qJ9ZRCDMy4R1xbT74Go=;
        b=ry7DsZt9m1RfqYRKNEmZwZvXO2ZRmhd3huwKKN1AWv1oVdrkkf2JACn2CLYdHBNYV2
         bKwjvNbDn4UBEGaHepSCxGDmN/nnMChAzUUJGOtd5qb5R2HIVY4WhtmJ5Gl7brvFOOlT
         omIiQpMiQeJ2tgZ6SKqI+NHzxQqcVQjCyFsHxBd2mezHEgwnvDammqmUpnHoMx7/OufO
         lSEO5uPwwJEwpCHoA3UpF+OtTzWxCYzZbyIMwX+n7A2Ec32+84nQmh8Rk8PPt6pPa5e2
         Hhv6zqyZs1964nDYoeM+ixqTyPHpfT118hTREKoinHKRb/S2QXQChd+3wasZ3n4MSUe+
         MDqQ==
X-Gm-Message-State: AO0yUKUDaB6pOyofEVmARAVLXdW0O963jkhwXJCDu7QH20JfnE5QlA9O
        GwzbPgnlDWN3nu7gjRvPQFYaUw==
X-Google-Smtp-Source: AK7set9k27HgrqEsOfhwiHXkpEu7mk/mCZUPj/glYM0D8NK2+nxdjZk1qfCEbKDlOnwN1Et+WDX0KQ==
X-Received: by 2002:a05:600c:43ca:b0:3dc:557f:6129 with SMTP id f10-20020a05600c43ca00b003dc557f6129mr11400366wmn.2.1677452116251;
        Sun, 26 Feb 2023 14:55:16 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 14/20] thermal/drivers/da9062: Don't access the thermal zone device fields
Date:   Sun, 26 Feb 2023 23:54:00 +0100
Message-Id: <20230226225406.979703-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

The driver is reading the passive polling rate in the thermal zone
structure. We want to prevent the drivers to rummage around in the
thermal zone structure.

On the other side, the delay is what the driver passed to the
thermal_zone_device_register() function, so it has already the
information.

Reuse the information we have instead of reading the information we
set.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/da9062-thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index e7097f354750..2d31b1f73423 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -41,6 +41,8 @@
 
 #define DA9062_MILLI_CELSIUS(t)			((t) * 1000)
 
+static unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
+
 struct da9062_thermal_config {
 	const char *name;
 };
@@ -95,7 +97,10 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-		delay = thermal->zone->passive_delay_jiffies;
+		/*
+		 * pp_tmp is between 1s and 10s, so we can round the jiffies
+		 */
+		delay = round_jiffies(msecs_to_jiffies(pp_tmp));
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -155,7 +160,6 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 {
 	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
 	struct da9062_thermal *thermal;
-	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
 	const struct of_device_id *match;
 	int ret = 0;
 
@@ -208,8 +212,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev,
-		"TJUNC temperature polling period set at %d ms\n",
-		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
+		"TJUNC temperature polling period set at %d ms\n", pp_tmp);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0)
-- 
2.34.1

