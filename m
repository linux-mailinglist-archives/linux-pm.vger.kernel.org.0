Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A382415C7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 06:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgHKElq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 00:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHKElp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 00:41:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC905C06174A
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 21:41:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so1189203pjx.5
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mE27Q38brRQJRQFHecs3wbVF5vyzIo0pA5YfBnjEd0M=;
        b=dcwuxobTOVwsVWMExcu2c1u07wvKJPkUNKWxbz91PgELKLP2CMXHd9hz3m4ZbgJa5d
         GfEb1wxg9eB7K2iGnUeYoYysBiatdmXrfGk5jMCRb9mmSjHTWPXxzCwJ07UyVtdYbq1e
         9t/o5JoiiJ2/YZbnx6q9FOg3jOGLyeyB0jsCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mE27Q38brRQJRQFHecs3wbVF5vyzIo0pA5YfBnjEd0M=;
        b=hJrRKWXA05MdnRuE24B5DPv2kxbyNTCT5zy4SRF/SxMQG8VPjqVIymSPsBko70jBAb
         59ZZ1nE67fX+HecdMlf+9Zsah92JEjCt4DWf6F2SeeDPM5O67KnQrgFE/n4xRC3H1k7w
         ZC0Sn4cnEEsDCOfJSiUOatY72T2uvL/h0vFlfVVZsX0CDVnPbDLwwKD7UCbsdxssx4O3
         4JTAAtL46//IlY4r6mu9jscgxAQae8gBUctspWX0DuGwIrg6SLXHRg4Pmp5YjEewxqAN
         JR6MK9DagV/XVbHz0l5ObUe/MghayoubdlKD+DuP75Jf+Lk8fjVnlz3J8/LoxWsCB4s+
         fkHA==
X-Gm-Message-State: AOAM532Yh5AQ3iSS+zVO4xC0efu6EML2t/jTS4B3r4VQJmAow2AJPx7p
        KsqDq6xAD3j71E5y2Gw5ysqDJo5JsGk=
X-Google-Smtp-Source: ABdhPJypsimlIf0acj5/URTgwmBaduezmnRYRZrOC4WalSD0JGGMmZCrBV+sKMLyABO4swKCTXQ+OQ==
X-Received: by 2002:a17:90a:b386:: with SMTP id e6mr2826993pjr.57.1597120905375;
        Mon, 10 Aug 2020 21:41:45 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id l78sm445671pfd.130.2020.08.10.21.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 21:41:44 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2] power: supply: sbs-battery: remove unused enable_detection flags
Date:   Tue, 11 Aug 2020 12:41:41 +0800
Message-Id: <20200811044141.1821281-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unused enable_detection flag which is always true after
the device is proved.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v2: initialize work queue before registering power supply
---
 drivers/power/supply/sbs-battery.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83b9924033bd..1b706adc8d43 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -185,7 +185,6 @@ struct sbs_info {
 	struct power_supply		*power_supply;
 	bool				is_present;
 	struct gpio_desc		*gpio_detect;
-	bool				enable_detection;
 	bool				charger_broadcasts;
 	int				last_state;
 	int				poll_time;
@@ -876,9 +875,6 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->enable_detection)
-		goto done;
-
 	if (!chip->gpio_detect &&
 		chip->is_present != (ret >= 0)) {
 		sbs_update_presence(chip, (ret >= 0));
@@ -1007,7 +1003,6 @@ static int sbs_probe(struct i2c_client *client)
 
 	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
 	chip->client = client;
-	chip->enable_detection = false;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
@@ -1077,6 +1072,8 @@ static int sbs_probe(struct i2c_client *client)
 		}
 	}
 
+	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
+
 	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->power_supply)) {
@@ -1089,10 +1086,6 @@ static int sbs_probe(struct i2c_client *client)
 	dev_info(&client->dev,
 		"%s: battery gas gauge device registered\n", client->name);
 
-	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
-
-	chip->enable_detection = true;
-
 	return 0;
 
 exit_psupply:
-- 
2.28.0.236.gb10cc79966-goog

