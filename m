Return-Path: <linux-pm+bounces-42991-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MItOI/T0m2nj+AMAu9opvQ
	(envelope-from <linux-pm+bounces-42991-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:34:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D61722DF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216F33048104
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E3E34C808;
	Mon, 23 Feb 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+E229Vw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5234A788
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828300; cv=none; b=Sxs1E8+pFBnUbwOGTAEWbg1FvhCxw8ymvgbeQOjh4ywDicpOxuLeuUh/NMIs/2g/GCq8Ua/O9BpSFJzy7mhvwbKHHgIQBwMK1pq+kW4JAfwgQ8KPNkGHRdrqaG7hOAq/ApiPUzI3au1XRKy5thdbLyWUwo1w7ms4HCAenZyPjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828300; c=relaxed/simple;
	bh=82wJ6CSHc8UFLw87bHXmNuqNeti15tSupjn/C1BIx6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2YTVQbXQVlIT4bqQunY+kun2Rx7ohUFcgSzvQJxmxlcKcwCoJfAX7FcYV3qke7CMcNAxTML9krxeJdZTUD5TGDZXcXvo4X/i654i0cTeS4X+E+u+nEtqjd/bS+YUY+esznO1M9urwpLpaP6zvcYRNt84zZQCNCzzayiGYGz2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+E229Vw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e62a3ee29so4134560e87.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 22:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828295; x=1772433095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxQXkdXlba88gXFDuag6mxU8wtp75fT8rqY0N+LZnb8=;
        b=S+E229VwxpV5gMT4aXWDmJqldktVYg3pP+SD7G4Kg1or6hfLsYGytUxd1Q2tJW7MK2
         cQNULcayUY5Ad2fmETTB1GEbNqntzx6LYJ80YpTFeAb9GHRkvtZkGhAn1U0/jo+Efq9o
         MHKnhsVJKY/NxsfHHda8GvyMgtdaQJS90RJHEBH6nN5aqoSuc9aKnk3ugiIEyhBkK0LS
         lf60KBncvg3VeYrbfMq//cRhR5/C/6UMX9z2sO7jpg+WhNYQV4bZsmBK0jQrlU/eAs4J
         mge1EBujZ2M1ixetdfBpbZ9Uu7Oll/VmkksQYDke9xGvZt7ekf1+uW2+22gWiKJv3Qm2
         xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828295; x=1772433095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxQXkdXlba88gXFDuag6mxU8wtp75fT8rqY0N+LZnb8=;
        b=Z6X6R3zOwB8Y5sMsZeyLyIOmaOapW8NuTFDVTvYCtpvF3ApMWxtlaRFmEeIglETo0s
         l94stfL3dGiFXtg3Tc7nC/HGoMJ9Mz8twQBC9aK/aGwIxhE5Ehk6T4ow9URVG96VApZv
         9YFqTbl4Gg71v6Ebe33x75Wo4+YryiEbnK1P0WquSz1CCDgT35/KP4WF4O67WHgMhZvY
         KTayBUlUaurnsckhmX1tMOSBYefBcknH+RGNUybbfeX9wjiJ2eacXsfsBKrS8dCCGgOL
         VeAaMqqOnS64VsLmRBK2znvSvCXL2g4Otiz1TfRGZXblYwWpUQK+33Kt7I8ExxePtCSR
         RvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX/IzKuPpFb1h4w2Z2H0mSemW74z5KmERocJNhqXsTNsKzX0T83C8/dh0fSlJk8Gzk4E/IkjqXMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHh1mhDJof/+oDCr9RsiQSKtOPbDE7amxdjKtOk27pCQ3/sNb
	WC9CPE+ksZfqcXUfK0A/uK3fBl1Moo4y/AqXqE5nblW0ytohLSbDcUaC
X-Gm-Gg: AZuq6aJ2wnAFV3kL158zOlkVv1pLDaToLAJHmVpskRLVT288XkGRfsyo7yOuMCqNmZD
	9nfOmJlQRgUobFQwhfM5q6v/bU0hVvg96hPcDrnIEz8FU07Z22W4aEqApL5+KUwmNarDC0siXTq
	RmMzKViKp4Komigzoq+pZSy6umN4sv9cTkJdAGjMjSFgaH50t8nVnuBEzgrabSgbgQRn/jZRVJp
	lgPW2t7jIfpO8GJ4C0kHDVVCtG+L0voTenooy+v3YQsoNw90YBc/SyyLk1447fbMwbq/pxj+DSL
	RlYAXz0f5FbDCVm5OqO0gIonUzSm+RMnWdEQqAHmFFr9Rj44D1z9TD7u1F6xezBW6HWxfBRs2Q3
	T9P+B4Qwpin8AHrEgrLh6jVISEJKNmf3I444afnJQ+dWKMDHjqnZQMW0mYzkyUOY3hrdrhmA9Hl
	Ap4w/FLIRVJXvg
X-Received: by 2002:a05:6512:1252:b0:5a0:c5af:c3ca with SMTP id 2adb3069b0e04-5a0ed884052mr2265825e87.17.1771828294586;
        Sun, 22 Feb 2026 22:31:34 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:34 -0800 (PST)
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
Subject: [PATCH v4 6/7] power: supply: Add driver for ASUS Transformer battery
Date: Mon, 23 Feb 2026 08:30:58 +0200
Message-ID: <20260223063059.11322-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063059.11322-1-clamor95@gmail.com>
References: <20260223063059.11322-1-clamor95@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-42991-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qmqm.pl:email,poll_work.work:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C3D61722DF
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Driver implements one battery cell per EC controller and supports reading
of battery status for ASUS Transformer's pad and mobile dock.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 .../supply/asus-transformer-ec-battery.c      | 272 ++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 81fadb0695a9..3c46b412632d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -122,6 +122,17 @@ config BATTERY_CHAGALL
 	  This driver can also be built as a module. If so, the module will be
 	  called chagall-battery.
 
+config BATTERY_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's battery driver"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here to enable support APM status emulation using
+	  battery class devices.
+
+	  This sub-driver supports battery cells found in Asus Transformer
+	  tablets and mobile docks and controlled by special embedded
+	  controller.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 41c400bbf022..aa5e6b05b018 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_POWER)	+= test_power.o
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
+obj-$(CONFIG_BATTERY_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-battery.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
diff --git a/drivers/power/supply/asus-transformer-ec-battery.c b/drivers/power/supply/asus-transformer-ec-battery.c
new file mode 100644
index 000000000000..aefcd3fed6fe
--- /dev/null
+++ b/drivers/power/supply/asus-transformer-ec-battery.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/unaligned.h>
+
+#define ASUSEC_BATTERY_DATA_FRESH_MSEC		5000
+
+#define ASUSEC_BATTERY_DISCHARGING		0x40
+#define ASUSEC_BATTERY_FULL_CHARGED		0x20
+#define ASUSEC_BATTERY_NOT_CHARGING		0x10
+
+#define TEMP_CELSIUS_OFFSET			2731
+
+struct asus_ec_battery_data {
+	const struct asusec_info *ec;
+	struct power_supply *battery;
+	struct power_supply_desc psy_desc;
+	struct delayed_work poll_work;
+	struct mutex battery_lock; /* for data refresh */
+	unsigned long batt_data_ts;
+	int last_state;
+	u8 batt_data[DOCKRAM_ENTRY_BUFSIZE];
+};
+
+static int asus_ec_battery_refresh(struct asus_ec_battery_data *priv)
+{
+	int ret = 0;
+
+	guard(mutex)(&priv->battery_lock);
+
+	if (time_before(jiffies, priv->batt_data_ts))
+		return ret;
+
+	ret = asus_dockram_read(priv->ec->dockram, ASUSEC_DOCKRAM_BATT_CTL,
+				priv->batt_data);
+	if (ret < 0)
+		return ret;
+
+	priv->batt_data_ts = jiffies +
+		msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC);
+
+	return ret;
+}
+
+static enum power_supply_property asus_ec_battery_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const unsigned int asus_ec_battery_prop_offs[] = {
+	[POWER_SUPPLY_PROP_STATUS] = 1,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = 3,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = 5,
+	[POWER_SUPPLY_PROP_TEMP] = 7,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = 9,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = 11,
+	[POWER_SUPPLY_PROP_CAPACITY] = 13,
+	[POWER_SUPPLY_PROP_CHARGE_NOW] = 15,
+	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW] = 17,
+	[POWER_SUPPLY_PROP_TIME_TO_FULL_NOW] = 19,
+};
+
+static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv,
+				     enum power_supply_property psp)
+{
+	int ret, offs;
+
+	if (psp >= ARRAY_SIZE(asus_ec_battery_prop_offs))
+		return -EINVAL;
+
+	offs = asus_ec_battery_prop_offs[psp];
+	if (!offs)
+		return -EINVAL;
+
+	ret = asus_ec_battery_refresh(priv);
+	if (ret < 0)
+		return ret;
+
+	if (offs >= priv->batt_data[0])
+		return -ENODATA;
+
+	return get_unaligned_le16(priv->batt_data + offs);
+}
+
+static int asus_ec_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct asus_ec_battery_data *priv = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+
+	default:
+		ret = asus_ec_battery_get_value(priv, psp);
+		if (ret < 0)
+			return ret;
+
+		val->intval = (s16)ret;
+
+		switch (psp) {
+		case POWER_SUPPLY_PROP_STATUS:
+			if (ret & ASUSEC_BATTERY_FULL_CHARGED)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else if (ret & ASUSEC_BATTERY_NOT_CHARGING)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else if (ret & ASUSEC_BATTERY_DISCHARGING)
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+
+		case POWER_SUPPLY_PROP_TEMP:
+			val->intval -= TEMP_CELSIUS_OFFSET;
+			break;
+
+		case POWER_SUPPLY_PROP_CHARGE_NOW:
+		case POWER_SUPPLY_PROP_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_CURRENT_MAX:
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+			val->intval *= 1000;
+			break;
+
+		case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+			val->intval *= 60;
+			break;
+
+		default:
+			break;
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
+static void asus_ec_battery_poll_work(struct work_struct *work)
+{
+	struct asus_ec_battery_data *priv =
+		container_of(work, struct asus_ec_battery_data, poll_work.work);
+	int state;
+
+	state = asus_ec_battery_get_value(priv, POWER_SUPPLY_PROP_STATUS);
+	if (state < 0)
+		return;
+
+	if (state & ASUSEC_BATTERY_FULL_CHARGED)
+		state = POWER_SUPPLY_STATUS_FULL;
+	else if (state & ASUSEC_BATTERY_DISCHARGING)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+	else
+		state = POWER_SUPPLY_STATUS_CHARGING;
+
+	if (priv->last_state != state) {
+		priv->last_state = state;
+		power_supply_changed(priv->battery);
+	}
+
+	/* continuously send uevent notification */
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+}
+
+static const struct power_supply_desc asus_ec_battery_desc = {
+	.name = "asus-ec-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = asus_ec_battery_properties,
+	.num_properties = ARRAY_SIZE(asus_ec_battery_properties),
+	.get_property = asus_ec_battery_get_property,
+	.external_power_changed = power_supply_changed,
+};
+
+static int asus_ec_battery_probe(struct platform_device *pdev)
+{
+	struct asus_ec_battery_data *priv;
+	struct device *dev = &pdev->dev;
+	struct power_supply_config cfg = { };
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	mutex_init(&priv->battery_lock);
+
+	priv->ec = cell_to_ec(pdev);
+	priv->batt_data_ts = jiffies - 1;
+	priv->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	cfg.fwnode = dev_fwnode(dev->parent);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_battery_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s-battery",
+					     priv->ec->name);
+
+	priv->battery = devm_power_supply_register(dev, &priv->psy_desc, &cfg);
+	if (IS_ERR(priv->battery))
+		return dev_err_probe(dev, PTR_ERR(priv->battery),
+				     "Failed to register power supply\n");
+
+	ret = devm_delayed_work_autocancel(dev, &priv->poll_work,
+					   asus_ec_battery_poll_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+
+	return 0;
+}
+
+static int __maybe_unused asus_ec_battery_suspend(struct device *dev)
+{
+	struct asus_ec_battery_data *priv = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&priv->poll_work);
+
+	return 0;
+}
+
+static int __maybe_unused asus_ec_battery_resume(struct device *dev)
+{
+	struct asus_ec_battery_data *priv = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(asus_ec_battery_pm_ops,
+			 asus_ec_battery_suspend, asus_ec_battery_resume);
+
+static struct platform_driver asus_ec_battery_driver = {
+	.driver = {
+		.name = "asus-transformer-ec-battery",
+		.pm = &asus_ec_battery_pm_ops,
+	},
+	.probe = asus_ec_battery_probe,
+};
+module_platform_driver(asus_ec_battery_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's battery driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


