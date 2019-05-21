Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3051D24F9A
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfEUNEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 09:04:14 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50285 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNEO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 09:04:14 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 86FB5100011;
        Tue, 21 May 2019 13:03:59 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/4] Prepare Armada 3700 PCIe suspend to RAM support
Date:   Tue, 21 May 2019 15:03:53 +0200
Message-Id: <20190521130357.20803-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

As part of an effort to bring suspend to RAM support to the Armada
3700 SoC (main target: ESPRESSObin board), there are small things to
do in the Armada 3700 peripherals clock driver:

* On this SoC, the PCIe controller gets fed by a gated clock in the
  south bridge. This clock is missing in the current driver, patch 1
  adds it.

* Because of a constraint in the PCI core, the resume function of a
  PCIe controller driver must be run at an early stage
  (->suspend/resume_noirq()), before the core tries to ->read/write()
  in the PCIe registers to do more configuration. Hence, the PCIe
  clock must be resumed before. This is enforced thanks to two
  changes:
  1/ Add device links to the clock framework. This enforce order in
     the PM core: the clocks are resumed before the consumers. Series
     has been posted, see [1].
  2/ Even with the above feature, the clock's resume() callback is
     called after the PCI controller's resume_noirq() callback. The
     only way to fix this is to change the "priority" of the clock
     suspend/resume callbacks. This is done in patch 2.

* The bindings are updated with the PCI clock in patch 4 while patch 3
  is just a typo correction in the same file.

If there is anything unclear please feel free to ask.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614527.html

Thanks,
Miquèl

Changes in v2:
==============
* Rebased on top of v5.2-rc1.
* Added Rob's R-by tags.
* No change on the "change suspend/resume time" patch as, despite my
  pings, I got no answer and IMHO the proposed approach is entirely
  valid.


Miquel Raynal (4):
  clk: mvebu: armada-37xx-periph: add PCIe gated clock
  clk: mvebu: armada-37xx-periph: change suspend/resume time
  dt-bindings: clk: armada3700: fix typo in SoC name
  dt-bindings: clk: armada3700: document the PCIe clock

 .../devicetree/bindings/clock/armada3700-periph-clock.txt   | 5 +++--
 drivers/clk/mvebu/armada-37xx-periph.c                      | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.19.1

