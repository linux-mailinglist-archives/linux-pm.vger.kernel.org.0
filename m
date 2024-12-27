Return-Path: <linux-pm+bounces-19779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDC9FD671
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B8718857EF
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C461F868C;
	Fri, 27 Dec 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og/2Q5aZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E535974;
	Fri, 27 Dec 2024 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319736; cv=none; b=ps3z4QrbcNV7Buc34tT8qzkRtDd6hkmDdkFO/Wrp4WA6ANnPoHPup25mwqwi83R70aATPRZiLVWKB7nWcm1vt5lQLVkf+vFdgSesk4WmVP5yS5XmF64iQJ4A6yW4JDzePqBnmI9XHxJrMCFEDH39euiVOoVN7wAvGd0pLsdZd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319736; c=relaxed/simple;
	bh=WoWWuX9D0EPFssLKQ0lws001L82HD047Q+6Cn79ziLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9QQ2XDT0fnZuRuPmeVFkNul6QyGkSe3FJZOc+DixdnPCyuiYGoEEstaRRk+mxGoW+2FGk6aLBsn98/CVFqYjy9WDGfSchAGK093Gw5G2dIyjrOCsAWoQVuLsmhAXz46LNSZv1+392jZLrZ8BECYK0kJ/n6xSxQe6pwvXiZLYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og/2Q5aZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165cb60719so92051275ad.0;
        Fri, 27 Dec 2024 09:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319734; x=1735924534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2hfiQhPzSgHrBlx838Ib/oJn1ApDYkgvtk1gQ24Sv0=;
        b=Og/2Q5aZEp+cmDngdJV2YrY9X0Mi4vszohOE2BdxEsdT/iMO84jxJiF+nSAh4IAWLS
         ubiVdC5GPR+WI53peTfEDlECEaccUNNtLRXVaZmigao1K8qARsliMv3FrEX1RxJm7o58
         lkgf9Rq41e7Vg3sTHbc5h3y5FxdZAFs5RzgG2USrN0xNiyFegxdT8r4fnZhWlPv4whdr
         336F+kfYaO5VlywvHS87+wVCteDLtDjILbF0tQPMAU8si/yMU8DEvT3bxlmM3JzwZc3C
         K0BLbRvc/3q+saXW9cLPnX6vW/G1S/HuDbdTXe3GzzXm/Dj5mQYJ2WmMO8u0kZeLu5Va
         z71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319734; x=1735924534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2hfiQhPzSgHrBlx838Ib/oJn1ApDYkgvtk1gQ24Sv0=;
        b=heNlvYYy43fmFwEyql4X3cMhNvvDSGaEH0zCTlMUlpIoq4IIl4xu3tlaBSnxliwLG+
         yTYApHJY94Wk60oeeH6/2oRr9g18i8JAKW3SrMAHkVtM8Md9jbYIW0ItCqsse+D2OneP
         2qmkDkj7sUtwbxLDOPCV8V0Nalcgw3D7KRDx6LSRnc8Fmb4pZAIkQZj2zdffZTDl1Mhr
         EILfDJySemD7t6KZ+XDiaSUUYhaJ9HHQmByEFddRhq9WwwDqw7VzDvcpuPgceZakoAZy
         DKhINFYjrKONAAHEDaP4ReH+2s0xyX9pzh9Mtr/5iugfxuHqBmPRTkvTkAEpVGEakU3p
         UeYA==
X-Forwarded-Encrypted: i=1; AJvYcCUmtwyn/jODOVwyFnQ3CmKjnqtPUbS4EDoViwLXS6tdFLPIR9jDu6uU6XsU4LzeYngjeX4+dxGD9s4=@vger.kernel.org, AJvYcCUrCvKf42fJCXoSAA/Eg2foJhbuVAT4dNGBYhalfazX5qVQCJB1XI5cPEq1/onelwJxEHnPKU5oiJ7fSCo3@vger.kernel.org, AJvYcCWFrlFA6F7UMLUjD7p5ny3JcEDCFwecAWFTAGqFVGPK6SlU3P5WTeWvaYL9k3f3TIcOvkbnLcY1MthR@vger.kernel.org, AJvYcCXE4ygmxIIGIN5gQawQn1yozwmKU54Tj4lD7pazkRTAVsGnrUTDpVIgurhQdoCrmAPUs+5rhLA7cJQ+4nKHZZpT6TkXuw==@vger.kernel.org, AJvYcCXFepuiFhnqCHUF3Kg5uUcpS/+E2WMEw9k+pEW7KbXPCloasjbNYCTJlpycnS4aEw5YKmyfqR78dlf/YaZ0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0F5R3mkCvc9MRF7AkQZAu2WBd8N3yR2zB8g48bAPxhaWZIME
	aPzERS9KPjBkaJAppfgSJwZOFbv2bnnfL9MxJgTzrfJ6MbKiCdwSYUqnitCksrYDQLHH
