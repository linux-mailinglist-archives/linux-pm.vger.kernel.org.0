Return-Path: <linux-pm+bounces-23391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54071A4E3A5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E985517D168
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8928D070;
	Tue,  4 Mar 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PHFpKyfU"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CC28D069;
	Tue,  4 Mar 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101426; cv=none; b=i/q7SEmnZqEQw3oGXozmA6X4/K1YrFJo8vQWl0DfNs5IdDYLOqwkU2qsVmLqlJMeYlyYA5RLVjGpAh2+pAHUJxROW42tWgR0HUzZ8OIgAdILxV3rcncncpIKU2PK13kmrQ339Z+HsqS83n70OLNd9jsigka4KEaWCjqz76OGsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101426; c=relaxed/simple;
	bh=25TENqi8q+kBqzrzX/J7Q2+OaNY4swWOeoiOQighkU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB8KISBmC9/BeRoH2n+13hVjQgr8duKRK3DUYgHD/CSk4dMBHVhSgOnJtnL3Qs3RFMU70rUgs1DEcx7mPqofyATg8APVsJ8mymgsSt6K1WROxRC3eJtKisYUheAgJ/NytL3gH5fsVvzdjTFzqT91Xj/U/xIiUufeZ+i+lBxfnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PHFpKyfU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101423;
	bh=25TENqi8q+kBqzrzX/J7Q2+OaNY4swWOeoiOQighkU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PHFpKyfUhYm1j2LO3j/C7oEhRAUpKvlk8UTWZt5KktDPANZVjkNOTrOoRMZl0R0tZ
	 NkunvECiEw++g03QKtgqI5zHggRPqnswYfcrxq6eB+uAl8F8XcdbCLuBLAipC4xiIX
	 mEmNIdkWzRfw4Z4jrdecM+zRCE2ZGQ831EU/5yjDhYqSjHnPKLHWjMN2xEjwtXSjFi
	 vj+M/FtWvZIkg1PItEaPshjuP1wYihIdJwiJbkSK4XFMC4OQ99E8jkisdQdx5rHMUC
	 apvbRQX4DsPUHAn5Id69tJns0CRZ/5THzsY8+ohf/6vnu4UV2Gn+NKOYEO5PHy4bQ2
	 YnTaNTJ29rrhg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 24B1017E07F8;
	Tue,  4 Mar 2025 16:16:57 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:51 -0300
Subject: [PATCH v3 10/20] ASoC: mediatek: mt6359-accdet: Drop dead code for
 plugout-debounce
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-10-5b0eafc29f5b@collabora.com>
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

The mediatek,plugout-debounce property is undocumented in the binding
and unhandled by the driver. Remove it.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 5 -----
 sound/soc/codecs/mt6359-accdet.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 6b0178976d91e37c32540991693ebfd8e29c11f5..d78d7516342a5c2273b1c2962c0346646aa6390f 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -513,11 +513,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
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
index 09e1072b61a4c929bf6b764b4fab3c4b26f7cf4a..54a33a0f0e084f80df33386b3df9bba9525fa880 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -72,7 +72,6 @@ struct pwm_deb_settings {
 struct dts_data {
 	unsigned int mic_vol;
 	unsigned int mic_mode;
-	unsigned int plugout_deb;
 	bool hp_eint_high;
 	struct pwm_deb_settings *pwm_deb;
 	unsigned int moisture_detect_enable;

-- 
2.48.1


