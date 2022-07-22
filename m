Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661CC57E7BC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jul 2022 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiGVUAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jul 2022 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiGVUAe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2022 16:00:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C2747A9
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z13so7862520wro.13
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2022 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=fvyzh6EwYLnAPYw9qRlgMfMJC9tpW5CB7/eX86RxN3Y09XauD2TDaxWKmQ0Vxjg3Ws
         HwuAcj6GIEirkvPYqBbFmyGXNwq1ZLZIp8v+zvXz/8GWX01twz/eerkniNsnb5n2pMUQ
         avnbI6OryCNePF3Z5wa80niBQm+j7meeayyHn4LZXmu36PnpWYjWGkMng1/Vp72pv1D0
         sNOa0k6eElXcL41KT4jJhMJwZj9vwbCG2Ve8wZaTtIPE7YVyS4xQWm4QxgFDe2mNEa1I
         gtyb9uz7F2fkDdRrtUjc7nv+m/XSU2Iz/ILbUbmAUlo9UZUZuY2dHKkBTmSWdUvDT0bf
         jM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UKKS5f7QbJpxlk+iXwxbcq70b7aqG7EJc4B5ZEy8YU=;
        b=EW08iork9thhfWc8JomkMjYPl95BNxPqD4CIWBEataXRenP/qMWUSzykSvQ6m/qGMC
         6tLPaRuvKgY5NI4EL5isGzpBjtrgjB0CemXTZYRhyR2jAATLX6s3aKhHTS4pys1Y/icO
         X1WyDJbX4Wy3yFhD6OOUPfYiWzTpACffpAP5DqycIT/QlCtNU1BRiz5aRvVbruVvIgRH
         YUxMcdCGhhVfuO4OJkTYB8Yk4DHvzNTVUqOL53mFstMVFZatY4LKW2H3vT9AAN0AQcxU
         7BvKz0WE2YvFYkXEi2vO1Cy1qMfNT68l8mT9T0w5RR33/KTXCha79VWo2RU2OlDzPza1
         oC+w==
X-Gm-Message-State: AJIora9jGmF5UboovGfPNU1uNuGzolfhZvuwHrypMBYehqmTpfigrtNs
        4f8iwj3F3llNAJDyDOfEx99Z3w==
X-Google-Smtp-Source: AGRyM1u1XAz+2HpKZbt7QaNpruxsbTp371HvHRAil253bJP2l772ZNkuxuoohMs/JPs+6KyWlqyYDQ==
X-Received: by 2002:a5d:538b:0:b0:21e:4b08:7474 with SMTP id d11-20020a5d538b000000b0021e4b087474mr909649wrv.465.1658520030644;
        Fri, 22 Jul 2022 13:00:30 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 01/10] thermal/core: Remove duplicate information when an error occurs
Date:   Fri, 22 Jul 2022 21:59:58 +0200
Message-Id: <20220722200007.1839356-2-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pr_err already tells it is an error, it is pointless to add the
'Error:' string in the messages. Remove them.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..e22e7d939c54 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1198,23 +1198,23 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
-		pr_err("Error: No thermal zone type defined\n");
+		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
-		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
+		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
-		pr_err("Error: Incorrect number of thermal trips\n");
+		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ops) {
-		pr_err("Error: Thermal zone device ops not defined\n");
+		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.25.1

