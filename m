Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680872A7A40
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 10:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgKEJOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 04:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgKEJOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 04:14:42 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFAEC0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 01:14:42 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b12so495522plr.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwLa055BkHU9dTWCUTcnkXH5JjkLSC8HIhnffeY25Zk=;
        b=EepgRQDItwjh7SX279QAYnNLCMrLVZ5BJlsaSQt57Lwo228weAronXHiYtRQ74yV0r
         IhL1PETBFhP4A3lgC4WsdbtvfIOi9+Rj7swepTNR5hk11luy/+ADFA5Xn1IC/j4/SYkU
         MD0vRBLtv7uRaVFBHubPhF2XeXpgIPoeZ2WZJGqKzq8SVBozNS1N2Ke9JaSqQe0Wg3Yj
         dbAwzWosR2w5qjFPdxEEUrIELS0sGLcmgNJ7nLpDV5/qgHtMY7XvIY0V0HvINACFE7U/
         s8hM1/EPJRV7RBzgft6gj35HZnK5UKRPQ4cBuXHvjsa5cexFtox89d80oa9w2ZeHVjJU
         Y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwLa055BkHU9dTWCUTcnkXH5JjkLSC8HIhnffeY25Zk=;
        b=qcZ2p6eY2RF0zqxsBkd5wGqpixhGu23xyeZ3IFOgJr+e8w4SrORPk/P1hxUqRMMePO
         DnjD5ut0syVvKVbQoCZWfSQhfZL/xZ+M0UWdQ4tkdV7ssKhAB5S1QRDI8he3hyud9BMY
         zOOnKLzqxI5MjNv88cD4Rpx5lbfAURebBioVhu20uSXX1k4FmE69vJyOTX+trvHBb6m6
         hRXvhSBSO8L7wOCyFA3YX65unX/XyO+pOR182q2kWje+Fclp4XqotXXko8QXcpQyep/I
         NTNL165/ctIIACZ7UFtS0EZlnWYSgHPCxjTEPAwk5QtmdS9eWMNcayAWx7fHNAQ3diIp
         6Uww==
X-Gm-Message-State: AOAM53177QN5/HpwyaV+ZcHoaKS06YKXYTtPoLccnKBbfp0KgkE9Ht6X
        XYsGWEseeQ6bDjQaTTPPqaZ2GQ==
X-Google-Smtp-Source: ABdhPJzLN0DR/Tyg3X3jh6GJFxrnSziZI7/fQNDzC9lVER5hGyEjzo5mwj/zv6Hk3qtRcjl566dwvw==
X-Received: by 2002:a17:902:9347:b029:d5:d554:9922 with SMTP id g7-20020a1709029347b02900d5d5549922mr1605449plp.56.1604567682333;
        Thu, 05 Nov 2020 01:14:42 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 92sm1593107pjv.32.2020.11.05.01.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:14:41 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Rearrange thermal_zone_device_set_polling()
Date:   Thu,  5 Nov 2020 14:43:52 +0530
Message-Id: <c024f35421c67d7b1a3a20bc280fb5131ce6db43.1604567599.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rearrange thermal_zone_device_set_polling() to make it more readable and
reduce duplicate code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..7dfab370a369 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -291,16 +291,17 @@ static int __init thermal_register_governors(void)
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
-	if (delay > 1000)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 round_jiffies(msecs_to_jiffies(delay)));
-	else if (delay)
+	if (delay) {
+		int time = msecs_to_jiffies(delay);
+
+		if (delay > 1000)
+			time = round_jiffies(time);
+
 		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue,
-				 msecs_to_jiffies(delay));
-	else
+				 &tz->poll_queue, time);
+	} else {
 		cancel_delayed_work(&tz->poll_queue);
+	}
 }
 
 static inline bool should_stop_polling(struct thermal_zone_device *tz)
-- 
2.25.0.rc1.19.g042ed3e048af

