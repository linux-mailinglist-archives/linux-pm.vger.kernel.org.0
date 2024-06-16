Return-Path: <linux-pm+bounces-9248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1B909D10
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF841C209F1
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2738187329;
	Sun, 16 Jun 2024 10:54:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FF49635;
	Sun, 16 Jun 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535266; cv=none; b=osATJoWdf2XaIWg0+FyVqC5tuKEplSp5t+UxQWMYftvlyIs/4rj1NlXcn1AZ8IyO8pawNbesV1ezvQDWn/MqIexpBcS8yEbyY0DBITsLYtIAXHRUk+xC4hww1mgN1ss9L4ctp5BAQc2c2NRXcrThOwJH7nZ93gbcTCYZQfcUR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535266; c=relaxed/simple;
	bh=7FP5SW/pQQFUtd/2FgZIG6Ih4VXyqX1czkFZfRsthsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyE+gpKRQjF/g5BxUx5irVOAhExX/hpqUr5LY8OdUvfN1L60AEJtrytPGxR5tDZvQaDwkbE8MHmalRxJUC8u2fzdMLAo8aRvWR3YDSQeCZ8PktGFULVubH4pfbrtNAagbybHOyGVxrVxdM7FCXb5P84F/C8QLye/WiC7S5LijqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,242,1712588400"; 
   d="scan'208";a="208104636"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jun 2024 19:54:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 566A841FEF55;
	Sun, 16 Jun 2024 19:54:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/6] regulator: core: Add helper for allow HW access to enable/disable regulator
Date: Sun, 16 Jun 2024 11:53:55 +0100
Message-ID: <20240616105402.45211-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616105402.45211-1-biju.das.jz@bp.renesas.com>
References: <20240616105402.45211-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function that allow regulator consumers to allow low-level
HW access, in order to enable/disable regulator in atomic context.

The use-case for RZ/G2L SoC is to enable VBUS selection register based
on vbus detection that happens in interrupt context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Updated commit header and description
 * Replaced regulator_set_hardware_enable_register()->regulator_hardware_enable()
 * Updated documentation to "must use of regulator_get_exclusive() for consumers"
 * Enforced exclusive access in regulator_hardware_enable().
 * Added generic support regulator_hardware_enable().
v3:
 * New patch.
---
 Documentation/power/regulator/consumer.rst |  6 +++++
 drivers/regulator/core.c                   | 28 ++++++++++++++++++++++
 include/linux/regulator/consumer.h         |  7 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/power/regulator/consumer.rst
index 85c2bf5ac07e..9d2416f63f6e 100644
--- a/Documentation/power/regulator/consumer.rst
+++ b/Documentation/power/regulator/consumer.rst
@@ -227,3 +227,9 @@ directly written to the voltage selector register, use::
 
 	int regulator_list_hardware_vsel(struct regulator *regulator,
 					 unsigned selector);
+
+To access the hardware for enabling/disabling the regulator, consumers must
+use regulator_get_exclusive(), as it can't work if there's more than one
+consumer. To enable/disable regulator use::
+
+	int regulator_hardware_enable(struct regulator *regulator, bool enable);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 844e9587a880..7674b7f2df14 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3408,6 +3408,34 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
 
+/**
+ * regulator_hardware_enable - access the HW for enable/disable regulator
+ * @regulator: regulator source
+ * @enable: true for enable, false for disable
+ *
+ * Request that the regulator be enabled/disabled with the regulator output at
+ * the predefined voltage or current value.
+ *
+ * On success 0 is returned, otherwise a negative errno is returned.
+ */
+int regulator_hardware_enable(struct regulator *regulator, bool enable)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret = -EOPNOTSUPP;
+
+	if (!rdev->exclusive || !ops || !ops->enable || !ops->disable)
+		return ret;
+
+	if (enable)
+		ret = ops->enable(rdev);
+	else
+		ret = ops->disable(rdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_hardware_enable);
+
 /**
  * regulator_get_linear_step - return the voltage step size between VSEL values
  * @regulator: regulator source
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index e6f81fc1fb17..d986ec13092e 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -250,6 +250,7 @@ int regulator_get_hardware_vsel_register(struct regulator *regulator,
 					 unsigned *vsel_mask);
 int regulator_list_hardware_vsel(struct regulator *regulator,
 				 unsigned selector);
+int regulator_hardware_enable(struct regulator *regulator, bool enable);
 
 /* regulator notifier block */
 int regulator_register_notifier(struct regulator *regulator,
@@ -571,6 +572,12 @@ static inline int regulator_list_hardware_vsel(struct regulator *regulator,
 	return -EOPNOTSUPP;
 }
 
+static inline int regulator_hardware_enable(struct regulator *regulator,
+					    bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb)
 {
-- 
2.43.0


