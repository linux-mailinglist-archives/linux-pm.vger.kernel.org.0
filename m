Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31458733D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHAVZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiHAVZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 17:25:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78740481F2
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 14:24:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l4so15625039wrm.13
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=NBHfTUiQ4g3pInNgtGa6G+ZzcWU2vJeUc9ioYtj8Zb2LMyDSXbT6NExwerc573eAAv
         rX6veJRX3zBYYgajn2kLXYMe5hVUyvvKRnpccYvYlWZmvgmDesMaZhTDERcCtV4pUY4i
         2ee6jzKv+E6p72MB/g5umhdvq36XAutBV9UY6fGdDnwb/lLoZBjGCi4NUFx8ZMLkf716
         VM6PlkvqWkExrqrX6iEcDVlDRGJyEYyTu4TQqk64NKXmWkhZ9SHFxFYM72EjhHLQF5tI
         iov5GDdVBgOeL6+XZf4tNOtflC5twMQXWr3IkjDT5CfFl+JUIVkqN0wS0cVqhrBqoiVy
         qAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y+8gnJ68hJod6uvQUR4L1wvFSKnRgzdO4yxaDxG616M=;
        b=bhC50KVf17AqTe56we/IyK6NTTrO+L3m0+f2rOLelGtcqZV6v/1jKip/oX6hR0Yfr5
         pWViSKejOp69UUrx9t78LZOmYecWxgpBwiGMwfDCyg++DZjcZ6/HpJAK19ozs94cd6Ak
         aK0z7lwTLtq6BTJdYRnHhXHEEVggv/p+tkXyShcWeLtvHf47clo/scNsu7f0ssGOCJNq
         G47FHyqTLz5ke1LMOHmkPfXi/dCBUFSc2V0SsjLtI2MYul0zwWIIBLUv7y/MQjj948K8
         HStjA+9AP1935AlMzPx6ED8skJiZ0zNMQsZEiVmm8IhQWJPi9Sncdw/FVClRtRmaZN4g
         92Kw==
X-Gm-Message-State: ACgBeo0hxHAhokYV22CT9Z/EYcsePgOQLhodMiqiQvAS/wokpRmetlrF
        AYjgWuaMJBn4L1XIBhE+Cc5apg==
X-Google-Smtp-Source: AA6agR6hyB/kUCbACq7Gy0CRy1027lqq3Q1zhRKL5RhO0ID4O5UIdq1Skw4yJfqYJSvtv55eIron3Q==
X-Received: by 2002:a05:6000:1447:b0:21d:b22b:e5d with SMTP id v7-20020a056000144700b0021db22b0e5dmr10663693wrx.189.1659389043799;
        Mon, 01 Aug 2022 14:24:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:24:03 -0700 (PDT)
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
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v4 25/32] ata/drivers/ahci_imx: Switch to new of thermal API
Date:   Mon,  1 Aug 2022 23:22:37 +0200
Message-Id: <20220801212244.1124867-26-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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

sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.

So in order to change the function prototype for the get_temp ops which
does not take a void* but a thermal_zone_device* structure, this
function wraps the call.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_imx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 79aa9f285312..b734e069034d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
 }
 
 /* SATA AHCI temperature monitor */
-static int sata_ahci_read_temperature(void *dev, int *temp)
+static int __sata_ahci_read_temperature(void *dev, int *temp)
 {
 	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
 	u32 str1, str2, str3, str4;
@@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
 	return 0;
 }
 
+static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
+{
+	return __sata_ahci_read_temperature(tz->devdata, temp);
+}
+
 static ssize_t sata_ahci_show_temp(struct device *dev,
 				   struct device_attribute *da,
 				   char *buf)
@@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
 	unsigned int temp = 0;
 	int err;
 
-	err = sata_ahci_read_temperature(dev, &temp);
+	err = __sata_ahci_read_temperature(dev, &temp);
 	if (err < 0)
 		return err;
 
 	return sprintf(buf, "%u\n", temp);
 }
 
-static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
+static const struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
 	.get_temp = sata_ahci_read_temperature,
 };
 
@@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			ret = PTR_ERR(hwmon_dev);
 			goto disable_clk;
 		}
-		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
-					     &fsl_sata_ahci_of_thermal_ops);
+		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
+					      &fsl_sata_ahci_of_thermal_ops);
 		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
 	}
 
-- 
2.25.1

