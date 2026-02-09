Return-Path: <linux-pm+bounces-42339-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MSwD0W7iWmEBQUAu9opvQ
	(envelope-from <linux-pm+bounces-42339-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:47:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D510E502
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF91F303CC0D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99336922D;
	Mon,  9 Feb 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chz2uP1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B5368269
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633871; cv=none; b=giJFxNvKCAmEDoiL7Zxd4aiEBXLXyOvusaeRTACY8xwThCoH0LLNBv/y/xMQ13tn5NljfShl8SCt/JVSxsp5OBvwS721T3cHDLY2ykTOILSyGB24SLwlCUT5S5bxpk8cLOJABkXa1ZVvF9OjsQ/g9x8eeGcb3NtxYpzA9LMhyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633871; c=relaxed/simple;
	bh=LN5BArXu/Se7+4dtxV14gw9vAVWZi+IUkDx4iP67oRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPzDWaq/SbE5hwSLGXW6ebbN7wgPez5BhJw5g2ovjlkT7OZZn0g4voFs02pb62tTCKAROkyM1V5iM5oZlTjfB4d/USlWuCDul6qMKazRMhKRLI92f7CB9qZ26jYgh/0WL9j7hveFmlaZE5YYJgOaDX4853769DZULyCk8kViMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chz2uP1z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e17afd2d5so3180307e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633870; x=1771238670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq2FpxhF2cZ84ZQ1df1uG3zKLBW+YrD//0pnj4fZFUA=;
        b=Chz2uP1zG6zYtVaC8jpJtQgeZGmqVBqYxQF7pMQ1WZnXTKcc52oEspwfMDkTC8CEHu
         +3XEEhwA8d5M92g181htNe72LV/BHj+QPp5V0ysVLv7Siq7GNJLOodPFINSDnNHJdbtb
         SFxEVH+PgAmtXCAIIMhCwKZFYKdTnrpXumOf/WaLOISdBWXajGaWWAvwRTqEbDFWHoFf
         s+EmFqQ9WFOKNGK1N+l9o+6Vt0Lm+/TokU7erECXcMiGvVFZxTTeaQx+3cDYxOsAqYSc
         HsYasm6nFByxLcrtGSEBwFZGRLY7s17oVuwYVhMcBqgELV2oUQ9JfgI/Gi1gHDOyOX9F
         +TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633870; x=1771238670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uq2FpxhF2cZ84ZQ1df1uG3zKLBW+YrD//0pnj4fZFUA=;
        b=i4ThhrSzoT+nMfrZje7UahhFgckr+WmTInxqIkABW+6FeNqBgCGptL+6WGg0lMAU3p
         xSR5a9e1ZEPQCKWTblqpk04hU7FaHYjQukWV8Ikrpa2ulPLAoIZ77IZML2dNl67fIqWj
         oH0qGL21RdeKbDcMyTNjgeBRXO//GVave2ppF7s/fkndUnpzKC9l6L/nWNitDxpdlumZ
         jiO2fTVUmQvTCBt0sySThvFjwuNCEEK4OW2VQzqKzwVeGn+pOqsQZzTcvkIQaCgzDQCE
         O/TSxyB1MI78pZ4CDDqzcOERwGjGc5Ay7I5iaJv5l4go2mSDyuogJx6wUAAq64dfdqQQ
         /BNg==
X-Forwarded-Encrypted: i=1; AJvYcCVfUbdCIIWMFqF3udB24yPxNXIakoojwywNvo7NmHn1XabE+q6305Qj1T8juOSVsqziruuMmqFLNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycHsQgpiaXyLEiCgTKzCWAi3KVNPrUC4cD9/7E1mCDivO3ihQz
	b4K2/EoFciD5kJ1G7ixE5k6XgYPSKALVJLh0t0nBmihXUjfIwqVFXIZv
X-Gm-Gg: AZuq6aIRc5Kc3BbfnDqScgu7iFuPHYH2TX9/aNr9Gv7EqCjDazXffCzrYdSHTjOa48+
	KJqQQSq5WOq/uDGzyMcb2jIzRIkIILaq0NjY+3KdF47xMTK4wC8tR5opx9Yvp/UGSvTP4YGFTgG
	KhMIjLnABL4t2WMrjxVRYzWrfqqNjNKAwObWuPnMJRnJdOJLA+1GJHYn78pLlvhiRPjNdw/dFq8
	uLB9RFVqov9zxEEJPuIvz+l2OBv0OJLB7xEWnHsp6LC2ekgMkZwXGH8wFZrtLLFAOKLfXEXogXG
	Fbdfld0h4UFGsdd7ih3P92wPDK5EEPKfBm6PC7f8wSVqB7P1rrD8Hb4aJnBhdslUIyD9fGLTiCU
	L/2zdB0U6ilO78Mune4wNynpgyESaQ+DSbvN/6id1sbLxoP+gXFaUiIRMK8h4XNmcADa2QAqEc3
	zLn+Q2QJGlPxY=
X-Received: by 2002:a05:6512:1591:b0:59e:249f:81c7 with SMTP id 2adb3069b0e04-59e451583demr2912259e87.30.1770633869363;
        Mon, 09 Feb 2026 02:44:29 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:28 -0800 (PST)
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
Subject: [PATCH v2 2/9] misc: Support Asus Transformer's EC access device
Date: Mon,  9 Feb 2026 12:44:00 +0200
Message-ID: <20260209104407.116426-3-clamor95@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42339-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qmqm.pl:email]
X-Rspamd-Queue-Id: 988D510E502
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for accessing Embedded Controller of Asus Transformer devices.
This will be used by the EC MFD drivers.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/misc/Kconfig        |   9 +
 drivers/misc/Makefile       |   1 +
 drivers/misc/asus-dockram.c | 370 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/asus-ec.h |  24 +++
 4 files changed, 404 insertions(+)
 create mode 100644 drivers/misc/asus-dockram.c
 create mode 100644 include/linux/mfd/asus-ec.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dd1ab7e445ac..e7faa7ab4199 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -50,6 +50,15 @@ config AD525X_DPOT_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad525x_dpot-spi.
 
