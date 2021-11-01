Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786CB441591
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAIry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhKAIrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 04:47:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06640C061714;
        Mon,  1 Nov 2021 01:45:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v20so11089261plo.7;
        Mon, 01 Nov 2021 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyHgyvdYN9mfI560DHVzHVQgQloYct/ExUi3QqbzJbQ=;
        b=DkMEZBQF03H9D909AOR3mYOk3biz5rvdsg1TwLkKxjwj3D5Wy3gqk58br7FayxRcQG
         JG1j5O2sPkQ8cYn9vkIHRNCTbE1VRS6Wu79739HNB0/D14/axmZE5uvADwo7T/91mC1e
         FmXdh8uUajQA0ArjJf+gL3LwgjnpSJ6NlxwzxRfF48jP5WW7qo61Yg1bbmMW/qqKRSn1
         gnY0nKv1tPfqKUVG1EwmOoaEnesIHJIXfwr1QY2zMvZSOxnNEBOn7ynXjdll2GJsNCuV
         ZzYVfkRISlmabh3/1fGIQFurNgvJ8fGskggm79ZG0c4GRn1WK0uSZjjWV8HKP0FXqWrA
         NgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyHgyvdYN9mfI560DHVzHVQgQloYct/ExUi3QqbzJbQ=;
        b=H95DhivjCcyJonnA4edoufmLiAyzyTzfdYrWfuL1MXgFhQly7fE7BBKwCsrorCTEWl
         XHTIn1TJV9xp81b24x2hiq42VUZcr6N6SiLkLMryngYo/FlPy0RHAt1OZ5KJEMwJy0+U
         ZSL+Xw/AuR0JmxT0GWJpXs5vStkOpFVFo0mq69af8M60PXPhE7nBK0t+jaOHJ3C8P6Wk
         +s8D7k6hHvR+nnkkVcH96MfOoBW0Cq7dmDzOjwNVDR2lAleaxtf2kfwrHVJmbXuOqAmQ
         g535xDdaPBkxlDTtI2P18cTmbtWoQr40zdk7hHy7gz9CSHQIrGgLpw1nUbAyZrtqVjVA
         9IEQ==
X-Gm-Message-State: AOAM530o+Yj7MjqFPu5PQ85fp7M4vszchpYZWFf5E8kCUAuUQHdleRb6
        t9XZplbqAem+03svs09CniI=
X-Google-Smtp-Source: ABdhPJwe/eFzqFQVQnw9NEbyA+dGlCAQ0Q9E3lrvZp5WMSihk4tDej47vJGoWu5FxJGX5WDtVKk0FA==
X-Received: by 2002:a17:902:edc7:b0:141:a2d8:ede9 with SMTP id q7-20020a170902edc700b00141a2d8ede9mr20412013plk.24.1635756316261;
        Mon, 01 Nov 2021 01:45:16 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id nv5sm13406574pjb.10.2021.11.01.01.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 01:45:16 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 1/2] THERMAL: Add THERMAL driver for Sunplus SP7021
Date:   Mon,  1 Nov 2021 16:45:09 +0800
Message-Id: <1635756310-25415-2-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
References: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add THERMAL driver for Sunplus SP7021.

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
 MAINTAINERS                       |   6 +
 drivers/thermal/Kconfig           |  10 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 287 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..dff822b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS THERMAL DRIVER
