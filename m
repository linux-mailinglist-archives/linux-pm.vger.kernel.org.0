Return-Path: <linux-pm+bounces-22103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F777A3646B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3568B1893F74
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3502690E4;
	Fri, 14 Feb 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="auKxJJZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF82690CD;
	Fri, 14 Feb 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553624; cv=none; b=dr2QTiCgr4nFjhKkUlYugoq3dJxHTstkUBefYAlOFtodvFfCsZgAyR+0xps1wXZPDl9cvAkxHu2v2nH2S9ens+PpyXS0z0yjIS51capbV3TNbmGgjmGTJIE8pz57ilVlURQi6oKVicsQ++yBUmOs2CfThS2NsIBtMlHh7bKWKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553624; c=relaxed/simple;
	bh=L2T4ek7h+Mjl4qzzgisy3XYBCi228hsxzedCePnCexI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhY1Zb8dCMFNKwoER0RbHqcYtRHQlByrfxXV1MGPXGt6y/k7B4CmiTJbEXH9vRaNv9KXMhBwwRuWV26YHP8TJw0ePpUex2ut9HceEalXDBQAFLfeO1QHfqX52jb3VrelSDH5DPi7jtuNZL3oD16Bi5w+Mjgx/BtO067UZglH/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=auKxJJZU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553621;
	bh=L2T4ek7h+Mjl4qzzgisy3XYBCi228hsxzedCePnCexI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=auKxJJZUPekOf9Bnx36fTulkRnQEg57CiyhOlb3MLcwskpDf4OLbEmACcNzodrjVv
	 z8m6OC+B8VMgW5gauE6O0YI1A0JIF8fu/JzqBhybz8r3Nydud4toCYg/9y2+ekliqh
	 LRP9j9v7WRVbDsvBf/JX9MsINIB6f19McQlsXTMBlB3VvHR870Y2jj4WOuop/st5Y7
	 ajH6r6i/1KCLYTAkNtbRIwApOljMpDJfQ4JRnd/+AUVWfQhLF+10qR+kx2LgebCt8v
	 Lr/iqezRlm/pVtPiyDZXGRGFryzYu2vOdom6keujVmNlUlAUULsPgIoNEi3sH0c1xn
	 uvQaD7sO9c6PQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CDA817E0239;
	Fri, 14 Feb 2025 18:20:15 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:44 -0300
Subject: [PATCH 13/13] arm64: dts: mt6359: Add accessory detect node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-13-677a151b9b4c@collabora.com>
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

Add audio jack detection node. PMIC accessory detect driver will
create an input device that will send key events on jack
insertion/removal or accessory device key presses.

Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 150ad84d5d2b30ab6064c71e1375ce5df5ae4b36..44631fa046b88fffe888d94bfb9b5943b8a66b24 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -15,6 +15,30 @@ pmic_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		accdet: accdet {
+			compatible = "mediatek,mt6359-accdet";
+			mediatek,mic-vol = <8>;
+			mediatek,mic-mode = <2>;
+			mediatek,pwm-width = <0x500>;
+			mediatek,pwm-thresh = <0x500>;
+			mediatek,pwm-fall-delay = <1>;
+			mediatek,pwm-rise-delay = <0x1f0>;
+			mediatek,debounce0 = <0x800>;
+			mediatek,debounce1 = <0x800>;
+			mediatek,debounce3 = <0x20>;
+			mediatek,debounce-auxadc = <0x44>;
+			mediatek,eint-cmpmen-pwm-width = <4>;
+			mediatek,eint-cmpmen-pwm-thresh = <1>;
+			mediatek,eint-debounce0 = <5>;
+			mediatek,eint-debounce1 = <3>;
+			mediatek,eint-debounce2 = <3>;
+			mediatek,eint-debounce3 = <5>;
+			mediatek,eint-inverter-debounce = <0xe>;
+			mediatek,eint-detect-mode = <4>;
+			mediatek,eint-num = <0>;
+			mediatek,eint-comp-vth = <2>;
+		};
+
 		mt6359codec: mt6359codec {
 		};
 

-- 
2.48.1


