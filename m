Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDF5806B8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiGYV36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiGYV3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 17:29:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239A24BE0
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:28:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d8so17622842wrp.6
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=uisaYlWHlc1RSvh90hpzc7AOFByO6SZOCyDzOMnogH0ZogazNwnYVkQ9oEHpT9V+JG
         dHyb/dlixsReklVEcEGk1t6k+jnAlhFtWhmjsD+3vhap9Y7sdPNYwZ7n6GaWxIPg8VIr
         M5BrqdaX1YGUbos8NzxD1/HbBDMNiMxwh9Ej/3ahYypsbH2QRpvXUNFFpO122LDxygZ2
         yflNbmzyx/yfw4bJe7B+sh2esm9/YIr8r737zy8yHkSXxoJ9HTZd8sl7aRrYVW3GmYS0
         2Q2weVTqUyHsNYiQeuy4csaFK93xldDCTSdJ58OnQxYjMCQCfveEwsJ8VgVSkkaJoMe6
         yFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpAJvHnsGVgVYdV6CGwRXamKol+XLg/BJyowOdExSUs=;
        b=Uf2UksRBw1pyla0tq+tUecZkUaF/nwZA4v2Ou4lAabGi7NdYzq5HHgtdjYOc5vFmT7
         KylA1t5OtbTzEOllhfgLyI/q8gdraDtMf7QAnRcUefPgqtSwoUW44oWHlV109c1WQZnG
         H5db3kHHIPS3gEiF5ORyYYBujsfPVGocQuhfRz/VvoG3/UuMBkbUjnTE7TP/kRd3A/wh
         nj+RhU7a40PPMrTkdOm8nO6nfyu4miUtmzQh8u5xot/idkmMr7DweGOL9e+rEV78DXMl
         5pZarso7a58mpvw4u46j1KSBpjUXXl8xBGmVSBIrOCtFvTUfhCYmLMwTq098FcLgaKWH
         PXnA==
X-Gm-Message-State: AJIora+HsqCMPsnz32uZXKl+gy4PGZh606nW/axFRzzNmOg/wizl4i2s
        FNkZltooD6BAYegrWhpNcegx6Q==
X-Google-Smtp-Source: AGRyM1uI3wfXx2DOxmMhE1F+VbGqV3pN/W/4oQOzQ/VR/RxyuEoMWtDqsQfUPTNSt3/kwY1RVdJN+Q==
X-Received: by 2002:a5d:4811:0:b0:21e:3d86:a2df with SMTP id l17-20020a5d4811000000b0021e3d86a2dfmr9104284wrq.633.1658784483998;
        Mon, 25 Jul 2022 14:28:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:28:03 -0700 (PDT)
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
Subject: [PATCH v2 28/32] Input: sun4i-ts - switch to new of thermal API
Date:   Mon, 25 Jul 2022 23:26:33 +0200
Message-Id: <20220725212637.2818207-29-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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

