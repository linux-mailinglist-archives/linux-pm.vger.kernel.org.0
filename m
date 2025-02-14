Return-Path: <linux-pm+bounces-22097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7EA3645F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501ED1896954
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796E269884;
	Fri, 14 Feb 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nu/Nyn5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A3268693;
	Fri, 14 Feb 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553594; cv=none; b=spOg6hPVHEXIBVEo4/RCIO9D4LGm08Nlmcku7ZY4tlB//TlDUPYCUHkCfxYWjkTB1OQD+KOCzVTV2HvG7lglQnLvaUPI9JLxASAIsvzfhdGr2FaI3q4BhsYp8QemqRYRywCsLqM96nWW+IhUOmbVit1/vS3Lx5i32Dr7NSWOmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553594; c=relaxed/simple;
	bh=00LuyQwthdh+8uIpImTyvsn+9nWVCxHN/HdOPIE73Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V94DvSfWxIjCX7WBH0hOe4J5vZhjNsw6tqsVRzybq7AxLcB/FbsG9+3HTRono7CLPbAtuVwead/48KKwwH1U1Sbn2Y8CJmcaBvWNjkUyirT6LAxsZcVvhqGBMvR3ULGC/1taHQtSpx45b+HU6hgB8Yi/0LUtZP1brFYTANyX3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nu/Nyn5a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553591;
	bh=00LuyQwthdh+8uIpImTyvsn+9nWVCxHN/HdOPIE73Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nu/Nyn5abae0kdlvkimaIaT1dlXXVOhx4s5ajeC1Hs4tM/knyuv8wJ1doPmItwuId
	 1McNTYmOrE/rUCQ6EOcJuBlmRhk62VBC5G/v7KzwcIkBXdkuXOSnMjscKTlUSutlN0
	 HMQMTbK4YM83FcMgtV5tIcyVs28IrtvsOGPoSyGb8vZ85vRH3vE6kMzPBncq3N7FQ3
	 7xJfSM+d3GIcgOBNimcw1fEVt892CB+cqxerpNO8OWwkZzfq649PzGkaH59Pj+uotj
	 lJyKv8j/0jJLlgNR0xNISh1b8lhWWmRPUciXPJMbqyrxIlww37EXXzar4kmWD0V0fw
	 CBzCzy5Iiwxkw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4DBAA17E0239;
	Fri, 14 Feb 2025 18:19:46 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:38 -0300
Subject: [PATCH 07/13] ASoC: mediatek: mt6359-accdet: Drop dead code for
 EINT/GPIO IRQ handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-7-677a151b9b4c@collabora.com>
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

The ACCDET supports two modes for IRQ generation: PMIC EINT or AP GPIO,
which in principle could be configured through a DT property. However
this DT property has no user nor is documented in a binding, and the
driver only implements the PMIC EINT case, so drop the unused code
intended to handle both cases.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index b71957f7a2edb352add23884fd9e231e36b08621..57a70867b4b80fc904ae07ee05d0e554495ed6e7 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -31,9 +31,6 @@
 #define REGISTER_VAL(x)	((x) - 1)
 
 /* mt6359 accdet capability */
-#define ACCDET_PMIC_EINT_IRQ		BIT(0)
-#define ACCDET_AP_GPIO_EINT		BIT(1)
-
 #define ACCDET_PMIC_EINT0		BIT(2)
 #define ACCDET_PMIC_EINT1		BIT(3)
 #define ACCDET_PMIC_BI_EINT		BIT(4)
@@ -448,8 +445,7 @@ static void mt6359_accdet_jd_work(struct work_struct *work)
 		mt6359_accdet_recover_jd_setting(priv);
 	}
 
-	if (priv->caps & ACCDET_PMIC_EINT_IRQ)
-		recover_eint_setting(priv);
+	recover_eint_setting(priv);
 	mutex_unlock(&priv->res_lock);
 }
 
@@ -583,14 +579,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (ret)
 		priv->data->eint_pol = IRQ_TYPE_LEVEL_LOW;
 
-	ret = of_property_read_u32(node, "mediatek,eint-use-ap", &tmp);
-	if (ret)
-		tmp = 0;
-	if (tmp == 0)
-		priv->caps |= ACCDET_PMIC_EINT_IRQ;
-	else if (tmp == 1)
-		priv->caps |= ACCDET_AP_GPIO_EINT;
-
 	ret = of_property_read_u32(node, "mediatek,eint-detect-mode",
 				   &priv->data->eint_detect_mode);
 	if (ret) {
@@ -910,10 +898,8 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 				   0x3 << RG_ANALOGFDEN_SFT);
 	}
 
-	if (priv->caps & ACCDET_PMIC_EINT_IRQ) {
-		config_eint_init_by_mode(priv);
-		config_digital_init_by_mode(priv);
-	}
+	config_eint_init_by_mode(priv);
+	config_digital_init_by_mode(priv);
 }
 
 int mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,

-- 
2.48.1


