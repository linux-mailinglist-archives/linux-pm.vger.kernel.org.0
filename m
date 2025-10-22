Return-Path: <linux-pm+bounces-36674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC48EBFE158
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 21:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 711BB4E8933
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA502F0C79;
	Wed, 22 Oct 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB9v311P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDE229B38;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162474; cv=none; b=EqRtR4eIDNe0c5PGabhB4xtQTWxa/KZQCEhHfoWdistKLP1576c+19epJ3HEi4GUnsOVkJhC8q+ds8VPQ2cl1slVy1oh0lU+h9HP77DnFOQEIvKo/QFuwdYClh6Y2ji4BBecCVgu9fBu/sv427RSBHU4ZL/0VU0kNWo9Mbl0EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162474; c=relaxed/simple;
	bh=TMB/vzDd+LTd/lCIfQUrdA02dtsXU52MRguMhkvQVb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsQMTMyyc5B/d7Ho52KC6LKbDGMik33QJKy8MT7jH7TxtPjRhz/xTkro8LphHUDYS3QnA+tNvn1fsDAH90K6XAxOIjzgsw2ppI33ETceXXYPP8mDvvoVvq2ptWLki+0jO/iwdzTqO1nohhNFjuTPXUcn+DUnqM4Uh6fQv5vKnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB9v311P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B069AC4CEFD;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761162473;
	bh=TMB/vzDd+LTd/lCIfQUrdA02dtsXU52MRguMhkvQVb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UB9v311PtmZ8PnnRfw/io6cgniNpJxDv/YprnnB2BwtlwPXX3TlMCSrxDSamfR6cw
	 YCTqkEdYHuBOLVqQtB+YO0DSIm3uOrLH2iJSx4nz+1rNgfrjWtr81Opa0HD/c/ZMXk
	 rH2GJm+MctyBJfVvyhoveOUH1/GPI3EoKn9k28XvejSAtOt6UEV8olKyTH4vh1Vmlf
	 QQqF7codQelr3AK17hZSXNCnqFHGfRZhKZ9vXHX6fLYweFr7hHVnfGxRi6gQ+cokgK
	 4lDdznv1b76jNvwuJvyFtqo8Oli6bVO6/hKTvi3xJZUNM6COT7IE/smAirZWsOhNyh
	 vRLmKhVbc1pYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB25CCF9E2;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 22 Oct 2025 21:47:48 +0200
Subject: [PATCH 2/2] power: supply: gpio-charger: add support for
 fast-charge timer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-charger-timer-v1-2-b557409400f2@liebherr.com>
References: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
In-Reply-To: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761162472; l=3484;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=p7cAOt/Kei0dwrov23S0iQygvZlwNI2XjIcLZTRyKRk=;
 b=VtUneGRFdgJjNlcSNgZ3ZTbrQI719MPCVYdI2APLJ8I8sP9jzrOg30kIpZiu5jYAmtRfXtPLt
 1F5WZKPNtyvDaVCKeZ3PDOUlT7XZqb98OCgrPpXizmH/QaQUuC1hfC1
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

On some devices like TIs BQ24081 battery charger it is possible to activate
or deactivate a fast-charge timer that provides a backup safety for charge
termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
for enabling/disabling the fast-charge timer via GPIO.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../ABI/testing/sysfs-class-power-gpio-charger     | 10 ++++++
 drivers/power/supply/gpio-charger.c                | 39 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-gpio-charger b/Documentation/ABI/testing/sysfs-class-power-gpio-charger
new file mode 100644
index 0000000000000000000000000000000000000000..95fb31ac4af3d5354bdc642c98baa7df267d150d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-gpio-charger
@@ -0,0 +1,10 @@
+What:		/sys/class/power_supply/<supply_name>/fast_charge_timer
+Date:		October 2025
+KernelVersion:	6.19.0
+Contact:	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+Description:
+		This entry enables or disables the timer in fast-charge mode.
+
+		Access: Write
+
+		Valid values: 0 (disabled) or 1 (enabled)
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 2504190eba82e69b79382320e67de6b8f3dedc77..52997205879406fae600171b070a0328657fa79b 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -32,6 +32,7 @@ struct gpio_charger {
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
 	struct gpio_desc *charge_status;
+	struct gpio_desc *timer;
 
 	struct gpio_descs *current_limit_gpios;
 	struct gpio_mapping *current_limit_map;
@@ -259,6 +260,36 @@ static int init_charge_current_limit(struct device *dev,
 	return 0;
 }
 
+static ssize_t fast_charge_timer_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct gpio_charger *gpio_charger = power_supply_get_drvdata(psy);
+	int ret;
+	bool en;
+
+	if (kstrtobool(buf, &en))
+		return -EINVAL;
+
+	if (!gpio_charger->timer)
+		return -ENODEV;
+
+	ret = gpiod_set_value_cansleep(gpio_charger->timer, en);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(fast_charge_timer);
+
+static struct attribute *gpio_charger_attrs[] = {
+	&dev_attr_fast_charge_timer.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(gpio_charger);
+
 /*
  * The entries will be overwritten by driver's probe routine depending
  * on the available features. This list ensures, that the array is big
@@ -308,6 +339,13 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		num_props++;
 	}
 
+	gpio_charger->timer = devm_gpiod_get_optional(dev, "fast-charge-timer",
+						      GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio_charger->timer)) {
+		return dev_err_probe(dev, PTR_ERR(gpio_charger->timer),
+				     "error getting fast-charge timer GPIO descriptor\n");
+	}
+
 	charge_status = devm_gpiod_get_optional(dev, "charge-status", GPIOD_IN);
 	if (IS_ERR(charge_status))
 		return PTR_ERR(charge_status);
@@ -336,6 +374,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = gpio_charger;
+	psy_cfg.attr_grp = gpio_charger_groups;
 
 	if (pdata) {
 		charger_desc->name = pdata->name;

-- 
2.39.5



