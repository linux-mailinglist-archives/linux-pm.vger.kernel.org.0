Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3B582F7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfF0Mwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 08:52:55 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45027 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfF0Mwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 08:52:55 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 99969E000E;
        Thu, 27 Jun 2019 12:52:52 +0000 (UTC)
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
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 4/4] dt-bindings: clk: armada3700: document the PCIe clock
Date:   Thu, 27 Jun 2019 14:52:45 +0200
Message-Id: <20190627125245.26788-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627125245.26788-1-miquel.raynal@bootlin.com>
References: <20190627125245.26788-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a reference to the missing PCIe clock managed by this IP. The
clock resides in the south bridge.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/armada3700-periph-clock.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
index 85972715e593..fbf58c443c04 100644
--- a/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
+++ b/Documentation/devicetree/bindings/clock/armada3700-periph-clock.txt
@@ -46,6 +46,7 @@ ID	Clock name	Description
 10	sdio		SDIO
 11	usb32-sub2-sys	USB 2 clock
 12	usb32-ss-sys	USB 3 clock
+13	pcie		PCIe controller
 
 Required properties:
 
-- 
2.19.1

