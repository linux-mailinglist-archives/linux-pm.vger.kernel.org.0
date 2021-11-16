Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A61452904
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 05:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbhKPENq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 23:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbhKPEMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 23:12:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A93C07E476
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 17:03:57 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b1so42508352lfs.13
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7qg7iTkpuWDH/cGtwUCf+VVwcHd5bv32NU5qkjE9ZE=;
        b=t/KR4zVIfzjduOnyNPWKKhsi3VWcpeIWzJg8QaO6ADa+rc2wmALFbyla807d4rZ091
         WsitPMl4ls1EDXtRzH1FF3a4dbNOtXZegWhWoMtuBaJIqFDhxd5CF9Q02MKrzvnRocCe
         Qjbro5gaoqCwQXY5Y3oRi8hJiGQDL3s61khD3hbzp8k/OeaGZWTo7WhScfGcb82fNs73
         S1ArkX4HhlzumDNsLYBr/q3VqYBuSFJ8S1tgkwwirhRaf3J52mSHUGQnNzXWsI6LqD+H
         zZjhOBGBdadiA0hN3ZZlVgaPMulUjkWVvvGHqTZI4YY9u7Bo0ROWQ5aSQ41J/vf78NZI
         wGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7qg7iTkpuWDH/cGtwUCf+VVwcHd5bv32NU5qkjE9ZE=;
        b=EObXBphyM/qA3R7B3PviRlLW+hrJxS5lQABYAHV4Aa7+5qdAHEJ3SOgv1UE7pKSqeG
         PrYkowSDvEOnIPzFHO7rRAxhKRQgqpCZHZ+ULNE+3gCVG8KfA1wxY8OeO1V30+JFtq1f
         fZ5dR1k2HAqOmrvvU3rlO3M+7RyPMXIO2zwfD21ywVk8KMilztb3mxm0k2nmyVLg/RJ4
         15DI7n9gPQqaBAtWda2PeJ0p9b/UPCQMa5sH8aL9uX2+y1u8LxRbiFaycFxOxi5S1EEU
         0c4f/vIdxMvKPFRgHWcCk4dcMpCaAio/o8Sn3SuMZQRYtfUSHpCpmcwd46n1K68wMyJf
         b6lQ==
X-Gm-Message-State: AOAM533CyLbs9w11TOUreFQFdJnzK8YQ+lITdbVsWz5euBmrqIGPjtY2
        HpLQZaMTizJ6dwHrbcENkMGRkHqyqQtYDQ==
X-Google-Smtp-Source: ABdhPJymAXLF3F0GbPImqUcaUzpNUmTEuOAqc3gXJwL537iD7IvtyPD4yupa4Tu5/oXnJz5Ln4wgtg==
X-Received: by 2002:a05:6512:23a4:: with SMTP id c36mr2984852lfv.125.1637024636179;
        Mon, 15 Nov 2021 17:03:56 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id a12sm1652659ljb.19.2021.11.15.17.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 17:03:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v3] power: supply: core: Use library interpolation
Date:   Tue, 16 Nov 2021 02:01:53 +0100
Message-Id: <20211116010153.2134873-1-linus.walleij@linaro.org>
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
index fc12a4f407f4..5d3c62652299 100644
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

