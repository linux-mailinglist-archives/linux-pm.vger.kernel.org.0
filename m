Return-Path: <linux-pm+bounces-14909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C29899DB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 06:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62E41C21325
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167713D281;
	Mon, 30 Sep 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVUQH8uX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF54137C37
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671600; cv=none; b=k5gJbMtYGMWOWKcFowARgOKhpQ5XvpomQ8mQ3eMaYlHQjdasZwLgNaldaPhGZlcd647ArZ2K5Ft4f5MGuvI0H4/SGEKkz/TfTznNmlctqQie2Id5k5gxP2p5s4iAR6ESoJ8jTyed33P3dqmJsrWjDT49zEfwMRKU2doMRrl7QVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671600; c=relaxed/simple;
	bh=21VfkSUMY1oMGreP1Pvv10IY5H+7DgtDxgMk6RHpTMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4umN869C/BLDHsAChn8wAeHJiOGaInXaaQgIL8a7dHCslfsPktflEgeaHuLn8X/7nXROx5gk139RBkOWn0q9bboNHiswVAYI3vwOcKFJ+vTX7JrQGofhbgdiwuqDVX3WLBpA+k6L/yBVjy8idffARWAtrGxr3JhQwnBf8qzPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVUQH8uX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b9b35c7c7so66975ad.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727671597; x=1728276397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGyzeNaZ5V1M7D29TbD7ZSDpWWRPNFu98Dae5UWiJuc=;
        b=PVUQH8uXLMac7DNTcU7/76QeywArQBlXzrf5aIlsNnatfCeV/RyA/f94f/q17dqEGB
         WOE+BzXm4wmSXsixGAA8DEGJYvJ27CFIow0x4EErGGso3PIwoj5ZZI2YZCxhj3Ktbuog
         8U4GMUyJ879f/DdimckEXgaxVbQMolwF+Gapw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727671597; x=1728276397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGyzeNaZ5V1M7D29TbD7ZSDpWWRPNFu98Dae5UWiJuc=;
        b=XbE1zQBMEK7Hqi8pYNC+olTBx/RoyqgH/kdSxtKdAuyDcLBDFueSpY6WJp6fsm7ceH
         25m0Y0KIjb+SOHjPUX9ubqvsRA196BaVJx7qOBs5b535X6gAw4+GRBI2XqG6XfbuHt/l
         N4XJDFMX7U6l1y9f3h+o+clq9fzlED0WG1Lf0uTn0xxaHxhfb6WmztEFk6lswh7vgap9
         xxN9CS4EUZTe+/e3wzQhL8nsr4odJEWvZ4ZZgagGrV/gdNehA/mu95FzsnNLmFCxohOb
         asCgf03D+kFAcm1hkbEySRFjKJyhyubEF4X1R5bcFegkEDc1xye5kqKRTaraPbtFVP3K
         eoHA==
X-Forwarded-Encrypted: i=1; AJvYcCXuRnRydgf2hWHSRCr8Zm8DUEofy5IEa4Obxh6Bsxf5xV1HYoTFuu9jn4N7EsxiMt523e1s0YPfwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDPpsC2ngAO1+lwv0JQbmTQ7N9Gm6ZC2HMrC8Ia2i0Sqbi6gh
	/QlWYO73OUadkdejAqcAY9S913J0kDTstBMn1L1BMvBtJY5i7gLnKkefQnM5mw==
X-Google-Smtp-Source: AGHT+IFnMQTAEREEEWPYxSTTjCTMZ6EMTOWbZJ5tAa90pajm8FslwDubIQOj+gAHEiUnOmMNv6gA2Q==
X-Received: by 2002:a17:902:d549:b0:20b:54e5:e822 with SMTP id d9443c01a7336-20b54e5ea9amr97833325ad.21.1727671597400;
        Sun, 29 Sep 2024 21:46:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:659b:6caf:831b:3926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm46236925ad.123.2024.09.29.21.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 21:46:37 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v9 1/3] regulator: Add of_regulator_get_optional() for pure DT regulator lookup
