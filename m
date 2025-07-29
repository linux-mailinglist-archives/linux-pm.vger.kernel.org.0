Return-Path: <linux-pm+bounces-31552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFACB14CE4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD107A918F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725928C865;
	Tue, 29 Jul 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOPyrZ+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CF28B3F3
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787870; cv=none; b=Tp2gZQU/bhI6OHwH270CshyaLL8mBGDz2/fYf9FraAcibwaT/U+Rl4OB9viyDCYY75B3zHPjQ/jtOREwr0tcilA5fF8HC087zxYtdBy1p5XAKNpKRmibbuYJC20axhjcqc95RDTSebqhfzrzB0IrgLR6iF1aGn7VX5t2NUP6xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787870; c=relaxed/simple;
	bh=wEVZhpgt1uNcasnqEQ15dSnD0eh7wUda2VTINBIA7/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+TRuhmtyEKxrC0yW38Cr36QI9BfelRUQZFEty5DjUtJBYPE+YEWH6UQTVlaWqqsbcqsXUhbvBLv5Cgm+eicxLkaGbcR/ji5OcLh0NqblKILIi63N7PLeCKxEfgpzSL/KFaQSJF9i5GjYDPs+jbeyH25wBWr0LPGwCHOo6gqSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOPyrZ+4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55a4befb8ccso5741166e87.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753787866; x=1754392666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNqyxgyK0nsgvQIxHIvNEn3WYoXCL9lVWy5TTd0G+sE=;
        b=kOPyrZ+4WxhqPscq3pVAzPk2B3g8dQQsE6lOOTWt7PW1FGtp5FdHbx3PLEv+NalMLb
         YdPlRAm8j32xPDJeX45zZdjPV2dIpup7iDiVAoyhzDGSV+eRI2svcHmnqUaUc0EHnVMC
         v1Q+QXdr4INmLiZH3nv1A8bKVp0WEpYjm4ESwx+jnfHPIiC37LH6qela3khFvPzgtums
         C4Lt6i2RAQBrO/Lg7ySVZgXeeu5OycIvKllEYvCjyJJp9M2RUD4/jBc1682E3axBBlJm
         CGu+rpGFDbl8k9udzRFfuW1Dl9/jgVw7mS9gzZyGsq8NcXD86+T1eUVYLwPN5EITbuIm
         CO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787866; x=1754392666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNqyxgyK0nsgvQIxHIvNEn3WYoXCL9lVWy5TTd0G+sE=;
        b=CdrFMX+oCtt75PdNt/bM7wnXEDD3t4YNth7SYFctqVGj3wvH2uQdxzqt+G003Zz4co
         80aoBmPLdsBHwBJT0JNsyCt813MGf57Xb0rWwefpleySjLIM7uxo6nyfJ6xNkok0Qwn8
         NkQ7sEM10wJF6zsCdRmykpZDBpy2VfbzWMcA6+gp+WkQOThUFnpomnBZh3yKNs1thbqV
         5Ja9jjXC0JRJjqFC8gHBTVUc+SHdAj5g4us2hB3/AoL2XTN9sY4k144aJa6E8QlrLA8u
         KUYEKJAPzoU3iKXXItcgC6ivgk0oEdXhpdiDNO/zIfFwr9EaflOLt056AoJszxYBVl5q
         1tng==
X-Forwarded-Encrypted: i=1; AJvYcCWw4Kt26g3UccV1vBdJT5eGqd8s4qqOjqTA1E3qi1Ej43/ysFwdqH78zjCydjR/36IMz5PYIuzyYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymMKxPliXZW9rpNnAkUIU00njZQqiaXrGg0JUutPrXCOdTq/zn
	+t7T3S8pVJhqSvJhgnLLUPUYPLSmrVDj3aIC7tt1RpXMWosmbCb0sTh6ti4cGWC83i21HQHzIUV
	8uJtm