+config ASUS_DOCKRAM
+	tristate "Asus Transformer's EC DockRAM"
+	depends on I2C
+	help
+	  Select this if you are building for Asus Transformer's.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called asus-dockram.
+
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index bfad6982591c..d2287e912d59 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
 obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
+obj-$(CONFIG_ASUS_DOCKRAM)	+= asus-dockram.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
diff --git a/drivers/misc/asus-dockram.c b/drivers/misc/asus-dockram.c
new file mode 100644
index 000000000000..ecda7b0c6d63
--- /dev/null
+++ b/drivers/misc/asus-dockram.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC: DockRAM
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+struct dockram_ec_data {
+	struct mutex ctl_lock; /* prevent simultaneous access */
+	char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
+};
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
+	ret = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
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
+ * This executes the DockRAM write based on the SMBus "block write" protocol
+ * or its emulation. It writes DOCKRAM_ENTRY_SIZE bytes to the specified
+ * register address.
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
+DEFINE_DEBUGFS_ATTRIBUTE(control_reg_fops, control_reg_get, control_reg_set, "%016llx\n");
+
+/**
+ * asus_dockram_debugfs_init - Register DockRAM debugfs.
+ * @client: Handle to the DockRAM device.
+ * @debugfs_root: Pointer to the root directory dentry.
+ *
+ * Creates a debugfs setup for DockRAM in the directory of the linked EC.
+ * The debugfs setup must be removed by the caller.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+void asus_dockram_debugfs_init(struct i2c_client *client, struct dentry *debugfs_root)
+{
+	struct dentry *dockram_dir;
+
+	dockram_dir = debugfs_create_dir("dockram", debugfs_root);
+
+	debugfs_create_file("control_reg", 0644, dockram_dir, client, &control_reg_fops);
+	debugfs_create_file("dockram", 0644, dockram_dir, client, &dockram_fops);
+}
+EXPORT_SYMBOL_GPL(asus_dockram_debugfs_init);
+
+static int asus_dockram_probe(struct i2c_client *client)
+{
+	struct dockram_ec_data *priv;
+	struct device *dev = &client->dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return dev_err_probe(dev, -ENXIO,
+			"I2C bus is missing required SMBus block mode support\n");
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, priv);
+	mutex_init(&priv->ctl_lock);
+
+	return 0;
+}
+
+static const struct of_device_id asus_dockram_ids[] = {
+	{ .compatible = "asus,dockram" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_dockram_ids);
+
+static struct i2c_driver asus_dockram_driver = {
+	.driver	= {
+		.name = "asus-dockram",
+		.of_match_table = of_match_ptr(asus_dockram_ids),
+	},
+	.probe = asus_dockram_probe,
+};
+module_i2c_driver(asus_dockram_driver);
+
+static void devm_i2c_device_release(struct device *dev, void *res)
+{
+	struct i2c_client **pdev = res;
+	struct i2c_client *child = *pdev;
+
+	if (child)
+		put_device(&child->dev);
+}
+
+static struct i2c_client *devm_i2c_device_get_by_phandle(struct device *dev,
+							 const char *name,
+							 int index)
+{
+	struct device_node *np;
+	struct i2c_client **pdev;
+
+	pdev = devres_alloc(devm_i2c_device_release, sizeof(*pdev),
+			    GFP_KERNEL);
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	np = of_parse_phandle(dev_of_node(dev), name, index);
+	if (!np) {
+		devres_free(pdev);
+		dev_err(dev, "can't resolve phandle %s: %d\n", name, index);
+		return ERR_PTR(-ENODEV);
+	}
+
+	*pdev = of_find_i2c_device_by_node(np);
+	of_node_put(np);
+
+	if (!*pdev) {
+		devres_free(pdev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	devres_add(dev, pdev);
+
+	return *pdev;
+}
+
+/**
+ * devm_asus_dockram_get - Device-managed request of DockRAM via device phandle.
+ * @parent: Parent device which requests the DockRAM device.
+ *
+ * Request the DockRAM device by phandle from the parent's device-tree node.
+ * The DockRAM device phandle will be automatically released and DockRAM will be
+ * detached on parent driver detach.
+ *
+ * Return: Pointer to the DockRAM I2C device on success, or an ERR_PTR on failure.
+ */
+struct i2c_client *devm_asus_dockram_get(struct device *parent)
+{
+	struct i2c_client *dockram =
+		devm_i2c_device_get_by_phandle(parent, "asus,dockram", 0);
+
+	if (IS_ERR(dockram))
+		return dockram;
+	if (!dockram->dev.driver)
+		return ERR_PTR(-EPROBE_DEFER);
+	if (dockram->dev.driver != &asus_dockram_driver.driver)
+		return ERR_PTR(-EBUSY);
+
+	return dockram;
+}
+EXPORT_SYMBOL_GPL(devm_asus_dockram_get);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's dockram driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/asus-ec.h b/include/linux/mfd/asus-ec.h
new file mode 100644
index 000000000000..6a36313b9ebd
--- /dev/null
+++ b/include/linux/mfd/asus-ec.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MISC_ASUS_EC_H
+#define __MISC_ASUS_EC_H
+
+struct i2c_client;
+
+#define DOCKRAM_ENTRIES			0x100
+#define DOCKRAM_ENTRY_SIZE		32
+#define DOCKRAM_ENTRY_BUFSIZE		(DOCKRAM_ENTRY_SIZE + 1)
+
+/* control register [0x0A] layout */
+#define ASUSEC_CTL_SIZE			8
+
+#define ASUSEC_DOCKRAM_CONTROL		0x0a
+
+/* dockram comm */
+int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
+int asus_dockram_write(struct i2c_client *client, int reg, const char *buf);
+int asus_dockram_access_ctl(struct i2c_client *client,
+			    u64 *out, u64 mask, u64 xor);
+struct i2c_client *devm_asus_dockram_get(struct device *parent);
+void asus_dockram_debugfs_init(struct i2c_client *client,
+			       struct dentry *debugfs_root);
+#endif /* __MISC_ASUS_EC_H */
-- 
2.51.0


