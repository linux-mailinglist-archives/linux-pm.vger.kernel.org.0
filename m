Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8144528DB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhKPEA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 23:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhKPEAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 23:00:23 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF4C076B3A
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 16:40:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z8so39253422ljz.9
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 16:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzfUgWFeDAk1c/moRTBky5GDnO4T98ewWNIznDjMvdY=;
        b=isuzywhaP2OWfOPjlUlaG4o/ir+vBf/aFkNsbbg0snRBNGi480nrgCkUm5GaWZTL11
         TwuKwdRWzpQbaPaCqidv3oFfJlmGognh3sRcgilaiaXLVeAXTkWLub1QkClVprwUwYMj
         rpOd6+1x4saLE0gxltX4zUA4Oz0d1k6kqtUms334nCreLojd6Sp9nSxzjP1IsqfOdMld
         BmMJ5ICnxpuNQvdPKWXz2HWAR+V7z/WBWpoeEexNrnSyU/qlPqn+NNLFlQViK+VP+d7U
         zyCtC2Cs9yTpVeCdBymDrH3aPWM1phK6yJd1PYhR7XWkaqfAltDWbLrFIDf8CZM1SVbS
         LZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzfUgWFeDAk1c/moRTBky5GDnO4T98ewWNIznDjMvdY=;
        b=LBdZfMSxuOCngoSbC7i6itqov3fJ9mWkew7PixBKJdnYaADCifmbElUWffALNIzyZS
         EIMP8wqiBuvwvw4Q+cw87qnYT3VhHICBvh2FXr1HRzvWMUhbx4Z46JEQEd2GVwVlR6aa
         kbYnIDx7n/IdyMESefBnL4KEYEXzdvLrdZufPK2TyFAhRKarXp6jvXP01SS/v9r7XkVG
         Ali1zQA7PrWUakgo1FjYs9OIg8KZ1vBfJnd5ENI4qm1DoQ7Sq7BjybMu0wgsEmWoM+LD
         cdL45I+PuR8FKjIrCiI9PxivC8KwmCXOfFA9Z7f+7DSd+rX/A/PxaMEK9FNbzj2J3RgT
         HF7A==
X-Gm-Message-State: AOAM533h2h17X61HMsmfqMvAy0n+OOnLR3S9qwMnnKs+lCX+dGpJmZ4l
        GrMYpcXAaBuSc29R6x1fqMqLv4YDrXUo9g==
X-Google-Smtp-Source: ABdhPJyMtVm7ttaOBj38y+upczaIFYN1kGJyoofew6deDLsLEloD787YjQzt4c9JrDwhaxkQflvdew==
X-Received: by 2002:a2e:bd82:: with SMTP id o2mr2836995ljq.96.1637023248033;
        Mon, 15 Nov 2021 16:40:48 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id h6sm1585607lfv.202.2021.11.15.16.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:40:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2] power: supply: core: Use library interpolation
Date:   Tue, 16 Nov 2021 01:38:44 +0100
Message-Id: <20211116003844.2133683-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Break the table loop at table_len - 1 so we don't index
  past the end of the table. (Thanks Baolin!)

Chunyan: The sc27xx fuel gauge seems to be the only driver
using this, so it'd be great if you could test this to make
sure it works as intended.
---
 drivers/power/supply/power_supply_core.c | 59 ++++++++++++------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fc12a4f407f4..2983466a4914 100644
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
 
+	/* Break loop at table_len - 1 because that is the highest index */
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

