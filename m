Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A24CF082
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 04:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiCGDpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Mar 2022 22:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiCGDpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Mar 2022 22:45:06 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14915D5CA
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 19:44:12 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso122861227b3.19
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 19:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5hsSDKF2hxibRKdAOZqtgoiMABLvidZTZY6Q7kdG83c=;
        b=RlXb24MplPY74433fFv8w4K+KxTUczocebThBO+NCeJkU41+9DRe6HVYpYK36PRvVC
         W0rwIlFTqrdBsfTRdZdz5Frpsv9Sc/2HQAipjMTIhNmCWYUykQpF19ZxuCGBrH38h1QD
         G8D5hYQNTS3AivBowA52XqUUNO54x7/VWDSbUinplPOm3reRaNKBPH1UJ7V0HQvQtww8
         +Kgnqa7bHws8W/MdOCu9HTkfKzf6Oq1hs+4uENlwy4s+PaRO+M22MA4PPhphK30kiHkz
         +3LKlPSvW0pDJFLnGbJ8NEQeToj7xC6DppxviHLoDd9T3wTvhiLRRHPaIG9xb68naqVq
         N+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5hsSDKF2hxibRKdAOZqtgoiMABLvidZTZY6Q7kdG83c=;
        b=6BbpZ6969HrZFx4fLXu/2I6io7LfaoiV6kzW5fScz5lps4T1Amy1iQFXkNlD3pbj0m
         d/pH4ClsKfyWNjIpK2K8QD9424/cS+Yf9bGKqRVNh9kGJS0gnKCJLxkSDiJdoBK9mvMh
         cK086uQWjJRExssQr4l5NN09MJ4vvi03itBz+4xh8hVu6KtF41dEeGfF1O3rGvgLCEUC
         tpGR19Cmh2YSvdfEkIg3SS4OfBGHxka+UHoRtJqXTHVtjaDV81Nua9BYFh1dfnyrAet9
         JyJ12VHdmUWUXXu2CT+PA3nEzZyGQi47tDDH//5fvr9+NwWTVhqKQwYit8tiLLbTQpIn
         OOLQ==
X-Gm-Message-State: AOAM53204kj5H6rRlTDfIwefImkZGASNtgnVinLy9Vfu+7ijSrp3Fay/
        uotyL9EibBIshRlJlm/hydYUs4D+9Q==
X-Google-Smtp-Source: ABdhPJwBtu+UzQV6WUyeIYcs0BmQ9jLNT73tgg1C5sRndOkBzJxhP2vjOrICudqscR9VHLO+aAWzSPFOVg==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:309f:cb85:fb3d:7ae0])
 (user=wjack job=sendgmr) by 2002:a0d:fe43:0:b0:2d0:b2b2:2ed4 with SMTP id
 o64-20020a0dfe43000000b002d0b2b22ed4mr7150329ywf.355.1646624651935; Sun, 06
 Mar 2022 19:44:11 -0800 (PST)
Date:   Mon,  7 Mar 2022 11:43:57 +0800
Message-Id: <20220307034358.286657-1-wjack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v2] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dock power_supply_type for the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

Signed-off-by: Jack Wu <wjack@google.com>
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 859501366777..0b45d9d3a50f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -34,7 +34,7 @@ Description:
 		Describes the main type of the supply.
 
 		Access: Read
-		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
+		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless", "Dock"
 
 **Battery and USB properties**
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c0dfcfa33206..2b1f18b7f98c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
+	[POWER_SUPPLY_TYPE_DOCK]		= "Dock",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e218041cc000..8f0425f00803 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -189,6 +189,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.35.1.616.g0bdcbb4464-goog

