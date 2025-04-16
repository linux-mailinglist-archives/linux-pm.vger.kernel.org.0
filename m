Return-Path: <linux-pm+bounces-25581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8813A90EE1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 00:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38BE16E924
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D1243374;
	Wed, 16 Apr 2025 22:49:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA26234966;
	Wed, 16 Apr 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843778; cv=none; b=o7vrgfy1dSjdjyN3+WEqkwxWQaFWGe32nco/A9uo0BMM/tyvU+t7VFtdvSesABYyDjL67dZXZIkIoeBSKn1wg4szLQPL53ZXxj/nnCfAIj6nIy2fX2mkCsE06D24d9KktheF9xSXnh4kf44ocApWvqwTHkh7jrRnoi/mwnkUcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843778; c=relaxed/simple;
	bh=oQjnlP2eUw7xkKA3jGOXsy0Wcf06SkIplXIkawEKh5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxEGTPZP2IFUkKhvHfq01lDGbQXDI7h/DusjQqCyE1RP0YnX9MD/6B/xYvjKfEy72kTBKxsvclfE/jd5PBKW+l/IAIbpDjvbbK1bznf/9IafCzgFSm/PlfNyPjxzGV9qQ/2T5TugS7+yDONkr5DM7bbrYKlQ8Rc4c2PU5ceq1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FCA1515;
	Wed, 16 Apr 2025 15:49:32 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A7F3F66E;
	Wed, 16 Apr 2025 15:49:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] arm64: sunxi: h616: Enable Mali GPU
Date: Wed, 16 Apr 2025 23:48:35 +0100
Message-ID: <20250416224839.9840-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

version 2 is addressing the comments I got from the reviewers (many
thanks for that!). The list of power domains is now separated from the
per-SoC data, to avoid going over the list twice. Also the error path
takes care of removing already registered genpd objects.
Based on v6.15-rc1, changelog below.

==========================
The Allwinner H616/H618/H313/H700 SoCs contain a Mali G32 MP2 GPU. This
IP is from the Bifrost family and is already supported by the panfrost
driver, so enabling support for 3D graphics on this SoC is rather
straight-forward.
However Allwinner added some bits in the PRCM block, that control the
power domain for the GPU - on top of its power *supply*.

This series enables the Mali GPU on those SoCs, by first introducing a
power domain driver for that SoC (patch 1/4: DT binding, patch 2/4:
the actual driver). For the Mali GPU to work we literally need to flip a
single bit (the BSP does this in the bootloader), and this full featured
power domain driver is admittedly a bit over the top for that purpose.
However it seems to be the right thing to do architecturally, and while
at it I added the other power domains (for analogue, PLLs, and the
management core), even though we won't use them in Linux and they would
be always on.

The rest of the patches enable the Mali GPU on the DT side: patch 3/4 adds
the purely SoC specific DT nodes, for both the power domain and the Mali
GPU. The final patch 4/4 then enables the GPU on all existing H616-family
boards.

For this to reliably work, the Panfrost driver needs a tweak to fix the
order of clock and reset bring-up and tear-down[1], but this is
technically independent from this series.

Cheers,
Andre

[1] https://lore.kernel.org/linux-sunxi/20250403055210.54486-1-simons.philippe@gmail.com/

Changelog v1 .. v2:
- rebase on v6.15-rc1
- drop already applied Allwinner Mali DT binding patch
- add review tags
- move list of power domains into separate structs, use ARRAY_SIZE()
- remove already registered genpds in error path
- print correct power domain name in error path

Andre Przywara (4):
  dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
  pmdomain: sunxi: add H6 PRCM PPU driver
  arm64: dts: allwinner: h616: Add Mali GPU node
  arm64: dts: allwinner: h616: enable Mali GPU for all boards

 .../power/allwinner,sun50i-h6-prcm-ppu.yaml   |  42 ++++
 .../dts/allwinner/sun50i-h313-tanix-tx1.dts   |   5 +
 .../sun50i-h616-bigtreetech-cb1.dtsi          |   5 +
 .../allwinner/sun50i-h616-orangepi-zero.dtsi  |   4 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |   4 +
 .../dts/allwinner/sun50i-h616-x96-mate.dts    |   5 +
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  21 ++
 .../sun50i-h618-longan-module-3h.dtsi         |   5 +
 .../allwinner/sun50i-h618-orangepi-zero2w.dts |   5 +
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |   4 +
 .../sun50i-h618-transpeed-8k618-t.dts         |   5 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |   5 +
 drivers/pmdomain/sunxi/Kconfig                |  10 +
 drivers/pmdomain/sunxi/Makefile               |   1 +
 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c   | 208 ++++++++++++++++++
 15 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
 create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c

-- 
2.46.3


