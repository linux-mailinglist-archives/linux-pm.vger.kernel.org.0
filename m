Return-Path: <linux-pm+bounces-20004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB6A03B33
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6A71624AF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B781E492C;
	Tue,  7 Jan 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXmnxr9p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82581E22EB;
	Tue,  7 Jan 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242313; cv=none; b=qsqhOYJy3YGt0wooF3VgxTBr+fh1YrjrQZuJbqrFmf8emcGuBwDg+C+ER9SnTDbKSfRf/7H8ZXTR4j22PRi5BAtQI7rhxmSX6f6ofpHANPbM/8IBQ8NxsWQtF+jXLID8Rm7iXtP4buN6oyVti8VmqtzcfbvDeEy6+OfCZEC0DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242313; c=relaxed/simple;
	bh=/U5C+nfuke8YP3qpDkMfO7fqpvAqGnzMcDfWnXPrw5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC0KfHPmwQPQNsnLvWC9XAH/mVY+RfvqHtWYDeD37xyMgSwEh38t+tlimBcnzPqjWQnfH8vCWnm0mZUAOA35ollhzc43KdcyRL8LcYFpuj9zBco0e9GA7lym9NJyHcpsWJU+hxXxBNtOx2C0g/tSVlC8UXyVUhU3c1CtiP6QP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXmnxr9p; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso8501778a12.0;
        Tue, 07 Jan 2025 01:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736242307; x=1736847107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BB8jR7nXUYydyK9dfdg79I9SeH0rKSouMJyEMKtyGM=;
        b=LXmnxr9p7S8VJ4s0/GScz0JRJqBCXbvD8agouIsGiLBWZVA6U6LHdl59FwhCD9iur+
         R1hV0gpOmyLAjPTIdwibVt6G2xH0rrmlKteurfD/KNb0lUvzYZal3l6IvuSABnTwbbNW
         krztiiNaR8IKVeTAkeOaS2qtKuEKbw8ti/SNDMW9ZirElXILEjet7EWHvyIxHhcwtYBs
         R4jsajeMJy6xi/jYjYIxyjL4AskjqponlD6+o+QfIBK8J2h34ikLgHhbK3uP8YfgcrIv
         yPmRWaqAhvlnYgrKjsu0kuUipCM4jk0Fhs8/HlMz4ApEwgkkgzfKkxHBVf9qu8V5REgx
         1D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242307; x=1736847107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BB8jR7nXUYydyK9dfdg79I9SeH0rKSouMJyEMKtyGM=;
        b=pXEaK0hy+uIGTOiydeQk+PPV6UmpHxstHV34g2ORW/SgHc8+BeD2YGG8ki10Em+VCl
         dVjX9jPXDYMpiG5IJ1Wz0T0fizAZJOuvxtXeX/oKv9uQgbV9/+nVxKAe8SAfrhdv+Njq
         dUePyxXz+cHH6UtToukwB2jLL+QD1g3CdE/csoqbo11nOUjhT9d5l43UTUq/PfvzqReK
         0MQAMr/mhWlksrZIY5ZW9lCge+PDWAbNlI8by7BCpG4riBsUJ0LUrYuBwCVoirVh/ua6
         O4hsL/l1VaZ7s57+MWlEWl0/gnhWtwI+fZXfnT9Op/ABYzytglKYWRSWjcl4t4mcMRbj
         4ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCVKSos3KnUatuOAqvnXhw3M/hVeYwOjjw4YQcvII4Itnk9CDiWcuDlkoOzzTCZVOctOe1B07STt76K0lsdJf1J6nek=@vger.kernel.org, AJvYcCVtgqYmrnnJr97W7gpPRbKZhUArhs74h82Ejw2KcKyllu51+1Py5f89Iv4FrsLE1rz/CtsjPT8/j8DquIVe@vger.kernel.org, AJvYcCXIZUoqIRlmBT/qRQn/9c3sxXLdPc+KfI56asNg7fQXbsXh6w00vzr/1M8t/n4TO5dmTGCIiVMjoRNe@vger.kernel.org, AJvYcCXKf7MLkmZETh9T0iFel0W3ZeAowIIZnTMOAfJ92cNAVaKt2QduxxWMQ/UTxVocqTyD+2Sp1VHeO5YbMyzoUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31adRLYXpunSnIdMCblsbg6e+mvI3/hR0hxGLE0QZFMud0kFd
	cmFnfGuC8muK/AfiAqZKkdAAkyvoMVwEKgznqY7VKAE510GkiC4W
