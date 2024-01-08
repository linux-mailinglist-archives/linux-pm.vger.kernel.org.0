Return-Path: <linux-pm+bounces-1954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAC827367
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFEDB22B80
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875852F91;
	Mon,  8 Jan 2024 15:34:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454B52F92
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4T7ylp2Trfz4x0b6
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 16:34:14 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d323:2fd4:4f64:e281])
	by laurent.telenet-ops.be with bizsmtp
	id YFZw2B00A0Qz0eJ01FZw4R; Mon, 08 Jan 2024 16:34:07 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrco-00EtLl-Vn;
	Mon, 08 Jan 2024 16:33:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrdU-00D7nm-4O;
	Mon, 08 Jan 2024 16:33:56 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/15] arm64: renesas: Add R-Car V4M and Gray Hawk Single support
Date: Mon,  8 Jan 2024 16:33:39 +0100
Message-Id: <cover.1704726960.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds initial support for the Renesas R-Car V4M
(R8A779G0) SoC and the Renesas Gray Hawk Single development board.

As both driver code and DTS have hard dependencies on DT binding
definitions, all patches in this series are supposed to go in through
the renesas-devel, renesas-clk, and/or renesas-pmdomain trees, using a
shared branch for DT binding definitions, as usual.

Note that this series does not include the DT binding update for the
HSCIF serial ports, as Greg does not like receiving new patches during
the merge window.

For testing, this series can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/v4m-gray-hawk-single-v1

Thanks for your comments (especially about the naming of the compatible
value and DTB for Gray Hawk Single :-)!

Cong Dang (1):
  clk: renesas: cpg-mssr: Add support for R-Car V4M

Duy Nguyen (6):
  dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
  dt-bindings: power: renesas,rcar-sysc: Document R-Car V4M support
  dt-bindings: power: Add r8a779h0 SYSC power domain definitions
  pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support
  soc: renesas: Identify R-Car V4M
  soc: renesas: rcar-rst: Add support for R-Car V4M

Geert Uytterhoeven (6):
  dt-bindings: clock: renesas,cpg-mssr: Document R-Car V4M support
  dt-bindings: reset: renesas,rst: Document R-Car V4M support
  dt-bindings: soc: renesas: Document R-Car V4M Gray Hawk Single
  clk: renesas: rcar-gen4: Add support for FRQCRC1
  soc: renesas: Introduce ARCH_RCAR_GEN4
  arm64: dts: renesas: Add Gray Hawk Single board support

Hai Pham (1):
  arm64: dts: renesas: Add Renesas R8A779H0 SoC support

Linh Phung (1):
  arm64: defconfig: Enable R8A779H0 SoC

 .../bindings/clock/renesas,cpg-mssr.yaml      |   1 +
 .../bindings/power/renesas,rcar-sysc.yaml     |   1 +
 .../bindings/reset/renesas,rst.yaml           |   1 +
 .../bindings/soc/renesas/renesas.yaml         |   6 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 .../dts/renesas/r8a779h0-gray-hawk-single.dts |  52 ++++
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     | 121 +++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r8a779h0-cpg-mssr.c       | 240 ++++++++++++++++++
 drivers/clk/renesas/rcar-gen4-cpg.c           |  10 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h        |   1 +
 drivers/pmdomain/renesas/Kconfig              |   4 +
 drivers/pmdomain/renesas/Makefile             |   1 +
 drivers/pmdomain/renesas/r8a779h0-sysc.c      |  55 ++++
 drivers/pmdomain/renesas/rcar-gen4-sysc.c     |   3 +
 drivers/pmdomain/renesas/rcar-gen4-sysc.h     |   1 +
 drivers/soc/renesas/Kconfig                   |  17 +-
 drivers/soc/renesas/rcar-rst.c                |   1 +
 drivers/soc/renesas/renesas-soc.c             |   8 +
 include/dt-bindings/clock/r8a779h0-cpg-mssr.h |  96 +++++++
 include/dt-bindings/power/r8a779h0-sysc.h     |  49 ++++
 24 files changed, 678 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0.dtsi
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c
 create mode 100644 drivers/pmdomain/renesas/r8a779h0-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a779h0-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a779h0-sysc.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

