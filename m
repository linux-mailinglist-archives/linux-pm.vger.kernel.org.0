Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95545240227
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHJHAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHJHAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 03:00:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01540C061786
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:00:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so4634475pfl.11
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PaYSbxUwv9yN57+SOQkKrctAUvcnjUP0cxb1/WJhE0=;
        b=oT6WB9VWiwEyyuNd06z7NUUBS1FehmJmCyYO6su2+wkEdieupjHKgU/x0T4jnTzHSk
         QrT/DA1OJP6fFWMeYzICxc9egTpI5W0eTeu7CMxWWsw/F1fdbZ9IsNdz7/W6X7HL6q24
         4NafSgsLi17yCPldtgV55deAYbSuFj6Fbasok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PaYSbxUwv9yN57+SOQkKrctAUvcnjUP0cxb1/WJhE0=;
        b=mOFn4gcC+hKAYwVgFpsvRMLzQRSJnVSdIgCthJiP7K8+psKQdY7LLuxhxyHe2E7GZA
         MGSauVytsp0Fsb2s1kHfcYh/NxMZ6cwGreuik02/qNBg2mJYvsjRQ9Qk5Pa8VqHhQMpR
         R1L9apQsiW4JiuDCXW6yZagyselGZkGd4GtcUeFXBoFPPXvtWBjv2cs1Wj33hT+3kHT1
         8rp1ot1VJ0IKbY0+jNdfJvk6dUf8ObNDwEqjG3BE8nNAJrp6nImp5FYSaZOQvNV2gKJp
         p+5dT1AfJJTdxzYU2Ujd8N28iOgNxvzCjnsM/6KUkXm8CNdtdfS4tP+pwfx1SyfvDQxf
         dZqQ==
X-Gm-Message-State: AOAM532TikhBUHQ5D4C/ExXL3jy8qIHmaN0LMyuoeI6KuR0VMUr3OCzU
        giD4U7frNniWrg5oiFiaFrNK6A==
X-Google-Smtp-Source: ABdhPJw2i0Dvol67N+GLngD1ZyDfX7mf1ptT6RoKds5hIA498mdGWWDrDneWFcir1lcJl0+uWGyXvg==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr20608578pgu.367.1597042845922;
        Mon, 10 Aug 2020 00:00:45 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id h1sm21938651pfr.39.2020.08.10.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:00:45 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] power: supply: sbs-battery: remove unused enable_detection flags
Date:   Mon, 10 Aug 2020 15:00:41 +0800
Message-Id: <20200810070041.662662-1-ikjn@chromium.org>
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
 drivers/power/supply/sbs-battery.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83b9924033bd..73461321eb05 100644
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
@@ -1091,8 +1086,6 @@ static int sbs_probe(struct i2c_client *client)
 
 	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
 
-	chip->enable_detection = true;
-
 	return 0;
 
 exit_psupply:
-- 
2.28.0.236.gb10cc79966-goog

