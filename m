Return-Path: <linux-pm+bounces-9131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE1907FB9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 01:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B3D1F21D29
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB471156C60;
	Thu, 13 Jun 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAgOX+OZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A22155340
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322229; cv=none; b=aR3J6E0MlqBi5D5dIPbzkXVSvayji2GkspX74HVi61VX9rz9b6GOKuCOoaPOaEsRpduy76XrLggWwqVpLcbItTwJVKL0+BlhBWEUoJd8W2jAeRBiAP2jRgOMTdTQeM0o997rWAvXoyMsA+LuPRgMpl58IKpBBLWWgx+xYz1FOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322229; c=relaxed/simple;
	bh=YjO3HERQXyskOyDP/GT2qK2COkuh5ScqcnEjbgN5iS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6FbYHLn00kWlTfvSR5KzgL9MyGhPgHNiilvZwOQfWiHaeCk4ApIvs6LUOgCkJyxQoL+NymK+ixiQ+bBJ2YXtTJZALleiAzXqzdI79liZUAQQea6rMz9PkxSzwe7DmL1uhvqHSKUS2vkPu03Zib3CkjEvJaK+HN3MxcwUxwAejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAgOX+OZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c8342af5eso1747777e87.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718322225; x=1718927025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4HqRTh5U1mlib+hXr43CpQLDDLz/tPafIE4z1Rshd0=;
        b=LAgOX+OZHn6R3lZd7/5tuWyYe+KsAJgK0C+NiFmesaHQ9idZ/rnJ9Odm0lfKhx3q5r
         fnj+OR51udPG5VmIc5EWPHQTuvxRWn0ba1mw4KE6uSlJlQtBAzA1lUZacSlSsG2CGyth
         bghdqejHYATQB8MXLMrgQY53p2OkUzbZrxGSDX50AC0hi7YC1wLrre2aiho5PiRChZbF
         zr1nF1o6AkuPziCSbSdq2tpZCZKzcdu+baUnF2mMlCkqanM2PhkhlRLrt43mCdUnOuIT
         Sj4ixQ5CtAN9OzTtKQPzuPkJwY1fgsv55H0cjTmHzNvukuPBR8DzJd56hqW7j2lPnEDi
         9gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718322225; x=1718927025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4HqRTh5U1mlib+hXr43CpQLDDLz/tPafIE4z1Rshd0=;
        b=b4ir794fipb0Wvvr3+0+zzoHc0Hn51/au49oe8oj043DkEua06laNMMvQ1WpGwGO7M
         tNjTPT4BdIUgl03u/l6A3FVBKD3C8T/9reNdD7FmNFmbnKFu6UJXe4/OriyxJ/3BJ6IV
         MMlGKMkPuJOj4BBJ7h3/HNLA7lFMG0GYgY+3/FQSBq8tGojhTglAEnOnnzseNkJGW+8f
         LQyzCX+9pzq7AgYqFFxkjxByxycs950/hBt4RT9SqXapyHmJBAnt2lyL4rZSEkFrd2hm
         ZoxZksCkybFCSsryXrICe3X6oy6rKD4rlIf3kbI8YcCnvN87bJfSTYmGwclgZ0NP66Dj
         SZIA==
X-Gm-Message-State: AOJu0Yzlfze/5H+BTWwU4bhqPz2NsCRiZJyhpe6SullrX2iXeEVgOhIE
	/mpU5styRGMdE5cm1TnDtE9+b65CrKNMCrN2kS1EGW1BLDF76RZWJMri0MGZwOU=
X-Google-Smtp-Source: AGHT+IGCaYhM5j/NRfMnNcYbxQ0By/7+it2U8IWQTzxj4k3dmkfFaQIIgdBYeHCILv99gcRXgsUTUw==
X-Received: by 2002:a19:e053:0:b0:52b:c198:bd75 with SMTP id 2adb3069b0e04-52ca6ea0ae4mr569263e87.69.1718322225255;
        Thu, 13 Jun 2024 16:43:45 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872260sm359298e87.142.2024.06.13.16.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:43:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 02:43:40 +0300
