Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C577249D75F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiA0BO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiA0BOz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB8C06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u6so2203886lfm.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmo1KPyQuJu1qr8r4resFl86vrFfdMW4m6+4mc83kkc=;
        b=mLMLwFsg1tlE2IOMyaIdgdjx2wtEypTmr8XhH8KBbXY3bvZB3sCM3BTqiD9fTE+CV4
         zfjUJyThw57Xt0TGFV24LXmbhs4HFV7H6ku+BC/OsWNxxIb4Qke4Xr8vnu9TuookmIbl
         IbCzFvZmtnfDNGd6oYUQ8gGSuxy05G8grEGeHQL80/gKFkwXpPpl3sr+Ewn1kTfykgOl
         j0CNwowxUdcPlk6lk4rZCweOzDDdV+y0IOc2SOX/BSfaaXrjWPVqhGr0EZJmZEPa32UK
         fDMKvZ6D65kogd8agTc7JSZ3ogL630USBph/QzUlH7jQQOWLBa3f4TLpSKNyWELRMC29
         qhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmo1KPyQuJu1qr8r4resFl86vrFfdMW4m6+4mc83kkc=;
        b=2XugEn8grDyBB2XPKjh415rFlnZ/gYBxgxghP2VO7eAez0bbp18KhUeifV3ThEVZ5U
         q0GaLpDy26qrX+hzkHFqPfPvkLiHB8jxIfxaVYgxdBkspL8ETFCrJifYfac0M/LQVh5f
         8+7+cm+9y2SRzgYmu8sNrklxkspNBXQbPsCCOQILGkqIrtgRKk8LB7jI9+PlLyf3oIE3
         8IuXNGohB/F/i9+exg1hWibRimx9s7VcV33S7U0Gbnpkbyn3UmRNFrmouH06/7EbAzSP
         hgoBRnYj00SuyOoxZDUpdS9HCrajhB+f7ewX5/jxS8lH/FSabk8RyJhOx8XY45U9tgVH
         Ze+w==
X-Gm-Message-State: AOAM531zMouq++95PHhME5CTqIEmV5WqRSawEOHZQzaqO64/uHBXcgZj
        ODbt9dcco/4MXu9etYCjaiWgrAL+5Ie9KCne
X-Google-Smtp-Source: ABdhPJyCyOPha657c/qDAwnxINoitSl7JRxjpUilpIACMRrCTxatsxfbYIB3vOJ8tKK4erCAqtNjMw==
X-Received: by 2002:a05:6512:1398:: with SMTP id p24mr1176929lfa.581.1643246093655;
        Wed, 26 Jan 2022 17:14:53 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:53 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/11] power: supply: ab8500_fg: Break loop for measurement
Date:   Thu, 27 Jan 2022 02:12:29 +0100
Message-Id: <20220127011236.332687-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the Samsung code tree we find that it can happen that this
measurement loop goes on for a long time, and it seems like a
good idea to break it after 70 iterations if it goes on for
too long.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 236fd9f9d6f1..29896f09fd17 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -45,6 +45,7 @@
 #define SEC_TO_SAMPLE(S)		(S * 4)
 
 #define NBR_AVG_SAMPLES			20
+#define WAIT_FOR_INST_CURRENT_MAX	70
 
 #define LOW_BAT_CHECK_INTERVAL		(HZ / 16) /* 62.5 ms */
 
@@ -926,10 +927,18 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 		vbat_uv += ab8500_fg_bat_voltage(di);
 		i++;
 		usleep_range(5000, 6000);
-	} while (!ab8500_fg_inst_curr_done(di));
+	} while (!ab8500_fg_inst_curr_done(di) &&
+		 i <= WAIT_FOR_INST_CURRENT_MAX);
+
+	if (i > WAIT_FOR_INST_CURRENT_MAX) {
+		dev_err(di->dev,
+			"TIMEOUT: return capacity based on uncompensated measurement of VBAT\n");
+		goto calc_cap;
+	}
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
+calc_cap:
 	di->vbat_uv = vbat_uv / i;
 	res = ab8500_fg_battery_resistance(di);
 
-- 
2.34.1

