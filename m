Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2E4CE7A4
	for <lists+linux-pm@lfdr.de>; Sun,  6 Mar 2022 00:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiCEX1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Mar 2022 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEX1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Mar 2022 18:27:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608F6D4CD
        for <linux-pm@vger.kernel.org>; Sat,  5 Mar 2022 15:26:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l12so15562815ljh.12
        for <linux-pm@vger.kernel.org>; Sat, 05 Mar 2022 15:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHbjb2TfBARbvzWbfKXkyTdL+m7r0LW5kyFk/mbRIr0=;
        b=PV4phmuH7ZRD3+FqMDGFEf+/Pj/+QOmkaRWjEJCYQKVNATlsCJDHMFi0pIgmjL2KVD
         Fn08dSsrGnkflOye0iDUM296YnsrtfqOmxGUTguucrLFD6yu+7yWAIpdSF7AtYyFaEdA
         vtzBDOj4NSZUezcLFEm3OY4a/xkdjLtdrlkFROIEc/vFeICzBtnbgUAQyw8gFeTrq2uk
         jjQ0lNGzYt38OJx0rb9wZssSbeD3AjbgvOBUf0uJZmnT6Xrp6JvJwN8bJl6E8puwqOZg
         LReKFKzk+Dwn3GS6Bmen1y0VmF3luYNHI1j3OKXnbknTG+/ENqcuI00Hg4ruJFOkz5MS
         CObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHbjb2TfBARbvzWbfKXkyTdL+m7r0LW5kyFk/mbRIr0=;
        b=AER4atDexX3bB4SVbCZuLtGgpCUwhDESZfhKWcnSFzwjcrytMOJYD/pWvJIYpIJFzW
         z84xKwxJj0L3JbkLDig/NFwBTMDnEf7NxGP3/wv5QD/iMzoDkcd3X7Z3jrD5NxVE6Ku9
         c0JBOIsSzf228Wh+UnL0O6oc9QyLYL1eCtdX4irvQgczZ+UpL5ThVx+kKB41g7WIztRd
         z6c2D5vyX3lMnj+4WN2z/QsljdRHTeNHcD6AARgnijK4Y/je2xU50k0k8zcrMG5g+Tm8
         7MHgdxzNCk7T3Bjt0V1mDCAago4cPvXfLPHYX4quGBFz9LBBZ/HezC/N2xeb6FsDBwFt
         U97Q==
X-Gm-Message-State: AOAM530rlt99R2pyMKCIGrVkMr9dn6xwHFJSKy5elm9Urq3rQIKayFzU
        bIfmk5qeIClC7NzUZbHx0f8U9Q==
X-Google-Smtp-Source: ABdhPJxDbS69rT7seQ8ZtOAV3uNIY5WrW8LHE9KY3fUkRpYi3uPgVDkrR+7jlJoSBuebBgzliMfN8Q==
X-Received: by 2002:a05:651c:990:b0:240:752f:a224 with SMTP id b16-20020a05651c099000b00240752fa224mr3298487ljq.266.1646522783738;
        Sat, 05 Mar 2022 15:26:23 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2414b000000b0044826a25a32sm445144lfi.145.2022.03.05.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 15:26:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: Add missing charge restart voltages
Date:   Sun,  6 Mar 2022 00:24:20 +0100
Message-Id: <20220305232420.201726-1-linus.walleij@linaro.org>
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

