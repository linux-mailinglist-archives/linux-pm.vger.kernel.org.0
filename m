Return-Path: <linux-pm+bounces-30278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D9AFB1C3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17551898A57
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9F29ACDA;
	Mon,  7 Jul 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Icih2SeW"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BB29A326;
	Mon,  7 Jul 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885784; cv=none; b=E+JCbmEl8gti3c4kz1RBlKiCRvHqA9foG4Va5JfAM1tG4msiIyAxbuvDKm3OQFdUwCnr+J8NaMNJRBNJU2D1+vuSIP5kS7sk6Iwv6CyxJ2fgUPZJiT2JQJqClBkK3vMcvM93b3G3NhKq2xZhTnVDIfYKtlRRKRBHcJPfK3b2K3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885784; c=relaxed/simple;
	bh=ET/2n99K59BCvtfpKkwNLwUv6RmwwfRjPpRaSbab+BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJHlzKyB8To92PypXooZanDgnhEwuMJyz6cYIOh3M8+1a2tk40i4ULQe6zGKvwcGdd5YrymxxzAxqtoMLV5fms++0S/HD2S6IIwWa57D4kLmWE+aSoakjIAWhJxjCKlrwxVptnrn+15hgUhQkOn87YzABdcN8J1Yc95q8ApigG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Icih2SeW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885780;
	bh=ET/2n99K59BCvtfpKkwNLwUv6RmwwfRjPpRaSbab+BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Icih2SeWq4BReVJcuNuRwVJoZqaBPPqiHUoBla1AmjeCP+nUvQrWr0KM/iS0BkS+n
	 a3vqoq0Izy5OGzhNvtzOYIQ0LFfUBhfKIuXPsD/Zm9//XnjOzxifRM/L7n9/ynNSN7
	 uVa8BR5jU2uj5VgmxQlgW2nu7/nBN0WNQYKatYEJKFUgL6V4TEoznJNFICb0DyZDOX
	 wFqdjdmtmEHEI/IqkixJoj/rxvTDSI5bKk2XyqOztLJuhog2KmcEduB47nYf+2Cy31
	 9EqLBmTWo/JbmYDhmZwnrUFble2QZS6+e2nG7v7nzgU9XRKX4Im+9As3IdIHTQk1c0
	 GGXxvBsK8Xu2A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C064C17E1136;
	Mon,  7 Jul 2025 12:56:19 +0200 (CEST)
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
Subject: [PATCH v2 05/10] pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
Date: Mon,  7 Jul 2025 12:56:00 +0200
Message-ID: <20250707105605.98248-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some SoCs, and even some subsystems in the same SoC, may have the
logic for SRAM power-down inverted, as in, setting the bit means
"power down" and unsetting means "power up": this is because some
hardware subsystems use this as a power-lock indication and some
use this as a power down one (for example, usually, the modem ss
has it inverted!).

In preparation for adding support for power domains with inverted
SRAM_PDN bits, add a new MTK_SCPD_SRAM_PDN_INVERTED flag and check
for it in scpsys_sram_enable() and scpsys_sram_disable().

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 27 ++++++++++++++++------
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 9da18238496b..dd7f5f377271 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -79,16 +79,23 @@ static bool scpsys_domain_is_on(struct scpsys_domain *pd)
 
 static int scpsys_sram_enable(struct scpsys_domain *pd)
 {
-	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	u32 expected_ack, pdn_ack = pd->data->sram_pdn_ack_bits;
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
 	int ret;
 
-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_PDN_INVERTED)) {
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+		expected_ack = pdn_ack;
+	} else {
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+		expected_ack = 0;
+	}
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 	ret = regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
-				       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+				       (tmp & pdn_ack) == expected_ack,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 	if (ret < 0)
 		return ret;
 
@@ -103,7 +110,7 @@ static int scpsys_sram_enable(struct scpsys_domain *pd)
 
 static int scpsys_sram_disable(struct scpsys_domain *pd)
 {
-	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	u32 expected_ack, pdn_ack = pd->data->sram_pdn_ack_bits;
 	struct scpsys *scpsys = pd->scpsys;
 	unsigned int tmp;
 
@@ -113,12 +120,18 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_SRAM_ISOINT_B_BIT);
 	}
 
-	regmap_set_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_SRAM_PDN_INVERTED)) {
+		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+		expected_ack = 0;
+	} else {
+		regmap_set_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits);
+		expected_ack = pdn_ack;
+	}
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
-					(tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
-					MTK_POLL_TIMEOUT);
+					(tmp & pdn_ack) == expected_ack,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
 static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 4f2d331a866a..fbbfb23a8739 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -13,6 +13,7 @@
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
 #define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
 #define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(8)
+#define MTK_SCPD_SRAM_PDN_INVERTED	BIT(9)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.49.0


