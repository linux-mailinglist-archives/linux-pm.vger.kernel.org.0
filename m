Return-Path: <linux-pm+bounces-29288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1DAE3F4A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6AA189A6F5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF477262FEA;
	Mon, 23 Jun 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GJPBje4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412526157E;
	Mon, 23 Jun 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680125; cv=none; b=dDmSeWG+CNRW882kKOlmuqtnzxNDA2eutDATkLu/hDX9MwZNVhDtb9I/sreRwXAM7e0fyJLH9RBUIXM2gIZPhTFr9DHPZlTNUG5HMLe/mL3etx6Yl6WJa8+GBsU5Yd7Z/A8qOtiigrxeTyfQXzjlim8bYV5u2TlFIa0m84un4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680125; c=relaxed/simple;
	bh=Jy2EB1cMlsijtNMvI79qnH/ppAJrlFyGTqcN90xczFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9MmseVko3MPxz/5SDv3z68YO3PAEi0FeXhBllqqaGmXje+T+VwrZ+oCtftJjc3vjtWQSN7Tfq7lFsx9RnqMAyARfUntbPdKCCrsdV6iBle9VQ3zno4kMqjUaNhh0UtYoLQZRZF21eE+7d9xm74PXzd7W0ryKyV9EsriRfcpaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GJPBje4Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680122;
	bh=Jy2EB1cMlsijtNMvI79qnH/ppAJrlFyGTqcN90xczFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJPBje4Y/oh8tcXAZoW56YBHVZFu3VGDXLy1AfplnLW1nOV7EUewmi4jD7PYpNTMQ
	 RKulYByBDNdqKGQxip5chnjDeUTJKYUu2Cc9ZzGP27FY9dpq3V1y29e6ZyFwSxdeQT
	 zZPSnOcU7k3T/kZtecSRbj1x6TVTQb/9ifcHCZO+kJyduJgkSuG/z5ouYWAzxKO2hn
	 gyAuQHY9oqrcTlA45Ry4XGEXknX/X4TEXENgotvOuGTX76+rwrISOoHziTt+58P/He
	 LTrbGRLGgnsyDp7s37p3PaEFGvq8rteWSzYzugLAHFE0NSGHghj1mq6aOdYAvvAhQ3
	 jtul1iJ+UlnSw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73CE817E156D;
	Mon, 23 Jun 2025 14:02:01 +0200 (CEST)
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
Subject: [PATCH v1 04/13] pmdomain: mediatek: Move ctl sequences out of power_on/off functions
Date: Mon, 23 Jun 2025 14:01:45 +0200
Message-ID: <20250623120154.109429-5-angelogioacchino.delregno@collabora.com>
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

In preparation to support power domains of new SoCs and the modem
power domains for both new and already supported chips, move the
generic control power sequences out of the scpsys_power_on() and
scpsys_power_off() and put them in new scpsys_ctl_pwrseq_on(),
scpsys_ctl_pewseq_off() functions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 57 ++++++++++++++--------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 2a430e7cd353..331736d55329 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -244,11 +244,45 @@ static int scpsys_regulator_disable(struct regulator *supply)
 	return supply ? regulator_disable(supply) : 0;
 }
 
+static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+	bool tmp;
+	int ret;
+
+	/* subsys power on */
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
+
+	/* wait until PWR_ACK = 1 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+
+	return 0;
+}
+
+static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+
+	/* subsys power off */
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
 	struct scpsys *scpsys = pd->scpsys;
-	bool tmp;
 	int ret;
 
 	ret = scpsys_regulator_enable(pd->supply);
@@ -263,20 +297,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 		regmap_clear_bits(scpsys->base, pd->data->ext_buck_iso_offs,
 				  pd->data->ext_buck_iso_mask);
 
-	/* subsys power on */
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
-
-	/* wait until PWR_ACK = 1 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp, MTK_POLL_DELAY_US,
-				 MTK_POLL_TIMEOUT);
-	if (ret < 0)
+	ret = scpsys_ctl_pwrseq_on(pd);
+	if (ret)
 		goto err_pwr_ack;
 
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
-
 	/*
 	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
 	 * stricter, which leads to bus protect release must be prior to bus
@@ -342,12 +366,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
-	/* subsys power off */
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+	scpsys_ctl_pwrseq_off(pd);
 
 	/* wait until PWR_ACK = 0 */
 	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
-- 
2.49.0


