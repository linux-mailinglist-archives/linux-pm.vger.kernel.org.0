Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22F24F9F
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfEUNEV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 09:04:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58803 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 09:04:21 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7DEEF100012;
        Tue, 21 May 2019 13:04:16 +0000 (UTC)
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
Subject: [PATCH v2 2/4] clk: mvebu: armada-37xx-periph: change suspend/resume time
Date:   Tue, 21 May 2019 15:03:55 +0200
Message-Id: <20190521130357.20803-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190521130357.20803-1-miquel.raynal@bootlin.com>
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Armada 3700 PCIe IP relies on the PCIe clock managed by this
driver. For reasons related to the PCI core's organization when
suspending/resuming, PCI host controller drivers must reconfigure
their register at suspend_noirq()/resume_noirq() which happens after
suspend()/suspend_late() and before resume_early()/resume().

Device link support in the clock framework enforce that the clock
driver's resume() callback will be called before the PCIe
driver's. But, any resume_noirq() callback will be called before all
the registered resume() callbacks.

The solution to support PCIe resume operation is to change the
"priority" of this clock driver PM callbacks to "_noirq()".

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1e18c5a875bd..bee45e43a85f 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -715,8 +715,8 @@ static int __maybe_unused armada_3700_periph_clock_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops armada_3700_periph_clock_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(armada_3700_periph_clock_suspend,
-				armada_3700_periph_clock_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(armada_3700_periph_clock_suspend,
+				      armada_3700_periph_clock_resume)
 };
 
 static int armada_3700_periph_clock_probe(struct platform_device *pdev)
-- 
2.19.1

