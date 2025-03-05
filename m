Return-Path: <linux-pm+bounces-23503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B0A50A9D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F357A9B62
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1352571A8;
	Wed,  5 Mar 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CoIUP5Vw"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE882571AB;
	Wed,  5 Mar 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201187; cv=none; b=V4eQORlwApU7A91fCCdFeLDzEwNxZtjemFMWguiojgkC8oXTeUZ3Y+SIUYNmlSUq8zVI1RwIn6Ql/qsHt2aqbUsBW+4jUeZV8xo0DqCG8si8YnnFvxMSgCAmElwIMRdLlOMo/FkeYW0BqmkfFkZswl9R9fGz+TpKOmxAc+bo9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201187; c=relaxed/simple;
	bh=lix1WOppoHxLTu8lRo8ZOELVqyyGO52750g+3jKAaYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEVhC9vZuhpUJtJWGKZNdr2Wqug3W0elzuEnPAYIiNWF0Q88wChMcoT8S1LXbg3+0OqlcgY875DwYeNDl9gvdB7W5l69fRIVa1vC9CnRVMkgzQhp+3Cvd77H2Jcu4KTIR348iA6ofgJjJa1SX6s0AnQp5rNE+jL0Ry1HjyLRr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CoIUP5Vw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201183;
	bh=lix1WOppoHxLTu8lRo8ZOELVqyyGO52750g+3jKAaYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CoIUP5VwwBV5tif8gKDEdiKkhVFH1jDrE32RoRJfxre0TjDsJszxrVSk1cZ0pRXsz
	 N3Wo5lBzowIfdBlS1u6R4vbWrYSk91AnR2LleCyb+8iUYyNbutLTGeddtDub/sUI64
	 th5sNwCHjSO3JKbYOfI7PVZ7ZrIUNUIEF42ybhAH40OOpfBR+Gx1ZrnlxWmTnwIcao
	 8mBK8khE2pCneFE9+RM8ZITh6PFSAHOqpB/kb+ovT+AmSXG/xM8YQkgdYT3GSNP2ZU
	 47YVpWd2TcNKRW8J9KVYw+jomYilS+2HmJQh8VMHKn3iSMD08Q1BvVDyUJEMRU2zm9
	 2UzyuZnype0DA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 80E8B17E0147;
	Wed,  5 Mar 2025 19:59:38 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:19 -0300
Subject: [PATCH v4 04/19] ASoC: mediatek: mt6359-accdet: Handle
 hp-eint-high property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-4-e5ffa5ee9991@collabora.com>
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

Now that the dt-binding was introduced, the property that governs the
eint polarity is a boolean called mediatek,hp-eint-high, while the
current code handles a u32 property called mediatek,eint-level-pol.
Update the driver handling accordingly.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


