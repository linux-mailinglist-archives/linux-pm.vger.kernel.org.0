Return-Path: <linux-pm+bounces-22090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40157A36446
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661DB189540A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E63267729;
	Fri, 14 Feb 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IUGXUY/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC8264FA7;
	Fri, 14 Feb 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553559; cv=none; b=XUvO/8kMEPHCZl/7MqbKRfmOhY3HduQWA1aRdbpBh8dIYlJYfAr1c+lVMcrESiu/ScqwkhUBzn1d99f/HSfFR4dVGAIy+0gtNZEWofSBr7nogps20e7jQgp/uH3rA4ivYzMeYTVo3a435kMKVYq2BGuMKmQeywUntKKKPZLLvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553559; c=relaxed/simple;
	bh=/Vq4HRI2BN0XjmmO8kOb2O01hlISp/5ZPmuCinm7xyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=refzVZnRLeIrL8E52Y57UHT1ES7x+Sr7bGElF2opbpf0V1cg4LpddmlJTxoMUsY4vy9cSUV2ax9FsfZ1Y3rlHoQDU4f6CZ9aVFGVLH5jdQGITLq4Diz3nuPmDRG0LQ6VsHzMUm0VSn9dnn2b3kqbywPa9Z2rdbO4xeHBhSF+GFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IUGXUY/i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553554;
	bh=/Vq4HRI2BN0XjmmO8kOb2O01hlISp/5ZPmuCinm7xyQ=;
	h=From:Subject:Date:To:Cc:From;
	b=IUGXUY/ikc92B5KBNi1Q/E/BPJeorXdvdXpf9z4MeLr8tHubO3s6O1iySo15XcYST
	 6B226mq0N8mUcJH3admq/6+MBMlT7HUgPMxa/51nMmJbRP1pXX/VTjlGz95cMO/JwO
	 vc+dIWIB9bz3wf2E5o7JNYWZxGIB7pvDEYVWOwoZaJIICHdHBvcq9KrkL2BrND1+Y7
	 odvR+2y6YZ4HymROR5zvlB4de0l3ZnCTgPcP+9upl45Do7khw20IBeggDCkaxPsfn/
	 RMwtzwVK/LOJ1p2dpzIxIUM0mZqA9bZL8HQ6W8SoDtdedZwgiMF6iUGElE++mnBLar
	 jNYjW/FkrF8eg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDEEA17E0239;
	Fri, 14 Feb 2025 18:19:09 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 00/13] Get mt6359-accdet ready for usage in Devicetree
Date: Fri, 14 Feb 2025 14:18:31 -0300
Message-Id: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOd6r2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MT3dwSM2NTS93E5OSU1BLdlJJiXQODJEMLSwsT8zTjZCWgvoKi1LT
 MCrCZ0bG1tQBQBtbGYwAAAA==
X-Change-ID: 20250214-mt6359-accdet-dts-00b189847f3c
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

This series prepares the MT6359 ACCDET for actual usage in the
Devicetree. Patches 1 and 2 add the required DT bindings, patches 3 and
4 get the mt6359-accdet driver probing, patches 5-12 clean up code
related to DT property parsing, and patch 13 adds the node in the
Devicetree.

Together with the series "Allow retrieving accessory detection reference
on MT8188" [1], and one extra patch on top enabling it on the
genio-700-evk DT, this series was tested on the Genio 700 EVK to get
audio jack detection working on it.

[1] https://lore.kernel.org/all/20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Andrew Perepech (3):
      mfd: mt6397-core: Add mfd_cell for mt6359-accdet
      ASoC: mediatek: mt6359-accdet: Implement EINT IRQ polarity configuration
      ASoC: mediatek: mt6359-accdet: Use IRQ_TYPE_LEVEL_LOW not raw value

Nícolas F. R. A. Prado (10):
      ASoC: dt-bindings: Add document for mt6359-accdet
      dt-bindings: mfd: mediatek: mt6397: Add accdet subnode
      ASoC: mediatek: mt6359-accdet: Add compatible property
      ASoC: mediatek: mt6359-accdet: Drop dead code for EINT/GPIO IRQ handling
      ASoC: mediatek: mt6359-accdet: Drop dead code for EINT trigger setting
      ASoC: mediatek: mt6359-accdet: Drop dead code for button detection
      ASoC: mediatek: mt6359-accdet: Drop dead code for plugout-debounce
      ASoC: mediatek: mt6359-accdet: Handle mediatek,eint-use-ext-res as bool
      ASoC: mediatek: mt6359-accdet: Split mediatek,pwm-deb-setting properties
      arm64: dts: mt6359: Add accessory detect node

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |   7 +
 .../bindings/sound/mediatek,mt6359-accdet.yaml     | 293 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |  24 ++
 drivers/mfd/mt6397-core.c                          |  12 +
 sound/soc/codecs/mt6359-accdet.c                   | 208 +++++----------
 sound/soc/codecs/mt6359-accdet.h                   |  18 +-
 6 files changed, 404 insertions(+), 158 deletions(-)
---
base-commit: dab2734f8e9ecba609d66d1dd087a392a7774c04
change-id: 20250214-mt6359-accdet-dts-00b189847f3c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


