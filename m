Return-Path: <linux-pm+bounces-23387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99858A4E438
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7723BE1A4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6773286292;
	Tue,  4 Mar 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gH7U9mYN"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FB206F3F;
	Tue,  4 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101404; cv=none; b=RPATi3sw04P3c9DZEU0JGZR80OoEbMj1IcmJsKK9UYTrJeOoSDB0jxMcSdxlVXm7UU27fWpt0Dxdp9mc1rITwV9H3103YIQNNMykTANcz+Jol6CeIJGw5PlJFO1avW2RK+2+MPeHq8f2FDTkf+x+EXzAyrGHVGHLxseixkPNalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101404; c=relaxed/simple;
	bh=oENbZq9wxTXMu0zGgWXBpMvdBFjW1P8NsiaK44heerA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktgKPbdXNqfpbmEIZw9vkAObhArgzCPZoAoqXKJK3OzMPNSkEQPb79z/kPkilxQEEYAzbu5Mu/enU0L/RbjsH91VPHeJmdGK5BSAcv7N5MSClLJDkhJeKMEj/cyUI0XCz9gbS/+WHrM3aT/vkbB3QDD5TNlbtLY+qPXcjPXhHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gH7U9mYN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101401;
	bh=oENbZq9wxTXMu0zGgWXBpMvdBFjW1P8NsiaK44heerA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gH7U9mYNOoTAY+C5Mv8HQQ+3xjkMY3Ju1G4zwT7SoWUDstR/SUMISk6dGUhzoN1AB
	 phHPr56Mc2aRVdI5vCreMz63RO60TPcKLMSj3jlp3jr2hvh2CDTp5SwQBDz2IfR+mK
	 djPn7rZ4Ml7HLgykB8iyfsxmHMctf9VmEjbaBjOtXlG++Bu1kzQWHUkzeMee4f01lU
	 +tbttMgaYqwGK/irunkdGBsbujIcPUhj0QNMUFXPPZ8nTVh+TBXoXNJC8Ao+R3cjTQ
	 ZKOP+GXCKRs8dnmcNrCb0EPM9pSeNTp+gI6EKBOMpkyRhbPi0WWMEhqOkVFvm4jNW/
	 X8hgvRXCL5Jjw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0738C17E0A4E;
	Tue,  4 Mar 2025 16:16:35 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:47 -0300
Subject: [PATCH v3 06/20] ASoC: mediatek: mt6359-accdet: Implement HP_EINT
 polarity configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-6-5b0eafc29f5b@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Andrew Perepech <andrew.perepech@mediatek.com>
X-Mailer: b4 0.14.2

From: Andrew Perepech <andrew.perepech@mediatek.com>

The driver currently reads the HP_EINT polarity from the Devicetree but
never actually configures the hardware accordingly.

Implement the polarity configuration in hardware.

Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


