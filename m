Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4B56D17E
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGJV0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGJVZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD315724
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so4774473wrc.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWuLOj6nDfiApNSc64J2uRqACZX+IVavJuD3AMPKGUY=;
        b=cdYKu83P0gOPdJq4HqnHimBhZEQhFDIWWzxJRonAfn7A8HPPQ1Ra7rZ/q6UwVnfqm3
         AwqqjY8+BZYNYi1rFjHrBccBWZF9f7o7L4dL/eWanJc7IM+adwgjgN/ZEuojhpOFdvJJ
         9lAKbhl7+CSfOdVpINdyi2meeBdqKKWhggHBfJm0L21Uenxu6ekzeZ/BKa4cwsnTB7kb
         iREsWBLbQm6O4BI3/gLMkuCZMG6AwQ5yPN+iQPM84ZLXQOJoMfV3LXKBCQNk9OkSE9oP
         VSuXHjqgB31tAgwc/VXzGdxhh32uU53Twdu8mDKn9uuPvDrHy/OznX0++lluMvnnquf2
         kWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWuLOj6nDfiApNSc64J2uRqACZX+IVavJuD3AMPKGUY=;
        b=JE2VyzTN1A+NkD/ZL+Oj/c3huTVhKOXbwA69QAKjQvLAlhVPCUeMDZSwpF2J/p/nNX
         xQkBb7eWmZAoP68hEIsgNmftpueNJ6rNjXfdpy/GF+uu8+OShFBTQNbaaue8prS/BcsF
         L2wivTC+Ypged1biV/LdZg0XWTeYgRLV9V4n6yUFT72S6u/WJsFdUTIjrofEfNz6eEeT
         6gEQIovVKqTptfg28Dk22MHHfQPmiHpCh8bAu1QRxBbh41VlKqV5iSqv35x1sFyUBlV2
         wjvqT2lDw+Ajp7H2T0dHQsiN0F2/xBFbzlTzvJYJFj557E2k3Q6M+OiVYQWIyPHQDBcR
         32bA==
X-Gm-Message-State: AJIora9bKpg009qZ/p9hbNg0xV8P+T/Je6q4KhqXH7xk92c5ZALWSHeh
        f6vSRXPZJ5OzdrAmhYRZmgQ456x0krrF9Q==
X-Google-Smtp-Source: AGRyM1u7otQoNLhS1lQ+oub24K4MnjT+FBSWkx06RuIyOEGGrp95LgLnjfxEXYrnOsJCTwc0Ssd5Ww==
X-Received: by 2002:adf:e18e:0:b0:21d:8d22:bb24 with SMTP id az14-20020adfe18e000000b0021d8d22bb24mr14143838wrb.397.1657488315767;
        Sun, 10 Jul 2022 14:25:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v1 25/33] ata/drivers/ahci_imx: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:15 +0200
Message-Id: <20220710212423.681301-26-daniel.lezcano@linexp.org>
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
 drivers/ata/ahci_imx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 79aa9f285312..5ad9a890e71a 100644
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
+static struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
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

