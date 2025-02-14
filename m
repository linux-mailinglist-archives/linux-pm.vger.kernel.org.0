Return-Path: <linux-pm+bounces-22099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD995A36461
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16920171652
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA612698A9;
	Fri, 14 Feb 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eVog1OR+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AA268FD3;
	Fri, 14 Feb 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553604; cv=none; b=e3HMfYnVxaWp05hXrD6fhT+gwxPnBk9X0QuQlW/CC7nEiK0HltXmQXuWnBzFijF5nfTccIKxTELVs1GZKr+y3mklJwhmvkrUoCgciX5kIM9zerpO0zvqJ2/al+Scq4Lx2wR3XoXvV4Jqj/9XtkuJ9IZLW2NJLBfqs66/z0c4XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553604; c=relaxed/simple;
	bh=e4vX1ANCZsil8oa3grPqu+Rm/8SSkvhXYxIqWE5LhdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHJv48dYc1KpG8m5/AP82wEeyp6fdJPr5xTzC21ZuAqvEw+XCq+j9bnvDzd20EX5sxaXi9iOQeP4B4wp/QwYA3gPMcEktMp6j0j1/C29oc09xpH+Gr+vC5htqpRwiEGLzS5Yk4VjkFaDTlPPoYoqe44X97ZNnisSBl0UQDfpQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eVog1OR+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553601;
	bh=e4vX1ANCZsil8oa3grPqu+Rm/8SSkvhXYxIqWE5LhdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eVog1OR+93NsZ9uwafXhJ+tm84LtMXB9c1/OKQWR4BdurEO7+St6XVjcJMG+6vXFd
	 lx2loLHC4zxJEnTYdu0FwfivKwrD+mbKrtljPJK8upkVdrIHaqbE+L3Vc+3vrak3ts
	 bbko7xftvycY6liPVStAe4+MyfeosDIsAM6oh5QcGhLEEdD3u0bxjt3vgpyPbEoZ/S
	 FWa0c+JsY6DoSk7qomK2PXnqnNmAD+U5iA8L5vFO4suxPqMQMVb923aCpEmbw5u5XI
	 olzmK1NZJ1nHiBLFU5J8DDc4+zdkuoVzL23MRcRXtx+nxY5DVL1ZRQ3hbgqySO7AA9
	 tlsEEJIQjj2aA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F2CE17E0239;
	Fri, 14 Feb 2025 18:19:56 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:40 -0300
Subject: [PATCH 09/13] ASoC: mediatek: mt6359-accdet: Drop dead code for
 button detection
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-9-677a151b9b4c@collabora.com>
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

The button detection functionality depends on a calibration voltage
value which is currently not updated anywhere in the driver code, and
hence it doesn't actually do anything. Remove this unused code.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 88 +---------------------------------------
 sound/soc/codecs/mt6359-accdet.h | 15 -------
 2 files changed, 2 insertions(+), 101 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index e45630a134bb3a27bb52a80f43901c9fe4eac105..d2841b1385c7cbc5603100a56576eae3b6273b20 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -37,9 +37,6 @@
 
 #define ACCDET_PMIC_RSV_EINT		BIT(7)
 
-#define ACCDET_THREE_KEY		BIT(8)
-#define ACCDET_FOUR_KEY			BIT(9)
-#define ACCDET_TRI_KEY_CDD		BIT(10)
 #define ACCDET_RSV_KEY			BIT(11)
 
 #define ACCDET_ANALOG_FASTDISCHARGE	BIT(12)
@@ -322,41 +319,6 @@ static void mt6359_accdet_jack_report(struct mt6359_accdet *priv)
 	snd_soc_jack_report(priv->jack, report, MT6359_ACCDET_JACK_MASK);
 }
 
