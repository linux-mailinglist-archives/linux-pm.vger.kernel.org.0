Return-Path: <linux-pm+bounces-41852-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMjMOQIvf2kglQIAu9opvQ
	(envelope-from <linux-pm+bounces-41852-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:46:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B648C588A
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC6E301FAA3
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1032B992;
	Sun,  1 Feb 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhHosggr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6513254BD
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942661; cv=none; b=ubt6f3J0NHbRejaar4hPCD9IBsfW2ahyU81lUAr7lSH1VYL9cjyE1s8WGOna+9TDIfkV0FEv80yD5hIa5/x8v/uvGDSX+GWgzxk+HxInr79erkZEva1tIl6CVUWPTICnmCv5NwniCJPsv7feInRrhVZBJczXlQ1Tv5ujEZ5pQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942661; c=relaxed/simple;
	bh=UXzRbv2AJpOFvxhJbL04ahIUHG+2B8PBchoNwQoMDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuQSZF/4GDLoGjPYnBtN7fBzGhr/DUQsLpI0g4DP/RAu1t4y9O6nyhJ9CZF1qIjMOuh+PnuqNG9zPKYGexThaIm5cHfAMdpQaxvCLxNHwWbDwZ/kS+1PTjdMabhouq/QBCOsYal9Dj8Ou5AGToj3cO9iEY5AJzx5M3jse1JxRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhHosggr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435a11957f6so2848835f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942657; x=1770547457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvGgSKvbVH8wh4V8HM8xwYvX9eYP7WNQfdBJNYHNlf0=;
        b=LhHosggrXTQaZfviUXFr8xJMLSJb4D3YS39IBK0WfTwlht1lBGICl0mE/GFhIrpIPK
         npxCf7gM1JEkA+HXj7VaBcXugAhBaTi0FAv71Jaz9agYbwWzlrZOwxPdqO6DzmtP7hnt
         7wQBxsAPfB9EMh4mHskbkGsm3N/wRtP/d0uIglRzSzzgjSqWY18Xm3ZNr7Vu6eoAEpBZ
         2+VKi66121khJ6Y9rjdcxPsP/tHyH5NSuXdi6XFGqWgo1FqnOMm4ZsJC40J/WT0h86p7
         CDZfGS1MGCTaS1w5pQJqbnHPgwJuHdIIvweuTRun3P3N7Sss0XhfN4Nb3s/WFl4t9Gou
         4K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942657; x=1770547457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvGgSKvbVH8wh4V8HM8xwYvX9eYP7WNQfdBJNYHNlf0=;
        b=Q0vyByPBNWW6IvsH4knyo6PSM0RhzDKwfEFoMZG+YogFLLiMwpNk8U+GO2ocr/P8Gm
         ewqdge2D94DJyFDJ7d/TFsyYasyhZ0MmZs7IIPvp91EL9YWNOhEbD/0zMLNcM9vBYkzW
         4RY1yIxAsMc9oE85kOKx0mQxc+ATC88Ymgnp//dJfOrXnPT8aM04oRTFryuFbntj6EdI
         SdwiGQigJxkZfnj7SCeFt2UCcN/GjZOrGeHNmXsid/dhunYgdPKoJ6K4NmFXlYgg9RIL
         1IUTn2sQ/gRs+yad3K+jBJIFQxmgXOtD2U6MTKMD5UhvdqrS3vIJSnRi2rGSGCTAbFBw
         WFSg==
X-Forwarded-Encrypted: i=1; AJvYcCXtxIJIN9STBHhq+iXDk+Q7nKZikXccMDEjubwYXHm+mDXStNaLAm0+VHYyVtQKnsuqS/KdVAYFvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjrMPm9FgwC5yyu4QqXqxxV23wt099VDYLrzPspQNZh0enH6W
	/IFoxVz6ON7eRcCeT5veyw1OIF8TmDDWWshW/y1gZjXNOTxhNt9+psxU
X-Gm-Gg: AZuq6aJ/T/drACXfC5tiWiyyd+P3pd1st2MfXOpq/6s8+U9+azXJiG5pw4cv9yvnIN2
	5Lexd8WC8XCUv7ADVTCAFFTxvrVFI31ViqH3sVIY/NU8xuZCiUefUm6i9gpn8k6sBbuWRwlbvCm
	UIAgvZVZcIdEhsphIfgfTJ/kTeg4626bsn2nN1tiOd4aeEuJRSNrxQ30gATxrKW5EYzzqRJuE89
	PDFORum70ZKZrarBkJTmUXCnJtte32rEAbs+2QfdadcDgzN+0qasH4F4XMC2WAz2WxXHIMhm836
	LJwpDTBFc8799vxVdrbrDvnX2EIBdYcW9KZq6Cx89TSoprwfzy4wa9a3KOWjLPgKajv/XrbbjIH
	RHxKGIsmjjXJgPQkeE41eylRonSmYTN/bRupv/scYGVrapLhAn2vsvrZRrmVEtAO503oAzHlc5h
	WY
X-Received: by 2002:a05:600c:4f8f:b0:480:4c45:aff5 with SMTP id 5b1f17b1804b1-482db4995b1mr94284625e9.34.1769942656573;
        Sun, 01 Feb 2026 02:44:16 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 5/9] input: serio: Add driver for Asus Transformer dock keyboard and touchpad
Date: Sun,  1 Feb 2026 12:43:39 +0200
Message-ID: <20260201104343.79231-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201104343.79231-1-clamor95@gmail.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41852-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,agorria.com:email]
X-Rspamd-Queue-Id: 6B648C588A
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add input driver for Asus Transformer dock keyboard and touchpad.

