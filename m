Return-Path: <linux-pm+bounces-31939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E5B1AFAD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C2D17D854
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46738256C84;
	Tue,  5 Aug 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m6AZT9c4"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BB246326;
	Tue,  5 Aug 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380125; cv=none; b=f9qPExjROVXp2HBYq9mupM1UDGPf1E8pQL1woq2efGovwYHrzdZpHJGHyRL7g1nyWcgPXJvBmZNW6HheFacTt1/Mvyqx2wgpelRpMrNUs6nlzLFclCQE870O1+HZMKRR121ul5YRbg2aqgdbjxsRTHkSpM+OHkRjlfbbpT1kJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380125; c=relaxed/simple;
	bh=EW9/wwZaFZenMJUYfwI/se86Fwrk+yWISmXQeLcNmNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqWngQG5q86OBQy8qYyVrlVODE/JY5TUQl3NDFrpEITZtjaGA6vOMLOgDZkS3PCqpKkkIAqv7UzBDzXV7RlSvQXuCympTHC+Lmtzw8xpE96a+e6iGBWIwWZwEZ+qy5+zbUaOkJGkMFwCIeCzZrNQ9ME96jrFk7PE+DLKI3+HOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m6AZT9c4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380120;
	bh=EW9/wwZaFZenMJUYfwI/se86Fwrk+yWISmXQeLcNmNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6AZT9c4ZlBF8KaeYaMGTfshX6Dq78LVsalU+U64G/SM8D3A7IDVER0fj+bjEzm6Y
	 jhrDIfW+plvs3isH4icCzLkrMjVBahnKRhWY+gjBExRiRyvAs9V07HWVO0ZMKSn5iw
	 jP4PsEasldfYUc/WiH6ILv7k4L4Km9/2Bpy2LqpbP6RARQyy5sU7J/NvEzoR8fzezs
	 bbNi5T9Xvcz1y/Mz3IkdySa0Bd9mrIvnJVL+V/5qEv9PF66p15mHB+TSLdR/FAPblP
	 NAgejF+zNdEAW+bqXQom2ZrljkJYcx3ve8TZQRcdHKsMliFzixCXYQtjG16uw/nEm/
	 dbQbT01MmA15A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B55717E088C;
	Tue,  5 Aug 2025 09:48:39 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection regmaps retrieval
Date: Tue,  5 Aug 2025 09:47:40 +0200
Message-ID: <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation to add support for new generation SoCs like MT8196,
MT6991 and other variants, which require to set bus protection on
different busses than the ones found on legacy chips, and to also
simplify and reduce memory footprint of this driver, refactor the
mechanism to retrieve and use the bus protection regmaps.

This is done by removing the three pointers to struct regmap from
struct scpsys_domain (allocated for each power domain) and moving
them to the main struct scpsys (allocated per driver instance) as
an array of pointers to regmap named **bus_prot.

That deprecates the old devicetree properties to grab phandles to
the three predefined busses (infracfg, infracfg-nao and smi) and
replaces it with the base property "access-controllers" that is
meant to be an array of phandles holding the same busses where
required (for now - for legacy SoCs).

The new bus protection phandles are indexed by the bus_prot_index
member of struct scpsys, used to map "bus type" (ex.: infra, smi,
etc) to the specific *bus_prot[x] element.

While the old per-power-domain regmap pointers were removed, the
support for old devicetree was retained by still checking if the
new property (in DT) and new-style declaration (in SoC specific
platform data) are both present at probe time.

If those are not present, a lookup for the old properties will be
done in all of the children of the power controller, and pointers
to regmaps will be retrieved with the old properties, but then
will be internally remapped to follow the new style regmap anyway
as to let this driver benefit of the memory footprint reduction.

Finally, it was necessary to change macros in mtk-pm-domains.h and
in mt8365-pm-domains.h to make use of the new style bus protection
declaration, as the actual HW block is now recognized not by flags
but by its own scpsys_bus_prot_block enumeration.

The BUS_PROT_(STA)_COMPONENT_{INFRA,INFRA_NAO,SMI} flags were also
removed since they are now unused, and because that enumeration was
initially meant to vary the logic of bus protection and not the bus
where work is performed, anyway!

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |   8 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 188 ++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  53 +++--
 3 files changed, 187 insertions(+), 62 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
index 3d83d49eaa7c..6fbd5ef8d672 100644
--- a/drivers/pmdomain/mediatek/mt8365-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -29,11 +29,9 @@
 			    MT8365_SMI_COMMON_CLAMP_EN)
 
 #define MT8365_BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