X-Gm-Gg: ASbGncvDEJiDKOa+d3tOuOGb7e+luEDjaoYk1uoP7Whab/fgowhmUAKy2tlO8upiDsJ
	Z1leOjsHiWq55+y4YFiB3CPScW0lVFYCsQEbgNtyYUtNcQT9vodL2jeKCszjaARAMAUA/aTuxnI
	BzgF/Bjhi0AKlFnCMZnCo1hh+Sg0mcXgjPp1IdTtBRin8N2JZNdRonwmk1qGbrpYz28C0iLuisa
	n0RSmg0dZwQ9Gposl19Z6SmxcnwFtO71cm+WMUo/4M=
X-Google-Smtp-Source: AGHT+IEn8+hvUl0ELflaZHE8/bx1e0GFRujkLeLQU6y4a+RNOo+MJnBLeznSkwZG937TUgLLqaTnow==
X-Received: by 2002:a17:903:1209:b0:215:b9a7:5282 with SMTP id d9443c01a7336-219e6eb417dmr364834635ad.26.1735319733394;
        Fri, 27 Dec 2024 09:15:33 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:32 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp) EC driver
Date: Sat, 28 Dec 2024 01:13:50 +0800
Message-ID: <20241227171353.404432-3-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227171353.404432-1-mitltlatltl@gmail.com>
References: <20241227171353.404432-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 3 variants, Huawei released first 2 at the same time.
Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
Huawei Matebook E Go 2023(sc8280xp@2.69GHz).

Adding support for the latter two variants for now, this driver should
also work for the sc8180x variant according to acpi table files, but I
don't have the device yet.

Different from other Qualcomm Snapdragon sc8280xp based machines, the
Huawei Matebook E Go uses an embedded controller while others use
something called pmic glink. This embedded controller can be used to
perform a set of various functions, including, but not limited:

- Battery and charger monitoring;
- Charge control and smart charge;
- Fn_lock settings;
- Tablet lid status;
- Temperature sensors;
- USB Type-C notifications (ports orientation,  DP alt mode HPD);
- USB Type-C PD (according to observation, up to 48w).

Add the driver for the EC, that creates devices for UCSI, wmi and power
supply devices.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/platform/arm64/Kconfig                |  19 +
 drivers/platform/arm64/Makefile               |   2 +
 drivers/platform/arm64/huawei-gaokun-ec.c     | 598 ++++++++++++++++++
 drivers/platform/arm64/huawei-gaokun-wmi.c    | 283 +++++++++
 .../linux/platform_data/huawei-gaokun-ec.h    |  90 +++
 5 files changed, 992 insertions(+)
 create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
 create mode 100644 drivers/platform/arm64/huawei-gaokun-wmi.c
 create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h

diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index f88395ea3..eb7fbacf0 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -33,6 +33,25 @@ config EC_ACER_ASPIRE1
 	  laptop where this information is not properly exposed via the
 	  standard ACPI devices.
 
+config EC_HUAWEI_GAOKUN
+	tristate "Huawei Matebook E Go (sc8280xp) Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	depends on DRM
+	depends on POWER_SUPPLY
+	depends on INPUT
+	help
+	  Say Y here to enable the EC driver for Huawei Matebook E Go 2in1
+	  tablet. The driver handles battery(information, charge control) and
+	  USB Type-C DP HPD events as well as some misc functions like the lid
+	  sensor and temperature sensors, etc.
+
+	  This driver provides battery and AC status support for the mentioned
+	  laptop where this information is not properly exposed via the
+	  standard ACPI devices.
+
+	  Say M or Y here to include this support.
+
 config EC_LENOVO_YOGA_C630
 	tristate "Lenovo Yoga C630 Embedded Controller driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
index b2ae9114f..ed32ad6c0 100644
--- a/drivers/platform/arm64/Makefile
+++ b/drivers/platform/arm64/Makefile
@@ -6,4 +6,6 @@
 #
 
 obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
