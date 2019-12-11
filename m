Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8222B11BDF1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLKUcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:32:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKUb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:31:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so11085378pgm.5;
        Wed, 11 Dec 2019 12:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bUI3dxAJmLbR2verpuQbHht/NnNgFc4Xm8emQetKLeY=;
        b=ru6rpApkxWfLsDVpgRwLBm4hAo2TQvM8KsODhFgI3HwZBxEcNZ5tUFLlmKttn5uwFM
         2BnIPYTi5ylFrBcB8s09BZOmdUoYAJ7SQzUX7QqXg/iBpnqnloIPazKEXMdqVc4bujlN
         Kq08lbQl1wloiSnT8//5Ag0zpIfIBzeqVEgLpz1nNeQTUIRLw3+D+S+CKMEDBPezdokE
         wXLoS6KpgtIHgCaFUTTsBCmQ91mSWrWmkDuIQZR733e6sYdfmrrN10bGqqEW7+OAdsJ1
         ZzuGjMwRMEJfX9r8syaV0xN1yskgFxDejnGZ80dv7+agP88A7BjgumoMFyKNc9Fi3nvt
         pH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bUI3dxAJmLbR2verpuQbHht/NnNgFc4Xm8emQetKLeY=;
        b=cspYKXoO6shyhttB2xZALawBc8C5YfnJmVIZitowV3MtU3lNtAYyDYWWBFDgvCizb3
         yp9ziszzUGWgP4uhQAWaRRxEJxmV29z6/p33WsjDOM6o8IOxg6uxcn5rOpHwxMy1SL/1
         ndm+6Gi9/vIi8LtJZPsTIFlcT+yx5NQpR4SnRJV99Qm9HBCWAGvkbNe9TtFakvD9iJ8M
         5N09TqNI5SnEpAFq2ccarW6eyx4XITDjnesKIxupIW+n9r8aggS1XHmfn8TEtmpi7+oI
         VcnTwy6IVkl4yALWaNN6mqsSitpOqA0VOtKI8t9Am1QiOZ7uqsXEe3VVZ54avEPjwntg
         xN9w==
X-Gm-Message-State: APjAAAXYYhW2LWJdLqI7CYbq3mPBFsBa7OeXhdD8W8/n6GvyfMQAL7lZ
        GYRA0ZWL0g147UhWLCDgJiI=
X-Google-Smtp-Source: APXvYqyQ8PN4Yo0D5f0TxdtgaqutssAvFXy5lB6UXK07VypUBLW+9PLuwlCGTEr6LBLosXGwZ9rWLA==
X-Received: by 2002:a63:214e:: with SMTP id s14mr6207807pgm.428.1576096317292;
        Wed, 11 Dec 2019 12:31:57 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:31:56 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
Date:   Wed, 11 Dec 2019 12:31:38 -0800
Message-Id: <20191211203143.2952-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
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

