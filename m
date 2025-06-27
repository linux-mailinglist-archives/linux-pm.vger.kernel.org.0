Return-Path: <linux-pm+bounces-29676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D2AEBBC1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2125D189C18A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666EC2E9EA7;
	Fri, 27 Jun 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb027EaM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04B2E92CC;
	Fri, 27 Jun 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038170; cv=none; b=cbULK5xDS4HuuQoyqF98C39sNe6u/ZcH1NMYmXsUnLNqcjWZH/5PgePQRUDDPzqe8LVOvIR2rd94qsq7KwfHihXxWxHLqJejPTBHfj9g63Y4FSaejD18y9DrBq8p8kiilaFYmQXIrkUwNJZqPMww97/q1kq9eaUOL0iOfqTuh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038170; c=relaxed/simple;
	bh=DLL0uv9BKZAXYGcaADgHmi1/DoHhNnMIhXQxNX93FQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SLo+dsrtZAwu6xenJlNpxT8eKimtQpizmQIMmCiXs2pxS6kDYaPWVkqkcux3jTxikNyBgdY8x2yDQVBBzqXPYxZ1xnXEzDmId0WaBwuamLJ6yzTnOJohfxrjjRTwrKSoW39x5w1OMUSHndOh8cEyxmhL9xx/WaLDeKuOS0bk8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb027EaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA54CC4CEF2;
	Fri, 27 Jun 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751038169;
	bh=DLL0uv9BKZAXYGcaADgHmi1/DoHhNnMIhXQxNX93FQA=;
	h=From:To:Cc:Subject:Date:From;
	b=Bb027EaMRl72rIynik9ymtl6EoP6L6kbRgcXJT+28jIGaEwIsNgJXJm4DUDAV8p4b
	 tpsORQqbFZo+D0XmZLvvEnCjcHnMaqLTzgVEjRhETSixFoxgTjoxqwIm+2y7Dh0x8M
	 X5KLiwXZ1JDLrZ4+3ZRWmJViy8LLkcgUWyef+em4VHJXDsAxOTFrHqVA3Qz5z/1lAp
	 D8sd0rnlkmPjF7VNOVJAxCWypAnpvv21Va8epte42g5j8YrptOG3lYnTKEQsjNmfkx
	 SLpU52zKPd4iciVvE0+LS8Dq6a3IFvY/LVkW0Vc/ciiIhXsWf5Amf3P4/O94rqtF0x
	 cqe7WJRcLp1MA==
Received: by wens.tw (Postfix, from userid 1000)
	id 172185FD85; Fri, 27 Jun 2025 23:29:27 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] allwinner: a523: Add power controllers
Date: Fri, 27 Jun 2025 23:29:14 +0800
Message-Id: <20250627152918.2606728-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

This series adds the power controllers found in the Allwinner A523
family of SoCs. There are two power controllers. One is the same type
as those found in the D1 SoC, just with a different number of valid
power domains. The second is (I assume) a unit based on ARM's PCK-600
power controller. Some of the registers and values match up, but there
are extra registers for delay controls in the PCK-600's reserved
register range.

Patch 1 adds new compatible string entries for both of these
controllers.

Patch 2 adds support for the A523 PPU to the existing D1 PPU driver.

Patch 3 adds a new driver of the PCK-600 unit in the A523 SoC.

Patch 4 adds device nodes for both of these controllers.


Please have a look. The power controllers are critical for enabling more
peripherals, such as display output, camera input, video codecs, the NPU,
and a second DWMAC-compatible ethernet interface.


Thanks
ChenYu


Chen-Yu Tsai (4):
  dt-bindings: power: Add A523 PPU and PCK600 power controllers
  pmdomain: sunxi: sun20i-ppu: add A523 support
  pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power
    controller
  arm64: dts: allwinner: a523: Add power controller device nodes

 .../power/allwinner,sun20i-d1-ppu.yaml        |   2 +
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  18 ++
 drivers/pmdomain/sunxi/Kconfig                |   8 +
 drivers/pmdomain/sunxi/Makefile               |   1 +
 drivers/pmdomain/sunxi/sun20i-ppu.c           |  17 ++
 drivers/pmdomain/sunxi/sun55i-pck600.c        | 225 ++++++++++++++++++
 .../power/allwinner,sun55i-a523-pck600.h      |  15 ++
 .../power/allwinner,sun55i-a523-ppu.h         |  12 +
 8 files changed, 298 insertions(+)
 create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h

-- 
2.39.5


