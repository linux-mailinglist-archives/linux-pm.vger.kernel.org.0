Return-Path: <linux-pm+bounces-35379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD64BA006F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496BC4A2169
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A562DC791;
	Thu, 25 Sep 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EEq2Edtg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669572D9EF3;
	Thu, 25 Sep 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810695; cv=none; b=WX68l7Lt5ImdjVFNpD5yR8gnKZdESPh/vpCGGvKgINb2ykpDVUvIlc7a+SUa6vBW1NvmNq4IvjgRUNQyHebk4ydGrVEDeBAR0H6m8JnGkYMEJqo/rw9WUHyjeAGyWlcx5mV8iSBiQ/4219JMzuQSzRoQKmBth712vDVwavn0XjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810695; c=relaxed/simple;
	bh=kdhQOSWTYVrgxbYGEy8Sxj3IquAPonEI1tpFJXN2e1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byi0RpZhcLcXdByvh6cAVOOzcEVy97kJxeJ+voHMntmgvnO7K3V4afBEFymV6yMqVuZm0sEmwUFxUG71sgYJ2MgnRdub3yif1/nA1cHp+RiOWGjMC7mCPdL/1E6nKpA0v4lnOuWKLg1VAaukXmXGvK/3ONLjZT8x73bYbTkkEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EEq2Edtg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758810691;
	bh=kdhQOSWTYVrgxbYGEy8Sxj3IquAPonEI1tpFJXN2e1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEq2EdtgxduBCYInjMo9FrZ0ixsEOk0HBrORtIIHw7b7lc8Ja7bTHwGSfBQNT9GtP
	 Ndo0iRuVFMlSFwuPsgrDT2Rr4v6Gc5JmqWwfu7Tj/zxw3+rDsmwMNyM9pNBUaV1Buv
	 Q9g7h+0iOsD3XO8OfmuCIWsJ1zqbGb5MHB23SyBMeDa4ZoEfPF3TdUqbjrR0yJKENB
	 hqXpcu0WZJpA3Kfa2kpo1DPX6QIc5n+OG2SIzOkWdh8q10Z6MEXqPugIRYM08dzrTk
	 qipsnBNAOxtBDsHm4Kj97ehhNKiM7DaBrptVWWvi0lP7zYreP9q+apZqXs1Mnx0POi
	 P5Xky+ELgrdcw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1582617E13CD;
	Thu, 25 Sep 2025 16:31:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 3/5] pmdomain: mediatek: Add support for secure HWCCF infra power on
Date: Thu, 25 Sep 2025 16:31:14 +0200
Message-ID: <20250925143122.39796-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
References: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some SoCs, like the MediaTek Dimensity 9400 (MT6991), have granular
power controls and will disable power to the infracfg to save power
when the platform is in deeper sleep states (or when no IP in the
the infracfg macro-block is in use).

These chips also cannot control the infracfg power states directly
via AP register writes as those are protected by the secure world.

Add a new MTK_SCPD_INFRA_PWR_CTL cap and, if present, make a call
to the secure world to poweron the infracfg block, as the HWV IP
resides in there, when executing HWV domains power sequences.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 40 ++++++++++++++++++++--
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 36767f740f57..f400b0c6b5fd 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
 
 #include "mt6735-pm-domains.h"
 #include "mt6795-pm-domains.h"
@@ -51,6 +52,8 @@
 #define PWR_RTFF_SAVE_FLAG		BIT(27)
 #define PWR_RTFF_UFS_CLK_DIS		BIT(28)
 
+#define MTK_SIP_KERNEL_HWCCF_CONTROL	MTK_SIP_SMC_CMD(0x540)
+
 struct scpsys_domain {
 	struct generic_pm_domain genpd;
 	const struct scpsys_domain_data *data;
@@ -116,6 +119,15 @@ static bool scpsys_hwv_domain_is_enable_done(struct scpsys_domain *pd)
 	return (val[0] & mask) && (val[1] & mask) && !(val[2] & mask);
 }
 
+static int scpsys_sec_infra_power_on(bool on)
+{
+	struct arm_smccc_res res;
+	unsigned long cmd = on ? 1 : 0;
+
+	arm_smccc_smc(MTK_SIP_KERNEL_HWCCF_CONTROL, cmd, 0, 0, 0, 0, 0, 0, &res);
+	return res.a0;
+}
+
 static int scpsys_sram_enable(struct scpsys_domain *pd)
 {
 	u32 expected_ack, pdn_ack = pd->data->sram_pdn_ack_bits;
@@ -291,9 +303,15 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	u32 val;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL)) {
+		ret = scpsys_sec_infra_power_on(true);
+		if (ret)
+			return ret;
+	}
+
 	ret = scpsys_regulator_enable(pd->supply);
 	if (ret)
-		return ret;
+		goto err_infra;
 
 	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 	if (ret)
@@ -344,6 +362,9 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	/* It's done! Disable the HWV low power subsystem clocks */
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
+		scpsys_sec_infra_power_on(false);
+
 	return 0;
 
 err_disable_subsys_clks:
@@ -352,6 +373,9 @@ static int scpsys_hwv_power_on(struct generic_pm_domain *genpd)
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
 	scpsys_regulator_disable(pd->supply);
+err_infra:
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
+		scpsys_sec_infra_power_on(false);
 	return ret;
 };
 
@@ -363,9 +387,15 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
 	u32 val;
 	int ret;
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL)) {
+		ret = scpsys_sec_infra_power_on(true);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
 	if (ret)
-		return ret;
+		goto err_infra;
 
 	/* Make sure the HW Voter is idle and able to accept commands */
 	ret = regmap_read_poll_timeout_atomic(scpsys->base, hwv->done, val,
@@ -407,10 +437,16 @@ static int scpsys_hwv_power_off(struct generic_pm_domain *genpd)
 
 	scpsys_regulator_disable(pd->supply);
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
+		scpsys_sec_infra_power_on(false);
+
 	return 0;
 
 err_disable_subsys_clks:
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
+err_infra:
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_INFRA_PWR_CTL))
+		scpsys_sec_infra_power_on(false);
 	return ret;
 };
 
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index df4bf013709b..36adcfca80c6 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -16,6 +16,7 @@
 #define MTK_SCPD_SRAM_PDN_INVERTED	BIT(9)
 #define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
 #define MTK_SCPD_SKIP_RESET_B		BIT(11)
+#define MTK_SCPD_INFRA_PWR_CTL		BIT(12)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data ?		\
 					 (_scpd)->data->caps & (_x) :	\
 					 (_scpd)->hwv_data->caps & (_x))
-- 
2.51.0


