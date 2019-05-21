Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0E24F9C
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfEUNES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 09:04:18 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59341 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 09:04:18 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 634A6100018;
        Tue, 21 May 2019 13:04:13 +0000 (UTC)
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
Subject: [PATCH v2 1/4] clk: mvebu: armada-37xx-periph: add PCIe gated clock
Date:   Tue, 21 May 2019 15:03:54 +0200
Message-Id: <20190521130357.20803-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190521130357.20803-1-miquel.raynal@bootlin.com>
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PCIe clock is a gated clock which has the same source as GbE0
(both IPs share a set of registers). This source clock is called
'gbe_core' in the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 4c20093a42fb..1e18c5a875bd 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -304,6 +304,7 @@ PERIPH_CLK_GATE_DIV(gbe_bm, 12, DIV_SEL1, 0, clk_table1);
 PERIPH_CLK_FULL_DD(sdio, 11, 14, DIV_SEL0, DIV_SEL0, 3, 6);
 PERIPH_CLK_FULL_DD(usb32_usb2_sys, 16, 16, DIV_SEL0, DIV_SEL0, 9, 12);
 PERIPH_CLK_FULL_DD(usb32_ss_sys, 17, 18, DIV_SEL0, DIV_SEL0, 15, 18);
+static PERIPH_GATE(pcie, 14);
 
 static struct clk_periph_data data_sb[] = {
 	REF_CLK_MUX_DD(gbe_50),
@@ -319,6 +320,7 @@ static struct clk_periph_data data_sb[] = {
 	REF_CLK_FULL_DD(sdio),
 	REF_CLK_FULL_DD(usb32_usb2_sys),
 	REF_CLK_FULL_DD(usb32_ss_sys),
+	REF_CLK_GATE(pcie, "gbe_core"),
 	{ },
 };
 
-- 
2.19.1

