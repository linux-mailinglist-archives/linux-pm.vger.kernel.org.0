Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50A65AACF
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAARny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAARnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 12:43:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7E2DC2
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 09:43:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id co23so24367205wrb.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LMa3nqQehquNGKdG3HnNaWB4vayam0rDeBGKaKtFWo=;
        b=RtdAv8i4keVFE6uQvKWSBJ2G9Nu28bK/L11/CTwHHsHrLJaWJ6+xL2TTFicGOjpcKK
         fa88WsDDcKRYQqkxs5RkjzYeLSUKZasFnXNtE3GSXd0oy09UQMllMa26M5pQtlhFvOJJ
         eQYsa/kO4YGX2Vus83b4grNrCBCP+O5dlpZKQFRR4KXQE9FWqOfgA29WDmOz7oxwoRWe
         fA5nLwd+3HBXh4rkOxFx9vmhRsfeuhxBnERuNriig1tdna7WUYZHfMqhjgATezbFYFqx
         LmkHqHX/lZ2my8HQ6nKZFl0ZMRLXC95s8IVVZ75iWaUpIUEoeYdrauPOwnu/Oon9lRPO
         OCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LMa3nqQehquNGKdG3HnNaWB4vayam0rDeBGKaKtFWo=;
        b=pBUbY5U4F3lDfCc4NI2EhaXnYuSsg+cubhPeNRdW4pErR6Mt2fVE6l/8AKFTu0nkWk
         wxzc4wCQr4j4/dwzRGXxaJNLA4rsRrt6Bcba4VokT2t4Omv0ATXrfb0Q2Ei0hWZHkuIU
         vXxpRzVSwxhbZmbAJIEVEnmT1ycmm9jGi4wpjAzNraLqzsi7NYU9nMgB5tReABB6BmHK
         5SB58goBsZgMhPeU984LhvHXwRFCI9L8YKKrod+YKjCzZvx3iI5Ki/+DL0UVGrDwR6Ru
         CD6xmSaznMllAnNfTwcB5i2FP3nVLpdQ2vSHImpVES7sZebSjNwh7NFX3kMhxsO7eUPC
         mfEg==
X-Gm-Message-State: AFqh2koqwABkybMlxGYmb/YgR+Sez5qnoVLM4Ol5Aj5UIlpefK5yKpuv
        HaIvl+j9M4kEORrc9DFVYSPCDQ==
X-Google-Smtp-Source: AMrXdXt2F5Lf2EF0KsfyOsY/JdfMhOYOFBfdg56Dc0GVXwzpjWs3H2dlzEV2ek8vFyk62SYn8mZi9g==
X-Received: by 2002:adf:f28b:0:b0:274:357:6a12 with SMTP id k11-20020adff28b000000b0027403576a12mr21566356wro.55.1672595030475;
        Sun, 01 Jan 2023 09:43:50 -0800 (PST)
Received: from lion.. (host-92-24-101-87.as13285.net. [92.24.101.87])
        by smtp.gmail.com with ESMTPSA id ay19-20020a5d6f13000000b0022cdeba3f83sm7170582wrb.84.2023.01.01.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:43:49 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH] power: supply: fix circular dependency with cooling device
Date:   Sun,  1 Jan 2023 17:43:40 +0000
Message-Id: <20230101174342.58351-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A recent change in thermal/core means it now calls the cooling device
->get_max_state() callback during __thermal_cooling_device_register().
This creates a circular dependency as it attempts to fetch a power
supply property before the psy is initialised. Move this call later to
break the dependency.

Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7c790c41e2fe..c921111ff26a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1354,10 +1354,6 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	rc = psy_register_cooler(psy);
-	if (rc)
-		goto register_cooler_failed;
-
 	rc = power_supply_create_triggers(psy);
 	if (rc)
 		goto create_triggers_failed;
@@ -1378,17 +1374,27 @@ __power_supply_register(struct device *parent,
 	atomic_inc(&psy->use_cnt);
 	psy->initialized = true;
 
+	/* This has to be done after updating use_cnt and initialized
+	 * otherwise when __thermal_cooling_device_register calls back
+	 * to ->get_max_state() the psy core will return -EAGAIN..
+	 */
+	rc = psy_register_cooler(psy);
+	if (rc)
+		goto register_cooler_failed;
+
 	queue_delayed_work(system_power_efficient_wq,
 			   &psy->deferred_register_work,
 			   POWER_SUPPLY_DEFERRED_REGISTER_TIME);
 
 	return psy;
 
+register_cooler_failed:
+	power_supply_remove_hwmon_sysfs(psy);
+	psy->initialized = false;
+	atomic_dec(&psy->use_cnt);
 add_hwmon_sysfs_failed:
 	power_supply_remove_triggers(psy);
 create_triggers_failed:
-	psy_unregister_cooler(psy);
-register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 wakeup_init_failed:
-- 
2.39.0

