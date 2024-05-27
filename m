Return-Path: <linux-pm+bounces-8147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE88CFDBB
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4137E1F22AB0
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E844A13C687;
	Mon, 27 May 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5Kfee9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DF13AD2F
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804239; cv=none; b=TA+rUw3xYZIPNC7WoFWmaW8Qv6OPBVNhm6HSeP+NLdlKq+JXoVnAt/8lYZoj7lQfD+tHVyV63NG7Ekmv33IMRog3rBHJQ4yqh3fyIx3axYaMSGLsxAAenoFH+66vSWiVMi4WHkpUZvDU7F9B5nGrxMIEGlqJ6tFTG9nFwV1S0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804239; c=relaxed/simple;
	bh=9TzMr4Rk7UoqG9pBwIioYwk7quFk4Q3NDC6Ibx0+hjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAGAK9Ly1oIm1ahAd7EylinEJ/001XIMbGThqcW2mj0gPLMZUOutYbYHjgIDv2C4EUbUs47zLamDL/mMVVNnMqXCM7L+EPO8MldZ3SR8TSyb4QhT/sO+c0wv9mbgj+9RjOe6+oHzSiMcBOeCL6iCGiZ6vjQj1YknWExj9557p5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5Kfee9E; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso33052751fa.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716804234; x=1717409034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU7aU+1NDUYh6foJyF26h+ha4Rk59XBh0mnrzCaH2jQ=;
        b=s5Kfee9EQGvxwqe3tnx1KlmZ/eGv7QkpnD1jg5m3XPNszsc5STMfSg87Zi3sb6tPjN
         UnuQ26x2jdrB8HGxXx2k2tLr+bA8Uzgx9kW9q/TOpBaHtvCL8Q+qcsEnROJBnZLkRSOx
         zUrji6JuLAw8AnpTJKqN5kmJt83KsqavWFcP6edSfrWu83uWv4+nIo2ISf3jqHtwFrss
         viI5DXmzmQF7BASch/LGTnX39NN9EF+1vO3Y0Bb4rA+3SZIC/MzGGWIIXb67uXdZ/TUw
         voxOjF14nSw9iBQtOc0FPKfUrh8wcOk95oM0R+TtTELxSQi7a+QFumEJQFH31CqJEIkf
         1FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804234; x=1717409034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU7aU+1NDUYh6foJyF26h+ha4Rk59XBh0mnrzCaH2jQ=;
        b=eyR176v6K2A5lAqmZM3ybCffR5NQWCSB/8PlUrtxi63qLlnmsJXX0V8RU99dfwwpBN
         Iz0J+IPWkvqd66GmVmbH2POVW/wx/0HdT8ezfq6SVejYPTclrWRHgqWr5+3+e3IUBNvc
         K8j09IHsqFceQowxSZ6N6e393KLUiR2EDrkA+/MuiXd14V8WeSVUAs30WfzsfTiR228L
         o/kUOGKHRjCoFx39hVNn1bpvp+hge/WKw8DWjoQ5B1c36ebg3PQSyre/rcxopBBjttGy
         AsB3oseKfbfNmh6JUkL+9oAcE3ZycKpv/dNlOGRwT8jowduEPbcFpT4ZfCrAdAygWRiN
         jlSA==
X-Gm-Message-State: AOJu0YyBQoJLDRxQdG9hExdPL36J6CjR1zG+EIdpof88hwjux2Myptyb
	VXWyMjyMmXFFBcYs0TgsNmv2GSEQ+p7ZSTlOAbwMh2Fo8UahC8ppKzDbUUjsJ4oqEXsa6upe6mk
	x
X-Google-Smtp-Source: AGHT+IEiak0WMNW4QCpKIIN4dYFCanKpmvwjtzP9p48mdGd7HkUGyDBDwVySWFaOopH1433j4QLfXg==
X-Received: by 2002:a2e:90d9:0:b0:2df:c2b:8c84 with SMTP id 38308e7fff4ca-2e95b09452fmr54451161fa.1.1716804233647;
        Mon, 27 May 2024 03:03:53 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcf4bdfsm18616651fa.63.2024.05.27.03.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:03:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 27 May 2024 13:03:48 +0300
Subject: [PATCH v3 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-yoga-ec-driver-v3-3-327a9851dad5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6860;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9TzMr4Rk7UoqG9pBwIioYwk7quFk4Q3NDC6Ibx0+hjU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVFqF7sFc5W/hdAVvvZuPWPjPpnotuHsAvPoAX
 IYIPvKoeG2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlRahQAKCRCLPIo+Aiko
 1Z2YCACi/UPcOwGEPyVx08tQt4r98b2Xe2b6866KMAdePtdZh5SlMDNluHY14Ry4ZSGIbUVXzWH
 YDS4rUq3eIvVfrlG6wj9Z/Pz9QLdfmVfYUVwQRFUBrnPoUJGNAR+j9JgvHndriMyNGzlHgqtGcZ
 xgR/73NDN8KVU6dH2xuMzYtADQlQGoK9+V94tRQ4rC7oBgH2JHrkJho0IRkTFxTHAJ3Ca3uMl1v
 /fPHcP5ArUNffp2bzP9IoHpxKzeB/oT4rVU01qFGIKOGYXSu2YRRjBtdzZWSfECXKb3Am5q7iX9
 JXYmcq2aOagpts7UB/fMXwtxE/iVtnADEtewwvPPKLtTcT2Y
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
the onboard EC. Add glue driver to interface the platform's UCSI
implementation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/Kconfig          |   9 ++
 drivers/usb/typec/ucsi/Makefile         |   1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 189 ++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)

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
index 000000000000..ca1ab5c81b87
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024, Linaro Ltd
+ * Authors:
+ *    Bjorn Andersson
+ *    Dmitry Baryshkov
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
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
+static  int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
+				void *val, size_t val_len)
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
+	if (offset == UCSI_CCI)
+		memcpy(val, buf,
+		       min(val_len, YOGA_C630_UCSI_CCI_SIZE));
+	else if (offset == UCSI_MESSAGE_IN)
+		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
+		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static  int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
+				       const void *val, size_t val_len)
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
+static  int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
+				      const void *val, size_t val_len)
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
+static int yoga_c630_ucsi_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct yoga_c630_ucsi *uec = container_of(nb, struct yoga_c630_ucsi, nb);
+	u32 cci;
+	int ret;
+
+	if (action == LENOVO_EC_EVENT_USB || action == LENOVO_EC_EVENT_HPD) {
+		ucsi_connector_change(uec->ucsi, 1);
+		return NOTIFY_OK;
+	}
+
+	if (action != LENOVO_EC_EVENT_UCSI)
+		return NOTIFY_DONE;
+
+	ret = uec->ucsi->ops->read(uec->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret)
+		return NOTIFY_DONE;
+
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(uec->ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(UCSI_C630_ACK_PENDING, &uec->flags))
+		complete(&uec->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(UCSI_C630_COMMAND_PENDING, &uec->flags))
+		complete(&uec->complete);
+
+	return NOTIFY_OK;
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


