Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FBD24FA4
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUNEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 09:04:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47937 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 09:04:25 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BB0FF100017;
        Tue, 21 May 2019 13:04:19 +0000 (UTC)
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
Subject: [PATCH v2 3/4] dt-bindings: clk: armada3700: fix typo in SoC name
Date:   Tue, 21 May 2019 15:03:56 +0200
Message-Id: <20190521130357.20803-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190521130357.20803-1-miquel.raynal@bootlin.com>
References: <20190521130357.20803-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This documentation is about Armada 3700 SoCs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/armada3700-periph-clock.txt     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
index 1e3370ba189f..85972715e593 100644
--- a/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
+++ b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
@@ -9,7 +9,7 @@ bridge.
 The peripheral clock consumer should specify the desired clock by
 having the clock ID in its "clocks" phandle cell.
 
-The following is a list of provided IDs for Armada 370 North bridge clocks:
+The following is a list of provided IDs for Armada 3700 North bridge clocks:
 ID	Clock name	Description
 -----------------------------------
 0	mmc		MMC controller
@@ -30,7 +30,7 @@ ID	Clock name	Description
 15	eip97		EIP 97
 16	cpu		CPU
 
-The following is a list of provided IDs for Armada 370 South bridge clocks:
+The following is a list of provided IDs for Armada 3700 South bridge clocks:
 ID	Clock name	Description
 -----------------------------------
 0	gbe-50		50 MHz parent clock for Gigabit Ethernet
-- 
2.19.1

