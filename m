Return-Path: <linux-pm+bounces-27886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F3AC9069
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193364E04AF
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA42288C0;
	Fri, 30 May 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TUtxtTDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271A1E1DE3;
	Fri, 30 May 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612355; cv=pass; b=EaQxrAxnjgpNvarwFTsog8MdJX9cAPEHKEjx5q5g6j4HglYjU8R+QmhQSBrMikT4RVraeY5ZxLHlwDTAqEoF3OwKhHsIXJHZbjrvW4j1+8/umQf6DoDLPFmrekXLGZytXSOZDI7RDV6HOwff1uUYrSIvoCR3AFfMrZ8rVLtxgtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612355; c=relaxed/simple;
	bh=sKm/6tWM5Dt0t5geIE4cRYOZ5L9dPbQP5AXesJ03dk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQgyjy8qqtyB/zYOrWs6eC+NOhQBn+9276dcDeElEsL6IFMWObx5t2hBcekfgGVi8AE1RHvLngKqz52AUlzq+MCCnxheqQGUECg3Vu5itFi8iAr72a50qfASRLGRpTsSYrFIRqchFPdn9qg2yp93mg0Gw3CeuOImg9lEwGGS8GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=TUtxtTDX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748612327; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ca2JV1NvoRKv5pME+qb9G/ZrKNrPhFrJv4PWVsA586GumZI7xFu0nY1/ZmG7c7/RMPLDPTEtwdgo9zbD9QOQ6QmIvRxzHx2osUOcaOao5389zazozFKOBocEIv8iXm2z3p/zpAFlbcGIFe/+4UHge9vxhInXLvoFO+yD8CnHk4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748612327; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V3OqSA9b11oKNgkPDYr1xA9wl1ljVHhNL13TiqJ42tA=; 
	b=CORaZ4hP1D6sx4LhiK+ihZQEJKwHBDfu0HlJqsUpqY8SQMjVwVM0L85w6sd4LKjhq+oUF3JUxtvnnupO+2rbUfYEhigUm4Ns9yZCCRn3b32PCxfNGIS1KJtHZpjqOrB8JWxSo8T9daAjFtO7gqVc+agGextqVv1k3xNMK6s2NPM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748612327;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=V3OqSA9b11oKNgkPDYr1xA9wl1ljVHhNL13TiqJ42tA=;
	b=TUtxtTDXOcsQVd3PeEEi5CSpXzuFLcz/yiAJPn/ts3eUJKscSAj6mfzBqm+fQzeM
	IaR8BX7vh+Mps0TLUMBE7GFGIcMz+UY+64bVzExGGxt9NZ57lcVUKUG/o6tyOSg5Qs4
	uD+NJ6b06t8L0xoovPIwj1TxWeqACSqnpLg2vQSo=
Received: by mx.zohomail.com with SMTPS id 1748612325008737.6186102251434;
	Fri, 30 May 2025 06:38:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 30 May 2025 15:38:09 +0200
Subject: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
In-Reply-To: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Rockchip RK3588 SoC can also support LPDDR5 memory. This type of
memory needs some special case handling in the rockchip-dfi driver.

Add support for it in rockchip-dfi, as well as the needed GRF register
definitions.

This has been tested as returning both the right cycle count and
bandwidth on a LPDDR5 board where the CKR bit is 1. I couldn't test
whether the values are correct on a system where CKR is 0, as I'm not
savvy enough with the Rockchip tooling to know whether this can be set
in the DDR init blob.

Downstream has some special case handling for a hardware version where
not just the control bits differ, but also the register. Since I don't
know whether that hardware version is in any production silicon, it's
left unimplemented for now, with an error message urging users to report
if they have such a system.

There is a slight change of behaviour for non-LPDDR5 systems: instead of
writing 0 as the control flags to the control register and pretending
everything is alright if the memory type is unknown, we now explicitly
return an error.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 84 ++++++++++++++++++++++++++++--------
 include/soc/rockchip/rk3588_grf.h    |  8 +++-
 include/soc/rockchip/rockchip_grf.h  |  1 +
 3 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 54effb63519653d20b40eed88681330983399a77..5a2c9badcc64c552303c2f55c52e5420dec5ffc1 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -34,15 +34,18 @@
 
 /* DDRMON_CTRL */
 #define DDRMON_CTRL	0x04
+#define DDRMON_CTRL_LPDDR5		BIT(6)
 #define DDRMON_CTRL_DDR4		BIT(5)
 #define DDRMON_CTRL_LPDDR4		BIT(4)
 #define DDRMON_CTRL_HARDWARE_EN		BIT(3)
 #define DDRMON_CTRL_LPDDR23		BIT(2)
 #define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
 #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
-#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
+#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_LPDDR5 | \
+					 DDRMON_CTRL_DDR4 | \
 					 DDRMON_CTRL_LPDDR4 | \
 					 DDRMON_CTRL_LPDDR23)
+#define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
 
 #define DDRMON_CH0_WR_NUM		0x20
 #define DDRMON_CH0_RD_NUM		0x24
@@ -116,13 +119,60 @@ struct rockchip_dfi {
 	int buswidth[DMC_MAX_CHANNELS];
 	int ddrmon_stride;
 	bool ddrmon_ctrl_single;
+	u32 lp5_bank_mode;
+	bool lp5_ckr;	/* true if in 4:1 command-to-data clock ratio mode */
 	unsigned int count_multiplier;	/* number of data clocks per count */
 };
 
