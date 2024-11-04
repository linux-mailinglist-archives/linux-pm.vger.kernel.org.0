Return-Path: <linux-pm+bounces-17009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE539BBED4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 21:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B291F22C19
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64D1F5849;
	Mon,  4 Nov 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzpLsOcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8951F583F
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752565; cv=none; b=ZepTK67eRTPxRdrU7QomuJ65fYIRexe8IRbN8n7vGYrGQJqFHfvhApQOa50k5mi4BtUmf2VW7/EGvcVf5lBnzZBMr6/+BQUnaL8v/BQscgvjGAXiPhg+6rmPatzQpxKpVVd7jgbpnAoBFJmv7cAwO1kbz8n8WByRC2nypx+l9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752565; c=relaxed/simple;
	bh=SNq5/zZUoR19vQeAU1UXhniDK6FAgLJjzgLwY24ifDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BX3+OJ1fz9+xMhJ0LD/FB/4z8smPNhZFfckwNfd4obCJext/j3i2avY4Lvgj3fxpcny1uQ1aNFyemPMp0upjesZnTDFAycCDGtSau1cEjI4ltBysHq5IN13MKCY5iI3VRGcvlqwtAmAKPL7BOSx7WSAY0U1Huac2k50bVcUbiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzpLsOcd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730752561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cVLEjSy3FWeZ2vaXcWNTXsbLKfM4wEH6iHi1Mgx6u8U=;
	b=dzpLsOcdy63OL+4YJUZDYE+ZUqhiqhiUVJokAmtEoIFPt02nanZ8XgNsvIDa8TgmW2ShyV
	kkqukjU3ZVqih8skyYgHbUhKC5q9jGmSuzyvunKGnmkBsS8r6r3tic7HKiYnkY+JJNuPF8
	WztPXlQautTh3LXz8Xk/Xn7bSQxivVs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-N0NNGcnCPU2NR3ddKp9kdA-1; Mon,
 04 Nov 2024 15:35:59 -0500
X-MC-Unique: N0NNGcnCPU2NR3ddKp9kdA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FD861955E70;
	Mon,  4 Nov 2024 20:35:58 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C737D19560A2;
	Mon,  4 Nov 2024 20:35:56 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel: bytcrc_pwrsrc: Optionally register a power_supply dev
Date: Mon,  4 Nov 2024 21:35:54 +0100
Message-ID: <20241104203555.61104-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On some Android tablets with Crystal Cove PMIC the DSDT lacks an ACPI AC
device to indicate whether a charger is plugged in or not.

Add support for registering a "crystal_cove_pwrsrc" power_supply class
device to indicate charger online status. This is made conditional on
a "linux,register-pwrsrc-power_supply" boolean device-property to avoid
registering a duplicate power_supply class device on devices where this
is already handled by an ACPI AC device.

Note the "linux,register-pwrsrc-power_supply" property is only used on
x86/ACPI (non devicetree) devs and the devicetree-bindings maintainers
have requested properties like these to not be added to the devicetree
bindings, so the new property is deliberately not added to any bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/bytcrc_pwrsrc.c | 76 +++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/bytcrc_pwrsrc.c b/drivers/platform/x86/intel/bytcrc_pwrsrc.c
index 418b71af27ff..98b5057d4c68 100644
--- a/drivers/platform/x86/intel/bytcrc_pwrsrc.c
+++ b/drivers/platform/x86/intel/bytcrc_pwrsrc.c
@@ -8,13 +8,21 @@
  * Copyright (C) 2013 Intel Corporation
  */
 
+#include <linux/bits.h>
 #include <linux/debugfs.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
+#define CRYSTALCOVE_PWRSRC_IRQ		0x03
 #define CRYSTALCOVE_SPWRSRC_REG		0x1E
+#define CRYSTALCOVE_SPWRSRC_USB		BIT(0)
+#define CRYSTALCOVE_SPWRSRC_DC		BIT(1)
+#define CRYSTALCOVE_SPWRSRC_BATTERY	BIT(2)
 #define CRYSTALCOVE_RESETSRC0_REG	0x20
 #define CRYSTALCOVE_RESETSRC1_REG	0x21
 #define CRYSTALCOVE_WAKESRC_REG		0x22
@@ -22,6 +30,7 @@
 struct crc_pwrsrc_data {
 	struct regmap *regmap;
 	struct dentry *debug_dentry;
+	struct power_supply *psy;
 	unsigned int resetsrc0;
 	unsigned int resetsrc1;
 	unsigned int wakesrc;
@@ -118,11 +127,57 @@ static int crc_pwrsrc_read_and_clear(struct crc_pwrsrc_data *data,
 	return regmap_write(data->regmap, reg, *val);
 }
 
+static irqreturn_t crc_pwrsrc_irq_handler(int irq, void *_data)
+{
+	struct crc_pwrsrc_data *data = _data;
+	unsigned int irq_mask;
+
+	if (regmap_read(data->regmap, CRYSTALCOVE_PWRSRC_IRQ, &irq_mask))
+		return IRQ_NONE;
+
+	regmap_write(data->regmap, CRYSTALCOVE_PWRSRC_IRQ, irq_mask);
+
+	power_supply_changed(data->psy);
+	return IRQ_HANDLED;
+}
+
+static int crc_pwrsrc_psy_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct crc_pwrsrc_data *data = power_supply_get_drvdata(psy);
+	unsigned int pwrsrc;
+	int ret;
+
+	if (psp != POWER_SUPPLY_PROP_ONLINE)
+		return -EINVAL;
+
+	ret = regmap_read(data->regmap, CRYSTALCOVE_SPWRSRC_REG, &pwrsrc);
+	if (ret)
+		return ret;
+
+	val->intval = !!(pwrsrc & (CRYSTALCOVE_SPWRSRC_USB |
+				   CRYSTALCOVE_SPWRSRC_DC));
+	return 0;
+}
+
+static const enum power_supply_property crc_pwrsrc_psy_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc crc_pwrsrc_psy_desc = {
+	.name = "crystal_cove_pwrsrc",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = crc_pwrsrc_psy_props,
+	.num_properties = ARRAY_SIZE(crc_pwrsrc_psy_props),
+	.get_property = crc_pwrsrc_psy_get_property,
+};
+
 static int crc_pwrsrc_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct crc_pwrsrc_data *data;
-	int ret;
+	int irq, ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -149,6 +204,25 @@ static int crc_pwrsrc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(pdev->dev.parent, "linux,register-pwrsrc-power_supply")) {
+		struct power_supply_config psy_cfg = { .drv_data = data };
+
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return dev_err_probe(&pdev->dev, irq, "getting IRQ\n");
+
+		data->psy = devm_power_supply_register(&pdev->dev, &crc_pwrsrc_psy_desc, &psy_cfg);
+		if (IS_ERR(data->psy))
+			return dev_err_probe(&pdev->dev, PTR_ERR(data->psy),
+					     "registering power-supply\n");
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						crc_pwrsrc_irq_handler,
+						IRQF_ONESHOT, KBUILD_MODNAME, data);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "requesting IRQ\n");
+	}
+
 	data->debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
 	debugfs_create_file("pwrsrc", 0444, data->debug_dentry, data, &pwrsrc_fops);
 	debugfs_create_file("resetsrc", 0444, data->debug_dentry, data, &resetsrc_fops);
-- 
2.47.0


