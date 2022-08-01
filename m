Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A2587317
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiHAVX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiHAVXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:23:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6282B45F45
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:23:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso177148wms.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KoCo3jVOreA60M5B2h+gu+yJSl6IxRYoUlnzq7WRBI0=;
        b=cDdZ1fw1VBXgwqqqsZJVe+iYyRklKK14Nx/crmCVIHw8nTjAmdzHAZrEMEIsHDSVaP
         bFwIIFVAGKzXoZu0VCb23bBjMJm/CUlPPCOnYKS+UGzltYOqJC69/9LrG/JUVnN093wV
         2slfXYfe4ct/rYqRfPjhBmRIX1SLdZaggvEumZIoB27zW548fVkCmpjSQTG+gFfvjvKZ
         QvKhvR9ltxkSwsJx/nYTJohoJSSn5CWwYskzduELDEk8LrNDOeuqaIs4cJ/Zr+idIUZA
         PNMxm2osYyDFLMpC+JUb0Sp09O4220nLucKU4j1gBK4e8Xk9KtIrUkocoCKqzkAA+0Zx
         N5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KoCo3jVOreA60M5B2h+gu+yJSl6IxRYoUlnzq7WRBI0=;
        b=5Eb1ATi1SBWVVpKo0u85GpcqAyqgXEMrAZwq+soUmbFu50liO4Fcs2o8f40rfe02GM
         uVXiyIHG2vz66ktFSvcvjWa31eN4AjAQCj5HCd+gSiscGdWQFS+wxhtZ3iSyA94yZOUu
         VdpuXrxwfROuvcqeWo5Ic2iYa+xnZt2KYtIGutk6veeKx/vYr1M5r22Qwab6yaMtDopl
         +RzpQTZxkxALgbpG/9KMvSWkCej1foBcOBiTXxfUhQXOutJSvYkEe6ZwRqw1wdQLbTcP
         fWqHBvCba0dBP1hNLQTE8YbgHVV7tWD/zzQtKrzA0ss25DkpBST5WwCfwfV7PpPjuFNw
         2muA==
X-Gm-Message-State: AJIora8wUuQK6QM3o7Y9VoIkTHM7kTGUwvtCPdbun8pAJqCOFkl1yM0L
        W1O7LYWWJtLexB7Udu1VXbh8Fw==
X-Google-Smtp-Source: AGRyM1spgzXBzeo0Wmzah9XtSnUDIxgfTDKPyUBrvUAZ6nl8rbTqKySOGK6nLYffuY5v1GTWMDPLtg==
X-Received: by 2002:a1c:720a:0:b0:3a3:327:da23 with SMTP id n10-20020a1c720a000000b003a30327da23mr12932289wmc.196.1659389001926;
        Mon, 01 Aug 2022 14:23:21 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:21 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v4 08/32] thermal/drivers/sun8i: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:20 +0200
Message-Id: <20220801212244.1124867-9-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/sun8i_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 212c87e63a66..e64d06d1328c 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -108,9 +108,9 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
-static int sun8i_ths_get_temp(void *data, int *temp)
+static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsensor *s = data;
+	struct tsensor *s = tz->devdata;
 	struct ths_device *tmdev = s->tmdev;
 	int val = 0;
 
@@ -135,7 +135,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ths_ops = {
+static const struct thermal_zone_device_ops ths_ops = {
 	.get_temp = sun8i_ths_get_temp,
 };
 
@@ -468,10 +468,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
 		tmdev->sensor[i].tzd =
-			devm_thermal_zone_of_sensor_register(tmdev->dev,
-							     i,
-							     &tmdev->sensor[i],
-							     &ths_ops);
+			devm_thermal_of_zone_register(tmdev->dev,
+						      i,
+						      &tmdev->sensor[i],
+						      &ths_ops);
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-- 
2.25.1

