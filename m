Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE28587334
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiHAVZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiHAVYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:24:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D63459B1
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so14737wmb.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=7kH/6BqfPqfHpgF8aLj2FxU0sj26orMDLECovpm9Mw+K0JKZnb6mCayg0PRjUmls1A
         nnGDzn26KAy5XS39Imqv93DqLeI5kNje/Rck1xUra2u0D4f/yw8Ok3afaz+NP5TQ/F79
         PMH0DU/lImmWY8EeTJvk96OtXqpkbtt5zAxM5EbrK/AahDFO5LQdX1/3BPuQ//rPOPMm
         awfnWAoP14/MtAED6eZRRiAGZoyLNDSIRdS9Ouw+RCud8mtXS9yPhtPeBp/PdC60zfDc
         Se6wYL0O9CFkqbjNesFUQevwI3FfNR0wNEllv9MFxxwt4W4lB4MlSnNEXWTWbP9ssamw
         76hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f4QJf8ruUt+YX0IWOG7trN4ZQXuWHdSPHvGfzpjTqBk=;
        b=kq6R2I5NAryDrcOfV9+le58L8kdEHt3FhFomnJ9Rne+dQys2QQPU9dTwbdXHFRd3Jo
         Og9B7vuYPxWYz7vgXI8Wf9wfQT+Rl6JEEf1y0VuDNwL3OaXnZ+fRlhZOHJYEvWexhkcg
         k/gkFoe4MgShfQRbZeiuT/gjkbzPyge32O40jQzW/YgzSQPg9RXYXOUUpv8ntpadLQui
         a5THkOGfKfZ/23QrGxjzaS7EPcn25qCkrNTvsgmdMPrwp30gZi3IxBM//8o1TBNCa1Qo
         EHt3WzN4Nt5QvCp/VT22zG7h4ujjoz+zJkvtnzUsn0jpihkTbmArIMWRJNQgHGYqR1qY
         H2NQ==
X-Gm-Message-State: AJIora+8EejVi00w8S/ZhzNB61VAoY0aXhKrcgJZax+xzHQmfLxD0uxw
        WAJlqQRpPXMwYF4iOMNkMASxVg==
X-Google-Smtp-Source: AGRyM1uTZwUpQEaYRWrwPXVH9yL3knEa9rHrnPWrav0skfCkU7duYBUYLF6MpM0OYOmhZIIYohUWAg==
X-Received: by 2002:a05:600c:354e:b0:3a3:2ede:853d with SMTP id i14-20020a05600c354e00b003a32ede853dmr11710444wmq.61.1659389032980;
        Mon, 01 Aug 2022 14:23:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:52 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v4 20/32] thermal/drivers/mtk: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:32 +0200
Message-Id: <20220801212244.1124867-21-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..8440692e3890 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -679,9 +679,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	return max;
 }
 
-static int mtk_read_temp(void *data, int *temperature)
+static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal *mt = tz->devdata;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -700,7 +700,7 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
+static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
@@ -1082,8 +1082,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
+	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
+					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {
 		ret = PTR_ERR(tzdev);
 		goto err_disable_clk_peri_therm;
-- 
2.25.1

