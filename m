Return-Path: <linux-pm+bounces-19970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC306A01B1C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3F41883C73
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC81CDFD5;
	Sun,  5 Jan 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiIaQTq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEF1C0DED;
	Sun,  5 Jan 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099082; cv=none; b=UlqsM/eErlOMkQ25tMN58Uzc8n0F5Fg+2N9gfTr7/TuuAi1y6uueUzTHqwJksdUQhx2vBVn/aupABcF+MqtQzo+d0h8bZxedq9P5g20MmR3oKF4oewjZoZPcDzvLQgY/PmRWeGREq8wM1K+5eRAaXPebg1d6NNdQ8cVK/oLicT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099082; c=relaxed/simple;
	bh=D5IlMtAl+uTkkx/UIKc3WY2G0+8X7xX8G8TaPY6+f6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6oUG4AD7mpEiWhN3PUvYFvRbNz6LT/HOI+qKqm5au39jr+IfJ7IuS8jJFa6RxJySGEFTTKjJJWkqHxb2g8v0p2Lq1RbTltak7GqbIUDEPKwMQxpIQRPEJn30ZQtgZuAy4M0iblQ+gIRPBFApePFkG3qEsHHR+BLFbpSygYwufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiIaQTq0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216728b1836so174373945ad.0;
        Sun, 05 Jan 2025 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099079; x=1736703879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d0jF7kNZrSFFba9MWDdQNjjLx4MP93BazBprG+7xJg=;
        b=FiIaQTq0TVv5UUZ/HGNVg0nVnJQXaKW2B5xGa6TPLTZBcXzQA8DVESw6ZFscSAR2kj
         Fva3QPkWMfpFbACsdpq5FEWC2qduEOCi8kA6gUbhfvrBKOKcavXrnNFBJbUZ2wTPDwlT
         9wGb1zDimgFNLeCJO8c66nqFqVI4YOwZJgUlDlbhVu3cdcCFGiKooY3KUYXXpv6N/50t
         V+UZg/qhivz2Dhf1qf237KUJx2EA+L3oJzPwepk1SVh1ARc2UpPXbVEJwytskmYrTeW4
         2ggbMFxv/a/8GVOjaRV1zYZyqGot9mVQs2lMPffltZI1+WUh9cxdUuVk6NoIElizQy3v
         2x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099079; x=1736703879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d0jF7kNZrSFFba9MWDdQNjjLx4MP93BazBprG+7xJg=;
        b=h3gErzaj6RFftskuj1s1jLqcUlJ7h8lleg1MCxt8IUenxAyNOWlWkebr0XPXW5YWQt
         LfGcG2KZISzPfXFdGHWvmQLMA5h7w80PS8iNcLnvQ5pQvI3HM2eMAhZt6CQ0CgC0oESq
         PAOAP3ls1bcnHV/85y/KIeRauB+NeDmd0uKQSmk8uZZYxf5Hf8xNa5b1RS9d0SiljgZr
         a8Z1KeSYy5nz1UD98TaocVOamYmUl1gM75ArcP2CY7MCezH9nvYV6Wmp1fLfARSJHN6D
         1Zx6u4p0zZXPgwCIbL72C1hbZmp7OLz/U8VciCb2cmx5QA0gCoYeKh6sifvNDZj0C/q9
         +SvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfMylNldcUJCVaZYvjVxjD/f3U15gdG0X5aESNr2dhqi03aPM3WmYrOSZYE6YffefQInxd/KPpSEibXIZ4@vger.kernel.org, AJvYcCUrRMLcmLviwOKkJDzJexnRMLdtJFHIcgLEgIZrQ+gDsNNhBBEMxAFiiYpU9RfEAvx0ax3Tcl3SlobB@vger.kernel.org, AJvYcCVgLdWKTI+DKIVd2bYMSiV/kAelnxjFzcc8qS5qTFOAbushf/tVAeE3LK0n9VNYh6YbAwucVpw12lQ=@vger.kernel.org, AJvYcCX3iAy0VjjmcZrz++HfQJ3ihZLl6+fiJapX7Z/UCKfe3nTjCev+R+r6MwPkvRDTGNGe/HqFVdynSoDw39sHuqd1870dog==@vger.kernel.org, AJvYcCXdO1mSOw89qWLu0F/6ZMDVDhERGkZZJJLR0k/JWXZJ3cyNb0d3PBOUAPob7kRS7e+Hprdkc/kcOnlw5og=@vger.kernel.org, AJvYcCXgs2NwxX7oalWB0g3VBYj/AzyDx+DYrgV2zf9GdxB7Y74AC+vV6GtzFB+Xj5MBToeOtOc3uSP72gzb4ylf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EYRw+FWG7WW56I65qMMcdREHV0AYtLsURWOw9Yq+/5ZtRzNM
	GBGf/EwRMm63nZ8Cv40QXvws+rA44LvdgZOLvsiZqbydaP0W88Y9
