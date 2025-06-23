Return-Path: <linux-pm+bounces-29291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA85AE3F64
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED02817A476
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD3265629;
	Mon, 23 Jun 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dr9CnfXu"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C68263F32;
	Mon, 23 Jun 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680129; cv=none; b=sEHP8t82sGLBnG/ZgOzG56jNyyZVWcVqzwpmRsB8txn2zIBP1OGwQ5NE0Duxqhx3+z6dq/QoQEE52n1SVRpccGvvXLgtAK215wjiazTfDiJTWpusIqb3FcsbxfVoTiQaJU/6/OKJB5HTNkw0LEnJWRabp5e6TgsdOVWXDqKLjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680129; c=relaxed/simple;
	bh=IoUsNVe0Yo88xEvaAxYNGc3JFqeP1ogQUYh4NKW/uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYYODz1pN49ji/Q1QZrMZyp2c6q8hKvEVS2aBKSLeXEB2B35VlKRV68eUbO/zvZ8XhbOgIDbDAXKcOlz6HfQhTXTRH/aPI8WigrTJydeKznCZa/zzLwIIxfagE0ZFPOIFBbJnYPLP5ZjiuP7xtJt0FYSiSJ3skmEAoMB8RaSQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dr9CnfXu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680125;
	bh=IoUsNVe0Yo88xEvaAxYNGc3JFqeP1ogQUYh4NKW/uOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dr9CnfXucIU1KVoiiP3EifjudzKuAqd5twVgC9Y0S4gy2xn4tnM+byc+buJ+A7hti
	 e6N4KGGIUtkzcaUHs1xgozssBsG3R4IfHrTxJI1MQLF2McTsl22OeedudJu8iWumAn
	 gEzG3OHeXdqJlQZxupA87S5O4vSX4R6o1FndutSY6DK/q3ILAVgisQDWflu+CZrBsv
	 Vh8xpqipOTt8CaEpzuB/3w1yCeVDH0LlYiEnjCSx/u+nDbANRHcCvneZmHhVb/O5oR
	 M31+/8VO9rtTYMHRumAJPLVAJRbodOrpqEwwWfMxbeImFoFvopzo7Mv5kokojtkqZG
	 H1SqqP81HlUeQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9440B17E159C;
	Mon, 23 Jun 2025 14:02:04 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v1 07/13] pmdomain: mediatek: Add support for Hardware Voter power domains
Date: Mon, 23 Jun 2025 14:01:48 +0200
Message-ID: <20250623120154.109429-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New generation SoCs like MT8196/MT6991 feature a new type of power
domains, managed by a Hardware Voter (HWV) helper (through a SoC
internal fixed-function MCU): this is used to collect votes from
both the AP and the various other remote processors present in the
SoC and transparently power on/off various power domains, avoiding
unpowered access of registers in various internal IPs from all of
the integrated remote processors (or from the AP...!).

Add a new power domain type and differentiate between the old
SCPSYS_MTCMOS_TYPE_DIRECT_CTL - where power domains are controlled
directly by and exclusively from the Application Processor, and
the new SCPSYS_MTCMOS_TYPE_HW_VOTER, where the power domains are
voted through the HWV.

With the two needing different handling, check the power domain
type and assign a different power_{off,on} callback for pm_genpd:
for this specific reason, also move the check for the SCPD cap
MTK_SCPD_KEEP_DEFAULT_OFF after the assignment, and use the
assigned power_on function instead of calling scpsys_power_on()
directly to make that work for both HW_VOTER and DIRECT_CTL.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 250 ++++++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  45 +++-
 2 files changed, 268 insertions(+), 27 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 8711773e75d4..977e4e7de831 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -31,6 +31,12 @@
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
 
+#define MTK_HWV_POLL_DELAY_US		5
+#define MTK_HWV_POLL_TIMEOUT		(300 * USEC_PER_MSEC)
+
+#define MTK_HWV_PREPARE_DELAY_US	1
+#define MTK_HWV_PREPARE_TIMEOUT		(3 * USEC_PER_MSEC)
+
 #define PWR_RST_B_BIT			BIT(0)
 #define PWR_ISO_BIT			BIT(1)
 #define PWR_ON_BIT			BIT(2)
@@ -48,6 +54,7 @@
 struct scpsys_domain {
 	struct generic_pm_domain genpd;
 	const struct scpsys_domain_data *data;
+	const struct scpsys_hwv_domain_data *hwv_data;
 	struct scpsys *scpsys;
 	int num_clks;
 	struct clk_bulk_data *clks;
@@ -83,6 +90,32 @@ static bool scpsys_domain_is_on(struct scpsys_domain *pd)
 	return status && status2;
 }
 
