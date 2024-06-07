Return-Path: <linux-pm+bounces-8771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CA9000E5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2559EB23B03
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DA15ECF4;
	Fri,  7 Jun 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiEz83uc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240515D5AD
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756366; cv=none; b=c4M3D+WHMp3zDHMLerF21Q7LzzpAiaYcHky8tWHdgX1bm06GShF2mY6HrXal/pyrZYZbypWMosikhVW3963WKozeEDop8DiY8D9xMn3prua2iyxvClXyn7QvG8T7gs3HF8fvLb25LirSLwyXsqeSewFkwBcKVOveXTns7OxVov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756366; c=relaxed/simple;
	bh=mqr0CI5RrcGOxrosg2gQrG4KuhSfprys+iMzecjLucQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3UUvSrjBqusg1ywngofcCRQwq+qkHjgTLxDrIS4PzBfSwfq7Lv9VPgN2uvUWwyERRUkgG5H+LuLNKROBGl0NL0PxHrSzl1GZNyYiG+WpN5NZfojiAQO8gZF1Q5D4WQLA8EhvIzk/d4dDGYb7Uls/Uxgcd3ZKK2XocA/5Bftdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DiEz83uc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b91f655d1so1852257e87.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756361; x=1718361161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqFMjxHWNB15UugxObBoUNY4/hlpeuu3YCEPV7pSK4=;
        b=DiEz83ucP30AykeQH7bMmdFvw1zdv9AE2SwRZEfe2Ljwc8tBedzHO02wm41Llr9+Nx
         uE54TmigzhL41iK43G5+4+EGauUMWwdbSMcc0H7qbr7UqAi/HWywy8Uy5aOTlBom06LK
         pbsN2+5vVWBg7yr0MybxBsPGtXRaZ67uOsYFcct9YyOtSmS0gkOERlZDvgfIHKNA57+f
         NNiAnKIrY4bQyuzckZYwPCHoWN9lxnC7/jC+1J0i0BDYE+wPBHXJxz7c906GSuwHOFh3
         l2Yv9oRFpaCjda6OUb3rPoOQwlQqPGgtrnRY1CxRsF1x4aV6MDJhx2qwblZQNf1bHa+u
         dUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756361; x=1718361161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqFMjxHWNB15UugxObBoUNY4/hlpeuu3YCEPV7pSK4=;
        b=G+i1e6RlpPhdFM/pcwYY8it2IWUxN1ii2Mf7T/atiES9WKd2vAopCuYLOnaV8Vk3Z+
         UpEJGpUQ3Nz8htKu7qppa50aPeKq10hkEJOTK3t1kZ+EbxDamRzblYRACh8gq2ZZOA7Z
         EcmC6OBp6XWPQYWSy07f5Q3moSmlnMSBKh4HiGQSX6EM/IR/xNt/nBF1/0NcTpIJc+iP
         BAT+UEhjt7oMcHsSwroSxSTvCbixduVZLtFpXDUPABkjMSaWfMgRaB63EWWM9gZy4bs0
         78bQvepF/nQ4sC3KP+VmhTCmWPS3xyYyWFbvLfacdD5xqeWLgTCB5HPVtrgxzWpwteUP
         W/8w==
X-Gm-Message-State: AOJu0Yy+SiYTTpnmSc+eYvQBPu6QHFa7NLXPnCFgudhtjuCXKVt+cMhY
	Tu+heEUm/ed3W4CMXdv4/T/vEgJQJ9S5PMCRsFloaHINaA3x734KugTK0W/RNd4=
X-Google-Smtp-Source: AGHT+IE+XZz3ITU14GOmmMzsznpWX2RvDh3oAgmT31Lt9RuAyICjibRe7TFnkTlTk23Kw8vue4Mesg==
X-Received: by 2002:ac2:5e70:0:b0:52a:7742:4593 with SMTP id 2adb3069b0e04-52bb9f07e0bmr526427e87.25.1717756361580;
        Fri, 07 Jun 2024 03:32:41 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433ccdbsm483448e87.283.2024.06.07.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:32:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 13:32:37 +0300
Subject: [PATCH v5 2/6] platform: arm64: add Lenovo Yoga C630 WOS EC driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-yoga-ec-driver-v5-2-1ac91a0b4326@linaro.org>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
In-Reply-To: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11021;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mqr0CI5RrcGOxrosg2gQrG4KuhSfprys+iMzecjLucQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYuHGMBDiPQpArdcIkM/Cqt2t/WOufwAkGp1u2
 JfXCxYJ3BuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmLhxgAKCRCLPIo+Aiko
 1TkWB/wKjM+6lm+1rWFnKv+al+mCTnNBrfkwYWeBeiZV/IvUsF92BC98Swc5NaJahCI2u3gdP1v
 bpVahDGeRZDjcFevU6gAoTJHEZV19mEDfy2CVaMZAcGYD0PByo3f78jyrZWloyBIOgxKevCp5OX
 Rq3t8RPqhpfLvCftaF0l4nkoQ9zn84dXepSZY/Dt/zLup24LkRK8R1aBOc7pJExKMKxf411GbTn
 dC7ew0apFzUvBSY/2OChVwu1Nm8+0ANmyV+rV41UewgqCGruYWRa+5h4kewcCmX5NE+Iisvay9i
 1H4FwhKch6HRab1J5vtUC0DRNeA+UaFdBqQe45zJKZyXWpuL
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Lenovo Yoga C630 WOS is a laptop using Snapdragon 850 SoC. Like many
laptops it uses an embedded controller (EC) to perform various platform
operations, including, but not limited, to Type-C port control or power
supply handlng.

Add the driver for the EC, that creates devices for UCSI and power
supply devices.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/platform/arm64/Kconfig                 |  14 ++
 drivers/platform/arm64/Makefile                |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c      | 283 +++++++++++++++++++++++++
 include/linux/platform_data/lenovo-yoga-c630.h |  43 ++++
 4 files changed, 341 insertions(+)

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
index 000000000000..ffad8c443a13
--- /dev/null
+++ b/drivers/platform/arm64/lenovo-yoga-c630.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/irqreturn.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
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
+	lockdep_assert_held(&ec->lock);
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
+	scoped_guard(mutex, &ec->lock) {
+		req[1] = addr;
+		ret = yoga_c630_ec_request(ec, req, sizeof(req), &val, 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	return val;
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
+	scoped_guard(mutex, &ec->lock) {
+		req[1] = addr;
+		ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
+		if (ret < 0)
+			return ret;
+
+		req[1] = addr + 1;
+		ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	return msb << 8 | lsb;
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
+	scoped_guard(mutex, &ec->lock) {
+		ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
+		if (ret < 0)
+			return ret;
+
+		req[2] = 0x21;
+		ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	return msb << 8 | lsb;
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
+static irqreturn_t yoga_c630_ec_thread_intr(int irq, void *data)
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
+	return blocking_notifier_chain_register(&ec->notifier_list, nb);
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
+	struct device *dev = &client->dev;
+	struct yoga_c630_ec *ec;
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
+					NULL, yoga_c630_ec_thread_intr,
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
index 000000000000..5571dd65ce08
--- /dev/null
+++ b/include/linux/platform_data/lenovo-yoga-c630.h
@@ -0,0 +1,43 @@
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
+struct notifier_block;
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


