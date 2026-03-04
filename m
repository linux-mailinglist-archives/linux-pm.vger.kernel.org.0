Return-Path: <linux-pm+bounces-43614-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIDlHheCqGmYvAAAu9opvQ
	(envelope-from <linux-pm+bounces-43614-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C18206CE2
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39164304DC9A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9E3DA5A7;
	Wed,  4 Mar 2026 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXszN3V2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF53DA5B0
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650690; cv=none; b=Zk/znukYXOAVq29mf+PVHBZEQriEMswNP18pXPyBhl0hahuCzI6JTO1y8ouq6VY3K0IhaGxw/h6lKAYaa+2ATglSuVvaht8x6SiW/jOeN4M2T4ZFh1mm3+MoyBZsc1WaYngTZBRKiWXtXGani11jjGAlbjKHSG+R7alSSvPdX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650690; c=relaxed/simple;
	bh=navC5G1S8W8VX/n9M16sJYL90Z7g1iUS62GUDJpPyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgfTio2W5YU+J5ei2Rn18NDMPgvl8Ay5bEwRoeEx3e51dg4k1joVyCNddcVglGMJsLhyuviCn55+Io2K2O+2T06k16mSEuT/MF/1zLB68k7CWqNZ5A6e2Le8PtB3GKQWRYgUidyY7NNNZt25v/6g8+yQEPwZ6sf73UUpnNQZ2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXszN3V2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a33070b32so6388431fa.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650685; x=1773255485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2931DPcC4IxpMNLiMCX6IPqOOVc3fEg8iXAlIxRLRik=;
        b=XXszN3V27l0L6Jyom3kG3h5RrKqYkAFCf1eHUDOeEXxB9eXB3sqoRHaQ178ro6BkUv
         QMGaBJhCgXTLdyJCxl/2Uu5OAO76kqIEDliE+bOUMgp5S4Yyk3rqggdkMov/KamNqf02
         xfj2IjKe4XpLbuKwkCeHno86MXCKuZlJoR7ZlJRal4sy7HTrjQ1xRZ3y0cE3jSwqoxcE
         wmdQnm6ZNFJ3OskY+5Ez2ZTsi+4jDU0sWnQTmUJaXNji+QtafboCCmv7B42aSKsazUie
         fWf+oLNyzH86NJ0B4A9lWYU3/tb2yAn7sQ5icEXvKpS0o0oK3yaYDTaJkyLFa63NIzSs
         qWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650685; x=1773255485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2931DPcC4IxpMNLiMCX6IPqOOVc3fEg8iXAlIxRLRik=;
        b=eAERJo15wr6qteXX1kz7jwLp6CYOoqmhmd3OHBxp/9qTbWi23Zez+ArgA2cAGwzeUq
         LWk3hWqn8XUTax6ZRB21fAVTIDU1FZUZ882YdgQMfWBDwwfWllFKR+UIFSIwacgBmjhO
         vH5QiB9KARJq/DiAAkSELmzaFqm6qpNmMjHXvQ/8dUwKZYCRk19yJSzznGkQFIlszAhB
         L+nKGKYdpiFLrI1BV7fEaJqt98EoO0DuuzUjbenW+7RoFURlhWLJYFDVpBThWOINSCUq
         H98nGH19ReSo8JdbUL21ZTWt35rsrstlZBOAOXd0sZWlQZ2vciPD6rKGAt/g6wVpXhaO
         cXqw==
X-Forwarded-Encrypted: i=1; AJvYcCVq+l+aPT9dhy8IjMj36Co76an9S+zr5ue+Fou2kPJfySO1sEFjtZ6oUaufadAm54QSBntEMHFVqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGbBjbnqGJwfgi0OIXfk9yUB+MH/U75lJ+CTLEl6bvc/fVEak
	Ii1bpHwuyf3uUISQocCU2GbgxqR0MiyHkfZ2oeRrpfZdd5pKVOgBezZr
X-Gm-Gg: ATEYQzyzi9vhyAnrAIianHw2M/g7PT7wlYruyUg+xbacuWnpRHmL6xmEEv8lUspxqUE
	AVM0VI819b0DfnUB8bRwmlqJ+zmqyndpufS9KEZJX3ryBLEeSOVDYAwMo6CAJcMiFxLMbTClADT
	BdMRhG19swqhjEwH7yEt2BrEg7K73UQyQ59abwNFbv5ku5r1cTIXD7kbRF3tZZzi2BZsCj3xjmw
	QS7fUmF354ksI2URLb69kjrf3IhV9UFscGl2V3d4inWGqMAo1il4F0ZACL/AUQ6pB16VksJg8K5
	QE2ZQTu91gWDZQZUe+8nz242ALlfnRlgZ3XWf17TCIwXJ0bAeAfRPRJn916lI6HVB/4SFg89Tnq
	OoNKjQPCczkysRGcXiJmc4N0Ilsw96LtuAKLfKzH02mtnutHf77UeMFKGmrholF2FBFaGMsPPfw
	dpMQ0EESvFpqZu
X-Received: by 2002:a05:651c:f02:b0:38a:464:a53d with SMTP id 38308e7fff4ca-38a2c574d63mr25901741fa.12.1772650684896;
        Wed, 04 Mar 2026 10:58:04 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 2/7] mfd: Add driver for ASUS Transformer embedded controller
