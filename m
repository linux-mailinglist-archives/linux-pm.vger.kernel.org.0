Return-Path: <linux-pm+bounces-18929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259129EB792
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5890163433
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00D23D417;
	Tue, 10 Dec 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SW/wKDO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31823A58F;
	Tue, 10 Dec 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850629; cv=none; b=Bcx99mi/zA0x5SHltbl1aZALtCiIU3tm7WG0EreiPxP1Ee8AVWhPREXxbzv64S+70ou4vVPd+ENPvS9mPYoVsiVanQdaV9l5XGU7f90xY9W/J1ZzYfAx7DUoXY97kHGWZ+XYu/TKr90mRaCLinNjeYqAQhpvJMH0KO2XaW+AYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850629; c=relaxed/simple;
	bh=O5swrGRgXY7L7+HtzQsEkzO+Z95c/1GCTlkAs6oxEew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl1FeJg1x12IxjO9Bo5LQP8MqkwyPJMzKlgOlGZ6vEVy5BDTyv4R1raeOAueUOBLNVkjTZwb4cyNiR4RD2sAQWzyxdMoUnvkh8rHU9wsgI8sTMBP6jDIe1KogY9dDQbX1oeJ/ciCxkwtOG2Aw1FWbRp4yDi+hGsxGjju6ig8TTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SW/wKDO0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733850625;
	bh=O5swrGRgXY7L7+HtzQsEkzO+Z95c/1GCTlkAs6oxEew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SW/wKDO0tnLpo1jojfF0BkUouqwgtHaKZb485qFSpXKZ1F7Hn1K462/uNWKjBcH5e
	 5XzF2pHOxeo++3An3Y/mA3uF1AoRX1LXuy6J4Ax5Q+EfRtPBAIAYVIsn8n+wJ/ZFl8
	 dAN/7kUlXmET66DCPNkxW4jk+wPMfgJ6R2MgU5z43IxfSgNofqKdweZt0o8JR2LrZ0
	 2CirWwNYdInMiHcsA+WB7mCrOSbbi8ZxSENZ35LnAX0UkCxB+d3ilBWrS6T471vXV5
	 inaDE0Rwaw/zQVIWMCjyT3dl9vXrrHohKh/v0eC8emIqEO2AfW/JLFY+bqI0ocDsCK
	 rBtb2fU+A68Zg==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 23FE717E37C2;
	Tue, 10 Dec 2024 18:10:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A51AA48CC3B; Tue, 10 Dec 2024 18:10:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	=?UTF-8?q?Adri=C3=A1n=20Mart=C3=ADnez=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v4 1/7] regulator: Add (devm_)of_regulator_get()
Date: Tue, 10 Dec 2024 18:06:41 +0100
Message-ID: <20241210171023.141162-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210171023.141162-1-sebastian.reichel@collabora.com>
References: <20241210171023.141162-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip power-domain controller also plans to make use of
per-domain regulators similar to the MediaTek power-domain controller.
Since existing DTs are missing the regulator information, the kernel
should fallback to the automatically created dummy regulator if
necessary. Thus the version without the _optional suffix is needed.

The Rockchip driver plans to use the managed version, but to be
consistent with existing code the unmanaged version is added at the
same time.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/devres.c         | 17 +++++++++++++++++
 drivers/regulator/of_regulator.c   | 21 +++++++++++++++++++++
 include/linux/regulator/consumer.h |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 36164aec30e8..a3a3ccc711fc 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -771,6 +771,23 @@ static struct regulator *_devm_of_regulator_get(struct device *dev, struct devic
 	return regulator;
 }
 
+/**
+ * devm_of_regulator_get - Resource managed of_regulator_get()
+ * @dev: device used for dev_printk() messages and resource lifetime management
+ * @node: device node for regulator "consumer"
+ * @id:  supply name or regulator ID.
+ *
+ * Managed of_regulator_get(). Regulators returned from this
+ * function are automatically regulator_put() on driver detach. See
+ * of_regulator_get() for more information.
+ */
+struct regulator *devm_of_regulator_get(struct device *dev, struct device_node *node,
+						 const char *id)
+{
+	return _devm_of_regulator_get(dev, node, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_of_regulator_get);
+
 /**
  * devm_of_regulator_get_optional - Resource managed of_regulator_get_optional()
  * @dev: device used for dev_printk() messages and resource lifetime management
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3d85762beda6..31a5bacd99b4 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -682,6 +682,27 @@ struct regulator *_of_regulator_get(struct device *dev, struct device_node *node
 	return _regulator_get_common(r, dev, id, get_type);
 }
 
+/**
+ * of_regulator_get - get regulator via device tree lookup
+ * @dev: device used for dev_printk() messages
+ * @node: device node for regulator "consumer"
+ * @id: Supply name
+ *
+ * Return: pointer to struct regulator corresponding to the regulator producer,
+ *	   or PTR_ERR() encoded error number.
+ *
+ * This is intended for use by consumers that want to get a regulator
+ * supply directly from a device node. This will _not_ consider supply
+ * aliases. See regulator_dev_lookup().
+ */
+struct regulator *of_regulator_get(struct device *dev,
+					    struct device_node *node,
+					    const char *id)
+{
+	return _of_regulator_get(dev, node, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(of_regulator_get);
+
 /**
  * of_regulator_get_optional - get optional regulator via device tree lookup
  * @dev: device used for dev_printk() messages
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 8c3c372ad735..5903ae7444ae 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -169,6 +169,12 @@ void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
 
 #if IS_ENABLED(CONFIG_OF)
+struct regulator *__must_check of_regulator_get(struct device *dev,
+						struct device_node *node,
+						const char *id);
+struct regulator *__must_check devm_of_regulator_get(struct device *dev,
+						     struct device_node *node,
+						     const char *id);
 struct regulator *__must_check of_regulator_get_optional(struct device *dev,
 							 struct device_node *node,
 							 const char *id);
-- 
2.45.2


