Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F42340F65
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCRUx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCRUxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 16:53:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9153C06174A
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 13:53:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so6944531wro.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ERPynUyb8bk2OjO46Oc7F9PinwfeSmgz5LXVTrsHbvA=;
        b=oZtJyDPfmi7BoXXV4OHaJ/MSEXLIcZirEgjjJhyLvM88sr3ir/mj90pCi3gzJNFPqQ
         xwQAvnHrWlA08k83rQTXc4uAZxoTIhntqFEQnemaiT4qNZ3fVrhQ870gRnwVYulAc69b
         xzaZdptyDcgqEjHOHv8brAdKysNyfNq5ypGKyI0Rc34Tg8rbTebmzJwds8EW40Xj/7un
         5loOzlqt9OA/vc97WVK5qfkhPMTnFzl3NK8btlEeIWrgnNHGYP5aNA1ZoB5I0fFERcXr
         ya+A4N/QJrq2/dRVaadBfdLQWIYGQSXfhbUK7f08ypVHodI+dQykAO58h0WgGSt8sbwP
         vFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ERPynUyb8bk2OjO46Oc7F9PinwfeSmgz5LXVTrsHbvA=;
        b=Y4VcaXqnAfCrHxeKDZJT4HZMOKZI1SQljHLVaXv7cIbK+bFv32f8D19JaDrseV0Su0
         6bnosNRctnq5hWJ92g9Eq3jT/9XIS8A4NtNRXhwykiTgCJtziAKbj6oywVKdbiGyM1I5
         wr6Liypqa7PSMDfFuXN3W/BWjnHR9Qj9hAk+ilA9ED3cjgjABitPjcS5L8q2c6SnvxZ3
         ta5Ll6WK1R2RbdGR/5WXvg8EKxX4jqsxlWljj79L6EEl3qX+rp3vNucxPmBFx3YT93q7
         WrzHRYKU2CfRb/MAdw00LovLwd9XV+zVoItmCCQKP8vZKGFm4/I5BNKvRsyTUcddOjUP
         ECRw==
X-Gm-Message-State: AOAM532mwMtMSGdAMJaXvR2IcWjvZNEDjSJFEjS3F2/epZFc2lL5VWDe
        CfXz68B65QOmw97zkgB4oDIobw==
X-Google-Smtp-Source: ABdhPJw1MCTDEy6VfarjFMKHUY5IR7/UVZGcxGGcu8smC1c6vfd+qf03L19g49bkHT7UWLnC8CI1Kg==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr1099981wrp.57.1616100781147;
        Thu, 18 Mar 2021 13:53:01 -0700 (PDT)
Received: from localhost.localdomain ([82.142.18.100])
        by smtp.gmail.com with ESMTPSA id n6sm5293696wrw.63.2021.03.18.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:53:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap/drivers/dtpm : Fix power limit initialization
Date:   Thu, 18 Mar 2021 21:52:38 +0100
Message-Id: <20210318205238.21937-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a DTPM node is registered its power limit must be initialized to
the power max.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index a4784ac2f79b..2f028776cfa8 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -594,8 +594,10 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 		root = dtpm;
 	}
 
-	if (dtpm->ops && !dtpm->ops->update_power_uw(dtpm))
+	if (dtpm->ops && !dtpm->ops->update_power_uw(dtpm)) {
 		__dtpm_add_power(dtpm);
+		dtpm->power_limit = dtpm->power_max;
+	}
 
 	pr_info("Created dtpm node '%s' / %llu-%llu uW, \n",
 		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
-- 
2.17.1

