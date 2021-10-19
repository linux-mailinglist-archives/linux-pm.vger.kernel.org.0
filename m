Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08B433C64
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJSQhf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhJSQhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:37:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B098C06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 09:35:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4015339wmz.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=goeAxY6VmGCgCRvdus1WGmsm0JBbAmio3aubFOTGKbw=;
        b=qeHGvpSDyNQqJdm2AmtQXasO76AGIjS87PPJJuVJGWuq92jcPARXqp7MLjME+fspWs
         jtDBUdZ8XOXED3ASVkoGhcqZ7u2SbBphpDCS5SJWMiNvL1GS0/fW7IX3f97ssMxRC6Qp
         s29EHvyFExobD5R2vUdIsYHx9/o9blxVf3L3YiK1HtjqvCsjOBZt9dCl3Y/QxQ8kuX7Y
         gEuhpF/10DUIQvXAL+RjzC8OHdObNB+HAKTuhEAfEmZOWlQdF7M4XH14bt2p/G5mf5UR
         olJPQ6jFyIP2y7LuEyMNi73scpLAHVlTPrMCkldd5eeNXqBcKibkxWcpOCd/X+jNL7VX
         lLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=goeAxY6VmGCgCRvdus1WGmsm0JBbAmio3aubFOTGKbw=;
        b=KTf9kYa4gKk8SKJX1QdZsp+itwHC+nNLskYX0QtjfVS94KLCtd3CaGWvl4Yt6dpCke
         aLORY0/nFhlUVa/8yLedYqTptY7dqjE/EPqVAFBkvIBn/pNjmwl6nlR4KkGt56DHSjER
         l/PS0sew9zP5V7EbDeetnVjdQWakicd4L0ozghd7RLZrj6P5BHFjPy3zKxB+2fV3Um0t
         3sDUMFRiKzE8lMXu3VHGNYXKtlmlgBfUvRA6ie2Vv+15ImsxEHOnTGU/1TbkNj/iVwng
         tDfpXr+q4steHa/u9rsyRFsJto35IRTeEAx+L7Hg1kNamvO6C8F0kPT1b3xhI5z2a2du
         YmZA==
X-Gm-Message-State: AOAM530nC8MuDZsHC/x/jwuOqM2V6kCP9Pdgwoyf6e/C/d/KaYGfRYVZ
        w9vQZX+np1MTHMSsWsgO3QvCFQ==
X-Google-Smtp-Source: ABdhPJwXcBW9oqMddFNVyWlNt00vWahXExfjGsBr5Zmtccj3G9KGWojwfLxYbfxBsqVOkvfdVWe4xA==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr7210087wmi.177.1634661319624;
        Tue, 19 Oct 2021 09:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.gmail.com with ESMTPSA id n7sm15377389wra.37.2021.10.19.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:35:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 1/2] thermal/core: Make the userspace governor deprecated
Date:   Tue, 19 Oct 2021 18:35:05 +0200
Message-Id: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The userspace governor is sending temperature when polling is active
and trip point crossed events. Nothing else.

AFAICT, this governor is used with custom kernels making the userspace
governor co-existing with another governor on the same thermal zone
because there was no notification mechanism, implying a hack in the
framework to support this configuration.

The new netlink thermal notification is able to provide more
information than the userspace governor and give the opportunity to
the users of this governor to replace it by a dedicated notification
framework.

The userspace governor will be removed as its usage is no longer
needed.

Add a warning message to tell the userspace governor is deprecated.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_user_space.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 82a7198bbe71..f4fe050e1cbc 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -15,6 +15,14 @@
 
 #include "thermal_core.h"
 
+static int user_space_bind(struct thermal_zone_device *tz)
+{
+	pr_warn("Userspace governor deprecated: use thermal netlink "	\
+		"notification instead\n");
+
+	return 0;
+}
+
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
@@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
+	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
-- 
2.25.1

