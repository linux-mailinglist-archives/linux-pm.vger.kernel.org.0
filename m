Return-Path: <linux-pm+bounces-19780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D289FD677
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CED9164555
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5B1F8ADA;
	Fri, 27 Dec 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwA/Iesy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02851F8697;
	Fri, 27 Dec 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319741; cv=none; b=s+Bacblsbbl9bN9gjLHJUpQUfeK0CbDDQbQ8RRbDmzHGx2r/fR5RXaaOQkJL6UqpihU7buzYg9yFTRKKdY/tiKRR3SBTx7/mXjFXzKlRVAItvgSqh2V0jqdpBqbIpqIXUnpIPwZYwLNVlnH0fyERDb7kZ2LfKAc5q7IqYE4AUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319741; c=relaxed/simple;
	bh=mdwOStdBuKl43dStixJcmAf3kFLlRgS+OF1uMIKc2pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/eeFm+txKCjAFufbEmLyaZLbTMQGDXtTSlSnEh0lhnWd+7StVJqSTBon3ano1NOa91yBlyxcaOfTtuDWC+slUQP7d1pSvRWUc0ScYWjtgP9i2e9Xv7jj53dNUb5dPo+m/akZhy/vLCT3i0/Ad8uyBjxI2pTsHkKduTvzia+eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwA/Iesy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso83615845ad.3;
        Fri, 27 Dec 2024 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319739; x=1735924539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR+Kbj/tlw2NvrjzC38Sr9CFS1Wcs9+3deLrkf74fVA=;
        b=fwA/IesymZO0Wyll0tATb6jXD/eKGeB6OcOydoOQEPXzw8oP9LCx8PAZzPuNSIGYLA
         tjO/w7wIRuuQlAysC9dMPTvMYrSE3GA0I+seoU3S/XNsVckXDTyt5JBNBN2LnvbPZWL1
         MpqxmBPSQM7zbTCSHf+4UdNh3hdXtv4UOG3UOZ9Nug6JQRHOweJO1lb/ScYPln883dHM
         FlXNRUFcvsvRaNTCcQDrihSmb8zcAdNrvqrDnVxUdAcwUL8wz3HGRztQCh4HpiW4UflZ
         LaxpZSTrE3UmKFVHn1Io9Nsz1lGI/iIpos5J2aoUzEsXueMCpZqjdoWrRYi/zoYuIDYJ
         a1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319739; x=1735924539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR+Kbj/tlw2NvrjzC38Sr9CFS1Wcs9+3deLrkf74fVA=;
        b=gSzJ1RCgK3f/3sPhp3qVMyUZwIHrJxDhgOgoxFks+plwtAq9UNhrkr4aPaK5s5IiVK
         gAHqynaREuDsA0EplHEph8miVx/yfT6T74fP3nCadwEmHoe/EVGUb0p+pSGNxJ3quoZL
         k2rhjQxrH8iDBYYLk+WBG4jRUMeGdJuxP+f7EkgPF7OU7zhR2UN2ZnNNvpJFWieHWSYl
         hb1NierhKzYdnmsV75t5Ev7yu0bn+T6v7oAy5+ZA1mwYs/KClg/pevQkRoNUZ/pIxxYo
         TZuASCQaKvqTROD06C+RIj8GBgU8jjGhzSO2wYxQiA9f4G03oj1FmUsuCVFDCIfg6WE9
         W3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUSD6CNrduwaGb2W33DfpYd/LMg8/aoe0byl6V5Zs8AogBS0+BpXin9GIqMphFD3wW8FKTWj0iKEr6c30hS@vger.kernel.org, AJvYcCVbACSMM9c1Zx63vjOLy37OZ44uNav0+FtXk/inHSXyIOXJxrH66qp+7EGwdBNODDL3c9YEhHIb5iJ6imTs2tcR4OdFVg==@vger.kernel.org, AJvYcCWJ8jOScxipk4w5nwUoiwd15jmlqaJML0ofyhT/bDijhvKHveTPJO0JjESC9WzS5BBH0MUdoMpxfK4=@vger.kernel.org, AJvYcCWf8q1gIhJyjEFkRQuNNPu2vnIOuQDK1Sngtka90e4TkO8Ylj/l4NjpOb+9eh+4LE3ObKmeSJ6x0hzw@vger.kernel.org, AJvYcCWmQfoBbmnRvfLqPJvz4OlEXeZNkTYWArZGDXyZlN9YKaAEq4XL8WfYHLIYVdj6HMOP7MkdL7Xs+Z6l0B59@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfQoZn4ifxERYLkeBMb9yaiTdJclmYApYiVn5WV8WIhXNtByY
	JQk66rTRBvm0vFk6NzOm1ib9ZNh10gj8nRrizjtNLS0iHEFGPxyW
