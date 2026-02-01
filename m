Return-Path: <linux-pm+bounces-41849-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM8SK5Auf2kZlQIAu9opvQ
	(envelope-from <linux-pm+bounces-41849-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A3AC57BC
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9384130022D7
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DEB326D70;
	Sun,  1 Feb 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK8fV1qZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1A2EC54C
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942657; cv=none; b=GLjXLUT3zjXr61D9WaSv3pMF3radgRlP4hgd6e8Ar+kybXiiZYK49YMUGZDNScvBkyty4ha1wqiyw4nfghT+EUhDZOaFcTwvEIpVtWmsVC5r6MwADwmKfLIX8MgR+PChuMFTDqr24pU5IsIRwR2qDtMurfN6lxsBydCOnA4UQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942657; c=relaxed/simple;
	bh=MmvcjAHmY9aFurBioYKxYGT+fXCRvKADDio6QvZg5Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX02af+4rkKg382Y3rR8vqqdy8J4J0/8UpAqVgWrjHSqPBlBva8qkc3F0SsrNl9DJqGfkU+SbvzrTKyUFxf6zRbRFYhkp83XdiBEDkMVTfpgpZJ/3mGkTSf+ekdnM3lToRjznMWjKfAgwmtW85hqcnCINKyjQ6L5dBi5O6Fk7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK8fV1qZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso14058915e9.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942653; x=1770547453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW0JM8bdWfKfSamq7DjcZL13sVfyz7u3bs6KeiNnLcY=;
        b=IK8fV1qZjVEFFQ1iUfVaNwe6Vf2H/FmtinypcsKPqdJrqOWRAlySQ3NZyoUEdDC15p
         bt6VHwibGoUZZrq8dxj+GYXTPc6cGEOx4jGLHWD/yih9EPXr/lyDNr1H9WR7sN6j1idw
         GbxYYAC1dVqlmygLc7A7ZbtkKZy6bgDTF+bRKFSppdcboLweRhiVtdDwgyoszY9eX7I9
         Mq61VocPi84A7iKq3Y0hjS5v7GwLX7hGQxzwhb247D4+yRcOrZ+0WV+V+w+nBv90pi9l
         S+Ac7tq6G0c7CQAbyvIfONi9PvK9sp3YPZ+ri+I5fSH4xAmcAbZFxd+pK8EE4yfCjzzz
         7mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942653; x=1770547453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FW0JM8bdWfKfSamq7DjcZL13sVfyz7u3bs6KeiNnLcY=;
        b=ZE9k+oUblWWvyPLPTBvLqJ2+v2DysjtMlQ1tp6jQDo7ziT4G7xDDLShQl4xMITLh4E
         q160fQiN+b5B5yYHtdAtTk1A+y6I1vN+NqS4pFUtTK40KkJ0FH1Q+fOoP1nfuqqpbklP
         g0LLUAv4NXlgJIg7ttyu4MV8P3kMhd9xGBfHWC/E4k/Rp+/T4LHlyA9qd4GoMD5958Wl
         6QUiNuY2JESqJYgCP0qWtx0rYrlYtsUyZytLL4r/XIh/opbXYlgdiAp9WPGhG0bSOEhm
         OvrlItz/LtrQ4dFNljeZGOGHD7Li0KkU9S0OkFjebkTSBnJrSltakMxNWh4n5vpcSqL8
         tu4w==
X-Forwarded-Encrypted: i=1; AJvYcCXtakcKUQ6RQuPEHXxQW0meDSo4e1nl4EcMuevEet5nRBGoXVbZzP4LWl6ten0ul4Wo00mG3BMGcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZrjdDMn6Z4uMtb6IpREY8Q6JD5GH2O2fTnUNASHvgyp0Bmyi
	FO4jdlsRKzxhgEGjtAOn4IK6l7o0rWSZHzZSv0chqr27ccstrs7xSpVG
X-Gm-Gg: AZuq6aL5Hyz9LgOorYQHsB3NVKBLbrRx6o18yeaO/OLquex+zb65a63fjt6nktMCryS
	kK4MSKiTcsOeMLFnpqN+HQL9YjmITrVeVSKfirb4z5IPU0nUQCozC7Zo6CDC6MuRvICrOa2q7RA
	SyrABTEkj1YfR0nO3fnDtCely4FVrUyiwR4m6TWjvsK0LeTFx/+uvz8ftCwY+cpBHi7gCcTAd3s
	aQOkZx15infWlB6Qx9dvkLLjKW285a5Q7fmA/P+6J0BQqQRknXpgimKcOzMbfxXnevreEX3oY5o
	13yNm1PxBEHx02NI8ei4l285u0CKdEguu9dV0EiCvo3rKOUxXXtYhQnkxeQHxc4WXSTK0BwY8/N
	2nYFnOVd5DvjB5ShplxXi0UR89NJ8SkRtnNrxRv2kQUI13B32gf7MJSaddcPZPAdz8iuJKrVaC+
	bJ
X-Received: by 2002:a05:600c:1385:b0:480:6852:8d94 with SMTP id 5b1f17b1804b1-482db499781mr103571145e9.27.1769942653146;
        Sun, 01 Feb 2026 02:44:13 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:12 -0800 (PST)
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
Subject: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
Date: Sun,  1 Feb 2026 12:43:36 +0200
Message-ID: <20260201104343.79231-3-clamor95@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41849-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57A3AC57BC
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for accessing Embedded Controller of Asus Transformer devices.
This will be used by the EC MFD drivers.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/Kconfig        |   9 +
 drivers/misc/Makefile       |   1 +
 drivers/misc/asus-dockram.c | 327 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/asus-ec.h |  18 ++
 4 files changed, 355 insertions(+)
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
index 000000000000..d98dcf5ef2d4
--- /dev/null
+++ b/drivers/misc/asus-dockram.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC: DockRAM
+ */
+
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
+int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
+{
+	int rc;
+
+	memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
+	rc = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
+	if (rc < 0)
+		return rc;
+
+	if (buf[0] > DOCKRAM_ENTRY_SIZE) {
+		dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d\n",
+			DOCKRAM_ENTRY_BUFSIZE, buf, rc);
+		return -EPROTO;
+	}
+
+	dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
+		DOCKRAM_ENTRY_BUFSIZE, buf, rc);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asus_dockram_read);
+
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
+int asus_dockram_access_ctl(struct i2c_client *client,
+			    u64 *out, u64 mask, u64 xor)
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
+static ssize_t dockram_read(struct file *filp, struct kobject *kobj,
+			    const struct bin_attribute *attr,
+			    char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	unsigned int reg;
+	ssize_t n_read = 0;
+	char *data;
+	int ret;
+
+	reg = off / DOCKRAM_ENTRY_SIZE;
+	off %= DOCKRAM_ENTRY_SIZE;
+
+	if (!count)
+		return 0;
+
+	data = kmalloc(DOCKRAM_ENTRY_BUFSIZE, GFP_KERNEL);
+
+	while (reg < DOCKRAM_ENTRIES) {
+		unsigned int len = DOCKRAM_ENTRY_SIZE - off;
+
+		if (len > count)
+			len = count;
+
+		ret = asus_dockram_read(client, reg, data);
+		if (ret < 0) {
+			if (!n_read)
+				n_read = ret;
+			break;
+		}
+
+		memcpy(buf, data + 1 + off, len);
+		n_read += len;
+
+		if (len == count)
+			break;
+
+		count -= len;
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
+			     const char *buf, size_t count)
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
+static ssize_t dockram_write(struct file *filp, struct kobject *kobj,
+			     const struct bin_attribute *attr,
+			     char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	unsigned int reg;
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
+static ssize_t control_reg_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u64 val;
+	int ret;
+
+	ret = asus_dockram_access_ctl(client, &val, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%016llx\n", val);
+}
+
+static ssize_t control_reg_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u64 val;
+	int ret;
+
+	ret = kstrtoull(buf, 16, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = asus_dockram_access_ctl(client, NULL, ~0ull, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
+static DEVICE_ATTR_RW(control_reg);
+
+static struct attribute *dockram_attrs[] = {
+	&dev_attr_control_reg.attr,
+	NULL
+};
+
+static const struct bin_attribute *dockram_bin_attrs[] = {
+	&bin_attr_dockram,
+	NULL
+};
+
+static const struct attribute_group dockram_group = {
+	.attrs = dockram_attrs,
+	.bin_attrs = dockram_bin_attrs,
+};
+
+static int asus_dockram_probe(struct i2c_client *client)
+{
+	struct dockram_ec_data *priv;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return dev_err_probe(&client->dev, -ENXIO,
+			"I2C bus is missing required SMBus block mode support\n");
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, priv);
+	mutex_init(&priv->ctl_lock);
+
+	return devm_device_add_group(&client->dev, &dockram_group);
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
index 000000000000..bc4efa37f5ba
--- /dev/null
+++ b/include/linux/mfd/asus-ec.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MISC_ASUS_EC_H
+#define __MISC_ASUS_EC_H
+
+struct i2c_client;
+
+/* dockram comm */
+int asus_dockram_read(struct i2c_client *client, int reg, char *buf);
+int asus_dockram_write(struct i2c_client *client, int reg, const char *buf);
+int asus_dockram_access_ctl(struct i2c_client *client,
+			    u64 *out, u64 mask, u64 xor);
+struct i2c_client *devm_asus_dockram_get(struct device *parent);
+
+#define DOCKRAM_ENTRIES		0x100
+#define DOCKRAM_ENTRY_SIZE	32
+#define DOCKRAM_ENTRY_BUFSIZE	(DOCKRAM_ENTRY_SIZE + 1)
+
+#endif /* __MISC_ASUS_EC_H */
-- 
2.51.0