X-Gm-Gg: ASbGncthmW2N14AaW7cR1mwN5jTsd8Fhm+2f8k9akpj8S54g7D88PS5U6EOfHXuaNJQ
	x+NciYxoNjr0JNsXMPZHv4f8veOSqbptm21ZBNJLNwq3krFKVt9Kn7XVz6eWoytrqchwwvXrpvk
	4JrKkCg+KAbqRUoWTo+PsJxtX7NW8bO00H9A2pm9TFL2Q3BDhhIA2roup2O//QyzKYJUhLFVhAe
	U1JPesqMG5CCxCFI+FROxg3J1ZqzHo+WSUbXzv4T7OmfqPuFQ+iAhAyBRJlVfyKwi3PFhJwuKDF
	sFLYMQ09ZfiOJHxwtEz3HACtns6DZsNa6xgImoRdQKOVc+diuonjC8WNRyTa/ElgdNw87aS1LLf
	QxvMdYT+sb3m7KjWlPxYNu0VG0mniQ7VWnsG4IADsUV4W8oa3Vs/334mXNb13dIteqti+be5h
X-Google-Smtp-Source: AGHT+IGssqGSc/l4qTALfsZmnWpz0MEgV6jXLRfV5IBNiy/NKNIKDaCf0ufZ7BJYRZwGjpYZkZDx3g==
X-Received: by 2002:a05:6512:23a2:b0:554:f76a:baba with SMTP id 2adb3069b0e04-55b5f3d5c73mr4808104e87.3.1753787865739;
        Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316db49sm1652507e87.3.2025.07.29.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci updates for v6.17
Date: Tue, 29 Jul 2025 13:17:33 +0200
Message-ID: <20250729111743.14723-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain and cpuidle-psci updates for v6.17.

FYI, this time we have made quite some changes in the pmdomain provider core
(aka genpd), which affects a couple of provider drivers that are sprinkled
across a few more subsystems than usual.

