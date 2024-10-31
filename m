Return-Path: <linux-pm+bounces-16798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E409B74E4
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A862865A0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156441474AF;
	Thu, 31 Oct 2024 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="C95dSwTB"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CEB14830F;
	Thu, 31 Oct 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358210; cv=none; b=b6sYzfrg4l6rr54siWim/v+bAm54bQEtLMaT6/5WDey5PZ90+w/R3F4XLul1IotBdriByVJGIFQpXrvpzPzNua6HHyX0ExtGcYelgsoutWIIjsAvlQiyw9o+re/p5rQAKiC44fC820XKZI7gkoUcegpIMCtRgf/njez88r/bO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358210; c=relaxed/simple;
	bh=8BCyeg5IzkuYMXudvFriGegtayHWd0iTD7AKHmg9Xqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpRKPG/3LGo3KJrHUpFdHbqwylMxDPMbzRUe2wr9PcpIcJpAAaqOnAaSq5YmeM1RvjsPHmCFiHGyknyIq+egG/qQNiQ8ASdhqfTe6kuT3Ul0Tw+7GELwNN0k6ocHTnZryF/7uKBr56PjomhZdGeEizSKKehhvrSTizprXCQtwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=C95dSwTB; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358201;
	bh=8BCyeg5IzkuYMXudvFriGegtayHWd0iTD7AKHmg9Xqs=;
	h=From:To:Cc:Subject:Date:From;
	b=C95dSwTBaCseH3f5sJn3+wOaaokpEUVDX9BuzGLPjcJJt/7UjcMv+2g3uB/R//bjg
	 Z4zS0OYvHol4CJkT/fYjO1YhPu+ht2CxehmbQV4hmAsit6iv50inWTzHbn3YlZgSnb
	 ZNw5pUr3ALY40xqMzu8pOnh52KuNAAsqvYJnp4wKT9uWew4GmWkUgx++C6xldbp/Z4
	 2OkSx//jd3yF0cDySi1h38cWVyRZLr8myTA4yq+gX2xiyJs+VafVWWbj8XeKh/j0aq
	 WgmcdX4ci7bG7E1qcHB+M1DSI3s4lLJkc/ASJUKdcMvOQeVpc2GWfFc5ieqeqGGRsp
	 G5hiNgw48kPpA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 00/13] sunxi: A100/A133 second stage support
Date: Thu, 31 Oct 2024 04:02:13 -0300
Message-ID: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again!

This is V2 of this series [5], with some changes that were requested and
others that were made after testing on more devices. Thank you for all of
your feedback! A changelog is available below.

==================
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
followed by patches 3-7, which implement support for the USB host and OTG
peripherals. Patches 8-10 add MMC nodes, rounding out what originally
made up the first patch series; support for these already exists from
earlier patches, though patch 7 fixes an issue with the clock definitions
preventing the MMC controller from initializing. Patches 11-13 finish the
job of the second original series and this series, implementing OPP and
enabling DVFS on these SoCs.

This series is also available on GitHub [3].

A sincere thanks to Andre for encouraging me to submit these patches,
Parthiban for testing this tree on his board, and to the linux-sunxi
community and its resources for pointing me to these abandoned series in
the first place [4].

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=380887&archive=both&state=*
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=396055&archive=both&state=*
[3] https://github.com/BrokenR3C0RD/linux-a100/compare/c2ee9f59..allwinner-a100
[4] https://linux-sunxi.org/Linux_mainlining_effort#Work_In_Progress
[5] https://lore.kernel.org/all/20241024170540.2721307-1-masterr3c0rd@epochal.quest/

Changelog - V2:
 - Change name of opp table to match bindings and pass CHECK_DTBS
 - Drop "phy: sun4i-usb: add support for A100 USB PHY" in favor of
   falling back to "allwinner,sun20i-d1-usb-phy".
 - Add "allwinner,sun50i-a100" to the cpufreq-dt-platform blacklist
 - Update dt-bindings changes to keep intended ordering of compatibles
 - Update regs that were too small in the usbphy bindings
 - Add patch to remove CLK_SET_RATE_NO_REPARENT from the MMC drivers.
 - Fix error in the description of "arm64: dts: allwinner: a100: add usb
   related nodes"
 - Add acks and reviews from Andre and Rob


Cody Eksal (5):
  dt-bindings: phy: sun50i-a64: add a100 compatible
  dt-bindings: usb: Add A100 compatible string
  dt-bindings: usb: sunxi-musb: Add A100 compatible string
  clk: sunxi-ng: a100: enable MMC clock reparenting
  dt-bindings: opp: h6: Add A100 operating points

Shuosheng Huang (2):
  cpufreq: sun50i: add a100 cpufreq support
  arm64: dts: allwinner: a100: Add CPU Operating Performance Points
    table

Yangtao Li (6):
  arm64: dts: allwinner: A100: Add PMU mode
  arm64: dts: allwinner: a100: add watchdog node
  arm64: dts: allwinner: a100: add usb related nodes
  arm64: allwinner: A100: enable EHCI, OHCI and USB PHY nodes in Perf1
  arm64: allwinner: a100: Add MMC related nodes
  arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node

 .../allwinner,sun50i-h6-operating-points.yaml |   1 +
 .../phy/allwinner,sun50i-a64-usb-phy.yaml     |  10 +-
 .../usb/allwinner,sun4i-a10-musb.yaml         |   1 +
 .../devicetree/bindings/usb/generic-ehci.yaml |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   1 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts |  60 ++++++
 .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    |  90 ++++++++
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 193 +++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c        |   6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        |  28 +++
 11 files changed, 383 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi


base-commit: 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907
-- 
2.47.0


