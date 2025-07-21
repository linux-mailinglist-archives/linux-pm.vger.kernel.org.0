Return-Path: <linux-pm+bounces-31139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E607EB0B9F7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EA3177E8F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75D1E261F;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzaT2j3g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFB15853B;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064240; cv=none; b=nnNF60hgnxgR57SrY3IogCYVMolSVqsPcOtDxLEFuS4h37/FrmcED6xvCYeki162mGLq5Ub209pTr8Mg7XEDh1QcWq8f+takLWJhX9nvne3VvgWLRFj9tWkktIZmNQIsYaKtpAWaTSsPKicAofXuQQ7hOxrdmp2P2LJ6WL9teKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064240; c=relaxed/simple;
	bh=D4slPNc6Z1U3EWga2c4poJ3saIhVXP1H0Ye4x3zfpK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XErzET7PKwc/wknGIVYgu9Gu7A12j0mrhlzvte+vd/MJpomXDYw7Z4SNynypW+pF6SSgphsfWLxrWnIlvi8NrVa41Cw4LwlnTwcClZSbcojrWZhhHWr+yZyGlbYEXtEiQPy7Hb/sukS+5FyrJMy+8/Dm6XgL5B5dQKVs+BoF374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzaT2j3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09823C4CEE7;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=D4slPNc6Z1U3EWga2c4poJ3saIhVXP1H0Ye4x3zfpK8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JzaT2j3gm84YqDFJmwfh9CKhE93Y0wn+3uW/Cj2nTjb6aavjPhgiD1BeUz0WDVZlG
	 BzYtpBfgctpKQlT8FydQhDTejAWf9DrGFGBmlUbk6Trs/7S1fyA9Mh/xH/4TG9qsqi
	 DnoH5xmYrNuviVIcc6vRg4WqMNxn2ALeKLDEEzGPFkkkWNQuEFQnFG1ult4S7QW2r6
	 jgTAWFvV19qGfYmCLcMVm736V0orUvBGph2M88wF1RYKK6Sk2n+CLD+3Ka4HFY1rne
	 lVs57oeFwciqAFXXFP2wfaf6D59Je4fBfN3Uz7zZEUlhwaN/QnNcIOgMe+OUvrksN8
	 to5b1O/HC0tyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7100C83F17;
	Mon, 21 Jul 2025 02:17:19 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 00/17] arm64: tegra: Add Tegra210B01 support
Date: Sun, 20 Jul 2025 21:14:54 -0500
Message-Id: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6ifWgC/z3MQQrCMBCF4auUWRuZxIZaV95DuojJpB2wjSQlK
 CV3N1Zw+T8e3waJIlOCS7NBpMyJw1JDHRqwk1lGEuxqg0KlUWMvViXxjlJYqVtr0J/7voX6fkb
 y/Nql21B74rSG+N7hLL/rz+hk+zeyFCjo5LXvHGln6TrOhh9HG2YYSikffXBOt54AAAA=
X-Change-ID: 20250509-t210b01-c154ca0f8994
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, Azkali Manad <a.ffcc7@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=4059;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=D4slPNc6Z1U3EWga2c4poJ3saIhVXP1H0Ye4x3zfpK8=;
 b=DAg8YVEDqTLQjcwuGcianfkqSUmfcS0Zt9XbFE7poCGvB5cdaqLa6Dwleey9xMIk7ZRthnWlE
 2UO3dC5JJOgAgmFuWAAj0r1loGajcqrqWgEqfgRZJtPbjmK7ltJP6Kw
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Also known as Tegra X1+, the Tegra210B01 has higher CPU and GPU clocks
than the original Tegra210.

This series adds Tegra210B01 support to several drivers, as a slight
extension to the existing Tegra210 support. Then adds a generic soc dtsi
in the same vein as other tegra archs. And finally adds a barebones
device dts to be used for dt checks. Further device support will be
submitted in later series.

Earlier internal revisions of this series included changes to the dfll
driver to support Tegra210B01, but those did not work in testing, thus
was dropped from the series. A bindings update to match is still in the
series so the soc dtsi can declare a separate compatible from Tegra210,
preventing the driver from attempting incorrect initialization on
Tegra210B01.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Fix patch 1 subject
- Add descriptive name in patch 8
- Fix copy-paste error in patch 13, discovered by kernel ci
- Link to v1: https://lore.kernel.org/r/20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com

---
Aaron Kling (16):
      dt-bindings: soc: tegra: pmc: Document Tegra210B01
      dt-bindings: phy: tegra-xusb: Document Tegra210B01
      dt-bindings: usb: tegra-xusb: Document Tegra210B01
      dt-bindings: usb: tegra-xudc: Document Tegra210B01
      dt-bindings: thermal: tegra: Document Tegra210B01
      dt-bindings: clock: tegra: Document Tegra210B01
      dt-bindings: clock: tegra124-dfll: Document Tegra210B01
      dt-bindings: tegra: Document Shield TV 2019
      phy: tegra: xusb: Add Tegra201B01 Support
      usb: xhci: tegra: Add Tegra210B01 support
      usb: gadget: tegra-xudc: Add Tegra210B01 Support
      thermal: tegra: Add Tegra210B01 Support
      clk: tegra: Add Tegra210B01 support
      arm64: tegra: Add BPMP node for Tegra210
      arm64: tegra: Add Tegra210B01 support
      arm64: tegra: Add support for NVIDIA Shield TV Pro 2019

Azkali Manad (1):
      soc/tegra: pmc: Add Tegra210B01 support

 Documentation/devicetree/bindings/arm/tegra.yaml   |    6 +
 .../bindings/clock/nvidia,tegra124-dfll.txt        |    1 +
 .../bindings/clock/nvidia,tegra20-car.yaml         |    1 +
 .../bindings/phy/nvidia,tegra210-xusb-padctl.yaml  |    4 +-
 .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml     |    5 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |    2 +
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |    2 +
 .../bindings/usb/nvidia,tegra210-xusb.yaml         |    4 +-
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   11 +
 .../boot/dts/nvidia/tegra210b01-p2894-0050-a08.dts |   10 +
 arch/arm64/boot/dts/nvidia/tegra210b01-p2894.dtsi  |   70 +
 arch/arm64/boot/dts/nvidia/tegra210b01.dtsi        |   64 +
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-tegra-periph.c               |    3 +
 drivers/clk/tegra/clk-tegra210b01.c                | 3758 ++++++++++++++++++++
 drivers/clk/tegra/clk-utils.c                      |    5 +-
 drivers/clk/tegra/clk.c                            |   19 +-
 drivers/clk/tegra/clk.h                            |    6 +
 drivers/phy/tegra/xusb-tegra210.c                  |   41 +
 drivers/phy/tegra/xusb.c                           |    4 +
 drivers/phy/tegra/xusb.h                           |    1 +
 drivers/soc/tegra/pmc.c                            |  117 +
 drivers/thermal/tegra/soctherm.c                   |    4 +
 drivers/thermal/tegra/soctherm.h                   |    1 +
 drivers/thermal/tegra/tegra210-soctherm.c          |   78 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   20 +
 drivers/usb/host/xhci-tegra.c                      |   25 +
 include/dt-bindings/clock/tegra210-car.h           |    5 +-
 29 files changed, 4262 insertions(+), 7 deletions(-)
---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20250509-t210b01-c154ca0f8994

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



