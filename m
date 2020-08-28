Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35142553D2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgH1Egc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgH1Egc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 00:36:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D92C061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 21:36:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z15so74228plo.7
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORs9f1UOAtT2viX41nJ/6iEMC1Azc173oplMVvoqxmM=;
        b=f7OeKoa0Pcm7olyIzX+v5pd5mvHCvxUBvrlEDY0ekXqJSlL4WKknpzZqBJ/82maHea
         KQYEcrT0bf2VngjOOMPgDpy3lMHw8iO6VMSDPvzyaMz7GNygLd5UFjB5syxH/fZL3WBm
         0snaJ/U2+xKyKTFiQVQ+HupF+oSh7DNTRE0zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORs9f1UOAtT2viX41nJ/6iEMC1Azc173oplMVvoqxmM=;
        b=fC6DC3gdlJA/P+qBLeiYSmTdozz7YmVuntxa5MwieNgKOhkc/QJE3bkVGoWlWv58Ho
         Ql/iFY+kwn0RJMed5W4vz+8KKZza8tC1OgWe10DFggeNswapLuN+7lKT/u/3hGFCtpe/
         JszQdC0OhwzJzGv3KBPkNU3IFYYf/kOXwF6CJdh+qciNUh0Wib/WJBoyIrk68C2SiNWT
         FwklI75dyMtWdkZZ6PzoH5+RsCcbnH6o/Txy8dxocbhmGWEQvNtqtC+eaT/X2/htoZ7V
         wW3syt9OLMu5gxsZoaVNzJaCnjMBc3NL3HC/mxjnasTYvhQm99ULzPj5VJDB8Qz/MnvW
         zjNQ==
X-Gm-Message-State: AOAM533uUqpfqBc7lGZskXZ2dGbtDfIw3D4wuk3osqrt3gFc+Z75Yyff
        IQX3m0noR6IdY6GzweMenNcl7w==
X-Google-Smtp-Source: ABdhPJwFow1Lq1np1cDfVHJqKmvRPvzRdkF5nhcT1UTIhHeL+poe26lDXUSPP5pAwljJG7edd3FZEQ==
X-Received: by 2002:a17:90a:e286:: with SMTP id d6mr53814pjz.98.1598589390900;
        Thu, 27 Aug 2020 21:36:30 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id u14sm4568098pfm.103.2020.08.27.21.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 21:36:30 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        dianders@chromium.org, briannorris@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v4] power: supply: sbs-battery: don't assume i2c errors as battery disconnect
Date:   Fri, 28 Aug 2020 12:36:26 +0800
Message-Id: <20200828043626.1247250-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current sbs-battery considers all smbus errors as disconnection events
when battery-detect pin isn't supplied, and restored to present state back
when any successful transaction is made.

This can lead to unwanted state changes between present and !present
when there's one i2c error and other following commands were successful.

This patch provides a unified way of checking presence by calling
sbs_get_battery_presence_and_health() when detect pin is not used.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v4: rebase from merge conflict, amend commit messages
v3: check return value of get_presence_and_health()
v2: combine get_presence_and_health functions to reuse
---

 drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6273211cd673..dacc4bc1c013 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -959,10 +959,17 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >= 0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		ret = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, !ret && val.intval);
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1147,11 +1154,13 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+		union power_supply_propval val;
 
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		rc = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (rc < 0 || !val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
+			rc = -ENODEV;
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.402.g5ffc5be6b7-goog

