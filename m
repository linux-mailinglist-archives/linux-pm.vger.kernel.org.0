Return-Path: <linux-pm+bounces-31942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C108FB1AFB8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93417189F619
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D425A341;
	Tue,  5 Aug 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VsKiWvLA"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A8257AC6;
	Tue,  5 Aug 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380127; cv=none; b=PTTIZUmAn3FrYx+w2Rki7X6mphNz/RXDObzABivsggtVG2a/+U3lPPbNDhmQE9yEYR8ZqZ8XxQVtKH3OeePsApjqDqOFiQj9FonPW8Ui9UyQFnl6pcu/Ae47CZgkAQ2lVcRmVlP2Bez68Ac53k9RL3EeKNz4SM3kv0FTbeSQj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380127; c=relaxed/simple;
	bh=u4Yqci3izjF1oykdtg2PDkkhxGSsUxJ2IJlwkoAKdJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTHFa5n210VM3pdBMqgj67GELdpDokyKQ0e5HKYCj1PcqVmOVSdUZ6/DYb/nbESbRjJYBR0UuEsHYZ2P1j4ai8INfLS39s4uUZU3DKj4hbo88xr2YYF2f3ZZilH52p86U4r3aT2wP6OXxVyy4JAvRm8e0pU23pMTey9d+BrBVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VsKiWvLA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380124;
	bh=u4Yqci3izjF1oykdtg2PDkkhxGSsUxJ2IJlwkoAKdJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsKiWvLAB3yL50Tb9vqrq15enZ6FXa3L6Dd1Quqjl32T5zNnTs9o0ySZcCf/a8TMx
	 Kbx9sOrOH3VazoyUy41YSSYyYHhQlulHQjAmLS1NQ4OHDqk9p8How8PzBg7aijE7k5
	 C1FLPnrjykZR5XfoAvXJ5lEHjYyVc2yE2Z7FiJe+c8+A4MjDgKQBK+7BEXApTXB0+g
	 EJq6r1hKFN3qln+OK1N7UqTrMpv8vL8J8uAVPoQqVywV6C7ix7yTGJTu2WHAFC031t
	 U9Q9BTPSShlzoPu3DaZHsz5xDm01CFYtZ/afkChTvMFjnHx4H+wnYtSJQ+GnQsezXM
	 r+ou6FIu4wD7A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4BB5317E0C8C;
	Tue,  5 Aug 2025 09:48:43 +0200 (CEST)
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
Subject: [PATCH v3 08/10] pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
Date: Tue,  5 Aug 2025 09:47:44 +0200
Message-ID: <20250805074746.29457-9-angelogioacchino.delregno@collabora.com>
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

New generation SoCs use a new RTFF Hardware to save power during
operation of various IPs, other than managing isolation of the
internal buck converters during powerup/down of power domains.

Since some of the power domains need different RTFF handling, add
a new scpys_rtff_type enumeration and hold the value for each
power domain in struct scpsys_domain_data.

If RTFF HW is available, the RTFF additional power sequences are
handled in scpsys_ctl_pwrseq_{on,off}().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 94 +++++++++++++++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h | 18 +++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index cf749ba5c3c7..0ebe7379b94e 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -39,6 +39,12 @@
 #define PWR_SRAM_CLKISO_BIT		BIT(5)
 #define PWR_SRAM_ISOINT_B_BIT		BIT(6)
 
