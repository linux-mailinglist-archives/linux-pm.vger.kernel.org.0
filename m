Return-Path: <linux-pm+bounces-29289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4DAE3F69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EDC3BC96B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117E263C9F;
	Mon, 23 Jun 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ItVGlM56"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D95262FC4;
	Mon, 23 Jun 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680126; cv=none; b=eGtyc/zru91lyP/i0N6CiBcFuefx71IJ8B9rm6mj+qxFF2Nd4tcQCdvutL9aMcsWncYTliN40fqYG4QR0Tnd7pCLf1fVOkZgDdC+m1q8QPMi7xGxRVllheXrKAs3kUITyqY5PQnkkSozSsdvP4m6xyMXuo2RyDlJXv6iEPaooD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680126; c=relaxed/simple;
	bh=/BrBadfVBZBtuYCZKYq9WvAYMEyISTzymr2tI7L36ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RixqfLyP6qOLA+4d41w9TWIYbTusKHa1ZMdfKCw5kTKHhaaZQ/nZl+avKwwN77tGA+J/iUhJ4LfMBiaedO0AXzV0OyPgYLAmT5wRIHeUBP+Nqr9VnggUjkTs2qVjSr/J+uKW6rk4dy0bgndQGNKf0RUyaFesuxc7E3YGblE5aN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ItVGlM56; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680123;
	bh=/BrBadfVBZBtuYCZKYq9WvAYMEyISTzymr2tI7L36ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItVGlM56jF8hdlUphc+whwO3Baa5KHILBtlyLyq/SsUgeif3K125qOOmDSprfPl0o
	 qI+ZMh0YX4XufYgczaeXshzdvqxT9iHogH6w8P6Xr1OyTWL+2MB/EW77R2WA2880yx
	 NH76uzCO4ef0RfNHKfMPTxwOnmSC4DrRAnPMX6av6OlYLYX141zrUisGliYw7iuvNu
	 D85GMWYa2Pi4KOPzxbu9QOvHWN8y5gXjsJSyd7qc56yGdoYTQLP0dLZ+2Yv6w32IDn
	 dt5SqQ9ts9EGeqH/GnERkAkRbiZ2UDi3gMtzm6YtKeUYsbytbY4XhH3JpRd4ox7K3Y
	 CPZ+/1kq/7Z0w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8087F17E156E;
	Mon, 23 Jun 2025 14:02:02 +0200 (CEST)
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
Subject: [PATCH v1 05/13] pmdomain: mediatek: Add support for modem power sequences
Date: Mon, 23 Jun 2025 14:01:46 +0200
Message-ID: <20250623120154.109429-6-angelogioacchino.delregno@collabora.com>
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

Add support for the modem power domains by adding its specific
power sequence in functions scpsys_modem_pwrseq_{on,off}() and
call them if the flag MTK_SCPD_MODEM_PWRSEQ is present.

While at it, since some SoC models need to skip setting/clearing
the PWR_RST_B_BIT, also add a MTK_SCPD_SKIP_RESET_B flag for that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 41 ++++++++++++++++++++--
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  2 ++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 331736d55329..d14616d4aaab 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -279,6 +279,36 @@ static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
 }
 
+static int scpsys_modem_pwrseq_on(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+	bool tmp;
+	int ret;
+
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SKIP_RESET_B))
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+
+	/* wait until PWR_ACK = 1 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SKIP_RESET_B))
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
@@ -297,7 +327,11 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 		regmap_clear_bits(scpsys->base, pd->data->ext_buck_iso_offs,
 				  pd->data->ext_buck_iso_mask);
 
-	ret = scpsys_ctl_pwrseq_on(pd);
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
+		ret = scpsys_modem_pwrseq_on(pd);
+	else
+		ret = scpsys_ctl_pwrseq_on(pd);
+
 	if (ret)
 		goto err_pwr_ack;
 
@@ -366,7 +400,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
-	scpsys_ctl_pwrseq_off(pd);
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
+		scpsys_modem_pwrseq_off(pd);
+	else
+		scpsys_ctl_pwrseq_off(pd);
 
 	/* wait until PWR_ACK = 0 */
 	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index f7f0a5fb383b..4abdc8de25c8 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -14,6 +14,8 @@
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
 #define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
 #define MTK_SCPD_SRAM_PDN_INVERTED	BIT(9)
+#define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
+#define MTK_SCPD_SKIP_RESET_B		BIT(11)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.49.0


