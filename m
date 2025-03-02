Return-Path: <linux-pm+bounces-23234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E845A4B33E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02211188FF04
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7591EB1B6;
	Sun,  2 Mar 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZIy7+JTb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADB1EB1B2;
	Sun,  2 Mar 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933100; cv=none; b=mKYzJpzc0vRHEmIt/koqmS5BUYNR655jWN0SE3w6UXboaE8bWQeEHtup0BxL3zqw87hbBemRFR5Qo9teyDWPjSmWzOxLBJFxvflTByaPklstXPihaAwVPAT6Uyz4OqBpz3qZPpmRgSFIAwUncFC2VGojimP43R8L3WAyyuzeBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933100; c=relaxed/simple;
	bh=sdW1yXEUmXq8SNfh7ww/5Pnhe7bTSRPgObGL9j+2/Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3QX+Qv0KAOcPupMSpaD1pLS31UAOKEbLo7XrWNA+XjhfKeyusz9rJ8zii5f0H4O1+ZhPFl2/MyZpo4pKBPJLPOGeYwoVZTsoLbcqHXKisli9ZkanJ4u8wZWMKkvC6U/m9L8DQHSUKF9Cgpzd44WyZ4LIFpq6V/t3dN/tCe3UPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZIy7+JTb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933097;
	bh=sdW1yXEUmXq8SNfh7ww/5Pnhe7bTSRPgObGL9j+2/Hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZIy7+JTbM9fMzJprdw3y+a2zoyZdq7Aqo+e2qy06/lEZipYow/n4TWeLRJL650CaH
	 lzpM1/wH7W41q2xg/fkVw7BbEJySP0iPf/qwgXxVI/WO5duy45VpD3+SmIcuUG8dIJ
	 M0S+BNhHCl+xcNOGnlehdvFCc+gvtWU3oy6lab4DEKO60GB1CekZED7EmKrICMw+OQ
	 wq7mzOgw3Y32CcA4qCSL++AQof7MjA5BlMi+XN4sSeE4o7XflSi2e4raCW4TlfBBlc
	 VAPcpuNF5mQ2tHlbJpCL7ChSRt4Rb2nJKX4dgUDdHfxiKkjE9zEPicK/5d6HJq8OGA
	 t+CPhCiDC26fQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FEAB17E023F;
	Sun,  2 Mar 2025 17:31:32 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:46 -0300
Subject: [PATCH v2 07/20] ASoC: mediatek: mt6359-accdet: Drop dead code for
 EINT/GPIO IRQ handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-7-5bd633ee0d47@collabora.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
In-Reply-To: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
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


