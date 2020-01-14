Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52513B2AA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANTGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45731 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgANTGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so5586242pls.12;
        Tue, 14 Jan 2020 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bUI3dxAJmLbR2verpuQbHht/NnNgFc4Xm8emQetKLeY=;
        b=H9zkXg6jxTLY3Zf994WcfVL5r28Y6dR2Q/ybE2c3Pi4qGR4BhL9EQpP7HqLnUNzOYC
         FLZAhk3XvPUAy9TUjqZvHJH2n55NqnaycqLyKThGj7c6im+6KTrl0Z6OG3xIRZPfrVKn
         nx84xIZWKJQeOS3ysCePa31x+8S3tqikkbkAksyShUdp/TnewAhU74/OfhbPbWXYd3a0
         vfLOeFtIrTCcU1CaxH9/s30yHznb3jZQOlv4BNqipoJ/R7SasP5dZxbsluPD9yzZjH9f
         cl/WuLgExWG9lJf1Jpf4pTm4ZsIZjpemmYa2Bi/9No866yj+TzOSHlQHe2LVMTmU7Uif
         5ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bUI3dxAJmLbR2verpuQbHht/NnNgFc4Xm8emQetKLeY=;
        b=p70jvMQf5gWtaXWNadH0b12piZ4v5DmF1rEMkNx8uNw8pw7Bm5uqjd5usmVEqK8Q/P
         zLbqpN3nVVrCVLTw0FIbeX9y3TzxOw3DxHx4D0eWnN7C0kKg8bMOZbzdrCi2krfTuNf7
         dpT6q74d+r0IOONwV5q76rzOknJEKBv3SaI7hIjUY6Ek5S2UbMwZORw5dy5y/cqlBmUL
         rzu+hNDNFlDx0QohEfY1HmXz+IH2ZfwV78OWOxaQ3s2tMyE/c3rEiMvhxTaWHP311/oZ
         2lYUCl0YuaGe9R8CtfZ7tJ4kNKRcEFtUgilcTBWKAVASjQT7gFrI6TGTBZ9ok4ZrY/h/
         Jwcg==
X-Gm-Message-State: APjAAAV8AOMIYJncyww7OP5fAg5e2GCoxm2WtbJOSWz3tPJEdFk8yLdk
        r1dsZtOJL64G1fKqRBFjpJlfOZOg
X-Google-Smtp-Source: APXvYqzaeyStl5zxy5XUEqSmclev0JfVwR009tJs/43CxE4oEzpicozRzjtH2tejfJTVfAa+Osvy/w==
X-Received: by 2002:a17:90b:30c8:: with SMTP id hi8mr30814632pjb.73.1579028784213;
        Tue, 14 Jan 2020 11:06:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
Date:   Tue, 14 Jan 2020 11:06:02 -0800
Message-Id: <20200114190607.29339-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At the time the brcmstb_thermal driver and its binding were merged, the
DT binding did not make the coefficients properties a mandatory one,
therefore all users of the brcmstb_thermal driver out there have a non
functional implementation with zero coefficients. Even if these
properties were provided, the formula used for computation is incorrect.

The coefficients are entirely process specific (right now, only 28nm is
supported) and not board or SoC specific, it is therefore appropriate to
hard code them in the driver given the compatibility string we are
probed with which has to be updated whenever a new process is
introduced.

We remove the existing coefficients definition since subsequent patches
are going to add support for a new process and will introduce new
coefficients as well.

Fixes: 9e03cf1b2dd5 ("thermal: add brcmstb AVS TMON driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 31 +++++++---------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..680f1a070606 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -49,7 +49,7 @@
 #define AVS_TMON_TP_TEST_ENABLE		0x20
 
 /* Default coefficients */
-#define AVS_TMON_TEMP_SLOPE		-487
+#define AVS_TMON_TEMP_SLOPE		487
 #define AVS_TMON_TEMP_OFFSET		410040
 
 /* HW related temperature constants */
@@ -108,23 +108,12 @@ struct brcmstb_thermal_priv {
 	struct thermal_zone_device *thermal;
 };
 
-static void avs_tmon_get_coeffs(struct thermal_zone_device *tz, int *slope,
-				int *offset)
-{
-	*slope = thermal_zone_get_slope(tz);
-	*offset = thermal_zone_get_offset(tz);
-}
-
 /* Convert a HW code to a temperature reading (millidegree celsius) */
 static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
 					u32 code)
 {
-	const int val = code & AVS_TMON_TEMP_MASK;
-	int slope, offset;
-
-	avs_tmon_get_coeffs(tz, &slope, &offset);
-
-	return slope * val + offset;
+	return (AVS_TMON_TEMP_OFFSET -
+		(int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
 }
 
 /*
@@ -136,20 +125,18 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
 static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
 					int temp, bool low)
 {
-	int slope, offset;
-
 	if (temp < AVS_TMON_TEMP_MIN)
-		return AVS_TMON_TEMP_MAX; /* Maximum code value */
-
-	avs_tmon_get_coeffs(tz, &slope, &offset);
+		return AVS_TMON_TEMP_MAX;	/* Maximum code value */
 
-	if (temp >= offset)
+	if (temp >= AVS_TMON_TEMP_OFFSET)
 		return 0;	/* Minimum code value */
 
 	if (low)
-		return (u32)(DIV_ROUND_UP(offset - temp, abs(slope)));
+		return (u32)(DIV_ROUND_UP(AVS_TMON_TEMP_OFFSET - temp,
+					  AVS_TMON_TEMP_SLOPE));
 	else
-		return (u32)((offset - temp) / abs(slope));
+		return (u32)((AVS_TMON_TEMP_OFFSET - temp) /
+			      AVS_TMON_TEMP_SLOPE);
 }
 
 static int brcmstb_get_temp(void *data, int *temp)
-- 
2.17.1