More details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 621a88dbfe9006c318a0cafbd12e677ccfe006e7:

  cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y (2025-07-14 13:09:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17

for you to fetch changes up to 05e35bd07d56780f0a5119973995b97a16843579:

  pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains (2025-07-23 12:12:16 +0200)

----------------------------------------------------------------
pmdomain core:
 - Leave powered-on genpds on until ->sync_state() or late_initcall_sync
 - Export a common ->sync_state() helper for genpd providers
 - Add generic ->sync_state() support
 - Add a bus/driver for genpd provider-devices
 - Introduce dev_pm_genpd_is_on() for consumers

pmdomain providers:
 - cpuidle-psci: Drop redundant ->sync_state() support
 - cpuidle-riscv-sbi: Drop redundant ->sync_state() support
 - imx: Set ISI panic write for imx8m-blk-ctrl
 - qcom: Add support for Glymur and Milos RPMh power-domains
 - qcom: Use of_genpd_sync_state() for power-domains
 - rockchip: Add support for the RK3528 variant
 - samsung: Fix splash-screen handover by enforcing a ->sync_state()
 - sunxi: Add support for Allwinner A523's PCK600 power-controller
 - tegra: Opt-out from genpd's common ->sync_state() support for pmc
 - thead: Instantiate a GPU power sequencer via the auxiliary bus
 - renesas: Move init to postcore_initcalls
 - xilinx: Move ->sync_state() support to firmware driver
 - xilinx: Use of_genpd_sync_state() for power-domains

pmdomain consumers:
 - remoteproc: imx_rproc: Fixup the detect/attach procedure for pre-booted cores

----------------------------------------------------------------
Chen-Yu Tsai (4):
      dt-bindings: power: Add A523 PPU and PCK600 power controllers
      pmdomain: sunxi: sun20i-ppu: add A523 support
      pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power controller
      pmdomain: sunxi: sun20i-ppu: change to tristate and enable for ARCH_SUNXI

Christophe JAILLET (1):
      pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_data

Guillaume La Roque (1):
      pmdomain: ti: Select PM_GENERIC_DOMAINS

Hiago De Franco (3):
      pmdomain: core: introduce dev_pm_genpd_is_on()
      remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
      remoteproc: imx_rproc: detect and attach to pre-booted remote cores

Jonas Karlman (3):
      dt-bindings: power: rockchip: Add support for RK3528
      dt-bindings: rockchip: pmu: Add compatible for RK3528
      pmdomain: rockchip: Add support for RK3528

Kamal Wadhwa (2):
      dt-bindings: power: rpmpd: Add Glymur power domains
      pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains

Krzysztof Hałasa (1):
      imx8m-blk-ctrl: set ISI panic write hurry level

Kuninori Morimoto (2):
      pmdomain: renesas: use menu for Renesas
      pmdomain: renesas: sort Renesas Kconfig configs

Luca Weiss (2):
      dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Milos power domains

Lukas Bulwahn (1):
      pmdomain: arm: scmi_pm_domain: remove code clutter

Michal Wilczynski (2):
      dt-bindings: firmware: thead,th1520: Add resets for GPU clkgen
      pmdomain: thead: Instantiate GPU power sequencer via auxiliary bus

Saravana Kannan (1):
      driver core: Add dev_set_drv_sync_state()

Sven Peter (1):
      pmdomain: apple: Drop default ARCH_APPLE in Kconfig

Ulf Hansson (31):
      pmdomain: core: Use of_fwnode_handle()
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: renesas: rcar-sysc: Add genpd OF provider at postcore_initcall
      pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
      pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
      pmdomain: core: Prevent registering devices before the bus
      pmdomain: core: Add a bus and a driver for genpd providers
      pmdomain: core: Add the genpd->dev to the genpd provider bus
      pmdomain: core: Export a common ->sync_state() helper for genpd providers
      pmdomain: core: Prepare to add the common ->sync_state() support
      soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
      cpuidle: psci: Opt-out from genpd's common ->sync_state() support
      cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
      pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
      pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
      firmware/pmdomain: xilinx: Move ->sync_state() support to firmware driver
      firmware: xilinx: Don't share zynqmp_pm_init_finalize()
      firmware: xilinx: Use of_genpd_sync_state()
      driver core: Export get_dev_from_fwnode()
      pmdomain: core: Add common ->sync_state() support for genpd providers
      pmdomain: core: Default to use of_genpd_sync_state() for genpd providers
      pmdomain: core: Leave powered-on genpds on until late_initcall_sync
      pmdomain: core: Leave powered-on genpds on until sync_state
      cpuidle: psci: Drop redundant sync_state support
      cpuidle: riscv-sbi: Drop redundant sync_state support
      pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next

 .../devicetree/bindings/arm/rockchip/pmu.yaml      |   2 +
 .../bindings/firmware/thead,th1520-aon.yaml        |   7 +
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |   4 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 .../bindings/power/rockchip,power-controller.yaml  |   1 +
 drivers/base/core.c                                |   8 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |  14 --
 drivers/cpuidle/cpuidle-riscv-sbi.c                |  14 --
 drivers/firmware/xilinx/zynqmp.c                   |  18 +-
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       |  12 +-
 drivers/pmdomain/apple/Kconfig                     |   1 -
 drivers/pmdomain/arm/scmi_pm_domain.c              |  12 +-
 drivers/pmdomain/core.c                            | 254 +++++++++++++++++++--
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |  10 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  47 ++++
 drivers/pmdomain/qcom/rpmpd.c                      |   2 +
 drivers/pmdomain/renesas/Kconfig                   | 124 +++++-----
 drivers/pmdomain/renesas/rcar-gen4-sysc.c          |   2 +-
 drivers/pmdomain/renesas/rcar-sysc.c               |  19 +-
 drivers/pmdomain/renesas/rmobile-sysc.c            |   3 +-
 drivers/pmdomain/rockchip/pm-domains.c             |  27 +++
 drivers/pmdomain/samsung/exynos-pm-domains.c       |   9 +
 drivers/pmdomain/sunxi/Kconfig                     |  19 +-
 drivers/pmdomain/sunxi/Makefile                    |   1 +
 drivers/pmdomain/sunxi/sun20i-ppu.c                |  17 ++
 drivers/pmdomain/sunxi/sun55i-pck600.c             | 234 +++++++++++++++++++
 drivers/pmdomain/thead/Kconfig                     |   1 +
 drivers/pmdomain/thead/th1520-pm-domains.c         |  51 +++++
 drivers/pmdomain/ti/Kconfig                        |   2 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c        |  16 --
 drivers/remoteproc/imx_rproc.c                     |  45 +++-
 drivers/soc/tegra/pmc.c                            |  26 ++-
 .../power/allwinner,sun55i-a523-pck-600.h          |  15 ++
 .../dt-bindings/power/allwinner,sun55i-a523-ppu.h  |  12 +
 include/dt-bindings/power/rockchip,rk3528-power.h  |  19 ++
 include/linux/device.h                             |  13 ++
 include/linux/firmware/xlnx-zynqmp.h               |   6 -
 include/linux/pm_domain.h                          |  23 ++
 38 files changed, 918 insertions(+), 174 deletions(-)
 create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
 create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h

