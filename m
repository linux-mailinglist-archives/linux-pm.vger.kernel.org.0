Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20621857FE
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 02:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCOBw5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 21:52:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39355 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCOBw4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 21:52:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so4210815edu.6;
        Sat, 14 Mar 2020 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vm/GIUSLtBZh58O4fR2ur84bB8eyJdEcy/lVRET/Sj4=;
        b=ZFxixgYKxWSEZF7Wpg4iIXSTPzRjd4GLl2qa1W+n8hvCH1Fzz12RLheNcyo/z/1Zog
         DvYtGAmtv22sl96ZiscZtwJCKjhKQP58PY73u6u4KFgNQaQMgVA2RS5a9RSjw1W124Cw
         iwnmebe480+qsxZtHBHTgO9eCtZI6b2v6D5Z2BYI18kyIvW0aZUT6hGbcbIUutMqSWHE
         rI1s4XNTChJkGy0PqkZmKqFm6sTXxbHFng/WARvCtdzpZlgC2xUbMwsyvw8A6l2P+2TZ
         jmPd7ZBSvTLokd05kPSrmR9DuOdzTMY7Ohfp+S86ZiyZmFZy2tFtoP30aPpjUYXv1LWN
         7LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vm/GIUSLtBZh58O4fR2ur84bB8eyJdEcy/lVRET/Sj4=;
        b=tvhIgxAzQQ5i4V6scfPq2zonGmCpuNS8dOgS2XuEj/fduMIkjh1djolZkaGE6a6r9N
         PSuhhVljU9z9lKZxuEma7LllZdWh8FYPxW5Zg1R3VUqmTmWFqfKPUslTAxlJX1Qocp7y
         KWiHf7cDylJgpBgrCqSUuoOzvD4c2cW4xBA3Jy0jyEhwBKKhGySy+Y5yQ1nH0OBfuY7n
         TccABYCzSxOtOtRSfwTe7hAkD6iM1KPIALfUQRTuCan4WwwST6MGHU7aBsC68XA/jUW1
         LkAsVzGzngx0F3JYpTdHm7n7YvKUoAVZqSxz9GV7Ev7Ih1Lh+xJyLzklAJryW7eEgHJk
         cbIg==
X-Gm-Message-State: ANhLgQ2ls6OAMand5MRAf6GfX+V44vdrhlUxs55O0lbg466xcmV6HSkB
        qunBhRihxzfvYuJ/IjMLmWbV7H7APyc=
X-Google-Smtp-Source: ADFU+vv3dgbI2p7SKFWv4ib9SXdSi4OqvU7y0RiFBIJ/ZYC1UihfAoulcO/Ii46mB701PPXhNbjojw==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr5213982wru.110.1584230428121;
        Sat, 14 Mar 2020 17:00:28 -0700 (PDT)
Received: from localhost.localdomain (p5B3F731E.dip0.t-ipconnect.de. [91.63.115.30])
        by smtp.gmail.com with ESMTPSA id 7sm11394469wmf.20.2020.03.14.17.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 17:00:27 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 2/5] mfd: mp2629: Add support for mps battery charger
Date:   Sun, 15 Mar 2020 01:00:10 +0100
Message-Id: <20200315000013.4440-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315000013.4440-1-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

mp2629 is a highly-integrated switching-mode battery charge management
device for single-cell Li-ion or Li-polymer battery.

Add MFD core enables chip access for ADC driver for battery readings,
and a power supply battery-charger driver

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/mfd/Kconfig        |  9 ++++
 drivers/mfd/Makefile       |  2 +
 drivers/mfd/mp2629.c       | 96 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mp2629.h | 32 +++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 include/linux/mfd/mp2629.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3c547ed575e6..f3f0a2908f16 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MP2629
+	bool "Monolithic power system MP2629 ADC and Battery charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Select this option to enable support for Monolithic power system
+	  Battery charger. This provides ADC, thermal, Battery charger power
+	  management functions on the systems.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0f..d6c210f96d02 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -170,6 +170,8 @@ obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
 obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
 obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
 
+obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
+
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
new file mode 100644
index 000000000000..47a37eadf25d
--- /dev/null
+++ b/drivers/mfd/mp2629.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MP2629 MFD Driver for ADC and battery charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mp2629.h>
+
+enum {
+	MP2629_MFD_ADC,
+	MP2629_MFD_CHARGER,
+	MP2629_MFD_MAX
+};
+
+static const struct mfd_cell mp2629mfd[] = {
+	[MP2629_MFD_ADC] = {
+		.name = "mp2629_adc",
+		.of_compatible = "mps,mp2629_adc",
+	},
+	[MP2629_MFD_CHARGER] = {
+		.name = "mp2629_charger",
+		.of_compatible = "mps,mp2629_charger",
+	}
+};
+
+static const struct regmap_config mp2629_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x17,
+};
+
+static int mp2629_probe(struct i2c_client *client)
+{
+	struct mp2629_info *info;
+	int ret;
+
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = &client->dev;
+	info->irq = client->irq;
+	i2c_set_clientdata(client, info);
+
+	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		dev_err(info->dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(info->regmap);
+	}
+
+	ret = devm_mfd_add_devices(info->dev, PLATFORM_DEVID_NONE, mp2629mfd,
+				ARRAY_SIZE(mp2629mfd), NULL,
+				0, NULL);
+	if (ret)
+		dev_err(info->dev, "Failed to add mfd %d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id mp2629_of_match[] = {
+	{ .compatible = "mps,mp2629"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mp2629_of_match);
+
+static const struct i2c_device_id mp2629_id[] = {
+	{ "mp2629", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mp2629_id);
+
+static struct i2c_driver mp2629_driver = {
+	.driver = {
+		.name = "mp2629",
+		.of_match_table = mp2629_of_match,
+	},
+	.probe_new	= mp2629_probe,
+	.id_table	= mp2629_id,
+};
+module_i2c_driver(mp2629_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MP2629 Battery charger mfd driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
new file mode 100644
index 000000000000..32f0737f245e
--- /dev/null
+++ b/include/linux/mfd/mp2629.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * mp2629.h  - register definitions for mp2629 charger
+ *
+ * Copyright 2020 Monolithic Power Systems, Inc
+ *
+ */
+
+#ifndef __MP2629_H__
+#define __MP2629_H__
+
+#include <linux/types.h>
+
+struct device;
+struct regmap;
+
+struct mp2629_info {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+};
+
+enum mp2629_adc_chan {
+	MP2629_BATT_VOLT,
+	MP2629_SYSTEM_VOLT,
+	MP2629_INPUT_VOLT,
+	MP2629_BATT_CURRENT,
+	MP2629_INPUT_CURRENT,
+	MP2629_ADC_CHAN_END
+};
+
+#endif
-- 
2.17.1

