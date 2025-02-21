Return-Path: <linux-pm+bounces-22584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9FA3E987
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF957A4D36
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4B2AE99;
	Fri, 21 Feb 2025 01:00:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7752557C;
	Fri, 21 Feb 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099618; cv=none; b=tABeDojFFZSaVqpcHOnB4W1MQhvEeMK+aQWB1dYXbNIOxjlzXPDhTKZsHlPgvCtn+LKcKq+U7HWM3nxn+hHtX1q2yB2C76Z3kAvJ9Q6PZ8HUs9K+FGT0ir7B/sr3380hpncXPR1DoUVhw4zcWndqLU256SQh2PQ1d5EJSkSOHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099618; c=relaxed/simple;
	bh=tu+gpw7OD2GQyTiWhJLzR65PzZKxGrztR1wVsmwPETM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/va9wLfSrlZwsohV8mbjbr5Xa8ybnOwd7Hg9GbGVeeAOfbUNUuf1OAvElTE9KcONf1FOT2xYFdoKRzKqyhFnSdIVul8csQGKE1m5HFPDORwGj2KA8PR1KP0QtShrdGF0DkzAOU+7lbWa79wrD+Iiz8fka9IFDxHkkWCT0JTmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788BE1BA8;
	Thu, 20 Feb 2025 17:00:31 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15BA43F59E;
	Thu, 20 Feb 2025 17:00:10 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/5] arm64: sunxi: h616: Enable Mali GPU
Date: Fri, 21 Feb 2025 00:57:57 +0000
Message-ID: <20250221005802.11001-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616/H618/H313/H700 SoCs contain a Mali G32 MP2 GPU. This
IP is from the Bifrost family and is already supported by the panfrost
driver, so enabling support for 3D graphics on this SoC is rather
straight-forward.
However Allwinner added some bits in the PRCM block, that control the
power domain for the GPU - on top of its power *supply*.

This series enables the Mali GPU on those SoCs, by first introducing a
power domain driver for that SoC (patch 1/5: DT binding, patch 2/5:
the actual driver). For the Mali GPU to work we literally need to flip a
single bit (the BSP does this in the bootloader), and this full featured
power domain driver is admittedly a bit over the top for that purpose.
However it seems to be the right thing to do architecturally, and while
at it I added the other power domains (for analogue, PLLs, and the
management core), even though we won't use them in Linux and they would
be always on. I have a simpler version of the driver which just covers
this single bit controlling the GPU, please let me know if you prefer
that.
Please also note that this supersedes an RFC patch I sent a year ago,
which included this power domain in the R-CCU driver:
https://lore.kernel.org/linux-sunxi/20240225160616.15001-1-andre.przywara@arm.com/T/#u

The rest of the patches enable the Mali GPU on the DT side: patch 3/5
adds the compatible string to the Mali DT binding, while patch 4/5 adds
the purely SoC specific DT nodes, for both the power domain and the Mali
GPU. The final patch 5/5 then enables the GPU on all existing H616-family
boards.

There seems to be an existing problem with powering up the GPU, after it
has been turned off by the kernel. Chances are this is a problem with the
proper power-up (or power-down) sequence, where clock gates, reset lines
and the power domain must be asserted in a specific order.
A workaround used so far downstream is to keep the power domain enabled,
by ignoring the power-off request. Observing any assumed "proper" sequence
is a bit more tricky, since there is no Allwinner specific glue driver
or anything, so things would need be changed in the generic panfrost
code, where they have the potential of breaking other Mali users.
I would be interested in hearing opinions about this.

Cheers,
Andre

Andre Przywara (5):
  dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
  pmdomain: sunxi: add H6 PRCM PPU driver
  dt-bindings: gpu: mali-bifrost: Add Allwinner H616 compatible
  arm64: dts: allwinner: h616: Add Mali GPU node
  arm64: dts: allwinner: h616: enable Mali GPU for all boards

 .../bindings/gpu/arm,mali-bifrost.yaml        |   1 +
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
 .../sun50i-h618-yuzukihd-chameleon.dts        |   5 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |   5 +
 drivers/pmdomain/sunxi/Kconfig                |  10 +
 drivers/pmdomain/sunxi/Makefile               |   1 +
 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c   | 191 ++++++++++++++++++
 17 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
 create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c

-- 
2.46.3


