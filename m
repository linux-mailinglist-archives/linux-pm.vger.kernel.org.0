Return-Path: <linux-pm+bounces-23395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A055A4E390
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB74188E608
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8827F4ED;
	Tue,  4 Mar 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CsTYzapK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED227F4E4;
	Tue,  4 Mar 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101448; cv=none; b=jbQ+rm2QiTgdlGm0SDBUyB0NkGUWCZ0eczjwGBxx8GBIh1RRtsTPrSzQ47PQ0M5v80mowdkcplBJlEMK1v8XfcO/C/LNmmUI/DhB7XjuagB0mmEx8xG9J6KJe6DWUjXvBsrOtD8xSLcdlmRptoPRMSuJs+ZUXlOmZF1SKehCTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101448; c=relaxed/simple;
	bh=sk4Gc1vWzvy1bYpW1lA/DEQpt1YQ8vmHPR+8OGEM/CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyFW7Rd7pDkRSopGgd3B24U3DkFT+wzF7N5MmaMXpKjcXa/JXZoxqbpM/TCuL68W7gZDSGMHvGQB4Wa5tIzdVW3U0979ptcDH8VLriJ20OER32QnXe/o/2AvmbwjH4vfy9H3aq6/Q349TGCoqGJvp0ANIu62Sr5EQJo4GLiVJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CsTYzapK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101445;
	bh=sk4Gc1vWzvy1bYpW1lA/DEQpt1YQ8vmHPR+8OGEM/CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CsTYzapKORGbDcvcmNqUTdvhzFgGoG9Dl0vtI2BOz7JURA6wQ8p7tWWkkZ4Bf5dRG
	 r33aJuTnsNiNQMNVPEskd5tLMhKcG7Tw2pepxEO4HxsiOERJrmrmgk3Nnv4SniSF4o
	 wCDWoGHQMOuoUa3BAPOoF1oWjDQwxOuavT3UyXX/qPc55M8lGhz5ZU3EKKKSt01v1e
	 DJ744KdalxAOCKvpQU2NPB1DfGt+0mvHeG1P+IxRBEAOD7m7xeH7mR2nZinJuofCMv
	 CM2jByz5f3dTP2sP8mAVfA7fkOKZ3QdTw6s3tzvm8D2DrTcFnm0/X6gf5CCrSS7LVO
	 sNOp8KGznSzQA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 408CD17E07F8;
	Tue,  4 Mar 2025 16:17:20 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:55 -0300
Subject: [PATCH v3 14/20] ASoC: mediatek: mt6359-accdet: Always use eint
 detect mode 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-14-5b0eafc29f5b@collabora.com>
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

The driver currently reads a mediatek,eint-detect-mode property from DT,
which determines certain register configurations. Since there are no
users of the property, it doesn't directly describe the hardware, and
the default value (4) is known to work across multiple boards, remove
the handling for this property and always assume mode 4 is used. The
property can be properly introduced in the binding in the future if
different boards actually need different configurations.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 208 +++++++++++++--------------------------
 sound/soc/codecs/mt6359-accdet.h |   1 -
 2 files changed, 70 insertions(+), 139 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 6728f1018c992fc9d4e4133dbaf091d256567683..83e65b6d5845dea00a8a77d68df4b7df1f62a87c 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -81,31 +81,22 @@ static void recover_eint_setting(struct mt6359_accdet *priv);
 
 static unsigned int adjust_eint_analog_setting(struct mt6359_accdet *priv)
 {
-	if (priv->data->eint_detect_mode == 0x3 ||
-	    priv->data->eint_detect_mode == 0x4) {
-		/* ESD switches off */
-		regmap_update_bits(priv->regmap,
-				   RG_ACCDETSPARE_ADDR, 1 << 8, 0);
-	}
-	if (priv->data->eint_detect_mode == 0x4) {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			/* enable RG_EINT0CONFIGACCDET */
-			regmap_update_bits(priv->regmap,
-					   RG_EINT0CONFIGACCDET_ADDR,
-					   RG_EINT0CONFIGACCDET_MASK_SFT,
-					   BIT(RG_EINT0CONFIGACCDET_SFT));
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			/* enable RG_EINT1CONFIGACCDET */
-			regmap_update_bits(priv->regmap,
-					   RG_EINT1CONFIGACCDET_ADDR,
-					   RG_EINT1CONFIGACCDET_MASK_SFT,
-					   BIT(RG_EINT1CONFIGACCDET_SFT));
-		}
-		/*select 500k, use internal resistor */
-		regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
-				   RG_EINT0HIRENB_MASK_SFT,
-				   BIT(RG_EINT0HIRENB_SFT));
+	/* ESD switches off */
+	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR, 1 << 8, 0);
+	if (priv->caps & ACCDET_PMIC_EINT0) {
+		/* enable RG_EINT0CONFIGACCDET */
+		regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
+				   RG_EINT0CONFIGACCDET_MASK_SFT,
+				   BIT(RG_EINT0CONFIGACCDET_SFT));
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		/* enable RG_EINT1CONFIGACCDET */
+		regmap_update_bits(priv->regmap, RG_EINT1CONFIGACCDET_ADDR,
+				   RG_EINT1CONFIGACCDET_MASK_SFT,
+				   BIT(RG_EINT1CONFIGACCDET_SFT));
 	}
