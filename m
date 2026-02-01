Return-Path: <linux-pm+bounces-41856-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLeVCg0vf2kglQIAu9opvQ
	(envelope-from <linux-pm+bounces-41856-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:46:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C232C5899
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73B5F301932C
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C01332EBC;
	Sun,  1 Feb 2026 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWihEKQ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B66324B24
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942665; cv=none; b=QmKxlSdC1+smM+oEXjYITbuOUvM1lKdCy3Jdg/kKklKLE9DaXYW4nX58Ntt2aBg3Q9mC9tfd+8XDn5R2Gws6JkDZdXBPP+XpCwuYvDNsfCfOJR09MnjMATB4DJeWPqpJXeQIEjJfB8n381Ezl3/bC2Ay9QSlXVMzmJm5bLF+yCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942665; c=relaxed/simple;
	bh=PlyybFsZsqNmpXRB8/13kR5LEafXRlgj3o35Wb5kkYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sc1Y4kEyiVnwWrlqnozeFCwTAsBKAqc0mZlveZspR/7R25ToYU0bczAgLWAQVkqW8eLZA9AZDvtcYgBd4b1CyWl0mcRbQIMRgatYBKIsOXEn/x7jKDZsfk5TydAbxGRBKBwcN3dTFXl1KK7ufTSUXf4NXcZWo75KH8+D5f4D5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWihEKQ2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so37251815e9.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942661; x=1770547461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPFQoidqkErVeAGy+/qpK+osZp6nImPKthWl2DazuOo=;
        b=jWihEKQ2bsASXKl0aiLsW57Pptyzf4nhzmR4/zqv1XuoodLOaIWYviYFxRzkV/pbvs
         XuAWUr9jqFw8IS3zU049ug6U39O2OmzMVKoJulVvJT/+IBkgCSKRwPkcrViVr0R2/4Rn
         CLRPl/VhvcQaSLe3rd8r1EYZL0OVmcciGJYpQbgwhha8T8oDKMepnjC5zWRxnFR0ITcP
         WyvK1bOtDDl+xictmmN5m+d7V5XhIfkfSWNFFs9pYJcFHd/EHlO57H0Fg1rKEYwND1kT
         /RI+SWv1MEhjFO+r9MDp4uASac7+Cj7QO8WS6lfVr7tj2Rqi9PO8zq8ERkWONSj6QJ5s
         WIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942661; x=1770547461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPFQoidqkErVeAGy+/qpK+osZp6nImPKthWl2DazuOo=;
        b=v6o1S9FUD935e6V4YriW7Z4WQk4zqbdjP62n7cQNSUJTaVpBMtxMdmZ0++IszIDI75
         erCjhbaU771lHQZqjLmp2jW1eVwBB8haQLEsd2Q3n+YBXlox15E5aAVAB0waT8JEAmri
         AywhTW6RLlLrR4sz8TNsZuaVkfiPkYng/NuMzewxyjqyNLN+AyDCNRFvuECf33HwneAL
         qUKg2+au7VFebej5c7XxIBVuAe9cPQkojqOjN+oCvrMLwNaPo8nIXhxwakaWQXICIY5G
         1MWP5ZY1/Y5DkdPa/eaYhsAeA3oyMJyqz4AEQx9r4nI7nHxhSnkBF+vXFvfecudsxBVG
         PaGg==
X-Forwarded-Encrypted: i=1; AJvYcCWAQ/yVDxnqfOTCEfpyuAWn161y5AylLHuUoIKg1Elck5LjqpH8fqcwxsvqB4m6Thg+a5O/RjRfcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOav8ET5/7BP8IV09T+1zXnGOM8pBO+JLUMvuPUCRDhZ8CE34
	EFtXHiCrnzoi0CTxPWRZ5zX9ZJQqxvUV5bTGwgl++R5xWigQ5IAJKgcY
X-Gm-Gg: AZuq6aKCY3ypiU2CJqBqXzoabnQubg22OU79nZR/2RkbWDTkTTvY9hzY36YCYGbJM7k
	ySGdpuT/Km3yXHrE1SddhODB7Fhln2bUTdybwSaBPI128XwafJxcHUruFXIOnLmJQ4nVcsJf2W/
	xuS3xCvLK0qRqxqKsvvzrDFm6UGfjkC+K4vJWGiF/bUx+NHXSVUUl0nlzyI/9ZO4e5cve4LjvyX
	X4zVYsS9+JQKotcnsppRbejCwwMsvYEoxAGotu81KVmMxyIZzi02+pOu4YKHnJjK7mpe/Et89p2
	se246k0Ra4K2Sdp4gtVfsyLwHwYgmkOaVMKxUuSDYpog/AVUTiK/IEVgKBNK6HRzwCDwi0CXfq1
	ykeYR1VbMJ1KK+noP73/NumlkIQunQI6MHX3IDGmtyplNZZ0AyKFEYPJ+H/2+8qYSaQ+n1/wOly
	7U
X-Received: by 2002:a05:600c:3552:b0:47e:e970:cf28 with SMTP id 5b1f17b1804b1-482db4a3834mr93508735e9.30.1769942661102;
        Sun, 01 Feb 2026 02:44:21 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:20 -0800 (PST)
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
Subject: [PATCH v1 9/9] power: supply: Add charger driver for Asus Transformers
Date: Sun,  1 Feb 2026 12:43:43 +0200
Message-ID: <20260201104343.79231-10-clamor95@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41856-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qmqm.pl:email]
X-Rspamd-Queue-Id: 4C232C5899
X-Rspamd-Action: no action

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for charger detection capabilities found in the embedded
controller of ASUS Transformer devices.

