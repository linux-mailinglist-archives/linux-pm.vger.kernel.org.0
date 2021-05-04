Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21DD372FEA
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhEDSti (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhEDSti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 14:49:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB7C061574;
        Tue,  4 May 2021 11:48:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n84so6109029wma.0;
        Tue, 04 May 2021 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzlNEhJ1uZspc9o+iSF+f7KP6K9qPrHK+2KHSvJBLhk=;
        b=Mziraub34Z3rH7N+20S9LqYW4EBqc3uozvRmCxaoZL5i7leqEpmIM8ynSfQ0HKoBQJ
         gaDuuV0jPosshjx//yzfYN0S95KanupHsFDPsQczUGye167JOEYG7TmUoNWhJ0lfwW2W
         6KnZp/MYrj1MJ+IDZU3/WEjrf5ZLoQMlhvnvOH/DXYzqZMqenvBTHmFoLTWz9O21i94W
         Td7VTwP4SGQcWIsLOi8fqxcGOt6wzI3HrUSqOK+js1wKF3IeRLB7oCUbiEakKaX2rXup
         vLkBwwJ2/LdYxVZkeBdBvo+1JDpfwU6zWeOIrT/XR+DohXjvLSe4xHUI8BRLdcs+kN2d
         l3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzlNEhJ1uZspc9o+iSF+f7KP6K9qPrHK+2KHSvJBLhk=;
        b=LISJpLwEkoQ32yy+RmUxNf+RRHEtdAZcGkr1Evzlf3kMJ9ZBTzijspAOEoIqnKbqRN
         Lgu6gHl0ixoBlMKRQNYo8CY+kq5ETsuXi+CofGfsVWUfGlCqoIhGENhh5s2JfTfhnJJ5
         ykTlgMy4ySa2V5y3H4HdYQgU6EXzl8U1Z1021P4yt/xsWGd881QjsXz4b6xjeyY1ZfD9
         2DBlnsmmjTxsmRGml743Y84g612O4JPjYuvU1dqkpzyLztJKIwbG6VO//pY+6LAQmtDO
         M022DcbLYMqOPzHEGbLuhusTNtGW5Om9lBzWE8MFetrUDdPwZHdf3WzyiJrkny10tTke
         8GjQ==
X-Gm-Message-State: AOAM53108RVX3Y3PnEZzi8YWR1CwI130BwQZ0YZFQorfEMXr49il299U
        B9Qf3PMgeWhsSGJ4xEjnwkaV5HDqM9c=
X-Google-Smtp-Source: ABdhPJzrnJB7AGpUZvD2iMKacBUq444P5XgYxl6tEaEFLfGsi/2Xc4fx7A8rkXvGmGf1/YEUu8/W8w==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr5823494wmn.82.1620154121489;
        Tue, 04 May 2021 11:48:41 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g11sm16611508wri.59.2021.05.04.11.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 11:48:41 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: surface_battery: Fix battery event handling
Date:   Tue,  4 May 2021 20:48:13 +0200
Message-Id: <20210504184813.3414376-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The battery subsystem of the Surface Aggregator Module EC requires us to
register the battery notifier with instance ID 0. However, battery
events are actually sent with the instance ID corresponding to the
device, which is nonzero. Thus, the strict-matching approach doesn't
work here and will discard events that the driver is expected to handle.

To fix this we have to fall back on notifier matching by target-category
only and have to manually check the instance ID in the notifier
callback.

Fixes: 167f77f7d0b3 ("power: supply: Add battery driver for Surface Aggregator Module")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/power/supply/surface_battery.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 7efa431a62b2..5ec2e6bb2465 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -345,6 +345,16 @@ static u32 spwr_notify_bat(struct ssam_event_notifier *nf, const struct ssam_eve
 	struct spwr_battery_device *bat = container_of(nf, struct spwr_battery_device, notif);
 	int status;
 
+	/*
+	 * We cannot use strict matching when registering the notifier as the
+	 * EC expects us to register it against instance ID 0. Strict matching
+	 * would thus drop events, as those may have non-zero instance IDs in
+	 * this subsystem. So we need to check the instance ID of the event
+	 * here manually.
+	 */
+	if (event->instance_id != bat->sdev->uid.instance)
+		return 0;
+
 	dev_dbg(&bat->sdev->dev, "power event (cid = %#04x, iid = %#04x, tid = %#04x)\n",
 		event->command_id, event->instance_id, event->target_id);
 
@@ -720,8 +730,8 @@ static void spwr_battery_init(struct spwr_battery_device *bat, struct ssam_devic
 	bat->notif.base.fn = spwr_notify_bat;
 	bat->notif.event.reg = registry;
 	bat->notif.event.id.target_category = sdev->uid.category;
-	bat->notif.event.id.instance = 0;
-	bat->notif.event.mask = SSAM_EVENT_MASK_STRICT;
+	bat->notif.event.id.instance = 0;	/* need to register with instance 0 */
+	bat->notif.event.mask = SSAM_EVENT_MASK_TARGET;
 	bat->notif.event.flags = SSAM_EVENT_SEQUENCED;
 
 	bat->psy_desc.name = bat->name;
-- 
2.31.1

