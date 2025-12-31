Return-Path: <linux-pm+bounces-40076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15DCEB359
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 04:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E94D3009F60
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 03:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B230BBB8;
	Wed, 31 Dec 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK09EsNB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2C2D3737
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153253; cv=none; b=Chi39UNJ8jvRvRGOHKajoauY7cy7qhet5UVmjJkwi0sD1a4qNxXUVDPcr1LsOedJ9hXdZBjIPJ426cLH3Z2HGwWdMWZbcHWNroEYydYBxhOmEPKhpkAtg/OsdOXrq9kx+roXamY8diZoZ0uRaXdvt62psEs2SH8DgTsXN2FG+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153253; c=relaxed/simple;
	bh=vv5TvpKljz67G4j1CDBjncg42B3hKIrjZiA2MqUfKQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2cfmy0x1MGHcHiT+nVksm3X50LgNSTTTEgCPY4ELL8Py4iiaZ+Z9wbIZVV7vvscEDi8IWDrQzNZfQsvjgUpl1A6AX+uatY4Ez6LtIZgTiHdE3Hdge14Rw6FfiGA4HbOiKU++CTeM1L6Kdu/Awy9w5ZUWlr0fZlSMSilaOWewnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK09EsNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBE4C116B1;
	Wed, 31 Dec 2025 03:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767153253;
	bh=vv5TvpKljz67G4j1CDBjncg42B3hKIrjZiA2MqUfKQM=;
	h=From:To:Cc:Subject:Date:From;
	b=AK09EsNBLL6jpKUoF2W5bmUlTOL2bwsJb6JGm9RlwHldcEIGApe8VqcPvBIciahwn
	 Xyll+XGUfi9TAWHiqTz1didvdskF0WLdXgP1oFkKvy018q6KAw+l0z8huvTbF9VXdW
	 QbT1sWlRPiXG9NYcltfLIf5ZczINvWFXVvkMgILIdX+ppqpyNGl/Z4DU3NxM2HkOO2
	 LWxSjn8OQ6O/lT+DQyDzi1r3ZBP7ojwcBQLQpZ2+dbbWmfzKzNOrrR+94ksiEk8u3Z
	 Y0aRq4SvEhJnoUCFt72rakZjzoGCc3t5sw1Jpwu/hv1I69jY/bsiE5FHQrOb7i9VB9
	 EPcT0KsYbp8eQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	tzungbi@kernel.org
Subject: [PATCH v2] pmdomain: mediatek: Break lock dependency to `prepare_lock`
Date: Wed, 31 Dec 2025 03:53:57 +0000
Message-ID: <20251231035357.1147578-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Break a circular locking dependency between the Generic Power Domain
lock (`genpd->mlock`) and the clock framework's `prepare_lock`.  Move
the prepare() to the domain initialization phase and the unprepare()
to the cleanup phase.

The possible deadlock occurs in the following scenario:

1. `genpd_power_on` acquires `genpd->mlock` and then calls the driver's
   `scpsys_power_on`.  The driver calls `clk_bulk_prepare_enable`,
   which attempts to acquire `prepare_lock`.

> -> #0 (prepare_lock){+.+.}-{3:3}:
>        __lock_acquire
>        lock_acquire
>        __mutex_lock_common
>        mutex_lock_nested
>        clk_prepare
>        clk_bulk_prepare
>        scpsys_power_on
>        genpd_power_on

2. A clock provider (managed by a power domain) is resumed.
   `clk_prepare` acquires `prepare_lock` and triggers a runtime resume of
   its power domain, which attempts to acquire `genpd->mlock`.

> -> #1 (&genpd->mlock){+.+.}-{3:3}:
>        __mutex_lock_common
>        mutex_lock_nested
>        genpd_lock_mtx
>        genpd_runtime_resume
>        __rpm_callback
>        rpm_callback
>        rpm_resume
>        __pm_runtime_resume
>        clk_core_prepare
>        clk_prepare
>        clk_bulk_prepare

This creates a cycle: `mlock` -> `prepare_lock` -> `mlock`.

> Possible unsafe locking scenario:
>
>       CPU0                    CPU1
>       ----                    ----
>  lock(&genpd->mlock);
>                               lock(prepare_lock);
>                               lock(&genpd->mlock);
>  lock(prepare_lock);

This breaks the dependency chain in #0.

This is a revert of f0fce06e345d ("soc: mtk-pm-domains: Fix the clock
prepared issue").  However, addressing the issue by moving the
unprepare()/prepare() to PM suspend()/resume() callbacks.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- Fix build error reported by "kernel test robot <lkp@intel.com>".

v1: https://lore.kernel.org/all/20251229043244.4103262-1-tzungbi@kernel.org/

 drivers/pmdomain/mediatek/mtk-pm-domains.c | 101 +++++++++++++++++----
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 80561d27f2b2..c371b08c9170 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -318,12 +318,12 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		goto err_infra;
 
-	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
 	if (ret)
 		goto err_reg;
 
 	/* For HWV the subsys clocks refer to the HWV low power subsystem */
-	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
 	if (ret)
 		goto err_disable_clks;
 
@@ -365,7 +365,7 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	}
 
 	/* It's done! Disable the HWV low power subsystem clocks */
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
 		scpsys_sec_infra_power_on(false);
