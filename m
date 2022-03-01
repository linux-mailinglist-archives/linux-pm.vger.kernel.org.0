Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3FD4C8BEE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiCAMpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 07:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiCAMpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 07:45:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA88D6AC
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 04:45:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bu29so26763106lfb.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dogCVIaGLNn7gaQQX6eAeL47siMQWDzUECuKLHBWVE=;
        b=FOfMeL4HppckZVBWJ6QRjSghKNOJz+yPIwRljMLCTS4qDx73iAqBdNqB4kG0oMftxR
         dyQ63t4CPLw4hTAuGSy+4KrPpIJuTni+zgtjXdZSYlQ+mf41bisXq2JzbGk2rgEaHzYX
         mfgaMoQKuQjkJbkaZVCv1i4U7EUvyz6teW1+xrDV95MryYLemk76xrOKE/p1Xy6LDm2V
         cYytVHn5v8d1loYwOBbgR/pg76jnhOaTRZqT0b7l4KtD4656A5TzMmxfQCSBKSadzkJW
         oMXzld5z0zb6/iFHLmhud1Wi7hsfMXiYglqcL5kd/zXTvNT8iCJKMGqvmQUMSZPmLxuy
         79ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dogCVIaGLNn7gaQQX6eAeL47siMQWDzUECuKLHBWVE=;
        b=J5beEa5i1abja5q+uIEbtvFGyVjJvFNx+/BFhEf++55DgrP2RW3kTIhZsqZFCGYarS
         aqicdhwnkHTxAdb16BUbqIMRlJvd/92GltfblMPGhXePhA0elCCixdvN90lXvTWQb4er
         pA2BBTTep74t5VMgtjddjCwWvozQiMEC4leSNQuD2dLI4ZiM5d4aottkAD9CNlY2VZSR
         pUx2pF2fZxqNm0k3JzDDSFDJNPO/2x3W81N/c9EEswvdQCZXC0ZNbQeqrHlAXF8hKE6M
         9+9IXwdCElfAwY8QdlQEM5e9yAKNgIGGwUpCe20mjGZWROYqCOgDzWWxTTZu6YkGTjqL
         /Q2w==
X-Gm-Message-State: AOAM533N9QHfpePxSvNzPxg1/8CAhEmdLO64LVKxPVeYR01sNHbqoGwN
        u3Ra393Q6wReyXISkEDS+8Qwng==
X-Google-Smtp-Source: ABdhPJzny9U8oWNrLuiII2AWsMf6ub28jbnBXkWVIP+l5yYA4iH2F58Bgxm+/SqYDRHewd2tRQcOOA==
X-Received: by 2002:ac2:521c:0:b0:443:2ef2:d690 with SMTP id a28-20020ac2521c000000b004432ef2d690mr15391241lfl.258.1646138709497;
        Tue, 01 Mar 2022 04:45:09 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g18-20020a19ee12000000b00443af3721f2sm1467944lfb.237.2022.03.01.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 04:45:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] power: supply: ab8500_fg: Account for line impedance
Date:   Tue,  1 Mar 2022 13:42:54 +0100
Message-Id: <20220301124254.2338270-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301124254.2338270-1-linus.walleij@linaro.org>
References: <20220301124254.2338270-1-linus.walleij@linaro.org>
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

We add the line impedance to the inner resistance determined
from the battery voltage or other means to improve the
capacity estimations.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 1abe10c7ff2a..3ae8086907de 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -213,6 +213,7 @@ struct ab8500_fg {
 	int init_cnt;
 	int low_bat_cnt;
 	int nbr_cceoc_irq_cnt;
+	u32 line_impedance_uohm;
 	bool recovery_needed;
 	bool high_curr_mode;
 	bool init_capacity;
@@ -910,6 +911,9 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di, int vbat_uncomp_uv
 		resistance = bi->factory_internal_resistance_uohm / 1000;
 	}
 
+	/* Compensate for line impedance */
+	resistance += (di->line_impedance_uohm / 1000);
+
 	dev_dbg(di->dev, "%s Temp: %d battery internal resistance: %d"
 	    " fg resistance %d, total: %d (mOhm)\n",
 		__func__, di->bat_temp, resistance, di->bm->fg_res / 10,
@@ -3098,6 +3102,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (!of_property_read_u32(dev->of_node, "line-impedance-micro-ohms",
+				  &di->line_impedance_uohm))
+		dev_info(dev, "line impedance: %u uOhm\n",
+			 di->line_impedance_uohm);
+
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	psy_cfg.drv_data = di;
-- 
2.34.1

