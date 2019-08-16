Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7095F908D6
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfHPToO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:44:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13199 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfHPTmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d570721000c>; Fri, 16 Aug 2019 12:42:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:22 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:13 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:13 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:13 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707120000>; Fri, 16 Aug 2019 12:42:13 -0700
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
Subject: [PATCH v9 00/22] SC7 entry and exit support for Tegra210
Date:   Fri, 16 Aug 2019 12:41:45 -0700
Message-ID: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984545; bh=xxfaCpGQ/6tsM0ITlfRHpalVc1tuGs8NZQl1Z1tKhi0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=CxXIL7/R30oVW9kT7Ia6jai1ieAoDGA0AaGpVN80HDKTucDvJOoEvtz8tWWnydfcx
         +28YWj9QRORAAe4a0OMsnoBpAQ3LpzPF2tN6cmBWYCjWnOi1i0Q03lIcSTIFdfoaCP
         xO4PbK/mEzbFMVqXPSalU3mRwJe/D7LaAjJngGGkoRYPPkgX5eBnObVyIlhOTPTMg9
         2dIkWjptjjC2r5V/k3px8woX5vM5nf27ozO+G0c9jpqREr2mBFHqiCftJiznRiIOpy
         brpYXRytJBRVu7jjGSnqvurQuJqqIn3pSIm7B9wXVvCzRfrnVqL4muVVYGW8JR0CbK
         0VK5fZe2kiq3g==
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

[V9]: Changed betweenv8 & v9 are
	- v8 feedback fixes

	Note:
	  Below patch is also needed for SC7 support as GPIO restore need
	  to happen prior to pinctrl.
	  https://patchwork.kernel.org/patch/11012077/

[v8]: Changes between v7 & v8 are
	- v7 feedback fixes
	- moved clock enable/disable state and reset enable/disable state
	  restore from clk_save/restore_context back to clk-tegra210 driver
	  to do complete register value store/restore.
	- Removed manual store/restore of peripheral parent context and added
	  API in clk core to retrieve clock parent index to use during
	  restoring parent on resume.
	- Implemented Tegra recommended clock source programming sequence
	  during restore (CLK ENB ON followed by divider/source programming
	  followed by restoring CLK ENB ON/OFF state followed by restoring
	  RST state).
	- Removed pinctrl suspend/resume patch from this series as pinctrl
	  suspend/resume patch from v7 got acked and merged.
	- Added pinctrl patch-0001 to update pmx_writel for proper placement
	  of write barrier.
	- Added pinctrl patch-0002 to insert write barrier after all pinctrl
	  register writes during pinctrl resume.

	Note:
	  Below patch is also needed for SC7 support as GPIO restore need
	  to happen prior to pinctrl.
	  https://patchwork.kernel.org/patch/11012077/

[v7]: Changes between V6 & v7 are
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


Sowjanya Komatineni (22):
  pinctrl: tegra: Fix write barrier placement in pmx_writel
  pinctrl: tegra: Flush pinctrl writes during resume
  clk: tegra: divider: Save and restore divider rate
  clk: tegra: pllout: Save and restore pllout context
  clk: tegra: pll: Save and restore pll context
  clk: tegra: Support for OSC context save and restore
  clk: Add API to get index of the clock parent
  clk: tegra: periph: Add restore_context support
  clk: tegra: clk-super: Fix to enable PLLP branches to CPU
  clk: tegra: clk-super: Add restore-context support
  clk: tegra: clk-dfll: Add suspend and resume support
  cpufreq: tegra124: Add suspend and resume support
  clk: tegra210: Use fence_udelay during PLLU init
  clk: tegra: Share clk and rst register defines with Tegra clock driver
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
 drivers/clk/clk.c                                  |  17 +++
 drivers/clk/tegra/clk-dfll.c                       |  56 +++++++++
 drivers/clk/tegra/clk-dfll.h                       |   2 +
 drivers/clk/tegra/clk-divider.c                    |  11 ++
 drivers/clk/tegra/clk-periph.c                     |  18 +++
 drivers/clk/tegra/clk-pll-out.c                    |   9 ++
 drivers/clk/tegra/clk-pll.c                        |  86 +++++++++-----
 drivers/clk/tegra/clk-sdmmc-mux.c                  |  12 ++
 drivers/clk/tegra/clk-super.c                      |  35 ++++++
 drivers/clk/tegra/clk-tegra-fixed.c                |  15 +++
 drivers/clk/tegra/clk-tegra-super-gen4.c           |   7 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |   1 +
 drivers/clk/tegra/clk-tegra210.c                   | 104 +++++++++++++++--
 drivers/clk/tegra/clk.c                            | 112 +++++++++++-------
 drivers/clk/tegra/clk.h                            |  67 +++++++++++
 drivers/cpufreq/tegra124-cpufreq.c                 |  59 ++++++++++
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   8 +-
 drivers/soc/tegra/pmc.c                            | 130 ++++++++++++++++++++-
 include/linux/clk-provider.h                       |   1 +
 22 files changed, 677 insertions(+), 92 deletions(-)

-- 
2.7.4

