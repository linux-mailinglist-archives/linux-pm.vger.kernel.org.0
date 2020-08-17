Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA9C247B56
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHQX7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 19:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQX7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 19:59:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D13C061389;
        Mon, 17 Aug 2020 16:59:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so19427203ljc.3;
        Mon, 17 Aug 2020 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQe5ZScQDtzUfrz2foLiIf8STnJmMHgr25JkIASCkVs=;
        b=rcg717jprkdOzrqr44VeUZpPY0cfVgH6lq9WPI+5TTUvvBmw4ufPyUj7EaRXy8epZE
         1JwpcKQtZPSrIB7CLj1+/epP3uJE94WUAYPE4ZynlMwudDDIgQ65QPJrHewBr1/gEHp+
         XiWz66Ief2YCtlF1BHc/53Nb7NPR8l7YjkadAOvzAoe3xkO+vI9ibzgxG0UAKG7rDvu9
         3wGJJiVT+kjQmj6mo8R5/Y1U80XNVQKbw0uWLBnIy+c9wqbUWMIFOwMkKpvQEo26afmY
         yUNhUithrTG0O7G4MVQIUzJvYJiHMs00pw9jBDhV6L/Lm0YLQnGPQ3rBoMWOC2wbC5XO
         TAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQe5ZScQDtzUfrz2foLiIf8STnJmMHgr25JkIASCkVs=;
        b=Cjirnu+kUqrIbZgtGFTwkmMTcHA5EPmbGjHsh4IjA1p8zV0Cvz1AYJ2IcI3bwBnoFS
         VejpzLA1lKRcpron9EFYmN5gTAmPA+n1Ni+H27f6fWVXx6QXo54za9hhoDnQaCYg5VqK
         T68TzzyCl2yUyY/drv9PhMvSnQR6Ac8hymMPvR3knxzr6vpefh+TxVTMXg3MW1vm5bGe
         0Z3Y/uNa9ewN4WlAjExVyybd+Vk3yQMEOxgZF6RNRfZcYqSQusJe8KCHiBOgiBa9AIup
         75nToY3T6Risk1VVh3+F/bpvMtjUrlfEbP2uVDC1LfMs09+fp+z/xix2DZ30hzjK5Af0
         on5g==
X-Gm-Message-State: AOAM530oOZSJFh0rDKTAeoHsdR9ttR7yTDylBGYvbMVKE1YTGgqq60q9
        Llg3mHJjlBBLD0bACxwSrnk=
X-Google-Smtp-Source: ABdhPJx9ZLv9dIwMy4XOdlBHoum7oNtiO/pJsyafsioDVNIIn5AbyuV3OqjBfFJKl0oDBgqt/JCoag==
X-Received: by 2002:a2e:87cd:: with SMTP id v13mr9241119ljj.180.1597708744471;
        Mon, 17 Aug 2020 16:59:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id h17sm5396507ljj.118.2020.08.17.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:59:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: core: Fix use-after-free in thermal_zone_device_unregister()
Date:   Tue, 18 Aug 2020 02:58:54 +0300
Message-Id: <20200817235854.26816-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The user-after-free bug in thermal_zone_device_unregister() is reported by
KASAN. It happens because struct thermal_zone_device is released during of
device_unregister() invocation, and hence the "tz" variable shouldn't be
touched by thermal_notify_tz_delete(tz->id).

Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Don't touch lines unrelated to the actual fix.

 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 72bf159bcecc..a6616e530a84 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1516,7 +1516,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register);
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
-	int i;
+	int i, tz_id;
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
@@ -1525,6 +1525,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		return;
 
 	tzp = tz->tzp;
+	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
@@ -1567,7 +1568,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
-	thermal_notify_tz_delete(tz->id);
+	thermal_notify_tz_delete(tz_id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
-- 
2.27.0

