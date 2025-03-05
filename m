Return-Path: <linux-pm+bounces-23506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D44A50AAC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D511C188F311
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C85259498;
	Wed,  5 Mar 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kq6yxcbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55824CEE3;
	Wed,  5 Mar 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201203; cv=none; b=IB8nVvrT/d/sbdJi+RBWg4jtwx8xIEcF8kSEQq2bPUXQTwFAEQR5P0szXORt0M0HjeqhrSduHPTXI2J61CSXGi5gru0dnSIWxnVKzaJhGiVQX5fZm2c21JY/epXJXdv1OVm1VYAgVa/F0z7o+zSuvlz7fbef9HAL2eJOzw/96Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201203; c=relaxed/simple;
	bh=ew/lKKPHiRKrKA2kFSoKnjYv5WzKBHZsXi8V5xGuf2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oe9RwgRqlFoSzCCNQUJaqJTy2A0v1xOIggHFI0pfMUtweGllIEdxOUonCCIwNvHPd/bKboX2Od1y8df8XUkN2DM3IKl8pejjZEAv1bE3DLbkWEcCGRSb9rXPMTsFJGVLrujsQfmQm+Mbo5igVuV8xIkAxRljxVylzHfM+JYr7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kq6yxcbH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201200;
	bh=ew/lKKPHiRKrKA2kFSoKnjYv5WzKBHZsXi8V5xGuf2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kq6yxcbHxf5FMrDZ2VxBAMOctt94KtnY4rsGqlZmwu23S0gyG9yVy3C7iT2k/W0aD
	 2tMUVtJyKqua8F3g2T7l3jggQrjCoXuVNBPISFOjGjbNexrSuxSQoBs87kZ+UYz37d
	 F+N8V5oUaFIrwdWskV+LUK0RUGYRaOaAiovQv9Qo8UdZ9TripU1dh5zLSX91H1+3ei
	 o8FJOGVPAPUcl3i1spc/yezhz0mnSML/WohRJe70xV5FTb5PCkoTvPV9ugaTVq2Zez
	 swd3wamisYOfoxWPodkrGAXt9L+nxgP+cUj60yOfGDjPQC/zj5OhfwPRclAmsSsoZ1
	 uCfOCusap729A==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6E41517E017D;
	Wed,  5 Mar 2025 19:59:55 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:22 -0300
Subject: [PATCH v4 07/19] ASoC: mediatek: mt6359-accdet: Drop dead code for
 EINT trigger setting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-7-e5ffa5ee9991@collabora.com>
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

None of the EINT trigger options are implemented and the DT property is
not described in the binding. Remove the unused code.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


