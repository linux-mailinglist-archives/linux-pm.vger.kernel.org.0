Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1596787602
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbjHXQu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjHXQuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 12:50:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB88199D;
        Thu, 24 Aug 2023 09:50:22 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9cd6876bbso11480a34.1;
        Thu, 24 Aug 2023 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692895822; x=1693500622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLSqqr6p1MYItW3pXcqRaVAFN1Hp7NsO7h0Ylat3w9g=;
        b=LPAXhLZXXZZH8GmCW0mAK2QadHlxqFtdJDOqVZlVF2CUwDcv3K7kHt4yRkH35pIdAG
         geSuzqu5f92nh6liLWSuAZDA/URLeIMgFBORMikaqmE/vXmDx/KTOQxhV/wicis1wGz/
         Li9VfutIvJhdXCe1jZ9mDr/+cmXe/Z3OcEMF5vvTV8aocNxJa1/AR2twlLFLHKno0ImW
         Iwmwl1EYjbfgWIK8zEu5kftBE/j1qq97gSu1WzJtbNhrAysUSklWY71jIq9BNaZYNelW
         9j2Qt4R6ysfhY5hRfme37Ru8UOcmlIUCFrWwV4wQNT0ieM7NeSImrspQ0Kai1uB9IrGe
         6ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895822; x=1693500622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLSqqr6p1MYItW3pXcqRaVAFN1Hp7NsO7h0Ylat3w9g=;
        b=TVwXySQZgoPTGYGg3SR5oXakt8yY6a5FVopLFuh76SueT4nvssbMpih8A+3dnPVxB9
         s7RC00MetobDjc0NbUhoDSPOYal/GzdghccNAJi0D3WMbMTTCTafVOIxMqBLc3vr1Pcb
         mUEnpFZrSDut75PI4sZFZtchnBOIjOakbK51Se9O7FaqNxwtqYHc0JlQXg44wItZYRY9
         pSJxTbb7oshd83AVSmFHKY9otb0cenCCRwSoZUFrZYarbjOTC4Pa5xS9Fl/qsFdGiGlP
         u8QZblzwoiU4C+EN4EYzjsqr310pM9Cmh8swrfs8471D23+9ODaj0kmGAqqiRqGotN3v
         Rf2g==
X-Gm-Message-State: AOJu0YwGnA9F7HDYTAZULNK1EXSUxZF791oHPaOcHJOqKNcXWq/aNohF
        svXkC+omoy9H7Cq64B6mlq8=
X-Google-Smtp-Source: AGHT+IEoUQ5wLDLKkmmvqArDFW9S9EynUQirmNwH7KZeZFMll0mGOe9K9/g3V+fj0IbdDvXndVba2A==
X-Received: by 2002:a05:6870:4690:b0:1b7:613c:2e30 with SMTP id a16-20020a056870469000b001b7613c2e30mr17829758oap.2.1692895822091;
        Thu, 24 Aug 2023 09:50:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:12f9:9354:2260:4588])
        by smtp.gmail.com with ESMTPSA id zf21-20020a0568716a9500b001c51990e2a0sm5697990oab.53.2023.08.24.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:50:21 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v5 2/2] thermal: imx8mm: Allow reboot after critical temperature
Date:   Thu, 24 Aug 2023 13:50:11 -0300
Message-Id: <20230824165011.569386-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824165011.569386-1-festevam@gmail.com>
References: <20230824165011.569386-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Currently, after the SoC reaches the critical temperature, the board
goes through a poweroff mechanism.

In some cases, such behavior does not suit well, as the board may be
unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce the 'nxp,reboot-on-critical' property to indicate that the
board will go through a reboot after the critical temperature is reached.

When this property is absent, the default behavior of forcing a shutdown
is kept.

Tested on a imx8mm-evk board.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v4:
- Went back to the devicetree approach.
- Populate tmu_tz_ops.critical inside probe (Daniel).
Changes since v3:
- Switch to sysfs.
Changes since v2:
- Populate tmu_tz_ops.critical inside probe (Daniel).
Changes since v1:
- Use module_param().

 drivers/thermal/imx8mm_thermal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..0ca3cba33f39 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
@@ -146,7 +147,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return tmu->socdata->get_temp(sensor, temp);
 }
 
-static const struct thermal_zone_device_ops tmu_tz_ops = {
+static struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -293,6 +294,13 @@ static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
 	return imx8mm_tmu_probe_set_calib_v2(pdev, tmu);
 }
 
+static void tmu_critical(struct thermal_zone_device *tz)
+{
+	dev_emerg(thermal_zone_device(tz), "%s: critical temperature reached\n",
+		  thermal_zone_device_type(tz));
+	kernel_restart(NULL);
+}
+
 static int imx8mm_tmu_probe(struct platform_device *pdev)
 {
 	const struct thermal_soc_data *data;
@@ -313,6 +321,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(tmu->base))
 		return PTR_ERR(tmu->base);
 
+	if (of_property_present(pdev->dev.of_node, "nxp,reboot-on-critical"))
+		tmu_tz_ops.critical = tmu_critical;
+
 	tmu->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tmu->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk),
-- 
2.34.1

