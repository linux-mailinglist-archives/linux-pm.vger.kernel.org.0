Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B5502FD3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbiDOUlW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDOUlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 16:41:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB8716E8
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:38:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k5so15557341lfg.9
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKkjAiIszCawKWT8AUIwwswATWKraE4A1R8cDkeebHg=;
        b=uS/8zWpLHPctXa+DSmJnWO+wTt6g9CPaoJ3Y4ZxwKbGzkIeXLiDNoGUSNqC+coyKhM
         NvrVv6vSPdX/xL/Orb1CIU3yHbTSa67nVNvayxzJE2UcJDz9QClnQ0QzLAL/XO46MYSs
         hexmIFhnDZnRrnx5ntwSQzwPhB6oJybbTFP/c4j9fCBjhjbc8Gri2EtJhWh2GYiYWOZk
         xgZ0l3xqW79P+cdkNobTlo7/LyLVHybDQ5rA4CiskZfBTTvBy3uyRqp8wm9p+INI7eJY
         Rs/hQcXDeBRNZvadWi6HYHeyMmaaNLXQ6NWN0cwmbWo6l8U5XSf0/37QXq8zXN+aTOmy
         0apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKkjAiIszCawKWT8AUIwwswATWKraE4A1R8cDkeebHg=;
        b=ySqMolhzc5lQ746Eq4QhlrlbPVobETJUvAX0L6cUWyJY5q0dTVCq3F/oCIF7/7VOLj
         RUW228Y0ZKnIWZR++MikdpK1UeMrCuv9WpH/s95Yd/NnX07DnNzgpVXMeqWagT854TvA
         Ly+RSBbHdAKJA0wU59s2HYHLo2/TwBN05MkIgW6L4QyU+JWNsNBZxns1XFbswOZdJXSg
         CCI0xgfVl3iVtGt9E25mroFML51mXdMOououvMF2I4x0KIp8SxWKr/Owp+PCE321/l0d
         Vmq7eFGxGCfLevHxev+IV8mpkqg51oEXT5a4tWqGRhWqwKxr7sxi+ympfuE2EFZrmXVP
         lrSg==
X-Gm-Message-State: AOAM531YX1BjEGs25kCmwGaNS66UD9bR52lSdCwkwkWPRos968/txN+h
        aadcINpts6eeQ7ljkXesChc4xQ==
X-Google-Smtp-Source: ABdhPJxONdN21L3HPnFy1jWIgrZoipXV7+ND2O9QcosPJhPq7mi0mewmJ+QtPRIjleiPwvFro4iccw==
X-Received: by 2002:a05:6512:2308:b0:46b:c4e6:f3fd with SMTP id o8-20020a056512230800b0046bc4e6f3fdmr425651lfu.411.1650055131040;
        Fri, 15 Apr 2022 13:38:51 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e94c9000000b0024b4c2a1346sm375318ljh.123.2022.04.15.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:38:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] power: supply: ab8500: Exit maintenance if too low voltage
Date:   Fri, 15 Apr 2022 22:36:38 +0200
Message-Id: <20220415203638.361074-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415203638.361074-1-linus.walleij@linaro.org>
References: <20220415203638.361074-1-linus.walleij@linaro.org>
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

The maintenance charging is supposedly designed such that the
maintenance current compensates for the battery discharge curve,
and as the charging progress from CC/CV -> maintenance A ->
maintenance B states, we end up on a reasonable voltage to
restart ordinary CC/CV charging after the safety timer at the
maintenance B state exits.

However: old batteries discharge quicker, and in an old
battery we might not get to the expiration of the maintenance B
timer before the battery is completely depleted and the system
powers off with an empty battery.

This is hardly the desire of anyone leaving their phone in the
charger for a few days!

Introduce a second clause in both maintenance states such that
we exit the state and return to ordinary CC/CV charging if
the voltage drops below charge_restart_voltage_uv or 95%
if this is not defined for the battery.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_chargalg.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index b9622eb9fc72..1b23b5261881 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1514,6 +1514,14 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 			ab8500_chargalg_stop_maintenance_timer(di);
 			ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
 		}
+		/*
+		 * This happens if the voltage drops too quickly during
+		 * maintenance charging, especially in older batteries.
+		 */
+		if (ab8500_chargalg_time_to_restart(di)) {
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			dev_info(di->dev, "restarted charging from maintenance state A - battery getting old?\n");
+		}
 		break;
 
 	case STATE_MAINTENANCE_B_INIT:
@@ -1538,6 +1546,14 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 			ab8500_chargalg_stop_maintenance_timer(di);
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		}
+		/*
+		 * This happens if the voltage drops too quickly during
+		 * maintenance charging, especially in older batteries.
+		 */
+		if (ab8500_chargalg_time_to_restart(di)) {
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			dev_info(di->dev, "restarted charging from maintenance state B - battery getting old?\n");
+		}
 		break;
 
 	case STATE_TEMP_LOWHIGH_INIT:
-- 
2.35.1

