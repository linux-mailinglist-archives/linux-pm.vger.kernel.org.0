Return-Path: <linux-pm+bounces-2381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FF832A70
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603C9B22D7B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C8954FB6;
	Fri, 19 Jan 2024 13:25:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68C54BFF
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670745; cv=none; b=kY5jlQqd9/NV1rSigXqIcWXoP6xbUVP9lFgsJbkmSJD3QlZTTi5Rrn/7Fd9BTV+ZxwSapQLK1VzICNYx9jlT4Ewesw0LPVaPTJt+feHGvcjKmXcsutyYFMCH7x+BgWBAxNlL+fAyY+XV/IhaY+iL5Mm8vgSNVJxPEn24Dswceyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670745; c=relaxed/simple;
	bh=XRisp6Vk9LcyDYqrO7hm1pl+pjDkrGL7bL4CcMKtXaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWKRq2dQp9cuK3EO6UEaQAMMSlbvJ4Ovd7wwqVqsflFgKolayoo/ul0BoXfpzvdQwpbbzki9DF+FMtQTEmbAmbKpzmsvFNpeiUWCzy4EEaKeUMi/U4PouzXvwHE+MPxK57sUXgBM1ZMa6ZIGkCqTtNjrQGnV+jqykH/rgQ7KJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos7-00074I-C2; Fri, 19 Jan 2024 14:25:23 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-000viM-7a; Fri, 19 Jan 2024 14:25:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-00F98B-0X;
	Fri, 19 Jan 2024 14:25:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [RFC PATCH v1 4/7] nvmem: provide consumer access to cell size metrics
Date: Fri, 19 Jan 2024 14:25:18 +0100
Message-Id: <20240119132521.3609945-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119132521.3609945-1-o.rempel@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Add nvmem_cell_get_size() function to provide access to cell size
metrics. In some cases we may get cell size less as consumer would
expect it. So, nvmem_cell_write() would fail with incorrect buffer size.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/nvmem/core.c           | 25 +++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bf42b7e826db..6c5b785b804b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1753,6 +1753,31 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
+ * nvmem_cell_get_size() - Get the size of a given nvmem cell
+ * @cell: nvmem cell to be queried.
+ * @bytes: Pointer to store the size of the cell in bytes. Can be NULL.
+ * @bits: Pointer to store the size of the cell in bits. Can be NULL.
+ *
+ * Return: 0 on success or negative on failure.
+ */
+int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *bits)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+
+	if (!entry->nvmem)
+		return -EINVAL;
+
+	if (bytes)
+		*bytes = entry->bytes;
+
+	if (bits)
+		*bits = entry->nbits;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_get_size);
+
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 				  void *val, size_t count)
 {
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 6ec4b9743e25..a174b05514b4 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *bits);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
@@ -127,6 +128,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes,
+				      size_t *bits)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_cell_read_u8(struct device *dev,
 				     const char *cell_id, u8 *val)
 {
-- 
2.39.2


