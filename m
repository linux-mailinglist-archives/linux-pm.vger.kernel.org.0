Return-Path: <linux-pm+bounces-29284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66632AE3F40
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CD4188D558
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69324DCE7;
	Mon, 23 Jun 2025 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xe3RELpV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5F24C076;
	Mon, 23 Jun 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680121; cv=none; b=PMuCZSwVGkxBdUodLsdtao5RpPg++x6rBLe2CDeHfYsmI+ItI0bojHjCIp2R5ZFH+3puBjMcU4aOewcglkP6YRywglAHe2qfoy0k8070zmYHbjwPYW5NOdu4jFILQ9LMkZPA1kSMCCkCkypbkl36oArII7DR7h/JCtZwf07phD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680121; c=relaxed/simple;
	bh=wbzxEmlkD6sQGb+eCEBPl+4QHXY1NuN+IhsaRuBybEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0ktoC0+zkTgPX6+Oi06Vu4kCu5h213TMJFPHtnnEcGSpTqCKMhQgnBSry8KziRJfddGvuSj61e/ozt2Gd53qOOi/EfKOXgFwDhlpXOimM5vt8DvZY8DCy2+Ki93rXYYfRPpW9J12PTT4CyWJPlLO5dVv6Y2YN95nwoTWql5ihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xe3RELpV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680118;
	bh=wbzxEmlkD6sQGb+eCEBPl+4QHXY1NuN+IhsaRuBybEI=;
	h=From:To:Cc:Subject:Date:From;
	b=Xe3RELpVUNlDSYsIUyzFidPSOMlT+VH770H4t/x2PsYrjf5xruTQPrt3Sv2iO23FB
	 WvgT2+dZSmzvdp04jTZC/vWu98PG/soRdyMiLP89uIFwVmBu2U2ErHSNab+Kr8UBsK
	 3nrgs2xtcmtVM5/LlPdKP9v55gJTE8k/zsvcvlhQkvjeo/TSJ0PGTcknfY72j+mfZp
	 IiOii/MEB7jJwe8FVkkZMiexKtqWCsjQajNtPKyDyQT4scBrV7vX6Hpn8LJerOYp+m
	 IhFgKZXr/KwcMtDb0HpPyF0cIbdAxmI2S/2X8hfJ5e4G7l9uAMTupt/ZBi1YVC50A1
	 R16nxkn0EHYRg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3171B17E0202;
	Mon, 23 Jun 2025 14:01:57 +0200 (CEST)
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
Subject: [PATCH v1 00/13] pmdomain: Partial refactor, add MT8196 support
Date: Mon, 23 Jun 2025 14:01:41 +0200
Message-ID: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 - Hardware Voter (MT8196/MT6991), allowing ATF, remote processors and
   the AP (Linux) to manage the same power domains through a voter MCU,
   avoiding power racing
 - Directly controlled power domains for MT8196
 - Voted power domains for MT8196
 - Multimedia (voted) power domains for MT8196.

Note that all of the power domains for MT8196 should also work on MT6991
but since I have no Dimensity 9400 boards, even though I'm 99.5% sure that
it will simply work as those are the same, I avoided to add compatibles
for 6991 as it's impossible for me to test.

AngeloGioacchino Del Regno (13):
  dt-bindings: power: mediatek: Document mediatek,bus-protection
  pmdomain: mediatek: Refactor bus protection regmaps retrieval
  pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
  pmdomain: mediatek: Move ctl sequences out of power_on/off functions
  pmdomain: mediatek: Add support for modem power sequences
  pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
  pmdomain: mediatek: Add support for Hardware Voter power domains
  pmdomain: mediatek: Add support for secure HWCCF infra power on
  pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
  arm64: dts: mediatek: Convert all SoCs to use mediatek,bus-protection
  dt-bindings: power: Add support for MT8196 power controllers
  pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
  pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains

 .../power/mediatek,power-controller.yaml      |  44 ++
 arch/arm64/boot/dts/mediatek/mt6795.dtsi      |   4 +-
 arch/arm64/boot/dts/mediatek/mt6893.dtsi      |  11 +-
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |   5 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   3 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  15 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  11 +-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  22 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  12 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  21 +-
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  14 +-
 drivers/pmdomain/mediatek/mt6795-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8167-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8173-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8183-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8186-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |   6 +
 drivers/pmdomain/mediatek/mt8192-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8195-pm-domains.h |   5 +
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 625 ++++++++++++++++
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |  14 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 694 +++++++++++++++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    | 123 +++-
 .../dt-bindings/power/mediatek,mt8196-power.h |  58 ++
 24 files changed, 1500 insertions(+), 217 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8196-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h

-- 
2.49.0