X-Gm-Gg: ASbGncvu/bGZb+KICS2+VyTC+tUMWs9r24c/EcMGr2X2b06wlzw/6qEGt5gIziGOHvW
	Crnh7SMyEyOWnzUdCZNMTJeXZB1xIV8fIV+YddbGvJ8YsVT9eUqa4cEo08bmul/vSvIxfN70ZrZ
	PpNH/laWhi/Y5Mw56Rr0DS8DH3/fMKxP64dg1ImT7QD0o1rY8/tbcMP7iOkzSzTO6EiwlFaX/Hm
	eDn20TPACrL9UPmC7FHPGvfPUHq/jChLUy7q+sqo23XnVcVeF7+L9M=
X-Google-Smtp-Source: AGHT+IFhM4H+33xSsvYkhW92V2AuBbuHnXONZyxIVy6w65xEXqkkQV+s2rc8boow5qq5ZPwfsij3gQ==
X-Received: by 2002:a05:6a00:acc:b0:72a:bb83:7804 with SMTP id d2e1a72fcca58-72abde81bf6mr81637286b3a.17.1736099079345;
        Sun, 05 Jan 2025 09:44:39 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842abd5927fsm27375046a12.10.2025.01.05.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:44:38 -0800 (PST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 3/5] usb: typec: ucsi: add Huawei Matebook E Go ucsi driver
Date: Mon,  6 Jan 2025 01:41:57 +0800
Message-ID: <20250105174159.227831-4-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105174159.227831-1-mitltlatltl@gmail.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Huawei Matebook E Go tablet implements the UCSI interface in the
onboard EC. Add the glue driver to interface with the platform's UCSI
implementation.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/usb/typec/ucsi/Kconfig              |  10 +
 drivers/usb/typec/ucsi/Makefile             |   1 +
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 524 ++++++++++++++++++++
 3 files changed, 535 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 680e1b87b..8a73df84a 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -78,4 +78,14 @@ config UCSI_LENOVO_YOGA_C630
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_yoga_c630.
 
+config UCSI_HUAWEI_GAOKUN
+	tristate "UCSI Interface Driver for Huawei Matebook E Go"
+	depends on EC_HUAWEI_GAOKUN
+	help
+	  This driver enables UCSI support on the Huawei Matebook E Go tablet,
+	  which is a sc8280xp-based 2-in-1 tablet.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_huawei_gaokun.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index aed41d238..0b400122b 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
 obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
 obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
 obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
+obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
new file mode 100644
index 000000000..044545b44
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go
+ *
+ * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+ *            drivers/usb/typec/ucsi/ucsi_glink.c
+ *            drivers/soc/qcom/pmic_glink_altmode.c
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ */
+
+#include <drm/bridge/aux-bridge.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_data/huawei-gaokun-ec.h>
+#include <linux/string.h>
+#include <linux/usb/pd_vdo.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/workqueue_types.h>
+
+#include "ucsi.h"
+
+#define EC_EVENT_UCSI	0x21
+#define EC_EVENT_USB	0x22
+
+#define GAOKUN_CCX_MASK		GENMASK(1, 0)
+#define GAOKUN_MUX_MASK		GENMASK(3, 2)
+
+#define GAOKUN_DPAM_MASK	GENMASK(3, 0)
+#define GAOKUN_HPD_STATE_MASK	BIT(4)
+#define GAOKUN_HPD_IRQ_MASK	BIT(5)
+
+#define GET_IDX(updt) (ffs(updt) - 1)
+
+#define CCX_TO_ORI(ccx) (++ccx % 3) /* convert ccx to enum typec_orientation */
+
+/* Configuration Channel Extension */
+enum gaokun_ucsi_ccx {
+	USBC_CCX_NORMAL,
+	USBC_CCX_REVERSE,
+	USBC_CCX_NONE,
+};
+
+enum gaokun_ucsi_mux {
+	USBC_MUX_NONE,
+	USBC_MUX_USB_2L,
+	USBC_MUX_DP_4L,
+	USBC_MUX_USB_DP,
+};
+/* based on pmic_glink_altmode_pin_assignment */
+enum gaokun_ucsi_dpam_pan {	/* DP Alt Mode Pin Assignments */
+	USBC_DPAM_PAN_NONE,
+	USBC_DPAM_PAN_A,	/* Not supported after USB Type-C Standard v1.0b */
+	USBC_DPAM_PAN_B,	/* Not supported after USB Type-C Standard v1.0b */
+	USBC_DPAM_PAN_C,	/* USBC_DPAM_PAN_C_REVERSE - 6 */
+	USBC_DPAM_PAN_D,
+	USBC_DPAM_PAN_E,
+	USBC_DPAM_PAN_F,	/* Not supported after USB Type-C Standard v1.0b */
+	USBC_DPAM_PAN_A_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
+	USBC_DPAM_PAN_B_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
+	USBC_DPAM_PAN_C_REVERSE,
+	USBC_DPAM_PAN_D_REVERSE,
+	USBC_DPAM_PAN_E_REVERSE,
+	USBC_DPAM_PAN_F_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
+};
+
+struct gaokun_ucsi_reg {
+	u8 port_num;
+	u8 port_updt;
+	u8 port_data[4];
+	u8 checksum;
+	u8 reserved;
+} __packed;
+
+struct gaokun_ucsi_port {
+	struct completion usb_ack;
+	spinlock_t lock;
+
+	struct gaokun_ucsi *ucsi;
+	struct auxiliary_device *bridge;
+
+	int idx;
+	enum gaokun_ucsi_ccx ccx;
+	enum gaokun_ucsi_mux mux;
+	u8 mode;
+	u16 svid;
+	u8 hpd_state;
+	u8 hpd_irq;
+};
+
+struct gaokun_ucsi {
+	struct gaokun_ec *ec;
+	struct ucsi *ucsi;
+	struct gaokun_ucsi_port *ports;
+	struct device *dev;
+	struct delayed_work work;
+	struct notifier_block nb;
+	u16 version;
+	u8 port_num;
+};
+
+/* -------------------------------------------------------------------------- */
+/* For UCSI */
+
+static int gaokun_ucsi_read_version(struct ucsi *ucsi, u16 *version)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
+
+	*version = uec->version;
+
+	return 0;
+}
+
+static int gaokun_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
+	u8 buf[GAOKUN_UCSI_READ_SIZE];
+	int ret;
+
+	ret = gaokun_ec_ucsi_read(uec->ec, buf);
+	if (ret)
+		return ret;
+
+	memcpy(cci, buf, sizeof(*cci));
+
+	return 0;
+}
+
+static int gaokun_ucsi_read_message_in(struct ucsi *ucsi,
+				       void *val, size_t val_len)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
+	u8 buf[GAOKUN_UCSI_READ_SIZE];
+	int ret;
+
+	ret = gaokun_ec_ucsi_read(uec->ec, buf);
+	if (ret)
+		return ret;
+
+	memcpy(val, buf + GAOKUN_UCSI_CCI_SIZE,
+	       min(val_len, GAOKUN_UCSI_DATA_SIZE));
+
+	return 0;
+}
+
+static int gaokun_ucsi_async_control(struct ucsi *ucsi, u64 command)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
+	u8 buf[GAOKUN_UCSI_WRITE_SIZE] = {};
+
+	memcpy(buf, &command, sizeof(command));
+
+	return gaokun_ec_ucsi_write(uec->ec, buf);
+}
+
+static void gaokun_ucsi_update_connector(struct ucsi_connector *con)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
+
+	if (con->num > uec->port_num)
+		return;
+
+	con->typec_cap.orientation_aware = true;
+}
+
+static void gaokun_set_orientation(struct ucsi_connector *con,
+				   struct gaokun_ucsi_port *port)
+{
+	enum gaokun_ucsi_ccx ccx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ccx = port->ccx;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	typec_set_orientation(con->port, CCX_TO_ORI(ccx));
+}
+
+static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
+{
+	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
+	int idx;
+
+	idx = con->num - 1;
+	if (con->num > uec->port_num) {
+		dev_warn(uec->dev, "set orientation out of range: con%d\n", idx);
+		return;
+	}
+
+	gaokun_set_orientation(con, &uec->ports[idx]);
+}
+
+const struct ucsi_operations gaokun_ucsi_ops = {
+	.read_version = gaokun_ucsi_read_version,
+	.read_cci = gaokun_ucsi_read_cci,
+	.read_message_in = gaokun_ucsi_read_message_in,
+	.sync_control = ucsi_sync_control_common,
+	.async_control = gaokun_ucsi_async_control,
+	.update_connector = gaokun_ucsi_update_connector,
+	.connector_status = gaokun_ucsi_connector_status,
+};
+
+/* -------------------------------------------------------------------------- */
+/* For Altmode */
+
+static void gaokun_ucsi_port_update(struct gaokun_ucsi_port *port,
+				    const u8 *port_data)
+{
+	struct gaokun_ucsi *uec = port->ucsi;
+	int offset = port->idx * 2; /* every port has 2 Bytes data */
+	unsigned long flags;
+	u8 dcc, ddi;
+
+	dcc = port_data[offset];
+	ddi = port_data[offset + 1];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	port->ccx = FIELD_GET(GAOKUN_CCX_MASK, dcc);
+	port->mux = FIELD_GET(GAOKUN_MUX_MASK, dcc);
+	port->mode = FIELD_GET(GAOKUN_DPAM_MASK, ddi);
+	port->hpd_state = FIELD_GET(GAOKUN_HPD_STATE_MASK, ddi);
+	port->hpd_irq = FIELD_GET(GAOKUN_HPD_IRQ_MASK, ddi);
+
+	/* Mode and SVID are unused; keeping them to make things clearer */
+	switch (port->mode) {
+	case USBC_DPAM_PAN_C:
+	case USBC_DPAM_PAN_C_REVERSE:
+		port->mode = DP_PIN_ASSIGN_C; /* correct it for usb later */
+		break;
+	case USBC_DPAM_PAN_D:
+	case USBC_DPAM_PAN_D_REVERSE:
+		port->mode = DP_PIN_ASSIGN_D;
+		break;
+	case USBC_DPAM_PAN_E:
+	case USBC_DPAM_PAN_E_REVERSE:
+		port->mode = DP_PIN_ASSIGN_E;
+		break;
+	case USBC_DPAM_PAN_NONE:
+		port->mode = TYPEC_STATE_SAFE;
+		break;
+	default:
+		dev_warn(uec->dev, "unknow mode %d\n", port->mode);
+		break;
+	}
+
+	switch (port->mux) {
+	case USBC_MUX_NONE:
+		port->svid = 0;
+		break;
+	case USBC_MUX_USB_2L:
+		port->svid = USB_SID_PD;
+		port->mode = TYPEC_STATE_USB; /* same as PAN_C, correct it */
+		break;
+	case USBC_MUX_DP_4L:
+	case USBC_MUX_USB_DP:
+		port->svid = USB_SID_DISPLAYPORT;
+		break;
+	default:
+		dev_warn(uec->dev, "unknow mux state %d\n", port->mux);
+		break;
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
+{
+	struct gaokun_ucsi_reg ureg;
+	int ret, idx;
+
+	ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
+	if (ret)
+		return GAOKUN_UCSI_NO_PORT_UPDATE;
+
+	uec->port_num = ureg.port_num;
+	idx = GET_IDX(ureg.port_updt);
+
+	if (idx < 0 || idx >= ureg.port_num)
+		return GAOKUN_UCSI_NO_PORT_UPDATE;
+
+	gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
+	return idx;
+}
+
+static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
+{
+	struct gaokun_ucsi *uec = port->ucsi;
+	int idx = port->idx;
+
+	if (idx >= uec->ucsi->cap.num_connectors) {
+		dev_warn(uec->dev, "altmode port out of range: %d\n", idx);
+		return;
+	}
+
+	/* UCSI callback .connector_status() have set orientation */
+	if (port->bridge)
+		drm_aux_hpd_bridge_notify(&port->bridge->dev,
+					  port->hpd_state ?
+					  connector_status_connected :
+					  connector_status_disconnected);
+
+	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
+}
+
+static void gaokun_ucsi_altmode_notify_ind(struct gaokun_ucsi *uec)
+{
+	int idx;
+
+	 if (!uec->ucsi->connector) { /* slow to register */
+		 dev_err(uec->dev, "ucsi connector is not initialized yet\n");
+		 return;
+	 }
+
+	idx = gaokun_ucsi_refresh(uec);
+	if (idx == GAOKUN_UCSI_NO_PORT_UPDATE)
+		gaokun_ec_ucsi_pan_ack(uec->ec, idx); /* ack directly if no update */
+	else
+		gaokun_ucsi_handle_altmode(&uec->ports[idx]);
+}
+
+/*
+ * USB event is necessary for enabling altmode, the event should follow
+ * UCSI event, if not after timeout(this notify may be disabled somehow),
+ * then force to enable altmode.
+ */
+static void gaokun_ucsi_handle_no_usb_event(struct gaokun_ucsi *uec, int idx)
+{
+	struct gaokun_ucsi_port *port;
+
+	port = &uec->ports[idx];
+	if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
+		dev_warn(uec->dev, "No USB EVENT, triggered by UCSI EVENT");
+		gaokun_ucsi_altmode_notify_ind(uec);
+	}
+}
+
+static int gaokun_ucsi_notify(struct notifier_block *nb,
+			      unsigned long action, void *data)
+{
+	u32 cci;
+	struct gaokun_ucsi *uec = container_of(nb, struct gaokun_ucsi, nb);
+
+	switch (action) {
+	case EC_EVENT_USB:
+		gaokun_ucsi_altmode_notify_ind(uec);
+		return NOTIFY_OK;
+
+	case EC_EVENT_UCSI:
+		uec->ucsi->ops->read_cci(uec->ucsi, &cci);
+		ucsi_notify_common(uec->ucsi, cci);
+		if (UCSI_CCI_CONNECTOR(cci))
+			gaokun_ucsi_handle_no_usb_event(uec, UCSI_CCI_CONNECTOR(cci) - 1);
+
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static inline int gaokun_ucsi_get_port_num(struct gaokun_ucsi *uec)
+{
+	struct gaokun_ucsi_reg ureg;
+	int ret;
+
+	ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
+
+	return ret ? 0 : ureg.port_num;
+}
+
+static int gaokun_ucsi_ports_init(struct gaokun_ucsi *uec)
+{
+	u32 port;
+	int i, ret, port_num;
+	struct device *dev = uec->dev;
+	struct gaokun_ucsi_port *ucsi_port;
+	struct fwnode_handle *fwnode;
+
+	port_num = gaokun_ucsi_get_port_num(uec);
+	uec->port_num = port_num;
+
+	uec->ports = devm_kcalloc(dev, port_num, sizeof(*(uec->ports)),
+				  GFP_KERNEL);
+	if (!uec->ports)
+		return -ENOMEM;
+
+	for (i = 0; i < port_num; ++i) {
+		ucsi_port = &uec->ports[i];
+		ucsi_port->ccx = USBC_CCX_NONE;
+		ucsi_port->idx = i;
+		ucsi_port->ucsi = uec;
+		init_completion(&ucsi_port->usb_ack);
+		spin_lock_init(&ucsi_port->lock);
+	}
+
+	device_for_each_child_node(dev, fwnode) {
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			fwnode_handle_put(fwnode);
+			return ret;
+		}
+
+		if (port >= port_num) {
+			dev_warn(dev, "invalid connector number %d, ignoring\n", port);
+			continue;
+		}
+
+		ucsi_port = &uec->ports[port];
+		ucsi_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
+		if (IS_ERR(ucsi_port->bridge)) {
+			fwnode_handle_put(fwnode);
+			return PTR_ERR(ucsi_port->bridge);
+		}
+	}
+
+	for (i = 0; i < port_num; i++) {
+		if (!uec->ports[i].bridge)
+			continue;
+
+		ret = devm_drm_dp_hpd_bridge_add(dev, uec->ports[i].bridge);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void gaokun_ucsi_register_worker(struct work_struct *work)
+{
+	struct gaokun_ucsi *uec;
+	struct ucsi *ucsi;
+	int ret;
+
+	uec = container_of(work, struct gaokun_ucsi, work.work);
+	ucsi = uec->ucsi;
+	/* This may be a problem specific to sc8280xp-based machines */
+	ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
+
+	ret = gaokun_ec_register_notify(uec->ec, &uec->nb);
+	if (ret) {
+		dev_err_probe(ucsi->dev, ret, "notifier register failed\n");
+		return;
+	}
+
+	ret = ucsi_register(ucsi);
+	if (ret)
+		dev_err_probe(ucsi->dev, ret, "ucsi register failed\n");
+}
+
+static inline int gaokun_ucsi_register(struct gaokun_ucsi *uec)
+{
+	/* EC can't handle UCSI properly in the early stage */
+	schedule_delayed_work(&uec->work, 3 * HZ);
+
+	return 0;
+}
+
+static int gaokun_ucsi_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct gaokun_ec *ec = adev->dev.platform_data;
+	struct device *dev = &adev->dev;
+	struct gaokun_ucsi *uec;
+	int ret;
+
+	uec = devm_kzalloc(dev, sizeof(*uec), GFP_KERNEL);
+	if (!uec)
+		return -ENOMEM;
+
+	uec->ec = ec;
+	uec->dev = dev;
+	uec->version = 0x0100;
+	uec->nb.notifier_call = gaokun_ucsi_notify;
+
+	INIT_DELAYED_WORK(&uec->work, gaokun_ucsi_register_worker);
+
+	ret = gaokun_ucsi_ports_init(uec);
+	if (ret)
+		return ret;
+
+	uec->ucsi = ucsi_create(dev, &gaokun_ucsi_ops);
+	if (IS_ERR(uec->ucsi))
+		return PTR_ERR(uec->ucsi);
+
+	ucsi_set_drvdata(uec->ucsi, uec);
+	auxiliary_set_drvdata(adev, uec);
+
+	return gaokun_ucsi_register(uec);
+}
+
+static void gaokun_ucsi_remove(struct auxiliary_device *adev)
+{
+	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
+
+	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
+	ucsi_unregister(uec->ucsi);
+	ucsi_destroy(uec->ucsi);
+}
+
+static const struct auxiliary_device_id gaokun_ucsi_id_table[] = {
+	{ .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_UCSI, },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, gaokun_ucsi_id_table);
+
+static struct auxiliary_driver gaokun_ucsi_driver = {
+	.name = GAOKUN_DEV_UCSI,
+	.id_table = gaokun_ucsi_id_table,
+	.probe = gaokun_ucsi_probe,
+	.remove = gaokun_ucsi_remove,
+};
+
+module_auxiliary_driver(gaokun_ucsi_driver);
+
+MODULE_DESCRIPTION("HUAWEI Matebook E Go UCSI driver");
+MODULE_LICENSE("GPL");
-- 
2.47.1


