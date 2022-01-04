Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D264841A1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jan 2022 13:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiADMZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jan 2022 07:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiADMZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jan 2022 07:25:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1AAC061784
        for <linux-pm@vger.kernel.org>; Tue,  4 Jan 2022 04:25:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so53184919yba.5
        for <linux-pm@vger.kernel.org>; Tue, 04 Jan 2022 04:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=prQTiZLznLqZ5+2hB9O27N1xUv+Alw1+Gsfjs0LUolU=;
        b=L/dp4Nhdz0lOG7M3GRsqIH/D6Zs9eJevRNLaTGWU2eKSPxFQQ7dUJqWpv1ogLXogea
         cMYA44jT047mndDVGbQ+KM4wVLljxO7uPPiJWeCYiaS+q6scQtlZwjou6dYt4NzLqvSo
         9R3NKz/0nLuaptqGZVGi8Vk8dqnLweFpPxSMN5RkUleQFPxbCXF8+xlF90C8Tu53tEji
         IpdWz1xQBjYcitr4JO2PTEE3w535AXFwK6l68R7j3lfbQIsWZR8zrC+jThap/VjSfJBw
         y3OQkkzmaAQ1441UNw8h7aztUv4y2ReP5g0e+xswUTHXOfX4cRWANGaVbHqWqkw3Xjyj
         gqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=prQTiZLznLqZ5+2hB9O27N1xUv+Alw1+Gsfjs0LUolU=;
        b=AaZwFUjPaBkihWi/s6srhgpXw6A8cTwQC5oR2wkCFVnCetTRwwSuEE4HGXZklIzvgQ
         jXFNwdJKD8eXyYoXxxAyqOd6eD+6jekVBv5wnFJkte41uA2VySGkEahhs9Mh4o+qJ9JF
         a7VJDGDecFyu4qKxhYfjsJNz0niSZm9KRyEX28uU4ZNIfZJHcMN62ZSFqR6cewRGWrQz
         pD0lLwodgthVh0nfekWO4mrufk1/V9vrJ3/cUqR0jGkTdfA3+gnBdoeGqgXO1HiFzHSN
         5gxFfR9OMvsTSL30Zh6y2XE4r1MtEUOEa9dpbeGBojgD0az8+ZZ/cHxgG4XZuY6UCKpc
         1nsQ==
X-Gm-Message-State: AOAM533PUOILwNAEiH/SOTyNo37EbuVM3vrCOoQhiFkKLV4HJsis6xaJ
        oSpsR7mQBxoWBSSgLXz0Fx2TACmRBg==
X-Google-Smtp-Source: ABdhPJz2gAA4J1A21mPQygq6+T6rFoBtqZJVjXY6aMYrh4yrjZ7M5WvXgxvSREJsqzeEZ6sl6vWREcwNLg==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:fe84:812d:a171:4b7e])
 (user=wjack job=sendgmr) by 2002:a25:cc55:: with SMTP id l82mr52843990ybf.408.1641299119492;
 Tue, 04 Jan 2022 04:25:19 -0800 (PST)
Date:   Tue,  4 Jan 2022 20:24:59 +0800
Message-Id: <20220104122500.338870-1-wjack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v1] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
index f7904efc4cfa..854299a0d36f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -34,7 +34,7 @@ Description:
 		Describes the main type of the supply.
 
 		Access: Read
-		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
+		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless", "Dock"
 
 **Battery and USB properties**
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..53494b56bbb4 100644
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
index 9ca1f120a211..fa80eaa54242 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -187,6 +187,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.34.1.448.ga2b2bfdf31-goog