Date: Mon, 30 Sep 2024 12:45:21 +0800
Message-ID: <20240930044525.2043884-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930044525.2043884-1-wenst@chromium.org>
References: <20240930044525.2043884-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The to-be-introduced I2C component prober needs to enable regulator
supplies (and toggle GPIO pins) for the various components it intends
to probe. To support this, a new "pure DT lookup" method for getting
regulator supplies is needed, since the device normally requesting
the supply won't get created until after the component is probed to
be available.

Add a new of_regulator_get_optional() function for this. This mirrors
the existing regulator_get_optional() function, but is OF-specific.
The underlying code that supports the existing regulator_get*()
functions has been reworked in previous patches to support this
specific case.

Also convert an existing usage of "dev && dev->of_node" to
"dev_of_node(dev)".

Link: https://lore.kernel.org/all/20231220203537.83479-2-jernej.skrabec@gmail.com/ [1]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes since v8:
- Reformat stub versions with `clang-format`

Changes since v7:
- Added stub version for !CONFIG_OF and !CONFIG_REGULATOR

Changes since v6:
- Changed reference [1] to Link: tag
- Rebased on top of commit 401d078eaf2e ("regulator: of: Refactor
  of_get_*regulator() to decrease indentation")
- Exported of_regulator_get_optional()
- Changed commit message to focus on "of_regulator_get_optional()"
- Dropped change to of_regulator_bulk_get_all()

Changes since v5:
- Used "dev_of_node(dev)" instead of "dev->of_node"
- Replaced "dev_printk" with "dev_printk()" in kerneldoc mentions
- Fixed kerneldoc "Return" section format for of_regulator_get_optional()
- Fix @np parameter name in of_regulator_dev_lookup() kerneldoc

Changes since v4:
- Restore platform-agnostic regulator consumer code to original state
- Move OF-specific regulator code to of_regulator.c (separate patch)
- Split _regulator_get() into three parts for reuse (separate patch)
- Add OF-specific _of_regulator_get() function
- Rename regulator_of_get_optional() to of_regulator_get_optional() for
  consistency
- Make of_regulator_get_optional static, as it is only used internally
- Convert of_regulator_bulk_get_all()

Changes since v3:
- New patch

# This is the commit message #2:

# fixup! regulator: Add of_regulator_get_optional() for pure DT regulator lookup
---
 drivers/regulator/core.c           |  4 +--
 drivers/regulator/internal.h       |  2 ++
 drivers/regulator/of_regulator.c   | 51 ++++++++++++++++++++++++++----
 include/linux/regulator/consumer.h | 17 ++++++++++
 4 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..d0b3879f2746 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1959,8 +1959,8 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	regulator_supply_alias(&dev, &supply);
 
 	/* first do a dt based lookup */
-	if (dev && dev->of_node) {
-		r = of_regulator_dev_lookup(dev, supply);
+	if (dev_of_node(dev)) {
+		r = of_regulator_dev_lookup(dev, dev_of_node(dev), supply);
 		if (!IS_ERR(r))
 			return r;
 		if (PTR_ERR(r) == -EPROBE_DEFER)
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 5b43f802468d..f62cacbbc729 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -67,6 +67,7 @@ static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 
 #ifdef CONFIG_OF
 struct regulator_dev *of_regulator_dev_lookup(struct device *dev,
+					      struct device_node *np,
 					      const char *supply);
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
@@ -82,6 +83,7 @@ bool of_check_coupling_data(struct regulator_dev *rdev);
 
 #else
 static inline struct regulator_dev *of_regulator_dev_lookup(struct device *dev,
+							    struct device_node *np,
 							    const char *supply)
 {
 	return ERR_PTR(-ENODEV);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3f490d81abc2..358c3ed791db 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -588,7 +588,8 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 /**
  * of_get_regulator - get a regulator device node based on supply name
- * @dev: Device pointer for the consumer (of regulator) device
+ * @dev: Device pointer for dev_printk() messages
+ * @node: Device node pointer for supply property lookup
  * @supply: regulator supply name
  *
  * Extract the regulator device node corresponding to the supply name.
@@ -596,15 +597,16 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
  * Return: Pointer to the &struct device_node corresponding to the regulator
  *	   if found, or %NULL if not found.
  */
-static struct device_node *of_get_regulator(struct device *dev, const char *supply)
+static struct device_node *of_get_regulator(struct device *dev, struct device_node *node,
+					    const char *supply)
 {
 	struct device_node *regnode = NULL;
 	char prop_name[64]; /* 64 is max size of property name */
 
-	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
+	dev_dbg(dev, "Looking up %s-supply from device node %pOF\n", supply, node);
 
 	snprintf(prop_name, 64, "%s-supply", supply);
-	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
+	regnode = of_parse_phandle(node, prop_name, 0);
 	if (regnode)
 		return regnode;
 
@@ -628,6 +630,7 @@ static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 /**
  * of_regulator_dev_lookup - lookup a regulator device with device tree only
  * @dev: Device pointer for regulator supply lookup.
+ * @np: Device node pointer for regulator supply lookup.
  * @supply: Supply name or regulator ID.
  *
  * Return: Pointer to the &struct regulator_dev on success, or ERR_PTR()
@@ -642,13 +645,13 @@ static struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
  * * -%ENODEV if lookup fails permanently.
  * * -%EPROBE_DEFER if lookup could succeed in the future.
  */
-struct regulator_dev *of_regulator_dev_lookup(struct device *dev,
+struct regulator_dev *of_regulator_dev_lookup(struct device *dev, struct device_node *np,
 					      const char *supply)
 {
 	struct regulator_dev *r;
 	struct device_node *node;
 
-	node = of_get_regulator(dev, supply);
+	node = of_get_regulator(dev, np, supply);
 	if (node) {
 		r = of_find_regulator_by_node(node);
 		of_node_put(node);
@@ -665,6 +668,42 @@ struct regulator_dev *of_regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static struct regulator *_of_regulator_get(struct device *dev, struct device_node *node,
+					   const char *id, enum regulator_get_type get_type)
+{
+	struct regulator_dev *r;
+	int ret;
+
+	ret = _regulator_get_common_check(dev, id, get_type);
+	if (ret)
+		return ERR_PTR(ret);
+
+	r = of_regulator_dev_lookup(dev, node, id);
+	return _regulator_get_common(r, dev, id, get_type);
+}
+
+/**
+ * of_regulator_get_optional - get optional regulator via device tree lookup
+ * @dev: device used for dev_printk() messages
+ * @node: device node for regulator "consumer"
+ * @id: Supply name
+ *
+ * Return: pointer to struct regulator corresponding to the regulator producer,
+ *	   or PTR_ERR() encoded error number.
+ *
+ * This is intended for use by consumers that want to get a regulator
+ * supply directly from a device node, and can and want to deal with
+ * absence of such supplies. This will _not_ consider supply aliases.
+ * See regulator_dev_lookup().
+ */
+struct regulator *of_regulator_get_optional(struct device *dev,
+					    struct device_node *node,
+					    const char *id)
+{
+	return _of_regulator_get(dev, node, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(of_regulator_get_optional);
+
 /*
  * Returns number of regulators coupled with rdev.
  */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index b9ce521910a0..37a5c4199563 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -168,6 +168,17 @@ int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
 
+#if IS_ENABLED(CONFIG_OF)
+struct regulator *__must_check of_regulator_get_optional(
+	struct device *dev, struct device_node *node, const char *id);
+#else
+static inline struct regulator *__must_check of_regulator_get_optional(
+	struct device *dev, struct device_node *node, const char *id)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 int regulator_register_supply_alias(struct device *dev, const char *id,
 				    struct device *alias_dev,
 				    const char *alias_id);
@@ -350,6 +361,12 @@ devm_regulator_get_optional(struct device *dev, const char *id)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct regulator *__must_check of_regulator_get_optional(
+	struct device *dev, struct device_node *node, const char *id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void regulator_put(struct regulator *regulator)
 {
 }
-- 
2.46.1.824.gd892dcdcdd-goog


