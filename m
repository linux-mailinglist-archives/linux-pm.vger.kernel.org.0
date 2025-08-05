Return-Path: <linux-pm+bounces-31941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51FB1AFB5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC73B02A0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F598258CF0;
	Tue,  5 Aug 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F9D0s6Wl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1E253F1A;
	Tue,  5 Aug 2025 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380126; cv=none; b=jECfZoYPZ+Avj22YAa3Dt44tCAbt4kSQaafTd3zioRAxRslMcjfyFeMSy8fhTjIPzsdIyenU5Ywk5gWpwZkDt6WCChXaM6ACUVm4znk8QptFzC/AWqza0Qh+zHzvisO6x5RXPcgy7e3aqi8jqo7PzbLLG3XEvmPyPAyCcYe8sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380126; c=relaxed/simple;
	bh=sRNhp2QPOoJQsiZGRDkr+9hMr8JVtwDhe7zfdujQmfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTfhBwT+z0cmqO+6jVVJ9bzT4T8JkO/c8hVHFMvcsmgxSFXADkt5VouHA0JzXAy0ZifOFnXxNW8E6FBiGAPUJB9W8Nhp5xdY1rPViU9EpcilwHMbIQdgUlpL6hRnOl+9I8e/TNWUIVk2RTR7avtI966qWG1eNXP41WD46cgOJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F9D0s6Wl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380123;
	bh=sRNhp2QPOoJQsiZGRDkr+9hMr8JVtwDhe7zfdujQmfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9D0s6Wlf00Dfx2H9wZP2Hiubsl7SVJBSCe781NJeCAQoqXSNYkfkknwypiEJRu/j
	 3rifJdWybvCUNA26RiElN5nxHT5JOadKkk4vQLgH5fwnxdtcDYMC4/nd/IPShUiD85
	 aiMEsxoi95yA6dsNXEcNtMR5Kna47sVMhjyWbgbOS/lII40wdeoQ3DQ3uHMyaBH6SU
	 0tya2RbgQc/EPRNhBteaDG1uic+CaB7oa82DYzz+/xhdRKTMnFV9P3EIheBsk1CrJP
	 Jc2hc5HtSU4Cn6d2NNa5KFGmMNqdT8rB0nJRFqb63/NG/oKoSnMukz5UcNskQzXhO7
	 dndShB+3O1zFg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4CD1F17E0C83;
	Tue,  5 Aug 2025 09:48:42 +0200 (CEST)
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
Subject: [PATCH v3 07/10] pmdomain: mediatek: Add support for modem power sequences
Date: Tue,  5 Aug 2025 09:47:43 +0200
Message-ID: <20250805074746.29457-8-angelogioacchino.delregno@collabora.com>
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

Add support for the modem power domains by adding its specific
power sequence in functions scpsys_modem_pwrseq_{on,off}() and
call them if the flag MTK_SCPD_MODEM_PWRSEQ is present.

While at it, since some SoC models need to skip setting/clearing
the PWR_RST_B_BIT, also add a MTK_SCPD_SKIP_RESET_B flag for that.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 41 ++++++++++++++++++++--
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  2 ++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index d84f0e7cde12..cf749ba5c3c7 100644
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
index fbbfb23a8739..931a54f1c5ca 100644
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
2.50.1