+#define PWR_RTFF_SAVE			BIT(24)
+#define PWR_RTFF_NRESTORE		BIT(25)
+#define PWR_RTFF_CLK_DIS		BIT(26)
+#define PWR_RTFF_SAVE_FLAG		BIT(27)
+#define PWR_RTFF_UFS_CLK_DIS		BIT(28)
+
 struct scpsys_domain {
 	struct generic_pm_domain genpd;
 	const struct scpsys_domain_data *data;
@@ -247,7 +253,7 @@ static int scpsys_regulator_disable(struct regulator *supply)
 static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
-	bool tmp;
+	bool do_rtff_nrestore, tmp;
 	int ret;
 
 	/* subsys power on */
@@ -260,10 +266,72 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 	if (ret < 0)
 		return ret;
 
+	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
+
+	/* Wait for RTFF HW to sync buck isolation state if this is PCIe PHY RTFF */
+	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
+		udelay(5);
+
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
+	/*
+	 * RTFF HW state may be modified by secure world or remote processors.
+	 *
+	 * With the only exception of STOR_UFS, which always needs save/restore,
+	 * check if this power domain's RTFF is already on before trying to do
+	 * the NRESTORE procedure, otherwise the system will lock up.
+	 */
+	switch (pd->data->rtff_type) {
+	case SCPSYS_RTFF_TYPE_GENERIC:
+	case SCPSYS_RTFF_TYPE_PCIE_PHY:
+	{
+		u32 ctl_status;
+
+		regmap_read(scpsys->base, pd->data->ctl_offs, &ctl_status);
+		do_rtff_nrestore = ctl_status & PWR_RTFF_SAVE_FLAG;
+		break;
+	}
+	case SCPSYS_RTFF_TYPE_STOR_UFS:
+		/* STOR_UFS always needs NRESTORE */
+		do_rtff_nrestore = true;
+		break;
+	default:
+		do_rtff_nrestore = false;
+		break;
+	}
+
+	/* Return early if RTFF NRESTORE shall not be done */
+	if (!do_rtff_nrestore)
+		return 0;
+
+	switch (pd->data->rtff_type) {
+	case SCPSYS_RTFF_TYPE_GENERIC:
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE_FLAG);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+		break;
+	case SCPSYS_RTFF_TYPE_PCIE_PHY:
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE_FLAG);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+		break;
+	case SCPSYS_RTFF_TYPE_STOR_UFS:
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_UFS_CLK_DIS);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_NRESTORE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_UFS_CLK_DIS);
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
@@ -271,8 +339,32 @@ static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
 
+	switch (pd->data->rtff_type) {
+	case SCPSYS_RTFF_TYPE_GENERIC:
+	case SCPSYS_RTFF_TYPE_PCIE_PHY:
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE_FLAG);
+		break;
+	case SCPSYS_RTFF_TYPE_STOR_UFS:
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_UFS_CLK_DIS);
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_SAVE);
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_UFS_CLK_DIS);
+		break;
+	default:
+		break;
+	}
+
 	/* subsys power off */
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
+
+	/* Wait for RTFF HW to sync buck isolation state if this is PCIe PHY RTFF */
+	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
+		udelay(1);
+
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 931a54f1c5ca..b2e3dee03831 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -108,6 +108,22 @@ struct scpsys_bus_prot_data {
 	u8 flags;
 };
 
+/**
+ * enum scpsys_rtff_type - Type of RTFF Hardware for power domain
+ * @SCPSYS_RTFF_NONE:          RTFF HW not present or domain not RTFF managed
+ * @SCPSYS_RTFF_TYPE_GENERIC:  Non-CPU, peripheral-generic RTFF HW
+ * @SCPSYS_RTFF_TYPE_PCIE_PHY: PCI-Express PHY specific RTFF HW
+ * @SCPSYS_RTFF_TYPE_STOR_UFS: Storage (UFS) specific RTFF HW
+ * @SCPSYS_RTFF_TYPE_MAX:      Number of supported RTFF HW Types
+ */
+enum scpsys_rtff_type {
+	SCPSYS_RTFF_NONE = 0,
+	SCPSYS_RTFF_TYPE_GENERIC,
+	SCPSYS_RTFF_TYPE_PCIE_PHY,
+	SCPSYS_RTFF_TYPE_STOR_UFS,
+	SCPSYS_RTFF_TYPE_MAX
+};
+
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @name: The name of the power domain.
@@ -118,6 +134,7 @@ struct scpsys_bus_prot_data {
  * @ext_buck_iso_offs: The offset for external buck isolation
  * @ext_buck_iso_mask: The mask for external buck isolation
  * @caps: The flag for active wake-up action.
+ * @rtff_type: The power domain RTFF HW type
  * @bp_cfg: bus protection configuration for any subsystem
  */
 struct scpsys_domain_data {
@@ -129,6 +146,7 @@ struct scpsys_domain_data {
 	int ext_buck_iso_offs;
 	u32 ext_buck_iso_mask;
 	u16 caps;
+	enum scpsys_rtff_type rtff_type;
 	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
-- 
2.50.1


