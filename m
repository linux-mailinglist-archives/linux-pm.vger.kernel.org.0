Return-Path: <linux-pm+bounces-8937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93009039A0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 13:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714302894A5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCA17B42F;
	Tue, 11 Jun 2024 11:04:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D09E57E;
	Tue, 11 Jun 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103870; cv=none; b=r5iS8nszItDo3VGGhb/marrn+X+l5s4o0Cjwd72n3dbvzhFAaf4E/SkzcBjUhN7tqA+8gPbYpskNZE2EhNPcVhCITI3MhRyAsJxxwRCVreef0qbuf1MoDTgFueuZCe1DdM1AMG/WOpvM3jKAmCJuJhWuVnarvjcM0hF2zjL+6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103870; c=relaxed/simple;
	bh=nTjyHcloqBVtat3BBDCLMHBQnJXJUHTsYTG0WZ7SHBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7h3LjdfqIgNt3aSByWBXlUCB2pIP0lslR+fJCEiHGPQtCVWLBuxqkucU99ejJpHZ71z3Pm8Xvpg2oPf5c6He27apKsmleOCIoA6w9Z6bbBnytmLYlgU5ct+RYoLgqCLMDb251/J7czHTcljS8LQpU/5dJTzLBXkPV8YkJLI6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,229,1712588400"; 
   d="scan'208";a="211446402"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jun 2024 20:04:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.49])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E78E240078D0;
	Tue, 11 Jun 2024 20:04:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/6] regulator: core: Add helper for allow access to enable register
Date: Tue, 11 Jun 2024 12:03:59 +0100
Message-Id: <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function that allow regulator consumers to allow low-level
enable register access, in order to enable/disable regulator in atomic
context.

The use-case for RZ/G2L SoC is to enable VBUS selection register based
on vbus detection that happens in interrupt context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 Documentation/power/regulator/consumer.rst |  5 ++++
 drivers/regulator/core.c                   | 32 ++++++++++++++++++++++
 include/linux/regulator/consumer.h         |  8 ++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/power/regulator/consumer.rst
index 85c2bf5ac07e..b5502f4ffe46 100644
--- a/Documentation/power/regulator/consumer.rst
+++ b/Documentation/power/regulator/consumer.rst
@@ -227,3 +227,8 @@ directly written to the voltage selector register, use::
 
 	int regulator_list_hardware_vsel(struct regulator *regulator,
 					 unsigned selector);
+
+To access the hardware register for enabling/disabling the regulator, use::
+
+	int regulator_set_hardware_enable_register(struct regulator *regulator,
+						   bool enable);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5794f4e9dd52..19df42868bbd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3407,6 +3407,38 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
 
+/**
+ * regulator_set_hardware_enable_register - set the HW enable register
+ * @regulator: regulator source
+ * @enable: true for enable, false for disable
+ *
+ * Request that the regulator be enabled/disabled with the regulator output at
+ * the predefined voltage or current value.
+ *
+ * On success 0 is returned, otherwise a negative errno is returned.
+ */
+int regulator_set_hardware_enable_register(struct regulator *regulator,
+					   bool enable)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret = -EOPNOTSUPP;
+
+	if (!ops)
+		return ret;
+
+	if (enable) {
+		if (ops->enable == regulator_enable_regmap)
+			ret = ops->enable(rdev);
+	} else {
+		if (ops->disable == regulator_disable_regmap)
+			ret = rdev->desc->ops->disable(rdev);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_set_hardware_enable_register);
+
 /**
  * regulator_get_linear_step - return the voltage step size between VSEL values
  * @regulator: regulator source
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index e6f81fc1fb17..4aa5c57de052 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -250,6 +250,8 @@ int regulator_get_hardware_vsel_register(struct regulator *regulator,
 					 unsigned *vsel_mask);
 int regulator_list_hardware_vsel(struct regulator *regulator,
 				 unsigned selector);
+int regulator_set_hardware_enable_register(struct regulator *regulator,
+					   bool enable);
 
 /* regulator notifier block */
 int regulator_register_notifier(struct regulator *regulator,
@@ -571,6 +573,12 @@ static inline int regulator_list_hardware_vsel(struct regulator *regulator,
 	return -EOPNOTSUPP;
 }
 
+static inline int regulator_set_hardware_enable_register(struct regulator *regulator,
+							 bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb)
 {
-- 
2.25.1


