Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389A1241699
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHKG7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgHKG7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 02:59:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64489C06174A
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:59:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so7088135pfb.10
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFIXitVkGGB3OquEg0UyFCUv4pL9LxO2pe6bYqKtso=;
        b=jL63M1JnD3F1yArg7W8QNSlW8MlF3QrcrBCZ9t//W4XmKBRTEHGcw7GhYfX0EUuc+G
         DepzEo+TBYU7rr9vPQi8p5Nw1TbMB936DZsSp0xT82QBcQ+18zNeWpL5I/x51ZkA6+0B
         lw/3UMHs8ECfpoXdOidsP2GnLr6ZjvVxmi0w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFIXitVkGGB3OquEg0UyFCUv4pL9LxO2pe6bYqKtso=;
        b=m/hhxy9rcKzJLxq9RsJdgT2onCZQgicskEWx373w27vn6e0dhHzt0AYEppCQ0BRrYx
         v/LbPMM2NfmPM3OVdlLRA/Or0/gI2cgOlVnCdcEG1++jbU/ZD9uwbIkk7tXgSzEr4OTR
         CxsQzmFLrHctzDjCmpUbuSEPfIteQjEdqpJD46XkXCGipJ8z7Sp/+/ns8mdpTrzG9wng
         +KUNNqe5f7k1+vkZuOCwz5QoGY40OVy2kILJA5dtKTRk6IpXBDpja2J3rw7nOlWhl4iI
         fINfufkvYY8wSSWJyUxHs9yc3Ct4nu2ma11CnppSS5p0+mZWrvCXwBlw/3eEJeBjTmKH
         /w1A==
X-Gm-Message-State: AOAM531UytDuv04mOsD2XvnsWpN0N1yJ7COdE8yvt+PZTXW8slOyhy0W
        jlgXQimzA4qxNCVnryy3TrInHw==
X-Google-Smtp-Source: ABdhPJwt7VZ9y0TDCOyGtiXGInmj8RP3FEOipZFy9pMwd7HbGwe6zkcbWrDe3CwzHsUOOuEao9qkyw==
X-Received: by 2002:a62:ee06:: with SMTP id e6mr4734809pfi.313.1597129145927;
        Mon, 10 Aug 2020 23:59:05 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id b15sm20487599pgk.14.2020.08.10.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:59:05 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 2/2] power: supply: sbs-battery: don't assume every i2c errors as battery disconnect
Date:   Tue, 11 Aug 2020 14:59:02 +0800
Message-Id: <20200811065902.2100551-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current sbs-battery considers all smbus errors as diconnection events
when battery-detect pin isn't supplied, and restored to present state back
on any successful transaction were made.

This can leads to unlimited state changes between present and !present
when one unsupported command was requested and other following commands
were successful, e.g. udev rules tries to read multiple properties.

This patch checks battery presence by reading known good command to
check battery existence.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v2: fix return value checking of sbs_get_battery_presence_and_health()
---
 drivers/power/supply/sbs-battery.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6acb4ea25d2a..db964a470ebc 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!chip->enable_detection)
 		goto done;
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, val.intval);
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1067,11 +1074,12 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		union power_supply_propval val;
+		sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (!val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
+			rc = -ENODEV;
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.236.gb10cc79966-goog