+static bool scpsys_hwv_domain_is_disable_done(struct scpsys_domain *pd)
+{
+	const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
+	u32 regs[2] = { hwv->done, hwv->clr_sta };
+	u32 val[2];
+	u32 mask = BIT(hwv->setclr_bit);
+
+	regmap_multi_reg_read(pd->scpsys->base, regs, val, 2);
+
+	/* Disable is done when the bit is set in DONE, cleared in CLR_STA */
+	return (val[0] & mask) && !(val[1] & mask);
+}
+
+static bool scpsys_hwv_domain_is_enable_done(struct scpsys_domain *pd)
+{
+	const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
+	u32 regs[3] = { hwv->done, hwv->en, hwv->set_sta };
+	u32 val[3];
+	u32 mask = BIT(hwv->setclr_bit);
+
+	regmap_multi_reg_read(pd->scpsys->base, regs, val, 3);
+
+	/* Enable is done when the bit is set in DONE and EN, cleared in SET_STA */
+	return (val[0] & mask) && (val[1] & mask) && !(val[2] & mask);
+}
+
 static int scpsys_sram_enable(struct scpsys_domain *pd)
 {
 	u32 expected_ack, pdn_ack = pd->data->sram_pdn_ack_bits;
@@ -250,6 +283,137 @@ static int scpsys_regulator_disable(struct regulator *supply)
 	return supply ? regulator_disable(supply) : 0;
 }
 
+static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
+	struct scpsys *scpsys = pd->scpsys;
+	u32 val;
+	int ret;
+
+	ret = scpsys_regulator_enable(pd->supply);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+	if (ret)
+		goto err_reg;
+
+	/* For HWV the subsys clocks refer to the HWV low power subsystem */
+	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_disable_clks;
+
+	/* Make sure the HW Voter is idle and able to accept commands */
+	ret = regmap_read_poll_timeout_atomic(scpsys->base, hwv->done, val,
+					      val & BIT(hwv->setclr_bit),
+					      MTK_HWV_POLL_DELAY_US,
+					      MTK_HWV_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(scpsys->dev, "Failed to power on: HW Voter busy.\n");
+		goto err_disable_subsys_clks;
+	}
+
+	/*
+	 * Instruct the HWV to power on the MTCMOS (power domain): after that,
+	 * the same bit will be unset immediately by the hardware.
+	 */
+	regmap_write(scpsys->base, hwv->set, BIT(hwv->setclr_bit));
+
+	/*
+	 * Wait until the HWV sets the bit again, signalling that its internal
+	 * state machine was started and it now processing the vote command.
+	 */
+	ret = regmap_read_poll_timeout_atomic(scpsys->base, hwv->set, val,
+					      val & BIT(hwv->setclr_bit),
+					      MTK_HWV_PREPARE_DELAY_US,
+					      MTK_HWV_PREPARE_TIMEOUT);
+	if (ret) {
+		dev_err(scpsys->dev, "Failed to power on: HW Voter not starting.\n");
+		goto err_disable_subsys_clks;
+	}
+
+	/* Wait for ACK, signalling that the MTCMOS was enabled */
+	ret = readx_poll_timeout_atomic(scpsys_hwv_domain_is_enable_done, pd, val, val,
+					MTK_HWV_POLL_DELAY_US, MTK_HWV_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(scpsys->dev, "Failed to power on: HW Voter ACK timeout.\n");
+		goto err_disable_subsys_clks;
+	}
+
+	/* It's done! Disable the HWV low power subsystem clocks */
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+
+	return 0;
+
+err_disable_subsys_clks:
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+err_disable_clks:
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+err_reg:
+	scpsys_regulator_disable(pd->supply);
+	return ret;
+};
+
+static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
+	struct scpsys *scpsys = pd->scpsys;
+	u32 val;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		return ret;
+
+	/* Make sure the HW Voter is idle and able to accept commands */
+	ret = regmap_read_poll_timeout_atomic(scpsys->base, hwv->done, val,
+					      val & BIT(hwv->setclr_bit),
+					      MTK_HWV_POLL_DELAY_US,
+					      MTK_HWV_POLL_TIMEOUT);
+	if (ret)
+		goto err_disable_subsys_clks;
+
+
+	/*
+	 * Instruct the HWV to power off the MTCMOS (power domain): differently
+	 * from poweron, the bit will be kept set.
+	 */
+	regmap_write(scpsys->base, hwv->clr, BIT(hwv->setclr_bit));
+
+	/*
+	 * Wait until the HWV clears the bit, signalling that its internal
+	 * state machine was started and it now processing the clear command.
+	 */
+	ret = regmap_read_poll_timeout_atomic(scpsys->base, hwv->clr, val,
+					      !(val & BIT(hwv->setclr_bit)),
+					      MTK_HWV_PREPARE_DELAY_US,
+					      MTK_HWV_PREPARE_TIMEOUT);
+	if (ret)
+		goto err_disable_subsys_clks;
+
+	/* Poweroff needs 100us for the HW to stabilize */
+	udelay(100);
+
+	/* Wait for ACK, signalling that the MTCMOS was disabled */
+	ret = readx_poll_timeout_atomic(scpsys_hwv_domain_is_disable_done, pd, val, val,
+					MTK_HWV_POLL_DELAY_US, MTK_HWV_POLL_TIMEOUT);
+	if (ret)
+		goto err_disable_subsys_clks;
+
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+
+	scpsys_regulator_disable(pd->supply);
+
+	return 0;
+
+err_disable_subsys_clks:
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	return ret;
+};
+
 static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