+	/*select 500k, use internal resistor */
+	regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
+			   RG_EINT0HIRENB_MASK_SFT, BIT(RG_EINT0HIRENB_SFT));
 	return 0;
 }
 
@@ -123,18 +114,14 @@ static unsigned int adjust_eint_digital_setting(struct mt6359_accdet *priv)
 				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT, 0);
 	}
 
-	if (priv->data->eint_detect_mode == 0x4) {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			/* set DA stable signal */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_DA_STABLE_ADDR,
-					   ACCDET_EINT0_CEN_STABLE_MASK_SFT, 0);
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			/* set DA stable signal */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_DA_STABLE_ADDR,
-					   ACCDET_EINT1_CEN_STABLE_MASK_SFT, 0);
-		}
+	if (priv->caps & ACCDET_PMIC_EINT0) {
+		/* set DA stable signal */
+		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+				   ACCDET_EINT0_CEN_STABLE_MASK_SFT, 0);
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		/* set DA stable signal */
+		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+				   ACCDET_EINT1_CEN_STABLE_MASK_SFT, 0);
 	}
 	return 0;
 }
@@ -159,27 +146,19 @@ static unsigned int mt6359_accdet_jd_setting(struct mt6359_accdet *priv)
 
 static void recover_eint_analog_setting(struct mt6359_accdet *priv)
 {
-	if (priv->data->eint_detect_mode == 0x3 ||
-	    priv->data->eint_detect_mode == 0x4) {
-		/* ESD switches on */
-		regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
-				   1 << 8, 1 << 8);
-	}
-	if (priv->data->eint_detect_mode == 0x4) {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			/* disable RG_EINT0CONFIGACCDET */
-			regmap_update_bits(priv->regmap,
-					   RG_EINT0CONFIGACCDET_ADDR,
-					   RG_EINT0CONFIGACCDET_MASK_SFT, 0);
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			/* disable RG_EINT1CONFIGACCDET */
-			regmap_update_bits(priv->regmap,
-					   RG_EINT1CONFIGACCDET_ADDR,
-					   RG_EINT1CONFIGACCDET_MASK_SFT, 0);
-		}
-		regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
-				   RG_EINT0HIRENB_MASK_SFT, 0);
+	/* ESD switches on */
+	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR, 1 << 8, 1 << 8);
+	if (priv->caps & ACCDET_PMIC_EINT0) {
+		/* disable RG_EINT0CONFIGACCDET */
+		regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
+				   RG_EINT0CONFIGACCDET_MASK_SFT, 0);
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		/* disable RG_EINT1CONFIGACCDET */
+		regmap_update_bits(priv->regmap, RG_EINT1CONFIGACCDET_ADDR,
+				   RG_EINT1CONFIGACCDET_MASK_SFT, 0);
 	}
+	regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
+			   RG_EINT0HIRENB_MASK_SFT, 0);
 }
 
 static void recover_eint_digital_setting(struct mt6359_accdet *priv)
@@ -193,37 +172,30 @@ static void recover_eint_digital_setting(struct mt6359_accdet *priv)
 				   ACCDET_EINT1_M_SW_EN_ADDR,
 				   ACCDET_EINT1_M_SW_EN_MASK_SFT, 0);
 	}
