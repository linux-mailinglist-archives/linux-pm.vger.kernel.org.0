Return-Path: <linux-pm+bounces-23388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77AA4E3A4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17223884089
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07F255251;
	Tue,  4 Mar 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="obk45PT1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BF255247;
	Tue,  4 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101410; cv=none; b=a/kyvuzCyG/hpLgTJ2TRAUZLwa+a20k/Kc+M7FR9RuEYPKZ8+gr3XV7jkPmhnVUcBXRGpWKZG51o10cXa7DyWTD1NMpUtc/keYaiaN6ZEsKEOUuYJpPM1osxz71HnKJHqJcWBDDXC6M8WMXjbX4EVmr6xuAlNKBEFhYy2ayfBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101410; c=relaxed/simple;
	bh=pxGZiXC6za5vFQ3V/0fw9IlCjpRVWVwiCZ21S4dEkDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1LZF0YltAFyMA3DXyYQNGhaAIGrjU/B+sLMcR3zdW6Su/gGIRvFuQH6rvvUnUaeixYLisBadIfBI0ChpKjzbbGh36IWJefuCH9pxANxczUyYETJqE1OuhCxShbcF6FPowipXk6vXaRE30+GgyFQO1R63xxT5zbifmS5t75/9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=obk45PT1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101406;
	bh=pxGZiXC6za5vFQ3V/0fw9IlCjpRVWVwiCZ21S4dEkDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=obk45PT1hiFCwR4gOShJURghXzyJM+ZaDykUZb+JuDXWEwxjv2z5kNky2Acb68W6W
	 x5kqfPgxPrGUUyX8UYsFTFR5YC0LYdKXAqTBHVrlj1nwhBMwqx9wKES+jAuuSmTm85
	 Q+7B6MSyl/rsClN8FoRGDbJGjgrp2ttBMkWr0QwZY26CfXDbTzY1ZoVc13M3uZKl8V
	 c8JeCJKv+9G8NagN8krC0H6+rwdNNg2D6xVT4elSQs+hP6nHdL7lH2srzDG0tnx6CD
	 fw4HA+/I1EEBGq1G+W3TOO3ipEgx1ewsFTrMOGo4uc6HLo5CpmE5gPNG57G/IrdOAs
	 8w7xdUWinObWw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A1DEC17E07F8;
	Tue,  4 Mar 2025 16:16:41 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:48 -0300
Subject: [PATCH v3 07/20] ASoC: mediatek: mt6359-accdet: Drop dead code for
 EINT/GPIO IRQ handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-7-5b0eafc29f5b@collabora.com>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
In-Reply-To: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

The ACCDET supports two modes for IRQ generation: PMIC EINT or AP GPIO,
which in principle could be configured through a DT property. However
this DT property has no user nor is documented in a binding, and the
driver only implements the PMIC EINT case, so drop the unused code
intended to handle both cases.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 1d4481109f6e4f473610e0797c9d3c636bdf12cf..ce8a5e64e0b9ca508124043ca1f93aaa3cc5f9a0 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -31,9 +31,6 @@
 #define REGISTER_VAL(x)	((x) - 1)
 
 /* mt6359 accdet capability */
-#define ACCDET_PMIC_EINT_IRQ		BIT(0)
-#define ACCDET_AP_GPIO_EINT		BIT(1)
-
 #define ACCDET_PMIC_EINT0		BIT(2)
 #define ACCDET_PMIC_EINT1		BIT(3)
 #define ACCDET_PMIC_BI_EINT		BIT(4)
@@ -448,8 +445,7 @@ static void mt6359_accdet_jd_work(struct work_struct *work)
 		mt6359_accdet_recover_jd_setting(priv);
 	}
 
-	if (priv->caps & ACCDET_PMIC_EINT_IRQ)
-		recover_eint_setting(priv);
+	recover_eint_setting(priv);
 	mutex_unlock(&priv->res_lock);
 }
 
@@ -580,14 +576,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 
 	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
-	ret = of_property_read_u32(node, "mediatek,eint-use-ap", &tmp);
-	if (ret)
-		tmp = 0;
-	if (tmp == 0)
-		priv->caps |= ACCDET_PMIC_EINT_IRQ;
-	else if (tmp == 1)
-		priv->caps |= ACCDET_AP_GPIO_EINT;
-
 	ret = of_property_read_u32(node, "mediatek,eint-detect-mode",
 				   &priv->data->eint_detect_mode);
 	if (ret) {
@@ -902,10 +890,8 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 				   0x3 << RG_ANALOGFDEN_SFT);
 	}
 
-	if (priv->caps & ACCDET_PMIC_EINT_IRQ) {
-		config_eint_init_by_mode(priv);
-		config_digital_init_by_mode(priv);
-	}
+	config_eint_init_by_mode(priv);
+	config_digital_init_by_mode(priv);
 }
 
 int mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,

-- 
2.48.1


