Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D248269E1D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOF6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 01:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgIOF6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 01:58:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BFEC06174A;
        Mon, 14 Sep 2020 22:58:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v14so1160090pjd.4;
        Mon, 14 Sep 2020 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zKHrWoVTGjPa0gAt+6GNqC0IOMaRogW2Eu5TIxZhkgc=;
        b=GOEZgWytaQiUKcOp2lQ9L5psHObz+NgNM6oVTtnETPRI2Wgo5Qe/2PNdmyoUKUibYw
         J8r9Svz2AsQBkZrDpk+lTbTV+5kPGv43Nwox92yxIjT5kIM1IUTcBTnQ34luQlgySstb
         QIdZ7wj63nIv20+EzyN+aI7nc3+2UkfwDLNR0XwpukATUD06ikhiY7LNTVnM5KM1nAYd
         v40FEkZ3JkpsgSesYcoQh4DYIQyDm4wc0D/h3JL3okzcE11xdArnCuN3v05nGD6RoPHG
         x6FR5mOKPA9Wwx3gyb+/ZStVUOvkteBI2qBDFb8qha8pkzZTZwnHpPE0vZ3Jh/cOyohH
         f2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zKHrWoVTGjPa0gAt+6GNqC0IOMaRogW2Eu5TIxZhkgc=;
        b=UOctWsMcE2GWfwLJywCw+pubQeHSZ2PZRQ8gTClk90+h8TBGb+byhbGURB76DupdQN
         3gdrKSuaAzzUq1a6BgSFlPuJva7SNmKIo/RFdIlaUuJeUdXICR9C2SUaLBk4uUiP9TyF
         mLQ6oq+/tp5q+F6VjIUB0F9LLN4DWhqUAuANoG456RQY07ik6/IsCidSBjoRJMZ68WEh
         ArcGH3gWM4Ma70M2UsvUVs2oigHqW3tOXc22/DD6FJ+PgY5CCAqOMjrPKSjBwFkY9VvE
         XBmO5cJn84KUteXMLIG089+CpEhcIQBD49PJiCiB0Amjl0nROyVxwMo5teClFYDNr2Mv
         GkzQ==
X-Gm-Message-State: AOAM530eexUBcjBnl0xM8szjZ6dZVOCOVv0rvXBgNoSoTQnyBDYtvnJE
        mUaWJYAuJqykTEOjJTiV0X8=
X-Google-Smtp-Source: ABdhPJwMoOk/pmr2lcxYrV8+7wXRtq4kLV9iWGhzuWQNejRW31MmfybxKTgVneT0FuSGGicpDwTG8g==
X-Received: by 2002:a17:902:7c03:b029:d0:cbe1:e71b with SMTP id x3-20020a1709027c03b02900d0cbe1e71bmr17781965pll.41.1600149533126;
        Mon, 14 Sep 2020 22:58:53 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z23sm12141071pfg.220.2020.09.14.22.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:58:52 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing@xiaomi.com
Subject: [PATCH] thermal: Fix slab-out-of-bounds in thermal_cooling_device_stats_update()
Date:   Tue, 15 Sep 2020 13:58:37 +0800
Message-Id: <20200915055837.498-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

In function thermal_cooling_device_stats_update(), if the input parameter
new_state is greater or equal to stats->max_states, then it will cause
slab-out-of-bounds error when execute the code as follows:
stats->trans_table[stats->state * stats->max_states + new_state]++;

Two functions call the function thermal_cooling_device_stats_update().
1. cur_state_store()
2. thermal_cdev_set_cur_state()
Both of the two functions call cdev->ops->set_cur_state(cdev, state)
before thermal_cooling_device_stats_update(), if the return value is
not 0, then thermal_cooling_device_stats_update() will not be called.
So if all cdev->ops->set_cur_state(cdev, state) check validity of the
parameter state, then it's ok. Unfortunately, it's not now.

We have two methods to avoid the slab-out-of-bounds error in
thermal_cooling_device_stats_update().
1. Check the validity of the parameter state in all
cdev->ops->set_cur_state(cdev, state).
2. Check the validity of the parameter state in
thermal_cooling_device_stats_update().

Use method 2 in this patch. Because the modification is simple and
resolve the problem in the scope of "#ifdef CONFIG_THERMAL_STATISTICS".

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 8c231219e15d..9c49f744d79d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -756,7 +756,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 	spin_lock(&stats->lock);
 
-	if (stats->state == new_state)
+	if (stats->state == new_state || new_state >= stats->max_states)
 		goto unlock;
 
 	update_time_in_state(stats);
-- 
2.17.1

