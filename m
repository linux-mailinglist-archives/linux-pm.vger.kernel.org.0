Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA14A2AB8
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiA2Avs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiA2Avr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45295C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id j14so11356740lja.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUiC0d8f/7ZHjZAd2/Oxz1SRQ1RYxgWHQHDdQRDOWkM=;
        b=QuzfoyaZS3HNyqEoAFPQTXiaVFSIdPeuapgWFBoJrMXWADsdJ8CmuGT57UmmHTSroK
         QtwvNHckx2DiLHmB7VB4fgssG8EWUomf6ke5SOt+yW43rStHwLtAU/7Ox88K5v4o4Z7P
         NrLN4WiZa5cCzUpQROHRwym8UGVYDC5OmKV6PXxK74fQpkDNCVA9DAEAu/CKJJ8uTqS3
         BloEeqvANdpCNroiG90XnRCodrkFZ29+Qu2I/4n3lmUAvfeIq2BymHa4rAARJH5xTClY
         OReVyVk9vuFnGq5vMqBakwS8lehZzYaOgk4TqCEePUueq0eDisGiZQWkeO811xsVJJ9K
         m1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUiC0d8f/7ZHjZAd2/Oxz1SRQ1RYxgWHQHDdQRDOWkM=;
        b=KPM6XnWZDqYXLeiNuYXZM6cZzO5QpbLbZ0wyQb/Mc71riG3byGVf8zk4OT3sfLxBMv
         S+aUhRz13sax2HIKSot7MnRKryctToE6PXplwnjxohdyRCaTHAescG3XeFBxhwDeY8eY
         rpV0RFLLpBy0KdcIzAY0JEBeeYIOLwDaj6m1Xu2go7kpVrjgaqqrJ7E+iMWbj0Bi70jC
         VgcJwj8a5+ZcxaRet7x9DKAphPgfu5hxcaoeSmcos/0NSPhHonr3pLpUcSr0YnC995PV
         rFCkDUWmJ+2hFtXKN3koAnHmhodDWNTRfeftW4Hx8s2NvbXewqnBIgNMlFgAbrVxdbpu
         97tw==
X-Gm-Message-State: AOAM532krus0blpBz9Sb7ojWRBH7A20v2hu97KCoZ85mkrfrWfSPij1G
        +lpInuirMypwEl1sC5jI1f6OBA==
X-Google-Smtp-Source: ABdhPJyOn5STwLl9CI5mh29LjK7nPxUzw93VVQzwVNL3vAHta9lsbBwOREHLCWqirWcgLgjp6KqEwQ==
X-Received: by 2002:a2e:87ce:: with SMTP id v14mr7282747ljj.380.1643417504575;
        Fri, 28 Jan 2022 16:51:44 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:44 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/11 v2] power: supply: ab8500_fg: Drop useless parameter
Date:   Sat, 29 Jan 2022 01:49:21 +0100
Message-Id: <20220129004925.639684-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All calls to ab8500_fg_calc_cap_discharge_voltage() require
compensation and pass true as the second argument so just drop
this argument.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_fg.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c659fdc8babd..6436861db016 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -1073,20 +1073,16 @@ static int ab8500_fg_calc_cap_charging(struct ab8500_fg *di)
 /**
  * ab8500_fg_calc_cap_discharge_voltage() - Capacity in discharge with voltage
  * @di:		pointer to the ab8500_fg structure
- * @comp:	if voltage should be load compensated before capacity calc
  *
- * Return the capacity in mAh based on the battery voltage. The voltage can
- * either be load compensated or not. This value is added to the filter and a
- * new mean value is calculated and returned.
+ * Return the capacity in mAh based on the load compensated battery voltage.
+ * This value is added to the filter and a new mean value is calculated and
+ * returned.
  */
-static int ab8500_fg_calc_cap_discharge_voltage(struct ab8500_fg *di, bool comp)
+static int ab8500_fg_calc_cap_discharge_voltage(struct ab8500_fg *di)
 {
 	int permille, mah;
 
-	if (comp)
-		permille = ab8500_fg_load_comp_volt_to_capacity(di);
-	else
-		permille = ab8500_fg_uncomp_volt_to_capacity(di);
+	permille = ab8500_fg_load_comp_volt_to_capacity(di);
 
 	mah = ab8500_fg_convert_permille_to_mah(di, permille);
 
@@ -1563,7 +1559,7 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 
 		/* Discard the first [x] seconds */
 		if (di->init_cnt > di->bm->fg_params->init_discard_time) {
-			ab8500_fg_calc_cap_discharge_voltage(di, true);
+			ab8500_fg_calc_cap_discharge_voltage(di);
 
 			ab8500_fg_check_capacity_limits(di, true);
 		}
@@ -1646,7 +1642,7 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 				break;
 			}
 
-			ab8500_fg_calc_cap_discharge_voltage(di, true);
+			ab8500_fg_calc_cap_discharge_voltage(di);
 		} else {
 			mutex_lock(&di->cc_lock);
 			if (!di->flags.conv_done) {
@@ -1680,7 +1676,7 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 		break;
 
 	case AB8500_FG_DISCHARGE_WAKEUP:
-		ab8500_fg_calc_cap_discharge_voltage(di, true);
+		ab8500_fg_calc_cap_discharge_voltage(di);
 
 		di->fg_samples = SEC_TO_SAMPLE(
 			di->bm->fg_params->accu_high_curr);
@@ -1799,7 +1795,7 @@ static void ab8500_fg_periodic_work(struct work_struct *work)
 
 	if (di->init_capacity) {
 		/* Get an initial capacity calculation */
-		ab8500_fg_calc_cap_discharge_voltage(di, true);
+		ab8500_fg_calc_cap_discharge_voltage(di);
 		ab8500_fg_check_capacity_limits(di, true);
 		di->init_capacity = false;
 
@@ -2422,7 +2418,7 @@ static void ab8500_fg_reinit_work(struct work_struct *work)
 	if (!di->flags.calibrate) {
 		dev_dbg(di->dev, "Resetting FG state machine to init.\n");
 		ab8500_fg_clear_cap_samples(di);
-		ab8500_fg_calc_cap_discharge_voltage(di, true);
+		ab8500_fg_calc_cap_discharge_voltage(di);
 		ab8500_fg_charge_state_to(di, AB8500_FG_CHARGE_INIT);
 		ab8500_fg_discharge_state_to(di, AB8500_FG_DISCHARGE_INIT);
 		queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
-- 
2.34.1