-static unsigned int check_button(struct mt6359_accdet *priv, unsigned int v)
-{
-	if (priv->caps & ACCDET_FOUR_KEY) {
-		if (v < priv->data->four_key.down &&
-		    v >= priv->data->four_key.up)
-			priv->btn_type = SND_JACK_BTN_1;
-		if (v < priv->data->four_key.up &&
-		    v >= priv->data->four_key.voice)
-			priv->btn_type = SND_JACK_BTN_2;
-		if (v < priv->data->four_key.voice &&
-		    v >= priv->data->four_key.mid)
-			priv->btn_type = SND_JACK_BTN_3;
-		if (v < priv->data->four_key.mid)
-			priv->btn_type = SND_JACK_BTN_0;
-	} else {
-		if (v < priv->data->three_key.down &&
-		    v >= priv->data->three_key.up)
-			priv->btn_type = SND_JACK_BTN_1;
-		if (v < priv->data->three_key.up &&
-		    v >= priv->data->three_key.mid)
-			priv->btn_type = SND_JACK_BTN_2;
-		if (v < priv->data->three_key.mid)
-			priv->btn_type = SND_JACK_BTN_0;
-	}
-	return 0;
-}
-
-static void is_key_pressed(struct mt6359_accdet *priv, bool pressed)
-{
-	priv->btn_type = priv->jack_type & ~MT6359_ACCDET_BTN_MASK;
-
-	if (pressed)
-		check_button(priv, priv->cali_voltage);
-}
-
 static inline void check_jack_btn_type(struct mt6359_accdet *priv)
 {
 	unsigned int val = 0;
@@ -368,15 +330,11 @@ static inline void check_jack_btn_type(struct mt6359_accdet *priv)
 
 	switch (priv->accdet_status) {
 	case 0:
-		if (priv->jack_type == SND_JACK_HEADSET)
-			is_key_pressed(priv, true);
-		else
+		if (priv->jack_type != SND_JACK_HEADSET)
 			priv->jack_type = SND_JACK_HEADPHONE;
 		break;
 	case 1:
-		if (priv->jack_type == SND_JACK_HEADSET) {
-			is_key_pressed(priv, false);
-		} else {
+		if (priv->jack_type != SND_JACK_HEADSET) {
 			priv->jack_type = SND_JACK_HEADSET;
 			accdet_set_debounce(priv, eint_state011, 0x1);
 		}
@@ -606,48 +564,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (ret)
 		priv->data->eint_comp_vth = 0x0;
 
-	ret = of_property_read_u32(node, "mediatek,key-mode", &tmp);
-	if (ret)
-		tmp = 0;
-	if (tmp == 0) {
-		int three_key[4];
-
-		priv->caps |= ACCDET_THREE_KEY;
-		ret = of_property_read_u32_array(node,
-						 "mediatek,three-key-thr",
-						 three_key,
-						 ARRAY_SIZE(three_key));
-		if (!ret)
-			memcpy(&priv->data->three_key, three_key + 1,
-			       sizeof(struct three_key_threshold));
-	} else if (tmp == 1) {
-		int four_key[5];
-
-		priv->caps |= ACCDET_FOUR_KEY;
-		ret = of_property_read_u32_array(node,
-						 "mediatek,four-key-thr",
-						 four_key,
-						 ARRAY_SIZE(four_key));
-		if (!ret) {
-			memcpy(&priv->data->four_key, four_key + 1,
-			       sizeof(struct four_key_threshold));
-		} else {
-			dev_warn(priv->dev,
-				 "accdet no 4-key-thrsh dts, use efuse\n");
-		}
-	} else if (tmp == 2) {
-		int three_key[4];
-
-		priv->caps |= ACCDET_TRI_KEY_CDD;
-		ret = of_property_read_u32_array(node,
-						 "mediatek,tri-key-cdd-thr",
-						 three_key,
-						 ARRAY_SIZE(three_key));
-		if (!ret)
-			memcpy(&priv->data->three_key, three_key + 1,
-			       sizeof(struct three_key_threshold));
-	}
-
 	of_node_put(node);
 	dev_warn(priv->dev, "accdet caps=%x\n", priv->caps);
 
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index c234f2f4276a12853a6fe0b13c4198dfc551b6b4..0ad5c8660a0bf4a87136a700698b04dff121b175 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -50,19 +50,6 @@ enum {
 	eint_inverter_state000,
 };
 
-struct three_key_threshold {
-	unsigned int mid;
-	unsigned int up;
-	unsigned int down;
-};
-
-struct four_key_threshold {
-	unsigned int mid;
-	unsigned int voice;
-	unsigned int up;
-	unsigned int down;
-};
-
 struct pwm_deb_settings {
 	unsigned int pwm_width;
 	unsigned int pwm_thresh;
@@ -88,8 +75,6 @@ struct dts_data {
 	unsigned int plugout_deb;
 	unsigned int eint_pol;
 	struct pwm_deb_settings *pwm_deb;
-	struct three_key_threshold three_key;
-	struct four_key_threshold four_key;
 	unsigned int moisture_detect_enable;
 	unsigned int eint_detect_mode;
 	unsigned int eint_use_ext_res;

-- 
2.48.1


