Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FC243381
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgHMFLM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHMFLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 01:11:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB9C061757
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:11:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f193so2197874pfa.12
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tea+4k1B/HQFagig/As/WEVEROeIYcdzTJzUHMCDyq0=;
        b=CG3sm1WeX4MSMZlGZZmfrsCDMTBFRdu4ZhOKSJiLq8MMmTvf3+dlq5rShHooQxqwNJ
         WKUqw0ONXJCWqE7ijIl0Uf0nQcaYZLTqPFL+uYOs/uj8dzjwQPPHVoyVMvbXAwgOEALv
         9YveoQgc+K8ing6MaFYJipqCivUwRMbyLlvyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tea+4k1B/HQFagig/As/WEVEROeIYcdzTJzUHMCDyq0=;
        b=HC8z/xs1y9UaMnpX/fTmSZ8AAFiKChO3H1yXYPmUaMajDLJotOMZew2JQ5/V8Bs6hM
         5RFVr5pSd/DmmekFvhilj7spS1hzT0nSck+jDWw/UMLURNc4l7qvHy5wyRb8Fv9bD7t6
         WFlbuvgEp5Pgt7Oe8VZ2OpGy8t+oGK1PiLE6FEXjBLbntPBQks0kYQuUyUocfjS+ilXa
         r+Kw0h0OBwhA7QrWIMN8afiin59i9HSa9aGZXMXmuxAK7KaPCXg71vQKGI7r+THUhJN6
         Kha5zIljxpwOZoSKvf5OjgoXskdyWJ0muLTWZ/uQrJuwLaCJnr/zsaMZZloUftPuxC2r
         mOqQ==
X-Gm-Message-State: AOAM532r894Y10ZXjZia97WcAG2gZ8oMf68cZKu33nFSFAtZqudIHchO
        2jT8XH3XSzfM9R2FSIvkH+MDKUzWhGI=
X-Google-Smtp-Source: ABdhPJylhIhnNENbfi7W1GL+zX4CfGF2UHGvdg+Tt9XYpqW6IJS8W2c02KkO20fP2QKvbAnrB8GI2g==
X-Received: by 2002:a63:cb0e:: with SMTP id p14mr2156402pgg.351.1597295471265;
        Wed, 12 Aug 2020 22:11:11 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id fh14sm3720153pjb.38.2020.08.12.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 22:11:10 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 1/2] power: supply: sbs-battery: combine get_presence_and_health
Date:   Thu, 13 Aug 2020 13:10:07 +0800
Message-Id: <20200813051008.3461515-2-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200813051008.3461515-1-ikjn@chromium.org>
References: <0200811065307.2094930-1-ikjn@chromium.org>
 <20200813051008.3461515-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch enables calling sbs_get_battery_presence_and_health()
without checking its chip type. No functional changes.

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