Date: Wed,  4 Mar 2026 20:57:46 +0200
Message-ID: <20260304185751.83494-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0C18206CE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43614-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/asus-transformer-ec.c       | 762 ++++++++++++++++++++++++
 include/linux/mfd/asus-transformer-ec.h | 162 +++++
 4 files changed, 939 insertions(+)
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7192c9d1d268..5aa4facfd2df 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -137,6 +137,20 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ASUS_TRANSFORMER_EC
+	tristate "ASUS Transformer's embedded controller"
+	depends on I2C && OF
+	help
+	  Support ECs found in ASUS Transformer's Pad and Mobile Dock.
+
+	  This provides shared glue for functional part drivers:
+	    asus-transformer-ec-kbc, asus-transformer-ec-keys,
+	    leds-asus-transformer-ec, asus-transformer-ec-battery
+	    and asus-transformer-ec-charger.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus-transformer-ec.
+
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e75e8045c28a..fd80088d8a9a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
+obj-$(CONFIG_MFD_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transformer-ec.c
new file mode 100644
index 000000000000..aa3b9e31f3fc
--- /dev/null
+++ b/drivers/mfd/asus-transformer-ec.c
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define ASUSEC_RSP_BUFFER_SIZE		8
+
+struct asus_ec_chip_data {
+	const char *name;
+	const struct mfd_cell *mfd_devices;
+	unsigned int num_devices;
+	bool clr_fmode; /* clear Factory Mode bit in EC control register */
+};
+
+struct asus_ec_data {
+	struct asusec_info info;
+	struct mutex ecreq_lock; /* prevent simultaneous access */
+	struct gpio_desc *ecreq;
+	struct i2c_client *self;
+	const struct asus_ec_chip_data *data;
+	char ec_data[DOCKRAM_ENTRY_BUFSIZE];
+	bool logging_disabled;
+};
+
+struct dockram_ec_data {
+	struct mutex ctl_lock; /* prevent simultaneous access */
+	char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
+};
+
+#define to_ec_data(ec) \
+	container_of(ec, struct asus_ec_data, info)
+
+/**
+ * asus_dockram_read - Read a register from the DockRAM device.
+ * @client: Handle to the DockRAM device.
+ * @reg: Register to read.
+ * @buf: Byte array into which data will be read; must be large enough to
+ *	 hold the data returned by the DockRAM.
+ *
+ * This executes the DockRAM read based on the SMBus "block read" protocol
+ * or its emulation. It extracts DOCKRAM_ENTRY_SIZE bytes from the set
+ * register address.
+ *
+ * Returns a negative errno code else zero on success.
+ */
+int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
+{
+	struct device *dev = &client->dev;
+	int ret;
+
+	memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
+	ret = i2c_smbus_read_i2c_block_data(client, reg,
+					    DOCKRAM_ENTRY_BUFSIZE, buf);
+	if (ret < 0)
+		return ret;
+
+	if (buf[0] > DOCKRAM_ENTRY_SIZE) {
+		dev_err(dev, "bad data len; buffer: %*ph; ret: %d\n",
+			DOCKRAM_ENTRY_BUFSIZE, buf, ret);
+		return -EPROTO;
+	}
+
+	dev_dbg(dev, "got data; buffer: %*ph; ret: %d\n",
+		DOCKRAM_ENTRY_BUFSIZE, buf, ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asus_dockram_read);
+
+/**
+ * asus_dockram_write - Write a byte array to a register of the DockRAM device.
+ * @client: Handle to the DockRAM device.
+ * @reg: Register to write to.
+ * @buf: Byte array to be written (up to DOCKRAM_ENTRY_SIZE bytes).
+ *
+ * This executes the DockRAM write based on the SMBus "block write"
+ * protocol or its emulation. It writes DOCKRAM_ENTRY_SIZE bytes to the
+ * specified register address.
+ *
+ * Returns a negative errno code else zero on success.
+ */
+int asus_dockram_write(struct i2c_client *client, int reg, const char *buf)
+{
+	if (buf[0] > DOCKRAM_ENTRY_SIZE)
+		return -EINVAL;
+
+	dev_dbg(&client->dev, "sending data; buffer: %*ph\n", buf[0] + 1, buf);
+
+	return i2c_smbus_write_i2c_block_data(client, reg, buf[0] + 1, buf);
+}
+EXPORT_SYMBOL_GPL(asus_dockram_write);
+
+/**
+ * asus_dockram_access_ctl - Read from or write to the DockRAM control register.
+ * @client: Handle to the DockRAM device.
+ * @out: Pointer to a variable where the register value will be stored.
+ * @mask: Bitmask of bits to be cleared.
+ * @xor: Bitmask of bits to be set (via XOR).
+ *
+ * This performs a control register read if @out is provided and both @mask
+ * and @xor are zero. Otherwise, it performs a control register update if
+ * @mask and @xor are provided.
+ *
+ * Returns a negative errno code else zero on success.
+ */
+int asus_dockram_access_ctl(struct i2c_client *client, u64 *out, u64 mask,
+			    u64 xor)
+{
+	struct dockram_ec_data *priv = i2c_get_clientdata(client);
+	char *buf = priv->ctl_data;
+	u64 val;
+	int ret = 0;
+
+	guard(mutex)(&priv->ctl_lock);
+
+	ret = asus_dockram_read(client, ASUSEC_DOCKRAM_CONTROL, buf);
+	if (ret < 0)
+		goto exit;
+
+	if (buf[0] != ASUSEC_CTL_SIZE) {
+		ret = -EPROTO;
+		goto exit;
+	}
+
+	val = get_unaligned_le64(buf + 1);
+
+	if (out)
+		*out = val;
+
+	if (mask || xor) {
+		put_unaligned_le64((val & ~mask) ^ xor, buf + 1);
+		ret = asus_dockram_write(client, ASUSEC_DOCKRAM_CONTROL, buf);
+	}
+
+exit:
+	if (ret < 0)
+		dev_err(&client->dev, "Failed to access control flags: %d\n",
+			ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asus_dockram_access_ctl);
+
+static void asus_ec_remove_notifier(struct device *dev, void *res)
+{
+	struct asusec_info *ec = dev_get_drvdata(dev->parent);
+	struct notifier_block **nb = res;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, *nb);
+}
+
+/**
+ * devm_asus_ec_register_notifier - Managed registration of notifier to an
+ *				    ASUS EC blocking notifier chain.
+ * @pdev: Device requesting the notifier (used for resource management).
+ * @nb: Notifier block to be registered.
+ *
+ * Register a notifier to the ASUS EC blocking notifier chain. The notifier
+ * will be automatically unregistered when the requesting device is detached.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
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
+	int ret = i2c_smbus_write_word_data(priv->self, ASUSEC_WRITE_BUF, data);
+
+	dev_dbg(&priv->self->dev, "EC write: %04x, ret = %d\n", data, ret);
+	return ret;
+}
+
+static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
+{
+	int ret = i2c_smbus_read_i2c_block_data(priv->self, ASUSEC_READ_BUF,
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
+/**
+ * asus_ec_i2c_command - Send a 16-bit command to the ASUS EC.
+ * @ec: Pointer to the shared ASUS EC structure.
+ * @data: The 16-bit command (word) to be sent.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
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
+		dev_info(&priv->self->dev, "%-14s: %.*s\n", name,
+			 buf[0], buf + 1);
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
+		 flag ? "susb on when receive ec_req" :
+		 "susb on when system wakeup");
+
+	return 0;
+}
+
+static int asus_ec_set_factory_mode(struct asus_ec_data *priv, bool on)
+{
+	dev_info(&priv->self->dev, "Entering %s mode.\n", on ? "factory" :
+		 "normal");
+	return asus_ec_update_ctl(&priv->info, ASUSEC_CTL_FACTORY_MODE,
+				  on ? ASUSEC_CTL_FACTORY_MODE : 0);
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
+	if (priv->data->clr_fmode)
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
+static ssize_t dockram_read(struct file *filp, char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct i2c_client *client = filp->private_data;
+	unsigned int reg, rsize;
+	ssize_t n_read = 0, val;
+	loff_t off = *ppos;
+	char *data;
+	int ret;
+
+	reg = off / DOCKRAM_ENTRY_SIZE;
+	off %= DOCKRAM_ENTRY_SIZE;
+	rsize = DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE;
+
+	if (!count)
+		return 0;
+
+	data = kmalloc(DOCKRAM_ENTRY_BUFSIZE, GFP_KERNEL);
+
+	while (reg < DOCKRAM_ENTRIES) {
+		unsigned int len = DOCKRAM_ENTRY_SIZE - off;
+
+		if (len > rsize)
+			len = rsize;
+
+		ret = asus_dockram_read(client, reg, data);
+		if (ret < 0) {
+			if (!n_read)
+				n_read = ret;
+			break;
+		}
+
+		val = copy_to_user(buf, data + 1 + off, len);
+		if (val == len)
+			return -EFAULT;
+
+		*ppos += len;
+		n_read += len;
+
+		if (len == rsize)
+			break;
+
+		rsize -= len;
+		buf += len;
+		off = 0;
+		++reg;
+	}
+
+	kfree(data);
+
+	return n_read;
+}
+
+static int dockram_write_one(struct i2c_client *client, int reg,
+			     const char __user *buf, size_t count)
+{
+	struct dockram_ec_data *priv = i2c_get_clientdata(client);
+	int ret;
+
+	if (!count || count > DOCKRAM_ENTRY_SIZE)
+		return -EINVAL;
+	if (buf[0] != count - 1)
+		return -EINVAL;
+
+	guard(mutex)(&priv->ctl_lock);
+
+	priv->ctl_data[0] = (u8)count;
+	memcpy(priv->ctl_data + 1, buf, count);
+	ret = asus_dockram_write(client, reg, priv->ctl_data);
+
+	return ret;
+}
+
+static ssize_t dockram_write(struct file *filp, const char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct i2c_client *client = filp->private_data;
+	unsigned int reg;
+	loff_t off = *ppos;
+	int ret;
+
+	if (off % DOCKRAM_ENTRY_SIZE != 0)
+		return -EINVAL;
+
+	reg = off / DOCKRAM_ENTRY_SIZE;
+	if (reg >= DOCKRAM_ENTRIES)
+		return -EINVAL;
+
+	ret = dockram_write_one(client, reg, buf, count);
+
+	return ret < 0 ? ret : count;
+}
+
+static const struct debugfs_short_fops dockram_fops = {
+	.read	= dockram_read,
+	.write	= dockram_write,
+	.llseek	= default_llseek,
+};
+
+static int control_reg_get(void *client, u64 *val)
+{
+	return asus_dockram_access_ctl(client, val, 0, 0);
+}
+
+static int control_reg_set(void *client, u64 val)
+{
+	return asus_dockram_access_ctl(client, NULL, ~0ull, val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(control_reg_fops, control_reg_get,
+			 control_reg_set, "%016llx\n");
+
+static int ec_request_set(void *ec, u64 val)
+{
+	if (val)
+		asus_ec_signal_request(ec);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ec_request_fops, NULL, ec_request_set, "%llu\n");
+
+static int ec_irq_set(void *ec, u64 val)
+{
+	struct asus_ec_data *priv = to_ec_data(ec);
+
+	if (val)
+		irq_wake_thread(priv->self->irq, priv);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ec_irq_fops, NULL, ec_irq_set, "%llu\n");
+
+static void asus_ec_debugfs_remove(void *debugfs_root)
+{
+	debugfs_remove_recursive(debugfs_root);
+}
+
+static void devm_asus_ec_debugfs_init(struct device *dev)
+{
+	struct asusec_info *ec = dev_get_drvdata(dev);
+	struct asus_ec_data *priv = to_ec_data(ec);
+	struct dentry *debugfs_root, *dockram_dir;
+	char *name = devm_kasprintf(dev, GFP_KERNEL, "asus-ec-%s",
+				    priv->data->name);
+
+	debugfs_root = debugfs_create_dir(name, NULL);
+	dockram_dir = debugfs_create_dir("dockram", debugfs_root);
+
+	debugfs_create_file("ec_irq", 0200, debugfs_root, ec,
+			    &ec_irq_fops);
+	debugfs_create_file("ec_request", 0200, debugfs_root, ec,
+			    &ec_request_fops);
+	debugfs_create_file("control_reg", 0644, dockram_dir,
+			    priv->info.dockram, &control_reg_fops);
+	debugfs_create_file("dockram", 0644, dockram_dir,
+			    priv->info.dockram, &dockram_fops);
+
+	devm_add_action_or_reset(dev, asus_ec_debugfs_remove, debugfs_root);
+}
+
+static void asus_ec_release_dockram_dev(void *client)
+{
+	i2c_unregister_device(client);
+}
+
+static struct i2c_client *devm_asus_dockram_get(struct device *dev)
+{
+	struct i2c_client *parent = to_i2c_client(dev);
+	struct i2c_client *dockram;
+	struct dockram_ec_data *priv;
+	int ret;
+
+	dockram = i2c_new_ancillary_device(parent, "dockram",
+					   parent->addr + 2);
+	if (IS_ERR(dockram))
+		return dockram;
+
+	ret = devm_add_action_or_reset(dev, asus_ec_release_dockram_dev,
+				       dockram);
+	if (ret)
+		return ERR_PTR(ret);
+
+	priv = devm_kzalloc(&dockram->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	i2c_set_clientdata(dockram, priv);
+	mutex_init(&priv->ctl_lock);
+
+	return dockram;
+}
+
+static int asus_ec_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct asus_ec_data *priv;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return dev_err_probe(dev, -ENXIO,
+			"I2C bus is missing required SMBus block mode support\n");
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = device_get_match_data(dev);
+	if (!priv->data)
+		return -ENODEV;
+
+	i2c_set_clientdata(client, priv);
+	priv->self = client;
+
+	priv->info.dockram = devm_asus_dockram_get(dev);
+	if (IS_ERR(priv->info.dockram))
+		return dev_err_probe(dev, PTR_ERR(priv->info.dockram),
+				     "failed to get dockram\n");
+
+	priv->ecreq = devm_gpiod_get(dev, "request", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->ecreq))
+		return dev_err_probe(dev, PTR_ERR(priv->ecreq),
+				     "failed to get request GPIO\n");
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&priv->info.notify_list);
+	mutex_init(&priv->ecreq_lock);
+
+	asus_ec_signal_request(&priv->info);
+
+	ret = asus_ec_detect(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to detect EC version\n");
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					&asus_ec_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED,
+					client->name, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register IRQ\n");
+
+	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
+	client->dev.coherent_dma_mask = 0;
+	client->dev.dma_mask = &client->dev.coherent_dma_mask;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		devm_asus_ec_debugfs_init(dev);
+
+	return devm_mfd_add_devices(dev, 0, priv->data->mfd_devices,
+				    priv->data->num_devices, NULL, 0, NULL);
+}
+
+static const struct mfd_cell asus_ec_sl101_dock_mfd_devices[] = {
+	{
+		.name = "asus-transformer-ec-kbc",
+	},
+};
+
+static const struct asus_ec_chip_data asus_ec_sl101_dock_data = {
+	.name = "dock",
+	.mfd_devices = asus_ec_sl101_dock_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_sl101_dock_mfd_devices),
+	.clr_fmode = false,
+};
+
+static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] = {
+	{
+		.name = "asus-transformer-ec-battery",
+		.id = 1,
+	}, {
+		.name = "asus-transformer-ec-charger",
+		.id = 1,
+	}, {
+		.name = "asus-transformer-ec-led",
+		.id = 1,
+	}, {
+		.name = "asus-transformer-ec-keys",
+	}, {
+		.name = "asus-transformer-ec-kbc",
+	},
+};
+
+static const struct asus_ec_chip_data asus_ec_tf101_dock_data = {
+	.name = "dock",
+	.mfd_devices = asus_ec_tf101_dock_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_tf101_dock_mfd_devices),
+	.clr_fmode = false,
+};
+
+static const struct mfd_cell asus_ec_tf201_pad_mfd_devices[] = {
+	{
+		.name = "asus-transformer-ec-battery",
+		.id = 0,
+	}, {
+		.name = "asus-transformer-ec-led",
+		.id = 0,
+	},
+};
+
+static const struct asus_ec_chip_data asus_ec_tf201_pad_data = {
+	.name = "pad",
+	.mfd_devices = asus_ec_tf201_pad_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_tf201_pad_mfd_devices),
+	.clr_fmode = true,
+};
+
+static const struct mfd_cell asus_ec_tf600t_pad_mfd_devices[] = {
+	{
+		.name = "asus-transformer-ec-battery",
+		.id = 0,
+	}, {
+		.name = "asus-transformer-ec-charger",
+		.id = 0,
+	}, {
+		.name = "asus-transformer-ec-led",
+		.id = 0,
+	},
+};
+
+static const struct asus_ec_chip_data asus_ec_tf600t_pad_data = {
+	.name = "pad",
+	.mfd_devices = asus_ec_tf600t_pad_mfd_devices,
+	.num_devices = ARRAY_SIZE(asus_ec_tf600t_pad_mfd_devices),
+	.clr_fmode = true,
+};
+
+static const struct of_device_id asus_ec_match[] = {
+	{ .compatible = "asus,sl101-ec-dock", .data = &asus_ec_sl101_dock_data },
+	{ .compatible = "asus,tf101-ec-dock", .data = &asus_ec_tf101_dock_data },
+	{ .compatible = "asus,tf201-ec-pad", .data = &asus_ec_tf201_pad_data },
+	{ .compatible = "asus,tf600t-ec-pad", .data = &asus_ec_tf600t_pad_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_match);
+
+static struct i2c_driver asus_ec_driver = {
+	.driver	= {
+		.name = "asus-transformer-ec",
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
diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/asus-transformer-ec.h
new file mode 100644
index 000000000000..0a72de40352e
--- /dev/null
+++ b/include/linux/mfd/asus-transformer-ec.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MFD_ASUS_TRANSFORMER_EC_H
+#define __MFD_ASUS_TRANSFORMER_EC_H
+
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+struct i2c_client;
+
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
+/* control register [0x0a] layout */
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
+#define ASUSEC_CTL_SUSB_MODE		BIT_ULL(9)
+#define ASUSEC_CMD_SUSPEND_S3		BIT_ULL(33)
+#define ASUSEC_CTL_TEST_DISCHARGE	BIT_ULL(35)
+#define ASUSEC_CMD_SUSPEND_INHIBIT	BIT_ULL(37)
+#define ASUSEC_CTL_FACTORY_MODE		BIT_ULL(38)
+#define ASUSEC_CTL_KEEP_AWAKE		BIT_ULL(39)
+#define ASUSEC_CTL_USB_CHARGE		BIT_ULL(40)
+#define ASUSEC_CTL_LED_BLINK		BIT_ULL(40)
+#define ASUSEC_CTL_LED_AMBER		BIT_ULL(41)
+#define ASUSEC_CTL_LED_GREEN		BIT_ULL(42)
+#define ASUSEC_CMD_SWITCH_HDMI		BIT_ULL(56)
+#define ASUSEC_CMD_WIN_SHUTDOWN		BIT_ULL(62)
+
+#define ASUSEC_DOCKRAM_INFO_MODEL	0x01
+#define ASUSEC_DOCKRAM_INFO_FW		0x02
+#define ASUSEC_DOCKRAM_INFO_CFGFMT	0x03
+#define ASUSEC_DOCKRAM_INFO_HW		0x04
+#define ASUSEC_DOCKRAM_CONTROL		0x0a
+#define ASUSEC_DOCKRAM_BATT_CTL		0x14
+
+#define ASUSEC_WRITE_BUF		0x64
+#define ASUSEC_READ_BUF			0x6a
+
+/* dockram comm */
+int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
+int asus_dockram_write(struct i2c_client *client, int reg, const char *buf);
+int asus_dockram_access_ctl(struct i2c_client *client,
+			    u64 *out, u64 mask, u64 xor);
+
+/* EC public API */
+
+/**
+ * cell_to_ec - Request the shared ASUS EC structure via a subdevice's pdev.
+ * @pdev: EC subdevice pdev requesting access to the shared ASUS EC structure.
+ *
+ * Returns a pointer to the asusec_info structure.
+ */
+static inline struct asusec_info *cell_to_ec(struct platform_device *pdev)
+{
+	return dev_get_drvdata(pdev->dev.parent);
+}
+
+/**
+ * asus_ec_get_ctl - Read from the DockRAM control register.
+ * @ec:  Pointer to the shared ASUS EC structure.
+ * @out: Pointer to the variable where the register value will be stored.
+ *
+ * Performs a control register read and stores the value in @out.
+ *
+ * Return: 0 on success, or a negative errno code on failure.
+ */
+static inline int asus_ec_get_ctl(const struct asusec_info *ec, u64 *out)
+{
+	return asus_dockram_access_ctl(ec->dockram, out, 0, 0);
+}
+
+/**
+ * asus_ec_update_ctl - Update the DockRAM control register.
+ * @ec:   Pointer to the shared ASUS EC structure.
+ * @mask: Bitmask of bits to be cleared.
+ * @xor:  Bitmask of bits to be toggled or set (via XOR).
+ *
+ * Performs a read-modify-write update on the control register using
+ * the provided @mask and @xor values.
+ *
+ * Return: 0 on success, or a negative errno code on failure.
+ */
+static inline int asus_ec_update_ctl(const struct asusec_info *ec,
+				     u64 mask, u64 xor)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, xor);
+}
+
+/**
+ * asus_ec_set_ctl_bits - Sets bits of the DockRAM control register.
+ * @ec:   Pointer to the shared ASUS EC structure.
+ * @mask: Bitmask of bits to be set.
+ *
+ * Sets bits of the control register using the provided @mask value.
+ *
+ * Return: 0 on success, or a negative errno code on failure.
+ */
+static inline int asus_ec_set_ctl_bits(const struct asusec_info *ec, u64 mask)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, mask);
+}
+
+/**
+ * asus_ec_clear_ctl_bits - Clears bits of the DockRAM control register.
+ * @ec:   Pointer to the shared ASUS EC structure.
+ * @mask: Bitmask of bits to be cleared.
+ *
+ * Clears bits of the control register using the provided @mask value.
+ *
+ * Return: 0 on success, or a negative errno code on failure.
+ */
+static inline int asus_ec_clear_ctl_bits(const struct asusec_info *ec, u64 mask)
+{
+	return asus_dockram_access_ctl(ec->dockram, NULL, mask, 0);
+}
+
+int asus_ec_i2c_command(const struct asusec_info *ec, u16 data);
+int devm_asus_ec_register_notifier(struct platform_device *dev,
+				   struct notifier_block *nb);
+#endif /* __MFD_ASUS_TRANSFORMER_EC_H */
-- 
2.51.0


