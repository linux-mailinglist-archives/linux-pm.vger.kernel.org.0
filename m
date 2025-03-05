Return-Path: <linux-pm+bounces-23499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157EA50A96
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064B9188D664
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C96253F0D;
	Wed,  5 Mar 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MHW65aF5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B7253B7C;
	Wed,  5 Mar 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201164; cv=none; b=rccEhOOTk2w46D7HcLoeZ92AP9OqzjKEdmJw5zQ7XLjn31OH6OBVlAENFIR2YpQx9JNtDz8BuJgfly4xbgqeUxk03GLATyv+mK0OmguZSlNcvSvAw9TcJBj1Ro2a3xJWUnRy1JYifXr2dQh9PXRWZMKdZWnp3wEp/AaUX3fU3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201164; c=relaxed/simple;
	bh=u/GQhP1xEopgzVBLmurB5SYuCMPtvKHmpfxo57+s2TE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zz+wVgQBa8aLbh7Ai5SI9o0Tqn96l+xqr/5x8aiRFkh1o3PdAuwM+H5TU+RUaljR/RJZcEGpSSOnq9oL4DpxK7fDicWWAQCJ4FkjW9ZaytEdEs3T1mitG8ccTlfZIkynzRhMALMfXr8FogL4tSix7+sYWFyxlffpplMXxtPqtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MHW65aF5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201160;
	bh=u/GQhP1xEopgzVBLmurB5SYuCMPtvKHmpfxo57+s2TE=;
	h=From:Subject:Date:To:Cc:From;
	b=MHW65aF5zt1j/P/JBQGhK4Ht+n1SPqCp9rnl7HVPK/MxufyDMnTGiFq+KJU5To5iu
	 qjqaWvq5FMB2H4Gf2zY1a1Dj9sbP6up5u5ABBQap/J6xIVvaqHp6a5fm1e6dUlRAW4
	 XD8uj8A1tPbMEZ9m2HwoRLr3Zga6yX6KmCt96gjg+Gbk5t9yVcxBEq170XEyFJWYDM
	 qMlqFYxdiINU+ie2Dq6WE1/DzYrAimdTNsALBJFAJ9yXZG3HLif69TPKsAVpP+TtRg
	 yNEMX5JoFuu4mB+FDfZwjN1Ssfs34DmXKRdaRdL67cCeeeuUIo9rncuCiYScq/P2wF
	 2ExQ+Tk/zupXQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFC6717E0599;
	Wed,  5 Mar 2025 19:59:14 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v4 00/19] Get mt6359-accdet ready for usage in Devicetree
Date: Wed, 05 Mar 2025 15:58:15 -0300
Message-Id: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMeeyGcC/33OSwrCMBCA4auUrI3k2TSuvIe4yGNqA62RpBSl9
 O6m3ShSXP4D883MKEMKkNGpmlGCKeQQ7yXEoUKuM/cb4OBLI0aYJIwKPIw1lxob5zyM2I8ZE2J
 poxuhWu5Q2XskaMNzMy/X0l3IY0yv7cRE1+k/baKY4FopQyW12gp3drHvjY3JHF0c0CpO7KNww
 vYUVhRpfc05APFC7Sn8W9n9hW8KAdM6pltpf5VlWd73WOlzQgEAAA==
X-Change-ID: 20250214-mt6359-accdet-dts-00b189847f3c
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

This series prepares the MT6359 ACCDET for actual usage in the
Devicetree. Patch 1 adds the required DT bindings, patches 2 and 3 get
the mt6359-accdet driver probing, patches 4-17 clean up code related to
DT property parsing, patch 18 adds the node in the Devicetree and patch
19 enables the kconfig for the driver.

Together with the series "Allow retrieving accessory detection reference
on MT8188" [1], and one extra patch on top enabling it on the
genio-700-evk DT, this series was tested on the Genio 700 EVK to get
audio jack detection working on it.

[1] https://lore.kernel.org/all/20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v4:
- Moved DT-binding for accdet from standalone file
  (sound/mediatek,mt6359-accdet.yaml) to parent mfd's file
  (mfd/mediatek,mt6397.yaml), squashing patches 1 and 2.
- Link to v3: https://lore.kernel.org/r/20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com

Changes in v3:
- Removed unneeded '|' in mt6359-accdet's dt-binding description
- Removed unneeded unevaluatedProperties for accdet node in mt6397's
  dt-binding
- Clarified HP_EINT pin is on the MT6359 PMIC in mediatek,hp-eint-high's
  description in the mt6359-accdet dt-binding
- Link to v2: https://lore.kernel.org/r/20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com

Changes in v2:
- Removed all DT-binding properties except for EINT polarity one
  (mediatek,eint-level-pol / mediatek,hp-eint-high)
  - Added patches 12-18 to make those settings internal to driver
- Renamed mediatek,eint-level-pol to mediatek,hp-eint-high and made it
  bool
- Added patch 20 to enable the MT6359 ACCDET Kconfig in the defconfig
- Removed unused btn_type variable as part of "Drop dead code for button
  detection" patch.
- Link to v1: https://lore.kernel.org/r/20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com

---
Andrew Perepech (2):
      mfd: mt6397-core: Add mfd_cell for mt6359-accdet
      ASoC: mediatek: mt6359-accdet: Implement HP_EINT polarity configuration

Nícolas F. R. A. Prado (17):
      dt-bindings: mfd: mediatek: mt6397: Add accdet subnode
      ASoC: mediatek: mt6359-accdet: Add compatible property
      ASoC: mediatek: mt6359-accdet: Handle hp-eint-high property
      ASoC: mediatek: mt6359-accdet: Drop dead code for EINT/GPIO IRQ handling
      ASoC: mediatek: mt6359-accdet: Drop dead code for EINT trigger setting
      ASoC: mediatek: mt6359-accdet: Drop dead code for button detection
      ASoC: mediatek: mt6359-accdet: Drop dead code for plugout-debounce
      ASoC: mediatek: mt6359-accdet: Drop unused moisture variables
      ASoC: mediatek: mt6359-accdet: Always use internal resistor
      ASoC: mediatek: mt6359-accdet: Make PWM debounce settings internal
      ASoC: mediatek: mt6359-accdet: Always use eint detect mode 4
      ASoC: mediatek: mt6359-accdet: Always set micbias1 to 2.8V
      ASoC: mediatek: mt6359-accdet: Always configure hardware as mic-mode 2
      ASoC: mediatek: mt6359-accdet: Always set comp-vth to 1.6V
      ASoC: mediatek: mt6359-accdet: Always use EINT0 IRQ
      arm64: dts: mt6359: Add accessory detect node
      arm64: defconfig: Enable MT6359 ACCDET

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |  51 ++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/mt6397-core.c                          |  12 +
 sound/soc/codecs/mt6359-accdet.c                   | 599 +++++----------------
 sound/soc/codecs/mt6359-accdet.h                   |  55 +-
 6 files changed, 198 insertions(+), 524 deletions(-)
---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250214-mt6359-accdet-dts-00b189847f3c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