-		_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta,	\
-			  BUS_PROT_COMPONENT_INFRA |			\
-			  BUS_PROT_STA_COMPONENT_INFRA_NAO |		\
-			  BUS_PROT_INVERTED |				\
-			  BUS_PROT_REG_UPDATE)
+		_BUS_PROT_STA(INFRA, INFRA_NAO, _set_mask, _set, _set,	\
+			      _sta_mask, _sta,				\
+			      BUS_PROT_INVERTED | BUS_PROT_REG_UPDATE)
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 	[MT8365_POWER_DOMAIN_MM] = {
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index a58ed7e2d9a4..48dc5f188438 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -47,9 +47,6 @@ struct scpsys_domain {
 	struct clk_bulk_data *clks;
 	int num_subsys_clks;
 	struct clk_bulk_data *subsys_clks;
-	struct regmap *infracfg_nao;
-	struct regmap *infracfg;
-	struct regmap *smi;
 	struct regulator *supply;
 };
 
@@ -57,6 +54,8 @@ struct scpsys {
 	struct device *dev;
 	struct regmap *base;
 	const struct scpsys_soc_data *soc_data;
+	u8 bus_prot_index[BUS_PROT_BLOCK_COUNT];
+	struct regmap **bus_prot;
 	struct genpd_onecell_data pd_data;
 	struct generic_pm_domain *domains[];
 };
@@ -125,19 +124,19 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
 						    const struct scpsys_bus_prot_data *bpd)
 {
-	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
-		return pd->smi;
-	else
-		return pd->infracfg;
+	struct scpsys *scpsys = pd->scpsys;
+	unsigned short block_idx = scpsys->bus_prot_index[bpd->bus_prot_block];
+
+	return scpsys->bus_prot[block_idx];
 }
 
 static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
 							const struct scpsys_bus_prot_data *bpd)
 {
-	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
-		return pd->infracfg_nao;
-	else
-		return scpsys_bus_protect_get_regmap(pd, bpd);
+	struct scpsys *scpsys = pd->scpsys;
+	int block_idx = scpsys->bus_prot_index[bpd->bus_prot_sta_block];
+
+	return scpsys->bus_prot[block_idx];
 }
 
 static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
@@ -149,7 +148,7 @@ static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
 	u32 expected_ack;
 	u32 val;
 
-	expected_ack = (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO ? sta_mask : 0);
+	expected_ack = (bpd->bus_prot_sta_block == BUS_PROT_BLOCK_INFRA_NAO ? sta_mask : 0);
 
 	if (bpd->flags & BUS_PROT_REG_UPDATE)
 		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
@@ -355,7 +354,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	struct device_node *smi_node;
 	struct property *prop;
 	const char *clk_name;
 	int i, ret, num_clks;
@@ -396,32 +394,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 				      node);
 	}
 
-	pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
-	if (IS_ERR(pd->infracfg))
-		return dev_err_cast_probe(scpsys->dev, pd->infracfg,
-					  "%pOF: failed to get infracfg regmap\n",
-					  node);
-
-	smi_node = of_parse_phandle(node, "mediatek,smi", 0);
-	if (smi_node) {
-		pd->smi = device_node_to_regmap(smi_node);
-		of_node_put(smi_node);
-		if (IS_ERR(pd->smi))
-			return dev_err_cast_probe(scpsys->dev, pd->smi,
-						  "%pOF: failed to get SMI regmap\n",
-						  node);
-	}
-
-	if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_INFRA_NAO)) {
-		pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
-		if (IS_ERR(pd->infracfg_nao))
-			return dev_err_cast_probe(scpsys->dev, pd->infracfg_nao,
-						  "%pOF: failed to get infracfg-nao regmap\n",
-						  node);
-	} else {
-		pd->infracfg_nao = NULL;
-	}
-
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
 		/* Calculate number of subsys_clks */
@@ -615,6 +587,136 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 	}
 }
 
