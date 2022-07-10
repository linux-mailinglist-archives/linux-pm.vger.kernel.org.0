Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29956D186
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiGJV0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGJVZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1315816
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk26so4741275wrb.11
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHt96uT4Q7BwS4NdRXSU1MVIN9ZQRmgKBYoUqlA70sg=;
        b=FTmtHevb/2lCiduv1bxN2jNSRFQIRp1jQ/TUsaCdBwAW/diJI+MM6X5FtZpJwCzVf3
         xFWyF1+0v3PX7grCleGiUZm577zgV6OCoxe/iNYb6agevNc8T+GA5VXWgMU5cpaWYEBF
         7FDYF6mc+ZQkiaNF9fOgCkXuuWuHDE3v6XnFCI0Lfr/ViYuHr7P9EZThxmTbJYEqO7Lc
         3kEoa0C2AA2hLg3U7vfgE7HgyBpa1NzcFta7EJPcXQvO8K+9vcDp834AfTGXBZ0+eZqT
         D/ZCenPS+afAUNbazuch9U8MPl56fezX+Sfhj2+98avOEg11/9H4dBRFDs+0XsBTrxTT
         nMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHt96uT4Q7BwS4NdRXSU1MVIN9ZQRmgKBYoUqlA70sg=;
        b=UEK61xBHj1B+Rx7UPP9tQtcI3XlZjNvZamstO3AjPyrpsBFoXQw1anvWQgFJk90+xG
         IZhuLNrw9mFYte38n8ipcV2mH3cdoD/68EC4XgSsfGDrxqBYv6cqOVWxz7vs1vK3/FZe
         RvMFiXf7YyTtUv7JJ3uDtb626kk70hOMEzc6x4Sr93n7P2OzNM/cBOmE8OwaMVWDnAOw
         wIAuPEQr4VdgcXIoF/G1QK8+by6MMQLwkLIgPYZZaYvqW30ymNYfga5C4pQIPbE5jmOU
         2yATKCZ4rRNS2AlpjaWzjO4cA+RQ/yK25vqTLLtNi/Y6HZ0VcxQe0lWYKr/SZV3LLX8+
         sq8w==
X-Gm-Message-State: AJIora8aeLQoyt2CnknKNKoMiN2Cy5t1mvy7IJrMpEvgfIQGqiGkENor
        tDQU5Xgyu/aU5E6+gIPUwdH/8A==
X-Google-Smtp-Source: AGRyM1uU2a9N+Tlm73VXF1neUxMMjGVz19hV+EhKo6BBv9h2XUa3CSeloMqm50v7vGSnm5mdnJA8Kw==
X-Received: by 2002:a5d:6d0d:0:b0:21d:7ae5:22ee with SMTP id e13-20020a5d6d0d000000b0021d7ae522eemr13289006wrq.152.1657488321495;
        Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v1 28/33] input/drivers/touchscreen_sun4i: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:18 +0200
Message-Id: <20220710212423.681301-29-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/input/touchscreen/sun4i-ts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 742a7e96c1b5..7cee09504e34 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -192,12 +192,12 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, int *temp)
 	return 0;
 }
 
-static int sun4i_get_tz_temp(void *data, int *temp)
+static int sun4i_get_tz_temp(struct thermal_zone_device *tz, int *temp)
 {
-	return sun4i_get_temp(data, temp);
+	return sun4i_get_temp(tz->devdata, temp);
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = sun4i_get_tz_temp,
 };
 
@@ -356,8 +356,8 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	thermal = devm_thermal_zone_of_sensor_register(ts->dev, 0, ts,
-						       &sun4i_ts_tz_ops);
+	thermal = devm_thermal_of_zone_register(ts->dev, 0, ts,
+						&sun4i_ts_tz_ops);
 	if (IS_ERR(thermal))
 		return PTR_ERR(thermal);
 
-- 
2.25.1

