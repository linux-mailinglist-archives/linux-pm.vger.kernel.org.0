Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835D27CFE1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfGaVM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:12:57 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17129 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaVLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203eb0000>; Wed, 31 Jul 2019 14:11:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 31 Jul 2019 14:11:06 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203e90002>; Wed, 31 Jul 2019 14:11:05 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v7 00/20] SC7 entry and exit support for Tegra210
Date:   Wed, 31 Jul 2019 14:10:43 -0700
Message-ID: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607467; bh=Paohd/0GlwDFo6d1zfjma7o1lYrzLZvAjiGOjwr/xbo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Qpqk2JwnYnhBhs+kUrVQOYjO8yu58Jd70ohO51KcuNLBs57hp4WKAFq0epnhphNSf
         IToJyrtwl5LbNcgaaB36hAvnUzyApRCGVOEURZlo0BYLVNnY5SYEaPMNkfdKrw3Zmr
         BvPJ+AGS4AX2MU5d/GRdZ5VD7DJix5FzV0NNXv8BJv5aRN6HFij0MfURpLL7lZN+LE
         3ESCI3zQsEfvale1xxMOxVmIVrzdndextoJzTlzFcIzBR2/MC6yg8fhx++WR0CtBlm
         EILvHcdz2Sy6rrvgSP2ipBzCQEnuKi8dHHrQ4BaiWOTtXyOnlx+yzxhZ4x+5ybHLqz
         kTFyMf/u9PzAw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series includes Tegra210 deepsleep (SC7) support with RTC alarm
wake event.

This series also includes save and restore of PLLs, clocks, OSC contexts
for deepsleep exit to normal operation.

This patch series doesn't support 100% suspend/resume to allow fully
functional state upon resume and we are working on some more drivers suspend
and resume implementations.

[V7]: Changes between V6 & V7 are
	- V6 feedback fixes
	- Removed patch-0001 from V6 which keeps COP IRQ enabled. Looking
	  more into ATF FW, it loads SC7 entry FW into IRAM and sets the
	  COP reset vector to SC7 FW load address and resets COP. So, COP
	  IRQ can be cleared during suspend.

	Note:
	  Below patch is also needed for SC7 support as GPIO restore need
	  to happen prior to pinctrl.
	  https://patchwork.kernel.org/patch/11012077/

[V6]: Changes between V5 & V6 are
	- V5 feedback fixes
	- DFLL suspend and resume moved to DFLL clock driver
	- Add suspend and resume support for CPUFreq driver to explicitly
	  switch source to safe source of PLLP and disable DFLL clock.
	- Fix to super clock driver to enable PLLP branch to CPU before
	  source switch to PLLP.
	- Added save and restore support for super clock driver.

[V5]: Changes between V4 & V5 are
	- V4 feedback fixes

[V4]: Changes between V3 & V4 are
	- V3 feedback fixes
	- Removed park bits clear for EMMC pads in pinctrl-tegra driver
	  function tegra_pinctrl_clear_parked_bits as based on V3 feedback
	  parked_bit is updated to parked_bitmask to use with DRV_PINGROUP
	  as well and thierry posted patch series for this.
	- Implemented all peripheral clocks save and restore through their
	  corresponding clk_ops save_context and restore_context and removed
	  all direct registers store and restore in clk-tegra210 driver.
	- Created separate patch for fence_delay update during PLLU init based
	  on V3 feedback.
	- Added more comments in tegra210_clk_resume regarding dfll restore
	  sequence and its dependency on peripheral clocks restore.

[V3]: Changes between V2 & V3 are
	- V2 feedback fixes
	- GPIO restore should happen prior to Pinctrl restore to prevent
	  glitch on GPIO lines. So using resume_noirq for gpio tegra to allow
	  gpio resume prior to pinctrl resume.
	- Implemented save_context and restore_context callbacks for clock
	  plls, pll outs and dividers in corresponding drivers.
	  Note: Peripheral clocks and clock enable and reset need to be in
	  Tegra210 clock suspend/resume as they need to be in proper sequence
	  w.r.t DFLL resume for restoring CPU clock.
	- Removed gpio-tegra changes for hierarchical support to have PMC as
	  parent to GPIOs for GPIO wake event support. Thierry is working on
	  gpiolib for some cleanup before adding hierarchical support. So
	  holding on to GPIO wake support for now.

[V2] : V1 feedback fixes
	Patch 0002: This version still using syscore. Thierry suggest not to
	use syscore and waiting on suggestion from Linux Walleij for any better
	way of storing current state of pins before suspend entry and restoring
	them on resume at very early stage. So left this the same way as V1 and
	will address once I get more feedback on this.
	Also need to findout and implement proper way of forcing resume order
	between pinctrl and gpio driver.

[V1]:	Tegra210 SC7 entry and exit thru RTC wake and Power button GPIO wake
	using hierarchical IRQ with PMC as parent to GPIO.



Sowjanya Komatineni (20):
  pinctrl: tegra: Add suspend and resume support
  pinctrl: tegra210: Add Tegra210 pinctrl pm ops
  clk: tegra: divider: Save and restore divider rate
  clk: tegra: pllout: Save and restore pllout context
  clk: tegra: pll: Save and restore pll context
  clk: tegra: Support for OSC context save and restore
  clk: tegra: clk-periph: Add save and restore support
  clk: tegra: clk-super: Fix to enable PLLP branches to CPU
  clk: tegra: clk-super: Add save and restore support
  clk: tegra: clk-dfll: Add suspend and resume support
  cpufreq: tegra124: Add suspend and resume support
  clk: tegra210: Use fence_udelay during PLLU init
  clk: tegra210: Add suspend and resume support
  soc/tegra: pmc: Allow to support more tegras wake
  soc/tegra: pmc: Add pmc wake support for tegra210
  arm64: tegra: Enable wake from deep sleep on RTC alarm
  soc/tegra: pmc: Configure core power request polarity
  soc/tegra: pmc: Configure deep sleep control settings
  arm64: dts: tegra210-p2180: Jetson TX1 SC7 timings
  arm64: dts: tegra210-p3450: Jetson Nano SC7 timings

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   7 ++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   7 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   5 +-
 drivers/clk/tegra/clk-dfll.c                       |  56 +++++++++
 drivers/clk/tegra/clk-dfll.h                       |   2 +
 drivers/clk/tegra/clk-divider.c                    |  11 ++
 drivers/clk/tegra/clk-periph-fixed.c               |  33 ++++++
 drivers/clk/tegra/clk-periph-gate.c                |  34 ++++++
 drivers/clk/tegra/clk-periph.c                     |  37 ++++++
 drivers/clk/tegra/clk-pll-out.c                    |  26 +++++
 drivers/clk/tegra/clk-pll.c                        | 112 +++++++++++++-----
 drivers/clk/tegra/clk-sdmmc-mux.c                  |  28 +++++
 drivers/clk/tegra/clk-super.c                      |  53 +++++++++
 drivers/clk/tegra/clk-tegra-fixed.c                |  15 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c           |   2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |   1 +
 drivers/clk/tegra/clk-tegra210.c                   |  86 ++++++++++++--
 drivers/clk/tegra/clk.c                            |  14 +++
 drivers/clk/tegra/clk.h                            |  26 +++++
 drivers/cpufreq/tegra124-cpufreq.c                 |  60 ++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.c              |  59 ++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   3 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |   1 +
 drivers/soc/tegra/pmc.c                            | 129 ++++++++++++++++++++-
 24 files changed, 759 insertions(+), 48 deletions(-)

-- 
2.7.4

