Return-Path: <linux-pm+bounces-28882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBAADC715
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F4317799F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C22D12FF;
	Tue, 17 Jun 2025 09:50:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7952D12EB
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153807; cv=none; b=ZouVFxkvRJU25b5T+8ma/xh3mW7chC9cTa88H2Ed20slwZXpXQNWjpB7j+4cee0aDRTx9wALaU8huSRDoEoG3DsSViAa1Of8NIkzAFNvF2GpYKeR4SHR+xb3N2dD1+lmDFxpJFcLvZk/cmRw2xSeEydGkVccQ6TWNmCbd4a189w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153807; c=relaxed/simple;
	bh=CSE1xGwJPwkE21FMhoW6TOA0Bu55dDPTRRyrNaMKYnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9wuN1C2S2/dM2CXVX43oIojqVh0/ScKKVcaetBBRF6uGraKqQ6pd5HK8LzJbd+UYHb1eYKvBJrLHpMR4QkuMegnBP7qXuLoAxmDC8ebC+Ltts7OyOHOa+OsnTZPrCA7MbxEawxMuDj0ryl6ahlEbF/xEnzRYn6eGzkh2/piHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSwt-0005ew-0H; Tue, 17 Jun 2025 11:49:47 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSws-003x4z-0r;
	Tue, 17 Jun 2025 11:49:46 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRSws-00FBgX-0Y;
	Tue, 17 Jun 2025 11:49:46 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v10 4/7] nvmem: provide consumer access to cell size metrics
Date: Tue, 17 Jun 2025 11:49:42 +0200
Message-Id: <20250617094945.3619360-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617094945.3619360-1-o.rempel@pengutronix.de>
References: <20250617094945.3619360-1-o.rempel@pengutronix.de>
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
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
changes v10:
- add Reviewed-by: Sebastian Reichel ...
changes v6:
- update function comment for nvmem_cell_get_size()
---
 drivers/nvmem/core.c           | 29 +++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fd2a9698d1c9..59c295a11d86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1810,6 +1810,35 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
+ * nvmem_cell_get_size() - Retrieve the storage size of an NVMEM cell.
+ * @cell: Pointer to the NVMEM cell structure.
+ * @bytes: Optional pointer to store the cell size in bytes (can be NULL).
+ * @bits: Optional pointer to store the cell size in bits (can be NULL).
+ *
+ * This function allows consumers to retrieve the size of a specific NVMEM
+ * cell before performing read/write operations. It is useful for validating
+ * buffer sizes to prevent mismatched writes.
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
index 34c0e58dfa26..bcb0e17e415d 100644
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
@@ -128,6 +129,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
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
2.39.5


