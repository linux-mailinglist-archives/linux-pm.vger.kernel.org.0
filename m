Return-Path: <linux-pm+bounces-38449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46BC801BC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C56F64E4459
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DB2FFDE0;
	Mon, 24 Nov 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="E8LEDUOd"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA952FF668;
	Mon, 24 Nov 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982470; cv=pass; b=k50crv/usi/xm0D4N6aZrJoe5VrK7xLiTAfpTI0+7O2OLU921OUaBEeUxwvJKl/OfvsWfznhaBQr9trFL8y6qdCrAUNOw1AmKkxcZDiVPbfGIiLOp6YFTl1nmd82pwPZnVxYtt0Id/pFvPgaMQbTxpCLScA+N/xdStAkW7otplk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982470; c=relaxed/simple;
	bh=XRN7l5HCuSrAf9FdSg5zMg7Ti3S6RyZaosUN5M0VrsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DG0TwpsOFCyPvHM+nDnp7nDpue36yt1Naq34tNPURslvxEvuTIi3cLsmjnVn+7dE8DiuuXxlh200IEknrVFT8szrqC8TkItEarZ2AXPgISFTt2s2nv/l32LODd7XBTy7qsHq9aLZ0yX+cFWDZbM9KfbAYDCSDf5a5KYuSy1rljA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=E8LEDUOd; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982451; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hRaDMdBgpJUWieMHl93K55uMn5+++VP+xmhy5V24ajBKLeAMA81aPwZ3Ib/UZUDt4wiiLh8pif5qO/mwqy1hQG/fcRd80JGejoigiuvSJh4uYBah9Ur2BQ6myEYAh3U3W1ZrgOj6YXvIUxtLX/piyNxOqRI2AzLubocPv0zXIhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982451; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l/jpHg8ggSLyVTybJftVENEdxbGTU3I5XefcjT15QOs=; 
	b=F585uhLOtdK8SsEkgSZWOBkPSvqQ725D/D0vLyQY73Vx583Cy0v6Eh9dMrn02fAqlB7Kx18O82tPzxkcsagmtfUMPPDWrTE70iJiJpRNIP5Tjts105zS/6JUs9Wd7EoX23kM8npD1OGr6+MbckMg+WQ3IkpXGAY8VV12gvMliQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982451;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=l/jpHg8ggSLyVTybJftVENEdxbGTU3I5XefcjT15QOs=;
	b=E8LEDUOdHlC34iedGgQowUrAZJeBj0rbdTIcsdpgePSNRR9g2gINi+uKrMkxOLSS
	PPMhoatYXleKJDP8VoQAJ6li44binP5oEgv9Mn1PoXubr2zlwX2T7FIu3W/QMqXki2u
	cFIlH5j+1559MMy3QCvKYadWUgwORaMPCMpeN5j4=
Received: by mx.zohomail.com with SMTPS id 1763982450499916.9244462379016;
	Mon, 24 Nov 2025 03:07:30 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:59 +0100
Subject: [PATCH v2 10/13] soc: mediatek: mtk-dvfsrc: Rework bandwidth
 calculations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-10-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The code, as it is, plays fast and loose with bandwidth units. It also
doesn't specify its constraints in the actual maximum hardware value,
but as some roundabout thing that then ends up multiplied into the
actual hardware value constraint after some indirections. In part, this
is due to the use of individual members for storing each limit, instead
of making it possible to index them by type.

Rework all of this by adding const array members indexed by the
bandwidth type enum to the soc_data struct. This array expresses the
actual hardware value limitations, not a factor thereof.

Use the clamp function macro to clamp the values between the minimum and
maximum constraints after all the calculations, which also means the
code doesn't write nonsense to a hardware register when the math is
wrong, as it'll constrain after all the calculations.

Pass the type as the actual enum type as well, and not as an int. If
there's some type checking that can be extracted from the function
signature, then we may as well use it.

Don't needlessly explicitly cast return values to the return type
either; this is both unnecessary and makes it harder to spot type safety
issues.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 107 ++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index a43d6f913914..548a28f50242 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -64,12 +64,6 @@ enum mtk_dvfsrc_bw_type {
 	DVFSRC_BW_MAX,
 };
 
