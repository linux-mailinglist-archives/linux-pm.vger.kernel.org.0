Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5372DD49
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjFMJHf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbjFMJHe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 05:07:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610341A1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:07:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b2b6910facso3139057a34.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686647252; x=1689239252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8VTC85npxbzTTiz7J8vOT5R1AzDbAm+HI0G+zkP/+g=;
        b=oFDfAjtzgx+It0GmNANydXBDbXDmgfg1rGAD4/w5jl+0V0GiACq5OE38w2/M8vsMzs
         FkfTvlHL82Gfrg8QSruKL9gtrnUCC9TTH1OgzcDqtulJ0lEWgLwwiO5HwA1BclJKktxk
         ieFm0spML0ubRNiPzEfH2JowNoyC9bPWKmz6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647252; x=1689239252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8VTC85npxbzTTiz7J8vOT5R1AzDbAm+HI0G+zkP/+g=;
        b=fFFebkfdBDVIj4Z467qUMjBxdomv+EDptGYgjCO7t2w1HJAzJTnEbTA62jPBp8BUcw
         ZyQHtRyFvmMrSduEsh2FSVvavYhmY83fTEL8r455z2qDJUobOOeBuRTn2L2j+yuZg60y
         OYPwbufeyGA24FMiwjXmrfhV7YS8kYy16N9kqvK0qGQtxw8raqRD25qk/8KEi8CDDsgZ
         t2gGLRgJ9n6xrQbCZJ71mlo+3q60tKGlCPUjY1ATFiY7w6JM/xjoKAiGChA1kyDlr/Is
         T9QpO8NOawIRD68jZWQRhAIdSBNVuo0gZkHfRlFlJKj9IKBAwm7pb89UFmxgqolovetA
         1Z1Q==
X-Gm-Message-State: AC+VfDwbYCMg0avTTrzbT0QpWSGilZGfOVxoPKH0n5WjCdSAjAomviqa
        6mAu4yE3DA1bh2u/Oj5IAnyMeg==
X-Google-Smtp-Source: ACHHUZ63A1yCDwHmmn69d8YPbxPDTz1rKrVi7mU2CU9rWpKWYlEVJjQo7HsKTV5K90CJDyEPYHL0MQ==
X-Received: by 2002:a9d:7559:0:b0:6b1:1f0a:80e3 with SMTP id b25-20020a9d7559000000b006b11f0a80e3mr8590848otl.20.1686647252706;
        Tue, 13 Jun 2023 02:07:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2d00:6d98:ebb3:585])
        by smtp.gmail.com with ESMTPSA id h5-20020a63e145000000b00528513c6bbcsm8902821pgk.28.2023.06.13.02.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:07:32 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: core: Avoid duplicate hwmon device from thermal framework
Date:   Tue, 13 Jun 2023 17:07:23 +0800
Message-ID: <20230613090726.1358199-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the power supply device being registered supports a temperature
readout, the core registers a thermal zone for it. The thermal core
would register a hwmon device for that unless told otherwise.

When CONFIG_POWER_SUPPLY_HWMON is enabled, the power supply core creates
a hwmon device. This results in a second entry, one which has a better
name than the one registered through the thermal framework. It could
potentially have readouts other than temperature.

To simplify the result, tell the thermal framework to not register a
hwmon device if CONFIG_POWER_SUPPLY_HWMON is enabled. The result is
one hwmon device with all the readings the device supports.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/supply/power_supply_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3791aec69ddc..4aa466c945e2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1305,8 +1305,12 @@ static int psy_register_thermal(struct power_supply *psy)
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+		/* Prefer our hwmon device and avoid duplicates */
+		struct thermal_zone_params tzp = {
+			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
+		};
 		psy->tzd = thermal_zone_device_register(psy->desc->name,
-				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
+				0, 0, psy, &psy_tzd_ops, &tzp, 0, 0);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
 		ret = thermal_zone_device_enable(psy->tzd);
-- 
2.41.0.162.gfafddb0af9-goog

