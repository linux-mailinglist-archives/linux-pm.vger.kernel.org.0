Return-Path: <linux-pm+bounces-23245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D388A4B371
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FED3B1BAC
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53701F03FF;
	Sun,  2 Mar 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h5d5wfX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30111F0996;
	Sun,  2 Mar 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933161; cv=none; b=VB2t8MmgBaYoV/TTKQMsGLH1Hmsn5i1zxe+bjdvGFedBviZ8yeLB9ucD7JiZ90/8XFJT/5ewJ/VmK1+93Fp2uUwwP3x8vtpcaNt/uitPn/5tATB4t8c/LyBpBjORMzY1SBxYnzvKMBTp7QTl2Jz9Ntll07jbFW4ChJOCUdzcMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933161; c=relaxed/simple;
	bh=AqQe2E7U0dfmYyLyIXsETLGOu5MrOdR7Z1LIsef8zm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHmeYRzF5E+IqM4F0jmony3rZcSTYd0dDaNfs+/9op/BwIeqUMBSAdhMwmT/RZ9Mr9v0i8P2oWXF80HFPuFkGN08wPQXvlXqTz4N4q3oM8C2lY/hAx/o5h7fejlN9z1wb6qC/rSBndS+GxjqB8s3LiHE5pk0qhQIjSeSseiCOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h5d5wfX8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933158;
	bh=AqQe2E7U0dfmYyLyIXsETLGOu5MrOdR7Z1LIsef8zm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5d5wfX8obnGhsrG7WEXVMkP/YUo0BUUn1VpPviUlkUch5MxP4+EqWlzPBdv43SAo
	 8CuM6PtlLUOBzZiMv07lt4UUmsJb/hqJQwQHHFxNSgRa8kg9dZlnZjSuApf0cSuncM
	 f16Pj6hUqjoE0brfDtgLaaJXul+Op44juaT4d6tZeXIJyhaRTAa6z5/jUDV4+vY7hN
	 4CXstJXPZVeg/GHv15CBRBG4BWi2sWTT+HO15IiBHrp8lm58XeFEUD7FWApRdQ6/KR
	 fNkzdKIlqUwNBhnu5Bys0uhWTJQ6eInKmYPMqUt9fJL9T0Cxdpv+Lps/+qNJR0MD+S
	 CXYexoojpyyKA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3350A17E05EA;
	Sun,  2 Mar 2025 17:32:33 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:57 -0300
Subject: [PATCH v2 18/20] ASoC: mediatek: mt6359-accdet: Always use EINT0
 IRQ
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-18-5bd633ee0d47@collabora.com>
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

The ACCDET block can generate two distinct EINT interrupts: EINT0 and
EINT1, and which is enabled is currently determined by mediatek,eint-num
property in DT. However, only EINT0 is used on the boards that are
known to have working ACCDET. Since there are no current users of the
property, remove its handling and instead always enable EINT0. The
property can be properly introduced in the binding in the future if it
really turns out that other boards require EINT1.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 187 +++++++++------------------------------
 sound/soc/codecs/mt6359-accdet.h |   1 -
 2 files changed, 43 insertions(+), 145 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 3f6a97e8de8d174e59e512d53135fadc5765b5c1..b1e63f3f7fa44687b1cac47c0e33f68a28e15a47 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -31,10 +31,6 @@
 #define REGISTER_VAL(x)	((x) - 1)
 
 /* mt6359 accdet capability */
-#define ACCDET_PMIC_EINT0		BIT(2)
-#define ACCDET_PMIC_EINT1		BIT(3)
-#define ACCDET_PMIC_BI_EINT		BIT(4)
-
 #define ACCDET_PMIC_RSV_EINT		BIT(7)
 
 #define ACCDET_RSV_KEY			BIT(11)
@@ -84,17 +80,10 @@ static unsigned int adjust_eint_analog_setting(struct mt6359_accdet *priv)
 {
 	/* ESD switches off */
 	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR, 1 << 8, 0);
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* enable RG_EINT0CONFIGACCDET */
-		regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
-				   RG_EINT0CONFIGACCDET_MASK_SFT,
-				   BIT(RG_EINT0CONFIGACCDET_SFT));
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* enable RG_EINT1CONFIGACCDET */
-		regmap_update_bits(priv->regmap, RG_EINT1CONFIGACCDET_ADDR,
-				   RG_EINT1CONFIGACCDET_MASK_SFT,
-				   BIT(RG_EINT1CONFIGACCDET_SFT));
-	}
+	/* enable RG_EINT0CONFIGACCDET */
+	regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
+			   RG_EINT0CONFIGACCDET_MASK_SFT,
+			   BIT(RG_EINT0CONFIGACCDET_SFT));
 	/*select 500k, use internal resistor */
 	regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
 			   RG_EINT0HIRENB_MASK_SFT, BIT(RG_EINT0HIRENB_SFT));
