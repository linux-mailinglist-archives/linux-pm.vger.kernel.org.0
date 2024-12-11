Return-Path: <linux-pm+bounces-19025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F019ECE9F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAA216ABD9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516B1A00ED;
	Wed, 11 Dec 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gAgnOB50"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE9246354;
	Wed, 11 Dec 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927450; cv=none; b=a7tgH1DqYs6MsIYqTWt9IVuWBr2XdHryZD4XrbPS6a3k8ukReg/PxUHtUL18tdoQ15ju05JS0TAYCOw42D7BklTmF3OjPKvEBcOFDkm/X+fi5Z0tnwC2aKv38zxd0Gmjqp2vISQBO+/VZ2ofR2MJKngUwLBDwgLoDpXbKX2uL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927450; c=relaxed/simple;
	bh=RPNaj3dsQqqixWWfKZK6tJJD94rhCaCLzXqu9ZuDbM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2qAqSC+6g6J1ei3FZT0UhEziKctNqaYN4k2u/EV4/0FGKgRc1pAUMY+IksORnmjos+OQpAuzLOyof/t3MgbRYnIfeNNUSH+vTWC0YI1wwjUNyKBGeii6QJ6042/DK1LXlR7gHM41L5BGWU8V+1nezSobNJ+GEFzFJ/8Kgb9bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gAgnOB50; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733927446;
	bh=RPNaj3dsQqqixWWfKZK6tJJD94rhCaCLzXqu9ZuDbM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAgnOB50eFOt4u03wuvUQpNs6v4tNyjQzdPU81s1XDrU/DWrfypscP8n+lPBTdvl9
	 MTMRxjxSJaW2m+Wul5iOOVkQVVb2kW69Xu5pYOeAgMt/pxmvC8xK5v4DOqHHI/O5aM
	 XEVUgGG0q1Y5wQCOrSBzsW6gk8KL80WON6tKuZX4H32KqEJa5JXE9CBd4JWtccBpM5
	 DTK5kWMrW6KUwy7O9u3TlxjKxOKJD835uUvK6kpF7l74iF7SHrT4TxpDcCx4i1JWE5
	 hpPcucpdrQ3B+7LjjeOYJeWKr1cb3ldtrmOCRETOD3YfFp5hEy38eeY8kzw7fbd6qx
	 jEMSv49XBt+nw==
Received: from jupiter.universe (dyndsl-091-248-215-089.ewe-ip-backbone.de [91.248.215.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4692F17E377E;
	Wed, 11 Dec 2024 15:30:46 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 77DE848CC8B; Wed, 11 Dec 2024 15:30:45 +0100 (CET)
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
Subject: [PATCH v5 1/7] regulator: Add (devm_)of_regulator_get()
Date: Wed, 11 Dec 2024 15:26:46 +0100
Message-ID: <20241211143044.9550-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211143044.9550-1-sebastian.reichel@collabora.com>
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
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

Tested-by: Heiko Stuebner <heiko@sntech.de>
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


