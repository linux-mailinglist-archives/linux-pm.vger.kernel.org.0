Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE63371E1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhCKL6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 06:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhCKL5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 06:57:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B35C061574;
        Thu, 11 Mar 2021 03:57:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t18so3350336pjs.3;
        Thu, 11 Mar 2021 03:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Md+pCA3Kui1jvX3JWGWDOlz+kcNBji2G/7qB9JjUzw=;
        b=dyOaG9/2zhOwjpMkAgZc0yyt25IyNvlkCd1DMi2r/xquo37eXdlH5CxCVTMrl/u325
         Ls6DqRc7UPPbwWQfsI7S2kl362KWDJlW58wwGRC01gX6/OMUMa9ykMOvBYw8bFRI9clR
         QKoFCrpEqjF58J/zdOjQtilZTKNxcB6VlWFv3a1uShEa5LSe5M93wW8140LHFjHAbDB7
         QECYL+I/MkiWiFBPUjswQpFMvrtQ3MvhQIFLttq6vswRdhlslrv5fvSDa1hNx1er/CzI
         yoCr+k0AtW9WlAO5OE3o40M3Vbr2YncLyNwf3qkFwWIIXcyFcw5Z41dhP023hK0x4lWL
         wTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Md+pCA3Kui1jvX3JWGWDOlz+kcNBji2G/7qB9JjUzw=;
        b=ODC6/teO3fghFk6Ov9oq+ECl5dCi1X+v6NfWsGbRSMB5psxho10kr8SGIu5cxnvQ51
         7Zl6hRrIN//L3mGMy3WqSHuQ4FjIUOhnw8T6rabrb/N/o7TB3sccLToC4QTOn0mn2XP4
         7rt39c23hAt+ghSb0xd5/2upZNzFqrAau7BQibYHx+c3Uy7UDihW59yl+62y4n/JMe8d
         /HlIlLH8i/SLJ00yCdeteTGhmCzqbqVndEaGenMHGu6C3mRoPFOVmf5fQun7XFb36cA/
         CGRT5MBfHra58yMTGVz7tot9UVGcZbnup++kGavX/ET6wxU5Oq3rfcI1UAAweTcYB+uh
         Vw7w==
X-Gm-Message-State: AOAM531pvDzKvC5MRpvlYaBO8ISVuLDEGb60YmqMO3dXe5KzdrBhz3zo
        DcG82Cmm3Pfy92OGJL/Fg4c=
X-Google-Smtp-Source: ABdhPJy5d6hESIgQG9qLtNPGi27ICWzYl8fVYg/OlrMfYthmbBJxTFr7eg9VyOFmUj/hh3ibipezpw==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr8931282pjl.139.1615463856721;
        Thu, 11 Mar 2021 03:57:36 -0800 (PST)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k11sm2116135pfc.22.2021.03.11.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:57:36 -0800 (PST)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Xiaofeng Cao <cxfcosmos@gmail.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] Rectify spelling
Date:   Thu, 11 Mar 2021 19:57:35 +0800
Message-Id: <20210311115735.1103-1-cxfcosmos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change  'stanalone'      to  'standalone'
Change  'mesaurement'    to  'measurement'
Change  'nonvilatile'    to  'nonvolatile'
Change  'unical'         to  'unique'
Change  'unaccesable'    to  'unaccessible'
Change  'correcpondent'  to  'correspond'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 drivers/power/supply/max1721x_battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 1b1a36f8e929..473e53cd2801 100644
--- a/drivers/power/supply/max1721x_battery.c
+++ b/drivers/power/supply/max1721x_battery.c
@@ -1,6 +1,6 @@
 /*
  * 1-Wire implementation for Maxim Semiconductor
- * MAX7211/MAX17215 stanalone fuel gauge chip
+ * MAX7211/MAX17215 standalone fuel gauge chip
  *
  * Copyright (C) 2017 Radioavionica Corporation
  * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
@@ -28,7 +28,7 @@
 /* Number of valid register addresses in W1 mode */
 #define MAX1721X_MAX_REG_NR	0x1EF
 
-/* Factory settings (nonvilatile registers) (W1 specific) */
+/* Factory settings (nonvolatile registers) (W1 specific) */
 #define MAX1721X_REG_NRSENSE	0x1CF	/* RSense in 10^-5 Ohm */
 /* Strings */
 #define MAX1721X_REG_MFG_STR	0x1CC
@@ -105,7 +105,7 @@ static inline int max172xx_temperature_to_ps(unsigned int reg)
 /*
  * Calculating current registers resolution:
  *
- * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
+ * RSense stored in 10^-5 Ohm, so measurement voltage must be
  * in 10^-11 Volts for get current in uA.
  * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
  * So: 102400 / 65535 * 10^5 = 156252
@@ -137,7 +137,7 @@ static int max1721x_battery_get_property(struct power_supply *psy,
 		/*
 		 * POWER_SUPPLY_PROP_PRESENT will always readable via
 		 * sysfs interface. Value return 0 if battery not
-		 * present or unaccesable via W1.
+		 * present or unaccessible via W1.
 		 */
 		val->intval =
 			regmap_read(info->regmap, MAX172XX_REG_STATUS,
@@ -334,9 +334,9 @@ static int devm_w1_max1721x_add_device(struct w1_slave *sl)
 
 	/*
 	 * power_supply class battery name translated from W1 slave device
-	 * unical ID (look like 26-0123456789AB) to "max1721x-0123456789AB\0"
-	 * so, 26 (device family) correcpondent to max1721x devices.
-	 * Device name still unical for any numbers connected devices.
+	 * unique ID (look like 26-0123456789AB) to "max1721x-0123456789AB\0"
+	 * so, 26 (device family) correspond to max1721x devices.
+	 * Device name still unique for any number of connected devices.
 	 */
 	snprintf(info->name, sizeof(info->name),
 		"max1721x-%012X", (unsigned int)sl->reg_num.id);
-- 
2.25.1

