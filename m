Return-Path: <linux-pm+bounces-23393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A2A4E39F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A006C880D35
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBD292F93;
	Tue,  4 Mar 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gn35RUFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE733292F8A;
	Tue,  4 Mar 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101437; cv=none; b=gdqohLbFoqyFdLwOHtAAewDRe5GSGs3YSbJTPgiDSrBXxONqHQ2X6U8JSARJc9/YtaCRzBrf/OaDKTRzIgIr19oGdJVGKLzA1QZktHrOHiqb/dUD2IPEcd616YqgI8B2oHvamMbRUYZ53Wd/8PSReK/g2xU3l1JpBXHbDciZEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101437; c=relaxed/simple;
	bh=Vr2iMt1JwvPbsT2boRLW+AKpWeiECbyHNYOMDVwTEG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRkq214CCwReAZff2wZj2LUOqPjWeMsI/qIV1a1fiXFj67xxl3TvfZvEisCS3lZ/8FyD7jQ5G4SWK1t9hsH9oHdzwDooBsDtKFNeZ/dzAbqZMnL5H4boorpSBzIOymYvqbUaFu0zLqiMrAdORy2CGBGn3AZcZhWlGmpvIr1dpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gn35RUFY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101434;
	bh=Vr2iMt1JwvPbsT2boRLW+AKpWeiECbyHNYOMDVwTEG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gn35RUFYre4goK7wAmCgB0JVr0YL26SRouOxY/8hlQOFyO9TLSTOQSCmP/M2Sq74p
	 TvuXpkUZEEhkVBMh7C7gsoSg+YuzHOSfoyc3H/40ijUomlG64V6dMFMK2Ynd3xjnkv
	 12Stb/ylR7M05X4ntqzCdT6ORR0/Uk8SCdXSusOvml8MK6IE9QClKgiX2wGiJlGHAT
	 7lv8xjxGHooLedsx+bnmEDJk8ggNBY/jIJhcuFWcaKdzZLrdL3kLy0myLyS5GyYThG
	 ZNER7Wz/heAW5SyDirqK6B32hbSpO9tXRayBZmkbx9COwSRvupMLEgaI+vnHqrlNyD
	 YOENSHXkqpCdQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 194D617E07F8;
	Tue,  4 Mar 2025 16:17:08 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:53 -0300
Subject: [PATCH v3 12/20] ASoC: mediatek: mt6359-accdet: Always use
 internal resistor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-12-5b0eafc29f5b@collabora.com>
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

The code currently reads a property mediatek,eint-use-ext-res with
values ranging between 0 and 4. Not only should this be a boolean
property, but there's no need for it to even be a DT property, seeing as
all current boards will use the internal resistor anyway. Since there's
no current dt-binding or Devicetree user of this property, remove its
handling and make the driver always configure the internal resistor.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 53 +++++++++++-----------------------------
 sound/soc/codecs/mt6359-accdet.h |  1 -
 2 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index d78d7516342a5c2273b1c2962c0346646aa6390f..e04cfb9a607aa5d38d46329eb1387545fda37ccc 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -82,14 +82,10 @@ static unsigned int adjust_eint_analog_setting(struct mt6359_accdet *priv)
 					   RG_EINT1CONFIGACCDET_MASK_SFT,
 					   BIT(RG_EINT1CONFIGACCDET_SFT));
 		}
-		if (priv->data->eint_use_ext_res == 0x3 ||
-		    priv->data->eint_use_ext_res == 0x4) {
-			/*select 500k, use internal resistor */
-			regmap_update_bits(priv->regmap,
-					   RG_EINT0HIRENB_ADDR,
-					   RG_EINT0HIRENB_MASK_SFT,
-					   BIT(RG_EINT0HIRENB_SFT));
-		}
+		/*select 500k, use internal resistor */
+		regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
+				   RG_EINT0HIRENB_MASK_SFT,
+				   BIT(RG_EINT0HIRENB_SFT));
 	}
 	return 0;
 }
@@ -543,13 +539,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	else if (tmp == 2)
 		priv->caps |= ACCDET_PMIC_BI_EINT;
 
-	ret = of_property_read_u32(node, "mediatek,eint-use-ext-res",
-				   &priv->data->eint_use_ext_res);
-	if (ret) {
-		/* eint use internal resister */
-		priv->data->eint_use_ext_res = 0x0;
-	}
-
 	ret = of_property_read_u32(node, "mediatek,eint-comp-vth",
 				   &priv->data->eint_comp_vth);
 	if (ret)
@@ -651,30 +640,16 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 	if (priv->data->eint_detect_mode == 0x1 ||
 	    priv->data->eint_detect_mode == 0x2 ||
 	    priv->data->eint_detect_mode == 0x3) {
-		if (priv->data->eint_use_ext_res == 0x1) {
-			if (priv->caps & ACCDET_PMIC_EINT0) {
-				regmap_update_bits(priv->regmap,
-						   RG_EINT0CONFIGACCDET_ADDR,
-						   RG_EINT0CONFIGACCDET_MASK_SFT,
-						   0);
-			} else if (priv->caps & ACCDET_PMIC_EINT1) {
-				regmap_update_bits(priv->regmap,
-						   RG_EINT1CONFIGACCDET_ADDR,
-						   RG_EINT1CONFIGACCDET_MASK_SFT,
-						   0);
-			}
-		} else {
-			if (priv->caps & ACCDET_PMIC_EINT0) {
-				regmap_update_bits(priv->regmap,
-						   RG_EINT0CONFIGACCDET_ADDR,
-						   RG_EINT0CONFIGACCDET_MASK_SFT,
-						   BIT(RG_EINT0CONFIGACCDET_SFT));
-			} else if (priv->caps & ACCDET_PMIC_EINT1) {
-				regmap_update_bits(priv->regmap,
-						   RG_EINT1CONFIGACCDET_ADDR,
-						   RG_EINT1CONFIGACCDET_MASK_SFT,
-						   BIT(RG_EINT1CONFIGACCDET_SFT));
-			}
+		if (priv->caps & ACCDET_PMIC_EINT0) {
+			regmap_update_bits(priv->regmap,
+					   RG_EINT0CONFIGACCDET_ADDR,
+					   RG_EINT0CONFIGACCDET_MASK_SFT,
+					   BIT(RG_EINT0CONFIGACCDET_SFT));
+		} else if (priv->caps & ACCDET_PMIC_EINT1) {
+			regmap_update_bits(priv->regmap,
+					   RG_EINT1CONFIGACCDET_ADDR,
+					   RG_EINT1CONFIGACCDET_MASK_SFT,
+					   BIT(RG_EINT1CONFIGACCDET_SFT));
 		}
 	}
 
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 38c36d59b9cc68bd90e16137a05a62b521b75ac1..99de5037a2294b62cb8535fc45dbf4c6fafb5c7f 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -75,7 +75,6 @@ struct dts_data {
 	bool hp_eint_high;
 	struct pwm_deb_settings *pwm_deb;
 	unsigned int eint_detect_mode;
-	unsigned int eint_use_ext_res;
 	unsigned int eint_comp_vth;
 };
 

-- 
2.48.1


