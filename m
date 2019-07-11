Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35400660B2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfGKUcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 16:32:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39086 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbfGKUcD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 16:32:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so3617405pls.6
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkYq7uT/CNUdv8Wag/pmsaqwtieqxy569t5n4hsEP2k=;
        b=QNSUIi6/JywXvRsdcCggLLKKWxpsTFA7kv56Cen4r7ynWMCGwz2B/Pz5kms6GM+fBl
         RfeMHSyFtMjCO1TbSWoqrXZcE9VcfVzxypHZu8ARhyLEq8Fh8NE+UbsJiDsyGKkmA+aR
         JxLU7XINELxFSiUazt3yK0PZwgfe7MvstUqvK46xheV6QPS72UadCPivC5+W0Ofch2f5
         sMtBQbkQTpO6x/khyX0tsnUTSH5EBvMICHSj+2bSL86eRNsqF16ui2ieJAoMJQ8Z+7o4
         NaYn5ZpX1JD7KOeNKj32TxJ1Rhhj8CsHp8atPVcPgSjLYJUah3neBUMStpO7bfz8LB13
         DkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkYq7uT/CNUdv8Wag/pmsaqwtieqxy569t5n4hsEP2k=;
        b=CSr/wzpXYW5nG3ptWFHtAFR5pYDW8d+47+M95wsw2hwuq/2BH7uSvgxUoumbNyIaob
         /lQgI0UTDanDwdqbIjbH9AA/RDrieuZ9hdhnUZoP7vlb1eRZ8Z2/EgGtxe5zDrx+2Ffb
         Q0b+zv9vqKtUXPPgjTZcw2SnNAvnyAMquI062vc6nt+9zc2Wu252e8VfC858IAdNmxWR
         I7erAsY9BlRU7tu8rCUJIm48AK4DUdF0muuYXOyua6kp4098uHaGs8R4xOIW0FKRHEUI
         SsPsj5UZbttErPv615lWoVpoKb8xJa7y3Bk7qBt8FvaeKaFizdbMhYJcTFDoWprkX7mP
         6/ZA==
X-Gm-Message-State: APjAAAWl7cwX8t1fn6nnk4/opthapluUy57lA1HZkL4k4e1h1aJ3qTlN
        H6UMiIwrmlZK/3pgDqH7gt5D2w==
X-Google-Smtp-Source: APXvYqxuiqD/QeFdfWOG0tlJem3oeWCYlhK+OsGUOgkfx68FOnXwufxYAiSVysaUMbTd+tVTuRakEw==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr6945324plz.132.1562877122722;
        Thu, 11 Jul 2019 13:32:02 -0700 (PDT)
Received: from localhost ([49.248.58.252])
        by smtp.gmail.com with ESMTPSA id u7sm6104032pgr.94.2019.07.11.13.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 13:32:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        joe@perches.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2] thermal: Add some error messages
Date:   Fri, 12 Jul 2019 02:01:58 +0530
Message-Id: <31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562876950.git.amit.kucheria@linaro.org>
References: <cover.1562876950.git.amit.kucheria@linaro.org>
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
index 46cfb7de4eb2..e1c2c2638219 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0)
+	if (!type || strlen(type) == 0) {
+		pr_err("Error: No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
+		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
+	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+		pr_err("Error: Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (!ops)
+	if (!ops) {
+		pr_err("Error: Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

