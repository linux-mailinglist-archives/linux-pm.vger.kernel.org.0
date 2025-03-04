Return-Path: <linux-pm+bounces-23397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EDA4E41B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102A83BA61B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BE20A5CC;
	Tue,  4 Mar 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Inzks9Mh"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26008293B6B;
	Tue,  4 Mar 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101459; cv=none; b=E0JPD3oFEpBvee96jQ4FrKrzDzGg8UHYxSc4XP5T7y13aKWSNgJpL+PbW7QqEt0FtxP68H6/k2Xzo2eJ8IV0RyV0o+0AeL73eXQWjRBo6fozmgsJm2zNWjxfSYGsrXTIDFwUSO1NYOjaKR2cQPsi3KjQgIDVpEZlVSGeRv5Yu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101459; c=relaxed/simple;
	bh=rBci4f69I/d/dQvGhQC94bd2AW9ZiKT0dsBk2rxvf9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puvAgynAK8lKNrWG243wpwcFX6DudkAL1jo1B/+c20lTv/IF1/Dr9XRSL0DWp7gq0ek2Z4ermCawSyXyNs8sKq/CJHzWuokTArUt9CDGxVw6yQoQD369v2Gb+SSaI01niPA5Dx2AiH01hmmzXZz5tQ/1Ig59Ff3Ly9/fp3Xd0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Inzks9Mh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101456;
	bh=rBci4f69I/d/dQvGhQC94bd2AW9ZiKT0dsBk2rxvf9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Inzks9Mhv1iMCQ3p9MrvMcYWBdpfIaJdhf8iMX+Gf+yyhHcHW1VKGh+91ONxkiLtS
	 lHAQfgqxt9ZHjidpXd28ba/gKIp/0sx4Zgu7+mdyj2KErN7cWmnOa68se6kufbiuH7
	 3IA5yA1wJeLr/HJ6PMwoIl2RiemhNCysXuQHd/GI9Pi4clynPxnzwdnWRf+jhtwTF2
	 hBCQd+4xtUi0EHThhEh5hV310T4lD/5YBDEivhg6DzguksJExCb3vdkhqU9yLKqRCQ
	 YrJKluc5nck6jKrkklOxl0nfshmbelcwsbU9CtE2IzLVcSgUZfYlystfOp7v3059Fo
	 ieY1vA8yNzohg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81A3717E0630;
	Tue,  4 Mar 2025 16:17:31 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:57 -0300
Subject: [PATCH v3 16/20] ASoC: mediatek: mt6359-accdet: Always configure
 hardware as mic-mode 2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-16-5b0eafc29f5b@collabora.com>
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

The driver currently reads a mediatek,mic-mode property from DT to
determine certain register configurations. Since there are no current
users of the property, the property doesn't directly reflect the
hardware  and the default value (2) is known to work on
multiple boards, remove the code handling this property and instead
always configure the hardware according to the known to work default.
This property can be properly introduced in the binding in the future
if it really turns out that different boards need different
configurations.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 43 ++++++----------------------------------
 sound/soc/codecs/mt6359-accdet.h |  5 -----
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index a31e084560c7643b14fb71871699e3167075d9d9..12697b02faff1be39317116cd7d8ffa359f2cd4e 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -494,11 +494,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (!node)
 		return -EINVAL;
 
-	ret = of_property_read_u32(node, "mediatek,mic-mode",
-				   &priv->data->mic_mode);
-	if (ret)
-		priv->data->mic_mode = 2;
-
 	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
 	ret = of_property_read_u32(node, "mediatek,eint-num", &tmp);
@@ -658,38 +653,12 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 			     RG_AUDMICBIAS1LOWPEN_MASK_SFT);
 	/* mic mode setting */
 	regmap_read(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR, &reg);
-	if (priv->data->mic_mode == HEADSET_MODE_1) {
-		/* ACC mode*/
-		regmap_write(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR,
-			     reg | RG_ACCDET_MODE_ANA11_MODE1);
-		/* enable analog fast discharge */
-		regmap_update_bits(priv->regmap, RG_ANALOGFDEN_ADDR,
-				   RG_ANALOGFDEN_MASK_SFT,
-				   BIT(RG_ANALOGFDEN_SFT));
-		regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
-				   0x3 << 11, 0x3 << 11);
-	} else if (priv->data->mic_mode == HEADSET_MODE_2) {
-		/* DCC mode Low cost mode without internal bias */
-		regmap_write(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR,
-			     reg | RG_ACCDET_MODE_ANA11_MODE2);
-		/* enable analog fast discharge */
-		regmap_update_bits(priv->regmap, RG_ANALOGFDEN_ADDR,
-				   0x3 << RG_ANALOGFDEN_SFT,
-				   0x3 << RG_ANALOGFDEN_SFT);
-	} else if (priv->data->mic_mode == HEADSET_MODE_6) {
-		/* DCC mode Low cost mode with internal bias,
-		 * bit8 = 1 to use internal bias
-		 */
-		regmap_write(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR,
-			     reg | RG_ACCDET_MODE_ANA11_MODE6);
-		regmap_update_bits(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR,
-				   RG_AUDMICBIAS1DCSW1PEN_MASK_SFT,
-				   BIT(RG_AUDMICBIAS1DCSW1PEN_SFT));
-		/* enable analog fast discharge */
-		regmap_update_bits(priv->regmap, RG_ANALOGFDEN_ADDR,
-				   0x3 << RG_ANALOGFDEN_SFT,
-				   0x3 << RG_ANALOGFDEN_SFT);
-	}
+	/* DCC mode Low cost mode without internal bias */
+	regmap_write(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR,
+		     reg | RG_ACCDET_MODE_ANA11_MODE2);
+	/* enable analog fast discharge */
+	regmap_update_bits(priv->regmap, RG_ANALOGFDEN_ADDR,
+			   0x3 << RG_ANALOGFDEN_SFT, 0x3 << RG_ANALOGFDEN_SFT);
 
 	config_eint_init_by_mode(priv);
 	config_digital_init_by_mode(priv);
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 46dcd4759230a5190434b9b7c785e8b9ed12fd3d..579373807c414130b2a7384db4978e01cf1d046c 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -12,10 +12,6 @@
 
 #define ACCDET_DEVNAME "accdet"
 
-#define HEADSET_MODE_1		(1)
-#define HEADSET_MODE_2		(2)
-#define HEADSET_MODE_6		(6)
-
 #define MT6359_ACCDET_NUM_BUTTONS 4
 #define MT6359_ACCDET_JACK_MASK (SND_JACK_HEADPHONE | \
 				SND_JACK_HEADSET | \
@@ -51,7 +47,6 @@ enum {
 };
 
 struct dts_data {
-	unsigned int mic_mode;
 	bool hp_eint_high;
 	unsigned int eint_comp_vth;
 };

-- 
2.48.1


