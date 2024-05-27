Return-Path: <linux-pm+bounces-8146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D68CFDB8
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB55B22633
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B013BC35;
	Mon, 27 May 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJd6fIXy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588513AD04
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804238; cv=none; b=Dq2UVQIfb1cC4JSJNMAGQg7iuQVo5EQz8ag7S7YnHdq78SNs2nEfQk1J2hnMmdqJ6GZUuDZX7Q9njcZi7wpAt5XSPr56S7H9PjakpBhdX4inGID8h2hQINkecfKpbkXFTcggJLLQjaOPLhCOvjLxz7OrTPJuw8tEaembRmo5bx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804238; c=relaxed/simple;
	bh=I2yK+f17QGvCBbxV9mu1qHPoL9MAc+tgbTW9LI9tZgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8OgSwfiyDf/6Jz94+6Av6Rp2R7vIGkIQz65TXUCxN0/GGepTnvk8yi/riEN5Yt0CtaSQkwem45cx19nWpQrZtubodSDyKlm6oThRpe8bI1HlyK/0I3fSgBL7ObPdWmSewafd/71uy1EhtUqU1poko0wAgfLzDEkAQ38hPKj/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJd6fIXy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b979so80517471fa.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716804233; x=1717409033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVK5TzUsekz8eA0P5r1NzTMbXr5dKzZwCG1F9TIdIXw=;
        b=jJd6fIXy4g4hVZy+Y16SBpkDQl0pHU8+3vKzMwQvZrHLdDUsaVpg/tCxWxSGwVDWQK
         P7Arht9TgJVzKJwXV9qIXeKVjv1bq33OeB3w2ugaRscayUX8Uc4HBROYudUiZMuoSe9u
         bQ2/EBBOWyEtuuv07zzXq40JtZ2gfAsvnz5aGTFFqv5HchHAJOFrrRO+h0+bcqXI7Jf5
         RVXJO/WEWCt0sn5G+0JfYMFOPT4ntO6kLIBu9qypE3tMZYwLlOqKl/PprCgQBICMyPJ1
         g6tHvkJAjKylRoCk8HzUgL/nRK6s+hlzhG6Drat4D2cCr88/hmkHPFt3sxldaVbw0asM
         ZUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804233; x=1717409033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVK5TzUsekz8eA0P5r1NzTMbXr5dKzZwCG1F9TIdIXw=;
        b=WqHNc7aA/F+J0Hhen7z82YrpZVF0qqInlbPu3JHtsSc5lKdzNbKPlFD7b6BZmfxyx2
         kxPRx3ftc2QlopNVB63HJgBFg2yjXOKyYzllEmzwanH/hxvl/lhzgTykBegFYbjn71SK
         4WnTNewb+CeTBsymcm6RCb6sDxenOupcK/hHt61kr7MUFv/bChsPNIsn3avmA5Z0Zcvh
         r6vpTQLYPYm+GahDX90Dae3OMY1t4zng9wEFAWWRW6oPa84Lib44JR1xD5vbc8FEl/ZF
         hy3xyRlb5jmxKO/AR1IWprqpLiJUEKNo4UpRkIsI+xuune+yFbBA/tIY3mI7jhqe2yan
         t7AA==
X-Gm-Message-State: AOJu0YzFy5duvWQ3Nl+nmtfLG6vyKifvAuh9Lv3CNW5Z+MfCRqvKB16L
	BhZue6S/M8/g56O7vat47JOpXESQ+DiKz3s9AZwJgl+UHq016SqgEsL+04JU0Fs=
X-Google-Smtp-Source: AGHT+IG/AHVCcty7CupHo9QX2dpXDmjcLwqx97IumZ0V6hgYoyyoXE6K3CBOp9FbZhofcYczjkGgHA==
X-Received: by 2002:a2e:9653:0:b0:2e9:6e0a:b8ed with SMTP id 38308e7fff4ca-2e96e0ab9edmr25104751fa.4.1716804232792;
        Mon, 27 May 2024 03:03:52 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcf4bdfsm18616651fa.63.2024.05.27.03.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:03:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 27 May 2024 13:03:47 +0300
Subject: [PATCH v3 2/6] platform: arm64: add Lenovo Yoga C630 WOS EC driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-yoga-ec-driver-v3-2-327a9851dad5@linaro.org>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
In-Reply-To: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10790;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=I2yK+f17QGvCBbxV9mu1qHPoL9MAc+tgbTW9LI9tZgw=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1pIVGtCmI38rvk/JEscdl5bVDjzhob21Dk/19rzVuuuZ
 8qL/OnSyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJbLjHwdCVnV8oqzPtb3d6
 0v0i1dx/BvHtruGfD01iubPTMTF+/rrj/ELp7I8K1yxnDLC9dOZz0fdAreVZAS7zz3FPE80Q6fO
 VYNdmXZ433UZikwcfs839ilgOsd8K0865pZqtFXAW7Rb/vvz6fF8XDy6RkguhZk84ljAtYf7Vzj
 y5beMeL+PUpe+tt8ix7i8tkdt2TvBs02Ubz/+LNVXPlj/fbdSlr1IZcaR82qMttfcKbzmGLPk17
 21+8CxeK9PJ3WvCj1U+k3kakeLlEf7Dfc7nWWJ6pQv/vdx/MUb//0LLXY65MxODW3vT8hOWLN/j
 qHuV91+thtUdns/h0y+KMDTGXHOzOdgoY/Te/mbWlBUWAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Lenovo Yoga C630 WOS is a laptop using Snapdragon 850 SoC. Like many
