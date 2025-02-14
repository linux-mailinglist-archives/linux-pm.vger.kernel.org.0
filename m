Return-Path: <linux-pm+bounces-22096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0EA36457
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C810170A37
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11B268C42;
	Fri, 14 Feb 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iRu7SqZn"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73330268693;
	Fri, 14 Feb 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553589; cv=none; b=YqWhQvr3FOquE6QgbBBD0RvHzqm1xSLIRQc6rKwS0YQOSiA8RWsEc76psK1RCUo07xZ1kEDf/5UBBNA/exz3jwEKaM9mr6YT3K5CuMup/9lzkaVTBcyUsHXtVzMdqIae3gCL4+eVTG7+yL+h6zXWtcsP0wmB0/aaylt+W/xLghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553589; c=relaxed/simple;
	bh=vJ93fyDfMroysl58pmK4LB0ei52PWUbfp+wax1ulrhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rA1YxB7bCID8Mq5UWXqj2HvcyXdXGmMDiWhp4WX0S41tjSfIq/zFT1ZXmu+CLLreTuuNRU6t0xnewDrNXvyYAhu82y2NjDdgA6TpAv9e6Zm4VSOwjVlHd/P7+32sr8EVgwtYH/JRQABPzBcir4GK7Sdli8i1nilKSUE4JxN/kxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iRu7SqZn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553585;
	bh=vJ93fyDfMroysl58pmK4LB0ei52PWUbfp+wax1ulrhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iRu7SqZnHmZMxyu8W02fGyQa/wGbL/cGVz4tnGT41QMdkwm5K4om+wH1Z0TbKS25L
	 vevjesfWzwLfXnc5iovD6wAsDrI0baCey402OdpA/mLYf77xkCd2Y8oGOmqqY7r94t
	 1hdfIrUTJk6fRVFI9lwD08R7/wa9lzaWhDCaWIdBVa4MQxqDtcwzlpKKu06oPFeEZd
	 HQdUa15mIJzyiBCHAeboi/rnPCtVNuK6K22LB0lIbjKzHDOJYHNQUFNXDAqk96ZuAy
	 t0eKrMigLmMpKKXFPBIXh1e7cJQ+XHNX6+Kal7Rq13rQVaGOJshaypy30Ql4QdjXpm
	 kKH9KKEKvDVTg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4931E17E1553;
	Fri, 14 Feb 2025 18:19:41 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:37 -0300
Subject: [PATCH 06/13] ASoC: mediatek: mt6359-accdet: Use
 IRQ_TYPE_LEVEL_LOW not raw value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-6-677a151b9b4c@collabora.com>
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

The symbol IRQ_TYPE_LEVEL_LOW is equivalent to 8, but the former should
be used for legibility. Update the code accordingly.

Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index eee676d1faef2076bc837a12a2ee3615216752b7..b71957f7a2edb352add23884fd9e231e36b08621 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -581,7 +581,7 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	ret = of_property_read_u32(node, "mediatek,eint-level-pol",
 				   &priv->data->eint_pol);
 	if (ret)
-		priv->data->eint_pol = 8;
+		priv->data->eint_pol = IRQ_TYPE_LEVEL_LOW;
 
 	ret = of_property_read_u32(node, "mediatek,eint-use-ap", &tmp);
 	if (ret)

-- 
2.48.1


