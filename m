Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5224168D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHKG4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgHKG4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 02:56:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A2C061756
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:56:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so7070193pfx.13
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LqHl1iK9xIF/M1r8MveG/ZqJf0ZfRNzgBcKNGlpX+U=;
        b=Xsp4+bSemAW3Pv7dsczgIa9RB9Ywpu9GL8X4M9AOq82zf2eCNJl8eNgm35Crk/ZJFj
         fzk6uF5AKz6sVuQAZIQD1EkueKw8Nrbo0k/MHu1vGeGAMHxxXHbcrmliZWmpZhfnpoJx
         K6Mp7Q0Q5bCw/8IBcCdP/W2EaYPh4qDrIcJvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LqHl1iK9xIF/M1r8MveG/ZqJf0ZfRNzgBcKNGlpX+U=;
        b=t/044fObydhrVrvZUpAHS1wYW6ud28nuj7UA/NPKUEosCrVZiYwtVZb63HqTGer1XJ
         OgACAf46k0mIsXWIePMzEgSwAQlQKSySfsdU7WFc4b5EzlWriLRUubphUgZycun/PZL1
         KjU22ecppkEEjM8eUjtDXmAG/J/lBqr4saTeE62yJvOaLClVotDLRNoHpxAR6ayHPTVq
         ImT7mynHRNe1uWHrczLPxrEE7NlrCq8tzc6qZCOpj1FtqCu33p+6YeQ17dAtU0KC9g7i
         eSf3Fk71yn+PZjyv0fAuU4t4rP9cMd/mQoS3yCdneRMDfj5WC4XxRfCN159f1slb8ccG
         7GKw==
X-Gm-Message-State: AOAM531YEwGf82F8d0ev+gptKE1CuD55/nSOnG3dJknvi5g8gL6lH6H0
        DI+9E6JPgaM+NJtV8nL4mkCgMg==
X-Google-Smtp-Source: ABdhPJz2AYrNAnCg/Oh/BX7v6pmWU+VuoLSFTAAGdVboDbHzaMxfcCDrqL4hehLHp57zH/jg6WMuoQ==
X-Received: by 2002:a62:78d6:: with SMTP id t205mr5020638pfc.68.1597129000088;
        Mon, 10 Aug 2020 23:56:40 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id h7sm1636832pjc.15.2020.08.10.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:56:39 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 1/2] power: supply: sbs-battery: combine get_presence_and_health
Date:   Tue, 11 Aug 2020 14:56:34 +0800
Message-Id: <20200811065634.2099732-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch combines two different sbs_get_battery_presence_and_health()
for reuse in the future. No functional changes.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 73 +++++++++++++++---------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83b9924033bd..6acb4ea25d2a 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -389,37 +389,6 @@ static bool sbs_bat_needs_calibration(struct i2c_client *client)
 	return !!(ret & BIT(7));
 }
 
-static int sbs_get_battery_presence_and_health(
-	struct i2c_client *client, enum power_supply_property psp,
-	union power_supply_propval *val)
-{
-	int ret;
-
-	/* Dummy command; if it succeeds, battery is present. */
-	ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-
-	if (ret < 0) { /* battery not present*/
-		if (psp == POWER_SUPPLY_PROP_PRESENT) {
-			val->intval = 0;
-			return 0;
-		}
-		return ret;
-	}
-
-	if (psp == POWER_SUPPLY_PROP_PRESENT)
-		val->intval = 1; /* battery present */
-	else { /* POWER_SUPPLY_PROP_HEALTH */
-		if (sbs_bat_needs_calibration(client)) {
-			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
-		} else {
-			/* SBS spec doesn't have a general health command. */
-			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
-		}
-	}
-
-	return 0;
-}
-
 static int sbs_get_ti_battery_presence_and_health(
 	struct i2c_client *client, enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -478,6 +447,41 @@ static int sbs_get_ti_battery_presence_and_health(
 	return 0;
 }
 
+static int sbs_get_battery_presence_and_health(
+	struct i2c_client *client, enum power_supply_property psp,
+	union power_supply_propval *val)
+{
+	struct sbs_info *chip = i2c_get_clientdata(client);
+	int ret;
+
+	if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
+		return sbs_get_ti_battery_presence_and_health(client, psp, val);
+
+	/* Dummy command; if it succeeds, battery is present. */
+	ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+
+	if (ret < 0) { /* battery not present*/
+		if (psp == POWER_SUPPLY_PROP_PRESENT) {
+			val->intval = 0;
+			return 0;
+		}
+		return ret;
+	}
+
+	if (psp == POWER_SUPPLY_PROP_PRESENT)
+		val->intval = 1; /* battery present */
+	else { /* POWER_SUPPLY_PROP_HEALTH */
+		if (sbs_bat_needs_calibration(client)) {
+			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
+		} else {
+			/* SBS spec doesn't have a general health command. */
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+		}
+	}
+
+	return 0;
+}
+
 static int sbs_get_battery_property(struct i2c_client *client,
 	int reg_offset, enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -780,12 +784,7 @@ static int sbs_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
-			ret = sbs_get_ti_battery_presence_and_health(client,
-								     psp, val);
-		else
-			ret = sbs_get_battery_presence_and_health(client, psp,
-								  val);
+		ret = sbs_get_battery_presence_and_health(client, psp, val);
 
 		/* this can only be true if no gpio is used */
 		if (psp == POWER_SUPPLY_PROP_PRESENT)
-- 
2.28.0.236.gb10cc79966-goog

