Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29F2E0E1D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLVSME (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgLVSMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 13:12:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A1C061793
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 10:11:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so15429140wrb.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GL5aY/W2SVxnORwgM+Hn8h/zHwFy35a3ciduRd4uE84=;
        b=FlVE6nftUwDWVsheKFkSpCEnBr8DDum+VdgxgfRSCTndL4/2yzAwiK85Ur56cKMpoN
         5dyWQM2T90Toszm/9cJFBicr0y3AAwCf4EXkA73q0419va8lSPG4d8MEUO9nJjCOD43Z
         23RNgDjNlqMid7GhfYiA5rvZyplWHXVDrARjoBUUfzKUy5GNroAMlVkwFKS10cWdgPLR
         Ew3mR8TrNuHjrcL3ERvndmV/xWwS3LQtDPQwd3Oa9rIaDYKiwyJhnM5x4pikgUwkDjr8
         lfQ6xxLT4BCIxwJyUv0QHrf/mlhhlABm1jCKjNa+WYoB0jmlGPcKcru9dlGjKKKo4frR
         HAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GL5aY/W2SVxnORwgM+Hn8h/zHwFy35a3ciduRd4uE84=;
        b=iLeNoSXpJtu4n0hc/wHx0JP7FMHqQZFGYf26cfD9Io+/Tu3KzqgvM5R0yEWyaSQh9V
         V9IsNnKnn9/bEe2sjBqT9JVAe4Krd/Hl/R2F0lKKfb68lqHFa3uO7q9li1Gd/qYvVZ5v
         YIlxDHolWoRvoJ7X8TDL+ABASVgtBuufCRy9gJtj/IInWsK/pJqescmfU0ugFLShdGUw
         5g6PYzzcoJORYurOEtt91mIOLcGUGAtuv66qcJMyOtEA/9zJYZVkZ3b1FPqJcu8yWHJk
         uMBKcVzf6w4cpc4fKroMdPZNykkWQ2TJ42Pas4JF+ys9RJjcfxwAg8I6ouwgYaGmVkB4
         uM4g==
X-Gm-Message-State: AOAM531qCkR53BQsrde1z5iWp7qabaHzFuMoouf4nzwSOOQNgyjKB208
        PA1JUPnuWua3nd/UsKuyQBrktA==
X-Google-Smtp-Source: ABdhPJy2+jvNUrTWqKfKRtorkV012kYBn/klQ3Zwv/Ui95vg6MVOXZ3FFu6vq0yZ0EDayaOUzSLmMw==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr25183984wrv.93.1608660681758;
        Tue, 22 Dec 2020 10:11:21 -0800 (PST)
Received: from mai.imgcgcw.net (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.gmail.com with ESMTPSA id m8sm28061971wmc.27.2020.12.22.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:11:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Remove pointless thermal_zone_device_reset() function
Date:   Tue, 22 Dec 2020 19:11:10 +0100
Message-Id: <20201222181110.1231977-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function thermal_zone_device_reset() is called in the
thermal_zone_device_register() which allocates and initialize the
structure. The passive field is already zero-ed by the allocation, the
function is useless.

Call directly thermal_zone_device_init() instead and
thermal_zone_device_reset().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b2615449b18f..996c038f83a4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -478,12 +478,6 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static void thermal_zone_device_reset(struct thermal_zone_device *tz)
-{
-	tz->passive = 0;
-	thermal_zone_device_init(tz);
-}
-
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -1363,7 +1357,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	thermal_zone_device_reset(tz);
+	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-- 
2.25.1