+obj-$(CONFIG_EC_HUAWEI_GAOKUN)	+= huawei-gaokun-ec.o
+obj-$(CONFIG_EC_HUAWEI_GAOKUN)	+= huawei-gaokun-wmi.o
 obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform/arm64/huawei-gaokun-ec.c
new file mode 100644
index 000000000..c1c657f7b
--- /dev/null
+++ b/drivers/platform/arm64/huawei-gaokun-ec.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * huawei-gaokun-ec - An EC driver for HUAWEI Matebook E Go (sc8280xp)
+ *
+ * reference: drivers/platform/arm64/acer-aspire1-ec.c
+ *            drivers/platform/arm64/lenovo-yoga-c630.c
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/version.h>
+
+#include <linux/platform_data/huawei-gaokun-ec.h>
+
+#define EC_EVENT		0x06
+
+/* Also can be found in ACPI specification 12.3 */
+#define EC_READ			0x80
+#define EC_WRITE		0x81
+#define EC_BURST		0x82
+#define EC_QUERY		0x84
+
+
+#define EC_EVENT_LID		0x81
+
+#define EC_LID_STATE		0x80
+#define EC_LID_OPEN		BIT(1)
+
+#define UCSI_REG_SIZE		7
+
+/* for tx, command sequences are arranged as
+ * {master_cmd, slave_cmd, data_len, data_seq}
+ */
+#define REQ_HDR_SIZE		3
+#define INPUT_SIZE_OFFSET	2
+#define INPUT_DATA_OFFSET	3
+
+/* for rx, data sequences are arranged as
+ * {status, data_len(unreliable), data_seq}
+ */
+#define RESP_HDR_SIZE		2
+#define DATA_OFFSET		2
+
+
+struct gaokun_ec {
+	struct i2c_client *client;
+	struct mutex lock;
+	struct blocking_notifier_head notifier_list;
+	struct input_dev *idev;
+	bool suspended;
+};
+
+static int gaokun_ec_request(struct gaokun_ec *ec, const u8 *req,
+			     size_t resp_len, u8 *resp)
+{
+	struct i2c_client *client = ec->client;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+			.len = req[INPUT_SIZE_OFFSET] + REQ_HDR_SIZE,
+			.buf = req,
+		}, {
+			.addr = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len = resp_len,
+			.buf = resp,
+		},
+	};
+
+	mutex_lock(&ec->lock);
+
+	i2c_transfer(client->adapter, msgs, 2);
+	usleep_range(2000, 2500);
+
+	mutex_unlock(&ec->lock);
+
+	return *resp;
+}
+
+/* -------------------------------------------------------------------------- */
+/* Common API */
+
+/**
+ * gaokun_ec_read - read from EC
+ * @ec: The gaokun_ec
+ * @req: The sequence to request
+ * @resp_len: The size to read
+ * @resp: Where the data are read to
+ *
+ * This function is used to read data after writing a magic sequence to EC.
+ * All EC operations dependent on this functions.
+ *
+ * Huawei uses magic sequences everywhere to complete various functions, all
+ * these sequences are passed to ECCD(a ACPI method which is quiet similar
+ * to gaokun_ec_request), there is no good abstraction to generalize these
+ * sequences, so just wrap it for now. Almost all magic sequences are kept
+ * in this file.
+ */
+int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
+		   size_t resp_len, u8 *resp)
+{
+	return gaokun_ec_request(ec, req, resp_len, resp);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_read);
+
+/**
+ * gaokun_ec_write - write to EC
+ * @ec: The gaokun_ec
+ * @req: The sequence to request
+ *
+ * This function has no big difference from gaokun_ec_read. When caller care
+ * only write status and no actual data are returnd, then use it.
+ */
+int gaokun_ec_write(struct gaokun_ec *ec, u8 *req)
+{
+	u8 resp[RESP_HDR_SIZE];
+
+	return gaokun_ec_request(ec, req, sizeof(resp), resp);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_write);
+
+int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte)
+{
+	int ret;
+	u8 resp[RESP_HDR_SIZE + sizeof(*byte)];
+
+	ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
+	*byte = resp[DATA_OFFSET];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_read_byte);
+
+int gaokun_ec_register_notify(struct gaokun_ec *ec, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ec->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_register_notify);
+
+void gaokun_ec_unregister_notify(struct gaokun_ec *ec, struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&ec->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_unregister_notify);
+
+/* -------------------------------------------------------------------------- */
+/* API For PSY */
+
+int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
+			     size_t resp_len, u8 *resp)
+{
+	int i, ret;
+	u8 _resp[RESP_HDR_SIZE + 1];
+	u8 req[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };
+
+	for (i = 0; i < resp_len; ++i) {
+		req[INPUT_DATA_OFFSET] = reg++;
+		ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
+		if (ret)
+			return -EIO;
+		resp[i] = _resp[DATA_OFFSET];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_psy_multi_read);
+
+/* -------------------------------------------------------------------------- */
+/* API For WMI */
+
+/* Battery charging threshold */
+int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind)
+{
+	/* GBTT */
+	return gaokun_ec_read_byte(ec, (u8 []){0x02, 0x69, 1, ind}, value);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_threshold);
+
+int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end)
+{
+	/* SBTT */
+	int ret;
+	u8 req[REQ_HDR_SIZE + 2] = {0x02, 0x68, 2, 3, 0x5a};
+
+	ret = gaokun_ec_write(ec, req);
+	if (ret)
+		return -EIO;
+
+	if (start == 0 && end == 0)
+		return -EINVAL;
+
+	if (start >= 0 && start <= end && end <= 100) {
+		req[INPUT_DATA_OFFSET] = 1;
+		req[INPUT_DATA_OFFSET + 1] = start;
+		ret = gaokun_ec_write(ec, req);
+		if (ret)
+			return -EIO;
+
+		req[INPUT_DATA_OFFSET] = 2;
+		req[INPUT_DATA_OFFSET + 1] = end;
+		ret = gaokun_ec_write(ec, req);
+	} else {
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_threshold);
+
+/* Smart charge param */
+int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value)
+{
+	/* GBAC */
+	return gaokun_ec_read_byte(ec, (u8 []){0x02, 0xE6, 0}, value);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge_param);
+
+int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value)
+{
+	/* SBAC */
+	if (value < 0 || value > 2)
+		return -EINVAL;
+
+	return gaokun_ec_write(ec, (u8 []){0x02, 0xE5, 1, value});
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge_param);
+
+/* Smart charge */
+int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
+				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE])
+{
+	/* GBCM */
+	u8 req[REQ_HDR_SIZE] = {0x02, 0xE4, 0};
+	u8 resp[RESP_HDR_SIZE + 4];
+	int ret;
+
+	ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
+	if (ret)
+		return -EIO;
+
+	data[0] = resp[DATA_OFFSET];
+	data[1] = resp[DATA_OFFSET + 1];
+	data[2] = resp[DATA_OFFSET + 2];
+	data[3] = resp[DATA_OFFSET + 3];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_smart_charge);
+
+int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
+				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE])
+{
+	/* SBCM */
+	u8 req[REQ_HDR_SIZE + GAOKUN_SMART_CHARGE_DATA_SIZE] = {0x02, 0XE3, 4,};
+
+	if (!(data[2] >= 0 && data[2] <= data[3] && data[3] <= 100))
+		return -EINVAL;
+
+	memcpy(req + INPUT_DATA_OFFSET, data, GAOKUN_SMART_CHARGE_DATA_SIZE);
+
+	return gaokun_ec_write(ec, req);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_smart_charge);
+
+/* Fn lock */
+int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on)
+{
+	/* GFRS */
+	int ret;
+	u8 val;
+	u8 req[REQ_HDR_SIZE] = {0x02, 0x6B, 0};
+
+	ret = gaokun_ec_read_byte(ec, req, &val);
+	if (val == 0x55)
+		*on = 0;
+	else if (val == 0x5A)
+		*on = 1;
+	else
+		return -EIO;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_fn_lock);
+
+int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on)
+{
+	/* SFRS */
+	u8 req[REQ_HDR_SIZE + 1] = {0x02, 0x6C, 1,};
+
+	if (on == 0)
+		req[INPUT_DATA_OFFSET] = 0x55;
+	else if (on == 1)
+		req[INPUT_DATA_OFFSET] = 0x5A;
+	else
+		return -EINVAL;
+
+	return gaokun_ec_write(ec, req);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_set_fn_lock);
+
+/* Thermal Zone */
+/* Range from 0 to 0x2C, partial valid */
+static const u8 temp_reg[] = {0x05, 0x07, 0x08, 0x0E, 0x0F, 0x12, 0x15, 0x1E,
+			      0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26,
+			      0x27, 0x28, 0x29, 0x2A};
+
+int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_NUM])
+{
+	/* GTMP */
+	u8 req[REQ_HDR_SIZE] = {0x02, 0x61, 1,};
+	u8 resp[RESP_HDR_SIZE + sizeof(s16)];
+	int ret, i = 0;
+
+	while (i < GAOKUN_TZ_REG_NUM) {
+		req[INPUT_DATA_OFFSET] = temp_reg[i];
+		ret = gaokun_ec_read(ec, req, sizeof(resp), resp);
+		if (ret)
+			return -EIO;
+		temp[i++] = *(s16 *)(resp + DATA_OFFSET);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_wmi_get_temp);
+
+/* -------------------------------------------------------------------------- */
+/* API For UCSI */
+
+int gaokun_ec_ucsi_read(struct gaokun_ec *ec,
+			u8 resp[GAOKUN_UCSI_READ_SIZE])
+{
+	u8 req[REQ_HDR_SIZE] = {0x3, 0xD5, 0};
+	u8 _resp[RESP_HDR_SIZE + GAOKUN_UCSI_READ_SIZE];
+	int ret;
+
+	ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
+	if (ret)
+		return ret;
+
+	memcpy(resp, _resp + DATA_OFFSET, GAOKUN_UCSI_READ_SIZE);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_read);
+
+int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
+			 const u8 req[GAOKUN_UCSI_WRITE_SIZE])
+{
+	u8 _req[REQ_HDR_SIZE + GAOKUN_UCSI_WRITE_SIZE];
+
+	_req[0] = 0x03;
+	_req[1] = 0xD4;
+	_req[INPUT_SIZE_OFFSET] = GAOKUN_UCSI_WRITE_SIZE;
+	memcpy(_req + INPUT_DATA_OFFSET, req, GAOKUN_UCSI_WRITE_SIZE);
+
+	return gaokun_ec_write(ec, _req);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_write);
+
+int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg)
+{
+	u8 req[REQ_HDR_SIZE] = {0x03, 0xD3, 0};
+	u8 _resp[RESP_HDR_SIZE + UCSI_REG_SIZE];
+	int ret;
+
+	ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
+	if (ret)
+		return ret;
+
+	memcpy(ureg, _resp + DATA_OFFSET, UCSI_REG_SIZE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_get_reg);
+
+int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id)
+{
+	u8 req[REQ_HDR_SIZE + 1] = {0x03, 0xD2, 1, 0};
+
+	if (port_id >= 0)
+		req[INPUT_DATA_OFFSET] = 1 << port_id;
+
+	return gaokun_ec_write(ec, req);
+}
+EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_pan_ack);
+
+/* -------------------------------------------------------------------------- */
+/* Modern Standby */
+
+static int gaokun_ec_suspend(struct device *dev)
+{
+	struct gaokun_ec *ec = dev_get_drvdata(dev);
+	u8 req[REQ_HDR_SIZE + 1] = {0x02, 0xB2, 1, 0xDB};
+	int ret;
+
+	if (ec->suspended)
+		return 0;
+
+	ret = gaokun_ec_write(ec, req);
+
+	if (ret)
+		return ret;
+
+	ec->suspended = true;
+
+	return 0;
+}
+
+static int gaokun_ec_resume(struct device *dev)
+{
+	struct gaokun_ec *ec = dev_get_drvdata(dev);
+	u8 req[REQ_HDR_SIZE + 1] = {0x02, 0xB2, 1, 0xEB};
+	int ret;
+	int i;
+
+	if (!ec->suspended)
+		return 0;
+
+	for (i = 0; i < 3; i++) {
+		ret = gaokun_ec_write(ec, req);
+		if (ret == 0)
+			break;
+
+		msleep(100);
+	};
+
+	ec->suspended = false;
+
+	return 0;
+}
+
+static void gaokun_aux_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void gaokun_aux_remove(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int gaokun_aux_init(struct device *parent, const char *name,
+			   struct gaokun_ec *ec)
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
+	adev->dev.release = gaokun_aux_release;
+	adev->dev.platform_data = ec;
+	/* Allow aux devices to access parent's DT nodes directly */
+	device_set_of_node_from_dev(&adev->dev, parent);
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
+	return devm_add_action_or_reset(parent, gaokun_aux_remove, adev);
+}
+
+/* -------------------------------------------------------------------------- */
+/* EC */
+
+static irqreturn_t gaokun_ec_irq_handler(int irq, void *data)
+{
+	struct gaokun_ec *ec = data;
+	u8 req[REQ_HDR_SIZE] = {EC_EVENT, EC_QUERY, 0};
+	u8 status, id;
+	int ret;
+
+	ret = gaokun_ec_read_byte(ec, req, &id);
+	if (ret)
+		return IRQ_HANDLED;
+
+	switch (id) {
+	case 0x0: /* No event */
+		break;
+
+	case EC_EVENT_LID:
+		gaokun_ec_psy_read_byte(ec, EC_LID_STATE, &status);
+		status = EC_LID_OPEN & status;
+		input_report_switch(ec->idev, SW_LID, !status);
+		input_sync(ec->idev);
+		break;
+
+	default:
+		blocking_notifier_call_chain(&ec->notifier_list, id, ec);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int gaokun_ec_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct gaokun_ec *ec;
+	int ret;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	mutex_init(&ec->lock);
+	ec->client = client;
+	i2c_set_clientdata(client, ec);
+	BLOCKING_INIT_NOTIFIER_HEAD(&ec->notifier_list);
+
+	/* Lid switch */
+	ec->idev = devm_input_allocate_device(dev);
+	if (!ec->idev)
+		return -ENOMEM;
+
+	ec->idev->name = "LID";
+	ec->idev->phys = "gaokun-ec/input0";
+	input_set_capability(ec->idev, EV_SW, SW_LID);
+
+	ret = input_register_device(ec->idev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register input device\n");
+
+	ret = gaokun_aux_init(dev, "psy", ec);
+	if (ret)
+		return ret;
+
+	ret = gaokun_aux_init(dev, "wmi", ec);
+	if (ret)
+		return ret;
+
+	ret = gaokun_aux_init(dev, "ucsi", ec);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					gaokun_ec_irq_handler, IRQF_ONESHOT,
+					dev_name(dev), ec);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id gaokun_ec_id[] = {
+	{ "gaokun-ec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gaokun_ec_id);
+
+static const struct of_device_id gaokun_ec_of_match[] = {
+	{ .compatible = "huawei,gaokun-ec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gaokun_ec_of_match);
+
+static const struct dev_pm_ops gaokun_ec_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(gaokun_ec_suspend, gaokun_ec_resume)
+};
+
+static struct i2c_driver gaokun_ec_driver = {
+	.driver = {
+		.name = "gaokun-ec",
+		.of_match_table = gaokun_ec_of_match,
+		.pm = &gaokun_ec_pm_ops,
+	},
+	.probe = gaokun_ec_probe,
+	.id_table = gaokun_ec_id,
+};
+module_i2c_driver(gaokun_ec_driver);
+
+MODULE_DESCRIPTION("HUAWEI Matebook E Go EC driver");
+MODULE_AUTHOR("Pengyu Luo <mitltlatltl@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/arm64/huawei-gaokun-wmi.c b/drivers/platform/arm64/huawei-gaokun-wmi.c
new file mode 100644
index 000000000..793cb1659
--- /dev/null
+++ b/drivers/platform/arm64/huawei-gaokun-wmi.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * huawei-gaokun-wmi - A WMI driver for HUAWEI Matebook E Go (sc8280xp)
+ *
+ * reference: drivers/platform/x86/huawei-wmi.c
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include <linux/version.h>
+
+#include <linux/platform_data/huawei-gaokun-ec.h>
+
+struct gaokun_wmi {
+	struct gaokun_ec *ec;
+	struct device *dev;
+	struct platform_device *wmi;
+};
+
+/* -------------------------------------------------------------------------- */
+/* Battery charging threshold */
+
+enum gaokun_wmi_threshold_ind {
+	START	= 1,
+	END	= 2,
+};
+
+static ssize_t charge_control_thresholds_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	int ret;
+	u8 start, end;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	ret = gaokun_ec_wmi_get_threshold(ecwmi->ec, &start, START)
+		|| gaokun_ec_wmi_get_threshold(ecwmi->ec, &end, END);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d %d\n", start, end);
+}
+
+static ssize_t charge_control_thresholds_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t size)
+{
+	int ret;
+	u8 start, end;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	if (sscanf(buf, "%hhd %hhd", &start, &end) != 2)
+		return -EINVAL;
+
+	ret = gaokun_ec_wmi_set_threshold(ecwmi->ec, start, end);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(charge_control_thresholds);
+
+/* -------------------------------------------------------------------------- */
+/* Smart charge param */
+
+static ssize_t smart_charge_param_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	int ret;
+	u8 value;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	ret = gaokun_ec_wmi_get_smart_charge_param(ecwmi->ec, &value);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", value);
+}
+
+static ssize_t smart_charge_param_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	int ret;
+	u8 value;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 10, &value))
+		return -EINVAL;
+
+	ret = gaokun_ec_wmi_set_smart_charge_param(ecwmi->ec, value);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(smart_charge_param);
+
+/* -------------------------------------------------------------------------- */
+/* Smart charge */
+
+static ssize_t smart_charge_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	int ret;
+	u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	ret = gaokun_ec_wmi_get_smart_charge(ecwmi->ec, bf);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d %d %d %d\n",
+			  bf[0], bf[1], bf[2], bf[3]);
+}
+
+static ssize_t smart_charge_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	int ret;
+	u8 bf[GAOKUN_SMART_CHARGE_DATA_SIZE];
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	if (sscanf(buf, "%hhd %hhd %hhd %hhd", bf, bf + 1, bf + 2, bf + 3) != 4)
+		return -EINVAL;
+
+	ret = gaokun_ec_wmi_set_smart_charge(ecwmi->ec, bf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(smart_charge);
+
+/* -------------------------------------------------------------------------- */
+/* Fn lock */
+
+static ssize_t fn_lock_state_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int ret;
+	u8 on;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	ret = gaokun_ec_wmi_get_fn_lock(ecwmi->ec, &on);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", on);
+}
+
+static ssize_t fn_lock_state_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	int ret;
+	u8 on;
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	if (kstrtou8(buf, 10, &on))
+		return -EINVAL;
+
+	ret = gaokun_ec_wmi_set_fn_lock(ecwmi->ec, on);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(fn_lock_state);
+
+/* -------------------------------------------------------------------------- */
+/* Thermal Zone */
+
+static ssize_t temperature_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+
+	int ret, len, i;
+	char *ptr = buf;
+	s16 value;
+	s16 temp[GAOKUN_TZ_REG_NUM];
+	struct gaokun_wmi *ecwmi = dev_get_drvdata(dev);
+
+	ret = gaokun_ec_wmi_get_temp(ecwmi->ec, temp);
+	if (ret)
+		return ret;
+
+	i = 0;
+	len = 0;
+	while (i < GAOKUN_TZ_REG_NUM) {
+		value = temp[i++];
+		if (value < 0) {
+			len += sprintf(ptr + len, "-");
+			value = -value;
+		}
+		len += sprintf(ptr + len, "%d.%d ", value / 10, value % 10);
+	}
+	len += sprintf(ptr + len, "\n");
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(temperature);
+
+static struct attribute *gaokun_wmi_features_attrs[] = {
+	&dev_attr_charge_control_thresholds.attr,
+	&dev_attr_smart_charge_param.attr,
+	&dev_attr_smart_charge.attr,
+	&dev_attr_fn_lock_state.attr,
+	&dev_attr_temperature.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gaokun_wmi_features);
+
+static int gaokun_wmi_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
+{
+	struct gaokun_ec *ec = adev->dev.platform_data;
+	struct device *dev = &adev->dev;
+	struct gaokun_wmi *ecwmi;
+
+	ecwmi = devm_kzalloc(&adev->dev, sizeof(*ecwmi), GFP_KERNEL);
+	if (!ecwmi)
+		return -ENOMEM;
+
+	ecwmi->ec = ec;
+	ecwmi->dev = dev;
+
+	auxiliary_set_drvdata(adev, ecwmi);
+
+	/* make it under /sys/devices/platform, convenient for sysfs I/O,
+	 * while adev is under
+	 * /sys/devices/platform/soc@0/ac0000.geniqup/a9c000.i2c/i2c-15/15-0038/
+	 */
+	ecwmi->wmi = platform_device_register_simple("gaokun-wmi", -1, NULL, 0);
+	if (IS_ERR(ecwmi->wmi))
+		return dev_err_probe(dev, PTR_ERR(ecwmi->wmi),
+				     "Failed to register wmi platform device\n");
+
+	platform_set_drvdata(ecwmi->wmi, ecwmi);
+
+	return device_add_groups(&ecwmi->wmi->dev, gaokun_wmi_features_groups);
+}
+
+static void gaokun_wmi_remove(struct auxiliary_device *adev)
+{
+	struct gaokun_wmi *ecwmi = auxiliary_get_drvdata(adev);
+	struct platform_device *wmi = ecwmi->wmi;
+
+	device_remove_groups(&wmi->dev, gaokun_wmi_features_groups);
+	platform_device_unregister(ecwmi->wmi);
+}
+
+static const struct auxiliary_device_id gaokun_wmi_id_table[] = {
+	{ .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_WMI, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, gaokun_wmi_id_table);
+
+static struct auxiliary_driver gaokun_wmi_driver = {
+	.name = GAOKUN_DEV_WMI,
+	.id_table = gaokun_wmi_id_table,
+	.probe = gaokun_wmi_probe,
+	.remove = gaokun_wmi_remove,
+};
+
+module_auxiliary_driver(gaokun_wmi_driver);
+
+MODULE_DESCRIPTION("HUAWEI Matebook E Go WMI driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/huawei-gaokun-ec.h b/include/linux/platform_data/huawei-gaokun-ec.h
new file mode 100644
index 000000000..a649e9ecf
--- /dev/null
+++ b/include/linux/platform_data/huawei-gaokun-ec.h
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Huawei Matebook E Go (sc8280xp) Embedded Controller
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ *
+ */
+
+#ifndef __HUAWEI_GAOKUN_EC_H__
+#define __HUAWEI_GAOKUN_EC_H__
+
+#define GAOKUN_UCSI_CCI_SIZE	4
+#define GAOKUN_UCSI_DATA_SIZE	16
+#define GAOKUN_UCSI_READ_SIZE	(GAOKUN_UCSI_CCI_SIZE + GAOKUN_UCSI_DATA_SIZE)
+#define GAOKUN_UCSI_WRITE_SIZE	0x18
+
+#define GAOKUN_TZ_REG_NUM	20
+#define GAOKUN_SMART_CHARGE_DATA_SIZE	4 /* mode, delay, start, end */
+
+/* -------------------------------------------------------------------------- */
+
+struct gaokun_ec;
+struct notifier_block;
+
+#define GAOKUN_MOD_NAME			"huawei_gaokun_ec"
+#define GAOKUN_DEV_PSY			"psy"
+#define GAOKUN_DEV_WMI			"wmi"
+#define GAOKUN_DEV_UCSI			"ucsi"
+
+/* -------------------------------------------------------------------------- */
+/* Common API */
+
+int gaokun_ec_register_notify(struct gaokun_ec *ec,
+			      struct notifier_block *nb);
+void gaokun_ec_unregister_notify(struct gaokun_ec *ec,
+				 struct notifier_block *nb);
+
+int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
+		   size_t resp_len, u8 *resp);
+int gaokun_ec_write(struct gaokun_ec *ec, u8 *req);
+int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte);
+
+/* -------------------------------------------------------------------------- */
+/* API For PSY */
+
+int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
+			     size_t resp_len, u8 *resp);
+
+static inline int gaokun_ec_psy_read_byte(struct gaokun_ec *ec,
+					  u8 reg, u8 *byte)
+{
+	return gaokun_ec_psy_multi_read(ec, reg, 1, byte);
+}
+
+static inline int gaokun_ec_psy_read_word(struct gaokun_ec *ec,
+					  u8 reg, u16 *word)
+{
+	return gaokun_ec_psy_multi_read(ec, reg, 2, (u8 *)word);
+}
+
+/* -------------------------------------------------------------------------- */
+/* API For WMI */
+
+int gaokun_ec_wmi_get_threshold(struct gaokun_ec *ec, u8 *value, int ind);
+int gaokun_ec_wmi_set_threshold(struct gaokun_ec *ec, u8 start, u8 end);
+
+int gaokun_ec_wmi_get_smart_charge_param(struct gaokun_ec *ec, u8 *value);
+int gaokun_ec_wmi_set_smart_charge_param(struct gaokun_ec *ec, u8 value);
+
+int gaokun_ec_wmi_get_smart_charge(struct gaokun_ec *ec,
+				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
+int gaokun_ec_wmi_set_smart_charge(struct gaokun_ec *ec,
+				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
+
+int gaokun_ec_wmi_get_fn_lock(struct gaokun_ec *ec, u8 *on);
+int gaokun_ec_wmi_set_fn_lock(struct gaokun_ec *ec, u8 on);
+
+int gaokun_ec_wmi_get_temp(struct gaokun_ec *ec, s16 temp[GAOKUN_TZ_REG_NUM]);
+
+/* -------------------------------------------------------------------------- */
+/* API For UCSI */
+
+int gaokun_ec_ucsi_read(struct gaokun_ec *ec, u8 resp[GAOKUN_UCSI_READ_SIZE]);
+int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
+			 const u8 req[GAOKUN_UCSI_WRITE_SIZE]);
+
+int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg);
+int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id);
+
+
+#endif /* __HUAWEI_GAOKUN_EC_H__ */
-- 
2.47.1


