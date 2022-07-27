Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A965834A0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiG0VGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiG0VFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:05:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BA6050D
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so10792242wmn.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=gBmx9wqQLoqOz1G8d20izBhuJqPdHv57Lnkp1oGme86ifNa1BX5VaVX6Qxni4w11x0
         M5zasePCyPuhkkRG7E4ecxaZtVm3iRm5eHLpLZPBANzAUDlBB29l7RG7wxAdPCjmW+K8
         I3ErWXL6Gwezl/+usLr2NQm7fGLJM1fjDkrbCY+RZSK7VCNfKlRaiEg79sLuQ6TtiXWb
         BaaMSQ+T81j7SbXHZbGqpSl905NGyHTffwPDdGqHZXhrRr6lKrF0G2Z4cpEdNb8PTKnP
         aneAxR3IUSJHYeTylaPGo2J/cIAjCJMsSXhMh8D3cOr3wS1Ms7vEJsdwrjb8KMZlxRj3
         Figw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=ug/rwJBq9sJKcu16lHRf5liNVD8swzecvRYnqNPP8egOYZmWlXvuh3UAuLM8VBgE6E
         5QXnHCjjK58iJiTr57FKTLxGT9KfY023wgbTBwMad/4eJIhyUBDcd+1xv4JIj8tNiup7
         nytU5okq5zc7ZEHh2lYeH/gvbCspaOpdu8lIoZD8C6c1eYiwr5czGG7D5lXM2BHt3sqz
         Frl1cpVCcqx47EmBNK6Trpm0eWSrK/nFuVMJGqnWHqlx9Af7GdYGaP8zPzZV9jf9i5JU
         QdpHzwpUMm4rVp+gZCQ9oJbNklCrPKJbWnP4QP6GkaamzXSktDjp4V5bO+bws7VQQPkp
         Imog==
X-Gm-Message-State: AJIora/nsVaxUOjDvhuMnLimt4kmkNuDCjl6yvtp0pA7PnJZS7deoxoS
        ETF8EZiL+fSrXhM2oxzsseqSvg==
X-Google-Smtp-Source: AGRyM1ugHIvYzT8GdJW8TvjMkyTFgxeT9hbgI4acFLt2PD9dNPAlJfHZAYPec9JkG0vYfhz8FRL5JA==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr4242428wms.137.1658955858007;
        Wed, 27 Jul 2022 14:04:18 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v3 28/32] Input: sun4i-ts - switch to new of thermal API
Date:   Wed, 27 Jul 2022 23:02:49 +0200
Message-Id: <20220727210253.3794069-29-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 742a7e96c1b5..73eb8f80be6e 100644
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
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
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

