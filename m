Return-Path: <linux-pm+bounces-23513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9290A50AC3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8F817716C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CC25C716;
	Wed,  5 Mar 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mBuCKKNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C5253B42;
	Wed,  5 Mar 2025 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201244; cv=none; b=TsBlBCmusWdC4CXORIGrnAWffAJdKf97BQqVWiBYs/Q/v1uPIc4r3XgHIc5qFNQ+82axbLK5py58u9TMvaLPFN+23Agy3WKF6/KPeUzbxDJM1QVGUMXCWsWkPCGCao/c8AGWRPCD7GAZJNZyyyAsq9nHOOhDC5CZj7UTsYJ+Bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201244; c=relaxed/simple;
	bh=+Xc6IIOKZkGqVJGEvJQSuFw6mN/ozG3/FVvAqN7VwII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KusOCsyVdulgjk8+USyyrfxBxQzlkFYkk8iqucItCdZ7aPH2y5YZqTFbeufr9nQw7r1Pwl3vSqN+TjBJgp7rTfX7UnE/BBbH7wom1j6hgYZjEiKEGVYLltXZ9qJ1bPDjeKSMyEQP1lcJ+6F7Ilwhc5qf5s6sZ58oQEfw6e6ZZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mBuCKKNT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201239;
	bh=+Xc6IIOKZkGqVJGEvJQSuFw6mN/ozG3/FVvAqN7VwII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mBuCKKNT447dwqs28x1gxkklz/uKTpGXc73NT0EFCy4ZyrwV5IivAmcdYcPhX2FDi
	 3Nn3YFrVZKi5HJojDgNvUWVsH6J4onywbjJm9531D36r7p7Q8xIjYO1cRC7gtAYWJc
	 pG3EGpPlhKM/0ir5fDEdlCMvhHFArammhQpYPMaq1jt7DKaKydOJjtAQ0dX55O/TTV
	 kiv1ejP4fZZtLA//Rciza4KneOqngif90POX2lIBPW8yxE3LW7DgHZdlZ+Z0Z1KT0A
	 5Hh2gehoeODE/tLvdK8UZnHPkL0P0Ftu438gqTHFnYrmvDQvdQ5eviQ6s7vuGy2k+4
	 Zenj0YYopkVHw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B0C117E0649;
	Wed,  5 Mar 2025 20:00:34 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:29 -0300
Subject: [PATCH v4 14/19] ASoC: mediatek: mt6359-accdet: Always set
 micbias1 to 2.8V
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-14-e5ffa5ee9991@collabora.com>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
In-Reply-To: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
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

The driver currently reads a mediatek,mic-vol property from DT to
determine the micbias1 setting to configure in hardware. Since there are
no current users of the property and the default value (2.8V) is known
to work on multiple boards, remove the code handling this property and
instead always configure the micbias1 to 2.8V. The property can be
properly introduced in the binding in the future if it really turns out
that different boards need different configurations.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 23 +++--------------------
 sound/soc/codecs/mt6359-accdet.h |  1 -
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 83e65b6d5845dea00a8a77d68df4b7df1f62a87c..a31e084560c7643b14fb71871699e3167075d9d9 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -494,11 +494,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (!node)
 		return -EINVAL;
 
-	ret = of_property_read_u32(node, "mediatek,mic-vol",
-				   &priv->data->mic_vol);
-	if (ret)
-		priv->data->mic_vol = 8;
-
 	ret = of_property_read_u32(node, "mediatek,mic-mode",
 				   &priv->data->mic_mode);
 	if (ret)
@@ -657,22 +652,10 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 		      ACCDET_RISE_DELAY));
 
 	regmap_read(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR, &reg);
-	if (priv->data->mic_vol <= 7) {
-		/* micbias1 <= 2.7V */
-		regmap_write(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR,
-			     reg | (priv->data->mic_vol << RG_AUDMICBIAS1VREF_SFT) |
-			     RG_AUDMICBIAS1LOWPEN_MASK_SFT);
-	} else if (priv->data->mic_vol == 8) {
-		/* micbias1 = 2.8v */
-		regmap_write(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR,
-			     reg | (3 << RG_AUDMICBIAS1HVEN_SFT) |
+	/* micbias1 = 2.8v */
+	regmap_write(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR,
+		     reg | (3 << RG_AUDMICBIAS1HVEN_SFT) |
 			     RG_AUDMICBIAS1LOWPEN_MASK_SFT);
-	} else if (priv->data->mic_vol == 9) {
-		/* micbias1 = 2.85v */
-		regmap_write(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR,
-			     reg | (1 << RG_AUDMICBIAS1HVEN_SFT) |
-			     RG_AUDMICBIAS1LOWPEN_MASK_SFT);
-	}
 	/* mic mode setting */
 	regmap_read(priv->regmap, RG_AUDACCDETMICBIAS0PULLLOW_ADDR, &reg);
 	if (priv->data->mic_mode == HEADSET_MODE_1) {
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index ff5cd6ea1b06f045b6e1b9f6bc53ef80d78e3b92..46dcd4759230a5190434b9b7c785e8b9ed12fd3d 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -51,7 +51,6 @@ enum {
 };
 
 struct dts_data {
-	unsigned int mic_vol;
 	unsigned int mic_mode;
 	bool hp_eint_high;
 	unsigned int eint_comp_vth;

-- 
2.48.1


