Return-Path: <linux-pm+bounces-8847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7150C901D85
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9F82812C4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCEB77F1B;
	Mon, 10 Jun 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a7uYwqwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D7770E8;
	Mon, 10 Jun 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009872; cv=none; b=TXyYlz/D1n817ysXJvzcoDzHzaTI2ezwvpajREvZDpx8eBRkYIQqOc/T6+nfmJZ1TFD2QV4sYQ1nLoKLAglkccaYfEkBl0mpbUdZ9YdGANEoQd6eBzph9eJCygTVBGX5KtoYuRi8UQXozzigWWrd4cRh71bmwProppUDWV3kV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009872; c=relaxed/simple;
	bh=e99sQb31EtqbM5DnQ+9bWzfSy0+td1CVrCQrtj0hb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gudhbd6Cz8108ETP/WslU33wiObmQmTQF7RubYDGatRZuXjbiCLe0Zhvi1VBVqCng/hIyaQ+Nuye34NAnc7N0pACkkst4Snh+AF3ZLew3i+9yiJe/tXEQAE1SkuKDbl5/marhsihgOayQ0KeCNT23ggqLSclVJFqsWB9VXwIWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a7uYwqwG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718009868;
	bh=e99sQb31EtqbM5DnQ+9bWzfSy0+td1CVrCQrtj0hb0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7uYwqwGOuzzkT7fdrlnC2PJ3n4nDqEH8sGvrLMfPlobFxku4EScL9vGKbhTa/KvC
	 B1FMocpVMNiDfXABJ/oB5B1NXv2XXRVlRxESQxEYS5vVPs5kxIY7qvA7cyhg0E9hs/
	 opZEW7acErsNepoMqN+X52896nuu+AwkgbLeObro7vlqhedJktZa2aQMoNCQLMDj4a
	 MkLoHABYa/MGBa0yF4Aidz0ymeHgZXwgr/0K4ryCAQPJoJRCNatMH/CtQRMojpYWPe
	 4vYMMPNFq2BAseNJekjO7X7v9Kz+VhXbKkY+2VSUQhe4EynksqrJ9m3bXvYgYv8rbU
	 vT4q2ni3ZDRtA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 980BD3782159;
	Mon, 10 Jun 2024 08:57:47 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v6 6/7] regulator: Add refactored mtk-dvfsrc-regulator driver
Date: Mon, 10 Jun 2024 10:57:34 +0200
Message-ID: <20240610085735.147134-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous driver never worked, and never got even compiled because
it was missing the DVFSRC driver entirely, including needed neaders.

This is a full (or nearly full) refactoring of the MediaTek DVFSRC
controlled Regulators driver, retaining support for the MT6873, MT8183
and MT8192 SoC, and adding MT8195.

As part of the refactoring, this driver is now probed using its own
devicetree compatible, as this is a child of the main DVFSRC driver
and gets probed as a subnode of that.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mtk-dvfsrc-regulator.c | 196 +++++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 drivers/regulator/mtk-dvfsrc-regulator.c

diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
new file mode 100644
index 000000000000..558efd8124b6
--- /dev/null
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/soc/mediatek/dvfsrc.h>
+
+enum dvfsrc_regulator_id {
+	DVFSRC_ID_VCORE,
+	DVFSRC_ID_VSCP,
+	DVFSRC_ID_MAX
+};
+
+struct dvfsrc_regulator_pdata {
+	struct regulator_desc *descs;
+	u32 size;
+};
+
+#define MTK_DVFSRC_VREG(match, _name, _volt_table)	\
+{							\
+	.name = match,					\
+	.of_match = match,				\
+	.ops = &dvfsrc_vcore_ops,			\
+	.type = REGULATOR_VOLTAGE,			\
+	.id = DVFSRC_ID_##_name,			\
+	.owner = THIS_MODULE,				\
+	.n_voltages = ARRAY_SIZE(_volt_table),		\
+	.volt_table = _volt_table,			\
+}
+
+static inline struct device *to_dvfs_regulator_dev(struct regulator_dev *rdev)
+{
+	return rdev_get_dev(rdev)->parent;
+}
+
+static inline struct device *to_dvfsrc_dev(struct regulator_dev *rdev)
+{
+	return to_dvfs_regulator_dev(rdev)->parent;
+}
+
+static int dvfsrc_get_cmd(int rdev_id, enum mtk_dvfsrc_cmd *cmd)
+{
+	switch (rdev_id) {
+	case DVFSRC_ID_VCORE:
+		*cmd = MTK_DVFSRC_CMD_VCORE_LEVEL;
+		break;
+	case DVFSRC_ID_VSCP:
+		*cmd = MTK_DVFSRC_CMD_VSCP_LEVEL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dvfsrc_set_voltage_sel(struct regulator_dev *rdev,
+				  unsigned int selector)
+{
+	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
+	enum mtk_dvfsrc_cmd req_cmd;
+	int id = rdev_get_id(rdev);
+	int ret;
+
+	ret = dvfsrc_get_cmd(id, &req_cmd);
+	if (ret)
+		return ret;
+
+	return mtk_dvfsrc_send_request(dvfsrc_dev, req_cmd, selector);
+}
+
+static int dvfsrc_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
+	enum mtk_dvfsrc_cmd query_cmd;
+	int id = rdev_get_id(rdev);
+	int val, ret;
+
+	ret = dvfsrc_get_cmd(id, &query_cmd);
+	if (ret)
+		return ret;
+
+	ret = mtk_dvfsrc_query_info(dvfsrc_dev, query_cmd, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
+static const struct regulator_ops dvfsrc_vcore_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.get_voltage_sel = dvfsrc_get_voltage_sel,
+	.set_voltage_sel = dvfsrc_set_voltage_sel,
+};
+
+static const unsigned int mt6873_voltages[] = {
+	575000,
+	600000,
+	650000,
+	725000,
+};
+
+static struct regulator_desc mt6873_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt6873_voltages),
+	MTK_DVFSRC_VREG("dvfsrc-vscp", VSCP, mt6873_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt6873_data = {
+	.descs = mt6873_regulators,
+	.size = ARRAY_SIZE(mt6873_regulators),
+};
+
+static const unsigned int mt8183_voltages[] = {
+	725000,
+	800000,
+};
+
+static struct regulator_desc mt8183_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt8183_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt8183_data = {
+	.descs = mt8183_regulators,
+	.size = ARRAY_SIZE(mt8183_regulators),
+};
+
+static const unsigned int mt8195_voltages[] = {
+	550000,
+	600000,
+	650000,
+	750000,
+};
+
+static struct regulator_desc mt8195_regulators[] = {
+	MTK_DVFSRC_VREG("dvfsrc-vcore", VCORE, mt8195_voltages),
+	MTK_DVFSRC_VREG("dvfsrc-vscp", VSCP, mt8195_voltages),
+};
+
+static const struct dvfsrc_regulator_pdata mt8195_data = {
+	.descs = mt8195_regulators,
+	.size = ARRAY_SIZE(mt8195_regulators),
+};
+
+static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = { .dev = &pdev->dev };
+	const struct dvfsrc_regulator_pdata *pdata;
+	int i;
+
+	pdata = device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+
+	for (i = 0; i < pdata->size; i++) {
+		struct regulator_desc *vrdesc = &pdata->descs[i];
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev, vrdesc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to register %s\n", vrdesc->name);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mtk_dvfsrc_regulator_match[] = {
+	{ .compatible = "mediatek,mt6873-dvfsrc-regulator", .data = &mt6873_data },
+	{ .compatible = "mediatek,mt8183-dvfsrc-regulator", .data = &mt8183_data },
+	{ .compatible = "mediatek,mt8192-dvfsrc-regulator", .data = &mt6873_data },
+	{ .compatible = "mediatek,mt8195-dvfsrc-regulator", .data = &mt8195_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_dvfsrc_regulator_match);
+
+static struct platform_driver mtk_dvfsrc_regulator_driver = {
+	.driver = {
+		.name  = "mtk-dvfsrc-regulator",
+		.of_match_table = mtk_dvfsrc_regulator_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = dvfsrc_vcore_regulator_probe,
+};
+module_platform_driver(mtk_dvfsrc_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Arvin wang <arvin.wang@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek DVFS Resource Collector Regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


