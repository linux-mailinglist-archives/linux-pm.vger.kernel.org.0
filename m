Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC992C5DCE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 23:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgKZWag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 17:30:36 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:24963 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732550AbgKZWag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 17:30:36 -0500
X-Halon-ID: fa841939-3036-11eb-a78a-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id fa841939-3036-11eb-a78a-0050569116f7;
        Thu, 26 Nov 2020 23:30:31 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/3] thermal: Add support for R-Car V3U (r8a779a0)
Date:   Thu, 26 Nov 2020 23:30:25 +0100
Message-Id: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series enables support for the R-Car V3U r8a779a0 thermal IP. It 
needs to touch both the device tree schema and driver as the IP is a tad 
different then its siblings in the Gen3 family.

  - It have 4 TSC cells instead of 2-3 that is used in other SoCs.

  - The interrupts are no longer wired to the INTC-AP so the driver 
    can't make use of them directly and are therefor made optional for 
    the V3U bindings. For this reason this series depends on [1].

The driver is tested together with it's dependency [1] and [2] on V3U 
and all 4 thermal sensors behaves as expected. The driver has also been 
tested on other R-Car Gen3 SoC for regressions, none where found.

The additional THCODE tuning parameters used in 3/3 are taken from the 
datasheet example and may need to be updated. In future the tuning 
parameters shall be read from fused registers on the IP directly and the 
hardcoded values in the driver only used as fallback for IP where the 
values are not fused.

1. [PATCH] thermal: rcar_gen3_thermal: Do not use interrupts for normal operation
2. [PATCH 0/2] clk: renesas: r8a779a0: Add clocks to support thermal

Niklas Söderlund (3):
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support
  arm64: dts: renesas: r8a779a0: Add thermal support
  thermal: rcar_gen3_thermal: Add r8a779a0 support

 .../bindings/thermal/rcar-gen3-thermal.yaml   | 17 ++++-
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi     | 70 +++++++++++++++++++
 drivers/thermal/rcar_gen3_thermal.c           |  7 +-
 3 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.29.2

