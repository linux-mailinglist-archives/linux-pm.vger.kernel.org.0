Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A984E5F9FFA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJJONp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJJONe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 10:13:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523189FF5
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 07:13:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u15so6901782oie.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LInEgpoLjaWQQiOfUSh68UQ+OYo/vhsuxJne2mnOIo=;
        b=msetRcFxjPB0OS9RwnY2i/qO8zzupocb1p1EQPWXuroErHxXofsdO9OmyGF2hkf4zM
         I8M5tc6oEn2gWPz613PG3fznesWHeoqquQQGgHsMaDMycYbIvhK0XKzNvbmk3OI4Pzgi
         Z86ShypFdi8hui3eeH37nJQefiXgNfInDyfUDAAwS7CFIDCFXMkeMe43v6hc3Gi6cHVq
         sCd0c0tfIJmBYDSPZbtOsSRPm/CBoK1wJpi2efOcTksCX6D2X3zXo9vgBx9qTUIjLBBA
         KV8fyVBtN5Z5VbPNu7Lo5FsatbQP7AEy5iIJl+g0YiQyGc06JWDB/aKsqS6Fjq5X3uuX
         ng/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LInEgpoLjaWQQiOfUSh68UQ+OYo/vhsuxJne2mnOIo=;
        b=dq41o7oFvuTyRHLcFEGuZSskpGTDT3UQwvrAlf1DxgVrJyElnsR4N+Ju5lj5OkOoE1
         6sGDEnKZNlLQm7OXxUEQ5zIJncmSyeosF/oqsj4Cjk1+hdJ0wii/5FTfmuHDHRaFGcG0
         TLPP6ZFTC72/6bNS1yj/Qgt+hqGY+W7crgvmo4UKTFIkvKjXd7VTzF8oInwXUHuMIoxn
         H+2zf0w2qqrYc6KWFZq2v/l5pUWKdOM8ioCYzi9DXT5cfYNlUmsAYUnMZ9jnfmh7X+Xs
         XfGG94t0R1ph9Jgc8rhRKMOmBchY0is6Nyy1uFKlFZzm6/ZdkFDzU/TeQX074a5P8qMz
         sjMg==
X-Gm-Message-State: ACrzQf1EGhwPtOdgqFiG1+vTMU0UXx2AT0WUY/kQGw8mxcTR9j/zYU+X
        J5QB4IA8AmoXrxZO22EUtnUCvZt7cjM=
X-Google-Smtp-Source: AMsMyM4tTbLvRZVT6or3frYc8rgERrfRQomPpvU5Vq8WJrGUBiBXArzD7vyaoSpBLhfzufhH3XaIvw==
X-Received: by 2002:a05:6808:1717:b0:334:9342:63f1 with SMTP id bc23-20020a056808171700b00334934263f1mr15323815oib.77.1665411211351;
        Mon, 10 Oct 2022 07:13:31 -0700 (PDT)
Received: from wintermute.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id q66-20020a4a4b45000000b00475f26931c8sm2901694ooa.13.2022.10.10.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:13:30 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     maccraft123mc@gmail.com, lee@kernel.org, sre@kernel.org,
        dan.carpenter@oracle.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] power: supply: Change rk817_chg_cur_to_reg to int
Date:   Mon, 10 Oct 2022 09:13:29 -0500
Message-Id: <20221010141329.10006-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Change return value of rk817_chg_cur_to_reg from u8 to int. If the
function fails to find a suitable value it returns a -EINVAL, but
defined as a u8 it would not return correctly. Additionally, change
defined variable that stores return value from u8 to int.

Fixes: 11cb8da0189b (power: supply: Add charger driver for Rockchip
RK817)

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/supply/rk817_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 635f051b0821..305354d99177 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -121,7 +121,7 @@ struct rk817_charger {
 #define ADC_TO_CHARGE_UAH(adc_value, res_div)	\
 	(adc_value / 3600 * 172 / res_div)
 
-static u8 rk817_chg_cur_to_reg(u32 chg_cur_ma)
+static int rk817_chg_cur_to_reg(u32 chg_cur_ma)
 {
 	if (chg_cur_ma >= 3500)
 		return CHG_3_5A;
@@ -864,8 +864,8 @@ static int rk817_battery_init(struct rk817_charger *charger,
 {
 	struct rk808 *rk808 = charger->rk808;
 	u32 tmp, max_chg_vol_mv, max_chg_cur_ma;
-	u8 max_chg_vol_reg, chg_term_i_reg, max_chg_cur_reg;
-	int ret, chg_term_ma;
+	u8 max_chg_vol_reg, chg_term_i_reg;
+	int ret, chg_term_ma, max_chg_cur_reg;
 	u8 bulk_reg[2];
 
 	/* Get initial plug state */
-- 
2.25.1

