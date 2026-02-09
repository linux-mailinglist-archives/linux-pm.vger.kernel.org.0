Return-Path: <linux-pm+bounces-42342-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OdaC7O6iWlwBQUAu9opvQ
	(envelope-from <linux-pm+bounces-42342-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:45:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E0310E434
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AFC4301A147
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51336A015;
	Mon,  9 Feb 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5crbl4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20878369236
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633875; cv=none; b=jbwbJ4+puUOi16q6WAzRDC/UhgZuY9PfyDeORvUd92XTSgBDUz/SE53tFRKUP5MJ7HPeUCjvi+f1EZNRLl4P3jwwT1cWxiNxoNPqqi2511nIHpX573PuPtPrGAfVOw09l13MWnHxDxjrZ//q8KGwkJJP3AOZmGrFuUkUkBsMEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633875; c=relaxed/simple;
	bh=L5L8z3dEdEv23jGtH4a9T59EHgzniV+IyLmlJZ/Ob6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HETHtdQ0Ik3X8A2Kwp6kjbLKjhBxOau2S+EJTwvb24DHCsKyaI0xGClZzJ4UPdR895GU8P7gFtDKz81s1kS+QWh1K659uVIHE5VK+qHsOdgfa1ZkpRevhY90C6UnDojrGoSQtSslPMCY+0V/ZAxP6CoGQPeQB2Zn2FsoCS8M2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5crbl4D; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e4993e00aso2064606e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633873; x=1771238673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mbuhFCPPv7pIkklBXErJ3O0VBejat88okAITG/2NqA=;
        b=d5crbl4DGV3PofoOXt/1Rf1PbAQudr9O02gge2MhQ+l6d++jwE3pGokY19nAVVGSmG
         8Z06QNiqOiLSe8Xd0Twob/VnRe1VBbDn50/XCpr6uykLxrNnOYAlfXug33OVJV8aA5hO
         a+uLwiLZf+5rJ3UA7wHQAzcpJeNJC6ANjdb5H3Nb6MvihV2p0Ey3fHXoj6OY5BrNhrfR
         EpXlprkKF9b2E9Xjo/ssAhjmj41XLfWA6hhaAuT15LaM85R6dnkcP0iOvYBAEdxWpt0Q
         r7bC+b8w4BymEwQAcjo5sQnAMTZoUct+5twIcEruyIJr1CTyn264psizcJC2GjnBjcGJ
         lUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633873; x=1771238673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mbuhFCPPv7pIkklBXErJ3O0VBejat88okAITG/2NqA=;
        b=Cqgz4LT1ZfzJC6YVgJ4OyH5NeBoRDtg8Bjz2FlXr2Qc0ze94LOAxOm2t7cTv9V0Tli
         azxNiJl9ZEUyAqO4vMsOibRIvBWUR43uGGi37lNcVYZaZ5+zCy5mTp9IkqeCYIzhuAt1
         uedzyDHTzMP1c/WugeljTX8p1hzivOAMtbztEDFUJjxP9FeIYiUQiAsAs4rk99Vm7Cb3
         7sxFHrDby293JnKGpKU207wk3DYaE81sUl+XiTf2kw0e4r8hycab2XJgk+oUsOK4F8Va
         OAVTK7w4DldDmI6iWQnQO5/GXImCrix1kxGAcTDUIv84frNQK8uSz/9eghOVrmy/4y00
         +oXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXik34E/309klMO4IgY1cm4l7xZGbJ5BMNffaGRsqs8+jq/1uJ7FpG6qHFp6+zjg54I2TRPFCYeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMsyamWbC+tdp66chEhJz/+m7nkswGZhAmfiIYo24y0m8+lEV
	1/w18wzYX14ip+1Ve5ONfuBwSvF4vcExQJH3NxwCwWmwl3ZNAi/GdGGy
X-Gm-Gg: AZuq6aK+lykO4eaHbdzfW+zZfGo5BCSHOd7S79fb84Czh3jQ+xrUbX8mUily5tPsdqq
	ZT/6aNtI5DHTikOC3I91waU30Kdxx7BvVIO508HtyhnxjgVKxIKg0vcUuLCHbIvjUNtWGbxDBtp
	SdPyTAJGJeAs6vtTXE+5UTvo+7jyrFGOWTcEIl8BtWj864Cvi/B9UtjAV3fMtQNsGkYidOQ6dVQ
	KKyAMTa/L4sD/75gn92/oEidhcqPtOdRou7q3X3w0lFke6gplG+rv3y2/dNVOafDDfq7crOqpIT
	/UpLCQVmUnY0fy/a4i5789YcGWCGsP7qokgeF22+7kLb2XZbRJIu+CAYCzWKd3kxursRjn+DvEu
	js16OOMmxe3Pi6caIGDpm7BEMLAjqBode+fc0r+yfpMhev42FryD7KwQ/1LFUh5ezyNBaiWsmQp
	GT
X-Received: by 2002:a05:6512:3f07:b0:59d:f28a:be11 with SMTP id 2adb3069b0e04-59e45044658mr3280391e87.3.1770633872876;
        Mon, 09 Feb 2026 02:44:32 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:32 -0800 (PST)
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
Subject: [PATCH v2 5/9] input: serio: Add driver for Asus Transformer dock keyboard and touchpad
Date: Mon,  9 Feb 2026 12:44:03 +0200
Message-ID: <20260209104407.116426-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-42342-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[agorria.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4E0310E434
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
 drivers/input/serio/asus-ec-kbc.c | 160 ++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/input/serio/asus-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c7ef347a4dff..46c4286cd5f6 100644
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
+	  be called asus-ec-kbc.
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
index 000000000000..c03f4721fc33
--- /dev/null
+++ b/drivers/input/serio/asus-ec-kbc.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC - keyboard and touchpad
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
+		return -ENOMEM;
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


