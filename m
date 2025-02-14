Return-Path: <linux-pm+bounces-22102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98445A36476
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB323B3385
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3D269D07;
	Fri, 14 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ryz+EwqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB02690CD;
	Fri, 14 Feb 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553618; cv=none; b=cfy60VGO6Bq1TYWA9Vyg14dHa5bwBj3wh/UBTtNrToU3koT0M4xNWP0MCtSz+yI6IqIW24CUIK2X84wPYyMurTlF42fcma+Yo0CZq0i+q+Qa2XZakj0rMa8WJHXyabIyAT/zn6QPjVEus2XhDQlECfJujmny1UcFJkSzvuHu/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553618; c=relaxed/simple;
	bh=vSj0waEcx17dh7fvzqeAr6f2FKcw3vDK6V0f2tcErhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=md9FJIpHiE7zFrE7NzKqStGjwwfBRil4fZVQjQGPGncGRoVeP1X4n97TvBM+HjYwkrhtZ4aPp4ZiMBZ2PnhLZgo/JXG2Qwd57mVk14qEpvzn1FQMZ8OsKUKwiSN61iRe5pFYJnjik5Yd70/asSF9DmWQhs9VIVWDLTutxWGvZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ryz+EwqX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553615;
	bh=vSj0waEcx17dh7fvzqeAr6f2FKcw3vDK6V0f2tcErhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ryz+EwqXUQc8bryYPPZtwdHaMkEyfPKmTk+BW6/8Hfl+FzlC2+s/y+yJk9vFI8bH0
	 KNCowMDpEMe62aG3YNlFW43bFJ7rXGBBO3M0VGXDKjOcTMxNuh54+8XwaaGwQDR1OU
	 EI/MJS+gZJnvhAijOzLHK4xm5vVeyJ3/XlDoEr5/oIWWJkq+jDZ88eysEtLNweLx0K
	 jPlzKL8qo0Q7if3Gh4gNA1oqLIigLV2UI67LSU5oDGQu9N79075ufAoNhAZDSWXCKd
	 HQ8BLJkmGGDk9QbrZBBckXBhT066MzsBiRf5uwhp0PMfwIFMti7x0MFsB/5gye2TP1
	 ow68EqiFADeog==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA84917E0FC1;
	Fri, 14 Feb 2025 18:20:10 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:43 -0300
Subject: [PATCH 12/13] ASoC: mediatek: mt6359-accdet: Split
 mediatek,pwm-deb-setting properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-12-677a151b9b4c@collabora.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
In-Reply-To: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Instead of parsing an array of 15 integers from the
mediatek,pwm-deb-setting property, which makes them harder to identify,
parse each value individually from its own property.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 44 +++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 646cdd4e0b57f2a007fdcfcaecb7534e08ae61c4..eca8a0eeb1f868a41c808cc0b853e77db3b0bf59 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -501,9 +501,13 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	int ret;
 	struct device *dev = priv->dev;
 	struct device_node *node = NULL;
-	int pwm_deb[15] = {0};
+	struct pwm_deb_settings *pwm_deb;
 	unsigned int tmp = 0;
 
+	pwm_deb = devm_kzalloc(dev, sizeof(struct pwm_deb_settings), GFP_KERNEL);
+	if (!pwm_deb)
+		return -ENOMEM;
+
 	node = of_get_child_by_name(dev->parent->of_node, "accdet");
 	if (!node)
 		return -EINVAL;
@@ -518,11 +522,33 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (ret)
 		priv->data->mic_mode = 2;
 
-	ret = of_property_read_u32_array(node, "mediatek,pwm-deb-setting",
-					 pwm_deb, ARRAY_SIZE(pwm_deb));
-	/* debounce8(auxadc debounce) is default, needn't get from dts */
-	if (!ret)
-		memcpy(priv->data->pwm_deb, pwm_deb, sizeof(pwm_deb));
+	of_property_read_u32(node, "mediatek,pwm-width", &pwm_deb->pwm_width);
+	of_property_read_u32(node, "mediatek,pwm-thresh", &pwm_deb->pwm_thresh);
+	of_property_read_u32(node, "mediatek,pwm-rise-delay",
+			     &pwm_deb->rise_delay);
+	of_property_read_u32(node, "mediatek,pwm-fall-delay",
+			     &pwm_deb->fall_delay);
+	of_property_read_u32(node, "mediatek,debounce0", &pwm_deb->debounce0);
+	of_property_read_u32(node, "mediatek,debounce1", &pwm_deb->debounce1);
+	of_property_read_u32(node, "mediatek,debounce3", &pwm_deb->debounce3);
+	of_property_read_u32(node, "mediatek,debounce-auxadc",
+			     &pwm_deb->debounce4);
+	of_property_read_u32(node, "mediatek,eint-cmpmen-pwm-width",
+			     &pwm_deb->eint_pwm_width);
+	of_property_read_u32(node, "mediatek,eint-cmpmen-pwm-thresh",
+			     &pwm_deb->eint_pwm_thresh);
+	of_property_read_u32(node, "mediatek,eint-debounce0",
+			     &pwm_deb->eint_debounce0);
+	of_property_read_u32(node, "mediatek,eint-debounce1",
+			     &pwm_deb->eint_debounce1);
+	of_property_read_u32(node, "mediatek,eint-debounce2",
+			     &pwm_deb->eint_debounce2);
+	of_property_read_u32(node, "mediatek,eint-debounce3",
+			     &pwm_deb->eint_debounce3);
+	of_property_read_u32(node, "mediatek,eint-inverter-debounce",
+			     &pwm_deb->eint_inverter_debounce);
+
+	priv->data->pwm_deb = pwm_deb;
 
 	ret = of_property_read_u32(node, "mediatek,eint-level-pol",
 				   &priv->data->eint_pol);
@@ -834,12 +860,6 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 	if (!priv->data)
 		return -ENOMEM;
 
-	priv->data->pwm_deb = devm_kzalloc(&pdev->dev,
-					   sizeof(struct pwm_deb_settings),
-					   GFP_KERNEL);
-	if (!priv->data->pwm_deb)
-		return -ENOMEM;
-
 	priv->regmap = mt6397->regmap;
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);

-- 
2.48.1


