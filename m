Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C626A7519
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 21:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCAUQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 15:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCAUQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 15:16:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072D515DE
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 12:15:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bw19so14466673wrb.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=w20389TVo7cyTMlF1uBdGLoV3aG9r8YnIBrEEaUmS9NigcXApbhiu+OjC9ruIiIyfC
         qNCdf4BKsBXu3pPRYxFsPeKFTm3gYDg3uMAMMVTVEmgan5U/bqXsoEB63X4rxO4Pn3lr
         STj1QF6J54achUo1iLzZTLul3chly+tXnbQHYT169j5RNdJk3Y6c2r7Xh4gZvAzZ260/
         HszIq/U4S41qFWXpL71jXGfFIngIdvBLkbXJPomnbPjLWH86lNjdQSlBWb07wjK6vtGl
         5QAIn0Ux8tUZW/347UD7g6foztFrY++6eH+t7cDjy8ddi5k7jnpowdUOs2fBgR2KDJUs
         +70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=t+c59qjHtOX3jaR1EAlrBE+ij5bv2nvwMN0Xbus4u2snr6MsnMyg8dVebYTvQYu4Rn
         7lX94/W6REhyNY37hwGvs6S5u9rwZlhJlRHKRtx64D4FJ2+GwzvwGAl9w1ACkRr89Dks
         RdNQDNh1FTveO9Zn+jkbUwRH0ptURNKW2JAEq3vb8Bjl7HiR8BuAS9J5h49E8YzladyH
         eSSDOqAThD2+tCO0kKQn3rJJcxSmjij50HJ1YwwfR8bNKXI+ec6PexPAqcU7hGNrk1FB
         gr8vZSVOa9Sx0lKaR46P0DY40rKntCXaCoo56/JO95o8EAKUy30OzslbLZ8B40/VBOLA
         iNJw==
X-Gm-Message-State: AO0yUKUjB7+qQDnfrRyCXvd5nobTKVk6tgSC4AUEpn/JUuA6O3cEZz44
        Qmln9mVJexImq0maTs9RESAShw==
X-Google-Smtp-Source: AK7set8XUqwRo5r5lojj7sUCgZls1QjoUg3zR+RESxHPeB+d5LlWXJhnxfeLre8oPm3UQJDLA0WWYg==
X-Received: by 2002:adf:ff8f:0:b0:2c7:1757:3a8e with SMTP id j15-20020adfff8f000000b002c717573a8emr5126686wrr.34.1677701751124;
        Wed, 01 Mar 2023 12:15:51 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v5 17/18] thermal/drivers/acerhdf: Make interval setting only at module load time
Date:   Wed,  1 Mar 2023 21:14:45 +0100
Message-Id: <20230301201446.3713334-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
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

The thermal zone device structure is in the process of being private
to the thermal framework core code. This driver is directly accessing
and changing the monitoring polling rate.

After discussing with the maintainers of this driver, having the
polling interval at module loading time is enough for their purpose.

Change the code to take into account the interval when the module is
loaded but restrict the permissions so the value can not be changed
afterwards.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/acerhdf.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 1956469c3457..61f1c3090867 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -79,7 +79,6 @@ static unsigned int list_supported;
 static unsigned int fanstate = ACERHDF_FAN_AUTO;
 static char force_bios[16];
 static char force_product[16];
-static unsigned int prev_interval;
 static struct thermal_zone_device *thz_dev;
 static struct thermal_cooling_device *cl_dev;
 static struct platform_device *acerhdf_dev;
@@ -346,20 +345,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 	trips[0].temperature = fanon;
 	trips[0].hysteresis  = fanon - fanoff;
 
-	if (kernelmode && prev_interval != interval) {
+	if (kernelmode) {
 		if (interval > ACERHDF_MAX_INTERVAL) {
 			pr_err("interval too high, set to %d\n",
 			       ACERHDF_MAX_INTERVAL);
 			interval = ACERHDF_MAX_INTERVAL;
 		}
+
 		if (verbose)
 			pr_notice("interval changed to: %d\n", interval);
-
-		if (thermal)
-			thermal->polling_delay_jiffies =
-				round_jiffies(msecs_to_jiffies(interval * 1000));
-
-		prev_interval = interval;
 	}
 }
 
@@ -807,5 +801,5 @@ static const struct kernel_param_ops interval_ops = {
 	.get = param_get_uint,
 };
 
-module_param_cb(interval, &interval_ops, &interval, 0600);
+module_param_cb(interval, &interval_ops, &interval, 0000);
 MODULE_PARM_DESC(interval, "Polling interval of temperature check");
-- 
2.34.1

