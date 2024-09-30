Return-Path: <linux-pm+bounces-14910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC99899DE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 06:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01A3282F00
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 04:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B21442F4;
	Mon, 30 Sep 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfkYn4Cz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181881428E0
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727671602; cv=none; b=CWoQ+Eim195aura7kanf3e2I8bGCm4QT3pC1xdqMp/DEfhN8k6hZRKXzOacGQGTTe+PvnRT9O6UOpPfhK/tGB5G2YDaEDQFIlSLXFCN/LQg/O/WPZUm8R3fDT18vGl4ATRHUObrbCiCS1o5z2VDT8vpMIszahxS7U1yAbWuzQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727671602; c=relaxed/simple;
	bh=iU2BUvCu4TbFwglherQKyk9DI310iRdnxE6w2tUlDhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkTo2P1ojdQRR/Bp1qmdSi2gDmtJv463kvpy9L7bQeqqM1qkaQ9je2aEG9oRttdZ1bFPynp/2wRg53BF4AF8DQAQZhAFvRkj1LrCrX23JD1/cS+QsuP1HmHuRGlEQMnXE3gGKK1AXTtGvXBn9KgswDuTfP/k1HZhws5JgXgXI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JfkYn4Cz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b5fb2e89dso8057415ad.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727671600; x=1728276400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUlZdNbsNhX6XY/barzAaC32mkUj4VQXnCI2Cvk8mw8=;
        b=JfkYn4Czpacrk2tmoTaXwmqAAXxgf9jFaLwZHEK2nB4oJzAbhsn46G4+R7vaoQAQjs
         07fwbgmPyRJ7gpq24t+xqNxUYcvvm1DYVvjIH/lArbKqOvmo22PuN+Ot6Bfgn5T6PSaH
         Sgmwlu67qVA4bepJMEJj+IdRgnWTXCVcl6GXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727671600; x=1728276400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUlZdNbsNhX6XY/barzAaC32mkUj4VQXnCI2Cvk8mw8=;
        b=nM6wwJynKVCgK0iYmcPOH6mt5XWhU8swflYJm5lqb9mvU7cFMXZcuhnxE5auIxX7ih
         GCVAW+e7dsQwC3t6qEeSE1C9RmJcMSxnd9SnscUQD2l3CosJ5WRTj6viMJ5hZmVTNdV1
         XZANFT2ZZsnv7H/7brqsh8wz6+1FGJMrNJs5lxqGex7IB17pseRCr0ReInoaBkrr1QNP
         J5DhhHt0nLAfMUfn+5w119jSlxV7XCf1ao+2WA9sScW7QgZcdxEPO9QtzyQlEGjSN4BF
         oU1AY4hHwYlufMJFv6vVgWQfY4rBRloolWT1C5bfCtVhNh4mjc8tPuaHE0nRi23eJHgN
         NFaA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/mVgQkZppR5C7i7/z/8CN5tWAz3qnDJgncM2m7P/hd3OQFiO8t4fcm9Kj1SU5l4Bz22Om6HHPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6MGPgm8KpaJtNiAbfh/rGJEMjqpUqyusRg2Db8Qs24EXyhdk
	eQFAYDohULCF+LjAQQbW0vUVqah8Okn3xNuqiA1GfJiUWF2vDyYtK0QYKp0+kg==
X-Google-Smtp-Source: AGHT+IGiPaUQ16Xnuae4NQju8BfwvozQQ66u5aiOHauwEzMnexKXZpeJLU+M8Oth2gtCms9fyjV8aQ==
X-Received: by 2002:a17:902:ea0e:b0:20b:8c13:5307 with SMTP id d9443c01a7336-20b8c1357fcmr27571105ad.33.1727671600403;
        Sun, 29 Sep 2024 21:46:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:659b:6caf:831b:3926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm46236925ad.123.2024.09.29.21.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 21:46:40 -0700 (PDT)
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
Subject: [PATCH v9 2/3] regulator: Add devres version of of_regulator_get_optional()
Date: Mon, 30 Sep 2024 12:45:22 +0800
Message-ID: <20240930044525.2043884-3-wenst@chromium.org>
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