laptops it uses embedded controller (EC) to perform various platform
operations, including, but not limited, to Type-C port control or power
supply handlng.

Add the driver for the EC, that creates devices for UCSI and power
supply devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/platform/arm64/Kconfig                 |  14 ++
 drivers/platform/arm64/Makefile                |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c      | 279 +++++++++++++++++++++++++
 include/linux/platform_data/lenovo-yoga-c630.h |  42 ++++
 4 files changed, 336 insertions(+)

diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index 8fdca0f8e909..8c103b3150d1 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -32,4 +32,18 @@ config EC_ACER_ASPIRE1
 	  laptop where this information is not properly exposed via the
 	  standard ACPI devices.
 
+config EC_LENOVO_YOGA_C630
+	tristate "Lenovo Yoga C630 Embedded Controller driver"
+	depends on I2C
+	help
+	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
+	  Lenovo Yoga C630, which provides battery and power adapter
+	  information.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
+	  Say M or Y here to include this support.
+
 endif # ARM64_PLATFORM_DEVICES
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
index 4fcc9855579b..b2ae9114fdd8 100644
--- a/drivers/platform/arm64/Makefile
+++ b/drivers/platform/arm64/Makefile
@@ -6,3 +6,4 @@
 #
 
 obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
+obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
diff --git a/drivers/platform/arm64/lenovo-yoga-c630.c b/drivers/platform/arm64/lenovo-yoga-c630.c
new file mode 100644
index 000000000000..3d1d5acde807
--- /dev/null
+++ b/drivers/platform/arm64/lenovo-yoga-c630.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/lenovo-yoga-c630.h>
+
+#define LENOVO_EC_RESPONSE_REG		0x01
+#define LENOVO_EC_REQUEST_REG		0x02
+
+#define LENOVO_EC_UCSI_WRITE		0x20
+#define LENOVO_EC_UCSI_READ		0x21
+
+#define LENOVO_EC_READ_REG		0xb0
+#define LENOVO_EC_REQUEST_NEXT_EVENT	0x84
+
+struct yoga_c630_ec {
+	struct i2c_client *client;
+	struct mutex lock;
+	struct blocking_notifier_head notifier_list;
+};
+
+static int yoga_c630_ec_request(struct yoga_c630_ec *ec, u8 *req, size_t req_len,
+				u8 *resp, size_t resp_len)
+{
+	int ret;
+
+	WARN_ON(!mutex_is_locked(&ec->lock));
+
+	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_REQUEST_REG,
+					     req_len, req);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_RESPONSE_REG,
+					     resp_len, resp);
+}
+
+int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr)
+{
+	u8 req[2] = { LENOVO_EC_READ_REG, };
+	int ret;
+	u8 val;
+
+	mutex_lock(&ec->lock);
+	req[1] = addr;
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &val, 1);
+	mutex_unlock(&ec->lock);
+
+	return ret < 0 ? ret : val;
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_read8);
+
+int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr)
+{
+	u8 req[2] = { LENOVO_EC_READ_REG, };
+	int ret;
+	u8 msb;
+	u8 lsb;
+
+	mutex_lock(&ec->lock);
+
+	req[1] = addr;
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
+	if (ret < 0)
+		goto out;
+
+	req[1] = addr + 1;
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
+
+out:
+	mutex_unlock(&ec->lock);
+
+	return ret < 0 ? ret : msb << 8 | lsb;
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_read16);
+
+u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec)
+{
+	u8 req[3] = { 0xb3, 0xf2, 0x20};
+	int ret;
+	u8 msb;
+	u8 lsb;
+
+	mutex_lock(&ec->lock);
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
+	if (ret < 0)
+		goto out;
+
+	req[2]++;
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
+
+out:
+	mutex_unlock(&ec->lock);
+
+	return ret < 0 ? ret : msb << 8 | lsb;
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_get_version);
+
+int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
+			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE])
+{
+	int ret;
+
+	mutex_lock(&ec->lock);
+	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_UCSI_WRITE,
+					     YOGA_C630_UCSI_WRITE_SIZE, req);
+	mutex_unlock(&ec->lock);
+
+	return ret < 0 ? ret : 0;
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_write);
+
+int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
+			   u8 resp[YOGA_C630_UCSI_READ_SIZE])
+{
+	int ret;
+
+	mutex_lock(&ec->lock);
+	ret = i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_UCSI_READ,
+					    YOGA_C630_UCSI_READ_SIZE, resp);
+	mutex_unlock(&ec->lock);
+
+	return ret < 0 ? ret : 0;
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_read);
+
+static irqreturn_t yoga_c630_ec_intr(int irq, void *data)
+{
+	u8 req[] = { LENOVO_EC_REQUEST_NEXT_EVENT };
+	struct yoga_c630_ec *ec = data;
+	u8 event;
+	int ret;
+
+	mutex_lock(&ec->lock);
+	ret = yoga_c630_ec_request(ec, req, sizeof(req), &event, 1);
+	mutex_unlock(&ec->lock);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	pr_info("NOTIFY %x\n", event);
+
+	blocking_notifier_call_chain(&ec->notifier_list, event, ec);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * yoga_c630_ec_register_notify - Register a notifier callback for EC events.
+ * @ec: Yoga C630 EC
+ * @nb: Notifier block pointer to register
+ *
+ * Return: 0 on success or negative error code.
+ */
+int yoga_c630_ec_register_notify(struct yoga_c630_ec *ec, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ec->notifier_list,
+						nb);
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_register_notify);
+
+/**
+ * yoga_c630_ec_unregister_notify - Unregister notifier callback for EC events.
+ * @ec: Yoga C630 EC
+ * @nb: Notifier block pointer to unregister
+ *
+ * Unregister a notifier callback that was previously registered with
+ * yoga_c630_ec_register_notify().
+ */
+void yoga_c630_ec_unregister_notify(struct yoga_c630_ec *ec, struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&ec->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(yoga_c630_ec_unregister_notify);
+
+static void yoga_c630_aux_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void yoga_c630_aux_remove(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int yoga_c630_aux_init(struct device *parent, const char *name,
+			      struct yoga_c630_ec *ec)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = name;
+	adev->id = 0;
+	adev->dev.parent = parent;
+	adev->dev.release = yoga_c630_aux_release;
+	adev->dev.platform_data = ec;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, yoga_c630_aux_remove, adev);
+}
+
+static int yoga_c630_ec_probe(struct i2c_client *client)
+{
+	struct yoga_c630_ec *ec;
+	struct device *dev = &client->dev;
+	int ret;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	mutex_init(&ec->lock);
+	ec->client = client;
+	BLOCKING_INIT_NOTIFIER_HEAD(&ec->notifier_list);
+
+	ret = devm_request_threaded_irq(dev, client->irq,
+					NULL, yoga_c630_ec_intr,
+					IRQF_ONESHOT, "yoga_c630_ec", ec);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "unable to request irq\n");
+
+	ret = yoga_c630_aux_init(dev, YOGA_C630_DEV_PSY, ec);
+	if (ret)
+		return ret;
+
+	return yoga_c630_aux_init(dev, YOGA_C630_DEV_UCSI, ec);
+}
+
+
+static const struct of_device_id yoga_c630_ec_of_match[] = {
+	{ .compatible = "lenovo,yoga-c630-ec" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, yoga_c630_ec_of_match);
+
+static const struct i2c_device_id yoga_c630_ec_i2c_id_table[] = {
+	{ "yoga-c630-ec", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, yoga_c630_ec_i2c_id_table);
+
+static struct i2c_driver yoga_c630_ec_i2c_driver = {
+	.driver = {
+		.name = "yoga-c630-ec",
+		.of_match_table = yoga_c630_ec_of_match
+	},
+	.probe = yoga_c630_ec_probe,
+	.id_table = yoga_c630_ec_i2c_id_table,
+};
+module_i2c_driver(yoga_c630_ec_i2c_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga C630 Embedded Controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/lenovo-yoga-c630.h b/include/linux/platform_data/lenovo-yoga-c630.h
new file mode 100644
index 000000000000..2b893dbeb124
--- /dev/null
+++ b/include/linux/platform_data/lenovo-yoga-c630.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+
+#ifndef _LENOVO_YOGA_C630_DATA_H
+#define _LENOVO_YOGA_C630_DATA_H
+
+struct yoga_c630_ec;
+
+#define YOGA_C630_MOD_NAME	"lenovo_yoga_c630"
+
+#define YOGA_C630_DEV_UCSI	"ucsi"
+#define YOGA_C630_DEV_PSY	"psy"
+
+int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr);
+int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr);
+
+int yoga_c630_ec_register_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);
+void yoga_c630_ec_unregister_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);
+
+#define YOGA_C630_UCSI_WRITE_SIZE	8
+#define YOGA_C630_UCSI_CCI_SIZE		4
+#define YOGA_C630_UCSI_DATA_SIZE	16
+#define YOGA_C630_UCSI_READ_SIZE	(YOGA_C630_UCSI_CCI_SIZE + YOGA_C630_UCSI_DATA_SIZE)
+u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec);
+int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
+			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE]);
+int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
+			   u8 resp[YOGA_C630_UCSI_READ_SIZE]);
+
+#define LENOVO_EC_EVENT_USB		0x20
+#define LENOVO_EC_EVENT_UCSI		0x21
+#define LENOVO_EC_EVENT_HPD		0x22
+#define LENOVO_EC_EVENT_BAT_STATUS	0x24
+#define LENOVO_EC_EVENT_BAT_INFO	0x25
+#define LENOVO_EC_EVENT_BAT_ADPT_STATUS	0x37
+
+#endif

-- 
2.39.2