-struct dvfsrc_bw_constraints {
-	u16 max_dram_nom_bw;
-	u16 max_dram_peak_bw;
-	u16 max_dram_hrt_bw;
-};
-
 struct dvfsrc_opp {
 	u32 vcore_opp;
 	u32 dram_opp;
@@ -98,7 +92,7 @@ struct dvfsrc_soc_data {
 	const u8 *bw_units;
 	const bool has_emi_ddr;
 	const struct dvfsrc_opp_desc *opps_desc;
-	u32 (*calc_dram_bw)(struct mtk_dvfsrc *dvfsrc, int type, u64 bw);
+	u32 (*calc_dram_bw)(struct mtk_dvfsrc *dvfsrc, enum mtk_dvfsrc_bw_type type, u64 bw);
 	u32 (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
 	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
@@ -113,7 +107,22 @@ struct dvfsrc_soc_data {
 	void (*set_vscp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
 	int (*wait_for_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
 	int (*wait_for_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
-	const struct dvfsrc_bw_constraints *bw_constraints;
+
+	/**
+	 * @bw_max_constraints - array of maximum bandwidth for this hardware
+	 *
+	 * indexed by &enum mtk_dvfsrc_bw_type, storing the maximum permissible
+	 * hardware value for each bandwidth type.
+	 */
+	const u32 *const bw_max_constraints;
+
+	/**
+	 * @bw_min_constraints - array of minimum bandwidth for this hardware
+	 *
+	 * indexed by &enum mtk_dvfsrc_bw_type, storing the minimum permissible
+	 * hardware value for each bandwidth type.
+	 */
+	const u32 *const bw_min_constraints;
 };
 
 static u32 dvfsrc_readl(struct mtk_dvfsrc *dvfs, u32 offset)
@@ -383,59 +392,62 @@ static u32 dvfsrc_get_opp_count_v4(struct mtk_dvfsrc *dvfsrc)
 	return FIELD_GET(DVFSRC_V4_BASIC_CTRL_OPP_COUNT, val) + 1;
 }
 
-static u32 dvfsrc_calc_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, int type, u64 bw)
+static u32
+dvfsrc_calc_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, enum mtk_dvfsrc_bw_type type, u64 bw)
 {
-	return (u32)div_u64(bw, 100 * 1000);
+	return clamp_val(div_u64(bw, 100 * 1000), dvfsrc->dvd->bw_min_constraints[type],
+			 dvfsrc->dvd->bw_max_constraints[type]);
 }
 
-static u32 dvfsrc_calc_dram_bw_v4(struct mtk_dvfsrc *dvfsrc, int type, u64 bw)
+/**
+ * dvfsrc_calc_dram_bw_v4 - convert kbps to hardware register bandwidth value
+ * @dvfsrc: pointer to the &struct mtk_dvfsrc of this driver instance
+ * @type: one of %DVFSRC_BW_AVG, %DVFSRC_BW_PEAK, or %DVFSRC_BW_HRT
+ * @bw: the bandwidth in kilobits per second
+ *
+ * Returns the hardware register value appropriate for expressing @bw, clamped
+ * to hardware limits.
+ */
+static u32
+dvfsrc_calc_dram_bw_v4(struct mtk_dvfsrc *dvfsrc, enum mtk_dvfsrc_bw_type type, u64 bw)
 {
 	u8 bw_unit = dvfsrc->dvd->bw_units[type];
 	u64 bw_mbps;
+	u32 bw_hw;
 
 	if (type < DVFSRC_BW_AVG || type >= DVFSRC_BW_MAX)
 		return 0;
 
 	bw_mbps = div_u64(bw, 1000);
-	return (u32)div_u64((bw_mbps + bw_unit - 1), bw_unit);
+	bw_hw = div_u64((bw_mbps + bw_unit - 1), bw_unit);
+	return clamp_val(bw_hw, dvfsrc->dvd->bw_min_constraints[type],
+			 dvfsrc->dvd->bw_max_constraints[type]);
 }
 
 static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
-				    int type, u16 max_bw, u16 min_bw, u64 bw)
+				    enum mtk_dvfsrc_bw_type type, u64 bw)
 {
-	u32 new_bw = dvfsrc->dvd->calc_dram_bw(dvfsrc, type, bw);
-
-	/* If bw constraints (in mbps) are defined make sure to respect them */
-	if (max_bw)
-		new_bw = min(new_bw, max_bw);
-	if (min_bw && new_bw > 0)
-		new_bw = max(new_bw, min_bw);
+	u32 bw_hw = dvfsrc->dvd->calc_dram_bw(dvfsrc, type, bw);
 
-	dvfsrc_writel(dvfsrc, reg, new_bw);
+	dvfsrc_writel(dvfsrc, reg, bw_hw);
 
 	if (type == DVFSRC_BW_AVG && dvfsrc->dvd->has_emi_ddr)
-		dvfsrc_writel(dvfsrc, DVFSRC_SW_EMI_BW, bw);
+		dvfsrc_writel(dvfsrc, DVFSRC_SW_EMI_BW, bw_hw);
 }
 
 static void dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
-	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_nom_bw;
-
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_BW, DVFSRC_BW_AVG, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_BW, DVFSRC_BW_AVG, bw);
 };
 
 static void dvfsrc_set_dram_peak_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
