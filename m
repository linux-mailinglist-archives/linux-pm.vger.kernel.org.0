Return-Path: <linux-pm+bounces-22100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5EA36466
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913B318972CB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FC268690;
	Fri, 14 Feb 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZoQlY4m9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A96269B01;
	Fri, 14 Feb 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553608; cv=none; b=m2YnT5e/zEpXJvAXcH9fl9FDT9yEJPbuafnvHmBTJ97HakR+Rn9JzVN3ctjEhzyzIiJznF10n/54NNK3EUfpn9++f5LPqOT1k5UKs5adnqpCOFY0+I1mDF3RT33UDSQlKVIR76zyu85vePddZ+rvGf2KivTr7rC6aCKwVpAj0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553608; c=relaxed/simple;
	bh=fvWy4uz+V/+JDM2O3ZKqvPv58h/Ey85tbYBXNegYFRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htGNJYCrSVdjIuvthJrnyw8aOH70daceqHUgosGSc4jnM5qUeHXdsd6zVPiUBOg/zGkMO5tixGzww3RLovVNuCNEaIDazLsnJdLxG6RxzZnIKbH46OL/Rjhr2Z9+Ux/FVjCjkquaD6BK0vceSa+i4TdkjZlXRP5q0SftabP56QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZoQlY4m9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553605;
	bh=fvWy4uz+V/+JDM2O3ZKqvPv58h/Ey85tbYBXNegYFRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZoQlY4m9HOBzemahk3IJNV7TjpXXHwLq+snwgYRM5N6G1F2m7TuIZMzKXxhzKg4XJ
	 oixwGlbKVYTGXh6nDCXUYlUiiXd9GiNTJzQV2cm+f4CKXhpMdYNJ4yHrgaxAPsqOEn
	 YzUin/vriuey76s1qgxBqEdr91hAAoxvSzon0G1YqgFITNkBLEzqPNKacBqC3KyncC
	 gLXJueLAYRh6er1CgaP6lcCehtWuZcyypj/veBYsDK+sIhL+9f7QVNRG/E1x/TJG3L
	 yJzC2aUZBA5CgijQnj2JQjtNbCVktlQRzadl0z6n/c5ZfRctqsUNwknFCDFJtvXpNL
	 BbZ1Pl4cmN/qg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8569E17E0FC1;
	Fri, 14 Feb 2025 18:20:01 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:41 -0300
Subject: [PATCH 10/13] ASoC: mediatek: mt6359-accdet: Drop dead code for
 plugout-debounce
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-10-677a151b9b4c@collabora.com>
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

The mediatek,plugout-debounce property is undocumented in the binding
and unhandled by the driver. Remove it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 5 -----
 sound/soc/codecs/mt6359-accdet.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index d2841b1385c7cbc5603100a56576eae3b6273b20..c3d51c0753c815cd92935736300f57fd18e033f7 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -514,11 +514,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (ret)
 		priv->data->mic_vol = 8;
 
-	ret = of_property_read_u32(node, "mediatek,plugout-debounce",
-				   &priv->data->plugout_deb);
-	if (ret)
-		priv->data->plugout_deb = 1;
-
 	ret = of_property_read_u32(node, "mediatek,mic-mode",
 				   &priv->data->mic_mode);
 	if (ret)
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 0ad5c8660a0bf4a87136a700698b04dff121b175..148e181fc00048ea349c029b382507542a33202e 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -72,7 +72,6 @@ struct pwm_deb_settings {
 struct dts_data {
 	unsigned int mic_vol;
 	unsigned int mic_mode;
-	unsigned int plugout_deb;
 	unsigned int eint_pol;
 	struct pwm_deb_settings *pwm_deb;
 	unsigned int moisture_detect_enable;

-- 
2.48.1


