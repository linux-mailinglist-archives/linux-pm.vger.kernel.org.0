Return-Path: <linux-pm+bounces-7510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0A8BC3C8
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEB31F2200A
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916417580E;
	Sun,  5 May 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DlRuY0kr"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CF6DCF5;
	Sun,  5 May 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942631; cv=none; b=GIMyGHITKA0hIMdICA/3Y8LxNp2iRII0gVs8slli6YN4+f0qJJdJ/yEvAiCNUHlWM3ktO/Lvpo+B/4ZqoJ9dpHXWlNAvEtCsuHqu0HHF5uy9+INCgb69PpBREVTX5PeK3SxlR9CLm4QzjHf5kc6aooRpABqti0pGwFCe0TYyAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942631; c=relaxed/simple;
	bh=K/HTrL3dabNlERTmoHaPw5pHxjJqcQ+Gsw+F4RjFMP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJGwgBd0sYHu4WFT/fLl7Udx25RfulzNn10C0o1NPZXZd0rY2aNXSy6n9e51Gb1sgW2TNOn7QBWyuO4Bk42SjXLg8Q9KhDvEye7l3YLRVQCXQdd5NLjyQCxvE5UgxVHDiPs0jworj1Qd1GDV5QTLq0wTaRxPaI9cpXGxTledh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DlRuY0kr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714942625;
	bh=K/HTrL3dabNlERTmoHaPw5pHxjJqcQ+Gsw+F4RjFMP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DlRuY0kruFOFHwKvP0N13UyDTwS3AxmEGenfQA7/GcAiNW89WUOVe9y4kf7KGai9y
	 69enMtp0qr9LDruumOdm93IYltTXiHit3ydLwQ5hutz976WgppFbwJ6wz84Nd403yI
	 xIaD7mVR7Hh4+/ozxkbQi4WvGXrwTLsv7vjVDA4E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 05 May 2024 22:56:35 +0200
Subject: [PATCH 2/2] platform/chrome: cros_ec_framework_laptop: implement
 battery charge thresholds
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240505-cros_ec-framework-v1-2-402662d6276b@weissschuh.net>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
In-Reply-To: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Dustin L. Howett" <dustin@howett.net>, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714942624; l=4885;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K/HTrL3dabNlERTmoHaPw5pHxjJqcQ+Gsw+F4RjFMP0=;
 b=qclKK7GMQPcv8He6mcRlgvXNLOvtIzmaV2pNR/4ps1X7RD1Hy7U0/BTNHLezsHDjaCFfk2tMd
 Mg7ujhtt64/Ae0d6OGF/53YdoO/4E8BBylcqgUQ9bQZn2a2989pm/pJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make use of the non-standard EC command FW_EC_CMD_CHARGE_LIMIT_CONTROL
to implement the standard sysfs attribute
"charge_control_end_threshold".

Tested on a Framework 13 AMD with firmware version 3.05.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_framework_laptop.c | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_framework_laptop.c b/drivers/platform/chrome/cros_ec_framework_laptop.c
index 8a8bf039fa9c..2693a80df38f 100644
--- a/drivers/platform/chrome/cros_ec_framework_laptop.c
+++ b/drivers/platform/chrome/cros_ec_framework_laptop.c
@@ -4,18 +4,119 @@
  *
  *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
  */
+#include <acpi/battery.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME	"cros-ec-framework"
 
+#define FW_EC_CMD_CHARGE_LIMIT_CONTROL	0x3E03
+
+#define FW_EC_CHG_LIMIT_DISABLE		BIT(0)
+#define FW_EC_CHG_LIMIT_SET		BIT(1)
+#define FW_EC_CHG_LIMIT_GET		BIT(3)
+#define FW_EC_CHG_LIMIT_OVERRIDE	BIT(7)
+
 struct cros_fwk_priv {
 	struct cros_ec_device *cros_ec;
+	struct acpi_battery_hook battery_hook;
+	struct device_attribute end_threshold;
+};
+
+union cros_fwk_data {
+	struct {
+		u8 modes;
+		u8 max_percentage;
+		u8 min_percentage; /* not implemented in the EC */
+	} __packed req;
+	struct {
+		u8 max_percentage;
+		u8 min_percentage;
+	} __packed resp;
 };
 
+static int cros_fwk_send_cmd(struct cros_ec_device *cros_ec, union cros_fwk_data *arg)
+{
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		union cros_fwk_data data;
+	} __packed buf = {
+		.msg = {
+			.version = 0,
+			.command = FW_EC_CMD_CHARGE_LIMIT_CONTROL,
+			.insize  = sizeof(arg->resp),
+			.outsize = sizeof(arg->req),
+		},
+		.data.req = arg->req
+	};
+
+	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+	if (ret < 0)
+		return ret;
+
+	arg->resp = buf.data.resp;
+
+	return 0;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct cros_fwk_priv *priv = container_of(attr, struct cros_fwk_priv, end_threshold);
+	union cros_fwk_data arg = { };
+	int ret;
+
+	arg.req.modes = FW_EC_CHG_LIMIT_GET;
+	ret = cros_fwk_send_cmd(priv->cros_ec, &arg);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)arg.resp.max_percentage);
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct cros_fwk_priv *priv = container_of(attr, struct cros_fwk_priv, end_threshold);
+	union cros_fwk_data arg = { };
+	int ret, val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 1 || val > 100)
+		return -EINVAL;
+
+	arg.req.modes = FW_EC_CHG_LIMIT_SET;
+	arg.req.max_percentage = val;
+	ret = cros_fwk_send_cmd(priv->cros_ec, &arg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static int cros_fwk_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_fwk_priv *priv = container_of(hook, struct cros_fwk_priv, battery_hook);
+
+	return device_create_file(&battery->dev, &priv->end_threshold);
+}
+
+static int cros_fwk_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_fwk_priv *priv = container_of(hook, struct cros_fwk_priv, battery_hook);
+
+	device_remove_file(&battery->dev, &priv->end_threshold);
+
+	return 0;
+}
+
 static int cros_fwk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -28,6 +129,24 @@ static int cros_fwk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->cros_ec = cros_ec;
+	priv->end_threshold = (struct device_attribute)__ATTR_RW(charge_control_end_threshold);
+
+	priv->battery_hook.name = dev_name(dev),
+	priv->battery_hook.add_battery = cros_fwk_add_battery,
+	priv->battery_hook.remove_battery = cros_fwk_remove_battery,
+
+	battery_hook_register(&priv->battery_hook);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int cros_fwk_remove(struct platform_device *pdev)
+{
+	struct cros_fwk_priv *priv = platform_get_drvdata(pdev);
+
+	battery_hook_unregister(&priv->battery_hook);
 
 	platform_set_drvdata(pdev, priv);
 
@@ -42,6 +161,7 @@ static const struct platform_device_id cros_fwk_id[] = {
 static struct platform_driver cros_fwk_driver = {
 	.driver.name	= DRV_NAME,
 	.probe		= cros_fwk_probe,
+	.remove		= cros_fwk_remove,
 	.id_table	= cros_fwk_id,
 };
 

-- 
2.45.0


