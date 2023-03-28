Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273536CB496
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjC1DKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Mar 2023 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC1DKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 23:10:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46B2114
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 20:10:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so10383370ple.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679973046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9rtmQf3+/k9brYMpe16mW92eSBX3phAG9+DZr8tElc=;
        b=JuGXT7BWgidqAU+U9NFWmJkcnYoPC6x71wZQlTucGNVG+piuo5sPakfKCZuigoFSjM
         px+Y4vf8GZwNQnHAwMxhFyWA1pJ/A32WcIT58WedWyC9gLDLRe9Q/o8tu0Qb560zZrUW
         yG8VPUBn6X+e/qO69VLkUUlT6I/jjAGJZfIWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679973046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9rtmQf3+/k9brYMpe16mW92eSBX3phAG9+DZr8tElc=;
        b=TOubMmFFMjMMueNx6yyQ+TszfAQ4QB1zp3ex9f5MhuLYzFYXR50bu5QMsHzvB+fABx
         VvdoxPTq9VxQ9bKp+fjzxBZgNjDukuOPAVYC4sx7j+UBx1CY+oXBxWXqOa1XAz3cAEhu
         D4v2esGn63+plKVhQwZM2xv4qCytwQOFFaBpBGAaa0UoAfnRpEHyq2MUwDXg4TSZcRUW
         HIO5oBWiHxkJWHzI4eR3bWOooCGSdy9in3Um17vbh4F4TYs2lb9exQ5gYDyqbuGDohpD
         8QA5sDeD7iA2HwRBs6SVnpwrqIalo44zFyNiC6H37UPBVB1iEvgtz6Sbbk78qdjj/2H1
         FzVA==
X-Gm-Message-State: AAQBX9cV5NrEO+1gEDqGmTjkHbblYp3cO/Sdcs0oZt6M7B8yz5HglE0X
        MB2cjZNUNw1blX/g1d+hetvU6A==
X-Google-Smtp-Source: AKy350Yhy0dWdjNAmaMv84OP2MovOHhZZoppM+d6gBHQlrg7Kw46jgJNOk74uIpr2rEXrRPToWVjTg==
X-Received: by 2002:a17:90b:38c4:b0:23d:2027:c355 with SMTP id nn4-20020a17090b38c400b0023d2027c355mr16148392pjb.10.1679973046316;
        Mon, 27 Mar 2023 20:10:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:da70:de00:9a3d:7067])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902bd9400b001a2574813b8sm1491784pls.278.2023.03.27.20.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:10:46 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: only update registered thermal zones
Date:   Tue, 28 Mar 2023 11:10:37 +0800
Message-Id: <20230328031037.1361048-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's possible for some sensors or thermal zones to not be registered,
either because they are unused or not fully declared in the device tree.
Nevertheless the driver enables interrupts for all sensors. If an
interrupt happens for an not-registered sensor, the driver would end up
updating a non-existent thermal zone, which leads to a NULL pointer
dereference.

Change it so that only registered thermal zones get updated.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d87d3847c7d0..bf59174e18d3 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -415,9 +415,14 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 		if (!(value & masks[i]))
 			continue;
 
+		iret = IRQ_HANDLED;
+
+		/* sensor might not exist (bogus interrupt) or not be registered */
+		if (!lvts_ctrl->sensors[i].tz)
+			continue;
+
 		thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
 					   THERMAL_TRIP_VIOLATED);
-		iret = IRQ_HANDLED;
 	}
 
 	/*
-- 
2.40.0.348.gf938b09366-goog

