Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514E49D762
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiA0BPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiA0BPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:15:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05FC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:15:00 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z19so2173932lfq.13
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9/KleBGoO0PO95Mx9jAXT4YN2e2L9g/3cjOpS4m2Og=;
        b=Uur9cwQYEtlq9UTRd353wREk9TgzYS1t4rt9DwbMXKOIa14TvjvJ5X7bZgeqp7Gwb1
         73/gNDuCYh0qhknuJ4WAKrbSAuPVBSYRfu746lbfQmiO9rnvcDnKlbLOq/HAuQLaaRzz
         1e5iJv/7yR7w3UF8BD54WnDoLP8YvWqgN9rMjRYjnyAmKF6bGXDai5lPHlIxqB5XmEYS
         HtfwDGowjxelE3mgM6pWQ+lj5eSRgF2Gn/yGgyPpEAyFhsN4C6ZGH+5iye6EpI4zhU02
         SHayC/SCSbM+LotrE412pRNG47BOeXtEgmmO7zRLvXm3JQER3R1wsLTbo3tpqqsYN+h3
         razQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9/KleBGoO0PO95Mx9jAXT4YN2e2L9g/3cjOpS4m2Og=;
        b=kx13k53PwGg8J72dflfCBQIq0TDpZUBQ1zhjT3nHQsoilrLMiSNb+DeNiRksUMbr22
         QO7N2RmiCf4bq5fTNg146AeRmv5ebsaYvupHQlvAzVntGfLWFh7zt6xsFEopU/XG5zzv
         3hL7kJInR00Me/VH2Rpder7ezHw+3b6r0GJaI9gwi9evakzpXOwN8oJAaQ6FkEVfp6x+
         GwKtc/DqRcOlLB0vTMXYT/w0EcAVtW6lWwYmgcpYqTgo47wJiBHrU5u+ixPsU4PbaMFK
         81T/HpsaH1+Qd+MMUr3WYm0utHdeUQMFipAutTS2orBJL3J/90fnot1FVQ5P6+0L08x6
         TSNA==
X-Gm-Message-State: AOAM532/o9tH8bW6zBuU2z/hYnaEx3xJ/CSHy/K+emuNH1E6LotSOPR6
        z+xxPEPVTTWHZpegXh/E4yrkbA==
X-Google-Smtp-Source: ABdhPJyJgNa0PwxJwof/RQfYwTUyhbhFZZEMeWJah93XGYuW+cA4hvT2Yjv+TWzWZpuXgIdN8OnpZA==
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr1227546lfu.123.1643246098405;
        Wed, 26 Jan 2022 17:14:58 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/11] power: supply: ab8500_fg: Drop useless parameter
Date:   Thu, 27 Jan 2022 02:12:32 +0100
Message-Id: <20220127011236.332687-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
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
 drivers/power/supply/ab8500_fg.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 323f6bacefd8..fa61ecebbce3 100644
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