+static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
+{
+	const u8 bp_blocks[3] = {
+		BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_SMI, BUS_PROT_BLOCK_INFRA_NAO
+	};
+	struct device_node *np = dev->of_node;
+	struct device_node *node, *smi_np;
+	int num_regmaps = 0, i, j;
+	struct regmap *regmap[3];
+
+	/*
+	 * Legacy code retrieves a maximum of three bus protection handles:
+	 * some may be optional, or may not be, so the array of bp blocks
+	 * that is normally passed in as platform data must be dynamically
+	 * built in this case.
+	 *
+	 * Here, try to retrieve all of the regmaps that the legacy code
+	 * supported and then count the number of the ones that are present,
+	 * this makes it then possible to allocate the array of bus_prot
+	 * regmaps and convert all to the new style handling.
+	 */
+	node = of_find_node_with_property(np, "mediatek,infracfg");
+	if (node) {
+		regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
+		of_node_put(node);
+		num_regmaps++;
+		if (IS_ERR(regmap[0]))
+			return dev_err_probe(dev, PTR_ERR(regmap[0]),
+					     "%pOF: failed to get infracfg regmap\n",
+					     node);
+	} else {
+		regmap[0] = NULL;
+	}
+
+	node = of_find_node_with_property(np, "mediatek,smi");
+	if (node) {
+		smi_np = of_parse_phandle(node, "mediatek,smi", 0);
+		of_node_put(node);
+		if (!smi_np)
+			return -ENODEV;
+
+		regmap[1] = device_node_to_regmap(smi_np);
+		num_regmaps++;
+		of_node_put(smi_np);
+		if (IS_ERR(regmap[1]))
+			return dev_err_probe(dev, PTR_ERR(regmap[1]),
+					     "%pOF: failed to get SMI regmap\n",
+					     node);
+	} else {
+		regmap[1] = NULL;
+	}
+
+	node = of_find_node_with_property(np, "mediatek,infracfg-nao");
+	if (node) {
+		regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
+		num_regmaps++;
+		of_node_put(node);
+		if (IS_ERR(regmap[2]))
+			return dev_err_probe(dev, PTR_ERR(regmap[2]),
+					     "%pOF: failed to get infracfg regmap\n",
+					     node);
+	} else {
+		regmap[2] = NULL;
+	}
+
+	scpsys->bus_prot = devm_kmalloc_array(dev, num_regmaps,
+					      sizeof(*scpsys->bus_prot), GFP_KERNEL);
+	if (!scpsys->bus_prot)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(bp_blocks); i++) {
+		enum scpsys_bus_prot_block bp_type;
+
+		if (!regmap[i])
+			continue;
+
+		bp_type = bp_blocks[i];
+		scpsys->bus_prot_index[bp_type] = j;
+		scpsys->bus_prot[j] = regmap[i];
+
+		j++;
+	}
+
+	return 0;
+}
+
+static int scpsys_get_bus_protection(struct device *dev, struct scpsys *scpsys)
+{
+	const struct scpsys_soc_data *soc = scpsys->soc_data;
+	struct device_node *np = dev->of_node;
+	int i, num_handles;
+
+	num_handles = of_count_phandle_with_args(np, "access-controllers", NULL);
+	if (num_handles < 0 || num_handles != soc->num_bus_prot_blocks)
+		return dev_err_probe(dev, -EINVAL,
+				     "Cannot get access controllers: expected %u, got %d\n",
+				     soc->num_bus_prot_blocks, num_handles);
+
+	scpsys->bus_prot = devm_kmalloc_array(dev, soc->num_bus_prot_blocks,
+					      sizeof(*scpsys->bus_prot), GFP_KERNEL);
+	if (!scpsys->bus_prot)
+		return -ENOMEM;
+
+	for (i = 0; i < soc->num_bus_prot_blocks; i++) {
+		enum scpsys_bus_prot_block bp_type;
+		struct device_node *node;
+
+		node = of_parse_phandle(np, "access-controllers", i);
+		if (!node)
+			return -EINVAL;
+
+		/*
+		 * Index the bus protection regmaps so that we don't have to
+		 * find the right one by type with a loop at every execution
+		 * of power sequence(s).
+		 */
+		bp_type = soc->bus_prot_blocks[i];
+		scpsys->bus_prot_index[bp_type] = i;
+
+		scpsys->bus_prot[i] = device_node_to_regmap(node);
+		of_node_put(node);
+		if (IS_ERR_OR_NULL(scpsys->bus_prot[i]))
+			return dev_err_probe(dev, scpsys->bus_prot[i] ?
+					     PTR_ERR(scpsys->bus_prot[i]) : -ENXIO,
+					     "Cannot get regmap for access controller %d\n", i);
+	}
+
+	return 0;
+}
+
 static const struct of_device_id scpsys_of_match[] = {
 	{
 		.compatible = "mediatek,mt6735-power-controller",
@@ -701,6 +803,14 @@ static int scpsys_probe(struct platform_device *pdev)
 		return PTR_ERR(scpsys->base);
 	}
 
+	if (of_find_property(np, "access-controllers", NULL))
+		ret = scpsys_get_bus_protection(dev, scpsys);
+	else
+		ret = scpsys_get_bus_protection_legacy(dev, scpsys);
+
+	if (ret)
+		return ret;
+
 	ret = -ENODEV;
 	for_each_available_child_of_node(np, node) {
 		struct generic_pm_domain *domain;
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 7085fa2976e9..4f2d331a866a 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -50,30 +50,43 @@ enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
 	BUS_PROT_INVERTED = BIT(3),
-	BUS_PROT_COMPONENT_INFRA = BIT(4),
-	BUS_PROT_COMPONENT_SMI = BIT(5),
-	BUS_PROT_STA_COMPONENT_INFRA_NAO = BIT(6),
 };
 
-#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
-		.bus_prot_set_clr_mask = (_set_clr_mask),	\
-		.bus_prot_set = _set,				\
-		.bus_prot_clr = _clr,				\
-		.bus_prot_sta_mask = (_sta_mask),		\
-		.bus_prot_sta = _sta,				\
-		.flags = _flags					\
+enum scpsys_bus_prot_block {
+	BUS_PROT_BLOCK_INFRA,
+	BUS_PROT_BLOCK_INFRA_NAO,
+	BUS_PROT_BLOCK_SMI,
+	BUS_PROT_BLOCK_COUNT,
+};
+
+#define _BUS_PROT_STA(_hwip, _sta_hwip, _set_clr_mask, _set, _clr,	\
+		      _sta_mask, _sta, _flags)				\
+	{								\
+		.bus_prot_block = BUS_PROT_BLOCK_##_hwip,		\
+		.bus_prot_sta_block = BUS_PROT_BLOCK_##_sta_hwip,	\
+		.bus_prot_set_clr_mask = (_set_clr_mask),		\
+		.bus_prot_set = _set,					\
+		.bus_prot_clr = _clr,					\
+		.bus_prot_sta_mask = (_sta_mask),			\
+		.bus_prot_sta = _sta,					\
+		.flags = _flags						\
 	}
 
