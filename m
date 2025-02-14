Return-Path: <linux-pm+bounces-22101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F262A36471
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD543B32AB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33DA269CED;
	Fri, 14 Feb 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZDIWifHG"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4667269CF4;
	Fri, 14 Feb 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553613; cv=none; b=Lw93edb+6FyQCfbOjukv+cDv/d+Rdb6oZ9yq14LaeIsKEPHH8oIh7ekg4IfJZxi3pIRfScRlWpPSkoxZN0peE76/cm7k9NJ77P5qAPDzRg2N+0hTORlsKpRVfN0INg6FnPzJ+obUDwRCgQThV/iSLrZqvFkKhaJzPgKG3NXmswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553613; c=relaxed/simple;
	bh=daPg2Fccz1EsxoSOHSS26SMyam1GJAwCnpk0jrud1Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oev9gycYQJBm2xqDOKY30Sdi3WQEOULwVS8UkhCLhyY1sQfVlERsfWkfbXDjP1pDrYX1XAoqzsidTizUIJzXa8tjpZRqzzoWLoPvpoocWEIYG+fc5CsGZts3zsbBauLKYxchRJo6doaBvBykO+OpZT3+Jlo1SUUNT9CQDAqE5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZDIWifHG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553610;
	bh=daPg2Fccz1EsxoSOHSS26SMyam1GJAwCnpk0jrud1Jc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZDIWifHGTNohT2atoseUGMlz2wV56E7UPz45PLkn29wGPTh841/hlaVfWyCXPpFgJ
	 HVwQ/XU+eSG1tUTwse6mW/3Nz5hMBLWU31dEUDjnVA3ljsKiZzO3CGHHg/9GB2V46t
	 oss2kceiK/DYUuDt6ACSrEKRYjZ25sj+3nsrdRQ7YAu4uat9tMwq5UCoUVi2vNRbz3
	 /otgmvMRGUR7iegJuheY7HFcQGoCJeOO3Fm6IE+3ewFZSIzNlJ7yjTj3ATHBgstJe7
	 GxrmN7eS77a4UIjhkZqQg5FxfKvBcR5zKRGTbipeiBG0Ew/4q2OyeujIXsDJooriWs
	 tV/ojXxwRwrug==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00C1017E0239;
	Fri, 14 Feb 2025 18:20:05 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:42 -0300
Subject: [PATCH 11/13] ASoC: mediatek: mt6359-accdet: Handle
 mediatek,eint-use-ext-res as bool
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-11-677a151b9b4c@collabora.com>
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

The code currently allows for values between 0 and 4 for the
eint_use_ext_res property, but it should be handled as a boolean, either
configuring the internal resistor to be used or not. Update the code
accordingly.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 12 +++---------
 sound/soc/codecs/mt6359-accdet.h |  2 +-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index c3d51c0753c815cd92935736300f57fd18e033f7..646cdd4e0b57f2a007fdcfcaecb7534e08ae61c4 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -82,8 +82,7 @@ static unsigned int adjust_eint_analog_setting(struct mt6359_accdet *priv)
 					   RG_EINT1CONFIGACCDET_MASK_SFT,
 					   BIT(RG_EINT1CONFIGACCDET_SFT));
 		}
-		if (priv->data->eint_use_ext_res == 0x3 ||
-		    priv->data->eint_use_ext_res == 0x4) {
+		if (!priv->data->eint_use_ext_res) {
 			/*select 500k, use internal resistor */
 			regmap_update_bits(priv->regmap,
 					   RG_EINT0HIRENB_ADDR,
@@ -547,12 +546,7 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	else if (tmp == 2)
 		priv->caps |= ACCDET_PMIC_BI_EINT;
 
-	ret = of_property_read_u32(node, "mediatek,eint-use-ext-res",
-				   &priv->data->eint_use_ext_res);
-	if (ret) {
-		/* eint use internal resister */
-		priv->data->eint_use_ext_res = 0x0;
-	}
+	priv->data->eint_use_ext_res = of_property_read_bool(node, "mediatek,eint-use-ext-res");
 
 	ret = of_property_read_u32(node, "mediatek,eint-comp-vth",
 				   &priv->data->eint_comp_vth);
@@ -660,7 +654,7 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 	if (priv->data->eint_detect_mode == 0x1 ||
 	    priv->data->eint_detect_mode == 0x2 ||
 	    priv->data->eint_detect_mode == 0x3) {
-		if (priv->data->eint_use_ext_res == 0x1) {
+		if (priv->data->eint_use_ext_res) {
 			if (priv->caps & ACCDET_PMIC_EINT0) {
 				regmap_update_bits(priv->regmap,
 						   RG_EINT0CONFIGACCDET_ADDR,
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 148e181fc00048ea349c029b382507542a33202e..1a255a360b2319396e9b7a5a145a9317e575587f 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -76,7 +76,7 @@ struct dts_data {
 	struct pwm_deb_settings *pwm_deb;
 	unsigned int moisture_detect_enable;
 	unsigned int eint_detect_mode;
-	unsigned int eint_use_ext_res;
+	bool eint_use_ext_res;
 	unsigned int eint_comp_vth;
 	unsigned int moisture_detect_mode;
 	unsigned int moisture_comp_vth;

-- 
2.48.1


