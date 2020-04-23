Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318F51B6636
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDWVlK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 17:41:10 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:25427 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgDWVlJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 17:41:09 -0400
X-IronPort-AV: E=Sophos;i="5.73,309,1583161200"; 
   d="scan'208";a="45339771"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2020 06:41:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id ABF4F400C420;
        Fri, 24 Apr 2020 06:41:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/10] Add RZ/G1H support.
Date:   Thu, 23 Apr 2020 22:40:40 +0100
Message-Id: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series aims to add support for Renesas RZ/G1H (r8a7742) SoC.

RZ/G1H SoC is similar to R-Car Gen2 H2 SoC.

This patch set is based on renesas-drivers/master-v5.7-rc1.

Lad Prabhakar (10):
  dt-bindings: power: rcar-sysc: Document r8a7742 SYSC binding
  dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
  soc: renesas: rcar-sysc: add R8A7742 support
  dt-bindings: reset: rcar-rst: Document r8a7742 reset module
  soc: renesas: rcar-rst: Add support for RZ/G1H
  dt-bindings: clock: renesas: cpg-mssr: Document r8a7742 binding
  clk: renesas: Add r8a7742 CPG Core Clock Definitions
  clk: renesas: cpg-mssr: Add R8A7742 support
  ARM: shmobile: r8a7742: Basic SoC support
  cpufreq: dt: Add support for r8a7742

 .../bindings/clock/renesas,cpg-mssr.yaml           |   1 +
 .../bindings/power/renesas,rcar-sysc.yaml          |   1 +
 .../devicetree/bindings/reset/renesas,rst.yaml     |   1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   2 +
 drivers/clk/renesas/Kconfig                        |   5 +
 drivers/clk/renesas/Makefile                       |   1 +
 drivers/clk/renesas/r8a7742-cpg-mssr.c             | 289 +++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c             |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/soc/renesas/Kconfig                        |   4 +
 drivers/soc/renesas/Makefile                       |   1 +
 drivers/soc/renesas/r8a7742-sysc.c                 |  42 +++
 drivers/soc/renesas/rcar-rst.c                     |   1 +
 drivers/soc/renesas/rcar-sysc.c                    |   3 +
 drivers/soc/renesas/rcar-sysc.h                    |   1 +
 include/dt-bindings/clock/r8a7742-cpg-mssr.h       |  42 +++
 include/dt-bindings/power/r8a7742-sysc.h           |  29 +++
 18 files changed, 431 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a7742-cpg-mssr.c
 create mode 100644 drivers/soc/renesas/r8a7742-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a7742-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a7742-sysc.h

-- 
2.7.4

