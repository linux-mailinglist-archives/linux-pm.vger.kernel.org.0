Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FA22FCAF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 01:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgG0XKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgG0XKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 19:10:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0641C0619D2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 16:10:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so6461422wrm.6
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X+XgM3FnODj9118Te+p3joAjz7Jojf3SmbRCLLwhj1Q=;
        b=SFtaoChSIVBjn4GTxMr4LGqSJOcKGWnGwvCGbiqriyC4uOo8+dg9nmzgnPtRC7FTRh
         uOGbq3CCnd65nlR6sebeY0KzR9HYLloLLafgHKrURUl5gNbcmWUZ31YCxLBnxm5WGvk/
         I38E1IgL8ajV5rbM+SaB3Lr5yeWAwUctBsMx9TyiU8VAcKCis3jkYV1zps4UsuvBYTlK
         Q92nrF0djoq5tfDcCkk9WxR4m6r4+O36HUTR9KpuyFQoKyPHggmVP7Vqz+rk46tcdIqR
         hPW06x8x4/IQ/rQ3F1Jni60zOpob1/c/qtAVNTG2ItvtEOlov78ckaEwr6i3zu0wl9M6
         BCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X+XgM3FnODj9118Te+p3joAjz7Jojf3SmbRCLLwhj1Q=;
        b=Cyh7JbUd6SS4/fIAgArd+8wXBr+vXQ8gnxKGtGCTjGIeKX2wGdiEJq9DQSANCpqw1L
         O7rWGvQX0dA3QDDeODoaFx9To/NInkEQEl4REljYtg2m/yk/xQhryIccxBiOLpx7k6BR
         G3UjBPdUuPmh6k+kT9B932hsnV+0uLd1It/QYPe0SSjoVCGX1HHeGyYMetrc3XhEBDs0
         wxetkSDycgt/hTgsb2SDf+rnzojgBwPCJBwEJGTSzhOJwMpUKAMvVnMMJKf23w/gRPS6
         Cu+DaTDpRqEVCs3WVQ2v4ccn/tFk349zAXAYyf4PcKpJkzDXUhv/F/R9XgO7ddJ0dIqJ
         NQig==
X-Gm-Message-State: AOAM533WjNQm6S4Mansn25HwUIt/Kw/yPBeSfH+4YoH/dK03FWbugwA3
        GuP040j1YFJUkVn7lRkbWXbaPQ==
X-Google-Smtp-Source: ABdhPJzZtV9IgcG34Ze8qQEdH3JL/CHLSiUvr9gZK/tVTWdYSUBgWbvgaxwCLT+zt2eZxNxYi/SrlQ==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr16540345wru.423.1595891440468;
        Mon, 27 Jul 2020 16:10:40 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id w14sm14238251wrt.55.2020.07.27.16.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:10:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@linaro.org, andrzej.p@collabora.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com
Subject: [PATCH] thermal: core: Add thermal zone enable/disable notification
Date:   Tue, 28 Jul 2020 01:10:33 +0200
Message-Id: <20200727231033.26512-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now the calls to enable/disable a thermal zone are centralized in a
call to a function, we can add in these the corresponding netlink
notifications.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9748fbb9a3a1..72bf159bcecc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -509,6 +509,11 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	if (mode == THERMAL_DEVICE_ENABLED)
+		thermal_notify_tz_enable(tz->id);
+	else
+		thermal_notify_tz_disable(tz->id);
+
 	return ret;
 }
 
-- 
2.17.1

