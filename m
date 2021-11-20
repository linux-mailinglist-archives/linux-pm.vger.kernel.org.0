Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFA458023
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhKTTuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 14:50:23 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:29902 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229488AbhKTTuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 14:50:22 -0500
X-IronPort-AV: E=Sophos;i="5.87,251,1631545200"; 
   d="scan'208";a="101265032"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2021 04:47:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CA3EB40E1DB4;
        Sun, 21 Nov 2021 04:47:14 +0900 (JST)
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
Subject: [PATCH v2 0/2] Add Thermal support for RZ/G2L
Date:   Sat, 20 Nov 2021 19:47:09 +0000
Message-Id: <20211120194711.9073-1-biju.das.jz@bp.renesas.com>
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

v1->v2:
 * Removed clk patch and dts pthes from this series
 * Removed devm_add_action_or_reset from probe.

Biju Das (2):
  dt-bindings: thermal: Document Renesas RZ/G2L TSU
  thermal/drivers: Add TSU driver for RZ/G2L

 .../bindings/thermal/rzg2l-thermal.yaml       |  76 ++++++
 drivers/thermal/Kconfig                       |   9 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/rzg2l_thermal.c               | 235 ++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
 create mode 100644 drivers/thermal/rzg2l_thermal.c

-- 
2.17.1

