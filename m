Return-Path: <linux-pm+bounces-29287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D49AE3F47
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA01188E78B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B61262803;
	Mon, 23 Jun 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZOcMmHra"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E002609F5;
	Mon, 23 Jun 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680124; cv=none; b=QFm467+Vk3ruG/LEXNo4CE5B9BJb2KxsV7nqTnC36iOeQp2cVH+U3PF1Wjyka6VfMJBWUZ6DF3EvYJcOJqr+283tWfDAlT51n5A9OOo+E6YACuZe9KM9Vjx83Sqc/T5AshA28XS2kEf2AXe9FM/hhFAHpbJ3IARNVLUS0phifCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680124; c=relaxed/simple;
	bh=q9K3jmOUIo44g3MRZ+Kf/mQgVXisCXrGe4rgUFmADVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP7ehNcXwMP19lF8WBzRfiBbLGlPlOVKKLe8MTAcj1ybgPdyQYMLYadXrxyIRZgQqeSBTOQHMtEswPlwJsyr/sKdqqKTKZGJKBi7uud5WjFeoylkyNkd6QDMUC84QK4IvdkREVaoCL/WuxMNbMvz2VIZvu80noX/OWc0G6mJ2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZOcMmHra; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680121;
	bh=q9K3jmOUIo44g3MRZ+Kf/mQgVXisCXrGe4rgUFmADVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOcMmHra+kCJo1kxkJy0tNT0PY7RXkrKHXl8QtaD9pB6JVF0Y0jXBadQeDyjfu/2Q
	 yRmUDiS7MeZhdXgy3VuX/ON+aDpIpgc0+78j0UOO7vdd1hIN/TtJV+xm4axUf50aUf
	 eCVyj/XRBbj3mz2x2erFnpNNJMBFvCF/q7LziINmoUrKOOLblTR+0WI2VxU8nHonv+
	 0ErlbguWYdY0isIket2E7PhFRRl5qid5BG340bgXSeDRC4YhQ3vF9ytVMHhw0i7uW6
	 RsJGxJzECmJbj9MAuJn/Z8BHRfyOtiDmzrim3aM6QWq/Wu8JVN6YCzUMvIDj/+1rN1
	 n3155XCviRBXQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 67D7F17E1560;
	Mon, 23 Jun 2025 14:02:00 +0200 (CEST)
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
Subject: [PATCH v1 03/13] pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
Date: Mon, 23 Jun 2025 14:01:44 +0200
Message-ID: <20250623120154.109429-4-angelogioacchino.delregno@collabora.com>
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

Some SoCs, and even some subsystems in the same SoC, may have the
logic for SRAM power-down inverted, as in, setting the bit means
"power down" and unsetting means "power up": this is because some
hardware subsystems use this as a power-lock indication and some
use this as a power down one (for example, usually, the modem ss
has it inverted!).

In preparation for adding support for power domains with inverted
SRAM_PDN bits, add a new MTK_SCPD_SRAM_PDN_INVERTED flag and check
for it in scpsys_sram_enable() and scpsys_sram_disable().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 27 ++++++++++++++++------
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 8c1b5a4851a1..2a430e7cd353 100644
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
index 2a71989bc2b4..f7f0a5fb383b 100644
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


