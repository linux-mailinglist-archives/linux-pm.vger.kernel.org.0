Return-Path: <linux-pm+bounces-22095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F6A3645B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891B71897771
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609232690EB;
	Fri, 14 Feb 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DkS1ptnk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A4268693;
	Fri, 14 Feb 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553584; cv=none; b=CAU13P2x6q9NRwJvqdGPwmUrw0eryIoK8EEmUblfLGKQdjYii5KJmpDfdjh7AY1i2c9aAYRLdgSRUNbVtvZo4o9+JU7W5sx5P0gSfKqtrGb0+BO0nVFZEh5YsaGlRwSUGB6lhw7wfO1Msy8+36W601yAXTvkZX38Vj2tLjrH3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553584; c=relaxed/simple;
	bh=mp9J76YP/HsVdMmLzZKcE6D8+8zelpiTKlZzw4q9iyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyZ2VudFcCNAye74lFEHebF41IETe9W8REtS559SqnNJ1r79TCV+GF7L6bIOQJ3U4FZXAiQ1zrRYG15kDnlsCnmVW+rfogQE7CKBpp+FeOyK6pNbabys5gwkaOVxGlMCq/8SjpW6eeQWjF44zX6vil6WyOa88tFlRR7Tg2Nb42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DkS1ptnk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553580;
	bh=mp9J76YP/HsVdMmLzZKcE6D8+8zelpiTKlZzw4q9iyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DkS1ptnka7mTCYFzCt3C4eiZfK5/Fs4EOLoFJO0U41PpywCfMKAg3Pr0SRh1YfFF3
	 auBkT7X170y7/8M7Bg/XDOPQ5zGbgE185dqRq/vYhJp+NIOszHfEkcV3cZ2NzcH6KX
	 D3cyMpA4QWEW/OHg2fNWHls6kyqxv+F6z8HjrhEE7scfSDQFgFfx59004VR9biWlbJ
	 j9TJNcBWG/kR9FkSPIpMMRq+IGymWkCJOYX9U9L75KETufkN6vBs25XI4LBGNqNQQL
	 gAx24d/z6dOT70sK4rzsI2hqelWHdcabQezFkNV4rGDJHdq/xKNHrAGdFL2/L65VaB
	 xdlBCVBAKnTBg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1287E17E0239;
	Fri, 14 Feb 2025 18:19:35 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:36 -0300
Subject: [PATCH 05/13] ASoC: mediatek: mt6359-accdet: Implement EINT IRQ
 polarity configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-5-677a151b9b4c@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

From: Andrew Perepech <andrew.perepech@mediatek.com>

The driver currently reads the EINT IRQ polarity from the
"mediatek,eint-level-pol" property but never actually configures the
hardware accordingly.

Implement the IRQ polarity configuration in hardware.

Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 6f07db879c6a56ce4843954f51bb9602373e4aa5..eee676d1faef2076bc837a12a2ee3615216752b7 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -733,6 +733,22 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 					   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
 		}
 	}
+
+	if (priv->data->eint_pol == IRQ_TYPE_LEVEL_LOW) {
+		/* EINT polarity normal */
+		regmap_update_bits(priv->regmap,
+				ACCDET_EINT_IN_INVERSE_ADDR,
+				ACCDET_EINT_IN_INVERSE_MASK_SFT,
+				0);
+	} else if (priv->data->eint_pol == IRQ_TYPE_LEVEL_HIGH) {
+		/* EINT polarity inverse */
+		regmap_update_bits(priv->regmap,
+				ACCDET_EINT_IN_INVERSE_ADDR,
+				ACCDET_EINT_IN_INVERSE_MASK_SFT,
+				BIT(ACCDET_EINT_IN_INVERSE_SFT));
+	} else {
+		dev_warn(priv->dev, "Unacceptable EINT level type, using default\n");
+	}
 }
 
 static void config_eint_init_by_mode(struct mt6359_accdet *priv)

-- 
2.48.1


