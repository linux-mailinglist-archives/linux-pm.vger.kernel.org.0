Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9C502FD6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351342AbiDOUni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 16:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiDOUnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 16:43:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED721D53
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:41:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u19so15588837lff.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHbjb2TfBARbvzWbfKXkyTdL+m7r0LW5kyFk/mbRIr0=;
        b=j0FtftBhi2NFsxyP4jfwVArQH+8y7k11/NbXRLe7+Pbq3ISI3Br+t5tB+isMn4vCla
         uz+CbEv2XKKCgkDMiyEo1jgHSicVG9gjM2Q+dSNGTLzwlzKJkHJWuvVY9+XEAVi6IgJ8
         fIt2F3YefNfPKUnRsSoow1mkAJ6aqL2Af9pRDKuH3iWGJXAlWd/rEtzuwOnmJS5JpTYr
         pESD0rotVwS5y+HzoT8cHPJ0yf7HlLl0xGdOVJwgjBpfTYZaQzzp+mIQuz1Q3JBYrT4K
         2047bFi7+0SU7KBjuljytxU91zGhv66DltrxOzCj4istpWTvFdo3RCQz/DX9tok3csnU
         RgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHbjb2TfBARbvzWbfKXkyTdL+m7r0LW5kyFk/mbRIr0=;
        b=kQW2LOoe+/1TCN2rzW2CT9y8N6hvetqNB9MRJ75kOvBO/FmJ3GjsBZw3JUIbCioPM5
         udEGeD7fprM1xA4mLMx/QJvsWARdaHBC0gJRE+RiMnhTkAoz7gKGI3v6bbxmqLHWrBMF
         rB4CF0O9yoVeKQ6dkPWKoMT8/fx2Bj2VBusAEYjjdKk/tLgEsUXAxKbVzInfottpg7Kg
         C0oi8FZYtjK96bMhwRsvQ354mx+NhlpSVJrIUERXBoWZ9IGaDBaQtv9bqNWkNlcGRZpB
         Wa4Jt7olYzIeF+lp5lpOaLV62/LDRlzYt0hrlD7v8t2DyNuSZt6FLgiONw+yxlBpi23C
         M2ow==
X-Gm-Message-State: AOAM532X1IKDU6BtTkdBqrbKS+xUwmGmW2oKBVB+qOGgmTUZ9KrtDBl3
        vczS24U6NmLB9q/vu7PbBZ6TkQ==
X-Google-Smtp-Source: ABdhPJwN+LiMi6/3kdcPIWeT8wScHX4Z94ASjXKDegavFXwlHS+8YBYEb5Zkk0iHssnH1lcfKNfD8Q==
X-Received: by 2002:a05:6512:13a6:b0:44a:3b54:42cd with SMTP id p38-20020a05651213a600b0044a3b5442cdmr432932lfa.73.1650055265269;
        Fri, 15 Apr 2022 13:41:05 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id i8-20020a196d08000000b0046d09ac99e0sm448144lfc.107.2022.04.15.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:41:04 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: samsung: Add missing charge restart voltages
Date:   Fri, 15 Apr 2022 22:39:02 +0200
Message-Id: <20220415203902.361177-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Two of the batteries were missing charging restart voltages,
meaning they can drain if the algorithm relies on restarting
charging at this voltage. Fix it up.

Fixes: c8aee3f41cb8 ("power: supply: Static data for Samsung batteries")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/samsung-sdi-battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 9d59f277f519..b33daab798b9 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -824,6 +824,7 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.constant_charge_current_max_ua = 900000,
 			.constant_charge_voltage_max_uv = 4200000,
 			.charge_term_current_ua = 200000,
+			.charge_restart_voltage_uv = 4170000,
 			.maintenance_charge = samsung_maint_charge_table,
 			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
 			.alert_low_temp_charge_current_ua = 300000,
@@ -867,6 +868,7 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.constant_charge_current_max_ua = 1500000,
 			.constant_charge_voltage_max_uv = 4350000,
 			.charge_term_current_ua = 120000,
+			.charge_restart_voltage_uv = 4300000,
 			.maintenance_charge = samsung_maint_charge_table,
 			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
 			.alert_low_temp_charge_current_ua = 300000,
-- 
2.35.1

