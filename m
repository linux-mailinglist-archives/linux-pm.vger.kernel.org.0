Return-Path: <linux-pm+bounces-23381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BDA4E352
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8666117CB81
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014227EC85;
	Tue,  4 Mar 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KY6FOERq"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D427E1C1;
	Tue,  4 Mar 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101371; cv=none; b=prqTFnuPgrBhugz5u66IXjuU+1+igetUSUJgAuhLOKBMOpUqNHeI6/R409H+w5ndm2wuBV3Hch1Mnee0A9ao+OG2J4yyzppbotFOEikYQfHkhg3fLLLmInwpROqPWNNBwTwSvdX9mECIruKZjlIzo3bEKPmdPfK8rmh4wdLaKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101371; c=relaxed/simple;
	bh=kRk65fFWGiW9cLrHn6Gq8JEnZaLlDaonyfy1q1fzf8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B7FVpPNoLOPFQwIQz3Vvwb50K1V9uhQB3BLdLrUPCx6Xwxfdp7+vARBNmFLZtlKuVhy7aTa3kASvni/8GYjooYBmrS8zHhMJAB8SQpIBjofPg2TTGoNWPEbbFBzN6/mj7sEYDjbuqLYtLSUhTqNL1o6FgrK4yJGyLJg4ZSeegNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KY6FOERq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101367;
	bh=kRk65fFWGiW9cLrHn6Gq8JEnZaLlDaonyfy1q1fzf8Q=;
	h=From:Subject:Date:To:Cc:From;
	b=KY6FOERqCblcMtcMsG1Jo68iIUJRZhzGfDNIRsw0BTcMNCXmDNb2m1j3zcEo4RvAA
	 4S7+Gwr6uePEDLlKtbtdj/RVOurABGmkx9fwp3yXQqjDouTPSh11yiZivu9fY1jVlN
	 FnGhPGOiS0LxG0DEH79LUJnsEIlfcb/c45tdRMvwYHg6KA9tKUAEV3FnTVZwLQOsZd
	 97PWLOlLF2mntA+8Pqg9e9+2oi0YZYWvHs9xJVB9D31sYKrBrnM5tF91uDTC7lkJZq
	 Ds3fnE8Yd/GyCNhqnmSeN/CrCLGhAf38zLQcbPMcP9PotWGAcSku55fkzh4p2+U7lO
	 O9k4rMmTYv0aA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5615517E065E;
	Tue,  4 Mar 2025 16:16:02 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 00/20] Get mt6359-accdet ready for usage in Devicetree
Date: Tue, 04 Mar 2025 12:15:41 -0300
Message-Id: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB0Zx2cC/33NSwrCMBSF4a2UjI3k2bSO3Ic4yOPWBlojSQhK6
 d5NOxFEHP4H7ncXlCB6SOjULChC8cmHew1+aJAd9f0G2LvaiBEmCaMCz7nlssfaWgcZu5wwIYZ
 2fSfUwC2qd48Ig3/u5uVae/Qph/jaXxS6rf+0QjHBrVKaSmp6I+zZhmnSJkR9tGFGm1jYR+GE/
 VJYVaRxLecAxAn1razr+gZ2a2Fy/AAAAA==
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
Devicetree. Patches 1 and 2 add the required DT bindings, patches 3 and
4 get the mt6359-accdet driver probing, patches 5-18 clean up code
related to DT property parsing, patch 19 adds the node in the
Devicetree and patch 20 enables the kconfig for the driver.

Together with the series "Allow retrieving accessory detection reference
on MT8188" [1], and one extra patch on top enabling it on the
genio-700-evk DT, this series was tested on the Genio 700 EVK to get
audio jack detection working on it.

[1] https://lore.kernel.org/all/20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
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

Nícolas F. R. A. Prado (18):
      ASoC: dt-bindings: Add document for mt6359-accdet
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

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |   6 +
 .../bindings/sound/mediatek,mt6359-accdet.yaml     |  42 ++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/mt6397-core.c                          |  12 +
 sound/soc/codecs/mt6359-accdet.c                   | 599 +++++----------------
 sound/soc/codecs/mt6359-accdet.h                   |  55 +-
 7 files changed, 195 insertions(+), 524 deletions(-)
---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250214-mt6359-accdet-dts-00b189847f3c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