@@ -103,27 +92,13 @@ static unsigned int adjust_eint_analog_setting(struct mt6359_accdet *priv)
 
 static unsigned int adjust_eint_digital_setting(struct mt6359_accdet *priv)
 {
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* disable inverter */
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT, 0);
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* disable inverter */
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT, 0);
-	}
+	/* disable inverter */
+	regmap_update_bits(priv->regmap, ACCDET_EINT0_INVERTER_SW_EN_ADDR,
+			   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT, 0);
 
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* set DA stable signal */
-		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
-				   ACCDET_EINT0_CEN_STABLE_MASK_SFT, 0);
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* set DA stable signal */
-		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
-				   ACCDET_EINT1_CEN_STABLE_MASK_SFT, 0);
-	}
+	/* set DA stable signal */
+	regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+			   ACCDET_EINT0_CEN_STABLE_MASK_SFT, 0);
 	return 0;
 }
 
@@ -149,55 +124,26 @@ static void recover_eint_analog_setting(struct mt6359_accdet *priv)
 {
 	/* ESD switches on */
 	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR, 1 << 8, 1 << 8);
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* disable RG_EINT0CONFIGACCDET */
-		regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
-				   RG_EINT0CONFIGACCDET_MASK_SFT, 0);
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* disable RG_EINT1CONFIGACCDET */
-		regmap_update_bits(priv->regmap, RG_EINT1CONFIGACCDET_ADDR,
-				   RG_EINT1CONFIGACCDET_MASK_SFT, 0);
-	}
+	/* disable RG_EINT0CONFIGACCDET */
+	regmap_update_bits(priv->regmap, RG_EINT0CONFIGACCDET_ADDR,
+			   RG_EINT0CONFIGACCDET_MASK_SFT, 0);
 	regmap_update_bits(priv->regmap, RG_EINT0HIRENB_ADDR,
 			   RG_EINT0HIRENB_MASK_SFT, 0);
 }
 
 static void recover_eint_digital_setting(struct mt6359_accdet *priv)
 {
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT0_M_SW_EN_ADDR,
-				   ACCDET_EINT0_M_SW_EN_MASK_SFT, 0);
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT1_M_SW_EN_ADDR,
-				   ACCDET_EINT1_M_SW_EN_MASK_SFT, 0);
-	}
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* enable eint0cen */
-		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
-				   ACCDET_EINT0_CEN_STABLE_MASK_SFT,
-				   BIT(ACCDET_EINT0_CEN_STABLE_SFT));
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* enable eint1cen */
-		regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
-				   ACCDET_EINT1_CEN_STABLE_MASK_SFT,
-				   BIT(ACCDET_EINT1_CEN_STABLE_SFT));
-	}
-
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		/* enable inverter */
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
-				   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		/* enable inverter */
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
-				   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
-	}
+	regmap_update_bits(priv->regmap, ACCDET_EINT0_M_SW_EN_ADDR,
+			   ACCDET_EINT0_M_SW_EN_MASK_SFT, 0);
+	/* enable eint0cen */
+	regmap_update_bits(priv->regmap, ACCDET_DA_STABLE_ADDR,
+			   ACCDET_EINT0_CEN_STABLE_MASK_SFT,
+			   BIT(ACCDET_EINT0_CEN_STABLE_SFT));
+
+	/* enable inverter */
+	regmap_update_bits(priv->regmap, ACCDET_EINT0_INVERTER_SW_EN_ADDR,
+			   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
+			   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
 }
 
 static void recover_eint_setting(struct mt6359_accdet *priv)
