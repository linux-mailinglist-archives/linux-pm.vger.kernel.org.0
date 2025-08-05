Return-Path: <linux-pm+bounces-31934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC202B1AF9C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549C93AD792
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B922259B;
	Tue,  5 Aug 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Odn44y4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAB189;
	Tue,  5 Aug 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380120; cv=none; b=PJ6iw65wdJQvQrzdXPYcEYSuEUH+ocLAZbHMvM8GfHcV73m9ZCkjcXh355O6ypsYt/d5wRNgk6qAbb7iYqUu4VPEVCfvncCdJk333ukUWclpXKBMnag7ULSVFerpiiiy2KFjVcwvGbOB45bS5/S2Iie8hdKl6+bVsB8yLHJfZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380120; c=relaxed/simple;
	bh=dfz9GEQtGUBOq+4N1TmCcfkFU6ARoozvcEdCqiVMSXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uC40YAjIZlCdqr04JIu7Vy1KA/6Ct/XxakstW9PMv4IVvLoaX0VcUMU0kwdF2Xsg+9mRYdUV+5K8Cj9CG6Dwj6YXvrr9u71N4Hk40eRkjKoOQRufbr2975JEIFmmwxOYOV3OhX1LK4opfkxDES7jM9rIhnjfNbrJ3xds5X8QLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Odn44y4u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380116;
	bh=dfz9GEQtGUBOq+4N1TmCcfkFU6ARoozvcEdCqiVMSXg=;
	h=From:To:Cc:Subject:Date:From;
	b=Odn44y4uCkUytDBo/oOSHQ7Idxe70sJ2w8swzbeUWboeYTHjT/CsidZXMOuT+Dz9x
	 0IJC8XC8Bpd0b6dmKLumrBFue826zqygwgJGH7itTCDFn8xkj0NMBRWHQ4DkwdgDN2
	 NOmPMQLG3v3Bjcisl1wcX2tG+iaXbzcUTS0Q2c5oF/AYdtTS7+UafYfCuPXRFwi3ha
	 aC/YeUbGdMf+JFc5+mJ21QF0bVJungC5MpQsWpPPbemOdacMQclz8vLGy+yx4Pd5SU
	 7X4Xh0j82ip32kfhOI7pIh+ISaqH7ku2XYYTKmjzyqUzBO3ue7vfIB2il1Sz/JLJS6
	 WZC6R43AR4kJw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5175D17E01F5;
	Tue,  5 Aug 2025 09:48:35 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 00/10] pmdomain: Partial refactor, support modem and RTFF
Date: Tue,  5 Aug 2025 09:47:36 +0200
Message-ID: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Dropped specified items for cells restriction as suggested by Rob
 - Fixed an issue in patch 4 still referencing "mediatek,bus-protection"
   as it is entirely replaced by "access-controllers"

Changes in v2:
 - Added #access-controller-cells allowance for MT8188/95 infracfg_ao

This series is a subset of [1], leaving out the Hardware Voter specific
bits for MT8196 until the discussion around it reaches a conclusion.

Even though the proposed code was born as a preparation to support the
MT8196/MT6991 SoCs power domain controllers, it is a necessary cleanup
for all power domain controllers of all of the currently supported SoCs
from MediaTek.

You may also notice the addition of support for modem power sequences:
this was brought up 6 months ago (or more) by community contributors
(mainly Yassine Oudjana) that were trying to upstream the MediaTek
MT6735 Smartphone SoC and needed support to provide power to the MD
subsystem - so, even though in this specific series the code for the
modem power sequence is not yet triggered by any SoC, please please
please, let it in.
Besides, "a bunch" of upstream supported SoCs do have the MD power
domain even though it wasn't added to their drivers (because if there
was no support in the driver, it would just crash the system); the
addition is something that I plan to do at some point, but definitely
not now as I have no bandwidth for that (bar MT8196, which will have
this domain).

Compared to v1 in [1]:
 - Changed mediatek,bus-protection to access-controllers
   as suggested by Rob (thanks!)
 - Added commits to document #access-controller-cells on all of
   the access control providers

In the meanwhile.... relevant excerpt from the old series:

This series refactors the bus protection regmaps retrieval to avoid
searching in all power domain devicetree subnodes for vendor properties
to get syscons for different busses, and adds a new property which is
located in the power controller root node containing handles to the same.

Retrocompatibility is retained and was tested on multiple SoCs in the
Collabora lab - specifically, on Genio 350/510/700/1200, and manually
on MT6795 Helio (Xperia M5 Smartphone), MT8186, MT8192 and MT8195
Chromebooks.

This was tested *three times*:
 - Before the per-SoC conversion in drivers/pmdomain/mediatek
 - With per-SoC conversion code but with *legacy* devicetree
 - With per-SoC conversion code and with *new* devicetree conversion

All of those tests were successful on all of the aforementioned SoCs.

This also adds support for:
 - Modem power domain for both old and new MediaTek SoCs, useful for
   bringing up the GSM/3G/4G/5G modem for both laptop and smartphone use
 - RTFF MCU HW, as found in MT8196 Chromebooks and MT6991 Dimensity 9400

...and prepares the pmdomain code to accomodate only the directly
controlled power domains for MT8196 (HW Voter support was left out).

[1] https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (10):
  dt-bindings: memory: mtk-smi: Document #access-controller-cells
  dt-bindings: clock: mediatek: Document #access-controller-cells
  dt-bindings: power: mediatek: Document access-controllers property
  pmdomain: mediatek: Refactor bus protection regmaps retrieval
  pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
  pmdomain: mediatek: Move ctl sequences out of power_on/off functions
  pmdomain: mediatek: Add support for modem power sequences
  pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
  pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
  arm64: dts: mediatek: Convert all SoCs to use access-controllers

 .../bindings/clock/mediatek,infracfg.yaml     |   3 +
 .../clock/mediatek,mt8186-sys-clock.yaml      |  15 +
 .../clock/mediatek,mt8188-sys-clock.yaml      |  15 +
 .../clock/mediatek,mt8192-sys-clock.yaml      |  15 +
 .../clock/mediatek,mt8195-sys-clock.yaml      |  15 +
 .../clock/mediatek,mt8365-sys-clock.yaml      |  15 +
 .../mediatek,smi-common.yaml                  |  16 +
 .../power/mediatek,power-controller.yaml      |  37 ++
 arch/arm64/boot/dts/mediatek/mt6795.dtsi      |   5 +-
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |   6 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  17 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  12 +-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  23 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  13 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  20 +-
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  16 +-
 drivers/pmdomain/mediatek/mt6795-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8167-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8173-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8183-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8186-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |   6 +
 drivers/pmdomain/mediatek/mt8192-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8195-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |  14 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 399 +++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  74 +++-
 28 files changed, 594 insertions(+), 181 deletions(-)

-- 
2.50.1


