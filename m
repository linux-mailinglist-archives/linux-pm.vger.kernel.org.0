Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9172EDEA
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbjFMVb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 17:31:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DAEC7
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 14:31:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b33176880bso29936661fa.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686691915; x=1689283915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8LbxPg/8V/MfQI3qTkVSDFqyCwtGDaYq59JUG+YCjQ=;
        b=tje4n7o/XuNKXO53aeyjUKDd1IWnYMmqQwqergtbexFg8e+hmGNIcNenJ0eKLOFrlf
         y69TNiWM8RuCTPbdmgC9NKyFjJD/q0R6LzMgVrqQV6KVRftOjjuJSsMpu5JSUkltWMQl
         yvCrQZqBhIdv0E+b7ZLR7+zOeTvUnBWzcfbMk/chBH1muNLcDbKEik72e9sKM6RI0bIa
         8gwBKHs1+MpTNXgQuCnPTY9HzoheX9H9nj6CpQ7D2EelKh9cbAov7fXGWEsqJ5msvKRb
         YV8TgpgYeUwVyOZRnwZy8q3rgNfU2OiY5hEqspLqTCMOc/eLtjAKSd/ioiUBwnYS5uJp
         ogMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691915; x=1689283915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8LbxPg/8V/MfQI3qTkVSDFqyCwtGDaYq59JUG+YCjQ=;
        b=BsMb9sHeSWCKjqbbOHUPByoYlZn3kG48yuq2ayn/YiFoZ4fxoq0TEs6YbuKnb890IV
         39eCDjU8yXqPqLMq1tq7/DsYMjS1NkkFDVXAiyZQ7rdaqbR90BB7EcFlnHurZGnj7GYm
         VC5WcijCebRy4bXIZvxHeGVpSFzDss18yo7EOGrQe83N35dN3+k8cf9DSCg70slidpb7
         44L5FXgttWWlEQauofDPNDSdL3LJQqJDdsMfEKEJcvChOO7CNT1UWgh/kwU6eet8z1Np
         XEZNQo4xQZMNmVqgq2JH0NdFdpTd8TrK8iFgjk+N1qU6QfxK6J4CJXMaEJPT1a8kLtRR
         F6FQ==
X-Gm-Message-State: AC+VfDyBUmwBXVsvGcTxcv6nuwEuMLN4vKpvpBB/F/oi6IkYgvfz5dKy
        YyA/9SPZWEAT7lpUqbHTD3S9gg==
X-Google-Smtp-Source: ACHHUZ4UdAtikr7c+tsqrjtvYVUHluhMHbZ/th0yRtBBJxsw2qV9ixOMXqQnkWyCrN9puYokoIaH7w==
X-Received: by 2002:a2e:99cd:0:b0:2b2:4e86:510b with SMTP id l13-20020a2e99cd000000b002b24e86510bmr5807595ljj.13.1686691915018;
        Tue, 13 Jun 2023 14:31:55 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id s16-20020a2e83d0000000b002b1a3ceb703sm2317203ljh.6.2023.06.13.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:31:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Stefan Hansson <newbyte@disroot.org>, stable@vger.kernel.org
Subject: [PATCH] power: supply: ab8500: Set typing and props
Date:   Tue, 13 Jun 2023 23:31:50 +0200
Message-Id: <20230613213150.908462-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I had the following weird phenomena on a mobile phone: while
the capacity in /sys/class/power_supply/ab8500_fg/capacity
would reflect the actual charge and capacity of the battery,
only 1/3 of the value was shown on the battery status
indicator and warnings for low battery appeared.

It turns out that utemp, the Freedesktop temperature daemon,
will average all the power supplies of type "battery" in
/sys/class/power_supply/* if there is more than one battery.

For the AB8500, there was "battery" ab8500_fg, ab8500_btemp
and ab8500_chargalg. The latter two don't know anything
about the battery, and should not be considered. They were
however averaged and with the capacity of 0.

Flag ab8500_btemp and ab8500_chargalg with type "unknown"
so they are not averaged as batteries.

Remove the technology prop from ab8500_btemp as well, all
it does is snoop in on knowledge from another supply.

After this the battery indicator shows the right value.

Cc: Stefan Hansson <newbyte@disroot.org>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c    | 9 +--------
 drivers/power/supply/ab8500_chargalg.c | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 307ee6f71042..3662ca53941e 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -115,7 +115,6 @@ struct ab8500_btemp {
 static enum power_supply_property ab8500_btemp_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_TEMP,
 };
 
@@ -532,12 +531,6 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 		else
 			val->intval = 1;
 		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		if (di->bm->bi)
-			val->intval = di->bm->bi->technology;
-		else
-			val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = ab8500_btemp_get_temp(di);
 		break;
@@ -664,7 +657,7 @@ static char *supply_interface[] = {
 
 static const struct power_supply_desc ab8500_btemp_desc = {
 	.name			= "ab8500_btemp",
-	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.type			= POWER_SUPPLY_TYPE_UNKNOWN,
 	.properties		= ab8500_btemp_props,
 	.num_properties		= ARRAY_SIZE(ab8500_btemp_props),
 	.get_property		= ab8500_btemp_get_property,
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index ea4ad61d4c7e..2205ea0834a6 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1720,7 +1720,7 @@ static char *supply_interface[] = {
 
 static const struct power_supply_desc ab8500_chargalg_desc = {
 	.name			= "ab8500_chargalg",
-	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.type			= POWER_SUPPLY_TYPE_UNKNOWN,
 	.properties		= ab8500_chargalg_props,
 	.num_properties		= ARRAY_SIZE(ab8500_chargalg_props),
 	.get_property		= ab8500_chargalg_get_property,
-- 
2.40.1

