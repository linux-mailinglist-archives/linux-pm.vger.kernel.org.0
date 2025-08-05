Return-Path: <linux-pm+bounces-31940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C59B1AFB0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECB517D91E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB402580DE;
	Tue,  5 Aug 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jH1/kIh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07525229C;
	Tue,  5 Aug 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380125; cv=none; b=f+r+6SAIG/fq6wd1UtCTjwzxZBXUkMeDavIasJfBZrOQuDUaQlxPWyKxX76OQTaqUgHVy5loIwOxsF87p/IZuvjAWixremn/SmYKu1G33xmgNpzBS2p/BOQkOC5LQ7FgtutuiN445Wz2V2gTlI8aoLmPgAWfmFtLBQRyoSt59uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380125; c=relaxed/simple;
	bh=Gh/u3ZCeLuKT6KDNbqOx6/ww1IVasVmdV+hy7t5OtOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkIRUnK7J0ptyxvrwysIVJDq/gom546apim9yoVIypgj8cR8Zpr+VUjh+EBw+SQdRHm0IHtGk7wbrBcBCuYTiwa0csL1+MOM/g1mxb7PGnQE2/FS95SwRXZ1EezJvCSMiYJWN8pwL0cp/vkvKsHL+6nBx4/AQk+h/dB3lIbD5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jH1/kIh3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380122;
	bh=Gh/u3ZCeLuKT6KDNbqOx6/ww1IVasVmdV+hy7t5OtOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jH1/kIh3q5qiE4foEFCFJMAA02QWd8mIItjmHOmyPLRDqpbUG0lA4NKZmcvT+Kbdc
	 uI9Xqxq3wgK3fqIHrCTIvt8TubpXv0a8HygbMzZFD1O0ICrW4gQMRnjbKFZarijoJt
	 h9Gn6sVvKb4Dlp6o7vjVHXyBQ5ki3afJ1Sn1CHSRc648pw85nhwBm3+BtLcNCB0TUP
	 Yc/u5dtEH39wdmLRMQenSKX3lByg3atU+0PBhH3gDqKodloCBa1qohSafCw8yEEf4n
	 1oBhWlelQC5C1eKu2VjeQtLhvj9W0qVcemay+cqC6InH9EEt4uYNtByLnSGZKrvfT5
	 J9we0CNmCLHcw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4BCE517E0B11;
	Tue,  5 Aug 2025 09:48:41 +0200 (CEST)
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
Subject: [PATCH v3 06/10] pmdomain: mediatek: Move ctl sequences out of power_on/off functions
Date: Tue,  5 Aug 2025 09:47:42 +0200
Message-ID: <20250805074746.29457-7-angelogioacchino.delregno@collabora.com>
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

In preparation to support power domains of new SoCs and the modem
power domains for both new and already supported chips, move the
generic control power sequences out of the scpsys_power_on() and
scpsys_power_off() and put them in new scpsys_ctl_pwrseq_on(),
scpsys_ctl_pewseq_off() functions.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 57 ++++++++++++++--------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 6118a389244a..d84f0e7cde12 100644
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
2.50.1


