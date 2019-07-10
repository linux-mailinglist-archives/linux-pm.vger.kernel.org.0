Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A24645E1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfGJLqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 07:46:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45324 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJLqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 07:46:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so1097717plr.12
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7GcSL06EKocZd6MAQEqpVHgYClPW57nk4fTdNrfLes=;
        b=XQEtbqgI5cgEJf0rZPJ+RHECruns4dgTgAsoNFnDCAeOtr8qshkl1bxYaOmDTI+7Tf
         08hxYyOWtxGv+GLwRdpl9Qa9wqEiMnY3yViyXALarV/xYLol5P7O4R4evCbtL+rJcwk+
         ZksC3NWSwIftzuXX6zvV6wWc0g8CsClMQ/SC2aMm1tNrO2W0HdGXgXgcIAX5KPxlWN2I
         bzGd3we/6D/5K2LQ9r+HsGZURomaGJcmE2TQSgljwmy4HhIgBoEQ8W1dIQqVAxEOPQXb
         XFP2eJokrNakGV7KgMOMXDfa0AX0RBwuPtFS5c8ycWgDErNnqGlJn8X1XAzsmejFE0Se
         /UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7GcSL06EKocZd6MAQEqpVHgYClPW57nk4fTdNrfLes=;
        b=XzrSImvb97q3Ty6uzDLhkkppwHj3piZaJ7EWavvJJC6COF31RcIRykyVMdK6bYxqdL
         xJzg+T2UoawgPciVk7Z8qeXxYu94AxtEZ8iSHtVrYguIpPdo89swSAy38iAj2azY5mdQ
         0nO+lNW8wLkTY7qt5vxb4872RD7Fz02SJ4soQ9IJj0/LCuNJhh1Artfa4e0Z3uetojIO
         4zJOKcw5sc+7ww4N1pNsAIGCEzhmcpg6GiKq1v+FmaRbLwNmLwL8PzomOWtqt6b12kyS
         95xcJlvCxFPvikQAN/nc5gku8OKnL2ZOeEEK64GGjEmeEDl/hsbeHDSvrLKsir/1m+ne
         xVXw==
X-Gm-Message-State: APjAAAXcsEXx/XJ/X6Jp/oZsGMwRxzuV9gO1iJtfzaVG0Vjgy+kTLUMw
        dhI0ANtOsOllmk+bzRhYEWwpCJDB7vERHA==
X-Google-Smtp-Source: APXvYqzwx+8EeHFffEXIFvoFOuecP4rBXizBq8vsKL6k/zuNVRpPi1MPCP7rAdrxe5n40/Df5lW9xw==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr39014082pll.310.1562759212947;
        Wed, 10 Jul 2019 04:46:52 -0700 (PDT)
Received: from localhost ([49.248.170.152])
        by smtp.gmail.com with ESMTPSA id q63sm2602413pfb.81.2019.07.10.04.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 04:46:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Add some error messages
Date:   Wed, 10 Jul 2019 17:16:47 +0530
Message-Id: <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562757659.git.amit.kucheria@linaro.org>
References: <cover.1562757659.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When registering a thermal zone device, we currently return -EINVAL in
four cases. This makes it a little hard to debug the real cause of the
failure.

Print some error messages to make it easier for developer to figure out
what happened.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 46cfb7de4eb28..95c3a4c649cf8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0)
+	if (!type || strlen(type) == 0) {
+		pr_err("Error: No thermal zone type defined");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",
+		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
+	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+		pr_err("Error: Incorrect number of thermal trips");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (!ops)
+	if (!ops) {
+		pr_err("Error: Thermal zone device ops not defined");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

