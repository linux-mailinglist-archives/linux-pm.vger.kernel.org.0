Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE83D358235
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhDHLmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhDHLmj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1294661139;
        Thu,  8 Apr 2021 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882148;
        bh=qYlGZW2SMBY0Bez1jSD2bTQlAc/FCgWwYoTOfL0UmvY=;
        h=From:To:Subject:Date:From;
        b=G3771ASouv4ufWB1sCmFZQpnQYI5xB6YqtorUbsOqFsYYeK3DcQ6ajM+7N83dS0uM
         J2CYt7JzboiWW6KiA71PxbFua4msGSmvMBbyPeX9vUXHnjL3/X4Cu6sZKtrLUqTg3n
         5BDioFb4K7ewBrb+moX7ssCntd2VCW1ViRQy2dPOaxBXeFhapzNiQsHVZIp4ox4cO9
         AWVitViw0dEGWfjMa1lr6VYUZ/t+GZ8YJIFnttKLrFHJcHBSYuTrJ+HipsdgtcAKbl
         LfBo47oTfSfZic99uspve6pZOr1Zw5aUQ2gPG2nmgiTKNgekz9fCpzZ/HBbZ4Y8r1Z
         8biONp4dUFj5A==
Received: by pali.im (Postfix)
        id 95C71EBC; Thu,  8 Apr 2021 13:42:25 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
Date:   Thu,  8 Apr 2021 13:42:14 +0200
Message-Id: <20210408114223.8471-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pali Rohár <pali.rohar@gmail.com>

Hello!

The armada-37xx-cpufreq driver changes base CPU speed from 1000 MHz to
800 MHz on EspressoBIN and Turris MOX. The commit message in patch 2/10
explains why and how can this be discovered.

That patch 2/10 led us to discover another bug, in the SOC itself,
that causes the CPU to behave weirdly when frequency changes to 1 GHz.
A similar erratum is documented by Marvell but only for systems where
base frequency is 1.2 GHz.

We've discovered that to make cpufreq scaling stable on Armada 3720
systems with base frequency 1 GHz, we also have to set voltage levels
for L0 and L1 loads to at least 1108 mV. We were led to this by patch we
found in Marvell kernel fork. Fix is in the patch 4/10.

https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/dc33b62c90696afb6adc7dbcc4ebbd48bedec269

During fixing this voltage issue for 1 GHz we discovered another bug in
armada-37xx-cpufreq driver that causes CPU instability. Erratum for VDD
stabilization was improperly implemented, details are in patch 6/10.

We have tested this patch series on Espressobin v5 and Turris MOX
boards. If you have other Armada 3720 boards (Espressobin v5/v7, uDPU,
Devel Board, ...) then it will be nice to do an additional tests and
check if instability issues are finally fixed.

There is a discussion on armbian forum that Espressobin v7 is unstable
when running at 1 GHz and in this thread was also mentioned above
voltage patch from Marvell kernel fork:

https://forum.armbian.com/topic/10429-how-to-make-espressobin-v7-stable/

The only change in this third version is modified patch 04/10 with fixes
for 1.2 GHz variant of Espressobin. Minimal CPU voltage in L1 load for
1.2 GHz variant was increased to 1.155V.

Patch 01/10 was already applied by Gregory into his DT tree, so it is
not RESEND to linux-pm.

Marek & Pali

Marek Behún (3):
  arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
  cpufreq: armada-37xx: Fix setting TBG parent for load levels
  clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
    clock

Pali Rohár (7):
  cpufreq: armada-37xx: Fix the AVS value for load L1
  clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
    1 GHz
  clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
    to L0
  cpufreq: armada-37xx: Fix driver cleanup when registration failed
  cpufreq: armada-37xx: Fix determining base CPU frequency
  cpufreq: armada-37xx: Remove cur_frequency variable
  cpufreq: armada-37xx: Fix module unloading

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
 drivers/clk/mvebu/armada-37xx-periph.c       |  83 +++++++-------
 drivers/cpufreq/armada-37xx-cpufreq.c        | 111 +++++++++++++++----
 3 files changed, 135 insertions(+), 62 deletions(-)

-- 
2.20.1

