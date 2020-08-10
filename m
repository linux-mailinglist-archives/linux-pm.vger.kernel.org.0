Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9156624022A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgHJHCE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgHJHCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 03:02:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80754C061786
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so4418675pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZ2qWIvH6uYgIORKPoTfrdoIgrgh2dDxOhXUmAE4Cf8=;
        b=KpnqMHq7NBNilrVqaRbw3aKNsVXzWCb5INK7cp772AVWrsz4eH2oMHnii03HUKebDF
         sKwmAcBjk7W6fuU6t8JkjjFD4fW5OVsJA0Xkjnvk/fFKQuVuOaKBrsDpzhC5PL11XSji
         nZRnV82G0uWGtneq1UepSdXDlm+v5tMeDGt3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZ2qWIvH6uYgIORKPoTfrdoIgrgh2dDxOhXUmAE4Cf8=;
        b=Ua9aTLNwU4FNN9kfRrP2O1qyDrJd4qLSRr/0Vf/ccmwZuf/5dkJ7TlKWhF1UGqp+84
         eQJk6qSILwKq7Oi3KZOZfUg3VgstM/vqVN3M3B9Hre00otcHkRKIdTWVD9IFvkU8SV9m
         vsL+4hKF4AZP/7iL+OFoXtQMVBo6MS2C5N5ZbfLTngOcMiGnGXlfflC7/id7ukbr7YrS
         427KGu0LirzRYPYXBDj79pu0yK5IDPj1gpT7dUUKphQmOnAoJtAO4d0ZIq7fsgiLLrOD
         hKn9U0pjy4Mu0vxBfFQBXxhr0CKI+RglcBQnUi6mKjyBlzAn5dSVo8DDCt88Wh11BbwZ
         SbGA==
X-Gm-Message-State: AOAM530xp7/hpLufR0Kxto0sQ7ACSISeUTROfp4gX2s968IlS13Lv0U3
        iiNXiPOqpcOFTAYxI6MKPkgDsw==
X-Google-Smtp-Source: ABdhPJwq29g5B+z9vOnN/8SxV/4lwZhNZJ3DXjSvTK3I8zP9tzjif4SPCX6yHfMVVm+9lAwuebTscg==
X-Received: by 2002:a17:90a:ca87:: with SMTP id y7mr24937606pjt.102.1597042924000;
        Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id w7sm20620571pfi.164.2020.08.10.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:02:03 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] power: supply: sbs-battery: don't assume i2c errors as battery disconnect
Date:   Mon, 10 Aug 2020 15:01:59 +0800
Message-Id: <20200810070159.662863-1-ikjn@chromium.org>
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

This patch checks battery presence by reading well-known register to
check battery existence.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 73461321eb05..483f814385a3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -875,10 +875,17 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		ret = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, !ret && !!(val.intval));
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1063,11 +1070,11 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		union power_supply_propval val;
+		rc = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (rc < 0 || !val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.236.gb10cc79966-goog

