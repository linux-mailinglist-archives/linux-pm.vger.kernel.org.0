Return-Path: <linux-pm+bounces-23238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E70A4B351
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E943B37E6
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94B1EB9FD;
	Sun,  2 Mar 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gXs5rFt+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCE262A6;
	Sun,  2 Mar 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933122; cv=none; b=gygESZhZx8+9TuqmS5tzzxZpZOfscvc09q5toWAYMYHZx/9UhISasxO+qt49m9g1t7jKKE44h+mBrSdYkNlZHrB85WoWtvtbOXFPLXQ59ek7SYBTQnIpK+WpQFq4g8VLa81B6Bk7XdN4A3XXbpxw2TpFa2toLyqY80h7uSVu9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933122; c=relaxed/simple;
	bh=blWuAtLpdGFI63hnHg9AWnYvcxAarPSsE7Vp8kiBoC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YErmqf+8mXi3jGlSvzPMQyvvF43S14U6PeFeMsglrzFyMN8jeDTI8xQPbeUCEAHQuuRbSL0WOZdOc/18UMMg7xMW0SHKrODC/+n8gD32pjgL0IjHLdix8bYwzwavgnfHVru9NmPn9JDyNtGvQMizWRCw9+3atDy5f6FPsLA+ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gXs5rFt+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933119;
	bh=blWuAtLpdGFI63hnHg9AWnYvcxAarPSsE7Vp8kiBoC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gXs5rFt+gbMfB6kLN4m5LcMCU9n1N9UAdm82ahW/T7eYUPq52atAHtxs/rv7EqQAq
	 B4PhsYWR5MPavvKyPq8IUJy6CdRpd7KeqjJi1zaMGOAMtLzWgMw0rOaRo5JEsCjBcR
	 zXiaa8xgf73PdF3YCB22Kl0SMs8UPZ+hluKHU7jsxek+n1nQgQvsnkVVZJ+2NW/9KV
	 rRfWxSx7JXHdRxLeJ9IkipbJOwa/JiJzlh+ZKAnfZcYlWSsGV4cuPgcbLGxAjygcyu
	 o3pWKBB7F2H5bhzbZ4a8t5hKAtK8pT3orJyib5hPbM7md1/zZpRRsXrh5sSHseL67g
	 DjqBVBnfTJR4g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A46D17E023F;
	Sun,  2 Mar 2025 17:31:54 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:50 -0300
Subject: [PATCH v2 11/20] ASoC: mediatek: mt6359-accdet: Drop unused
 moisture variables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-11-5bd633ee0d47@collabora.com>
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

The dts_data struct contains several variables for moisture
configuration that are simply never used. Drop them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 54a33a0f0e084f80df33386b3df9bba9525fa880..38c36d59b9cc68bd90e16137a05a62b521b75ac1 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -74,14 +74,9 @@ struct dts_data {
 	unsigned int mic_mode;
 	bool hp_eint_high;
 	struct pwm_deb_settings *pwm_deb;
-	unsigned int moisture_detect_enable;
 	unsigned int eint_detect_mode;
 	unsigned int eint_use_ext_res;
 	unsigned int eint_comp_vth;
-	unsigned int moisture_detect_mode;
-	unsigned int moisture_comp_vth;
-	unsigned int moisture_comp_vref2;
-	unsigned int moisture_use_ext_res;
 };
 
 struct mt6359_accdet {

-- 
2.48.1