There are existing uses for a devres version of of_regulator_get_optional()
in power domain drivers. On MediaTek platforms, power domains may have
regulator supplies tied to them. The driver currently tries to use
devm_regulator_get() to not have to manage the lifecycle, but ends up
doing it in a very hacky way by replacing the device node of the power
domain controller device to the device node of the power domain that is
currently being registered, getting the supply, and reverting the device
node.

Provide a better API so that the hack can be replaced.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v8:
- Moved OF-specific devres version to of_regulator.c
- Made _of_regulator_get() static again
- Made devm_regulator_release non-static
- Reformated stub versions with `clang-format`

Changes since v7:
- New patch
---
 drivers/regulator/devres.c         |  2 +-
 drivers/regulator/internal.h       |  2 ++
 drivers/regulator/of_regulator.c   | 37 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 14 +++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 1b893cdd1aad..569a80963a86 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -14,7 +14,7 @@
 
 #include "internal.h"
 
-static void devm_regulator_release(struct device *dev, void *res)
+void devm_regulator_release(struct device *dev, void *res)
 {
 	regulator_put(*(struct regulator **)res);
 }
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index f62cacbbc729..b1b4277aaf90 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -131,4 +131,6 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
 int _regulator_bulk_get(struct device *dev, int num_consumers,
 			struct regulator_bulk_data *consumers, enum regulator_get_type get_type);
+
+void devm_regulator_release(struct device *dev, void *res);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 358c3ed791db..9096d8f494a7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -704,6 +704,43 @@ struct regulator *of_regulator_get_optional(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(of_regulator_get_optional);
 
+static struct regulator *_devm_of_regulator_get(struct device *dev, struct device_node *node,
+						const char *id, int get_type)
+{
+	struct regulator **ptr, *regulator;
+
+	ptr = devres_alloc(devm_regulator_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	regulator = _of_regulator_get(dev, node, id, get_type);
+	if (!IS_ERR(regulator)) {
+		*ptr = regulator;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return regulator;
+}
+
+/**
+ * devm_of_regulator_get_optional - Resource managed of_regulator_get_optional()
+ * @dev: device used for dev_printk() messages and resource lifetime management
+ * @node: device node for regulator "consumer"
+ * @id:  supply name or regulator ID.
+ *
+ * Managed regulator_get_optional(). Regulators returned from this
+ * function are automatically regulator_put() on driver detach. See
+ * of_regulator_get_optional() for more information.
+ */
+struct regulator *devm_of_regulator_get_optional(struct device *dev, struct device_node *node,
+						 const char *id)
+{
+	return _devm_of_regulator_get(dev, node, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_of_regulator_get_optional);
+
 /*
  * Returns number of regulators coupled with rdev.
  */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 37a5c4199563..582b82a104e2 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -171,12 +171,20 @@ void devm_regulator_put(struct regulator *regulator);
 #if IS_ENABLED(CONFIG_OF)
 struct regulator *__must_check of_regulator_get_optional(
 	struct device *dev, struct device_node *node, const char *id);
+struct regulator *__must_check devm_of_regulator_get_optional(
+	struct device *dev, struct device_node *node, const char *id);
 #else
 static inline struct regulator *__must_check of_regulator_get_optional(
 	struct device *dev, struct device_node *node, const char *id)
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct regulator *__must_check devm_of_regulator_get_optional(
+	struct device *dev, struct device_node *node, const char *id)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 int regulator_register_supply_alias(struct device *dev, const char *id,
@@ -367,6 +375,12 @@ static inline struct regulator *__must_check of_regulator_get_optional(
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct regulator *__must_check devm_of_regulator_get_optional(
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


