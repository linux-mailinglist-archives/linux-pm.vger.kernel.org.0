Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E558A399
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiHDWya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiHDWxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:53:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4337393D
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:52:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v3so1428725wrp.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=SZ6V+1lExXvLh4LvWQCQc1cdewDYX86v39ZS27fUDa5bAIvFFjdXQLUWZvlmfjnH1N
         ge8pL9ckIml8VuVvCF92rlWFFzdIem08ud8X6QULHEMjbr/EWtkgi36XYJC6a3/jZnbW
         2N9hK+T8Tk+ajtTWnWJr8ZXhf0NoGWhCNlmBsY+73OxL5ZlZfiXeVl+Mv8lySzSikIAK
         TWFtvEwj/BmrKQYun1QTJBYpnkJXataeeArL4rpRUgcpyhmXnhQj6h9ljsOihGVgyYTy
         ypsdiGlK8l49com6bhOHioAG9MRk5os3IP6kYEzhGOxachUcedNsaGmRtM89qcvDizXB
         P9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=FOSPKMCR9bwIThEhTn9BGKIhsfSqFtM/kW2SXsgvD28hn3/0Vlg29IHGBsYrabIvoG
         d8xTucdT5hmIP2/Z7nrMC5WGq/XOHxlaRtnesWTJGYccftEZLl1CxNiNSZ3LgbBo1bVy
         PnDJybKpw21NY8MOGuBWtBP0IrAvq0ZB5BMgPRsonyOorouexUPV6q+fu+KhadzUu3cl
         4n1O2QQq1P07DRojEUBAa7bd7J0vSAaogDRinsXdWr5UPOli5xaiU64WkVVQH3eJvMvP
         FW3OfxNVy9AQkWhmKQjArQgkYEJKTzdGWf5G8pwvZeBiSVB3WlnCzmyLLiYv+QFnXfrQ
         TcCw==
X-Gm-Message-State: ACgBeo1DU6xpLy25pOJogk9N4E3Z0pPxSZIl62WqqEQEl5nWDI/QlAmR
        RWzH8LSmxaSW1coZkTsFdL1eIA==
X-Google-Smtp-Source: AA6agR70LCT7ArA2AFR6OMTZ5hXElDUOJkkKBvF3u0JiAGSJmwxkhnwBTR5o4wkSEiuGv5OthtlOOA==
X-Received: by 2002:a5d:5a1a:0:b0:21f:a9b:62c6 with SMTP id bq26-20020a5d5a1a000000b0021f0a9b62c6mr2541655wrb.20.1659653568158;
        Thu, 04 Aug 2022 15:52:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:47 -0700 (PDT)
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
Subject: [PATCH v5 22/33] thermal/drivers/maxim: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:38 +0200
Message-Id: <20220804224349.1926752-23-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