@@ -373,9 +373,9 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	return 0;
 
 err_disable_subsys_clks:
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_disable_clks:
-	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_disable(pd->num_clks, pd->clks);
 err_reg:
 	scpsys_regulator_disable(pd->supply);
 err_infra:
@@ -398,7 +398,7 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
 			return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
 	if (ret)
 		goto err_infra;
 
@@ -437,8 +437,8 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
 	if (ret)
 		goto err_disable_subsys_clks;
 
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
-	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable(pd->num_clks, pd->clks);
 
 	scpsys_regulator_disable(pd->supply);
 
@@ -448,7 +448,7 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
 	return 0;
 
 err_disable_subsys_clks:
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_infra:
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
 		scpsys_sec_infra_power_on(false);
@@ -616,7 +616,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
 	if (ret)
 		goto err_reg;
 
@@ -638,8 +638,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	 * access.
 	 */
 	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
-		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
-					      pd->subsys_clks);
+		ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
 		if (ret)
 			goto err_pwr_ack;
 	}
@@ -653,8 +652,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 		goto err_disable_sram;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
-		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
-					      pd->subsys_clks);
+		ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
 		if (ret)
 			goto err_enable_bus_protect;
 	}
@@ -667,10 +665,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
 	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
-		clk_bulk_disable_unprepare(pd->num_subsys_clks,
-					   pd->subsys_clks);
+		clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
-	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_disable(pd->num_clks, pd->clks);
 err_reg:
 	scpsys_regulator_disable(pd->supply);
 	return ret;
@@ -695,7 +692,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
 				pd->data->ext_buck_iso_mask);
 
-	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
 		scpsys_modem_pwrseq_off(pd);
@@ -708,7 +705,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_disable(pd->num_clks, pd->clks);
 
 	scpsys_regulator_disable(pd->supply);
 
@@ -855,6 +852,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
 	}
 
+	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
+	if (ret)
+		goto err_put_subsys_clocks;
+
+	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
+	if (ret)
+		goto err_unprepare_clocks;
+
 	/*
 	 * Initially turn on all domains to make the domains usable
 	 * with !CONFIG_PM and to get the hardware in sync with the
@@ -869,7 +874,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = pd->genpd.power_on(&pd->genpd);
 		if (ret < 0) {
 			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
-			goto err_put_subsys_clocks;
+			goto err_unprepare_subsys_clocks;
 		}
 
 		if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
@@ -888,6 +893,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	return scpsys->pd_data.domains[id];
 
+err_unprepare_subsys_clocks:
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+err_unprepare_clocks:
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_subsys_clocks:
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 err_put_clocks:
@@ -965,6 +974,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 	if (scpsys_domain_is_on(pd))
 		scpsys_power_off(&pd->genpd);
 
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
@@ -1208,6 +1219,7 @@ static int scpsys_probe(struct platform_device *pdev)
 	if (!scpsys)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, scpsys);
 	scpsys->dev = dev;
 	scpsys->soc_data = soc;
 
@@ -1270,12 +1282,61 @@ static int scpsys_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int scpsys_suspend(struct device *dev)
+{
+	struct scpsys *scpsys = dev_get_drvdata(dev);
+	struct generic_pm_domain *genpd;
+	struct scpsys_domain *pd;
+	int i;
+
+	for (i = 0; i < scpsys->pd_data.num_domains; i++) {
+		genpd = scpsys->pd_data.domains[i];
+		if (!genpd)
+			continue;
+
+		pd = to_scpsys_domain(genpd);
+		clk_bulk_unprepare(pd->num_clks, pd->clks);
+		clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+	}
+	return 0;
+}
+
+static int scpsys_resume(struct device *dev)
+{
+	struct scpsys *scpsys = dev_get_drvdata(dev);
+	struct generic_pm_domain *genpd;
+	struct scpsys_domain *pd;
+	int i, ret;
+
+	for (i = 0; i < scpsys->pd_data.num_domains; i++) {
+		genpd = scpsys->pd_data.domains[i];
+		if (!genpd)
+			continue;
+
+		pd = to_scpsys_domain(genpd);
+		ret = clk_bulk_prepare(pd->num_clks, pd->clks);
+		if (ret)
+			return ret;
+		ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops scpsys_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(scpsys_suspend, scpsys_resume)
+};
+
 static struct platform_driver scpsys_pm_domain_driver = {
 	.probe = scpsys_probe,
 	.driver = {
 		.name = "mtk-power-controller",
 		.suppress_bind_attrs = true,
 		.of_match_table = scpsys_of_match,
+		.pm = &scpsys_pm_ops,
 	},
 };
 builtin_platform_driver(scpsys_pm_domain_driver);
-- 
2.52.0.351.gbe84eed79e-goog


