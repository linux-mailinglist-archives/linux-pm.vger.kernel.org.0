Return-Path: <linux-pm+bounces-8772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728C9000EE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD02286479
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9B15F3E9;
	Fri,  7 Jun 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PK645yfm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E915DBCE
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756368; cv=none; b=RIedrRv7yYSQch8JaG8UkGdy3fGZQsi/NTBNbMOlmvUzoIQBt2ilUOI/kUt2N8LGM17iOHIi4ll+D5t2r99qbXDRXT/itaMbLkTNDZYqKWC6Un6ATh49TQnMUJQ93UjaqswLsw+3JEHP8cG2Map2dqzPFql08H+NOIsKpGmfcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756368; c=relaxed/simple;
	bh=bDPI93m5Tt38Imf2xDmlzCR3mDjGDdiW6tBNCWrxUL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hShvt9cd2fJkhC3sX/qju1s5uP+rnCr9Vr678iDhsxaSvqY6K3sneXd9pgEHrdgIzIkGvzrr43POaAsHTTethjJa5zVo7EPFQjSr6faD2UPdfELzQGStUwkdQ7V0p3r2os4frhTbyH4dzc6TyR3eDEhBjz5nN2SJUcF7ZXMa5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PK645yfm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso301925e87.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756363; x=1718361163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC9YfLlk7LlLp3bVQxQQxqnW9tFEmO8Ok5Bjp89caCY=;
        b=PK645yfmfP6AyVZtVVGWQBRvyr3DUjK8Qt+ySmOzcbuUPQvZou2nW9Nh5aqVT1lvak
         tZEP4mI6Y3c0R4CQi4oyFyvrpupsWjhYw7hWtKXC+7O2wcMEEwqHARF5j9V4Ra/9FQ5u
         qmWfQkKHYfzsnw3HS8Q71/WrH6dbGq48mflDtpwcqUY+sFnr2jkxt+ikC6Nqxxlq0EYH
         psUs/eYsM6hrQsTJwJ7PqnmOgy8V507XcXJIHO8cg7HHkp6xjkkmMyTHGXrQJ9VyKzt3
         N+Rsidis0CS+KEZ8UDou2/Qw4Au66k4qY2x95Ocu2QDrZQZ4qqDDxs+2HkGOM5woinvG
         x5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756363; x=1718361163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC9YfLlk7LlLp3bVQxQQxqnW9tFEmO8Ok5Bjp89caCY=;
        b=HjGZrNuBynqxDJOtVL5NZ6WPVEhBosyv5q6C6P4hgM7G6xgU8wqh5wKKZ3u594Dfav
         A/+sjNdWPwzL4/sKWu1ZIdt6whziEkRUKIDNKuMUeEHsoRuNF1bUJnmVpPoRDwS9pxlQ
         NqhxaAY2Bhl64rnJriJX1nmQEB/0ZAwNErzFhyPgdDqAnfJpJvhSo4Wdydq4/LPOEqRF
         B8pKBZvcGMWqQYKl8PummL6VmWVws/grDS8/efuNGVky0a3nYXuX6Soz6V2ullBsGXnb
         9TL6VnO25dSmAdZjg5O6Dta6oMBmDJ2FK8KexfDe8ocaWH/58o5Dyzjg4dFxJht7sqrX
         CnHg==
X-Gm-Message-State: AOJu0YxLGN2NsJSr2KgQEpv9iz8rKjDI0s+QsKj9or0slbBRWJwOBoU9
	edUhj4t0489B7RxZ0ywIKDQ+696pGVWlMjU7mSz77EG4Uv7+oTn2/Pvc2uySRHU=
X-Google-Smtp-Source: AGHT+IEqzSqcM07LAv8WDH78ddBMVsEhSfPkve7P0y2iC0HgwAQOjidNGOgp3dL9Xz9Zr8mR0U0HWA==
X-Received: by 2002:a05:6512:130b:b0:52b:bf8f:5690 with SMTP id 2adb3069b0e04-52bbf8f5813mr884860e87.52.1717756362506;
        Fri, 07 Jun 2024 03:32:42 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433ccdbsm483448e87.283.2024.06.07.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:32:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 13:32:38 +0300
Subject: [PATCH v5 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-yoga-ec-driver-v5-3-1ac91a0b4326@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7205;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bDPI93m5Tt38Imf2xDmlzCR3mDjGDdiW6tBNCWrxUL8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYuHG7DWpupvE88U4ZwcS5LPGbYU7zV0OPK+Wp
 7Qv0GqVzmKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmLhxgAKCRCLPIo+Aiko
 1aNVB/4+2d1quCNlRlcxfMm3FCbRrZuLFpgn55P6PJRDQvT/npZH7xhRRTXH3Gqhbo2soyJwJgd
 zMvPQolFlbBYPhQUHqv0nUJ/yfTS13k6G67SXaKY7RoIXgXkcT5NVB6YNpgXFKYkgj6xwstLp21
 P7OnEQOtaqNxY/oGb6cw5yINqbH2Jp8nDMkhog5qE2s9UfRUKTleSsAEkeyrnyppXYYT8t3DI2+
 mbwtA6ZrvDuk8TzYP7wGUu0yF90bJsbLEn4XhSn6Le89xnYzpHYj8sj/dwlI5cxm9tF9ZZw+mkv
 /rynKsbVkgza4AA3RELw0/NSG6SOu9zKEZQdyc0vcy8X6ta4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
the onboard EC. Add glue driver to interface the platform's UCSI
implementation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/Kconfig          |   9 ++
 drivers/usb/typec/ucsi/Makefile         |   1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 202 ++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

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
index 000000000000..194b49291f28
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -0,0 +1,202 @@
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
+	if (offset == UCSI_CCI)
+		memcpy(val, buf, min(val_len, YOGA_C630_UCSI_CCI_SIZE));
+	else if (offset == UCSI_MESSAGE_IN)
+		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
+		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
+	else
+		return -EINVAL;
+
+	return 0;
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


