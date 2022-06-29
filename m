Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D35603F3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiF2PMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiF2PME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:12:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C2340C9
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:10:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so19006542wrh.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ZYq3bcsj/UjtaD25DcyTAm2D/1RmGVwIAKcRPY+eg=;
        b=CmfYYcfr9K4XbkT5SOVFmJr3HuPO8kzgs7aT8gxU2yyEUPp6GOVCS8JG+2P3gzMlbj
         yKeowkAkIbJykRtw72dw9FERYSt6OhnDV90lVoenDJ6YiMW27N0D3oCzJdSLLG33V9C1
         wL6nDNlwM4meKfHLoGHjvaKpuzsQ88v+Qu7lYNugA3HQl5BIxNkR/fzCJDge2CCkLdJg
         oRd6Ld+/46jhOoHppRz+S5f0j7K+V2Zq9ZeJsgKBNEKDiDYxRXSVqEyrxjjvQovJqeFm
         GXVEdxkh3WDLpVa5h/tX89cGWi2oD86jhuiQIq7Ft6t/jCFpOSHR6nRELoiSIxGwQe8V
         EeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ZYq3bcsj/UjtaD25DcyTAm2D/1RmGVwIAKcRPY+eg=;
        b=GYO8M1gGDiL1mpEFx53FEHzpXvf9b/cnY8QqvSqAEU6GOXF79ZrAe68HcFvrYUkB4W
         0OYBJiCWZyqmf+Y2DURwCAv8Bmh8v/RSuXfVwqSmWLN7hFR2dScnOw/QJHe/gXC2pqzZ
         16zX/eOs/Ir9Mp4ps5eQsuUD/abWpg8tNjLQEjgrZWDmJG9nlsX15rOs3aCGLNaCY7QW
         D+6LiYOOCoko9pUP01gva4yKoU+PiOfJ/wB+z0EREBWnO1t3J7x5WsFff1rri1nvEsRY
         wWGY3yo8SyRodHF4SMye1p6CWc+PJCpwkz/UQ/Fuyv5ksqAU7LAtbwt+tvrY38dds+/8
         /J1Q==
X-Gm-Message-State: AJIora87XpdRbrg9vRlbDLb1MtY7TwrhBy1kRz6MS7Jbyp2mXcp2kHz2
        eP0EqWDA1uhJ6B9zTEuCpoIo4Q==
X-Google-Smtp-Source: AGRyM1vWMbd1NwnfZaHax5oHnxcFN5zGrIUsdhYd0b6WXkGuttwDKXF/INDjHiqVGqyNHSzC+DHU/g==
X-Received: by 2002:a5d:604d:0:b0:21b:9b2c:be31 with SMTP id j13-20020a5d604d000000b0021b9b2cbe31mr3710411wrt.91.1656515427060;
        Wed, 29 Jun 2022 08:10:27 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm3509029wmq.1.2022.06.29.08.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:10:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] thermal/core: Use clamp() helper in the stepwise governor
Date:   Wed, 29 Jun 2022 17:10:11 +0200
Message-Id: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code is actually clampling the next cooling device state using the
lowest and highest states of the thermal instance.

That code can be replaced by the clamp() macro which does exactly the
same. It results in a simpler routine to read.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 12acb12aac50..6efbfaf014da 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/thermal.h>
+#include <linux/minmax.h>
 #include <trace/events/thermal.h>
 
 #include "thermal_core.h"
@@ -52,10 +53,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
 	if (!instance->initialized) {
 		if (throttle) {
-			next_target = (cur_state + 1) >= instance->upper ?
-					instance->upper :
-					((cur_state + 1) < instance->lower ?
-					instance->lower : (cur_state + 1));
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		} else {
 			next_target = THERMAL_NO_TARGET;
 		}
@@ -66,10 +64,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
 		if (throttle) {
-			next_target = cur_state < instance->upper ?
-				    (cur_state + 1) : instance->upper;
-			if (next_target < instance->lower)
-				next_target = instance->lower;
+			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
 		}
 		break;
 	case THERMAL_TREND_RAISE_FULL:
@@ -82,9 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 				next_target = THERMAL_NO_TARGET;
 		} else {
 			if (!throttle) {
-				next_target = cur_state - 1;
-				if (next_target > instance->upper)
-					next_target = instance->upper;
+				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
 			}
 		}
 		break;
-- 
2.25.1