+M:	LH Kuo <lh.kuo@sunplus.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/sunplus_thermal.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44de..6643a81 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -493,4 +493,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config SUNPLUS_THERMAL
+	tristate "Sunplus thermal drivers"
+	depends on SOC_SP7021
+	help
+	  This the Sunplus SP7021 thermal driver, which supports the primitive
+	  temperature sensor embedded in Sunplus SP7021 SoC.
+
+	  If you have a Sunplus SP7021 platform say Y here and enable this option
+	  to have support for thermal management
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e6..23f8dce 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
\ No newline at end of file
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..ab17fd7
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SP7021 SoC thermal driver.
+ * Copyright (C) Sunplus Tech/Tibbo Tech. 2019
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/nvmem-consumer.h>
+
+#define DISABLE_THREMAL  (1<<31 | 1<<15)
+#define ENABLE_THREMAL  (1<<31)
+
+// thermal_sts_0 last 10 bits
+#define TEMP_MASK 0x7FF
+
+#define TEMP_RATE  608
+
+/* common data structures */
+struct sp_thermal_data {
+	struct thermal_zone_device *pcb_tz;
+	enum thermal_device_mode mode;
+	struct platform_device *pdev;
+	long sensor_temp;
+	uint32_t id;
+	void __iomem *regs;
+};
+
+struct sp_thermal_data sp_thermal;
+
+#define MOO5_REG_NAME "thermal_reg"
+#define MOO4_REG_NAME             "thermal_moon4"
+#define OTP_CALIB_REG "therm_calib"
+
+struct sp_thermal_reg {
+	unsigned int mo5_thermal_ctl0;
+	unsigned int mo5_thermal_ctl1;
+	unsigned int mo5_thermal_ctl2;
+	unsigned int mo5_thermal_ctl3;
+	unsigned int mo5_tmds_l2sw_ctl;
+	unsigned int mo5_l2sw_clksw_ctl;
+	unsigned int mo5_i2c2bus_ctl;
+	unsigned int mo5_pfcnt_ctl;
+	unsigned int mo5_pfcntl_sensor_ctl0;
+	unsigned int mo5_pfcntl_sensor_ctl1;
+	unsigned int mo5_pfcnt_sts0;
+	unsigned int mo5_pfcnt_sts1;
+	unsigned int mo5_thermal_sts0;
+	unsigned int mo5_thermal_sts1;
+	unsigned int mo5_rsv13;
+	unsigned int mo5_rsv14;
+	unsigned int mo5_rsv15;
+	unsigned int mo5_rsv16;
+	unsigned int mo5_rsv17;
+	unsigned int mo5_rsv18;
+	unsigned int mo5_rsv19;
+	unsigned int mo5_rsv20;
+	unsigned int mo5_rsv21;
+	unsigned int mo5_dc09_ctl0;
+	unsigned int mo5_dc09_ctl1;
+	unsigned int mo5_dc09_ctl2;
+	unsigned int mo5_dc12_ctl0;
+	unsigned int mo5_dc12_ctl1;
+	unsigned int mo5_dc12_ctl2;
+	unsigned int mo5_dc15_ctl0;
+	unsigned int mo5_dc15_ctl1;
+	unsigned int mo5_dc15_ctl2;
+};
+
+static struct sp_thermal_reg *thermal_reg_ptr;
+
+struct sp_ctl_reg {
+	unsigned int mo4_pllsp_ctl0;
+	unsigned int mo4_pllsp_ctl1;
+	unsigned int mo4_pllsp_ctl2;
+	unsigned int mo4_pllsp_ctl3;
+	unsigned int mo4_pllsp_ctl4;
+	unsigned int mo4_pllsp_ctl5;
+	unsigned int mo4_pllsp_ctl6;
+	unsigned int mo5_pfcnt_ctl;
+	unsigned int mo4_plla_ctl0;
+	unsigned int mo4_plla_ctl1;
+	unsigned int mo4_plla_ctl2;
+	unsigned int mo4_plla_ctl3;
+	unsigned int mo4_plla_ctl4;
+	unsigned int mo4_plle_ctl;
+	unsigned int mo4_pllf_ctl;
+	unsigned int mo4_plltv_ctl0;
+	unsigned int mo4_plltv_ctl1;
+	unsigned int mo4_plltv_ctl2;
+	unsigned int mo4_usbc_ctl;
+	unsigned int mo4_uphy0_ctl0;
+	unsigned int mo4_uphy0_ctl1;
+	unsigned int mo4_uphy0_ctl2;
+	unsigned int mo4_uphy1_ctl0;
+	unsigned int mo4_uphy1_ctl1;
+	unsigned int mo4_uphy1_ctl2;
+	unsigned int mo4_uphy1_ctl3;
+	unsigned int mo4_pllsys;
+	unsigned int mo_clk_sel0;
+	unsigned int mo_probe_sel;
+	unsigned int mo4_misc_ctl0;
+	unsigned int mo4_uphy0_sts;
+	unsigned int otp_st;
+};
+
+static struct sp_ctl_reg *sp_ctl_reg_ptr;
+
+int otp_thermal_t0;
+int otp_thermal_t1;
+
+char *sp7021_otp_coef_read(struct device *_d, ssize_t *_l)
+{
+	char *ret = NULL;
+	struct nvmem_cell *c = nvmem_cell_get(_d, OTP_CALIB_REG);
+
+	if (IS_ERR_OR_NULL(c)) {
+		dev_err(_d, "OTP read failure:%ld", PTR_ERR(c));
+		return NULL;
+	}
+	ret = nvmem_cell_read(c, _l);
+	nvmem_cell_put(c);
+	dev_dbg(_d, "%d bytes read from OTP", *_l);
+	return ret;
+}
+
+static void sp7021_get_otp_temp_coef(struct device *_d)
+{
+	ssize_t otp_l = 0;
+	char *otp_v;
+
+	otp_v = sp7021_otp_coef_read(_d, &otp_l);
+	if (otp_l < 3)
+		return;
+	if (IS_ERR_OR_NULL(otp_v))
+		return;
+	dev_dbg(_d, "OTP: %d %d %d", otp_v[0], otp_v[1], otp_v[2]);
+
+	otp_thermal_t0 = otp_v[0] | (otp_v[1] << 8);
+	otp_thermal_t0 = otp_thermal_t0 & TEMP_MASK;
+	otp_thermal_t1 = (otp_v[1] >> 3) | (otp_v[2] << 5);
+	otp_thermal_t1 = otp_thermal_t1 & TEMP_MASK;
+	if (otp_thermal_t0 == 0)
+		otp_thermal_t0 = 1518;
+}
+
+static int sp_thermal_get_sensor_temp(void *_data, int *temp)
+{
+	struct sp_thermal_data *data = _data;
+	struct sp_thermal_reg *thermal_reg = data->regs;
+	int t_code;
+
+	t_code = (readl(&(thermal_reg->mo5_thermal_sts0)) & TEMP_MASK);
+	*temp = ((otp_thermal_t0 - t_code)*10000/TEMP_RATE)+3500;
+	*temp *= 10;   // milli means 10^-3!
+	dev_dbg(&(data->pdev->dev), "tc:%d t:%d", t_code, *temp);
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+	.get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sp_thermal_register_sensor(struct platform_device *pdev,
+					struct sp_thermal_data *data,
+					int index)
+{
+	int ret;
+
+	data->id = index;
+	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+					data->id, data, &sp_of_thermal_ops);
+	if (!IS_ERR_OR_NULL(data->pcb_tz))
+		return 0;
+	ret = PTR_ERR(data->pcb_tz);
+	data->pcb_tz = NULL;
+	dev_err(&pdev->dev, "sensor#%d reg fail: %d\n", index, ret);
+	return ret;  }
+
+static int sp7021_thermal_probe(struct platform_device *_pd)
+{
+	struct sp_thermal_data *sp_data;
+	int ret;
+	struct resource *res;
+	void __iomem *reg_base;
+	void __iomem *ctl_base;
+	int ctl_code;
+
+	sp_data = devm_kzalloc(&(_pd->dev), sizeof(*sp_data), GFP_KERNEL);
+	if (!sp_data)
+		return -ENOMEM;
+
+	memset(&sp_thermal, 0, sizeof(sp_thermal));
+
+	res = platform_get_resource_byname(_pd, IORESOURCE_MEM, MOO5_REG_NAME);
+	if (IS_ERR(res)) {
+		dev_err(&(_pd->dev), "get_resource(%s) fail\n", MOO5_REG_NAME);
+		ret = PTR_ERR(res);
+		return ret;
+	}
+	reg_base = devm_ioremap(&(_pd->dev), res->start, resource_size(res));
+	if (IS_ERR(reg_base)) {
+		dev_err(&(_pd->dev), "ioremap_resource(%s) fail\n", MOO5_REG_NAME);
+		ret = PTR_ERR(res);
+		return ret;
+	}
+	sp_data->regs = reg_base;
+
+	res = platform_get_resource_byname(_pd, IORESOURCE_MEM, MOO4_REG_NAME);
+	if (IS_ERR(res)) {
+		dev_err(&(_pd->dev), "get_resource(%s) fail\n", MOO4_REG_NAME);
+		ret = PTR_ERR(res);
+		return ret;
+	}
+	ctl_base = devm_ioremap(&(_pd->dev), res->start, resource_size(res));
+	if (IS_ERR(reg_base)) {
+		dev_err(&(_pd->dev), "ioremap_resource(%s) fail\n", MOO4_REG_NAME);
+		ret = PTR_ERR(res);
+		return ret;
+	}
+
+	dev_dbg(&(_pd->dev), "reg:%p ctl:%p\n", reg_base, ctl_base);
+
+	thermal_reg_ptr = (struct sp_thermal_reg *)(reg_base);
+	sp_ctl_reg_ptr = (struct sp_ctl_reg *)(ctl_base);
+
+	// FIXME: enable thermal function - customize this part
+	writel(ENABLE_THREMAL, &(thermal_reg_ptr->mo5_thermal_ctl0));
+	// FIXME: it's just reg state. Clock enabled at different place
+	ctl_code = 0xFFFF & readl(&(sp_ctl_reg_ptr->mo_clk_sel0));
+	// writel(0x78F07810 , &sp_ctl_reg_ptr->mo_clk_sel0);  // enable thermal function
+	dev_dbg(&(_pd->dev), "ctl_code %x ", ctl_code);
+
+	platform_set_drvdata(_pd, sp_data);
+	sp7021_get_otp_temp_coef(&(_pd->dev));
+	ret = sp_thermal_register_sensor(_pd, sp_data, 0);
+	if (ret == 0)
+		dev_info(&(_pd->dev), "by Sunplus (C) 2020");
+	return ret;
+}
+
+static int sp7021_thermal_remove(struct platform_device *_pd)
+{
+	// nothing to do case devm_*
+	return 0;
+}
+
+static const struct of_device_id of_sp7021_thermal_ids[] = {
+	{ .compatible = "sunplus,sp7021-thermal" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
+
+static struct platform_driver sp7021_thermal_driver = {
+	.probe	= sp7021_thermal_probe,
+	.remove	= sp7021_thermal_remove,
+	.driver	= {
+		.name	= "sp7021-thermal",
+		.of_match_table = of_match_ptr(of_sp7021_thermal_ids),
+		},
+};
+module_platform_driver(sp7021_thermal_driver);
+
+MODULE_AUTHOR("lH Kuo <lh.kuo@sunplus.com>");
+MODULE_DESCRIPTION("Thermal driver for SP7021 SoC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

