Return-Path: <linux-pm+bounces-23235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1AA4B341
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969F6188FCAC
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C521EB5CF;
	Sun,  2 Mar 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YyNKlslS"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CC1EA7C9;
	Sun,  2 Mar 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933108; cv=none; b=NxzlrL7esl8slSk3Oo5QDY8vfOnuzAPbEniBJq4oaUJdyyi2wE0Nfnp55BpJxAH5ns5f0JT/aBEjI+yye+2xKUlNFmbITzt75KwUvp1IDPO5AGK8jxVrKLxcdWWrWKMGzj4LtojIMe1RfYEJARLjNAZdrAI2B3WEgGzVFZvCB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933108; c=relaxed/simple;
	bh=gHn6+QB7JOzpce3stmKJuB+P7B7u0x89jyrLFq5FivE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxuO91GEG6Et+9o2NURtbp6VtzjXnrg7CIDcZw6kRcAe9+SwshqjO5mswv9wbb1m6PTQBmHlm9ZIgNoLwHYKZKDo88a3rt2E0C0640fRkoIMxxvPVuKGQBvzdsQ1i9F0jUO3NZfBmXWF0MRZdKv0s2Ayc8c1+0m18fy0lvRR5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YyNKlslS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933102;
	bh=gHn6+QB7JOzpce3stmKJuB+P7B7u0x89jyrLFq5FivE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YyNKlslS+LxfRlBnn3DkmrrdMT/6VzQ04af5oLzf5c3zIhtyWByofM2o1L/aFH9W9
	 6n3yGrh4V3kJm4dReYBbVAU5cI1nlnA/j0uLQ5TdVh+lk1+EsvnT2gWV0HZIMUgwVR
	 WcckLKF9MRmFP5/OfR97erBkLy/YAkSoLf7Gdj+pwg2lFZUkwFWha58oiC4AZU2709
	 YnGM16txBSYor4/eWD9W+8Y7y10ySLp61JDffCFqRpgAr7H6ej9tYVz/3WTOhe/kHx
	 Ypy+a3JFJoYTuw/gW43jfwc4ZZTP4g7FucV2ZkTPDWXFdxfgVPzOOpsuVZxdJQkAuj
	 POT1SV0+FHAvg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC8E917E05EA;
	Sun,  2 Mar 2025 17:31:37 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:47 -0300
Subject: [PATCH v2 08/20] ASoC: mediatek: mt6359-accdet: Drop dead code for
 EINT trigger setting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-8-5bd633ee0d47@collabora.com>
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

None of the EINT trigger options are implemented and the DT property is
not described in the binding. Remove the unused code.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index ce8a5e64e0b9ca508124043ca1f93aaa3cc5f9a0..a21c6544174517e3eebc8cf25d1ea3029ba014f6 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -35,8 +35,6 @@
 #define ACCDET_PMIC_EINT1		BIT(3)
 #define ACCDET_PMIC_BI_EINT		BIT(4)
 
-#define ACCDET_PMIC_GPIO_TRIG_EINT	BIT(5)
-#define ACCDET_PMIC_INVERTER_TRIG_EINT	BIT(6)
 #define ACCDET_PMIC_RSV_EINT		BIT(7)
 
 #define ACCDET_THREE_KEY		BIT(8)
@@ -593,15 +591,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	else if (tmp == 2)
 		priv->caps |= ACCDET_PMIC_BI_EINT;
 
-	ret = of_property_read_u32(node, "mediatek,eint-trig-mode",
-				   &tmp);
-	if (ret)
-		tmp = 0;
-	if (tmp == 0)
-		priv->caps |= ACCDET_PMIC_GPIO_TRIG_EINT;
-	else if (tmp == 1)
-		priv->caps |= ACCDET_PMIC_INVERTER_TRIG_EINT;
-
 	ret = of_property_read_u32(node, "mediatek,eint-use-ext-res",
 				   &priv->data->eint_use_ext_res);
 	if (ret) {

-- 
2.48.1