X-Gm-Gg: ASbGncso6JJSc4fzJuNaTwD/ET+zLQEexpKKhAsbuQ9ulBWjVLbLx1duFpoc6Mwmr/p
	iBhShDyuWWx44zKXaCEJgUoCTTjc48/ohMKTDWWBR1Vzz/Nqp4YPARSV167b2NY+K67CT4VOJI6
	wBT0mMURsuIKpdZrNEY6BQIbMPbXcIEw70OtYaepAIOssJGD9GzSkEgOUvzAfXcLINXdl/dY7uZ
	NzLeGJSsZzmHemfvDTTBc+40JzgeEnfVZuzRGj7liI=
X-Google-Smtp-Source: AGHT+IGNQ7bPyRYgTtJ7vKlz86qrwyxLneTcNoNKDIdXTnvRrgZYymSBotOkOGAkVm7kIqUb+zfIYA==
X-Received: by 2002:a17:903:234f:b0:216:4b6f:ddda with SMTP id d9443c01a7336-219e6f0e6c3mr364070815ad.35.1735319739082;
        Fri, 27 Dec 2024 09:15:39 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5227sm138566925ad.185.2024.12.27.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:15:38 -0800 (PST)
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
Subject: [PATCH 3/5] usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp) ucsi driver
Date: Sat, 28 Dec 2024 01:13:51 +0800
Message-ID: <20241227171353.404432-4-mitltlatltl@gmail.com>
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

The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI
interface in the onboard EC. Add the glue driver to interface the
platform's UCSI implementation.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/usb/typec/ucsi/Kconfig              |   9 +
 drivers/usb/typec/ucsi/Makefile             |   1 +
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 481 ++++++++++++++++++++
 3 files changed, 491 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 680e1b87b..0d0f07488 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -78,4 +78,13 @@ config UCSI_LENOVO_YOGA_C630
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_yoga_c630.
 
+config UCSI_HUAWEI_GAOKUN
+	tristate "UCSI Interface Driver for Huawei Matebook E Go (sc8280xp)"
+	depends on EC_HUAWEI_GAOKUN
+	help
+	  This driver enables UCSI support on the Huawei Matebook E Go tablet.
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
index 000000000..84ed0407d
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go (sc8280xp)
+ *
+ * reference: drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+ *            drivers/usb/typec/ucsi/ucsi_glink.c
+ *            drivers/soc/qcom/pmic_glink_altmode.c
+ *
+ * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/string.h>
+#include <linux/workqueue_types.h>
+
+#include <linux/usb/pd_vdo.h>
+#include <drm/bridge/aux-bridge.h>
+
+#include "ucsi.h"
+#include <linux/platform_data/huawei-gaokun-ec.h>
+
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
+#define CCX_TO_ORI(ccx) (++ccx % 3)
+
+#define GET_IDX(updt) (ffs(updt) - 1)
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
+	struct work_struct work;
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
+		dev_warn(uec->ucsi->dev, "set orientation out of range: con%d\n", idx);
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
+	unsigned long flags;
+	u8 dcc, ddi;
+	int offset = port->idx * 2; /* every port has 2 Bytes data */
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
+	switch (port->mux) {
+	case USBC_MUX_NONE:
+		port->svid = 0;
+		break;
+	case USBC_MUX_USB_2L:
+		port->svid = USB_SID_PD;
+		break;
+	case USBC_MUX_DP_4L:
+	case USBC_MUX_USB_DP:
+		port->svid = USB_SID_DISPLAYPORT;
+		if (port->ccx == USBC_CCX_REVERSE)
+			port->mode -= 6;
+		break;
+	default:
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
+		return -EIO;
+
+	uec->port_num = ureg.port_num;
+	idx = GET_IDX(ureg.port_updt);
+
+	if (idx >= 0 && idx < ureg.port_num)
+		gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
+
+	return idx;
+}
+
+static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
+{
+	struct gaokun_ucsi *uec = port->ucsi;
+	int idx = port->idx;
+
+	if (idx >= uec->ucsi->cap.num_connectors || !uec->ucsi->connector) {
+		dev_warn(uec->ucsi->dev, "altmode port out of range: %d\n", idx);
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
+	idx = gaokun_ucsi_refresh(uec);
+	if (idx < 0)
+		gaokun_ec_ucsi_pan_ack(uec->ec, idx);
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
+static int gaokun_ucsi_get_port_num(struct gaokun_ucsi *uec)
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
+	uec->ports = devm_kzalloc(dev, port_num * sizeof(*(uec->ports)),
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
+	uec = container_of(work, struct gaokun_ucsi, work);
+	ucsi = uec->ucsi;
+
+	ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
+
+	ssleep(3); /* EC can't handle UCSI properly in the early stage */
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
+static int gaokun_ucsi_register(struct gaokun_ucsi *uec)
+{
+	schedule_work(&uec->work);
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
+	INIT_WORK(&uec->work, gaokun_ucsi_register_worker);
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


