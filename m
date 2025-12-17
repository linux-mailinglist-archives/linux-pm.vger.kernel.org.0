Return-Path: <linux-pm+bounces-39664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C28CC9196
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A19F32EAF7A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1B346A02;
	Wed, 17 Dec 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="T96gd2Kp"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC670346771;
	Wed, 17 Dec 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991080; cv=pass; b=PgiygFKEdhuJXupRX2CngA32srIQUyJO5VcpTuvuuY1tsw6eONqWlMN9oV5V17V+HXJu1ljoCBjxlC13gu+Ad9r93nebWfWoD4+V2ACtFhKHBmOdnhfQQydTOFVfD5aR66qqEgkF3dRMfxvYuiO6c5Li7dX6EqdEhF6ZDkfq/Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991080; c=relaxed/simple;
	bh=YmNwI7MxpnWlCVEo4v/8Kc9GMZMZ23l1F/XShcssJs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbvn/6vZAsahe5XfkroNP4E8P7tfbLgxzE+XtB5jaEAnSdCSdgfV7lxRLcgW5rRTWfgYC7GjGvIXGmjmQrdf8uzdkNDO+lVhXkSECELli1W1X5Gc2ndCMrmVaJbrp7NKAVJbM5ySyQLGv7m0XYvDSaRf7o+F3HE4WjPlYiAXJco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=T96gd2Kp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765991062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iNXV+LkqWbKyThRNyuMA7DBnA3Sg2x5ojhtfEQ3UXMd9BNoYAlS+zultvL2QIZFfjcPW0CisPXDH4CnA6skFYfqXa5YFJawtQE/Z+w6UvEE/hmHlxylIZTWT+BsMKNeNIIbAfmFkNymjN8tQ5Sg6p7U6hb85myq5gQ4mfxcGOyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765991062; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cn+wN94dsn6CdLIbCexrwAhvW7xHuDrjgU73wpCpToc=; 
	b=jMx5zQkMA6CDwleDqdP9EtRqmruILMNRfJnFFE1NEvzuNeWaRb3MQVmHZOjTzZi2zmIboLnvB1WgMuSUJH3Ll/OHIZ2/+Twk+87td9Ji8SveQvk0FA0C6ppg5i67KxJpksKtyZEa70UmnDAf9ZrouZiPbsjQNy6DP+YF2obl/Hs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765991062;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Cn+wN94dsn6CdLIbCexrwAhvW7xHuDrjgU73wpCpToc=;
	b=T96gd2KpGXUegdL47pBQjjHHEC1I1xbohrmvj5VPMcTsQwJDmoqRJkph4QxvPssg
	vihjm/SjXUFHSje5VH3KrKs2ubg5S/m+ywWm1c54bLMhdWdAWfgfrZ/uJl/rIxk6UAC
	RcQTz79rSYxSWuqZf+HkGbbQVh1dRDluYQVLzVqs=
Received: by mx.zohomail.com with SMTPS id 1765991061155339.44972850183456;
	Wed, 17 Dec 2025 09:04:21 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 17 Dec 2025 18:03:30 +0100
Subject: [PATCH 4/4] pmdomain: mediatek: mtk-mfg: Expose shader_present as
 nvmem cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-mt8196-shader-present-v1-4-f6f8f3aa1e93@collabora.com>
References: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
In-Reply-To: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

Implement nvmem-provider functionality in mtk-mfg-pmdomain, such that it
can expose its GF_REG_SHADER_PRESENT value in the shared memory as an
nvmem cell for panthor.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 9bad577b3ae4..725ebc678f1b 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/container_of.h>
 #include <linux/iopoll.h>
+#include <linux/nvmem-provider.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -872,6 +873,58 @@ static int mtk_mfg_init_clk_provider(struct mtk_mfg *mfg)
 	return 0;
 }
 
+static int mtk_mfg_read_nvmem(void *priv, unsigned int offset, void *val, size_t bytes)
+{
+	struct mtk_mfg *mfg = priv;
+	u32 *buf = val;
+
+	if (bytes != 4)
+		return -EINVAL;
+
+	if (!mfg->shared_mem)
+		return -ENODEV;
+
+	if (offset + bytes >= mfg->shared_mem_size)
+		return -EINVAL;
+
+	*buf = readl(mfg->shared_mem + offset);
+
+	return 0;
+}
+
+static int mtk_mfg_init_nvmem_provider(struct mtk_mfg *mfg)
+{
+	struct device *dev = &mfg->pdev->dev;
+	struct nvmem_cell_info cell = {};
+	struct nvmem_config config = {};
+	struct nvmem_device *nvdev;
+	int ret;
+
+	config.reg_read = mtk_mfg_read_nvmem;
+	config.dev = dev;
+	config.read_only = true;
+	config.priv = mfg;
+	config.size = 4;
+	config.word_size = 4;
+
+	nvdev = devm_nvmem_register(dev, &config);
+	of_node_put(config.of_node);
+	if (IS_ERR(nvdev))
+		return dev_err_probe(dev, PTR_ERR(nvdev), "Couldn't register nvmem provider\n");
+
+	cell.name = "shader-present";
+	cell.offset = GF_REG_SHADER_PRESENT;
+	cell.bytes = 4;
+	cell.np = of_get_child_by_name(dev->of_node, cell.name);
+
+	ret = nvmem_add_one_cell(nvdev, &cell);
+	/* cell.np purposefully not put as nvmem_add_one_cell does not increase refcount */
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't add cell %s\n", cell.name);
+
+	return 0;
+}
+
 static int mtk_mfg_probe(struct platform_device *pdev)
 {
 	struct mtk_mfg *mfg;
@@ -984,6 +1037,10 @@ static int mtk_mfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_power_off;
 
+	ret = mtk_mfg_init_nvmem_provider(mfg);
+	if (ret)
+		goto err_power_off;
+
 	ret = of_genpd_add_provider_simple(dev->of_node, &mfg->pd);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to add pmdomain provider\n");

-- 
2.52.0