-#define BUS_PROT_WR(_hwip, _mask, _set, _clr, _sta) \
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_##_hwip)
+#define _BUS_PROT(_hwip, _set_clr_mask, _set, _clr, _sta_mask,		\
+		  _sta, _flags)						\
+	_BUS_PROT_STA(_hwip, _hwip, _set_clr_mask, _set, _clr,		\
+		      _sta_mask, _sta, _flags)
+
+#define BUS_PROT_WR(_hwip, _mask, _set, _clr, _sta)			\
+		_BUS_PROT(_hwip, _mask, _set, _clr,  _mask, _sta, 0)
 
-#define BUS_PROT_WR_IGN(_hwip, _mask, _set, _clr, _sta) \
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
-			  BUS_PROT_COMPONENT_##_hwip | BUS_PROT_IGNORE_CLR_ACK)
+#define BUS_PROT_WR_IGN(_hwip, _mask, _set, _clr, _sta)		\
+		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
+			  BUS_PROT_IGNORE_CLR_ACK)
 
-#define BUS_PROT_UPDATE(_hwip, _mask, _set, _clr, _sta) \
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
-			  BUS_PROT_COMPONENT_##_hwip | BUS_PROT_REG_UPDATE)
+#define BUS_PROT_UPDATE(_hwip, _mask, _set, _clr, _sta)			\
+		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
+			  BUS_PROT_REG_UPDATE)
 
 #define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)			\
 		BUS_PROT_UPDATE(INFRA, _mask,			\
@@ -82,6 +95,8 @@ enum scpsys_bus_prot_flags {
 				INFRA_TOPAXI_PROTECTSTA1)
 
 struct scpsys_bus_prot_data {
+	u8 bus_prot_block;
+	u8 bus_prot_sta_block;
 	u32 bus_prot_set_clr_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
@@ -119,6 +134,8 @@ struct scpsys_domain_data {
 struct scpsys_soc_data {
 	const struct scpsys_domain_data *domains_data;
 	int num_domains;
+	enum scpsys_bus_prot_block *bus_prot_blocks;
+	int num_bus_prot_blocks;
 };
 
 #endif /* __SOC_MEDIATEK_MTK_PM_DOMAINS_H */
-- 
2.50.1