Suggested-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Suggested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/Kconfig           |  11 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/asus-ec-charger.c | 205 +++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/power/supply/asus-ec-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index bcf6a23858be..6d7e115f5d2f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -133,6 +133,17 @@ config BATTERY_ASUSEC
 	  tablets and mobile docks and controlled by special embedded
 	  controller.
 
+config CHARGER_ASUSEC
+	tristate "Asus Transformer's charger driver"
+	depends on MFD_ASUSEC
+	help
+	  Say Y here to enable support AC plug detection on Asus Transformer
+	  Dock.
+
+	  This sub-driver supports charger detection mechanism found in Asus
+	  Transformer tablets and mobile docks and controlled by special
+	  embedded controller.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 0a2cbfa96ed9..b93848227f50 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_ASUSEC)	+= asus-ec-battery.o
+obj-$(CONFIG_CHARGER_ASUSEC)	+= asus-ec-charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
diff --git a/drivers/power/supply/asus-ec-charger.c b/drivers/power/supply/asus-ec-charger.c
new file mode 100644
index 000000000000..9d98e5014915
--- /dev/null
+++ b/drivers/power/supply/asus-ec-charger.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC driver - charger monitoring
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+
+struct asus_ec_charger_data {
+	struct notifier_block nb;
+	const struct asusec_info *ec;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+};
+
+static enum power_supply_property asus_ec_charger_properties[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+static int asus_ec_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+	enum power_supply_usb_type psu;
+	int ret;
+	u64 ctl;
+
+	ret = asus_ec_get_ctl(priv->ec, &ctl);
+	if (ret)
+		return ret;
+
+	switch (ctl & (ASUSEC_CTL_FULL_POWER_SOURCE | ASUSEC_CTL_DIRECT_POWER_SOURCE)) {
+	case ASUSEC_CTL_FULL_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_CDP;	// DOCK
+		break;
+	case ASUSEC_CTL_DIRECT_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_SDP;	// USB
+		break;
+	case 0:
+		psu = POWER_SUPPLY_USB_TYPE_UNKNOWN;	// no power source connected
+		break;
+	default:
+		psu = POWER_SUPPLY_USB_TYPE_ACA;	// power adapter
+		break;
+	}
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = psu != POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return 0;
+
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = psu;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (ctl & ASUSEC_CTL_TEST_DISCHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		else if (ctl & ASUSEC_CTL_USB_CHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return 0;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = priv->ec->model;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch ((enum power_supply_charge_behaviour)val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			return asus_ec_update_ctl(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_USB_CHARGE);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			return asus_ec_clear_ctl_bits(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+			return asus_ec_update_ctl(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_TEST_DISCHARGE);
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct power_supply_desc asus_ec_charger_desc = {
+	.name = "asus-ec-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
+	.properties = asus_ec_charger_properties,
+	.num_properties = ARRAY_SIZE(asus_ec_charger_properties),
+	.get_property = asus_ec_charger_get_property,
+	.set_property = asus_ec_charger_set_property,
+	.property_is_writeable = asus_ec_charger_property_is_writeable,
+	.no_thermal = true,
+};
+
+static int asus_ec_charger_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct asus_ec_charger_data *priv =
+		container_of(nb, struct asus_ec_charger_data, nb);
+
+	switch (action) {
+	case ASUSEC_SMI_ACTION(POWER_NOTIFY):
+	case ASUSEC_SMI_ACTION(ADAPTER_EVENT):
+		power_supply_changed(priv->psy);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int asus_ec_charger_probe(struct platform_device *pdev)
+{
+	struct asus_ec_charger_data *priv;
+	struct power_supply_config cfg = { };
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = cell_to_ec(pdev);
+
+	cfg.fwnode = dev_fwnode(&pdev->dev);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_charger_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-charger",
+					     priv->ec->name);
+
+	priv->psy = devm_power_supply_register(&pdev->dev, &priv->psy_desc, &cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->psy),
+				     "Failed to register power supply\n");
+
+	priv->nb.notifier_call = asus_ec_charger_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static const struct of_device_id asus_ec_charger_match[] = {
+	{ .compatible = "asus,ec-charger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_charger_match);
+
+static struct platform_driver asus_ec_charger_driver = {
+	.driver = {
+		.name = "asus-ec-charger",
+		.of_match_table = asus_ec_charger_match,
+	},
+	.probe = asus_ec_charger_probe,
+};
+module_platform_driver(asus_ec_charger_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer Pad battery charger driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


