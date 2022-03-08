Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623744D1C3C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347870AbiCHPr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347970AbiCHPr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 10:47:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DA4EF65
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 07:46:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z11so17587616lfh.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WS72j8JGEqSGj9q0ZTN8/hogbbsFfe3+nSh2IPUnrHM=;
        b=mnnAK6zB6mM9uuESnxE1R/FMsIvcHNXhKho2sSBoHHPInvww2Nw+wuenq5TuctFCgE
         o0/bAnlerQeJxjF62dOllLwW3ktB2zPqpRxQlZfeQB5+empvT1XaJB5tPWlDVQS7sv4X
         P95BcY7G9OCC/Xk1N6fM2T9dYKZ1P43Yk7bKz+pJugE1augnNVPevqRZqJA2NBwxYApE
         jtfPqeGxG64zxNe36LF3qaSB7iNqJmNBCjjZfcipqcf7JUnNU4FeurlB3M8GdgqWpSgv
         VAqoYK7Bf1JxXSU5fCVE7YbrzYHL+rRVjJ/7iMSXRUsDu9uIVvIRGR5aje9MHmUXcRYf
         yyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WS72j8JGEqSGj9q0ZTN8/hogbbsFfe3+nSh2IPUnrHM=;
        b=BjmxnR4gX4hZp+ySPvXNOP7IhvCskIGUrFMDQdTXgcI2HmwXFlhmsO87zgVBQ+UBiP
         FYhEkHeer1/fMTUhB9teVzYmnZyZlxKhZazUyy6b4depx+kdYpK12r/09IRK1SbbL5Ww
         rSPHyIJERpOFLR2HSR5GZFdmdI8lUo0yw+9sNVa6C6HzJ+gHWGMTVLXinMyp7daI3iqN
         VEjn4hVyKYEQIj8l+rPGtAyIUJE9NV8mGA21B1xONLxltm8IcjJzZycGBdira2BDNron
         xGsrDhtqWL+4CVW1degi0PT8rjzKaimRF2Rk1/Z0A4RHm6IxUcHe0EmuuFAjaCVlAeyx
         bf2g==
X-Gm-Message-State: AOAM533ZAlTKubLQm7WH0j7GjE4A/UCsGd9NntxlHk1BTIUKBuoDxEbr
        yfCbTDfy8VqDmf4TMyCt1eymoA==
X-Google-Smtp-Source: ABdhPJymqOHDU/O5GwR9SWRCLZ93mX/T9+BrEsocE2xA+xU1VGzCeUpWe0sJAURwL7IwfPAgdgNeyw==
X-Received: by 2002:ac2:58f0:0:b0:41f:b7ca:eb79 with SMTP id v16-20020ac258f0000000b0041fb7caeb79mr11454324lfo.221.1646754388974;
        Tue, 08 Mar 2022 07:46:28 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t10-20020ac24c0a000000b004435eefa4efsm3531093lfq.269.2022.03.08.07.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:46:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH] power: ab8500_chargalg: Use CLOCK_MONOTONIC
Date:   Tue,  8 Mar 2022 16:44:25 +0100
Message-Id: <20220308154425.296308-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
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

The HRTimer in the AB8500 charging code is using CLOCK_REALTIME
to set an alarm some hours forward in time +/- 5 min for a safety
timer.

I have observed that this will sometimes fire sporadically
early when charging a battery with the result that
charging stops.

As CLOCK_REALTIME can be subject to adjustments of time from
sources such as NTP, this cannot be trusted and will likely
for example fire events if the clock is set forward some hours
by say NTP.

Use CLOCK_MONOTONIC as indicated in other instances and the
problem goes away. Also initialize the timer to REL mode
as this is what will be used later.

Fixes: 257107ae6b9b ("ab8500-chargalg: Use hrtimer")
Cc: Lee Jones <lee.jones@linaro.org>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_chargalg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 20d6b29cc9e2..c345d5e99118 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1780,11 +1780,11 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 	psy_cfg.drv_data = di;
 
 	/* Initilialize safety timer */
-	hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	hrtimer_init(&di->safety_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	di->safety_timer.function = ab8500_chargalg_safety_timer_expired;
 
 	/* Initilialize maintenance timer */
-	hrtimer_init(&di->maintenance_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	hrtimer_init(&di->maintenance_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	di->maintenance_timer.function =
 		ab8500_chargalg_maintenance_timer_expired;
 
-- 
2.35.1

