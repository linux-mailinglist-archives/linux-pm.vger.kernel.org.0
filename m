Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9744F5BC
	for <lists+linux-pm@lfdr.de>; Sun, 14 Nov 2021 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhKMXmz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 18:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKMXmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 18:42:55 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6804BC061766
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 15:40:02 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h11so26539616ljk.1
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 15:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgtpJL2KosIvva4a54I1qU5hEr/AEJbe0JB99nx9vNw=;
        b=MJ4tXif+1bu5mxjIYIn7VU4biXUFy6nur+reGgSmV8LcEsr11gTDvpBnC0Mp93BtT5
         ThVQXSi0yvVz9eRfF5TRuggOi5f7JuWAvfbKkdZyzBn2afAHL2JgWi2kwsaJzbnKKnrW
         cyuaVyFYcqrcZPzrTDkk2rTA+dxxVpJGZtVlV7QhnFcpSdG+czK6Kug+LstXZ+MEj28r
         gwOws0AEJgqm2NwFlTjzsllWFUlbuxFSZ6gb2opY/TRd4AIxXH4uMPr74fQV+1BlOvfh
         fWSlT68yIN/smOS/bFPUxYfWgF6ffMcCiZc6kbqstqhz54CVNkTphYTkzWud6TZ2qVK2
         9Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgtpJL2KosIvva4a54I1qU5hEr/AEJbe0JB99nx9vNw=;
        b=1c0n8x9pzoqHqx1J3/bV2J14+CDl4Du7FbUTUM0vbUo05raBSTPs4zryeNHuYhiRdR
         IIFPV5P/OrCvD4kcdGb6+vOCBY5qOekkYazzaDDT02oBkUCG8KlXgfBqSCm2HBAuAtDz
         AcsMp+y7fBtXR8l/i3zs3KgOlnY+W3pQ7lVptPOc2R/bQCYMQYAF/GVfW0urfwrarXFj
         iAk2OGC+QDjTkNl/Wp6cp7SqO/ny5A1BvD2QWY1TrykpjwxWTjF6Nu7J9d53HVi2gxVs
         nPuz5Qeql5Kzd2V9ciImXO4dgLBcWrqvridbHl6UAIAfK7A8nJCIzvekPpnjiKeP5I6t
         iURg==
X-Gm-Message-State: AOAM5332toDnHpzgxhLASXCc9ifjFtlFlpXKJWGAtp5mzcWpPOsva0pb
        PPh8vzyZi8DU/dXjMYaRwNVLshNz7jCF6Q==
X-Google-Smtp-Source: ABdhPJzXNTqiSLvFv2QRg3nbvK/l6hTVmQ4GUTY2FjYvjq5JxipsXq6X/V/EeIpfk7prlMsihCZicA==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr26012275ljh.363.1636846800699;
        Sat, 13 Nov 2021 15:40:00 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id br13sm980542lfb.61.2021.11.13.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 15:39:59 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH] power: supply: core: Use library interpolation
Date:   Sun, 14 Nov 2021 00:37:50 +0100
Message-Id: <20211113233750.1763820-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power supply core appears to contain two open coded
linear interpolations. Use the kernel fixpoint arithmetic
interpolation library function instead.

Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Chunyan: The sc27xx fuel gauge seems to be the only driver
using this, so it'd be great if you could test this to make
sure it works as intended.
---
 drivers/power/supply/power_supply_core.c | 55 ++++++++++++------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fc12a4f407f4..038e35ea7fbe 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -21,6 +21,7 @@
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/thermal.h>
+#include <linux/fixp-arith.h>
 #include "power_supply.h"
 
 /* exported for the APM Power driver, APM emulation */
@@ -783,26 +784,24 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				    int table_len, int temp)
 {
-	int i, resist;
+	int i, high, low;
 
 	for (i = 0; i < table_len; i++)
 		if (temp > table[i].temp)
 			break;
 
-	if (i > 0 && i < table_len) {
-		int tmp;
-
-		tmp = (table[i - 1].resistance - table[i].resistance) *
-			(temp - table[i].temp);
-		tmp /= table[i - 1].temp - table[i].temp;
-		resist = tmp + table[i].resistance;
-	} else if (i == 0) {
-		resist = table[0].resistance;
-	} else {
-		resist = table[table_len - 1].resistance;
-	}
-
-	return resist;
+	/* The library function will deal with high == low */
+	if (i > 0)
+		high = i - 1;
+	else
+		high = i; /* i.e. i == 0 */
+	low = i;
+
+	return fixp_linear_interpolate(table[low].temp,
+				       table[low].resistance,
+				       table[high].temp,
+				       table[high].resistance,
+				       temp);
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
@@ -821,24 +820,24 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 				int table_len, int ocv)
 {
-	int i, cap, tmp;
+	int i, high, low;
 
 	for (i = 0; i < table_len; i++)
 		if (ocv > table[i].ocv)
 			break;
 
-	if (i > 0 && i < table_len) {
-		tmp = (table[i - 1].capacity - table[i].capacity) *
-			(ocv - table[i].ocv);
-		tmp /= table[i - 1].ocv - table[i].ocv;
-		cap = tmp + table[i].capacity;
-	} else if (i == 0) {
-		cap = table[0].capacity;
-	} else {
-		cap = table[table_len - 1].capacity;
-	}
-
-	return cap;
+	/* The library function will deal with high == low */
+	if (i > 0)
+		high = i - 1;
+	else
+		high = i; /* i.e. i == 0 */
+	low = i;
+
+	return fixp_linear_interpolate(table[low].ocv,
+				       table[low].capacity,
+				       table[high].ocv,
+				       table[high].capacity,
+				       ocv);
 }
 EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
 
-- 
2.31.1

