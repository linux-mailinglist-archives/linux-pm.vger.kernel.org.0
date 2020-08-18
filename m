Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0D247E71
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHRGaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgHRGaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 02:30:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E7CC061389;
        Mon, 17 Aug 2020 23:30:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so9474758pfd.1;
        Mon, 17 Aug 2020 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4QHL6A8uyFKbDV2P19zFKn9zEQqqmFB/XApBSU9BFw=;
        b=W5b/Tfm0+LD9Z7cvao+vMTNs9ijNvX7eXiw9ZsZ/7TGir/QSEaMH65fRi3PbZY7TUo
         RYENSmFLiLWoLgg06zUoCHo3PhEYejSAhdyujGtoWZrYXfHmNjrycZ4kk/mu2KaSspaU
         dNmEUQnnB83A3TdVIVXJMjCt0pajG+gbk67LVdM7qufEB6RXDBM4b+gtAGUXlhEY01x/
         YR/2UMmLU5obRUsA+3hfRcgcbuCN8ChlBl1fNxsmFRnUjNyp98hqzB8btOhclU+gqjeX
         kR5BllY6FvJckr5H19WeKKpZxaRN8EBdFf1wPdHEsN28QKT9wgI6UHnBsbynSNtdMauO
         4v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4QHL6A8uyFKbDV2P19zFKn9zEQqqmFB/XApBSU9BFw=;
        b=ejwOfQxJ59yYQ3SYqz+wRYnfmv6iIe8GyxQhO5iTvZ1eS/rXc1WWs58F6OaJT+kpW0
         VIPxkEEIvVZERaIP6VIx3913SzFmUrNCMbReOKZIGH16yu2htG18j8LmLxOk+KvtEOad
         Ke/LDYcpfIsSlXC0+mQibBCmW2pUh0VTIRi5RlTq4umOLxNULpqh+xDtil4oUJExnP3z
         C3ObBjAKhIRg4PN88S1UqHoeMwap37qllOZchseLzer1xTgI1JuJNFm5Wz2pkXTE7g0g
         MTC+muTQLSKtPvkTujKTY1C8+dQV8k7sOAFXH328EQzl3a61Xis2j94t+2R2gJTlmrZN
         wccA==
X-Gm-Message-State: AOAM531XyGrB0eSq3Zj5n2qS8TzJbYDJpihf7R5p3Ambwrt/s6lpa3gq
        Yz7+rOGcqK4jYKaDJWdeVkM=
X-Google-Smtp-Source: ABdhPJwbqB7FRtldYEWCEwLz0lnKf/pdK1wAl2llvb5R0ejJ/742o9gwl5IRmSTx+MNxi8KBz8Hirg==
X-Received: by 2002:aa7:9a1c:: with SMTP id w28mr10809351pfj.116.1597732214919;
        Mon, 17 Aug 2020 23:30:14 -0700 (PDT)
Received: from huyue2.ccdomain.com ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id f6sm21532959pje.16.2020.08.17.23.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 23:30:14 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] thermal: sysfs: fall back to vzalloc for cooling device's statistics
Date:   Tue, 18 Aug 2020 14:30:04 +0800
Message-Id: <20200818063005.13828-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We observed warning about kzalloc() when register thermal cooling device
in backlight_device_register(). backlight display can be a cooling device
since reducing screen brightness will can help reduce temperature.

However, ->get_max_state of backlight will assign max brightness of 1024
to states. The memory size can be getting 1MB+ due to states * states.
That is so large to trigger kmalloc() warning.

So, let's remove it and try vzalloc() if kzalloc() fails.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/thermal/thermal_sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb..9bae0b6 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
@@ -919,7 +921,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
 
-	stats = kzalloc(var, GFP_KERNEL);
+	stats = kzalloc(var, GFP_KERNEL | __GFP_NOWARN);
+	if (!stats)
+		stats = vzalloc(var);
 	if (!stats)
 		return;
 
@@ -938,7 +942,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	kfree(cdev->stats);
+	kvfree(cdev->stats);
 	cdev->stats = NULL;
 }
 
-- 
1.9.1

