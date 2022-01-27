Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A449D75D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiA0BOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiA0BOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6AC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x23so2360189lfc.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/gXlHlEYU9y3S7brw2btRZQi4ddRdh7nKPMfXzIQjU=;
        b=cXvbtyEUybHqB2oFR0m4Dv5+3WDnF9mij5M2EooxS8iWuuGWl8W4pocn1mlYryGkyu
         nOnRVmE7gdwPpUlWEkyK6Me7KzfoLrW2K4o2leHV1d/U3gE72k404UH4PBcwzyLAaS3W
         uronUgffDsTBW7II2IcpsVMnJvIamPrIbw/wFhXzHyJSz8AldofkTncmRpKVY4bZEtuj
         L9UGhcfHcy+cvbwZw60j6Os+eNDlCAJFQWuzjAWwXe/7b5t6Ta4GWbOdU8vYaDXT8G2E
         Z0FkaX65J6mnwpPj9TO68t/aEP8CNvHVd9N1HVF67ysXh1g7U98GvB0bT4nOcPEVWopK
         SzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/gXlHlEYU9y3S7brw2btRZQi4ddRdh7nKPMfXzIQjU=;
        b=DaFzF4h03uWsoa5hLix5aqOwjYoBi4j6unXSf5KH/SN9SmTIGh8uSP82icxIPm39P9
         HA7ocQ2Fnc5kItHYEoPGzaO8EEuf5PAWw+I898o8msBlIiyz2N4SZBuj9cd0a7dkAdVU
         gh97/W4+nqWphBXFSdITtwmalCSc08Cw2WFQD+UjR9GP2a+VVw+oqKpFT6kRqQ4BnQFG
         WsyR8cnhipjrqalhc+o1DF/u3kGCqZY+M6sXLe22kEDy9SwtkUvs1Z0LhbUff33mZwVK
         QEPBrpJ1Z8+7d10bdvKP6rFbXDHJMJSfge0NmFG/3hIxOwde0s7hOH88BgTuTRmL3RQH
         2mWw==
X-Gm-Message-State: AOAM532L5AjtSq+ofGsYi5gdNT5hBzHGoVYTDNgGR901BU4l6ZmJrvoz
        vueCOCPGuLSqIaDk45q0ZjwTvg==
X-Google-Smtp-Source: ABdhPJx3p5GmN6XiWsa1fYU3jENqHyjUy33TCf03WJGELT2vPMSI7415iBvJK0ZQsEXMjstR3L5aXg==
X-Received: by 2002:ac2:55bc:: with SMTP id y28mr1277279lfg.548.1643246090562;
        Wed, 26 Jan 2022 17:14:50 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:50 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/11] power: supply: ab8500: Swap max and overvoltage
Date:   Thu, 27 Jan 2022 02:12:27 +0100
Message-Id: <20220127011236.332687-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We should terminate charging when we reach the voltage_max_design_uv
not overvoltage_limit_uv, this is an abuse of that struct member.

The overvoltage limit is actually not configurable on the AB8500,
it is fixed to 4.75 V so drop a comment about that in the code.

Fixes: 2a5f41830aad ("power: supply: ab8500: Standardize voltages")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_bmdata.c   | 8 +++-----
 drivers/power/supply/ab8500_chargalg.c | 2 +-
 drivers/power/supply/ab8500_fg.c       | 8 +++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 7133cce6a25a..62b63f0437dd 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -186,13 +186,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	 * fall back to safe defaults.
 	 */
 	if ((bi->voltage_min_design_uv < 0) ||
-	    (bi->voltage_max_design_uv < 0) ||
-	    (bi->overvoltage_limit_uv < 0)) {
+	    (bi->voltage_max_design_uv < 0)) {
 		/* Nominal voltage is 3.7V for unknown batteries */
 		bi->voltage_min_design_uv = 3700000;
-		bi->voltage_max_design_uv = 3700000;
-		/* Termination voltage (overcharge limit) 4.05V */
-		bi->overvoltage_limit_uv = 4050000;
+		/* Termination voltage 4.05V */
+		bi->voltage_max_design_uv = 4050000;
 	}
 
 	if (bi->constant_charge_current_max_ua < 0)
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index c4a2fe07126c..bcf85ae6828e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -802,7 +802,7 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
 		!di->maintenance_chg && (di->batt_data.volt_uv >=
-		di->bm->bi->overvoltage_limit_uv ||
+		di->bm->bi->voltage_max_design_uv ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
 		di->batt_data.avg_curr_ua <
 		di->bm->bi->charge_term_current_ua &&
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index b0919a6a6587..236fd9f9d6f1 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2263,7 +2263,13 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 {
 	int ret;
 
-	/* Set VBAT OVV threshold */
+	/*
+	 * Set VBAT OVV (overvoltage) threshold to 4.75V (typ) this is what
+	 * the hardware supports, nothing else can be configured in hardware.
+	 * See this as an "outer limit" where the charger will certainly
+	 * shut down. Other (lower) overvoltage levels need to be implemented
+	 * in software.
+	 */
 	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_CHARGER,
 		AB8500_BATT_OVV,
-- 
2.34.1