-	if (priv->data->eint_detect_mode == 0x4) {
+	if (priv->caps & ACCDET_PMIC_EINT0) {
 		/* enable eint0cen */
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			/* enable eint0cen */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_DA_STABLE_ADDR,
-					   ACCDET_EINT0_CEN_STABLE_MASK_SFT,
-					   BIT(ACCDET_EINT0_CEN_STABLE_SFT));
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			/* enable eint1cen */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_DA_STABLE_ADDR,
-					   ACCDET_EINT1_CEN_STABLE_MASK_SFT,
-					   BIT(ACCDET_EINT1_CEN_STABLE_SFT));
-		}
+		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+				   ACCDET_EINT0_CEN_STABLE_MASK_SFT,
+				   BIT(ACCDET_EINT0_CEN_STABLE_SFT));
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		/* enable eint1cen */
+		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+				   ACCDET_EINT1_CEN_STABLE_MASK_SFT,
+				   BIT(ACCDET_EINT1_CEN_STABLE_SFT));
 	}
 
-	if (priv->data->eint_detect_mode != 0x1) {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			/* enable inverter */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
-					   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			/* enable inverter */
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
-					   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
-		}
+	if (priv->caps & ACCDET_PMIC_EINT0) {
+		/* enable inverter */
+		regmap_update_bits(priv->regmap,
+				   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
+				   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
+				   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		/* enable inverter */
+		regmap_update_bits(priv->regmap,
+				   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
+				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
+				   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
 	}
 }
 
@@ -534,13 +506,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 
 	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
-	ret = of_property_read_u32(node, "mediatek,eint-detect-mode",
-				   &priv->data->eint_detect_mode);
-	if (ret) {
-		/* eint detection mode equals to EINT HW Mode */
-		priv->data->eint_detect_mode = 0x4;
-	}
-
 	ret = of_property_read_u32(node, "mediatek,eint-num", &tmp);
 	if (ret)
 		tmp = 0;
@@ -592,31 +557,16 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 	/* enable PWM */
 	regmap_write(priv->regmap, ACCDET_CMP_PWM_EN_ADDR, 0x67);
 	/* enable inverter detection */
-	if (priv->data->eint_detect_mode == 0x1) {
-		/* disable inverter detection */
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
-					   0);
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
-					   0);
-		}
-	} else {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
-					   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			regmap_update_bits(priv->regmap,
-					   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-					   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
-					   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
-		}
+	if (priv->caps & ACCDET_PMIC_EINT0) {
+		regmap_update_bits(priv->regmap,
+				   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
+				   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
+				   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
+	} else if (priv->caps & ACCDET_PMIC_EINT1) {
+		regmap_update_bits(priv->regmap,
+				   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
+				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
+				   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
 	}
 
 	if (priv->data->hp_eint_high) {
@@ -649,28 +599,10 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 	regmap_update_bits(priv->regmap, RG_NCP_PDDIS_EN_ADDR,
 			   RG_NCP_PDDIS_EN_MASK_SFT, BIT(RG_NCP_PDDIS_EN_SFT));
 
-	if (priv->data->eint_detect_mode == 0x1 ||
-	    priv->data->eint_detect_mode == 0x2 ||
-	    priv->data->eint_detect_mode == 0x3) {
-		if (priv->caps & ACCDET_PMIC_EINT0) {
-			regmap_update_bits(priv->regmap,
-					   RG_EINT0CONFIGACCDET_ADDR,
-					   RG_EINT0CONFIGACCDET_MASK_SFT,
-					   BIT(RG_EINT0CONFIGACCDET_SFT));
-		} else if (priv->caps & ACCDET_PMIC_EINT1) {
-			regmap_update_bits(priv->regmap,
-					   RG_EINT1CONFIGACCDET_ADDR,
-					   RG_EINT1CONFIGACCDET_MASK_SFT,
-					   BIT(RG_EINT1CONFIGACCDET_SFT));
-		}
-	}
-
-	if (priv->data->eint_detect_mode != 0x1) {
-		/* current detect set 0.25uA */
-		regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
-				   0x3 << RG_ACCDETSPARE_SFT,
-				   0x3 << RG_ACCDETSPARE_SFT);
-	}
+	/* current detect set 0.25uA */
+	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
+			   0x3 << RG_ACCDETSPARE_SFT,
+			   0x3 << RG_ACCDETSPARE_SFT);
 	regmap_write(priv->regmap, RG_EINTCOMPVTH_ADDR,
 		     val | priv->data->eint_comp_vth << RG_EINTCOMPVTH_SFT);
 }
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 287201eebe0330fa170093fd6192bf5694c30469..ff5cd6ea1b06f045b6e1b9f6bc53ef80d78e3b92 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -54,7 +54,6 @@ struct dts_data {
 	unsigned int mic_vol;
 	unsigned int mic_mode;
 	bool hp_eint_high;
-	unsigned int eint_detect_mode;
 	unsigned int eint_comp_vth;
 };
 

-- 
2.48.1


