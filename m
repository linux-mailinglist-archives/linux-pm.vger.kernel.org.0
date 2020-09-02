Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64525B266
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIBQ61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgIBQ6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 12:58:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A4C061244;
        Wed,  2 Sep 2020 09:58:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so178144wrt.3;
        Wed, 02 Sep 2020 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcXQvmAkY/k2J1p9we4yfCScXrpnX5eBNUZhNJtw/Hk=;
        b=jaDoR8zHGWv18DZ+k2xRN07EgfAnZ+2OtQTUEsDgS2Nvtiwv4dbl7FdLnw+v8ogXKP
         IMQQbEAkaVY21jp4yPHkzkdnmeSKvw2i7L+6m+oITeHfBtrLGKyWUByU2JIh7fgnkQbp
         bbg99vBEaeAYHE0xgr/9QZi1zx5d+2cnSbNhKc+IA804dttxHFV2YRdv5EMjr9DoY/qb
         Yi2lVRfBCAutj3gUwyx5hQY+957XlH6H+Zix/qZuAs6QtD/SpLwRYbLNCFgmjk0N9QTw
         0o4y6hpEJ1zIl7Wfl09nMZpS0hLGJ5Ae+VOfnr4xFTvFEz6ispXooDBEzykBeCcR9384
         cDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcXQvmAkY/k2J1p9we4yfCScXrpnX5eBNUZhNJtw/Hk=;
        b=KIZV47ZKQNePAhyQYW/F2G5xTRqjhwLmaryX/4jZXR+n/gfbPURF/37lKU0Eeyk7lg
         j15do3nLMTcAQTjcavoq/uYUIUzOdGcPkohj4bVqG6H+5lcS76fNSfSSq3/IF6rlkbvW
         ybguXjZjaTVgeCj9hda8VvGGYyWK5qIlK/b000m9xyWh2iX7GQLTSiJkRO437n3Jlgry
         WCFLRY+emba9WOoaE8SDGtcEawxz+eXPkTKxwhoEJNaPckSlqU+sM1myGDpSPDJb4gYS
         MaIlDJ4zMPA5qcklBWNw8LY6r+LEF/ml7viw+EK6VF/AYQjfhP4IsPmyMfjQKYp1Fmqf
         YNqQ==
X-Gm-Message-State: AOAM532XNCBO1o6fSVWTDpeR0TVR2wo80wPnb/xUVVn54quWOwxJejYK
        4TCXEAGY2zTeV8aj+6FR24g=
X-Google-Smtp-Source: ABdhPJyGog7lMzfBNy5rF2ditlUSIh4T71Lu/c3ROK2tC/kiQgMwPGZcTxRdjEoeV/4SjVJlTa4jew==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr7711127wrt.13.1599065900919;
        Wed, 02 Sep 2020 09:58:20 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id c205sm369795wmd.33.2020.09.02.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:58:20 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: charger-manager: Tidy function
Date:   Wed,  2 Sep 2020 17:58:16 +0100
Message-Id: <20200902165816.401213-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

check_charging_duration() contains some copy-pasted code, which makes it
less readable. Refactor the function to be a bit tidier.

I've also fixed a couple of typos.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/power/supply/charger-manager.c | 39 +++++++++-----------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..67c7b1fb6601 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -443,42 +443,31 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
  * check_charging_duration - Monitor charging/discharging duration
  * @cm: the Charger Manager representing the battery.
  *
- * If whole charging duration exceed 'charging_max_duration_ms',
+ * If whole charging duration exceeds 'charging_max_duration_ms',
  * cm stop charging to prevent overcharge/overheat. If discharging
- * duration exceed 'discharging _max_duration_ms', charger cable is
+ * duration exceeds 'discharging _max_duration_ms', charger cable is
  * attached, after full-batt, cm start charging to maintain fully
  * charged state for battery.
  */
 static int check_charging_duration(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
-	u64 curr = ktime_to_ms(ktime_get());
 	u64 duration;
-	int ret = false;
 
-	if (!desc->charging_max_duration_ms &&
-			!desc->discharging_max_duration_ms)
-		return ret;
-
-	if (cm->charger_enabled) {
-		duration = curr - cm->charging_start_time;
-
-		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Charging duration exceed %ums\n",
-				 desc->charging_max_duration_ms);
-			ret = true;
-		}
-	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
-		duration = curr - cm->charging_end_time;
+	if ((desc->charging_max_duration_ms == 0 &&
+			desc->discharging_max_duration_ms == 0))
+		return false;
+	if (!cm->charger_enabled &&
+			cm->battery_status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+		return false;
 
-		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Discharging duration exceed %ums\n",
-				 desc->discharging_max_duration_ms);
-			ret = true;
-		}
+	duration = ktime_to_ms(ktime_get()) - cm->charging_start_time;
+	if (duration > desc->charging_max_duration_ms) {
+		dev_info(cm->dev, "Charging duration exceeds %ums\n",
+				desc->charging_max_duration_ms);
+		return true;
 	}
-
-	return ret;
+	return false;
 }
 
 static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
-- 
2.28.0

