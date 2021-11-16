Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDCF453582
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 16:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhKPPUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 10:20:55 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:29293 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237778AbhKPPUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 10:20:54 -0500
X-IronPort-AV: E=Sophos;i="5.87,239,1631545200"; 
   d="scan'208";a="100471786"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Nov 2021 00:17:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.242])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6367C40062CC;
        Wed, 17 Nov 2021 00:17:53 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/5] Add Thermal support for RZ/G2L
Date:   Tue, 16 Nov 2021 15:17:45 +0000
Message-Id: <20211116151750.24857-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures
the temperature inside the LSI.
 
The thermal sensor in this unit measures temperatures in the range from
−40°C to 125°C with an accuracy of ±3°C. The TSU repeats measurement at
20-µs intervals, and automatically updates the results of measurement.

The TSU has no external pins as well as no interrupts.

This patch series aims to add TSU driver support for RZ/G2L SoC.

Biju Das (5):
  clk: renesas: r9a07g044: Add TSU clock and reset entries
  dt-bindings: thermal: Document Renesas RZ/G2L TSU
  thermal/drivers: Add TSU driver for RZ/G2L
  arm64: dts: renesas: r9a07g044: Add TSU node
  arm64: dts: renesas: r9a07g044: Create thermal zone to support IPA

 .../bindings/thermal/rzg2l-thermal.yaml       |  76 ++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 +++
 drivers/clk/renesas/r9a07g044-cpg.c           |   3 +
 drivers/thermal/Kconfig                       |   9 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/rzg2l_thermal.c               | 239 ++++++++++++++++++
 6 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
 create mode 100644 drivers/thermal/rzg2l_thermal.c

-- 
2.17.1