X-Gm-Gg: ASbGncv71Ej4hSnT81fInD7bxIPdcLYund7ZWWRmPh8xNT39l41RjrSjKSSfNGZd8Dv
	5SXGIcsizQ2QGzWp8W80KvDhTZOrYNPIHBMdAMjj1O+6qXehff0d8HjNhxn4lAcc19mpF8rxV4g
	sdfFHTo6VPUYdoCI3YZ0q5kRqVk+nKQ7hNxAPPQxrlsi+4jHwI+5797YSp3ASrhh6HTxnBm/Zd+
	ZOZ5WYE/+aE6iQKG/26xxmYTssio1j7epH2+OzZHjVHwMKItqvONkM0qHRxdfaD9/nFoMxc3HZ6
	f7T4/HpmgA+sh9vhx60rvwuGpQ==
X-Google-Smtp-Source: AGHT+IHVSwvO5REOZsXpr6NedG5NC3Z7zjoKMr78xylkWpwdIh5MXwXw5HCbuKJpAPKQjtruRtWSWQ==
X-Received: by 2002:a05:6402:35c2:b0:5cf:c33c:34cf with SMTP id 4fb4d7f45d1cf-5d81dd99557mr50433144a12.15.1736242306459;
        Tue, 07 Jan 2025 01:31:46 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806feddfasm24976300a12.58.2025.01.07.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:31:46 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 07 Jan 2025 12:31:31 +0300
Subject: [PATCH v6 2/2] power: supply: max17042: add platform driver
 variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-max17042-v6-2-3d0104ad5bc7@gmail.com>
References: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
In-Reply-To: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736242298; l=14259;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=/U5C+nfuke8YP3qpDkMfO7fqpvAqGnzMcDfWnXPrw5w=;
 b=tEoMRIasMIbReaQ1PMoag6ClMoUYVwBoShQ1bPoGXdU4NoRKkypyLSn4FRTBLH20qj2g3Tsk4
 QGmA90ITz9LA6Vwv3/5F8YUtVI3h+Fq2UTU81Lz39xfQAvat/vViEPg
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Maxim PMICs may include fuel gauge with additional features, which is
out of single Linux power supply driver scope.

For example, in max77705 PMIC fuelgauge has additional registers, like
IIN_REG, VSYS_REG, ISYS_REG. Those needed to measure PMIC input current,
system voltage and current respectively. Those measurements cannot be
bound to any of fuelgauge properties.

The solution here add and option to use max17042 driver as a MFD sub
device, thus allowing any additional functionality be implemented as
another sub device. This will help to reduce code duplication in MFD
fuel gauge drivers.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v6:
- fix changelog: move `use parent device of_node` change to v5 from v6
  list, since it first appeared there
- reformat commit message with vim `gq` to wrap closer to 75 chars

Changes in v5:
- replace *client field on *dev and irq in driver data struct
  this needed to provide correct dev and irq from platform probe
- s/&chip->client->dev/chip->dev/
- s/chip->client->irq/chip->irq/
- add regmap name to avoid possible conflicts in debugfs
- get i2c_client with common to_i2c_client(pdev->dev.parent); approach,
  not from platform data
- add device types to `of_device_id max17042_dt_match`, for platform
  version to be able to set platform device id, like in `clk-s2mps11.c`
  driver.
- use parent device of_node

Changes in v4:
- rename module_init and module_exit fuctions
- rework max17042_init
- assign chip_type in probe function
- pass i2c_client as pointer on pointer, to use same pointer created in
  MFD. This allows devm_regmap_init_i2c to cleanup gracefully.

Changes in v3:
- pass dev pointer in max17042_probe
- remove prints
---
 drivers/power/supply/max17042_battery.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
 1 file changed, 141 insertions(+), 50 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 99bf6915aa23..4037843e25bb 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/mod_devicetable.h>
 #include <linux/power_supply.h>