-	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_peak_bw;
-
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_PEAK_BW, DVFSRC_BW_PEAK, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_PEAK_BW, DVFSRC_BW_PEAK, bw);
 }
 
 static void dvfsrc_set_dram_hrt_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
 {
-	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_hrt_bw;
-
-	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_HRT_BW, DVFSRC_BW_HRT, max_bw, 0, bw);
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_HRT_BW, DVFSRC_BW_HRT, bw);
 }
 
 static void dvfsrc_set_opp_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
@@ -688,11 +700,22 @@ static int mtk_dvfsrc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dvfsrc_bw_constraints dvfsrc_bw_constr_v1 = { 0, 0, 0 };
-static const struct dvfsrc_bw_constraints dvfsrc_bw_constr_v2 = {
-	.max_dram_nom_bw = 255,
-	.max_dram_peak_bw = 255,
-	.max_dram_hrt_bw = 1023,
+static const u32 dvfsrc_bw_min_constr_none[DVFSRC_BW_MAX] = {
+	[DVFSRC_BW_AVG] = 0,
+	[DVFSRC_BW_PEAK] = 0,
+	[DVFSRC_BW_HRT] = 0,
+};
+
+static const u32 dvfsrc_bw_max_constr_v1[DVFSRC_BW_MAX] = {
+	[DVFSRC_BW_AVG] = U32_MAX,
+	[DVFSRC_BW_PEAK] = U32_MAX,
+	[DVFSRC_BW_HRT] = U32_MAX,
+};
+
+static const u32 dvfsrc_bw_max_constr_v2[DVFSRC_BW_MAX] = {
+	[DVFSRC_BW_AVG] = 65535,
+	[DVFSRC_BW_PEAK] = 65535,
+	[DVFSRC_BW_HRT] = 1023,
 };
 
 static const struct dvfsrc_opp dvfsrc_opp_mt6893_lp4[] = {
@@ -725,7 +748,8 @@ static const struct dvfsrc_soc_data mt6893_data = {
 	.set_vscp_level = dvfsrc_set_vscp_level_v2,
 	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v2,
 	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v1,
-	.bw_constraints = &dvfsrc_bw_constr_v2,
+	.bw_max_constraints = dvfsrc_bw_max_constr_v2,
+	.bw_min_constraints = dvfsrc_bw_min_constr_none,
 };
 
 static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
@@ -763,7 +787,8 @@ static const struct dvfsrc_soc_data mt8183_data = {
 	.set_vcore_level = dvfsrc_set_vcore_level_v1,
 	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v1,
 	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v1,
-	.bw_constraints = &dvfsrc_bw_constr_v1,
+	.bw_max_constraints = dvfsrc_bw_max_constr_v1,
+	.bw_min_constraints = dvfsrc_bw_min_constr_none,
 };
 
 static const struct dvfsrc_opp dvfsrc_opp_mt8195_lp4[] = {
@@ -797,7 +822,8 @@ static const struct dvfsrc_soc_data mt8195_data = {
 	.set_vscp_level = dvfsrc_set_vscp_level_v2,
 	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v2,
 	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v1,
-	.bw_constraints = &dvfsrc_bw_constr_v2,
+	.bw_max_constraints = dvfsrc_bw_max_constr_v2,
+	.bw_min_constraints = dvfsrc_bw_min_constr_none,
 };
 
 static const u8 mt8196_bw_units[] = {
@@ -825,7 +851,8 @@ static const struct dvfsrc_soc_data mt8196_data = {
 	.set_vscp_level = dvfsrc_set_vscp_level_v2,
 	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v4,
 	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v4,
-	.bw_constraints = &dvfsrc_bw_constr_v1,
+	.bw_max_constraints = dvfsrc_bw_max_constr_v2,
+	.bw_min_constraints = dvfsrc_bw_min_constr_none,
 };
 
 static const struct of_device_id mtk_dvfsrc_of_match[] = {

-- 
2.52.0


