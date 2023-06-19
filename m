Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127D67350A9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjFSJoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFSJoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 05:44:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC5110
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 02:44:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31126037f41so2884316f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687167862; x=1689759862;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bH2JT5shA1ZCFvcaglwjqW7UABD2qxQkB1KrAzjhl8=;
        b=S0wMhyjgBOGreIIxEfZAfOkUYsWWm56FbYluy+MS0mHDnGqEmORtrD1sILTTPkJYjC
         TCE2oCwWwx2C5A6DKnYH2sTKxBcyxTTaTXnviNSueMoHfe1B5f4FVJ4CbUEZDgibOxO8
         VzeOXer6JBwIyFV2r4wQcPHPX+HBCwElGNZudZt7nPYSIfVza4yQ2Wms1q8qYqPXc+Kh
         SKSASspv/IdZ/Tr2z7V9R+pZIKj79tfWblTRdBIprWygn+C/1/mmdJVAW+ygtU3lxCB+
         AL7x5JHSNfgCoE5Ov3YKmMMRwmJzHuS0pkVFXmCQXS7tQHNlz7UX1pSh0wGOOW3TB3eJ
         Q49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167862; x=1689759862;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bH2JT5shA1ZCFvcaglwjqW7UABD2qxQkB1KrAzjhl8=;
        b=NYn6TQV14eqZZHDRg2/72vWotyvzS2FfbVJIQMyy+++YizJRKSZ2Td6rvFQmABJUXE
         3csXFwOBiFQpCeQ+53DoeAOd45AFuaG2h9jgxvig8JDQwSmv7IerSR5fN1Q6+jkgMxvm
         Qfhgg6VMCeoWVzv0ptnG8cVe6VBMdNT4cGamIRe71qCN+9D3+Zi5V1iZM4+kOfG9MFE3
         FHErnQcZD8CW8whrxk/obKp7CZmgo6Mjpltf8qr6U9+sOqjorccc/cUgc7X63ULyAZby
         7K2/+LdrN1a7gQtuECd/UUMu/WV11E1FR5SKnndeqoLapwVqiHEDcd4MO5G1NjnrPf1Z
         65eA==
X-Gm-Message-State: AC+VfDzsjD65krVySDyf/jAcN31InnF1B3NkLGvNq1lcwc7/aPGjZXIY
        I0D8M34VYjTG+S/LRX74Yx6aRw==
X-Google-Smtp-Source: ACHHUZ5MCCrMybm9Rw8Luk/2SxvFgO16uZEWMQ1yDMM964v2WNceij9RJswUQNdSdPnMz0KwY26Ojg==
X-Received: by 2002:a5d:590c:0:b0:30a:8995:1dbc with SMTP id v12-20020a5d590c000000b0030a89951dbcmr6605706wrd.26.1687167862345;
        Mon, 19 Jun 2023 02:44:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm31035025wrj.39.2023.06.19.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:44:21 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:44:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: ucs1002: fix error code in
 ucs1002_get_property()
Message-ID: <687f64a4-4c6e-4536-8204-98ad1df934e5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This function is supposed to return 0 for success instead of returning
the val->intval.  This makes it the same as the other case statements
in this function.

Fixes: 81196e2e57fc ("power: supply: ucs1002: fix some health status issues")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From code review.  Untested.

 drivers/power/supply/ucs1002_power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 954feba6600b..7970843a4f48 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -384,7 +384,8 @@ static int ucs1002_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return ucs1002_get_usb_type(info, val);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return val->intval = info->health;
+		val->intval = info->health;
+		return 0;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = info->present;
 		return 0;
-- 
2.39.2

