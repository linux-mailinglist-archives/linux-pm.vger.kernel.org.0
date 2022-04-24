Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534650D59C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 00:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiDXWSK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Apr 2022 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXWSJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Apr 2022 18:18:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4195EBD9
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 15:15:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n14so2473891lfu.13
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoYSZl8d7UoAeK0KoVM4Rkf2mmoesyV+qZryaDA+DIs=;
        b=bmf2+Cvg7uqvVnCuKgR3yzR/f9v1nxScgBuw2hhMVLXFtgSxHLF5rt8giIZv5C6IFL
         Ql/n1fo0mVXnqBufcpyYOmSNFFu3Gd90UEyVEOlYMXMzOW0dAbiqgYLD8yQTqyJFNA93
         Wd96LYmHAC+3Tp5nc+/8MQ3Jk3irM1QWxdYCcRBF6+roN91RLy9SQHEbGtetBQdrjd5z
         rtMQCE/8wFscwEI+P+VR+uLI3MAKbtFM8DWepYKv9Cjk7n2FW8QaIeIual2fa5Tp3GRC
         v56uEgTuMgw7rHs352w0SKDbwY+bB3cJOP5/WRc77E20mZ5nAldDQafrDBTWv18BKt7I
         kOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoYSZl8d7UoAeK0KoVM4Rkf2mmoesyV+qZryaDA+DIs=;
        b=c/Q4itipntzQcXz2Jf7co4cMbHGlCceNfEybmZKFZEPf+Yz0C/QtU+Qj7gaF7fT+Q5
         uO94B0rEFnj7c5Xb4kJg/C6ul5RprLDN9GnS5CJ5R1fo4o/rqpEEYHDRKxQ0/pJx4MGC
         2B0Pg9jRzrxr1jEXC2vOcSVLP7DdkNpQufookbHpDjLPeIeR40OxIALAfTSzyBFFve+D
         Auf/rLkDjjN1qSJuJMhuqsFGiviG6ux/0ZB6JSA7qwnCY8/bu30maer3PiW6Qc2Cesgz
         6ZMcv2m7SGqHQgy2cpo0S+47W+eYEwg+ETFmp7wHeoZSnEufml0dtOsijL32A1N+nquk
         dAiw==
X-Gm-Message-State: AOAM533CEJRiIB0Dny/B7KOPTrUYfsAoZx6EQ8O1uoi22kcW+ZJFDRa7
        qU7k8iZb4FqzKu5GA2MLX2S6mA==
X-Google-Smtp-Source: ABdhPJxOeSiMzrYaTMQrV3hUvTXYjWm8yC/RrwTQCxIheBm1gzl+RpYu6KQIoH77+vx7Rfb+WCt/3A==
X-Received: by 2002:a05:6512:3ee:b0:471:f84f:7d5b with SMTP id n14-20020a05651203ee00b00471f84f7d5bmr5741995lfq.18.1650838505348;
        Sun, 24 Apr 2022 15:15:05 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b20-20020a056512061400b00471ff1f10absm483162lfe.247.2022.04.24.15.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:15:04 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: core: Initialize struct to zero
Date:   Mon, 25 Apr 2022 00:13:01 +0200
Message-Id: <20220424221301.1274428-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we rely on pointers in the battery info to be zero-initialized
such as in the helper function power_supply_supports_vbat2ri()
we certainly need to allocate the struct power_supply_battery_info
with kzalloc() as well. Else this happens:

Unable to handle kernel paging request at virtual address 00280000
(...)
PC is at power_supply_vbat2ri+0x50/0x12c
LR is at ab8500_fg_battery_resistance+0x34/0x108

Fixes: e9e7d165b4b0 ("power: supply: Support VBAT-to-Ri lookup tables")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d925cb137e12..fad5890c899e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -616,7 +616,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_put_node;
 	}
 
-	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		err = -ENOMEM;
 		goto out_put_node;
-- 
2.35.1

