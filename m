Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7D2B4C48
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgKPRMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 12:12:19 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:52821 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgKPRMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 12:12:19 -0500
X-Greylist: delayed 2863 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 12:12:18 EST
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 96CFF100041;
        Mon, 16 Nov 2020 17:12:15 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>
Subject: [PATCH 1/5] dt-bindings: reset: ocelot: Add documentation for 'microchip,reset-switch-core' property
Date:   Mon, 16 Nov 2020 18:11:55 +0100
Message-Id: <20201116171159.1735315-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116171159.1735315-1-gregory.clement@bootlin.com>
References: <20201116171159.1735315-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lars Povlsen <lars.povlsen@microchip.com>

This documents the 'microchip,reset-switch-core' property in the
ocelot-reset driver.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
index 4d530d815484..20fff03753ad 100644
--- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
 Required Properties:
  - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"
 
+Optional properties:
+- microchip,reset-switch-core : Perform a switch core reset at the
+  time of driver load. This is may be used to initialize the switch
+  core to a known state (before other drivers are loaded).
+
 Example:
 	reset@1070008 {
 		compatible = "mscc,ocelot-chip-reset";
 		reg = <0x1070008 0x4>;
+		microchip,reset-switch-core;
 	};
 
-- 
2.29.2