@@ -52,13 +53,14 @@
 #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
 
 struct max17042_chip {
-	struct i2c_client *client;
+	struct device *dev;
 	struct regmap *regmap;
 	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
 	struct max17042_platform_data *pdata;
 	struct work_struct work;
 	int    init_complete;
+	int    irq;
 };
 
 static enum power_supply_property max17042_battery_props[] = {
@@ -573,11 +575,11 @@ static inline int max17042_model_data_compare(struct max17042_chip *chip,
 	int i;
 
 	if (memcmp(data1, data2, size)) {
-		dev_err(&chip->client->dev, "%s compare failed\n", __func__);
+		dev_err(chip->dev, "%s compare failed\n", __func__);
 		for (i = 0; i < size; i++)
-			dev_info(&chip->client->dev, "0x%x, 0x%x",
+			dev_info(chip->dev, "0x%x, 0x%x",
 				data1[i], data2[i]);
-		dev_info(&chip->client->dev, "\n");
+		dev_info(chip->dev, "\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -812,14 +814,14 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	/* write cell characterization data */
 	ret = max17042_init_model(chip);
 	if (ret) {
-		dev_err(&chip->client->dev, "%s init failed\n",
+		dev_err(chip->dev, "%s init failed\n",
 			__func__);
 		return -EIO;
 	}
 
 	ret = max17042_verify_model_lock(chip);
 	if (ret) {
-		dev_err(&chip->client->dev, "%s lock verify failed\n",
+		dev_err(chip->dev, "%s lock verify failed\n",
 			__func__);
 		return -EIO;
 	}
@@ -875,7 +877,7 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 		return IRQ_HANDLED;
 
 	if ((val & STATUS_SMN_BIT) || (val & STATUS_SMX_BIT)) {
-		dev_dbg(&chip->client->dev, "SOC threshold INTR\n");
+		dev_dbg(chip->dev, "SOC threshold INTR\n");
 		max17042_set_soc_threshold(chip, 1);
 	}
 
@@ -907,7 +909,7 @@ static void max17042_init_worker(struct work_struct *work)
 static struct max17042_platform_data *
 max17042_get_of_pdata(struct max17042_chip *chip)
 {
-	struct device *dev = &chip->client->dev;
+	struct device *dev = chip->dev;
 	struct device_node *np = dev->of_node;
 	u32 prop;
 	struct max17042_platform_data *pdata;
@@ -949,7 +951,7 @@ static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
 static struct max17042_platform_data *
 max17042_get_default_pdata(struct max17042_chip *chip)
 {
-	struct device *dev = &chip->client->dev;
+	struct device *dev = chip->dev;
 	struct max17042_platform_data *pdata;
 	int ret, misc_cfg;
 
@@ -990,7 +992,7 @@ max17042_get_default_pdata(struct max17042_chip *chip)
 static struct max17042_platform_data *
 max17042_get_pdata(struct max17042_chip *chip)
 {
-	struct device *dev = &chip->client->dev;
+	struct device *dev = chip->dev;
 
 #ifdef CONFIG_OF
 	if (dev->of_node)
@@ -1003,6 +1005,7 @@ max17042_get_pdata(struct max17042_chip *chip)
 }
 
 static const struct regmap_config max17042_regmap_config = {
+	.name = "max17042",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
@@ -1029,14 +1032,12 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
 
-static int max17042_probe(struct i2c_client *client)
+static int max17042_probe(struct i2c_client *client, struct device *dev, int irq,
+			  enum max170xx_chip_type chip_type)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct i2c_adapter *adapter = client->adapter;
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
-	const struct acpi_device_id *acpi_id = NULL;
-	struct device *dev = &client->dev;
 	struct max17042_chip *chip;
 	int ret;
 	int i;
@@ -1045,33 +1046,25 @@ static int max17042_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EIO;
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	chip->client = client;
-	if (id) {
-		chip->chip_type = id->driver_data;
-	} else {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id)
-			return -ENODEV;
-
-		chip->chip_type = acpi_id->driver_data;
-	}
+	chip->dev = dev;
+	chip->chip_type = chip_type;
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
 	if (IS_ERR(chip->regmap)) {
-		dev_err(&client->dev, "Failed to initialize regmap\n");
+		dev_err(dev, "Failed to initialize regmap\n");
 		return -EINVAL;
 	}
 
 	chip->pdata = max17042_get_pdata(chip);
 	if (!chip->pdata) {
-		dev_err(&client->dev, "no platform data provided\n");
+		dev_err(dev, "no platform data provided\n");
 		return -EINVAL;
 	}
 
-	i2c_set_clientdata(client, chip);
+	dev_set_drvdata(dev, chip);
 	psy_cfg.drv_data = chip;
 	psy_cfg.of_node = dev->of_node;
 
@@ -1095,17 +1088,17 @@ static int max17042_probe(struct i2c_client *client)
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
+	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->battery)) {
-		dev_err(&client->dev, "failed: power supply register\n");
+		dev_err(dev, "failed: power supply register\n");
 		return PTR_ERR(chip->battery);
 	}
 
-	if (client->irq) {
+	if (irq) {
 		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, irq,
 						NULL,
 						max17042_thread_handler, flags,
 						chip->battery->desc->name,
@@ -1116,18 +1109,20 @@ static int max17042_probe(struct i2c_client *client)
 					CFG_ALRT_BIT_ENBL);
 			max17042_set_soc_threshold(chip, 1);
 		} else {
-			client->irq = 0;
+			irq = 0;
 			if (ret != -EBUSY)
-				dev_err(&client->dev, "Failed to get IRQ\n");
+				dev_err(dev, "Failed to get IRQ\n");
 		}
 	}
 	/* Not able to update the charge threshold when exceeded? -> disable */
-	if (!client->irq)
+	if (!irq)
 		regmap_write(chip->regmap, MAX17042_SALRT_Th, 0xff00);
 
+	chip->irq = irq;
+
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		ret = devm_work_autocancel(&client->dev, &chip->work,
+		ret = devm_work_autocancel(dev, &chip->work,
 					   max17042_init_worker);
 		if (ret)
 			return ret;
@@ -1139,6 +1134,44 @@ static int max17042_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int max17042_i2c_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct acpi_device_id *acpi_id = NULL;
+	struct device *dev = &client->dev;
+	enum max170xx_chip_type chip_type;
+
+	if (id) {
+		chip_type = id->driver_data;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!acpi_id)
+			return -ENODEV;
+
+		chip_type = acpi_id->driver_data;
+	}
+
+	return max17042_probe(client, dev, client->irq, chip_type);
+}
+
+static int max17042_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2c_client *i2c;
+	const struct platform_device_id *id;
+	int irq;
+
+	i2c = to_i2c_client(pdev->dev.parent);
+	if (!i2c)
+		return -EINVAL;
+
+	dev->of_node = dev->parent->of_node;
+	id = platform_get_device_id(pdev);
+	irq = platform_get_irq(pdev, 0);
+
+	return max17042_probe(i2c, dev, irq, id->driver_data);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int max17042_suspend(struct device *dev)
 {
@@ -1148,9 +1181,9 @@ static int max17042_suspend(struct device *dev)
 	 * disable the irq and enable irq_wake
 	 * capability to the interrupt line.
 	 */
-	if (chip->client->irq) {
-		disable_irq(chip->client->irq);
-		enable_irq_wake(chip->client->irq);
+	if (chip->irq) {
+		disable_irq(chip->irq);
+		enable_irq_wake(chip->irq);
 	}
 
 	return 0;
@@ -1160,9 +1193,9 @@ static int max17042_resume(struct device *dev)
 {
 	struct max17042_chip *chip = dev_get_drvdata(dev);
 
-	if (chip->client->irq) {
-		disable_irq_wake(chip->client->irq);
-		enable_irq(chip->client->irq);
+	if (chip->irq) {
+		disable_irq_wake(chip->irq);
+		enable_irq(chip->irq);
 		/* re-program the SOC thresholds to 1% change */
 		max17042_set_soc_threshold(chip, 1);
 	}
@@ -1183,12 +1216,26 @@ MODULE_DEVICE_TABLE(acpi, max17042_acpi_match);
 #endif
 
 #ifdef CONFIG_OF
-static const struct of_device_id max17042_dt_match[] = {
-	{ .compatible = "maxim,max17042" },
-	{ .compatible = "maxim,max17047" },
-	{ .compatible = "maxim,max17050" },
-	{ .compatible = "maxim,max17055" },
-	{ .compatible = "maxim,max77849-battery" },
+/*
+ * Device may be instantiated through parent MFD device and device matching is done
+ * through platform_device_id.
+ *
+ * However if device's DT node contains proper clock compatible and driver is
+ * built as a module, then the *module* matching will be done trough DT aliases.
+ * This requires of_device_id table.  In the same time this will not change the
+ * actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id max17042_dt_match[] __used = {
+	{ .compatible = "maxim,max17042",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17042 },
+	{ .compatible = "maxim,max17047",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
+	{ .compatible = "maxim,max17050",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17050 },
+	{ .compatible = "maxim,max17055",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17055 },
+	{ .compatible = "maxim,max77849-battery",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, max17042_dt_match);
@@ -1204,6 +1251,16 @@ static const struct i2c_device_id max17042_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
 
+static const struct platform_device_id max17042_platform_id[] = {
+	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
+	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
+	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max17042_platform_id);
+
 static struct i2c_driver max17042_i2c_driver = {
 	.driver	= {
 		.name	= "max17042",
@@ -1211,10 +1268,44 @@ static struct i2c_driver max17042_i2c_driver = {
 		.of_match_table = of_match_ptr(max17042_dt_match),
 		.pm	= &max17042_pm_ops,
 	},
-	.probe		= max17042_probe,
+	.probe		= max17042_i2c_probe,
 	.id_table	= max17042_id,
 };
-module_i2c_driver(max17042_i2c_driver);
+
+static struct platform_driver max17042_platform_driver = {
+	.driver	= {
+		.name	= "max17042",
+		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
+		.pm	= &max17042_pm_ops,
+	},
+	.probe		= max17042_platform_probe,
+	.id_table	= max17042_platform_id,
+};
+
+static int __init max17042_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&max17042_platform_driver);
+	if (ret)
+		return ret;
+
+	ret = i2c_add_driver(&max17042_i2c_driver);
+	if (ret) {
+		platform_driver_unregister(&max17042_platform_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(max17042_init);
+
+static void __exit max17042_exit(void)
+{
+	i2c_del_driver(&max17042_i2c_driver);
+	platform_driver_unregister(&max17042_platform_driver);
+}
+module_exit(max17042_exit);
 
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("MAX17042 Fuel Gauge");

-- 
2.39.5