@@ -486,10 +432,8 @@ static irqreturn_t mt6359_accdet_irq(int irq, void *data)
 
 static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 {
-	int ret;
 	struct device *dev = priv->dev;
 	struct device_node *node = NULL;
-	unsigned int tmp = 0;
 
 	node = of_get_child_by_name(dev->parent->of_node, "accdet");
 	if (!node)
@@ -497,16 +441,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 
 	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
-	ret = of_property_read_u32(node, "mediatek,eint-num", &tmp);
-	if (ret)
-		tmp = 0;
-	if (tmp == 0)
-		priv->caps |= ACCDET_PMIC_EINT0;
-	else if (tmp == 1)
-		priv->caps |= ACCDET_PMIC_EINT1;
-	else if (tmp == 2)
-		priv->caps |= ACCDET_PMIC_BI_EINT;
-
 	of_node_put(node);
 	dev_warn(priv->dev, "accdet caps=%x\n", priv->caps);
 
@@ -520,13 +454,8 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 		     (ACCDET_EINT_CMPMEN_PWM_WIDTH_400MS << 4 |
 		      ACCDET_EINT_CMPMEN_PWM_THRESH_2MS));
 	/* DA signal stable */
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		regmap_write(priv->regmap, ACCDET_DA_STABLE_ADDR,
-			     ACCDET_EINT0_STABLE_VAL);
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		regmap_write(priv->regmap, ACCDET_DA_STABLE_ADDR,
-			     ACCDET_EINT1_STABLE_VAL);
-	}
+	regmap_write(priv->regmap, ACCDET_DA_STABLE_ADDR,
+		     ACCDET_EINT0_STABLE_VAL);
 	/* after receive n+1 number, interrupt issued. */
 	regmap_update_bits(priv->regmap, ACCDET_EINT_M_PLUG_IN_NUM_ADDR,
 			   ACCDET_EINT_M_PLUG_IN_NUM_MASK_SFT,
@@ -543,17 +472,9 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 	/* enable PWM */
 	regmap_write(priv->regmap, ACCDET_CMP_PWM_EN_ADDR, 0x67);
 	/* enable inverter detection */
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT0_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
-				   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		regmap_update_bits(priv->regmap,
-				   ACCDET_EINT1_INVERTER_SW_EN_ADDR,
-				   ACCDET_EINT1_INVERTER_SW_EN_MASK_SFT,
-				   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
-	}
+	regmap_update_bits(priv->regmap, ACCDET_EINT0_INVERTER_SW_EN_ADDR,
+			   ACCDET_EINT0_INVERTER_SW_EN_MASK_SFT,
+			   BIT(ACCDET_EINT0_INVERTER_SW_EN_SFT));
 
 	if (priv->data->hp_eint_high) {
 		/* EINT polarity inverse */
@@ -571,13 +492,8 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 {
 	unsigned int val = 0;
 
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		regmap_update_bits(priv->regmap, RG_EINT0EN_ADDR,
-				   RG_EINT0EN_MASK_SFT, BIT(RG_EINT0EN_SFT));
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		regmap_update_bits(priv->regmap, RG_EINT1EN_ADDR,
-				   RG_EINT1EN_MASK_SFT, BIT(RG_EINT1EN_SFT));
-	}
+	regmap_update_bits(priv->regmap, RG_EINT0EN_ADDR, RG_EINT0EN_MASK_SFT,
+			   BIT(RG_EINT0EN_SFT));
 	/* ESD switches on */
 	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
 			   1 << 8, 1 << 8);
@@ -727,35 +643,18 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (priv->caps & ACCDET_PMIC_EINT0) {
-		priv->accdet_eint0 = platform_get_irq(pdev, 1);
-		if (priv->accdet_eint0 >= 0) {
-			ret = devm_request_threaded_irq(&pdev->dev,
-							priv->accdet_eint0,
-							NULL, mt6359_accdet_irq,
-							IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-							"ACCDET_EINT0", priv);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"Failed to request eint0 IRQ (%d)\n",
-					ret);
-				return ret;
-			}
-		}
-	} else if (priv->caps & ACCDET_PMIC_EINT1) {
-		priv->accdet_eint1 = platform_get_irq(pdev, 2);
-		if (priv->accdet_eint1 >= 0) {
-			ret = devm_request_threaded_irq(&pdev->dev,
-							priv->accdet_eint1,
-							NULL, mt6359_accdet_irq,
-							IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-							"ACCDET_EINT1", priv);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"Failed to request eint1 IRQ (%d)\n",
-					ret);
-				return ret;
-			}
+	priv->accdet_eint0 = platform_get_irq(pdev, 1);
+	if (priv->accdet_eint0 >= 0) {
+		ret = devm_request_threaded_irq(&pdev->dev,
+						priv->accdet_eint0,
+						NULL, mt6359_accdet_irq,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						"ACCDET_EINT0", priv);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request eint0 IRQ (%d)\n",
+				ret);
+			return ret;
 		}
 	}
 
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 288b8fbf7c5efaee6520a2c0a5845e156f3b805d..4156cbc7f0a1744226d5f28746bd13fec6c615b4 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -58,7 +58,6 @@ struct mt6359_accdet {
 	unsigned int caps;
 	int accdet_irq;
 	int accdet_eint0;
-	int accdet_eint1;
 	struct mutex res_lock; /* lock protection */
 	bool jack_plugged;
 	unsigned int jack_type;

-- 
2.48.1


