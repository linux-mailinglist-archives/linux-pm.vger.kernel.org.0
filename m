Return-Path: <linux-pm+bounces-23232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A94A4B338
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B38188FDA0
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918F1EB198;
	Sun,  2 Mar 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZkC4Q8DA"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE21E7C0E;
	Sun,  2 Mar 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933089; cv=none; b=ieVb1BhfQXL+bnTyyzXiey4/h61kDobCxePrFKOtHNSWc48HBUCKKoKikZ8nXCk0l/RE7mKdS2woUuWLcnI+2xufXsazK0LaGd5rxwkcwsRJFBqWWZT513jtRG2rCxJV5P+DwxfPplfEVGziZ42sQvcGEw7gumR5okCtOIw0gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933089; c=relaxed/simple;
	bh=Tgw0vGvYn1aDa8wojLhwcCN01faBqA4xTfz6ljblzSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QX9FcF7eGEq4rPsYeUVbpqvvc5UHJ/I3FIk3G3zzPzqpVXqm/lY8GV3XdkDV9EQC1nlEIyafxC8glVVuebK9NiViWen9WWZz41Dvdk+xQ/S6h74RDaeaVPeFPqGZ+AvUPlgq7SHd1bQnLklVIrKwIyydzGzWyPLEIpmXL8d6HGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZkC4Q8DA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933086;
	bh=Tgw0vGvYn1aDa8wojLhwcCN01faBqA4xTfz6ljblzSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZkC4Q8DArJsElX5mVKrRXBBfLaT1irlAZQArADcVPCGPL+Ab6BcqyMyf4C4bQIrit
	 yOoh9dihrQyq7UITc0Vh1EG4Gy6GsoernpZ1J7SyJInzaJQPTLZpuk2En8SN7/mCRx
	 YkpFxcQ8auzlrHsjsEKb2Ev5PgAbJ5orQX2TREHxUfIzJvkrxq5FBdz5FLVk3rb4lY
	 wb8ZWbANx1e3vm/bW7owmq0FU/67OHRr7z/6mexlE0hZreNvShz7qW0TRBm2w55GjH
	 W6h3OqOkShx/qeXQEQjJ1zktT3TeAu+kcXYjLfmnCL3h4ei9Dg114+P9PegISFaclW
	 E77dMXu/Afd0A==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0406F17E023F;
	Sun,  2 Mar 2025 17:31:20 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:44 -0300
Subject: [PATCH v2 05/20] ASoC: mediatek: mt6359-accdet: Handle
 hp-eint-high property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-5-5bd633ee0d47@collabora.com>
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

Now that the dt-binding was introduced, the property that governs the
eint polarity is a boolean called mediatek,hp-eint-high, while the
current code handles a u32 property called mediatek,eint-level-pol.
Update the driver handling accordingly.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 5 +----
 sound/soc/codecs/mt6359-accdet.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 9bbd4497e8d481ee125693be2fc576b439574b39..ca3be59d2d0ecaadccd9ba399649ba93f20490c4 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -578,10 +578,7 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (!ret)
 		memcpy(priv->data->pwm_deb, pwm_deb, sizeof(pwm_deb));
 
-	ret = of_property_read_u32(node, "mediatek,eint-level-pol",
-				   &priv->data->eint_pol);
-	if (ret)
-		priv->data->eint_pol = 8;
+	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
 	ret = of_property_read_u32(node, "mediatek,eint-use-ap", &tmp);
 	if (ret)
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index c234f2f4276a12853a6fe0b13c4198dfc551b6b4..a54a328bdf3797ce642da446c0cc6792f72ec939 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -86,7 +86,7 @@ struct dts_data {
 	unsigned int mic_vol;
 	unsigned int mic_mode;
 	unsigned int plugout_deb;
-	unsigned int eint_pol;
+	bool hp_eint_high;
 	struct pwm_deb_settings *pwm_deb;
 	struct three_key_threshold three_key;
 	struct four_key_threshold four_key;

-- 
2.48.1


