Return-Path: <linux-pm+bounces-39728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40426CD3590
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A11E3011AB8
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA631195B;
	Sat, 20 Dec 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YxRCapuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A833101AE;
	Sat, 20 Dec 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256693; cv=pass; b=C+b6D8IAcIFCI4Qjao+DV9ZTWMRvQQh0xQi5+Np+2tZhGggc+4jfN3PiNvM3T/TkTCJlCM6eVfvfMEPYzUh2vIKKXDeJWwQv4Ib5b1SlDf1p/h+xxC+OQmrPebgNyzdz9V98/W8B60u9B5cLexB5cblCvGiLWOzEiCJhfSfPTDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256693; c=relaxed/simple;
	bh=ZatUZYCF/cHOR33QjkB+YNbdZjxbeNr+Lg6rp1tov5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrDdFm01LJ1rALfeAnsVXWsSR9UG6IWvz8vqFyr3GT0u+02/H3Vu5TSXnArIZ/TlNZ4liAOhgfy8JnFUw7hWets8Z6qxe1hDWR83+F+J95yIMZGgnKF2XgBB7Ueu57CJV5X1+FBMt42HKslO84fBFNT9UVt4kXW+yCOobhRGO1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=YxRCapuL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766256646; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k+ps33RBoTWzNAlrymFBqhrJ55XvdVPAT3xq+aTba7zUdV7Z+/k3sFXbqkjStnwU3fKC4DLCfbfstyss83JbuvavywOY0EcDg3VIAPGHH3hBOKeMPjfB6xGPa73x19e+tvR3/xrJ+igMvn99fS524VdlG+VU1mvIh/aMxVQmBqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766256646; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5j17v1GY5ZUui5Rtx97+9pI639Hi6bT0WnwCtzvrtAQ=; 
	b=DXXW5zq0m7GofuoNuxOsUEqA1LuHa4dN/fLdZPkE1PXL79G/77pNl7LEZ5RoXzPQJ6ptLSf8TVX25ws6N8kMHKFepV2GWyZw0sMPwxApZhcmIXUVM2QWGhKoHoqgbAMoxlBJw+mQ0RebKzWb9RnkajGbAmGyL4unhOdY/vuyfHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766256646;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5j17v1GY5ZUui5Rtx97+9pI639Hi6bT0WnwCtzvrtAQ=;
	b=YxRCapuLlpcgveZ8ge+9Vt9yL4zoF7BeXltj21O4pBcGxMmo4PKr67dZOWJgacT9
	4LGATQCtFbN3QrbIoPAc5Wyk8dy9fLAHt1gHOZDn198/kWRImzStGT7ic1eIp2BDdU8
	EIaJSJZXXNJaG07RIi1ArCYZ4JYC0mCUo1E3Vuf4=
Received: by mx.zohomail.com with SMTPS id 1766256644626461.8229840632764;
	Sat, 20 Dec 2025 10:50:44 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 20 Dec 2025 19:49:55 +0100
Subject: [PATCH v2 4/4] pmdomain: mediatek: mtk-mfg: Expose shader_present
 as nvmem cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-mt8196-shader-present-v2-4-45b1ff1dfab0@collabora.com>
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
In-Reply-To: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
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
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 9bad577b3ae4..3ce6fb74dd53 100644
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
@@ -872,6 +873,60 @@ static int mtk_mfg_init_clk_provider(struct mtk_mfg *mfg)
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
+	if (IS_ERR(nvdev))
+		return dev_err_probe(dev, PTR_ERR(nvdev), "Couldn't register nvmem provider\n");
+
+	cell.name = "shader-present";
+	cell.offset = GF_REG_SHADER_PRESENT;
+	cell.bytes = 4;
+	cell.np = of_get_child_by_name(dev->of_node, cell.name);
+
+	ret = nvmem_add_one_cell(nvdev, &cell);
+	if (ret) {
+		of_node_put(cell.np);
+		return dev_err_probe(dev, ret, "Couldn't add cell %s\n", cell.name);
+	}
+
+	/* cell.np purposefully not put as nvmem_add_one_cell does not increase refcount */
+
+	return 0;
+}
+
 static int mtk_mfg_probe(struct platform_device *pdev)
 {
 	struct mtk_mfg *mfg;
@@ -984,6 +1039,10 @@ static int mtk_mfg_probe(struct platform_device *pdev)
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


