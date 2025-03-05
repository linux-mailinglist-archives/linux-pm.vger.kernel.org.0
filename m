Return-Path: <linux-pm+bounces-23509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63288A50AAD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF77F7A10B6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045225487E;
	Wed,  5 Mar 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lk5hFQaz"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416A254859;
	Wed,  5 Mar 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201220; cv=none; b=V3Mncw9ipw0wjRVApO8A92tP8+23JUuYI8/05sr7zRp1MINgWhmEj03IFC3AtuHMYOnxX1zQao5kDFc4Mfk9n3EAn3GjkQe7AsfpTshcRkju7ZNw615sbQaQMjOHuW2YtwXDEDUhWOshRax0/PfmZsXw+lQuN2ZU0Y9lY+LcrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201220; c=relaxed/simple;
	bh=nJmb237CbucvJKm/CuN9D5tE8zn4QuoUQDJSwYS6fXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSS0zD2qs2iPtNsDTo7lsABYViHXXHNXsN+rD0mHTyElg+HH7Dfbc9fdd4skVIl1lFF7xIH3Ib+2KRACUiKCGTwsp01096P90xbIxRjGSHn+AnmaNKkjM2fVZYAGGgc/C74JkZO5n8xLATwzwsNL13PmnHr4mVZfuqng6wrEN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lk5hFQaz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201217;
	bh=nJmb237CbucvJKm/CuN9D5tE8zn4QuoUQDJSwYS6fXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lk5hFQazmOQJIF0vamtqSxirnH5zfQBapxQpL7qiCSRyb4XT2bU6gGhfTudmQJdbx
	 0l0wMZzd1p88PGEvHYgZXAlmdZlcg42F9Gv83GKrsM1qcmtfYrDNBMIUtE8Y2ltSNN
	 Yj+COCOFWLDBddFDZtVMT/sMgjlD2qzkc9/X2KD6AilQtJtp1oiPMV43RMYc+AL5Zj
	 1/9HZ64TwyYTcMg3QSWwHDedTSe9d0Tw4lPShRYPAt1Q9vv+0xrqdAq3VzkXp+2eBq
	 yO4l4ecQMu1RJAW6FHc8tnB46f/Uo93oup18+weMXPrJiwdZKUp0KD1Y9XR6foc7lc
	 d1j5WLASAsRXA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E63BB17E0649;
	Wed,  5 Mar 2025 20:00:11 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:25 -0300
Subject: [PATCH v4 10/19] ASoC: mediatek: mt6359-accdet: Drop unused
 moisture variables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-10-e5ffa5ee9991@collabora.com>
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

The dts_data struct contains several variables for moisture
configuration that are simply never used. Drop them.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


