Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76629502FD2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350531AbiDOUlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDOUlN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 16:41:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0272441
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:38:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u19so15581890lff.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhELGrOOVgPcFGtEJejZf0g2WHh5ZLOtbqA5koG44Zk=;
        b=HDu27UTTZdHUtpoBv1b3CepLj+1upxM+qaiL2dsqgFof9mEk2bRlhAHGCQfDNcB6a+
         4092ggnSe1P8PMZwVxtgBfO3U1Wnf1NxXdkYP/xb9vZ4UNl/deOQvahLEnZ7iFeNI57O
         rjuRRG/AenvrSI+l9qrXfihHoWFBnE5ZJ2PyxvA+4+u+4K2ydjTKpjxo6afGZ7lB9tjp
         TY6DMofa+gr4bvLywZOgph45YKBnq2yE+U2Bd9qrAhDKtjX7uFmh4cXvb6YuywuZV2wb
         TCcQD8riGj0VJlQCQqujuOoTS6bu8Y3d4IgyJvx68GSk3DVfA+Dw7EZK+5lFRg7NiLuN
         MvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhELGrOOVgPcFGtEJejZf0g2WHh5ZLOtbqA5koG44Zk=;
        b=m0ccUXovKtCE9pIg+764h+fzXBZ+HbVTvzS3njnZKyFtdFrYcDTXUtYBquQ3rXe+xU
         oyMvaHqgvcQxRWGqOwpXet5e0v4RnignG/tLpwte7okCD2aIXp+BkAeneyeS0rDA8K7G
         1AL2NHa1z7QyRw2AlVuli1nZf5oR1PGEL4UjYcGtYqnb6T7Z4HuT9soNqlpebvYEKXR+
         BoKZVTBqpueCW8oKwXm7pAzm8kJ6ax7AgDxjYzqBvzfXVZlJz6xc9XbQLYXHE+MM1ibM
         cYL9Age621AhQX0oh5kXfr5lQlfr4oykcKc7CnRqyDtpqFBznS2WUd8Adl6miB33VM2q
         RqLw==
X-Gm-Message-State: AOAM531OumuRCm6/9jvgrElhZd4DPkt4LXGeimw5r2UpCaFhkmqBFwiL
        sRRZrQMTsF56Gciu3gSM4oAWExhiuOnp0g==
X-Google-Smtp-Source: ABdhPJwi0qhXhfOHOcJgoD32uFe8VmPnylacVML1fpXFs/DOS0TtjISzM5TfDUaN0DhWk6FaHkOnMg==
X-Received: by 2002:a19:505e:0:b0:46d:12df:d6b3 with SMTP id z30-20020a19505e000000b0046d12dfd6b3mr428121lfj.111.1650055122076;
        Fri, 15 Apr 2022 13:38:42 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e94c9000000b0024b4c2a1346sm375318ljh.123.2022.04.15.13.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:38:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] power: supply: ab8500: Respect charge_restart_voltage_uv
Date:   Fri, 15 Apr 2022 22:36:37 +0200
Message-Id: <20220415203638.361074-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The battery info contains a voltage indicating when the voltage
is so low that it is time to restart the CC/CV charging.
Make the AB8500 respect and prioritize this setting over the
hardcoded 95% threshold.

Break out the check into its own function and add some safeguards
so we do not run into unpredictable side effects.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_chargalg.c | 30 +++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 94c22fdfe963..b9622eb9fc72 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1216,6 +1216,34 @@ static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
 		queue_work(di->chargalg_wq, &di->chargalg_work);
 }
 
+/**
+ * ab8500_chargalg_time_to_restart() - time to restart CC/CV charging?
+ * @di: charging algorithm state
+ *
+ * This checks if the voltage or capacity of the battery has fallen so
+ * low that we need to restart the CC/CV charge cycle.
+ */
+static bool ab8500_chargalg_time_to_restart(struct ab8500_chargalg *di)
+{
+	struct power_supply_battery_info *bi = di->bm->bi;
+
+	/* Sanity check - these need to have some reasonable values */
+	if (!di->batt_data.volt_uv || !di->batt_data.percent)
+		return false;
+
+	/* Some batteries tell us at which voltage we should restart charging */
+	if (bi->charge_restart_voltage_uv > 0) {
+		if (di->batt_data.volt_uv <= bi->charge_restart_voltage_uv)
+			return true;
+		/* Else we restart as we reach a certain capacity */
+	} else {
+		if (di->batt_data.percent <= AB8500_RECHARGE_CAP)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ab8500_chargalg_algorithm() - Main function for the algorithm
  * @di:		pointer to the ab8500_chargalg structure
@@ -1459,7 +1487,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		fallthrough;
 
 	case STATE_WAIT_FOR_RECHARGE:
-		if (di->batt_data.percent <= AB8500_RECHARGE_CAP)
+		if (ab8500_chargalg_time_to_restart(di))
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
-- 
2.35.1

