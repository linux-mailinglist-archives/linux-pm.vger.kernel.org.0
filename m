Return-Path: <linux-pm+bounces-23227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFECA4B32B
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA86B188FCAC
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6918D65E;
	Sun,  2 Mar 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HXgX21fR"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A9208A7;
	Sun,  2 Mar 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933068; cv=none; b=ZBdupR4HkfCriOsOViMcXx2BE/xVM3LtqGLq55btCrFwONS4gEGqV4mUQ/+lS/UkW7GuhOqbKQ/16XJW0rNc+jyAxBIlavafgT3HT7PIWKFQuZkZenoGlvUVZeaaJfZziyrRw89KL5Zo/vCXrzT0b2lQxzqjOMRx1p7D3lTnLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933068; c=relaxed/simple;
	bh=Te/+ghmA/RZrMtfC1LsnoUqBiFhdUI71MOZB0VoMZmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UcVb6PRfSxZzmzoS8OXjNaMkRDzoWNysUSm+qh+DIceYt5+6IHqk8pa2Zhc2BcA4Ufhtv11crECmrEboS1NOb/6xg8xkE/tCcMk76kMK+aFJIV6MFBGOxhgr5DkabFk6S9XU4yomfPutkoeutK9pUSxz7AItB9xAX3X/a306oUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HXgX21fR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933057;
	bh=Te/+ghmA/RZrMtfC1LsnoUqBiFhdUI71MOZB0VoMZmw=;
	h=From:Subject:Date:To:Cc:From;
	b=HXgX21fRjHhEcq3b8BHzM6FFUGjiTu9fBYysFL0Z6qFQVu8vtMQTx/vtSR4ukAQ8C
	 IK+HT77hYQTAlrY7wOvabnyxM2QKUZSbZtQBeyR3zXbprnRExQxu0yDbwoE+w0xArf
	 +vkEbxYDTEIWk/LtPbW1RamznK1t9wsjSmcjg6+FP6vGiLTIq+gwJO6KqZ+4vR2uz2
	 lrycjkHQldzeSIJTmOTuSQBIF/3TlWr2RkB6DsaHExCh+FDH3/A8quZbmPi8DF848h
	 fiDK6ir/eHRfFWy8kVaUI6dFI4ijrm7jWDCY7+21l6V0nMCl/fNHUnK+Yu7+0K+dWH
	 pR7ad5GiRbLmg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A2B4B17E07F8;
	Sun,  2 Mar 2025 17:30:52 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 00/20] Get mt6359-accdet ready for usage in Devicetree
Date: Sun, 02 Mar 2025 13:30:39 -0300
Message-Id: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK+HxGcC/32NSwrDIBRFtxLeuK+oMb+Ouo+Sgb6YRkhiUZGW4
 N5rs4AOz4F77gHBeGsC3KoDvEk2WLcXEJcKaFH706CdCoNgomGCS9xiWzcDKqLJRJxiQMY074d
 ednNNUHYvb2b7PpuPsfBiQ3T+c14k/rP/aokjw7brFG+4HrSkO7l1Vdp5dSW3wZhz/gIMsO1lt
 gAAAA==
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

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |   7 +
 .../bindings/sound/mediatek,mt6359-accdet.yaml     |  42 ++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/mt6397-core.c                          |  12 +
 sound/soc/codecs/mt6359-accdet.c                   | 599 +++++----------------
 sound/soc/codecs/mt6359-accdet.h                   |  55 +-
 7 files changed, 196 insertions(+), 524 deletions(-)
---
base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
change-id: 20250214-mt6359-accdet-dts-00b189847f3c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


