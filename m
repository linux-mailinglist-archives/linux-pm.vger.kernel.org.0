Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A00453C84
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 00:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhKPXHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 18:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhKPXHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 18:07:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF5C061570
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 15:04:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so1866957lfb.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 15:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S2FKCCCeVXExpc5akXzhrPLAGPxYCcn/RLw7xIRs08M=;
        b=eJMhi32x3iPoMKrrLoNBbD5ipqrc3Ps9y942GnFkoPgq9aRJIXBZuN7vubjjKkwc1a
         XgGxQQC2MxtAPU/zxY43+kww4GD4xiUEnqrdgCgrR1BWp3CIPrbKYlIRJa2qzk+pAgaL
         Wgqizte3jpS0G3FSXkJjCazLSv8FyME40UQ+wL95WIGOOMKtsvXrIh3oWAHQ3mCe1yA/
         FFt+5MxKKWz4qoA/5lGsvsGM/aigkkEIuyYR4crj3cR6ZgOk8eTJVs6fiuyaeFP/vY0A
         fQn56IoUf1JGAE3sZms/xwtOPp+hqEn1btHNzc3IVTKw415Yv9bY557BNrNi03HXtFzy
         kWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S2FKCCCeVXExpc5akXzhrPLAGPxYCcn/RLw7xIRs08M=;
        b=U3qvqPtBNpYpwwiGG1g6/m/rqbxCJT52yQpOoYLbX9RND71zwP9zFlchkWwPgGhAnF
         e/JtWwqX8LmugF8j5IcjA/3V2LiPpGBT398nW4IoGZK9c7/Ce1jffLiKWj4+2kvykMMx
         c9dFQvDzlr4f/cT/ikwVKOEoH11RLgH8L8OUn3SJzDFfbF2xzsQadZkKUkQVjbalE2bq
         LbPjQFgRpnNNogCIz7KvYk3a+08+7Nafm27X7HCDboVIaM6VuIA8rWHcGUAPJYul8LSd
         /RYLRRD+G9uAfkGrrUy/P3E55RbtR2XjM5i5b1NyeIz0r1TQu+WNKB+R0VQ7z2EoTLEx
         osng==
X-Gm-Message-State: AOAM532PY/3a3qotH4zCtEijizLOHi5VzMS1EzkY89fDcSZuSU3ZCYPI
        KON1x1L8Wkw/Q3W5KKyfKjvXM/8ItSwvOg==
X-Google-Smtp-Source: ABdhPJy+5hiBZ+KGcVxpa1t8uzf/4DOA6azB19aRSeQPEiWP3qc6q03Kw6J2jJqtumlPjvnrhZq+nA==
X-Received: by 2002:a05:6512:ac1:: with SMTP id n1mr10235521lfu.639.1637103875750;
        Tue, 16 Nov 2021 15:04:35 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id e8sm1899366lft.308.2021.11.16.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:04:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v4] power: supply: core: Use library interpolation
Date:   Wed, 17 Nov 2021 00:02:33 +0100
Message-Id: <20211116230233.2167104-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Fix the code to really provide the same x index for both
  datapoints at the end of the table. Thanks again Baolin!
ChangeLog v2->v3:
- Actually implement the code as I say. Missed one occurence.
ChangeLog v1->v2:
- Break the table loop at table_len - 1 so we don't index
  past the end of the table. (Thanks Baolin!)

Chunyan: The sc27xx fuel gauge seems to be the only driver
using this, so it'd be great if you could test this to make
sure it works as intended.
---
 drivers/power/supply/power_supply_core.c | 61 ++++++++++++------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fc12a4f407f4..2907b84ceea9 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -21,6 +21,7 @@
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/thermal.h>
+#include <linux/fixp-arith.h>
 #include "power_supply.h"
 
 /* exported for the APM Power driver, APM emulation */
@@ -783,26 +784,25 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				    int table_len, int temp)
 {
-	int i, resist;
+	int i, high, low;
 
-	for (i = 0; i < table_len; i++)
+	/* Break loop at table_len - 1 because that is the highest index */
+	for (i = 0; i < table_len - 1; i++)
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
+	if ((i == 0) || (i == (table_len - 1)))
+		high = i;
+	else
+		high = i - 1;
+	low = i;
+
+	return fixp_linear_interpolate(table[low].temp,
+				       table[low].resistance,
+				       table[high].temp,
+				       table[high].resistance,
+				       temp);
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
@@ -821,24 +821,25 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 				int table_len, int ocv)
 {
-	int i, cap, tmp;
+	int i, high, low;
 
-	for (i = 0; i < table_len; i++)
+	/* Break loop at table_len - 1 because that is the highest index */
+	for (i = 0; i < table_len - 1; i++)
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
+	if ((i == 0) || (i == (table_len - 1)))
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

