Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4B69E70C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBUSJG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 13:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBUSIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 13:08:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C71A486
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:08:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso4348141wmq.4
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PLESKqLcdlyFOxotfZU1hq7qJ9ZRCDMy4R1xbT74Go=;
        b=IDkOMIXOnBC0YaKuJQVL1UzixxoNKs9qrgYjkKo6jDz2bLz5dLKXpdOwWvf1Rnx8DV
         Kytrn1nswuJgwZ28jXJZJydBccH1zX36Szzwa5+upGUmf6eFJxqmZ+QBhiCLXiqGhpG2
         0jMrOb3HXxthyJbfwlVNppr6h8HGAwcv62B/enXccgNycCjhFq8cIrTiJfbRg0rHem1D
         hZmJmE2WGrMOkhTlg/HCLdvi5RzBY8rV8u4U99z/APmJEIf8u0laVLLxkmEejYSaukDK
         Gh4mb2DkJ5xUj7I0hTcrs3TCJLkNSyctnLAhim/44C96NoHcQV/Mtr2JU+Zx7eBzN8SW
         s8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PLESKqLcdlyFOxotfZU1hq7qJ9ZRCDMy4R1xbT74Go=;
        b=kBjtou0jXTYp4BLf0iGgWYOkgla78vpMRBcX1e7tGItzd18v62t13Hx7pVmp5Z1c1r
         nyqxCV/5Sw8BJRhbT+GlJSQLqvIggz9yNDqwzSgPY+bvwXgLC6OS7RljccqyYoOCciaE
         f6+Qm0q3Ls62gG9pJjg6j2i5p63q+CUfZXeGsJicPB/fKSNzR4UkKHoi+AGd+5FCscr4
         kIf/j1IDaWXyd2FROzXoMdxwX5nFt7e8g0d0bYUoNiCFH0txMM0HFfXZqMqWkuXBTcer
         /s0od8Ykc4yZNwTq8QbFbUTJbnkyO14vtnPBiUSRDXjkLYoSqy8936l8rOc3YaSitk6Y
         gA6Q==
X-Gm-Message-State: AO0yUKWCifLSmBd+A1+wRF02waIFlYdJQHioM8q5S4Kc8G3EI95UdNtl
        AgenYsaEr+EVNxjLd+bWmt7oKQ==
X-Google-Smtp-Source: AK7set8ruiUqU3jrcwlb8VAObzf+jUPiQQRUbmmbsRffwnPe5/KWjU2/Htpqbn26H5VSFApehTmg2Q==
X-Received: by 2002:a05:600c:2a08:b0:3da:fb3c:c1ab with SMTP id w8-20020a05600c2a0800b003dafb3cc1abmr3758944wme.0.1677002884436;
        Tue, 21 Feb 2023 10:08:04 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:08:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 10/16] thermal/drivers/da9062: Don't access the thermal zone device fields
Date:   Tue, 21 Feb 2023 19:07:04 +0100
Message-Id: <20230221180710.2781027-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

