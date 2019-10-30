Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3077EA327
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfJ3SVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:21:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39362 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:21:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so2010511pgn.6;
        Wed, 30 Oct 2019 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6P5H/5uV7JacgxYkaFeE2k/FEa8xgvahkSEI1tPpC4=;
        b=AJmJh+mWDb0JsKw8h0qqyPLlnyvhhllDzfwONbL/lWjh03d2I/+24d6dCsaPEnkWel
         6n8KRJYnHfGrE+9DyTj7Y/Za63OHx7Pg9gg3rx7JlrAUCmLQSixoYvnXB5Ksv5j1zgEM
         /GgskK1TI4aXZs/B79FXMWWANtjAxwGekTHXlSmt8PamTkLU/2UCKeI2X+wZVRluBsnT
         oez67NfdmkJ6UHYoDiI/EJsRALrPV/7asy6s+OPN/9+4NsqO8KdseLSjYjfPFPH4rBhd
         KNqmoHJZZ6DxhSN9B4z+3x0jjqLDEv0X9Hs162pRRx51bc0SM3+UjmMaNbM5h4kRLF1J
         KI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6P5H/5uV7JacgxYkaFeE2k/FEa8xgvahkSEI1tPpC4=;
        b=QRmzCFpjS5p8G+CBGLA5MBucFDpwQLHc+I4pbfiCB/nVvGW8PlgaAQd3Z5jK9l/F+S
         sIaqRGsX96BQYaATmDdKAwaNI7mZ6zIRfZTschpwkxB0X1pj/zC9273WM+pZEgh48fze
         Vr/WxlLpBhNfTrxR1FBfFUeNoewdkxaKOjqmNGohrnPjZ4wkpxsrI9jQfWaUDh/31k1h
         Rgxc95UsSs+4To25A0ZqIlrJBBvk4X6KwLId8ZuG71bpaPRdfI5mdjXyt+E1YvUsiPRf
         j3tYtofY218osgnzehSeOt0pKxU36yYI20o2VNcn+Zexucm4V2SxiQPF1WMXgl9D8DJI
         YBVg==
X-Gm-Message-State: APjAAAWh3pTfEyxxZyVaIZXBOf9FvEWyVfleXqTykYgaXPgl6Fz0RIAD
        CRpfLFrkibxxvgbXOU50GwEfRNeI
X-Google-Smtp-Source: APXvYqw6qm/6KxOPBYJT/5NALIlwWu5lWetRg4AhEbAVKFFHyKHBtdirXo9dY9wHdGsKgzRFzc/UJA==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr764111pfb.60.1572459710934;
        Wed, 30 Oct 2019 11:21:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:21:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
Date:   Wed, 30 Oct 2019 11:21:27 -0700
Message-Id: <20191030182132.25763-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 37 ++++------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..42482af0422e 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -48,15 +48,6 @@
 #define AVS_TMON_TEMP_INT_CODE		0x1c
 #define AVS_TMON_TP_TEST_ENABLE		0x20
 
-/* Default coefficients */
-#define AVS_TMON_TEMP_SLOPE		-487
-#define AVS_TMON_TEMP_OFFSET		410040
-
-/* HW related temperature constants */
-#define AVS_TMON_TEMP_MAX		0x3ff
-#define AVS_TMON_TEMP_MIN		-88161
-#define AVS_TMON_TEMP_MASK		AVS_TMON_TEMP_MAX
-
 enum avs_tmon_trip_type {
 	TMON_TRIP_TYPE_LOW = 0,
 	TMON_TRIP_TYPE_HIGH,
@@ -108,23 +99,11 @@ struct brcmstb_thermal_priv {
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
+	return (410040 - (int)((code & 0x3FF) * 487));
 }
 
 /*
@@ -136,20 +115,16 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
 static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
 					int temp, bool low)
 {
-	int slope, offset;
-
-	if (temp < AVS_TMON_TEMP_MIN)
-		return AVS_TMON_TEMP_MAX; /* Maximum code value */
-
-	avs_tmon_get_coeffs(tz, &slope, &offset);
+	if (temp < -88161)
+		return 0x3FF;	/* Maximum code value */
 
-	if (temp >= offset)
+	if (temp >= 410040)
 		return 0;	/* Minimum code value */
 
 	if (low)
-		return (u32)(DIV_ROUND_UP(offset - temp, abs(slope)));
+		return (u32)(DIV_ROUND_UP(410040 - temp, 487));
 	else
-		return (u32)((offset - temp) / abs(slope));
+		return (u32)((410040 - temp) / 487);
 }
 
 static int brcmstb_get_temp(void *data, int *temp)
-- 
2.17.1

