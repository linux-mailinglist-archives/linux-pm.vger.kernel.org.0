Return-Path: <linux-pm+bounces-23515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19555A50AC0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2A37A51A6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630E25D200;
	Wed,  5 Mar 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bt09DITD"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576D255E30;
	Wed,  5 Mar 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201254; cv=none; b=MZB3YI/LsfaDLSAz1Q2xf1yjIOXUCAUf2PSRozVccmyevrpLpaP24rQgZwGiweK3S5nXo/zTVlFU+UcpBQmER3c9x9o1Q9rMw4j05U2/JD1GNVk4yxmCpeyT/EV//TuKmyRhLNByR6/Gt0Hv6rXfnZMjqBSWelgTxEGNxKmaJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201254; c=relaxed/simple;
	bh=UtaKHqK3+fgfZE111SW1PU59SBdv6NpsckijEheGGYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuUGuoDJxXSwa4Fl3+j8ReDPvFA7p0ZBfytwv+cYiyevbVCjk6gCIVr2Q133Zq3L3bb6os74g1JhMN6zUU6FdpgjQHOn1IYJ2DzSg+/e7gg9kx+HrN5jDHVkyiL0I1Zq+Tm3uvpsockomqPIyakDVtwBZ5rqum33lQD/lMM+hQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bt09DITD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201250;
	bh=UtaKHqK3+fgfZE111SW1PU59SBdv6NpsckijEheGGYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bt09DITDhDHr6BcjLLw3dplzAzkMk9iEeSH8U36Ow9mXHLYRwDNfK8xvj2DzT3AOA
	 C66WtEZDivhObsGiuVzPIt4WP89xFCNMjNsPiJ0v5gUlKxrNBgO8sT4PkW1WzmzkA9
	 fDXK8SAYkuwEsR7UNgjkWpYbWNiwk53oWK8QHfV2X/Ci3UWlIrQQaNUnCNW4vHewgS
	 0OTF3Er8N1Hi0+tdC6H97FaJDeXhcnTx89lU6u746oqPkLq0gzDkUSMa0kSNo5U0O1
	 KSMB8QQlhG0ZcbgAihtNngxuYctFiD0mWPwRMLA5tbQ7o/egaYaS03JWvkCyDXq2Q1
	 WbbLEDAXCYrgw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2BD317E0343;
	Wed,  5 Mar 2025 20:00:45 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:31 -0300
Subject: [PATCH v4 16/19] ASoC: mediatek: mt6359-accdet: Always set
 comp-vth to 1.6V
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-16-e5ffa5ee9991@collabora.com>
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

The driver currently reads a mediatek,eint-comp-vth property from DT to
determine the voltage threshold of the EINT comparator. Since there are
no current users of the property and setting it to 1.6V is known to work
across multiple boards, remove the code handling this property and
instead always configure it to 1.6V. The property can be properly
introduced in the binding in the future if it really turns out that
different boards need different configurations.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 8 ++------
 sound/soc/codecs/mt6359-accdet.h | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 12697b02faff1be39317116cd7d8ffa359f2cd4e..3f6a97e8de8d174e59e512d53135fadc5765b5c1 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -61,6 +61,7 @@
 #define ACCDET_EINT_INVERTER_DEBOUNCE_256MS 0xe
 #define ACCDET_EINT_CMPMEN_PWM_WIDTH_400MS 4
 #define ACCDET_EINT_CMPMEN_PWM_THRESH_2MS 1
+#define ACCDET_EINT_COMP_VTH_1600MV 2
 
 static struct platform_driver mt6359_accdet_driver;
 static const struct snd_soc_component_driver mt6359_accdet_soc_driver;
@@ -506,11 +507,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	else if (tmp == 2)
 		priv->caps |= ACCDET_PMIC_BI_EINT;
 
-	ret = of_property_read_u32(node, "mediatek,eint-comp-vth",
-				   &priv->data->eint_comp_vth);
-	if (ret)
-		priv->data->eint_comp_vth = 0x0;
-
 	of_node_put(node);
 	dev_warn(priv->dev, "accdet caps=%x\n", priv->caps);
 
@@ -594,7 +590,7 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 			   0x3 << RG_ACCDETSPARE_SFT,
 			   0x3 << RG_ACCDETSPARE_SFT);
 	regmap_write(priv->regmap, RG_EINTCOMPVTH_ADDR,
-		     val | priv->data->eint_comp_vth << RG_EINTCOMPVTH_SFT);
+		     val | ACCDET_EINT_COMP_VTH_1600MV << RG_EINTCOMPVTH_SFT);
 }
 
 static void mt6359_accdet_init(struct mt6359_accdet *priv)
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 579373807c414130b2a7384db4978e01cf1d046c..288b8fbf7c5efaee6520a2c0a5845e156f3b805d 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -48,7 +48,6 @@ enum {
 
 struct dts_data {
 	bool hp_eint_high;
-	unsigned int eint_comp_vth;
 };
 
 struct mt6359_accdet {

-- 
2.48.1