Some keys in Asus Dock report keycodes that don't make sense according to
their position, this patch modifies the incoming data that is sent to
serio to send proper scancodes.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/serio/Kconfig       |  15 +++
 drivers/input/serio/Makefile      |   1 +
 drivers/input/serio/asus-ec-kbc.c | 162 ++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/input/serio/asus-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c7ef347a4dff..c4e17dcfc98a 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -97,6 +97,21 @@ config SERIO_RPCKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpckbd.
 
+config SERIO_ASUSEC
+	tristate "Asus Transformer's Dock keyboard and touchpad controller"
+	depends on MFD_ASUSEC
+	help
+	  Say Y here if you want to use the keyboard and/or touchpad on
+	  Asus Transformed's Mobile Dock.
+
+	  For keyboard support you also need atkbd driver.
+
+	  For touchpad support you also need psmouse driver with Elantech
+	  touchpad option enabled.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called asusec-kbc.
+
 config SERIO_AMBAKMI
 	tristate "AMBA KMI keyboard controller"
 	depends on ARM_AMBA
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 6d97bad7b844..444e3ea70e37 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SERIO_CT82C710)	+= ct82c710.o
 obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
+obj-$(CONFIG_SERIO_ASUSEC)	+= asus-ec-kbc.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
diff --git a/drivers/input/serio/asus-ec-kbc.c b/drivers/input/serio/asus-ec-kbc.c
new file mode 100644
index 000000000000..796ce0de38c8
--- /dev/null
+++ b/drivers/input/serio/asus-ec-kbc.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC - keyboard and touchpad
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i8042.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serio.h>
+
+struct asus_ec_kbc_data {
+	struct notifier_block nb;
+	struct asusec_info *ec;
+	struct serio *sdev[2];
+};
+
+static int asus_ec_kbc_notify(struct notifier_block *nb,
+			      unsigned long action, void *data_)
+{
+	struct asus_ec_kbc_data *priv = container_of(nb, struct asus_ec_kbc_data, nb);
+	unsigned int port_idx, n;
+	u8 *data = data_;
+
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
+		return NOTIFY_DONE;
+	else if (action & ASUSEC_AUX_MASK)
+		port_idx = 1;
+	else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
+		port_idx = 0;
+	else
+		return NOTIFY_DONE;
+
+	n = data[0] - 1;
+	data += 2;
+
+	/*
+	 * We need to replace these incoming data for keys:
+	 * RIGHT_META Press   0xE0 0x27      -> LEFT_ALT   Press   0x11
+	 * RIGHT_META Release 0xE0 0xF0 0x27 -> LEFT_ALT   Release 0xF0 0x11
+	 * COMPOSE    Press   0xE0 0x2F      -> RIGHT_META Press   0xE0 0x27
+	 * COMPOSE    Release 0xE0 0xF0 0x2F -> RIGHT_META Release 0xE0 0xF0 0x27
+	 */
+
+	if (port_idx == 0 && n >= 2 && data[0] == 0xE0) {
+		if (n == 3 && data[1] == 0xF0) {
+			switch (data[2]) {
+			case 0x27:
+				data[0] = 0xF0;
+				data[1] = 0x11;
+				n = 2;
+				break;
+			case 0x2F:
+				data[2] = 0x27;
+				break;
+			}
+		} else if (n == 2) {
+			switch (data[1]) {
+			case 0x27:
+				data[0] = 0x11;
+				n = 1;
+				break;
+			case 0x2F:
+				data[1] = 0x27;
+				break;
+			}
+		}
+	}
+
+	while (n--)
+		serio_interrupt(priv->sdev[port_idx], *data++, 0);
+
+	return NOTIFY_OK;
+}
+
+static int asus_ec_serio_write(struct serio *port, unsigned char data)
+{
+	const struct asusec_info *ec = port->port_data;
+
+	return asus_ec_i2c_command(ec, (data << 8) | port->id.extra);
+}
+
+static void asus_ec_serio_remove(void *data)
+{
+	serio_unregister_port(data);
+}
+
+static int asus_ec_register_serio(struct platform_device *pdev, int idx,
+				  const char *name, int cmd)
+{
+	struct asus_ec_kbc_data *priv = platform_get_drvdata(pdev);
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
+	struct serio *port = kzalloc(sizeof(*port), GFP_KERNEL);
+
+	if (!port)
+		dev_err_probe(&pdev->dev, -ENOMEM,
+			      "No memory for serio%d\n", idx);
+
+	priv->sdev[idx] = port;
+	port->dev.parent = &pdev->dev;
+	port->id.type = SERIO_8042;
+	port->id.extra = cmd & 0xFF;
+	port->write = asus_ec_serio_write;
+	port->port_data = (void *)priv->ec;
+	snprintf(port->name, sizeof(port->name), "%s %s",
+		 priv->ec->model, name);
+	snprintf(port->phys, sizeof(port->phys), "i2c-%u-%04x/serio%d",
+		 i2c_adapter_id(parent->adapter), parent->addr, idx);
+
+	serio_register_port(port);
+
+	return devm_add_action_or_reset(&pdev->dev, asus_ec_serio_remove, port);
+}
+
+static int asus_ec_kbc_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct asus_ec_kbc_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	ret = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (ret < 0)
+		return ret;
+
+	ret = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
+	if (ret < 0)
+		return ret;
+
+	priv->nb.notifier_call = asus_ec_kbc_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static const struct of_device_id asus_ec_kbc_match[] = {
+	{ .compatible = "asus,ec-kbc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_kbc_match);
+
+static struct platform_driver asus_ec_kbc_driver = {
+	.driver = {
+		.name = "asus-ec-kbc",
+		.of_match_table = asus_ec_kbc_match,
+	},
+	.probe = asus_ec_kbc_probe,
+};
+module_platform_driver(asus_ec_kbc_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's Dock keyboard and touchpad controller driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


