Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093458349A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiG0VFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiG0VER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:04:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F865FACB
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h9so26128081wrm.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=fI915wWv5VLxz0rswURfWkSLVmCZd2woNVcH+ipgxaVZci5A/CMK4ELQRYHHCJiuUG
         nIj+EZMqr8A1wPc6cqG89Hg0V0NwIa6bu+1MG+hOMDeaqrsKPM6Uv1fup2lzW0qC82Kv
         wXt5sK1uvvblfMEawvjrJShK4Xr9KVCWG5pjDuda61bBYy9yg8tRQ5IcDoa7fFTG9xXM
         ZH+DdmP6Mw8qlMcQPPb9A2N1fseCJbqgsFL+iFH2Ng1IIXPZ6FdJDF5qbrvpTfnzXwdR
         nrsaXHUwVKUIqsxQqe/UXqoAwF1DN9LhyBU8cBW/tmT3TVfYad5LhotVEPWnyY3wZHph
         415A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=NBzoZteOCxWEFe2rgVHfjAEmBrZ9blulERVRu5CNDDxxcs6iVaNZ204tBX/jW02bVl
         rrEBc+qPdUmAd7W2Usidc/wkHqFxoAUi0apMvN90/m31891GsHPrFCNCzuiK3rWffVnH
         wpkLJl6q+ySatFlDtza6V1cY5xmvEK0J/q3qZVXExlwDEQWVnOEtjSWIbam1UW1NMu5L
         hMe/SuafD6rodi7QFctnr7NRMDW76wUq04bVo/4+vPslOBSAHtz3u3IFTGQuxPdoawuE
         gH/vXefq+eOdrN3aaGbivzQoPLJqT0MgAg7jiTP7EjI8JD2XMH9CR2kixXDM2g/IEZZT
         mvyQ==
X-Gm-Message-State: AJIora9WyhO5iI4tqWONbwWkV/S6IfOCV3V/43bHGhfxhYWeEwSK1O6O
        Co3/PMFlOvCRlrkMDeHKAjCGwg==
X-Google-Smtp-Source: AGRyM1u5HR3o2qHI7XHCI6k7Zd/BQl8Da0e5A1W6fArXCvApkohU4SHRi8X4snF4KrFmTCTymBuRdA==
X-Received: by 2002:adf:fbd2:0:b0:21e:7f74:5df1 with SMTP id d18-20020adffbd2000000b0021e7f745df1mr12732845wrs.43.1658955842629;
        Wed, 27 Jul 2022 14:04:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:02 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 22/32] thermal/drivers/maxim: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:43 +0200
Message-Id: <20220727210253.3794069-23-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 drivers/thermal/max77620_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 82d06c7411eb..6451a55eb582 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -44,9 +44,9 @@ struct max77620_therm_info {
  * Return 0 on success otherwise error number to show reason of failure.
  */
 
-static int max77620_thermal_read_temp(void *data, int *temp)
+static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max77620_therm_info *mtherm = data;
+	struct max77620_therm_info *mtherm = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -66,7 +66,7 @@ static int max77620_thermal_read_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops max77620_thermal_ops = {
+static const struct thermal_zone_device_ops max77620_thermal_ops = {
 	.get_temp = max77620_thermal_read_temp,
 };
 
@@ -114,7 +114,7 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	 */
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+	mtherm->tz_device = devm_thermal_of_zone_register(&pdev->dev, 0,
 				mtherm, &max77620_thermal_ops);
 	if (IS_ERR(mtherm->tz_device)) {
 		ret = PTR_ERR(mtherm->tz_device);
-- 
2.25.1

