Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED21D33715C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 12:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhCKL3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 06:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhCKL3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 06:29:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01AC061574;
        Thu, 11 Mar 2021 03:29:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so9206822pjv.1;
        Thu, 11 Mar 2021 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4w7jnZNAWVD7xmvwKvlkYQQ953D9+myIcvo+/vRtdQ=;
        b=rk01Ra2k1usSl2TLflOXsmqpVlbGxm5cg+Jb5pSoau9Oic0aasvC7AobkALccMH2/5
         tJ7V3BUBaMCbPS7usHHJ+ZFkOnnpDBNiNKBUf+jJjD2TaHTeNVrOM+DF+gv1/bHrOvlZ
         zKu1dOqNOc/1b1cn/jrZOsXul4Ir+i9lyzDGtzp61LA/011st7sYmnI0YEcQ0NaQxnsl
         tTpNLP+Vv0gKuYMlPcXPxLTSAoyB6pbXeFacgopNv8QDCZnIBntc71jugB5f2sHiuTDf
         yljkrCoW7aa5xf9XbDQeod8qZBmM/DNrXbaQH7zjGjcR6azdeqdznJzWH2N4CMbSd5Sp
         LR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4w7jnZNAWVD7xmvwKvlkYQQ953D9+myIcvo+/vRtdQ=;
        b=VxoYZAXPC+h/AW7s6qTDVvF6RwcTNsnhPwOPe+NYcLSBHctG+xmCNNZnFOcX43f024
         f6NQH85joktaGgxzdOEX3Xye9MhWy5mOYDAQvRLbl+UAA+CcdRVJBbxY2P2FNeRQzCZ/
         uuGnp7t96QB+WnUnvHdJTpERcNnV5Frtke2iQgQK+ZbLKxTHy9/Yrts21c/ZKQaJ/ODa
         rMypzxHj9aj+A5VlG+Z2RPAwFESGpzBtdkK0Pb+ObNbAZ5s1D0OS9kxm2UPJW8kZdxNm
         aXh779/UisPuoUPCLhXpIwn+R5DRHXe0XBtHkk+inA0PFb3SOKM5o2kIXpFwkSp9kxIW
         cM4Q==
X-Gm-Message-State: AOAM531+v9LcuSwLQJ5Ux8svT/dMxc5m8xBbeHBROkzc4gsV8wTNYlVD
        j6dFvnK2aNNyJk6lZyRPp1g=
X-Google-Smtp-Source: ABdhPJwi4Z5lycf6gmSVS1lTFLDGdr+xzvCwgc/N+rrG+HHCm753qeJuM1Kr2ifXZ4AfqzqGaYiB8w==
X-Received: by 2002:a17:902:ecc4:b029:e6:1a9f:3397 with SMTP id a4-20020a170902ecc4b02900e61a9f3397mr7559222plh.9.1615462176288;
        Thu, 11 Mar 2021 03:29:36 -0800 (PST)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 35sm2156595pgm.64.2021.03.11.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:29:35 -0800 (PST)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Xiaofeng Cao <cxfcosmos@gmail.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] Rectify spelling
Date:   Thu, 11 Mar 2021 19:29:16 +0800
Message-Id: <20210311112916.751-1-cxfcosmos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change 'stanalone'   to 'standalone'
Change 'mesaurement' to 'measurement'
Change 'nonvilatile' to 'nonvolatile'
Change 'unical'      to 'unique'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 drivers/power/supply/max1721x_battery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 1b1a36f8e929..32e2e919d054 100644
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

