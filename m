Return-Path: <linux-pm+bounces-23233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB4A4B33C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A142416BDD7
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E01EB1A6;
	Sun,  2 Mar 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c9TTeLh1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FE1EB1A2;
	Sun,  2 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933095; cv=none; b=bToJTCX1kqqIE4nCtois+/vSHSK+Xa+maiM6LU7+xf165JikN/gIIK9wosO4l2hGxvFBBOUV9jSGhIKEbB4jHZ56mQYUzo2SP0LBS6a4+ONbDyOC7gXYGS8DeqHkFii6K7waDd1m7DSzoHM6a3CYFarISr0wznbxX5zWpHvaAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933095; c=relaxed/simple;
	bh=FkPtvAEM6RvpAzlk3x8AyVhuQwrjqUaQxcRHThP+YKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPL3hbC6a9o2LyhYYYHTE1Kd3hevS5xjvn4tnuJgOmhg5BWQ5A8K6B6zLXUJi54vN5XqrzS00qakA3+DZFQqLQ2W0WO8qENQxXbX5UsFpgToWE1UGFu87av6Hr8TvD3imWBQ0+P//MRFGQYZs0OKidNqPcmgyUG4PRDdDAhRQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c9TTeLh1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933091;
	bh=FkPtvAEM6RvpAzlk3x8AyVhuQwrjqUaQxcRHThP+YKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9TTeLh1LRdbGNwXw5bOST5NyBn+pkNPsioBA4pHKuybYEu3UF8o8SxtVnSNJOpZe
	 bH/dZTdWaaLlRb/uIpsFQ5CRbcToGjQrzY7cS91mVBo9euuTmZPSyXrYHnagT0dzF8
	 Ve2ZZFduqBOxJrrJ78w0gGvGzKZ5P19KTXoGZUOBQs0F5Djhd+WawLjOf+kcIrew1u
	 t9UDtD5wFNvWAJdN6XjbNsfXA22FeM2sP94v0yLQO9Kxks8ifpCF4fFniyS87cahk5
	 NFAxQM6k2lHMq1CUYJXLVy7VEUeyT2rTmL0TS/y1mF78DAMSiNI2I/ze7BH3Uxcjzw
	 xdVz3Ew2oJzMA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EA4717E05EA;
	Sun,  2 Mar 2025 17:31:26 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:45 -0300
Subject: [PATCH v2 06/20] ASoC: mediatek: mt6359-accdet: Implement HP_EINT
 polarity configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-6-5bd633ee0d47@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

From: Andrew Perepech <andrew.perepech@mediatek.com>

The driver currently reads the HP_EINT polarity from the Devicetree but
never actually configures the hardware accordingly.

Implement the polarity configuration in hardware.

Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index ca3be59d2d0ecaadccd9ba399649ba93f20490c4..1d4481109f6e4f473610e0797c9d3c636bdf12cf 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -730,6 +730,17 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 					   BIT(ACCDET_EINT1_INVERTER_SW_EN_SFT));
 		}
 	}
+
+	if (priv->data->hp_eint_high) {
+		/* EINT polarity inverse */
+		regmap_update_bits(priv->regmap, ACCDET_EINT_IN_INVERSE_ADDR,
+				   ACCDET_EINT_IN_INVERSE_MASK_SFT,
+				   BIT(ACCDET_EINT_IN_INVERSE_SFT));
+	} else {
+		/* EINT polarity normal */
+		regmap_update_bits(priv->regmap, ACCDET_EINT_IN_INVERSE_ADDR,
+				   ACCDET_EINT_IN_INVERSE_MASK_SFT, 0);
+	}
 }
 
 static void config_eint_init_by_mode(struct mt6359_accdet *priv)

-- 
2.48.1