@@ -514,6 +678,7 @@ static struct
 generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
 {
 	const struct scpsys_domain_data *domain_data;
+	const struct scpsys_hwv_domain_data *hwv_domain_data;
 	struct scpsys_domain *pd;
 	struct property *prop;
 	const char *clk_name;
@@ -529,14 +694,33 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (id >= scpsys->soc_data->num_domains) {
-		dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
-		return ERR_PTR(-EINVAL);
-	}
+	switch (scpsys->soc_data->type) {
+	case SCPSYS_MTCMOS_TYPE_DIRECT_CTL:
+		if (id >= scpsys->soc_data->num_domains) {
+			dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
+			return ERR_PTR(-EINVAL);
+		}
+
+		domain_data = &scpsys->soc_data->domains_data[id];
+		hwv_domain_data = NULL;
 
-	domain_data = &scpsys->soc_data->domains_data[id];
-	if (domain_data->sta_mask == 0) {
-		dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
+		if (domain_data->sta_mask == 0) {
+			dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
+			return ERR_PTR(-EINVAL);
+		}
+
+		break;
+	case SCPSYS_MTCMOS_TYPE_HW_VOTER:
+		if (id >= scpsys->soc_data->num_hwv_domains) {
+			dev_err(scpsys->dev, "%pOF: invalid HWV domain id %d\n", node, id);
+			return ERR_PTR(-EINVAL);
+		}
+
+		domain_data = NULL;
+		hwv_domain_data = &scpsys->soc_data->hwv_domains_data[id];
+
+		break;
+	default:
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -545,6 +729,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		return ERR_PTR(-ENOMEM);
 
 	pd->data = domain_data;
+	pd->hwv_data = hwv_domain_data;
 	pd->scpsys = scpsys;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
@@ -604,6 +789,31 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		pd->subsys_clks[i].clk = clk;
 	}
 
+	if (scpsys->domains[id]) {
+		ret = -EINVAL;
+		dev_err(scpsys->dev,
+			"power domain with id %d already exists, check your device-tree\n", id);
+		goto err_put_subsys_clocks;
+	}
+
+	if (pd->data && pd->data->name)
+		pd->genpd.name = pd->data->name;
+	else if (pd->hwv_data && pd->hwv_data->name)
+		pd->genpd.name = pd->hwv_data->name;
+	else
+		pd->genpd.name = node->name;
+
+	if (scpsys->soc_data->type == SCPSYS_MTCMOS_TYPE_DIRECT_CTL) {
+		pd->genpd.power_off = scpsys_power_off;
+		pd->genpd.power_on = scpsys_power_on;
+	} else {
+		pd->genpd.power_off = scpsys_hwv_power_off;
+		pd->genpd.power_on = scpsys_hwv_power_on;
+
+		/* HW-Voter code can be invoked in atomic context */
+		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
+	}
+
 	/*
 	 * Initially turn on all domains to make the domains usable
 	 * with !CONFIG_PM and to get the hardware in sync with the
@@ -615,7 +825,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			dev_warn(scpsys->dev,
 				 "%pOF: A default off power domain has been ON\n", node);
 	} else {
-		ret = scpsys_power_on(&pd->genpd);
+		ret = pd->genpd.power_on(&pd->genpd);
 		if (ret < 0) {
 			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
 			goto err_put_subsys_clocks;
@@ -625,21 +835,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 	}
 
-	if (scpsys->domains[id]) {
-		ret = -EINVAL;
-		dev_err(scpsys->dev,
-			"power domain with id %d already exists, check your device-tree\n", id);
-		goto err_put_subsys_clocks;
-	}
-
-	if (!pd->data->name)
-		pd->genpd.name = node->name;
-	else
-		pd->genpd.name = pd->data->name;
-
-	pd->genpd.power_off = scpsys_power_off;
-	pd->genpd.power_on = scpsys_power_on;
-
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_ACTIVE_WAKEUP))
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 
@@ -870,7 +1065,8 @@ static int scpsys_get_bus_protection(struct device *dev, struct scpsys *scpsys)
 		scpsys->bus_prot[i] = device_node_to_regmap(node);
 		of_node_put(node);
 		if (IS_ERR_OR_NULL(scpsys->bus_prot[i]))
-			return dev_err_probe(dev, PTR_ERR(scpsys->bus_prot[i]),
+			return dev_err_probe(dev, scpsys->bus_prot[i] ?
+					     PTR_ERR(scpsys->bus_prot[i]) : -ENXIO,
 					     "Cannot get regmap for bus prot %d\n", i);
 	}
 
@@ -933,7 +1129,7 @@ static int scpsys_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct device *parent;
 	struct scpsys *scpsys;
-	int ret;
+	int num_domains, ret;
 
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
@@ -941,7 +1137,9 @@ static int scpsys_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	scpsys = devm_kzalloc(dev, struct_size(scpsys, domains, soc->num_domains), GFP_KERNEL);
+	num_domains = soc->num_domains + soc->num_hwv_domains;
+
+	scpsys = devm_kzalloc(dev, struct_size(scpsys, domains, num_domains), GFP_KERNEL);
 	if (!scpsys)
 		return -ENOMEM;
 
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index e1dae6409d4a..6fe06c4a06e1 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -16,7 +16,9 @@
 #define MTK_SCPD_SRAM_PDN_INVERTED	BIT(9)
 #define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
 #define MTK_SCPD_SKIP_RESET_B		BIT(11)
-#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
+#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data ?		\
+					 (_scpd)->data->caps & (_x) :	\
+					 (_scpd)->hwv_data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
 #define SPM_MFG_PWR_CON			0x0214
@@ -124,6 +126,18 @@ enum scpsys_rtff_type {
 	SCPSYS_RTFF_TYPE_MAX
 };
 
+/**
+ * enum scpsys_mtcmos_type - Type of power domain controller
+ * @SCPSYS_MTCMOS_TYPE_DIRECT_CTL: Power domains are controlled with direct access
+ * @SCPSYS_MTCMOS_TYPE_HW_VOTER:   Hardware-assisted voted power domain control
+ * @SCPSYS_MTCMOS_TYPE_MAX:        Number of supported power domain types
+ */
+enum scpsys_mtcmos_type {
+	SCPSYS_MTCMOS_TYPE_DIRECT_CTL = 0,
+	SCPSYS_MTCMOS_TYPE_HW_VOTER,
+	SCPSYS_MTCMOS_TYPE_MAX
+};
+
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @name: The name of the power domain.
@@ -152,11 +166,40 @@ struct scpsys_domain_data {
 	int pwr_sta2nd_offs;
 };
 
+/**
+ * struct scpsys_hwv_domain_data - Hardware Voter power domain data
+ * @name:       Name of the power domain
+ * @set:        Offset of the HWV SET register
+ * @clr:        Offset of the HWV CLEAR register
+ * @done:       Offset of the HWV DONE register
+ * @en:         Offset of the HWV ENABLE register
+ * @set_sta:    Offset of the HWV SET STATUS register
+ * @clr_sta:    Offset of the HWV CLEAR STATUS register
+ * @setclr_bit: The SET/CLR bit to enable/disable the power domain
+ * @sta_bit:    The SET/CLR STA bit to check for on/off ACK
+ * @caps:       The flag for active wake-up action
+ */
+struct scpsys_hwv_domain_data {
+	const char *name;
+	u16 set;
+	u16 clr;
+	u16 done;
+	u16 en;
+	u16 set_sta;
+	u16 clr_sta;
+	u8 setclr_bit;
+	u8 sta_bit;
+	u16 caps;
+};
+
 struct scpsys_soc_data {
 	const struct scpsys_domain_data *domains_data;
 	int num_domains;
+	const struct scpsys_hwv_domain_data *hwv_domains_data;
+	int num_hwv_domains;
 	enum scpsys_bus_prot_block *bus_prot_blocks;
 	int num_bus_prot_blocks;
+	enum scpsys_mtcmos_type type;
 };
 
 #endif /* __SOC_MEDIATEK_MTK_PM_DOMAINS_H */
-- 
2.49.0