Subject: [PATCH v7 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-yoga-ec-driver-v7-3-9f0b9b40ae76@linaro.org>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
In-Reply-To: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7288;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=YjO3HERQXyskOyDP/GT2qK2COkuh5ScqcnEjbgN5iS0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBma4QtK5O5B8f8kdZg8bOwsWDj88XKYGpbYWDgd
 jvuEgXUKzaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmuELQAKCRCLPIo+Aiko
 1USGB/wLYvVM1iCSjZNIFr1sbVCu2/6iTWJaOt/Ce9z2ZekoodsTTRLBp67STanjCRI8si8lspQ
 6At6pSe7l2OqFlWU6KrWzwace/m5dTuO403aAEUOCkkrCfwdWFRyQ3M2Rro4G8YVmotcWk5RQqM
 8I/1XkjA5R/o41+5/pHhitDoXHB0UhjmSx8S4Azw6SEyPPo/VdI5qIXKVPxI88K++3e1PoRGcI2
 R4MAhlfOXoiH88f7szck/Sf8jeiQKcwiJogLCuLzj3Z4w/QjxvcT8JBilPqEBjb5ir8+dV45O1d
 2ndChJDKnIFS0TPRk1q6iQh1SUJJ5ePLgnC+O828DxiKta89
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
the onboard EC. Add glue driver to interface the platform's UCSI
implementation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/Kconfig          |   9 ++
 drivers/usb/typec/ucsi/Makefile         |   1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 204 ++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index bdcb1764cfae..680e1b87b152 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -69,4 +69,13 @@ config UCSI_PMIC_GLINK
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_glink.
 
+config UCSI_LENOVO_YOGA_C630
+	tristate "UCSI Interface Driver for Lenovo Yoga C630"
+	depends on EC_LENOVO_YOGA_C630
+	help
+	  This driver enables UCSI support on the Lenovo Yoga C630 laptop.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_yoga_c630.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index b4679f94696b..aed41d23887b 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
 obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
 obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
 obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
+obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
new file mode 100644
index 000000000000..8bee0b469041
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *  Bjorn Andersson
+ *  Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/string.h>
+#include <linux/platform_data/lenovo-yoga-c630.h>
+
+#include "ucsi.h"
+
+struct yoga_c630_ucsi {
+	struct yoga_c630_ec *ec;
+	struct ucsi *ucsi;
+	struct notifier_block nb;
+	struct completion complete;
+	unsigned long flags;
+#define UCSI_C630_COMMAND_PENDING	0
+#define UCSI_C630_ACK_PENDING		1
+	u16 version;
+};
+
+static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
+			       void *val, size_t val_len)
+{
+	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
+	u8 buf[YOGA_C630_UCSI_READ_SIZE];
+	int ret;
+
+	ret = yoga_c630_ec_ucsi_read(uec->ec, buf);
+	if (ret)
+		return ret;
+
+	if (offset == UCSI_VERSION) {
+		memcpy(val, &uec->version, min(val_len, sizeof(uec->version)));
+		return 0;
+	}
+
+	switch (offset) {
+	case UCSI_CCI:
+		memcpy(val, buf, min(val_len, YOGA_C630_UCSI_CCI_SIZE));
+		return 0;
+	case UCSI_MESSAGE_IN:
+		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
+		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
+				      const void *val, size_t val_len)
+{
+	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
+
+	if (offset != UCSI_CONTROL ||
+	    val_len != YOGA_C630_UCSI_WRITE_SIZE)
+		return -EINVAL;
+
+	return yoga_c630_ec_ucsi_write(uec->ec, val);
+}
+
+static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
+				     const void *val, size_t val_len)
+{
+	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	int ret;
+
+	if (ack)
+		set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
+	else
+		set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
+
+	reinit_completion(&uec->complete);
+
+	ret = yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
+	if (ret)
+		goto out_clear_bit;
+
+	if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
+		ret = -ETIMEDOUT;
+
+out_clear_bit:
+	if (ack)
+		clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
+	else
+		clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
+
+	return ret;
+}
+
+const struct ucsi_operations yoga_c630_ucsi_ops = {
+	.read = yoga_c630_ucsi_read,
+	.sync_write = yoga_c630_ucsi_sync_write,
+	.async_write = yoga_c630_ucsi_async_write,
+};
+
+static void yoga_c630_ucsi_notify_ucsi(struct yoga_c630_ucsi *uec, u32 cci)
+{
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(uec->ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(UCSI_C630_ACK_PENDING, &uec->flags))
+		complete(&uec->complete);
+
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(UCSI_C630_COMMAND_PENDING, &uec->flags))
+		complete(&uec->complete);
+}
+
+static int yoga_c630_ucsi_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct yoga_c630_ucsi *uec = container_of(nb, struct yoga_c630_ucsi, nb);
+	u32 cci;
+	int ret;
+
+	switch (action) {
+	case LENOVO_EC_EVENT_USB:
+	case LENOVO_EC_EVENT_HPD:
+		ucsi_connector_change(uec->ucsi, 1);
+		return NOTIFY_OK;
+
+	case LENOVO_EC_EVENT_UCSI:
+		ret = uec->ucsi->ops->read(uec->ucsi, UCSI_CCI, &cci, sizeof(cci));
+		if (ret)
+			return NOTIFY_DONE;
+
+		yoga_c630_ucsi_notify_ucsi(uec, cci);
+
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
+				const struct auxiliary_device_id *id)
+{
+	struct yoga_c630_ec *ec = adev->dev.platform_data;
+	struct yoga_c630_ucsi *uec;
+	int ret;
+
+	uec = devm_kzalloc(&adev->dev, sizeof(*uec), GFP_KERNEL);
+	if (!uec)
+		return -ENOMEM;
+
+	uec->ec = ec;
+	init_completion(&uec->complete);
+	uec->nb.notifier_call = yoga_c630_ucsi_notify;
+
+	uec->ucsi = ucsi_create(&adev->dev, &yoga_c630_ucsi_ops);
+	if (IS_ERR(uec->ucsi))
+		return PTR_ERR(uec->ucsi);
+
+	ucsi_set_drvdata(uec->ucsi, uec);
+
+	uec->version = yoga_c630_ec_ucsi_get_version(uec->ec);
+
+	auxiliary_set_drvdata(adev, uec);
+
+	ret = yoga_c630_ec_register_notify(ec, &uec->nb);
+	if (ret)
+		return ret;
+
+	return ucsi_register(uec->ucsi);
+}
+
+static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
+{
+	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
+
+	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
+	ucsi_unregister(uec->ucsi);
+}
+
+static const struct auxiliary_device_id yoga_c630_ucsi_id_table[] = {
+	{ .name = YOGA_C630_MOD_NAME "." YOGA_C630_DEV_UCSI, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, yoga_c630_ucsi_id_table);
+
+static struct auxiliary_driver yoga_c630_ucsi_driver = {
+	.name = YOGA_C630_DEV_UCSI,
+	.id_table = yoga_c630_ucsi_id_table,
+	.probe = yoga_c630_ucsi_probe,
+	.remove = yoga_c630_ucsi_remove,
+};
+
+module_auxiliary_driver(yoga_c630_ucsi_driver);
+
+MODULE_DESCRIPTION("Lenovo Yoga C630 UCSI");
+MODULE_LICENSE("GPL");

-- 
2.39.2