+static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl,
+					u32 *mask)
+{
+	u32 ddrmon_ver;
+
+	*mask = DDRMON_CTRL_DDR_TYPE_MASK;
+
+	switch (dfi->ddr_type) {
+	case ROCKCHIP_DDRTYPE_LPDDR2:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
+		*ctrl = DDRMON_CTRL_LPDDR23;
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4X:
+		*ctrl = DDRMON_CTRL_LPDDR4;
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR5:
+		ddrmon_ver = readl_relaxed(dfi->regs);
+		if (ddrmon_ver < 0x40) {
+			*ctrl = DDRMON_CTRL_LPDDR5 | dfi->lp5_bank_mode;
+			*mask |= DDRMON_CTRL_LP5_BANK_MODE_MASK;
+			break;
+		}
+
+		/*
+		 * As it is unknown whether the unpleasant special case
+		 * behaviour used by the vendor kernel is needed for any
+		 * shipping hardware, ask users to report if they have
+		 * some of that hardware.
+		 */
+		dev_err(&dfi->edev->dev,
+			"unsupported DDRMON version 0x%04X, please let linux-rockchip know!\n",
+			ddrmon_ver);
+		return -EOPNOTSUPP;
+	default:
+		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
+			dfi->ddr_type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 {
 	void __iomem *dfi_regs = dfi->regs;
 	int i, ret = 0;
+	u32 ctrl;
+	u32 ctrl_mask;
 
 	mutex_lock(&dfi->mutex);
 
@@ -136,8 +186,11 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
+	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl, &ctrl_mask);
+	if (ret)
+		goto out;
+
 	for (i = 0; i < dfi->max_channels; i++) {
-		u32 ctrl = 0;
 
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
@@ -147,21 +200,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
-		/* set ddr type to dfi */
-		switch (dfi->ddr_type) {
-		case ROCKCHIP_DDRTYPE_LPDDR2:
-		case ROCKCHIP_DDRTYPE_LPDDR3:
-			ctrl = DDRMON_CTRL_LPDDR23;
-			break;
-		case ROCKCHIP_DDRTYPE_LPDDR4:
-		case ROCKCHIP_DDRTYPE_LPDDR4X:
-			ctrl = DDRMON_CTRL_LPDDR4;
-			break;
-		default:
-			break;
-		}
-
-		writel_relaxed(HIWORD_UPDATE(ctrl, DDRMON_CTRL_DDR_TYPE_MASK),
+		writel_relaxed(HIWORD_UPDATE(ctrl, ctrl_mask),
 			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
 
 		/* enable count, use software mode */
@@ -652,6 +691,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
 		break;
 	case ROCKCHIP_DDRTYPE_LPDDR4:
 	case ROCKCHIP_DDRTYPE_LPDDR4X:
+	case ROCKCHIP_DDRTYPE_LPDDR5:
 		dfi->burst_len = 16;
 		break;
 	}
@@ -730,7 +770,7 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
 static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 {
 	struct regmap *regmap_pmu = dfi->regmap_pmu;
-	u32 reg2, reg3, reg4;
+	u32 reg2, reg3, reg4, reg6;
 
 	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG2, &reg2);
 	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG3, &reg3);
@@ -757,6 +797,14 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	dfi->ddrmon_stride = 0x4000;
 	dfi->count_multiplier = 2;
 
+	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR5) {
+		regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG6, &reg6);
+		dfi->lp5_bank_mode = FIELD_GET(RK3588_PMUGRF_OS_REG6_LP5_BANK_MODE, reg6) << 7;
+		dfi->lp5_ckr = FIELD_GET(RK3588_PMUGRF_OS_REG6_LP5_CKR, reg6);
+		if (dfi->lp5_ckr)
+			dfi->count_multiplier *= 2;
+	}
+
 	return 0;
 };
 
diff --git a/include/soc/rockchip/rk3588_grf.h b/include/soc/rockchip/rk3588_grf.h
index 630b35a550640e57f1b5a50dfbe362653a7cbcc1..02a7b2432d9942e15a77424c44fefec189faaa33 100644
--- a/include/soc/rockchip/rk3588_grf.h
+++ b/include/soc/rockchip/rk3588_grf.h
@@ -12,7 +12,11 @@
 #define RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
 #define RK3588_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
 
-#define RK3588_PMUGRF_OS_REG4           0x210
-#define RK3588_PMUGRF_OS_REG5           0x214
+#define RK3588_PMUGRF_OS_REG4				0x210
+#define RK3588_PMUGRF_OS_REG5				0x214
+#define RK3588_PMUGRF_OS_REG6				0x218
+#define RK3588_PMUGRF_OS_REG6_LP5_BANK_MODE		GENMASK(2, 1)
+/* Whether the LPDDR5 is in 2:1 (= 0) or 4:1 (= 1) CKR a.k.a. DQS mode */
+#define RK3588_PMUGRF_OS_REG6_LP5_CKR			BIT(0)
 
 #endif /* __SOC_RK3588_GRF_H */
diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/rockchip_grf.h
index e46fd72aea8d1f649768a3269b85176dacceef0e..41c7bb26fd5387df85e5b58186b67bf74706f360 100644
--- a/include/soc/rockchip/rockchip_grf.h
+++ b/include/soc/rockchip/rockchip_grf.h
@@ -13,6 +13,7 @@ enum {
 	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
 	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
 	ROCKCHIP_DDRTYPE_LPDDR4X = 8,
+	ROCKCHIP_DDRTYPE_LPDDR5	= 9,
 };
 
 #endif /* __SOC_ROCKCHIP_GRF_H */

-- 
2.49.0


