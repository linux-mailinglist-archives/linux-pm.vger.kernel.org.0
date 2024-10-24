Return-Path: <linux-pm+bounces-16415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED09AEDAE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27C728573E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E31FE0F6;
	Thu, 24 Oct 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="XV3L7CAW"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47C1FB3C2;
	Thu, 24 Oct 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790356; cv=none; b=J7Y4q7DSXLCnQsmP3Z3O93WmeX91kaQfrf+lbCmcP7Ue5+lVLUMlfuhRr7WDkBUeetBwFFkRzitzFTJYmVUtev7YveGauWpFunaoG1fI+thguCJ5x//h1Gtmzh0Mk/iPEawfgzspLc91LTMl3xWYIQbv4xWjvuwHyk0NwLvCK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790356; c=relaxed/simple;
	bh=s7xzMFvJ4Cag5AvnrOIpgkj1EGCgsWQbCxPj4HldfhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM12+j4rgDcfqe9zgi7y0ZQ3GnEfQCTfuI8LqY4Y+j1P1BgS5ZP6DzOKBn2LxBYaby/uA3JCIFGRpdoJsbUVqQsu6kKUYpCsjV+M1YOHcge96tSM/dnbrOWmf9PMxyupD9A2oGLhFlRtqvFjqdkg/As5TRFEMLrzPXgtVDaUWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=XV3L7CAW; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789781;
	bh=s7xzMFvJ4Cag5AvnrOIpgkj1EGCgsWQbCxPj4HldfhU=;
	h=From:To:Cc:Subject:Date:From;
	b=XV3L7CAWsqfMo1+ztn5WJZFeVtrIN2TalAaxLuOyWtU0K6CierjqNvMA7qIxXIygT
	 /3edWKT7iFdUrQQeitM9eKoXXPz/1+YTBxLPnE6AGmGSbguryxK+m0ao7t0RhgVlwh
	 djaT0WBOlfhLbDGAah2KRenKKJG7MWaW+MpcVAnNOYI2XKCGNV6CbxajODgBEAG4Xs
	 g4fxBfMffN8VuFIi84Bj0lRJswbnM1rjyhSluGgSpPmzeflhMOTqDQ7CYKEAj0KpYz
	 QInLLVqWJP39DHxkarJgZmFkAZRuO0LAtXUr5gOQyGBVstgjUdtd27JnkYOmSXCRSM
	 vbs5ewMt05EeQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 00/13] sunxi: A100/A133 second stage support
Date: Thu, 24 Oct 2024 14:05:18 -0300
Message-ID: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello! This is my first submission, so please be gentle :)

Back in 2020, two Allwinner employees, Yangtao Li and Shuosheng Huang, each
submitted a patch series for the A100 series of SoCs; [1] intended to add
support for the watchdog, ARM PMU, DMA, USB, and (e)MMC controller, and [2]
implemented DVFS support. Some patches from the first series landed, but
the rest were seemingly abandoned.

Although references to the A100 have been removed by Allwinner, it is
believed that the A133 and A133 Plus, which are still available, are simply
better binned variants of the A100; no other differences have been noted
thus far, and the drivers for the A100 work on the A133 without any
additional modifications. There has been a resurgence of interest in the
A133; patches to allow mainline U-Boot to run on these devices are
currently in progress.

I have rebased the patches that failed to land, applying the feedback
provided by maintainers at the time. Some DT binding patches were added, as
there were a few cases where compatibles were used without being
documented. Minor reworks were necessary to apply certain patches, as the
drivers they modified have matured over time.

Patches 1 and 2 add PMU and watchdog nodes to the device tree. This is
followed by patches 3-8, which implement support for the USB host and OTG
peripherals. Patches 9 and 10 add MMC nodes, rounding out what originally
made up the first patch series; support for these already exists from
earlier patches. Patches 11-13 finish the job of the second original
series and this series, implementing OPP and enabling DVFS on these SoCs.

This series is also available on GitHub [3].

A sincere thanks to Andre for encouraging me to submit these patches,
Parthiban for testing this tree on his board, and to the linux-sunxi
community and its resources for pointing me to these abandoned series in
the first place [4].

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=380887&archive=both&state=*
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=396055&archive=both&state=*
[3] https://github.com/BrokenR3C0RD/linux-a100/compare/c2ee9f59..allwinner-a100
[4] https://linux-sunxi.org/Linux_mainlining_effort#Work_In_Progress

Cody Eksal (4):
  dt-bindings: phy: sun50i-a64: add a100 compatible
  dt-bindings: usb: Add A100 compatible string
  dt-bindings: usb: sunxi-musb: Add A100 compatible string
  dt-bindings: opp: h6: Add A100 operating points

Shuosheng Huang (2):
  cpufreq: sun50i: add a100 cpufreq support
  arm64: dts: allwinner: a100: Add CPU Operating Performance Points
    table

Yangtao Li (7):
  arm64: dts: allwinner: A100: Add PMU mode
  arm64: dts: allwinner: a100: add watchdog node
  phy: sun4i-usb: add support for A100 USB PHY
  arm64: dts: allwinner: a100: add usb related nodes
  arm64: allwinner: A100: enable EHCI, OHCI and USB PHY nodes in Perf1
  arm64: allwinner: a100: Add MMC related nodes
  arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node

 .../allwinner,sun50i-h6-operating-points.yaml |   1 +
 .../phy/allwinner,sun50i-a64-usb-phy.yaml     |   1 +
 .../usb/allwinner,sun4i-a10-musb.yaml         |   1 +
 .../devicetree/bindings/usb/generic-ehci.yaml |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   1 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  59 ++++++
 .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    |  90 ++++++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 193 +++++++++++++++++-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        |  28 +++
 drivers/phy/allwinner/phy-sun4i-usb.c         |  11 +
 10 files changed, 383 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi


base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
-- 
2.47.0


