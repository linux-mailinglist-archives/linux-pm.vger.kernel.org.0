Return-Path: <linux-pm+bounces-41851-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QERmKcAuf2kZlQIAu9opvQ
	(envelope-from <linux-pm+bounces-41851-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:45:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA0C5810
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE6A3009F27
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED432AABD;
	Sun,  1 Feb 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGNeTbdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EB32470E
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942660; cv=none; b=RldiBOi/ukmmMXyYVGmYiYpi2UofnKdevj9PbE2XV/LWHZwJAnpZ5ctqzzm143tdYmCf1+QvpPO5wNz3CYT3tFADwRVng9UTkkiLAuNH7tp4YNyiv69EHwqeRdcmShGIC8NkrvMcLDkFVv3+RPxQpT6psQk5rGwIiGLW7xChfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942660; c=relaxed/simple;
	bh=2AfNJD4L0rq1KzdDBDlAr7eYuOto2g4n0W7mmtI2Pa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdKbKPoQiJV/gPzBkRER0p0t4VyNzIrBrw/YKMshcaNPhIV751oOFeknVMlQfdBKQW1ZdSrOzbBxXyFYGkJVGFPWi3+b1wLtuWht6cRySGNcg/J8vOnEwDIiZQ/urg0qz+sEztIcADymGfs4kOLcqFfhaa7X2GyLB7DXQ3AztHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGNeTbdA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso35774405e9.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942656; x=1770547456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUWqWBNmt95ycDvovtO/3m39YHg1WQW5qxhoJyj0xwg=;
        b=GGNeTbdAP20L5r+BWml6wP5b7eEphVUtdBxb/vbTOKRPyCbo5QXShvynGowiVYBDP6
         eeUN2+0Ol/RiWkQ48P0lO24wiciV1CBIxOuZ3GE4TThjrOnueRdXm9jPmppfNEa3LpGA
         aMkgPq+QsqU6PBQ2nsD0cFdKb8LzG2fxHB1qGwpCKnbiybI54cH/j0hasczycTxNN8vy
         +4RedOSfiG5DW4FvzX9eu30R4CutHGOWrvKEaXcld5CH4yU0dK8cH3qQsp6uDxDeoEN+
         yIH8Sg/PokSwKWM56P12G6wYGBiK9GrkSjhgy72RLgq5gjUeSU3+kJ3V7dQO0yPyz0NN
         Kr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942656; x=1770547456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUWqWBNmt95ycDvovtO/3m39YHg1WQW5qxhoJyj0xwg=;
        b=e4Wl5NbbL5M/0r2fPiB2EW0pGJWMbdx19y9IYoPWcDEVfyqldPYLAmp3AkwbJRcS+w
         6W+mzFibFZajxrBjrLOMTqLsRQJPOFctxFSX1kVk0SC/gVH8UYEioviacaYAgGkw3gXQ
         lDmNdVHe42qcpLc/JXffjQp9bLkPWa9wUT+FIm2TDnRfDBQ7BTpPddJ5VR46+wDflDHT
         jj34lWiR8nD1fmNgUKx1YZiQM0+po7k56N2fURvPsG0Ssyd5SxGgwEgw3F36AEirtD+Y
         Wgkdgbv8v7/Lq7R0iJOrgW967vhu/L6dNyQ8UwHbz16JOwwtwWQTg7CE08DhrNyz66Jr
         1BdA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXvPEYFr/Q4XV6QP1WG5bnT9ClSDqG/UhFCLTPG94g+fM/Q5FJAafCKE8ab58kVo3UboSatWmbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkb+27YCBCixn4TAdqROPwd3PfMrIIU/BBfskgCXU/R5xI86v
	TjlUdBnOnJ/lrg7uddRIsPLSbl7bH2yWaCu6u3TvnnIOEvKGnmJzaPNb
X-Gm-Gg: AZuq6aKvz62xU+7i1stMBoO26p8UzJqpUMG5/y4Wlgq08FYkYClMEtN5CgF0boDmXmb
	oK3/KgNSoxKs4IpSi3iUt4p8EUZaf16ASXQnLmWjH8PBf9sNx5CW6egcruuYTTQaFBQE8lfiP+X
	ev7nDBdkPjZ9/LWnWOeAkTMX6fQELWo8NJD6qhoM+4z05szmmPBVIkqH6bxf7opTrB4Ui1l1kVe
	S8P0+qBrKNR1KFlFYwGoD7vye72WO02emxGOr3ZBspXpPbFTjOuWydv4E71LbnC35JFEUpGSsUA
	nKgWPDK4RW9SHlavZgxKslchJlEkpNgI/a5y+RS2ZVICmLN14aPe8MdhPPB/cO/3ksHirAjUISK
	05DmgPn72ZGh1G2ceI/832L6umJjvj4YeEW2HZ7t9stXUkI6VjW6pOTDrYc83CiLwof2dSWDNN5
	fA
X-Received: by 2002:a05:600c:64c6:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-482db4593a1mr108613865e9.3.1769942655480;
        Sun, 01 Feb 2026 02:44:15 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:15 -0800 (PST)
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
Subject: [PATCH v1 4/9] mfd: Add driver for Asus Transformer embedded controller
Date: Sun,  1 Feb 2026 12:43:38 +0200
Message-ID: <20260201104343.79231-5-clamor95@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41851-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1CA0C5810
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
and TF600T, P1801-T and TF701T pad. This is a glue driver handling
detection and common operations for EC's functions.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mfd/Kconfig         |  14 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/asus-ec.c       | 460 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/asus-ec.h | 101 +++++++-
 4 files changed, 573 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mfd/asus-ec.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7192c9d1d268..c7b32a4e65fa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -137,6 +137,20 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ASUSEC
+	tristate "ASUS embedded controller"
+	depends on I2C && OF
+	select SYSFS
+	select ASUS_DOCKRAM
+	help
+	  Support ECs as found in ASUS Transformer's Pad and Mobile Dock.
+
+	  This provides shared glue for functional part drivers:
+	    leds-asusec, serio-asusec, asusec-ext-keys, asusec-battery.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus-ec.
+
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e75e8045c28a..b676922601ba 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
+obj-$(CONFIG_MFD_ASUSEC)	+= asus-ec.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
diff --git a/drivers/mfd/asus-ec.c b/drivers/mfd/asus-ec.c
new file mode 100644
index 000000000000..09a914a963fe
--- /dev/null
+++ b/drivers/mfd/asus-ec.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC driver
+ */
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define ASUSEC_RSP_BUFFER_SIZE		8
+
+struct asus_ec_chip_data {
+	const char *name;
+	const struct mfd_cell *mfd_devices;
+	unsigned int num_devices;
+};
+
+struct asus_ec_data {
+	struct asusec_info info;
+	struct mutex ecreq_lock; /* prevent simultaneous access */
+	struct gpio_desc *ecreq;
+	struct i2c_client *self;
+	const struct asus_ec_chip_data *data;
+	u8 ec_data[DOCKRAM_ENTRY_BUFSIZE];
+	bool logging_disabled;
+};
+
+#define to_ec_data(ec) \
+	container_of(ec, struct asus_ec_data, info)
+
+static void asus_ec_remove_notifier(struct device *dev, void *res)
+{
+	struct asusec_info *ec = dev_get_drvdata(dev->parent);
+	struct notifier_block **nb = res;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, *nb);
+}
+
+int devm_asus_ec_register_notifier(struct platform_device *pdev,
+				   struct notifier_block *nb)
+{
+	struct asusec_info *ec = dev_get_drvdata(pdev->dev.parent);
+	struct notifier_block **res;
+	int ret;
+
+	res = devres_alloc(asus_ec_remove_notifier, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	*res = nb;
+	ret = blocking_notifier_chain_register(&ec->notify_list, nb);
+	if (ret) {
+		devres_free(res);
+		return ret;
+	}
+
+	devres_add(&pdev->dev, res);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_asus_ec_register_notifier);
+
+static int asus_ec_signal_request(const struct asusec_info *ec)
+{
+	struct asus_ec_data *priv = to_ec_data(ec);
+
+	guard(mutex)(&priv->ecreq_lock);
+
+	dev_dbg(&priv->self->dev, "EC request\n");
+
+	gpiod_set_value_cansleep(priv->ecreq, 1);
+	msleep(50);
+
+	gpiod_set_value_cansleep(priv->ecreq, 0);
+	msleep(200);
+
+	return 0;
+}
+
+static int asus_ec_write(struct asus_ec_data *priv, u16 data)
+{
+	int ret = i2c_smbus_write_word_data(priv->self, 0x64, data);
+
+	dev_dbg(&priv->self->dev, "EC write: %04x, ret = %d\n", data, ret);
+	return ret;
+}
+
+static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
+{
+	int ret = i2c_smbus_read_i2c_block_data(priv->self, 0x6A,
+						sizeof(priv->ec_data),
+						priv->ec_data);
+
+	dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
+		sizeof(priv->ec_data), priv->ec_data,
+		ret, in_irq ? "; in irq" : "");
+
+	return ret;
+}
+
+int asus_ec_i2c_command(const struct asusec_info *ec, u16 data)
+{
+	return asus_ec_write(to_ec_data(ec), data);
+}
+EXPORT_SYMBOL_GPL(asus_ec_i2c_command);
+
+static void asus_ec_clear_buffer(struct asus_ec_data *priv)
+{
+	int retry = ASUSEC_RSP_BUFFER_SIZE;
+
+	while (retry--) {
+		if (asus_ec_read(priv, false) < 0)
+			continue;
+
+		if (priv->ec_data[1] & ASUSEC_OBF_MASK)
+			continue;
+
+		break;
+	}
+}
+
+static int asus_ec_log_info(struct asus_ec_data *priv, unsigned int reg,
+			    const char *name, char **out)
+{
+	char buf[DOCKRAM_ENTRY_BUFSIZE];
+	int ret;
+
+	ret = asus_dockram_read(priv->info.dockram, reg, buf);
+	if (ret < 0)
+		return ret;
+
+	if (!priv->logging_disabled)
+		dev_info(&priv->self->dev, "%-14s: %.*s\n", name, buf[0], buf + 1);
+
+	if (out)
+		*out = kstrndup(buf + 1, buf[0], GFP_KERNEL);
+
+	return 0;
+}
+
+static int asus_ec_reset(struct asus_ec_data *priv)
+{
+	int retry, ret;
+
+	for (retry = 0; retry < 3; retry++) {
+		ret = asus_ec_write(priv, 0);
+		if (!ret)
+			return 0;
+
+		msleep(300);
+	}
+
+	return ret;
+}
+
+static int asus_ec_magic_debug(struct asus_ec_data *priv)
+{
+	u64 flag;
+	int ret;
+
+	ret = asus_ec_get_ctl(&priv->info, &flag);
+	if (ret < 0)
+		return ret;
+
+	flag &= ASUSEC_CTL_SUSB_MODE;
+	dev_info(&priv->self->dev, "EC FW behaviour: %s\n",
+		 flag ? "susb on when receive ec_req" : "susb on when system wakeup");
+
+	return 0;
+}
+
+static int asus_ec_set_factory_mode(struct asus_ec_data *priv, bool on)
+{
+	dev_info(&priv->self->dev, "Entering %s mode.\n", on ? "factory" : "normal");
+	return asus_ec_update_ctl(&priv->info, ASUSEC_CTL_FACTORY_MODE,
+				 on ? ASUSEC_CTL_FACTORY_MODE : 0);
+}
+
+static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int code);
+
+static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
+{
+	struct asus_ec_data *priv = dev_id;
+	unsigned long notify_action;
+	int ret;
+
+	ret = asus_ec_read(priv, true);
+	if (ret <= 0 || !(priv->ec_data[1] & ASUSEC_OBF_MASK))
+		return IRQ_NONE;
+
+	notify_action = priv->ec_data[1];
+	if (notify_action & ASUSEC_SMI_MASK) {
+		unsigned int code = priv->ec_data[2];
+
+		asus_ec_handle_smi(priv, code);
+
+		notify_action |= code << 8;
+		dev_dbg(&priv->self->dev, "SMI code: 0x%02x\n", code);
+	}
+
+	blocking_notifier_call_chain(&priv->info.notify_list,
+				     notify_action, priv->ec_data);
+
+	return IRQ_HANDLED;
+}
+
+static int asus_ec_detect(struct asus_ec_data *priv)
+{
+	char *model = NULL;
+	int ret;
+
+	ret = asus_ec_reset(priv);
+	if (ret)
+		goto err_exit;
+
+	asus_ec_clear_buffer(priv);
+
+	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_MODEL, "model", &model);
+	if (ret)
+		goto err_exit;
+
+	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_FW, "FW version", NULL);
+	if (ret)
+		goto err_exit;
+
+	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_CFGFMT, "Config format", NULL);
+	if (ret)
+		goto err_exit;
+
+	ret = asus_ec_log_info(priv, ASUSEC_DOCKRAM_INFO_HW, "HW version", NULL);
+	if (ret)
+		goto err_exit;
+
+	priv->logging_disabled = true;
+
+	ret = asus_ec_magic_debug(priv);
+	if (ret)
+		goto err_exit;
+
+	priv->info.model = model;
+	priv->info.name = priv->data->name;
+
+	if (device_property_read_bool(&priv->self->dev, "asus,clear-factory-mode"))
+		asus_ec_set_factory_mode(priv, false);
+
+err_exit:
+	if (ret)
+		dev_err(&priv->self->dev, "failed to access EC: %d\n", ret);
+
+	return ret;
+}
+
+static void asus_ec_handle_smi(struct asus_ec_data *priv, unsigned int code)
+{
+	dev_dbg(&priv->self->dev, "SMI interrupt: 0x%02x\n", code);
+
+	switch (code) {
+	case ASUSEC_SMI_HANDSHAKE:
+	case ASUSEC_SMI_RESET:
+		asus_ec_detect(priv);
+		break;
+	}
+}
+
+static ssize_t ec_request_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct asusec_info *ec = dev_get_drvdata(dev);
+
+	asus_ec_signal_request(ec);
+
+	return count;
+}
+
+static ssize_t ec_irq_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct asusec_info *ec = dev_get_drvdata(dev);
+	struct asus_ec_data *priv = to_ec_data(ec);
+
+	irq_wake_thread(priv->self->irq, priv);
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(ec_request);
+static DEVICE_ATTR_WO(ec_irq);
+
+static struct attribute *asus_ec_attributes[] = {
+	&dev_attr_ec_request.attr,
+	&dev_attr_ec_irq.attr,
+	NULL
+};
+
+static const struct attribute_group asus_ec_attr_group = {
+	.attrs = asus_ec_attributes,
+};
+
+static void asus_ec_sysfs_release(void *data)
+{
+	struct i2c_client *client = data;
+
+	sysfs_remove_link(&client->dev.kobj, "dockram");
+}
+
+static int asus_ec_probe(struct i2c_client *client)
+{
+	struct asus_ec_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = device_get_match_data(&client->dev);
+	if (!priv->data)
+		return -ENODEV;
+
+	i2c_set_clientdata(client, priv);
+	priv->self = client;
+
+	priv->info.dockram = devm_asus_dockram_get(&client->dev);
+	if (IS_ERR(priv->info.dockram))
+		return dev_err_probe(&client->dev, PTR_ERR(priv->info.dockram),
+				     "failed to get dockram\n");
+
+	priv->ecreq = devm_gpiod_get(&client->dev, "request", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->ecreq))
+		return dev_err_probe(&client->dev, PTR_ERR(priv->ecreq),
+				     "failed to get request GPIO\n");
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&priv->info.notify_list);
+	mutex_init(&priv->ecreq_lock);
+
+	ret = devm_device_add_group(&client->dev, &asus_ec_attr_group);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to create sysfs attributes\n");
+
+	ret = sysfs_create_link(&client->dev.kobj,
+				&priv->info.dockram->dev.kobj,
+				"dockram");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to create sysfs link 'dockram'\n");
+
+	ret = devm_add_action_or_reset(&client->dev, asus_ec_sysfs_release,
+				       client);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to register sysfs release\n");
+
+	asus_ec_signal_request(&priv->info);
+
+	ret = asus_ec_detect(priv);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to detect EC version\n");
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, &asus_ec_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED,
+					client->name, priv);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to register IRQ\n");
+
+	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
+	client->dev.coherent_dma_mask = 0;
+	client->dev.dma_mask = &client->dev.coherent_dma_mask;
+
+	return devm_mfd_add_devices(&client->dev, 0, priv->data->mfd_devices,
+				    priv->data->num_devices, NULL, 0, NULL);
+}
+
+static const struct mfd_cell asus_ec_pad_mfd_devices[] = {
+	{
+		.name = "asus-ec-battery",
+		.id = 0,
+		.of_compatible = "asus,ec-battery",
+	}, {
+		.name = "asus-ec-charger",
+		.id = 0,
+		.of_compatible = "asus,ec-charger",
+	}, {
+		.name = "asus-ec-led",
+		.id = 0,
+		.of_compatible = "asus,ec-led",
+	},
+};
+
+static const struct mfd_cell asus_ec_dock_mfd_devices[] = {
+	{
+		.name = "asus-ec-battery",
+		.id = 1,
+		.of_compatible = "asus,ec-battery",
+	}, {
+		.name = "asus-ec-charger",
+		.id = 1,
+		.of_compatible = "asus,ec-charger",
+	}, {
+		.name = "asus-ec-led",
+		.id = 1,
+		.of_compatible = "asus,ec-led",
+	}, {
+		.name = "asus-ec-keys",
+		.of_compatible = "asus,ec-keys",
+	}, {
+		.name = "asus-ec-kbc",
+		.of_compatible = "asus,ec-kbc",
+	},
+};
+
+static const struct asus_ec_chip_data asus_ec_pad_data = {
+	.name = "pad",
+	.mfd_devices = asus_ec_pad_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_pad_mfd_devices),
+};
+
+static const struct asus_ec_chip_data asus_ec_dock_data = {
+	.name = "dock",
+	.mfd_devices = asus_ec_dock_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_dock_mfd_devices),
+};
+
+static const struct of_device_id asus_ec_match[] = {
+	{ .compatible = "asus,ec-pad", .data = &asus_ec_pad_data },
+	{ .compatible = "asus,ec-dock", .data = &asus_ec_dock_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_match);
+
+static struct i2c_driver asus_ec_driver = {
+	.driver	= {
+		.name = "asus-ec",
+		.of_match_table = asus_ec_match,
+	},
+	.probe = asus_ec_probe,
+};
+module_i2c_driver(asus_ec_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's EC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/asus-ec.h b/include/linux/mfd/asus-ec.h
index bc4efa37f5ba..11b16295afcd 100644
--- a/include/linux/mfd/asus-ec.h
+++ b/include/linux/mfd/asus-ec.h
@@ -2,8 +2,76 @@
 #ifndef __MISC_ASUS_EC_H
 #define __MISC_ASUS_EC_H
 
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
 struct i2c_client;
 
+struct asusec_info {
+	const char *model;
+	const char *name;
+	struct i2c_client *dockram;
+	struct workqueue_struct *wq;
+	struct blocking_notifier_head notify_list;
+};
+
+#define DOCKRAM_ENTRIES			0x100
+#define DOCKRAM_ENTRY_SIZE		32
+#define DOCKRAM_ENTRY_BUFSIZE		(DOCKRAM_ENTRY_SIZE + 1)
+
+/* interrupt sources */
+#define ASUSEC_OBF_MASK			BIT(0)
+#define ASUSEC_KEY_MASK			BIT(2)
+#define ASUSEC_KBC_MASK			BIT(3)
+#define ASUSEC_AUX_MASK			BIT(5)
+#define ASUSEC_SCI_MASK			BIT(6)
+#define ASUSEC_SMI_MASK			BIT(7)
+
+/* SMI notification codes */
+#define ASUSEC_SMI_POWER_NOTIFY		0x31	/* [un]plugging USB cable */
+#define ASUSEC_SMI_HANDSHAKE		0x50	/* response to ec_req edge */
+#define ASUSEC_SMI_WAKE			0x53
+#define ASUSEC_SMI_RESET		0x5f
+#define ASUSEC_SMI_ADAPTER_EVENT	0x60	/* [un]plugging charger to dock */
+#define ASUSEC_SMI_BACKLIGHT_ON		0x63
+#define ASUSEC_SMI_AUDIO_DOCK_IN	0x70
+
+#define ASUSEC_SMI_ACTION(code)		(ASUSEC_SMI_MASK | ASUSEC_OBF_MASK | \
+					(ASUSEC_SMI_##code << 8))
+
+/* control register [0x0A] layout */
+#define ASUSEC_CTL_SIZE			8
+
+/*
+ * EC reports power from 40-pin connector in the LSB of the control
+ * register.  The following values have been observed (xor 0x02):
+ *
+ * PAD-ec no-plug  0x40 / PAD-ec DOCK     0x20 / DOCK-ec no-plug 0x40
+ * PAD-ec AC       0x25 / PAD-ec DOCK+AC  0x24 / DOCK-ec AC      0x25
+ * PAD-ec USB      0x45 / PAD-ec DOCK+USB 0x24 / DOCK-ec USB     0x41
+ */
+
+#define ASUSEC_CTL_DIRECT_POWER_SOURCE	BIT_ULL(0)
+#define ASUSEC_STAT_CHARGING		BIT_ULL(2)
+#define ASUSEC_CTL_FULL_POWER_SOURCE	BIT_ULL(5)
+#define ASUSEC_CTL_SUSB_MODE		BIT_ULL(11)
+#define ASUSEC_CMD_SUSPEND_S3		BIT_ULL(41)
+#define ASUSEC_CTL_TEST_DISCHARGE	BIT_ULL(43)
+#define ASUSEC_CMD_SUSPEND_INHIBIT	BIT_ULL(45)
+#define ASUSEC_CTL_FACTORY_MODE		BIT_ULL(46)
+#define ASUSEC_CTL_KEEP_AWAKE		BIT_ULL(47)
+#define ASUSEC_CTL_USB_CHARGE		BIT_ULL(50)
+#define ASUSEC_CMD_SWITCH_HDMI		BIT_ULL(70)
+#define ASUSEC_CMD_WIN_SHUTDOWN		BIT_ULL(76)
+
+#define ASUSEC_DOCKRAM_INFO_MODEL	0x01
+#define ASUSEC_DOCKRAM_INFO_FW		0x02
+#define ASUSEC_DOCKRAM_INFO_CFGFMT	0x03
+#define ASUSEC_DOCKRAM_INFO_HW		0x04
+#define ASUSEC_DOCKRAM_CONTROL		0x0a
+#define ASUSEC_DOCKRAM_BATT_CTL		0x14
+
 /* dockram comm */
 int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
 int asus_dockram_write(struct i2c_client *client, int reg, const char *buf);
@@ -11,8 +79,35 @@ int asus_dockram_access_ctl(struct i2c_client *client,
 			    u64 *out, u64 mask, u64 xor);
 struct i2c_client *devm_asus_dockram_get(struct device *parent);
 
-#define DOCKRAM_ENTRIES		0x100
-#define DOCKRAM_ENTRY_SIZE	32
-#define DOCKRAM_ENTRY_BUFSIZE	(DOCKRAM_ENTRY_SIZE + 1)
+/* EC public API */
+static inline struct asusec_info *cell_to_ec(struct platform_device *pdev)
+{
+	return dev_get_drvdata(pdev->dev.parent);
+}
+
+static inline int asus_ec_get_ctl(const struct asusec_info *ec, u64 *out)
+{
+	return asus_dockram_access_ctl(ec->dockram, out, 0, 0);
+}
+
+static inline int asus_ec_update_ctl(const struct asusec_info *ec,
+				     u64 mask, u64 xor)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, xor);
+}
+
+static inline int asus_ec_set_ctl_bits(const struct asusec_info *ec, u64 mask)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, mask);
+}
+
+static inline int asus_ec_clear_ctl_bits(const struct asusec_info *ec, u64 mask)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, 0);
+}
+
+int asus_ec_i2c_command(const struct asusec_info *ec, u16 data);
+int devm_asus_ec_register_notifier(struct platform_device *dev,
+				   struct notifier_block *nb);
 
 #endif /* __MISC_ASUS_EC_H */
-- 
2.51.0


