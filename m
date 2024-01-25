Return-Path: <linux-pm+bounces-2749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB883C6EB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D3329561B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F674E29;
	Thu, 25 Jan 2024 15:35:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893597316C
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196904; cv=none; b=ua0R7mYsZDFWqQ+yJiswAUPF4o8FE07fmR/3OSH/uIex5iptSn4eOFR7JpvRKUPLlB9iWndVSTI/Tde2J3jywfUqJs31HpcNKf5+JV9DXy/BRujMTOge6mr/Qs5Yz1eV5XczCwMuwajnjZUNNRAXy8lPv3FPPQoAk4G1Cu8qZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196904; c=relaxed/simple;
	bh=v15vasOy5jTU6RKaAc6l/DxvJnBWxYnDy11GfBA+2Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H7rhXAZ9BHTl/Zn6CUkkh7VM3Gk3Da3ziMR4Ozs/7TVj+Bfokjg8fcqSQ5iwptURNW31LZs6QKp6eQcTH5Xbtb6ysK7H3PjA4RwebIfLxxpw2KRXtWxi5DIriGKEP8uSrXLkb67BXK/zSargUksxHXEFMr27SN4XVYXIXDSoAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by andre.telenet-ops.be with bizsmtp
	id f3am2B00558agq2013amKN; Thu, 25 Jan 2024 16:34:56 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jn-00GUvT-Tx;
	Thu, 25 Jan 2024 16:34:45 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kb-00Fs2H-Qu;
	Thu, 25 Jan 2024 16:34:45 +0100
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
Subject: [PATCH v2 00/15] arm64: renesas: Add R-Car V4M and Gray Hawk Single support
Date: Thu, 25 Jan 2024 16:34:28 +0100
Message-Id: <cover.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds initial support for the Renesas R-Car V4M
(R8A779G0) SoC and the Renesas Gray Hawk Single development board.

As both driver code and DTS have hard dependencies on DT binding
definitions, most patches in this series are supposed to go in through
the renesas-devel and/or renesas-clk trees, using a shared branch for DT
binding definitions, as usual.  For the PM domain patches (03, 04, 09),
Ulf already offered to apply these to his pmdomain tree, and provide an
immutable "dt" branch, to be pulled in my renesas-devel tree.

Changes compared to v1[1]:
  - Add Acked-by, Reviewed-by,
  - Add vendor-prefix to DT binding definition header file names and
    update include guards,
  - Add "board" to compatible comment,
  - Add missing CP core clock,
  - Add SoC name to top-level comment.

For testing, this series can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/v4m-gray-hawk-single-v2

Thanks for your comments!

[1] "[PATCH 00/15] arm64: renesas: Add R-Car V4M and Gray Hawk Single
    support"
    https://lore.kernel.org/linux-renesas-soc/cover.1704726960.git.geert+renesas@glider.be

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
 drivers/clk/renesas/r8a779h0-cpg-mssr.c       | 241 ++++++++++++++++++
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
 .../clock/renesas,r8a779h0-cpg-mssr.h         |  96 +++++++
 .../dt-bindings/power/renesas,r8a779h0-sysc.h |  49 ++++
 24 files changed, 679 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0.dtsi
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c
 create mode 100644 drivers/pmdomain/renesas/r8a779h0-sysc.c
 create mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

